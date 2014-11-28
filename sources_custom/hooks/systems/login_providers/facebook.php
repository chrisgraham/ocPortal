<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		facebook_support
 */

class Hook_login_provider_facebook
{
	/**
	 * Standard login provider hook.
	 *
	 * @param  ?MEMBER		Member ID already detected as logged in (NULL: none). May be a guest ID.
	 * @return ?MEMBER		Member ID now detected as logged in (NULL: none). May be a guest ID.
	 */
	function try_login($member) // NB: if $member is set (but not Guest), then it will bind to that account
	{
		// Make sure we are installed/upgraded
		require_code('facebook_connect');
		facebook_install();

		// Facebook connect
		if ((get_forum_type()=='ocf') && (get_option('facebook_login')=='1'))
		{
			safe_ini_set('ocproducts.type_strictness','0');
			global $FACEBOOK_CONNECT;
			if (!is_null($FACEBOOK_CONNECT))
			{
				try
				{
					if ($FACEBOOK_CONNECT->getUser()!=0)
						$member=handle_facebook_connection_login($member);
				}
				catch (Exception $e)
				{
					// User will know what is wrong already (Facebook wil have said), so don't show on our end
				}
			}
			safe_ini_set('ocproducts.type_strictness','1');
		}
		return $member;
	}
}
