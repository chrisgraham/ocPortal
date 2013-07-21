<?php

class Hook_startup_referrals
{
	function run()
	{
		// Store referrer in cookie
		$by_url=get_param('keep_referrer','');
		if ($by_url!='')
		{
			$ini_file=parse_ini_file(get_custom_file_base().'/text_custom/referrals.txt',true);
			if ((!isset($ini_file['referrer_cookies'])) || ($ini_file['referrer_cookies']=='1'))
			{
				require_code('users_active_actions');
				ocp_setcookie('referrer',$by_url);
			}
		}
	}
}
