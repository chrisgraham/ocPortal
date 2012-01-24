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

	$referrer_member=$GLOBALS['FORUM_DB']->query_value_null_ok_full('SELECT id FROM '.$GLOBALS['FORUM_DB']->get_table_prefix().'f_members WHERE '.db_string_equal_to('m_username',$referrer).' OR '.db_string_equal_to('m_email_address',$referrer));
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

function assign_referral_awards($referree,$trigger)
{
	$ini_file=parse_ini_file(get_custom_file_base().'/data_custom/referrals.ini');

	$referree_username=$GLOBALS['FORUM_DRIVER']->get_username($referree);
	$referree_email=$GLOBALS['FORUM_DRIVER']->get_member_email_address($referree);
	if ($referree_email=='') return; // Weird situation! Somehow the member has no email address defined and hence we can't lookup the referral, can't normally happen

	$referrer=$GLOBALS['FORUM_DB']->query_value_null_ok('f_invites','i_inviter',array('i_taken'=>0,'i_email_address'=>$referree_email),'ORDER BY i_time');
	if (is_null($referrer)) // Was not actually a referral, member joined site on own accord
	{
		if ((isset($ini_file['notify_if_join_but_no_referral'])) && ($ini_file['notify_if_join_but_no_referral']=='1'))
		{
			dispatch_notification('referral_staff',NULL,do_lang('MAIL_REFERRALS__NONREFERRAL__TOSTAFF_SUBJECT',$referree_username),do_lang('MAIL_REFERRALS__NONREFERRAL__TOSTAFF_BODY',comcode_escape($referree_username)),NULL,NULL,A_FROM_SYSTEM_PRIVILEGED);
		}

		return;
	}
	$referrer_username=$GLOBALS['FORUM_DRIVER']->get_username($referrer);
	$referrer_email=$GLOBALS['FORUM_DRIVER']->get_member_email_address($referrer);

	require_lang('referrals');
	require_code('notifications');

	$report_url=find_script('referrer_report');

	$num_total=$GLOBALS['FORUM_DB']->query_value_null_ok('f_invites','COUNT(*)',array('i_inviter'=>$referrer,'i_taken'=>1),'ORDER BY i_time');

	if ((isset($ini_file['referrer_trigger__'.$trigger])) && ($ini_file['referrer_trigger__'.$trigger]=='1')) // Valid referral
	{
		$GLOBALS['FORUM_DB']->query_update('f_invites',array('i_taken'=>1),array('i_email_address'=>$referree_email),'',1);
		$num_total++;

		// Tell staff (referrer just completed a level)
		if (array_key_exists('level_'.strval($num_total),$ini_file))
		{
			$level_description=$ini_file['level_'.strval($num_total)];
			dispatch_notification('referral_staff',NULL,do_lang('MAIL_REFERRALS__QUALIFIED__TOSTAFF_AWARD_SUBJECT',$level_description,$referrer_username,$referree_username),do_lang('MAIL_REFERRALS__QUALIFIED__TOSTAFF_AWARD_BODY',comcode_escape($level_description),comcode_escape($referrer_username),array(comcode_escape(integer_format($num_total)),comcode_escape($referree_username),$report_url)),NULL,NULL,A_FROM_SYSTEM_PRIVILEGED);
		} else // Tell staff (referrer is between levels / no level hit yet)
		{
			dispatch_notification('referral_staff',NULL,do_lang('MAIL_REFERRALS__QUALIFIED__TOSTAFF_SUBJECT',$referrer_username,$referree_username),do_lang('MAIL_REFERRALS__QUALIFIED__TOSTAFF_BODY',comcode_escape($referrer_username),comcode_escape(integer_format($num_total)),array(comcode_escape($referree_username),$report_url)),NULL,NULL,$referrer);
		}

		// Tell referrer they got a referrer, but don't mention any awards explicitly regardless if achieved yet (because the staff will do this when they're ready with the award)
		dispatch_notification('referral',NULL,do_lang('MAIL_REFERRALS__QUALIFIED__TOREFERRER_SUBJECT',$referree_username),do_lang('MAIL_REFERRALS__QUALIFIED__TOREFERRER_BODY',comcode_escape($referrer_username),comcode_escape(integer_format($num_total)),array(comcode_escape($referree_username))),array($referrer),A_FROM_SYSTEM_PRIVILEGED);
	} else
	{
		if ($trigger=='join')
		{
			// Say if first step of referral happened (non-qualified referral), even if we've set not to award them for it
			dispatch_notification('referral_staff',NULL,do_lang('MAIL_REFERRALS__NONQUALIFIED__TOSTAFF_SUBJECT',$referrer_username,$referree_username),do_lang('MAIL_REFERRALS__NONQUALIFIED__TOSTAFF_BODY',comcode_escape($referrer_username),comcode_escape($referree_username),array($report_url)),NULL,NULL,$referrer);
			dispatch_notification('referral',NULL,do_lang('MAIL_REFERRALS__NONQUALIFIED__TOREFERRER_SUBJECT',$referree_username),do_lang('MAIL_REFERRALS__NONQUALIFIED__TOREFERRER_BODY',comcode_escape($referrer_username),comcode_escape($referree_username)),NULL,NULL,A_FROM_SYSTEM_PRIVILEGED);
		}
	}

	// Run any actioning code defined in hooks
	$hooks=find_all_hooks('systems','referrals');
	foreach (array_keys($hooks) as $hook)
	{
		require_code('hooks/systems/referrals/'.$hook);
		$ob=object_factory('Hook_referrals_'.$hook,true);
		if ($ob!==NULL)
			$ob->fire_referral($trigger,$referree,$num_total);
	}
}

function referrer_report_script()
{
	if (!has_zone_access(get_member(),'adminzone')) access_denied('ZONE_ACCESS','adminzone');

	require_lang('referrals');

	$data=array();
	$referrals=$GLOBALS['FORUM_DB']->query_select(
		'f_invites i LEFT JOIN '.$GLOBALS['FORUM_DB']->get_table_prefix().'f_members referrer ON referrer.id=i_inviter LEFT JOIN '.$GLOBALS['FORUM_DB']->get_table_prefix().'f_members referree ON referree.m_email_address=i_email_address',
		array(
			'i_time AS time',
			'referrer.m_username AS referrer',
			'referrer.m_email_address AS referrer_email',
			'referree.m_username AS referree',
			'referree.m_email_address AS referree_email',
			'i_taken AS qualified',
		),
		NULL,
		'ORDER BY i_time'
	);
	foreach ($referrals as $ref)
	{
		$data_row=array();
		$data_row[do_lang('DATE_TIME')]=get_timezoned_date($ref['time']);
		$data_row[do_lang('TYPE_REFERRER')]=$ref['referrer'];
		$data_row[do_lang('TYPE_REFERRER').' ('.do_lang('EMAIL_ADDRESS').')']=$ref['referrer_email'];
		$data_row[do_lang('REFERREE')]=$ref['referree'];
		$data_row[do_lang('REFERREE').' ('.do_lang('EMAIL_ADDRESS').')']=$ref['referree_email'];
		$data_row[do_lang('QUALIFIED_REFERRAL')]=do_lang(($ref['qualified']==1)?'YES':'NO');
		$data[]=$data_row;
	}

	require_code('files2');
	make_csv($data,get_site_name().' referrals.csv');
}
