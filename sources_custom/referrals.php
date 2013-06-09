<?php

function assign_referral_awards($referee,$trigger)
{
	$ini_file=parse_ini_file(get_custom_file_base().'/text_custom/referrals.txt',true);

	$referee_username=$GLOBALS['FORUM_DRIVER']->get_username($referee);
	$referee_email=$GLOBALS['FORUM_DRIVER']->get_member_email_address($referee);
	if ($referee_email=='') return; // Weird situation! Somehow the member has no email address defined and hence we can't lookup the referral, can't normally happen
	$one_trigger_already=!is_null($GLOBALS['FORUM_DB']->query_select_value_if_there('f_invites','i_inviter',array('i_taken'=>1,'i_email_address'=>$referee_email),'ORDER BY i_time'));

	require_lang('referrals');
	require_code('notifications');

	$referrer=$GLOBALS['FORUM_DB']->query_select_value_if_there('f_invites','i_inviter',array('i_email_address'=>$referee_email),'ORDER BY i_time');
	if (is_null($referrer)) // Was not actually a referral, member joined site on own accord
	{
		if ((isset($ini_file['global']['notify_if_join_but_no_referral'])) && ($ini_file['global']['notify_if_join_but_no_referral']=='1'))
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

	$num_total_qualified_by_referrer=$GLOBALS['FORUM_DB']->query_select_value_if_there('f_invites','COUNT(*)',array('i_inviter'=>$referrer,'i_taken'=>1),'ORDER BY i_time');
	$num_total_by_referrer=$GLOBALS['FORUM_DB']->query_select_value_if_there('f_invites','COUNT(*)',array('i_inviter'=>$referrer),'ORDER BY i_time');

	foreach ($ini_file as $ini_file_section_name=>$ini_file_section)
	{
		if ($ini_file_section_name!='global')
		{
			$qualified_trigger=_assign_referral_awards(
				$trigger,

				$ini_file_section_name,
				$ini_file_section,

				$referee,$referee_username,$referee_email,$one_trigger_already,
				$referrer,$referrer_username,$referrer_email,

				$num_total_qualified_by_referrer,$num_total_by_referrer
			);
			//if ($qualified_trigger) break; // Only do the first qualified scheme, not multiple schemes		ACTUALLY we will allow multiple; no actual harm
		}
	}
}

function _assign_referral_awards(
	$trigger,

	$scheme_name,
	$scheme,

	$referee,$referee_username,$referee_email,$one_trigger_already,
	$referrer,$referrer_username,$referrer_email,

	$num_total_qualified_by_referrer,$num_total_by_referrer
)
{
	$scheme_title=isset($scheme['title'])?$scheme['title']:$scheme_name;

	$report_url=find_script('referrer_report').'?scheme='.urlencode($scheme_name).'&csv=1';

	$referrer_is_qualified=referrer_is_qualified($scheme,$referrer);

	$notify_if_non_qualified=(isset($scheme['notify_if_non_qualified'])) && ($scheme['notify_if_non_qualified']=='1');
	$notify_staff_if_non_qualified=(!isset($scheme['notify_staff_if_non_qualified'])) || ($scheme['notify_staff_if_non_qualified']=='1');

	$qualified_trigger=(isset($scheme['referral_trigger__'.$trigger])) && ($scheme['referral_trigger__'.$trigger]=='1');
	if ($qualified_trigger) // Valid referral
	{
		$one_trigger_per_referee=(!isset($scheme['one_trigger_per_referee'])) || ($scheme['one_trigger_per_referee']=='1');

		if ((!$one_trigger_per_referee) || (!$one_trigger_already)) 
		{
			$GLOBALS['FORUM_DB']->query_update('f_invites',array('i_taken'=>1),array('i_email_address'=>$referee_email),'',1);
			$num_total_qualified_by_referrer++;
			$num_total_by_referrer++;

			// Tell staff (referrer just completed a level)
			if (array_key_exists('level_'.strval($num_total_qualified_by_referrer),$scheme))
			{
				$level_description=$scheme['level_'.strval($num_total_qualified_by_referrer)];
				if (($referrer_is_qualified) || ($notify_staff_if_non_qualified))
				{
					$subject_lang_string=$referrer_is_qualified?'MAIL_REFERRALS__QUALIFIEDREFERRER_QUALIFIEDREFERRAL__TOSTAFF_AWARD_SUBJECT':'MAIL_REFERRALS__NONQUALIFIEDREFERRER_QUALIFIEDREFERRAL__TOSTAFF_AWARD_SUBJECT';
					if (do_lang($subject_lang_string.'__'.$scheme_name,NULL,NULL,NULL,NULL,false)!==NULL)
						$subject_lang_string.='__'.$scheme_name;
					$subject=do_lang(
						$subject_lang_string,
						$level_description,
						$referrer_username,
						array(
							$referee_username,
							$scheme_title
						)
					);
					$body_lang_string=$referrer_is_qualified?'MAIL_REFERRALS__QUALIFIEDREFERRER_QUALIFIEDREFERRAL__TOSTAFF_AWARD_BODY':'MAIL_REFERRALS__NONQUALIFIEDREFERRER_QUALIFIEDREFERRAL__TOSTAFF_AWARD_BODY';
					if (do_lang($body_lang_string.'__'.$scheme_name,NULL,NULL,NULL,NULL,false)!==NULL)
						$body_lang_string.='__'.$scheme_name;
					$body=do_lang(
						$body_lang_string,
						comcode_escape($level_description),
						comcode_escape($referrer_username),
						array(
							comcode_escape(integer_format($num_total_qualified_by_referrer)),
							comcode_escape($referee_username),
							$report_url,
							comcode_escape(integer_format($num_total_by_referrer)),
							comcode_escape($scheme_title)
						)
					);
					dispatch_notification(
						'referral_staff',
						NULL,
						$subject,
						$body,
						NULL,
						A_FROM_SYSTEM_PRIVILEGED
					);
				}
			} else // Tell staff (referrer is between levels / no level hit yet)
			{
				if (($referrer_is_qualified) || ($notify_staff_if_non_qualified))
				{
					$subject_lang_string=$referrer_is_qualified?'MAIL_REFERRALS__QUALIFIEDREFERRER_QUALIFIEDREFERRAL__TOSTAFF_SUBJECT':'MAIL_REFERRALS__NONQUALIFIEDREFERRER_QUALIFIEDREFERRAL__TOSTAFF_SUBJECT';
					if (do_lang($subject_lang_string.'__'.$scheme_name,NULL,NULL,NULL,NULL,false)!==NULL)
						$subject_lang_string.='__'.$scheme_name;
					$subject=do_lang(
						$subject_lang_string,
						$referrer_username,
						$referee_username,
						array(
							$scheme_title
						)
					);
					$body_lang_string=$referrer_is_qualified?'MAIL_REFERRALS__QUALIFIEDREFERRER_QUALIFIEDREFERRAL__TOSTAFF_BODY':'MAIL_REFERRALS__NONQUALIFIEDREFERRER_QUALIFIEDREFERRAL__TOSTAFF_BODY';
					if (do_lang($body_lang_string.'__'.$scheme_name,NULL,NULL,NULL,NULL,false)!==NULL)
						$body_lang_string.='__'.$scheme_name;
					$body=do_lang(
						$body_lang_string,
						comcode_escape($referrer_username),
						comcode_escape(integer_format($num_total_qualified_by_referrer)),
						array(
							comcode_escape($referee_username),
							$report_url,
							comcode_escape(integer_format($num_total_by_referrer)),
							comcode_escape($scheme_title)
						)
					);
					dispatch_notification(
						'referral_staff',
						NULL,
						$subject,
						$body,
						NULL,
						$referrer
					);
				}
			}

			// Tell referrer they got a referrer, but don't mention any awards explicitly regardless if achieved yet (because the staff will do this when they're ready with the award)
			if (($referrer_is_qualified) || ($notify_if_non_qualified))
			{
				$subject_lang_string=$referrer_is_qualified?'MAIL_REFERRALS__QUALIFIEDREFERRER_QUALIFIEDREFERRAL__TOREFERRER_SUBJECT':'MAIL_REFERRALS__NONQUALIFIEDREFERRER_QUALIFIEDREFERRAL__TOREFERRER_SUBJECT';
				if (do_lang($subject_lang_string.'__'.$scheme_name,NULL,NULL,NULL,NULL,false)!==NULL)
					$subject_lang_string.='__'.$scheme_name;
				$subject=do_lang(
					$subject_lang_string,
					$referee_username,
					$scheme_title
				);
				$body_lang_string=$referrer_is_qualified?'MAIL_REFERRALS__QUALIFIEDREFERRER_QUALIFIEDREFERRAL__TOREFERRER_BODY':'MAIL_REFERRALS__NONQUALIFIEDREFERRER_QUALIFIEDREFERRAL__TOREFERRER_BODY';
				if (do_lang($body_lang_string.'__'.$scheme_name,NULL,NULL,NULL,NULL,false)!==NULL)
					$body_lang_string.='__'.$scheme_name;
				$body=do_lang(
					$body_lang_string,
					comcode_escape($referrer_username),
					comcode_escape(integer_format($num_total_qualified_by_referrer)),
					array(
						comcode_escape($referee_username),
						comcode_escape(integer_format($num_total_by_referrer)),
						comcode_escape($scheme_title)
					)
				);
				dispatch_notification(
					'referral',
					NULL,
					$subject,
					$body,
					array($referrer),
					A_FROM_SYSTEM_PRIVILEGED
				);
			}
		}
	} else
	{
		if ($trigger=='join') // Ready for FUTURE qualification
		{
			// Say if first step of referral happened (non-qualified referral), even if we've set not to award them for it
			if (($referrer_is_qualified) || ($notify_staff_if_non_qualified))
			{
				$subject_lang_string=$referrer_is_qualified?'MAIL_REFERRALS__QUALIFIEDREFERRER_NONQUALIFIEDREFERRAL__TOSTAFF_SUBJECT':'MAIL_REFERRALS__NONQUALIFIEDREFERRER_NONQUALIFIEDREFERRAL__TOSTAFF_SUBJECT';
				if (do_lang($subject_lang_string.'__'.$scheme_name,NULL,NULL,NULL,NULL,false)!==NULL)
					$subject_lang_string.='__'.$scheme_name;
				$subject=do_lang(
					$subject_lang_string,
					$referrer_username,
					$referee_username,
					array(
						$scheme_title
					)
				);
				$body_lang_string=$referrer_is_qualified?'MAIL_REFERRALS__QUALIFIEDREFERRER_NONQUALIFIEDREFERRAL__TOSTAFF_BODY':'MAIL_REFERRALS__NONQUALIFIEDREFERRER_NONQUALIFIEDREFERRAL__TOSTAFF_BODY';
				if (do_lang($body_lang_string.'__'.$scheme_name,NULL,NULL,NULL,NULL,false)!==NULL)
					$body_lang_string.='__'.$scheme_name;
				$body=do_lang(
					$body_lang_string,
					comcode_escape($referrer_username),
					comcode_escape($referee_username),
					array(
						$report_url,
						comcode_escape(integer_format($num_total_qualified_by_referrer)),
						comcode_escape(integer_format($num_total_by_referrer)),
						comcode_escape($scheme_title)
					)
				);
				dispatch_notification(
					'referral_staff',
					NULL,
					$subject,
					$body,
					NULL,
					A_FROM_SYSTEM_PRIVILEGED
				);
			}
			if (($referrer_is_qualified) || ($notify_if_non_qualified))
			{
				$subject_lang_string=$referrer_is_qualified?'MAIL_REFERRALS__QUALIFIEDREFERRER_NONQUALIFIEDREFERRAL__TOREFERRER_SUBJECT':'MAIL_REFERRALS__NONQUALIFIEDREFERRER_NONQUALIFIEDREFERRAL__TOREFERRER_SUBJECT';
				if (do_lang($subject_lang_string.'__'.$scheme_name,NULL,NULL,NULL,NULL,false)!==NULL)
					$subject_lang_string.='__'.$scheme_name;
				$subject=do_lang(
					$subject_lang_string,
					$referee_username,
					$scheme_title
				);
				$body_lang_string=$referrer_is_qualified?'MAIL_REFERRALS__QUALIFIEDREFERRER_NONQUALIFIEDREFERRAL__TOREFERRER_BODY':'MAIL_REFERRALS__NONQUALIFIEDREFERRER_NONQUALIFIEDREFERRAL__TOREFERRER_BODY';
				if (do_lang($body_lang_string.'__'.$scheme_name,NULL,NULL,NULL,NULL,false)!==NULL)
					$body_lang_string.='__'.$scheme_name;
				$body=do_lang(
					$body_lang_string,
					comcode_escape($referrer_username),
					comcode_escape($referee_username),
					array(
						comcode_escape(integer_format($num_total_qualified_by_referrer)),
						comcode_escape(integer_format($num_total_by_referrer)),
						comcode_escape($scheme_title)
					)
				);
				dispatch_notification(
					'referral',
					NULL,
					$subject,
					$body,
					array($referrer),
					A_FROM_SYSTEM_PRIVILEGED
				);
			}
		}
	}

	// Run any actioning code defined in hooks
	$hooks=find_all_hooks('systems','referrals');
	foreach (array_keys($hooks) as $hook)
	{
		require_code('hooks/systems/referrals/'.$hook);
		$ob=object_factory('Hook_referrals_'.$hook,true);
		if ($ob!==NULL)
			$ob->fire_referral($trigger,$referrer,$referrer_is_qualified,$referee,$qualified_trigger,$num_total_qualified_by_referrer,$num_total_by_referrer,$one_trigger_already);
	}

	return $qualified_trigger;
}

function referrer_is_qualified($scheme,$member_id)
{
	if (is_guest($member_id)) return false;

	if ((isset($scheme['referrer_qualified_for__all'])) && ($scheme['referrer_qualified_for__all']=='1'))
		return true;

	require_code('ocf_members');
	$primary_group=ocf_get_member_primary_group($member_id);

	$groups=$GLOBALS['FORUM_DRIVER']->get_members_groups($member_id);

	$positive=0;
	$negative=0;

	foreach ($groups as $group_id)
	{
		if ((isset($scheme['referrer_qualified_for__group_'.strval($group_id)])) && ($scheme['referrer_qualified_for__group_'.strval($group_id)]=='1'))
		{
			$positive++;
		} else
		{
			$negative++;
		}

		if ((isset($scheme['referrer_qualified_for__primary_group_'.strval($group_id)])) && ($scheme['referrer_qualified_for__primary_group_'.strval($group_id)]=='1'))
		{
			if ($group_id==$primary_group)
			{
				$positive++;
			} else
			{
				$negative++;
			}
		}
	}

	if (addon_installed('shopping'))
	{
		if ((isset($scheme['referrer_qualified_for__misc_purchase'])) && ($scheme['referrer_qualified_for__misc_purchase']=='1'))
		{
			if (!is_null($GLOBALS['SITE_DB']->query_value_if_there('SELECT id FROM '.get_table_prefix().'shopping_order WHERE c_member='.strval($member_id).' AND '.(db_string_equal_to('order_status','payment_received').' OR '.db_string_equal_to('order_status','dispatched')))))
			{
				$positive++;
			} else
			{
				$negative++;
			}
		}

		foreach (array_keys($scheme) as $key)
		{
			$matches=array();

			if (preg_match('#^referrer\_qualified\_for\_\_purchase\_(\d+)$#',$key,$matches)!=0)
			{
				if (!is_null($GLOBALS['SITE_DB']->query_value_if_there('SELECT o.id FROM '.get_table_prefix().'shopping_order o JOIN '.get_table_prefix().'shopping_order_details d ON o.id=d.order_id WHERE p_id='.strval(intval($matches[1])).' AND c_member='.strval($member_id).' AND '.(db_string_equal_to('order_status','payment_received').' OR '.db_string_equal_to('order_status','dispatched')))))
				{
					$positive++;
				} else
				{
					$negative++;
				}
			}
		}
	}

	$referrer_qualification_logic=isset($scheme['referrer_qualification_logic'])?$scheme['referrer_qualification_logic']:'OR';
	if ($referrer_qualification_logic=='OR')
	{
		return ($positive>0);
	} else
	{
		return ($negative==0);
	}

	// Should not get here
	return false;
}

function referrer_report_script($ret=false)
{
	$scheme_name=get_param('scheme','standard_scheme');
	$ini_file=parse_ini_file(get_custom_file_base().'/text_custom/referrals.txt',true);
	if (!isset($ini_file[$scheme_name])) warn_exit(do_lang_tempcode('MISSING_RESOURCE'));
	$scheme=$ini_file[$scheme_name];

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
	if (count($referrals)==0) warn_exit(do_lang_tempcode('NO_ENTRIES'));
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
			if (is_null($ref['referrer_id']))
			{
				$data_row[do_lang('QUALIFIED_REFERRER',$scheme_name)]=do_lang('NA');
			} else
			{
				$data_row[do_lang('QUALIFIED_REFERRER',$scheme_name)]=do_lang(referrer_is_qualified($scheme,$ref['referrer_id'])?'YES':'NO');
			}
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
		$data_row[do_lang('QUALIFIED_REFERRAL',$scheme_name)]=do_lang(($ref['qualified']==1)?'YES':'NO');
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

		$results_table=results_table(do_lang('REFERRALS'),$start,'start',$max,'max',$max_rows,$fields_title,$fields);

		if ($ret) return $results_table;

		$title=get_screen_title('REFERRALS');

		$out=new ocp_tempcode();
		$out->attach($title);
		$out->attach($results_table);

		$out=globalise($out,NULL,'',true);
		$out->evaluate_echo();
	}

	return NULL;
}
