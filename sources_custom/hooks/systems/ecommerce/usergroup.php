<?php

function init__hooks__systems__ecommerce__usergroup($in=NULL)
{
	if (is_null($in)) return $in; // HipHop PHP can't do code rewrites, but will call init functions if there is none in the original. Do nothing.
	
	return str_replace('ocf_add_member_to_group($member_id,$new_group);','ocf_add_member_to_group($member_id,$new_group); handle_sub_referrals($to_email);',$in);
}

function handle_sub_referrals($to_email)
{
	$inviter=$GLOBALS['FORUM_DB']->query_value_null_ok('f_invites','i_inviter',array('i_email_address'=>$to_email),'ORDER BY i_time');
	if (!is_null($inviter))
	{
		require_lang('signup_refer');
		
		$GLOBALS['FORUM_DB']->query_update('f_invites',array('i_taken'=>1),array('i_email_address'=>$to_email),'',1);
		
		$num_total=$GLOBALS['FORUM_DB']->query_value_null_ok('f_invites','COUNT(*)',array('i_inviter'=>$inviter),'ORDER BY i_time');
		
		$username=$GLOBALS['FORUM_DRIVER']->get_username($inviter);
		
		require_code('notifications');

		$ini_file=parse_ini_file(get_custom_file_base().'/data_custom/signup_refer.ini');
		if (array_key_exists('referral_'.strval($num_total),$ini_file))
		{
			$level=$ini_file['referral_'.strval($num_total)];
			dispatch_notification('referral_staff',NULL,do_lang('MAIL_SIGNUP_REFER__TOSTAFF_SUBJECT',$level),do_lang('MAIL_SIGNUP_REFER__TOSTAFF_BODY',$level,$username,number_format($num_total)),NULL,NULL,A_FROM_SYSTEM_PRIVILEGED);
		}

		dispatch_notification('referral',NULL,do_lang('MAIL_SIGNUP_REFER__TOREFERER_SUBJECT'),do_lang('MAIL_SIGNUP_REFER__TOREFERER_BODY',$username,number_format($num_total)),array($inviter),A_FROM_SYSTEM_PRIVILEGED);
	}
}
