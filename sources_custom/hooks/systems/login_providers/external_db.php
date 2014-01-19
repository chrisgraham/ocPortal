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

class Hook_login_provider_external_db
{
	/**
	 * Standard login provider hook.
	 *
	 * @param  ?MEMBER		Member ID already detected as logged in (NULL: none). May be a guest ID.
	 * @return ?MEMBER		Member ID now detected as logged in (NULL: none). May be a guest ID.
	 */
	function try_login($member)
	{
		if ((is_null($member)) || (is_guest($member)))
		{
			require_code('external_db');

			$record=external_db_user_from_session();

			if (is_null($record)) return $member;

			// Existing ocP user?
			$username_field=get_long_value('external_db_login__username_field');
			$member=mixed();
			if (get_option('one_per_email_address')=='1')
				$member=$GLOBALS['FORUM_DRIVER']->get_member_from_email_address($record[$email_address_field]);
			if (is_null($member))
				$member=$GLOBALS['FORUM_DRIVER']->get_member_from_username($record[$username_field]);
			if (!is_null($member))
			{
				external_db_user_sync($record);

				// Return existing user
				return $member;
			}

			// Create new user
			return external_db_user_add($record);
		}

		return $member;
	}
}
