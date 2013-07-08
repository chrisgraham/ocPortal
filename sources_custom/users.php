<?php

function init__users()
{
	require_code('facebook_connect');
}

function unused_other_func()
{
	// Just works as a flag that this isn't a "pure" file and hence to run the original's init function
}

/**
 * Find whether the current member is logged in via httpauth. For Facebook/OpenID we put in a bit of extra code to notify that the session must also be auto-marked as confirmed (which is why the function is called in some cases).
 *
 * @return boolean		Whether the current member is logged in via httpauth
 */
function is_httpauth_login()
{
	if (get_forum_type()!='ocf') return false;
	if (is_guest()) return false;

	$ret=non_overrided__is_httpauth_login();

	$compat=$GLOBALS['FORUM_DRIVER']->get_member_row_field(get_member(),'m_password_compat_scheme');
	if (($compat=='facebook') || ($compat=='openid'))
	{
		global $SESSION_CONFIRMED;
		$SESSION_CONFIRMED=1;
	}

	return $ret;
}
