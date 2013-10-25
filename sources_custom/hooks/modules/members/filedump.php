<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		filedump
 */

class Hook_members_filedump
{

	/**
	 * Standard modular run function.
	 *
	 * @param  MEMBER		The ID of the member we are getting link hooks for
	 * @return array		List of tuples for results. Each tuple is: type,title,url
	 */
	function run($member_id)
	{
		if (!addon_installed('filedump')) return array();

		$zone=get_page_zone('filedump',false);
		if (is_null($zone)) return array();
		if (!has_zone_access(get_member(),$zone)) return array();

		require_lang('filedump');

		$path=$GLOBALS['FORUM_DRIVER']->get_username($member_id);

		return array(array('content',do_lang_tempcode('FILE_DUMP'),build_url(array('page'=>'filedump','type'=>'misc','place'=>'/'.$path.'/'),$zone)));
	}
}


