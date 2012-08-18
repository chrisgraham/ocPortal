<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		classifieds
 */

class Hook_members_classifieds
{

	/**
	 * Standard modular run function.
	 *
	 * @param  MEMBER		The ID of the member we are getting link hooks for
	 * @return array		List of tuples for results. Each tuple is: type,title,url
	 */
	function run($member_id)
	{
		if (!has_actual_page_access(get_member(),'classifieds',get_module_zone('classifieds'))) return array();

		require_lang('classifieds');

		$result=array();

		if (($member_id==get_member()) || (has_privilege(get_member(),'assume_any_member')))
			$result[]=array('content',do_lang('CLASSIFIED_ADVERTS'),build_url(array('page'=>'classifieds','type'=>'adverts','member_id'=>$member_id),get_module_zone('classifieds')));

		return $result;
	}

}

