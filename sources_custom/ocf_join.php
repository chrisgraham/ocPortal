<?php

function init__ocf_join($in=NULL)
{
	// More referral fields in form
	$in=str_replace('list($fields,$_hidden)=ocf_get_member_fields(true,NULL,$groups);','list($fields,$_hidden)=ocf_get_member_fields(true,NULL,$groups); $fields->attach(get_referrer_field());',$in);

	// Better referral detection, and proper qualification management
	$in=str_replace("\$GLOBALS['FORUM_DB']->query_update('f_invites',array('i_taken'=>1),array('i_email_address'=>\$email_address,'i_taken'=>0),'',1);",'set_from_referrer_field();',$in);

	// Handle signup referrals
	$in=str_replace('return array($message);','assign_referral_awards($member_id,\'join\'); return array($message);',$in);

	return $in;
}

function get_referrer_field()
{
	require_lang('referrals');
	$by_url=get_param('keep_referrer','');
	if ($by_url!='')
	{
		if (is_numeric($by_url))
		{
			$by_url=$GLOBALS['FORUM_DRIVER']->get_username($by_url);
			if (is_null($by_url)) $by_url='';
		}
	}
	$field=form_input_username(do_lang_tempcode('TYPE_REFERRER'),do_lang_tempcode('DESCRIPTION_TYPE_REFERRER'),'referrer',$by_url,false,true);
	return $field;
}

function set_from_referrer_field()
{
	require_lang('referrals');

	$referrer=post_param('referrer','');
	if ($referrer=='') return; // NB: This doesn't mean failure, it may already have been set by the recommend module when the recommendation was *made*

	$referrer_member=$GLOBALS['FORUM_DB']->query_value_if_there('SELECT id FROM '.$GLOBALS['FORUM_DB']->get_table_prefix().'f_members WHERE '.db_string_equal_to('m_username',$referrer).' OR '.db_string_equal_to('m_email_address',$referrer));
	if (!is_null($referrer_member))
	{
		$GLOBALS['FORUM_DB']->query_delete('f_invites',array(
			'i_email_address'=>post_param('email_address'),
		),'',1); // Delete old invites for this email address
		$GLOBALS['FORUM_DB']->query_insert('f_invites',array(
			'i_inviter'=>$referrer_member,
			'i_email_address'=>post_param('email_address'),
			'i_time'=>time(),
			'i_taken'=>0
		));
	}
}

