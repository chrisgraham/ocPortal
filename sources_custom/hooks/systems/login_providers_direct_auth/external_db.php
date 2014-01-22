<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		external_db_login
 */

class Hook_login_providers_direct_auth_external_db
{
	/**
	 * Find if the given member ID and password is valid. If username is NULL, then the member ID is used instead.
	 * All authorisation, cookies, and form-logins, are passed through this function.
	 * Some forums do cookie logins differently, so a Boolean is passed in to indicate whether it is a cookie login.
	 *
	 * @param  object			Link to the real forum driver
	 * @param  ?SHORT_TEXT	The member username (NULL: don't use this in the authentication - but look it up using the ID if needed)
	 * @param  ?MEMBER		The member ID (NULL: use member name)
	 * @param  MD5				The md5-hashed password
	 * @param  string			The raw password
	 * @param  boolean		Whether this is a cookie login, determines how the hashed password is treated for the value passed in
	 * @return ?array			A map of 'id' and 'error'. If 'id' is NULL, an error occurred and 'error' is set (NULL: no action by this hook)
	 */
	function try_login($username,$userid,$password_hashed,$password_raw,$cookie_login=false)
	{
		require_code('external_db');

		if ($cookie_login || $password_raw=='') return NULL;

		$db=external_db();

		$table=get_long_value('external_db_login__table');
		$username_field=get_long_value('external_db_login__username_field');
		$password_field=get_long_value('external_db_login__password_field');
		$email_address_field=get_long_value('external_db_login__email_address_field');

		// Handle active login
		$query='SELECT * FROM '.$table.' WHERE ('.$db->static_ob->db_string_equal_to($username_field,$username);
		if (get_option('one_per_email_address')=='1')
			$query.=' OR '.$db->static_ob->db_string_equal_to($email_address_field,$username);
		$query.=')';
		$query.=' AND '.$db->static_ob->db_string_equal_to($password_field,$password_raw);
		$records=$db->query($query);
		if (isset($records[0]))
		{
			// Create new member
			return array('id'=>external_db_user_add($records[0]));
		}

		return NULL;
	}
}
