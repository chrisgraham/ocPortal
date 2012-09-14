<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.


 NOTE TO PROGRAMMERS:
   Do not edit this file. If you need to make changes, save your changed file to the appropriate *_custom folder
   **** If you ignore this advice, then your website upgrades (e.g. for bug fixes) will likely kill your changes ****

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		core_ocf
 */

class Hook_ocf_auth_aef
{

	/**
	 * Try and authenticate for our password compatibility scheme.
	 *
	 * @param  ?SHORT_TEXT	The member username (NULL: don't use this in the authentication - but look it up using the ID if needed)
	 * @param  ?MEMBER		The member id (NULL: use member name)
	 * @param  MD5				The md5-hashed password
	 * @param  string			The raw password
	 * @param  boolean		Whether this is a cookie login
	 * @param  array			Row of OCF account
	 * @return ?tempcode		Error message (NULL: none)
	 */
	function auth($username,$userid,$password_hashed,$password_raw,$cookie_login,$row)
	{
		if ($cookie_login)
		{
			if ($row['m_pass_hash_salted']!=$password_hashed)
			{
				return do_lang_tempcode('MEMBER_BAD_PASSWORD');
			}
		} else
		{
			if (md5($row['m_pass_salt'].trim($password_raw))!=$row['m_pass_hash_salted'])
			{
				return do_lang_tempcode('MEMBER_BAD_PASSWORD');
			}
		}

		return NULL;
	}

}


