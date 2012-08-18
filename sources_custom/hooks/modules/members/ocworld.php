<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		ocworld
 */

class Hook_members_ocworld
{

	/**
	 * Standard modular run function.
	 *
	 * @param  MEMBER		The ID of the member we are getting link hooks for
	 * @return array		List of tuples for results. Each tuple is: type,title,url
	 */
	function run($member_id)
	{
		if (!addon_installed('ocworld')) return array();

		$zone=get_page_zone('ocworld',false);
		if (is_null($zone)) return array();
		if (!has_zone_access(get_member(),$zone)) return array();

		$id=$GLOBALS['SITE_DB']->query_select_value_if_there('w_members','id',array('id'=>$member_id),'',true);
		if (!is_null($id))
		{
			require_lang('ocworld');
			return array(array('usage',do_lang_tempcode('OCWORLD'),build_url(array('page'=>'ocworld','type'=>'inventory','user'=>$member_id),get_page_zone('ocworld'))));
		}
		return array();
	}

}