function assign_referral_awards($referee,$trigger)
{
	$ini_file=parse_ini_file(get_custom_file_base().'/text_custom/referrals.txt');

	$referee_username=$GLOBALS['FORUM_DRIVER']->get_username($referee);
	$referee_email=$GLOBALS['FORUM_DRIVER']->get_member_email_address($referee);
	if ($referee_email=='') return; // Weird situation! Somehow the member has no email address defined and hence we can't lookup the referral, can't normally happen

	require_lang('referrals');
	require_code('notifications');

	$referrer=$GLOBALS['FORUM_DB']->query_select_value_if_there('f_invites','i_inviter',array('i_taken'=>0,'i_email_address'=>$referee_email),'ORDER BY i_time');
	if (is_null($referrer)) // Was not actually a referral, member joined site on own accord
	{
		if ((isset($ini_file['notify_if_join_but_no_referral'])) && ($ini_file['notify_if_join_but_no_referral']=='1'))
		{
			dispatch_notification(
				'referral_staff',
				NULL,
				do_lang(
					'MAIL_REFERRALS__NONREFERRAL__TOSTAFF_SUBJECT',
					$referee_username
				),
				do_lang(
					'MAIL_REFERRALS__NONREFERRAL__TOSTAFF_BODY',
					comcode_escape($referee_username)
				),
				NULL,
				A_FROM_SYSTEM_PRIVILEGED
			);
		}

		return;
	}
	$referrer_username=$GLOBALS['FORUM_DRIVER']->get_username($referrer);
	if (is_null($referrer_username)) return; // Deleted member
	if (is_guest($referrer)) return;
	$referrer_email=$GLOBALS['FORUM_DRIVER']->get_member_email_address($referrer);

	$report_url=find_script('referrer_report').'?csv=1';

	$num_total_qualified_by_referrer=$GLOBALS['FORUM_DB']->query_select_value_if_there('f_invites','COUNT(*)',array('i_inviter'=>$referrer,'i_taken'=>1),'ORDER BY i_time');
	$num_total_by_referrer=$GLOBALS['FORUM_DB']->query_select_value_if_there('f_invites','COUNT(*)',array('i_inviter'=>$referrer),'ORDER BY i_time');

	$referrer_is_qualified=referrer_is_qualified($referrer);

	$qualified=(isset($ini_file['referral_trigger__'.$trigger])) && ($ini_file['referral_trigger__'.$trigger]=='1');
	if ($qualified) // Valid referral
	{
		$GLOBALS['FORUM_DB']->query_update('f_invites',array('i_taken'=>1),array('i_email_address'=>$referee_email),'',1);
		$num_total_qualified_by_referrer++;
		$num_total_by_referrer++;

		// Tell staff (referrer just completed a level)
		if (array_key_exists('level_'.strval($num_total_qualified_by_referrer),$ini_file))
		{
			$level_description=$ini_file['level_'.strval($num_total_qualified_by_referrer)];
			dispatch_notification(
				'referral_staff',
				NULL,
				do_lang(
					$referrer_is_qualified?'MAIL_REFERRALS__QUALIFIEDREFERRER_QUALIFIEDREFERRAL__TOSTAFF_AWARD_SUBJECT':'MAIL_REFERRALS__NONQUALIFIEDREFERRER_QUALIFIEDREFERRAL__TOSTAFF_AWARD_SUBJECT',
					$level_description,
					$referrer_username,
					$referee_username
				),
				do_lang(
					$referrer_is_qualified?'MAIL_REFERRALS__QUALIFIEDREFERRER_QUALIFIEDREFERRAL__TOSTAFF_AWARD_BODY':'MAIL_REFERRALS__NONQUALIFIEDREFERRER_QUALIFIEDREFERRAL__TOSTAFF_AWARD_BODY',
					comcode_escape($level_description),
					comcode_escape($referrer_username),
					array(
						comcode_escape(integer_format($num_total_qualified_by_referrer)),
						comcode_escape($referee_username),
						$report_url,
						comcode_escape(integer_format($num_total_by_referrer))
					)
				),
				NULL,
				A_FROM_SYSTEM_PRIVILEGED
			);
		} else // Tell staff (referrer is between levels / no level hit yet)
		{
			dispatch_notification(
				'referral_staff',
				NULL,
				do_lang(
					$referrer_is_qualified?'MAIL_REFERRALS__QUALIFIEDREFERRER_QUALIFIEDREFERRAL__TOSTAFF_SUBJECT':'MAIL_REFERRALS__NONQUALIFIEDREFERRER_QUALIFIEDREFERRAL__TOSTAFF_SUBJECT',
					$referrer_username,
					$referee_username
				),
				do_lang(
					$referrer_is_qualified?'MAIL_REFERRALS__QUALIFIEDREFERRER_QUALIFIEDREFERRAL__TOSTAFF_BODY':'MAIL_REFERRALS__NONQUALIFIEDREFERRER_QUALIFIEDREFERRAL__TOSTAFF_BODY',
					comcode_escape($referrer_username),
					comcode_escape(integer_format($num_total_qualified_by_referrer)),
					array(
						comcode_escape($referee_username),
						$report_url,
						comcode_escape(integer_format($num_total_by_referrer))
					)
				),
				NULL,
				$referrer
			);
		}

		// Tell referrer they got a referrer, but don't mention any awards explicitly regardless if achieved yet (because the staff will do this when they're ready with the award)
		dispatch_notification(
			'referral',
			NULL,
			do_lang(
				$referrer_is_qualified?'MAIL_REFERRALS__QUALIFIEDREFERRER_QUALIFIEDREFERRAL__TOREFERRER_SUBJECT':'MAIL_REFERRALS__NONQUALIFIEDREFERRER_QUALIFIEDREFERRAL__TOREFERRER_SUBJECT',
				$referee_username
			),
			do_lang(
				$referrer_is_qualified?'MAIL_REFERRALS__QUALIFIEDREFERRER_QUALIFIEDREFERRAL__TOREFERRER_BODY':'MAIL_REFERRALS__NONQUALIFIEDREFERRER_QUALIFIEDREFERRAL__TOREFERRER_BODY',
				comcode_escape($referrer_username),
				comcode_escape(integer_format($num_total_qualified_by_referrer)),
				array(
					comcode_escape($referee_username),
					comcode_escape(integer_format($num_total_by_referrer))
				)
			),
			array($referrer),
			A_FROM_SYSTEM_PRIVILEGED
		);
	} else
	{
		if ($trigger=='join')
		{
			// Say if first step of referral happened (non-qualified referral), even if we've set not to award them for it
			dispatch_notification(
				'referral_staff',
				NULL,
				do_lang(
					$referrer_is_qualified?'MAIL_REFERRALS__QUALIFIEDREFERRER_NONQUALIFIEDREFERRAL__TOSTAFF_SUBJECT':'MAIL_REFERRALS__NONQUALIFIEDREFERRER_NONQUALIFIEDREFERRAL__TOSTAFF_SUBJECT',
					$referrer_username,
					$referee_username
				),
				do_lang(
					$referrer_is_qualified?'MAIL_REFERRALS__QUALIFIEDREFERRER_NONQUALIFIEDREFERRAL__TOSTAFF_BODY':'MAIL_REFERRALS__NONQUALIFIEDREFERRER_NONQUALIFIEDREFERRAL__TOSTAFF_BODY',
					comcode_escape($referrer_username),
					comcode_escape($referee_username),
					array(
						$report_url,
						comcode_escape(integer_format($num_total_qualified_by_referrer)),
						comcode_escape(integer_format($num_total_by_referrer))
					)
				),
				NULL,
				A_FROM_SYSTEM_PRIVILEGED
			);
			dispatch_notification(
				'referral',
				NULL,
				do_lang(
					$referrer_is_qualified?'MAIL_REFERRALS__QUALIFIEDREFERRER_NONQUALIFIEDREFERRAL__TOREFERRER_SUBJECT':'MAIL_REFERRALS__NONQUALIFIEDREFERRER_NONQUALIFIEDREFERRAL__TOREFERRER_SUBJECT',
					$referee_username
				),
				do_lang(
					$referrer_is_qualified?'MAIL_REFERRALS__QUALIFIEDREFERRER_NONQUALIFIEDREFERRAL__TOREFERRER_BODY':'MAIL_REFERRALS__NONQUALIFIEDREFERRER_NONQUALIFIEDREFERRAL__TOREFERRER_BODY',
					comcode_escape($referrer_username),
					comcode_escape($referee_username),
					array(
						comcode_escape(integer_format($num_total_qualified_by_referrer)),
						comcode_escape(integer_format($num_total_by_referrer))
					)
				),
				array($referrer),
				A_FROM_SYSTEM_PRIVILEGED
			);
		}
	}

	// Run any actioning code defined in hooks
	$hooks=find_all_hooks('systems','referrals');
	foreach (array_keys($hooks) as $hook)
	{
		require_code('hooks/systems/referrals/'.$hook);
		$ob=object_factory('Hook_referrals_'.$hook,true);
		if ($ob!==NULL)
			$ob->fire_referral($trigger,$referrer,$referrer_is_qualified,$referee,$qualified,$num_total_qualified_by_referrer,$num_total_by_referrer);
	}
}

