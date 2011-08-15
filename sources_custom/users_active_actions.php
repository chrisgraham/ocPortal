<?php 

/**
 * Process a logout.
 */
function handle_active_logout()
{
	// Kill cookie
//	$expire=time()-300;
	$member_cookie_name=get_member_cookie();
	$colon_pos=strpos($member_cookie_name,':');
	if ($colon_pos!==false)
	{
		$base=substr($member_cookie_name,0,$colon_pos);
	} else
	{
		$real_member_cookie=get_member_cookie();
		$base=$real_member_cookie;
	}
	ocp_eatcookie($base);
	unset($_COOKIE[$base]);

	$compat=$GLOBALS['FORUM_DRIVER']->get_member_row_field(get_member(),'m_password_compat_scheme');
	if ($compat=='facebook')
	{
		$GLOBALS['FACEBOOK_LOGOUT']=true;
		@ob_end_clean(); echo ' '; flush(); // Force headers to be sent so it's not an HTTP header request so Facebook can do it's JS magic
	}
	$GLOBALS['MEMBER_CACHED']=$GLOBALS['FORUM_DRIVER']->get_guest_id();

	// Kill session
	$session=get_session_id();
	if ($session!=-1)
	{
		$GLOBALS['SITE_DB']->query('DELETE FROM '.get_table_prefix().'sessions WHERE the_session='.strval((integer)$session));
		require_code('users_inactive_occasionals');
		set_session_id(-1);

		global $SESSION_CACHE;
		unset($SESSION_CACHE[$session]);
		if (get_value('session_prudence')!=='1')
		{
			persistant_cache_set('SESSION_CACHE',$SESSION_CACHE);
		}
	}
}
