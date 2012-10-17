<?php

/*
This finds an ocPortal member's Facebook ID, in offline mode.

Use FB_CONNECT_UID to get the Facebook ID of the currently active user, via an active Facebook Connect session.
*/

class Hook_symbol_USER_FB_CONNECT
{
	function run($param)
	{
		require_code('facebook_connect');

		if (!array_key_exists(0,$param)) return '';

		$member_id=intval($param[0]);

		$value='';
		if ((get_forum_type()=='ocf') && ($GLOBALS['FORUM_DRIVER']->get_member_row_field($member_id,'m_password_compat_scheme')=='facebook'))
		{
			// Find Facebook ID via their member profile (we stashed it in here; authorisation stuff is never stored in DB, only on Facebook and user's JS)...

			$value=$GLOBALS['FORUM_DRIVER']->get_member_row_field($param[0],'m_pass_hash_salted');
		} else
		{
			// Okay, look to see if they have set up syndication permissions instead, which is the other way around: stores authorisation, but not Facebook ID...

			$token=get_long_value('facebook_oauth_token__'.strval($member_id));

			$appid=get_option('facebook_appid',true);
			if (is_null($appid)) return '';
			$appsecret=get_option('facebook_secret_code',true);
			if (is_null($appsecret)) return '';
			try
			{
				$facebook_connect=new ocpFacebook(array('appId'=>$appid,'secret'=>$appsecret));
				$facebook_connect->setAccessToken($token);
				$value=strval($facebook_connect->getUser());
				if ($value=='0') $value='';
			}
			catch (Exception $e)
			{
				$value='';
			}
		}
		return $value;
	}
}