function referrer_is_qualified($member_id)
{
	if (is_guest($member_id)) return false;

	$ini_file=parse_ini_file(get_custom_file_base().'/text_custom/referrals.txt');

	if ((isset($ini_file['referrer_qualified_for__all'])) && ($ini_file['referrer_qualified_for__all']=='1'))
		return true;

	$groups=$GLOBALS['FORUM_DRIVER']->get_members_groups($member_id);

	foreach ($groups as $group_id)
	{
		if ((isset($ini_file['referrer_qualified_for__group_'.strval($group_id)])) && ($ini_file['referrer_qualified_for__group_'.strval($group_id)]=='1'))
			return true;
	}

	if (addon_installed('shopping'))
	{
		if ((isset($ini_file['referrer_qualified_for__misc_purchase'])) && ($ini_file['referrer_qualified_for__misc_purchase']=='1'))
		{
			if (!is_null($GLOBALS['SITE_DB']->query_value_if_there('SELECT id FROM '.get_table_prefix().'shopping_order WHERE c_member='.strval($member_id).' AND '.(db_string_equal_to('order_status','payment_received').' OR '.db_string_equal_to('order_status','dispatched')))))
				return true;
		}
	}

	foreach (array_keys($ini_file) as $key)
	{
		$matches=array();

		if (addon_installed('shopping'))
		{
			if (preg_match('#^referrer\_qualified\_for\_\_purchase\_(\d+)$#',$key,$matches)!=0)
			{
				if (!is_null($GLOBALS['SITE_DB']->query_value_if_there('SELECT o.id FROM '.get_table_prefix().'shopping_order o JOIN '.get_table_prefix().'shopping_order_details d ON o.id=d.order_id WHERE p_id='.strval(intval($matches[1])).' AND c_member='.strval($member_id).' AND '.(db_string_equal_to('order_status','payment_received').' OR '.db_string_equal_to('order_status','dispatched')))))
					return true;
			}
		}
	}

	return false;
}

