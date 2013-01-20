<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2013

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		referrals
 */

class Hook_members_referrals
{

	/**
	 * Standard modular run function.
	 *
	 * @param  MEMBER		The ID of the member we are getting link hooks for
	 * @return array		List of tuples for results. Each tuple is: type,title,url
	 */
	function run($member_id)
	{
		if ((!has_zone_access(get_member(),'adminzone')) && ($member_id!==get_member()))
			return array();

		require_code('ocf_join');
		if (!referrer_is_qualified($member_id)) return array();

		require_lang('referrals');

		$keep=symbol_tempcode('KEEP');

		return
			array(
				array(
					'usage',
					do_lang_tempcode('REFERRALS'),
					find_script('referrer_report').'?member_id='.strval($member_id).$keep->evaluate()
				)
			);
	}

}


