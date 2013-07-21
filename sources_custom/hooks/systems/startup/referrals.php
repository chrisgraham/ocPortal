<?php

class Hook_startup_referrals
{
	function run()
	{
		// Store referrer in cookie
		$by_url=get_param('keep_referrer','');
		if ($by_url!='')
		{
			require_code('users_active_actions');
			ocp_setcookie('referrer',$by_url);
		}
	}
}