function referrer_report_script($ret=false)
{
	$member_id=get_param_integer('member_id',NULL);
	if ((!has_zone_access(get_member(),'adminzone')) && ($member_id!==get_member()))
		access_denied('ZONE_ACCESS','adminzone');

	require_lang('referrals');
	$csv=(get_param_integer('csv',0)==1);

	$where=db_string_not_equal_to('i_email_address','').' AND i_inviter<>'.strval($GLOBALS['FORUM_DRIVER']->get_guest_id());
	if ($member_id!==NULL)
	{
		$where.=' AND referrer.id='.strval($member_id);
	}

	$max=get_param_integer('max',$csv?10000:30);
	$start=get_param_integer('start',0);

	$data=array();
	$table='f_invites i LEFT JOIN '.$GLOBALS['FORUM_DB']->get_table_prefix().'f_members referrer ON referrer.id=i_inviter LEFT JOIN '.$GLOBALS['FORUM_DB']->get_table_prefix().'f_members referee ON referee.m_email_address=i_email_address';
	$referrals=$GLOBALS['FORUM_DB']->query(
		'SELECT i_time AS time,referrer.id AS referrer_id,referrer.m_username AS referrer,referrer.m_email_address AS referrer_email,referee.id AS referee_id,referee.m_username AS referee,referee.m_email_address AS referee_email,i_taken AS qualified
		FROM '.
		$GLOBALS['FORUM_DB']->get_table_prefix().$table.
		' WHERE '.
		$where.
		' ORDER BY i_time DESC',
		$max,
		$start
	);
	$max_rows=$GLOBALS['FORUM_DB']->query_value_if_there('SELECT COUNT(*) FROM '.$GLOBALS['FORUM_DB']->get_table_prefix().$table.' WHERE '.$where);
	if (count($referrals)==0) inform_exit(do_lang_tempcode('NO_ENTRIES'));
	foreach ($referrals as $ref)
	{
		$data_row=array();
		$data_row[do_lang('DATE_TIME')]=get_timezoned_date($ref['time'],true,true,false,true);
		if (is_null($member_id))
		{
			if ($csv)
			{
				$deleted=true;
				$data_row[do_lang('TYPE_REFERRER')]=is_null($ref['referrer'])?do_lang($deleted?'REFEREE_DELETED':'REFEREE_NOT_SIGNED_UP'):$ref['referrer'];
			} else
			{
				$data_row[do_lang('TYPE_REFERRER')]=is_null($ref['referrer_id'])?'':strval($ref['referrer_id']);
			}
			$data_row[do_lang('TYPE_REFERRER').' ('.do_lang('EMAIL_ADDRESS').')']=$ref['referrer_email'];
			$data_row[do_lang('QUALIFIED_REFERRER')]=do_lang(referrer_is_qualified($ref['referrer_id'])?'YES':'NO');
		}

		$deleted=false;
		if (is_null($ref['referee']))
		{
			$deleted=($ref['qualified']==1);//!is_null($GLOBALS['SITE_DB']->query_select_value_if_there('adminlogs','id',array('the_type'=>'DELETE_MEMBER','param_b'=>TODO Unfortunately we can't tell)));
		}
		if ($csv)
		{
			$data_row[do_lang('REFEREE')]=is_null($ref['referee'])?do_lang($deleted?'REFEREE_DELETED':'REFEREE_NOT_SIGNED_UP'):$ref['referee'];
		} else
		{
			$data_row[do_lang('REFEREE')]=is_null($ref['referee_id'])?'':strval($ref['referee_id']);
		}
		$data_row[do_lang('REFEREE').' ('.do_lang('EMAIL_ADDRESS').')']=is_null($ref['referee_email'])?'':$ref['referee_email'];
		$data_row[do_lang('QUALIFIED_REFERRAL')]=do_lang(($ref['qualified']==1)?'YES':'NO');
		$data[]=$data_row;
	}

	if ($csv)
	{
		require_code('files2');
		make_csv($data,(is_null($member_id)?get_site_name():$GLOBALS['FORUM_DRIVER']->get_username($member_id)).' referrals.csv');
	} else
	{
		require_code('templates_results_table');

		$fields_title=new ocp_tempcode();
		$fields=new ocp_tempcode();
		foreach ($data as $i=>$data_row)
		{
			if ($i==0)
			{
				$fields_title->attach(results_field_title(array_keys($data_row)));
			}
			foreach ($data_row as $key=>$val)
			{
				if (($key==do_lang('REFEREE')) || ($key==do_lang('TYPE_REFERRER')))
				{
					if ($val=='')
					{
						$val=do_lang('UNKNOWN');
					} else
					{
						$val=$GLOBALS['FORUM_DRIVER']->member_profile_hyperlink($val,true);
					}
				}
				$data_row[$key]=escape_html($val);
			}
			$fields->attach(results_entry($data_row));
		}

		$table=results_table(do_lang('REFERRALS'),$start,'start',$max,'max',$max_rows,$fields_title,$fields);

		if ($ret) return $table;

		$title=get_screen_title('REFERRALS');

		$out=new ocp_tempcode();
		$out->attach($title);
		$out->attach($table);

		$out=globalise($out,NULL,'',true);
		$out->evaluate_echo();
	}

	return NULL;
}
