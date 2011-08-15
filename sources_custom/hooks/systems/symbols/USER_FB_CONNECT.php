<?php

class Hook_symbol_USER_FB_CONNECT
{
	function run($param)
	{
		require_code('facebook_connect');

		$value='';
		if ((get_forum_type()=='ocf') && (array_key_exists(0,$param)) && ($GLOBALS['FORUM_DRIVER']->get_member_row_field($param[0],'m_password_compat_scheme')=='facebook'))
		{
			$value=$GLOBALS['FORUM_DRIVER']->get_member_row_field($param[0],'m_pass_hash_salted');
		}
		return $value;
	}
}
