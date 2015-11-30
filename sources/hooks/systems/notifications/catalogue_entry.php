<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		catalogues
 */

class Hook_Notification_catalogue_entry extends Hook_Notification
{
	/**
	 * Find whether a handled notification code supports categories.
	 * (Content types, for example, will define notifications on specific categories, not just in general. The categories are interpreted by the hook and may be complex. E.g. it might be like a regexp match, or like FORUM:3 or TOPIC:100)
	 *
	 * @param  ID_TEXT		Notification code
	 * @return boolean		Whether it does
	 */
	function supports_categories($notification_code)
	{
		return true;
	}

	/**
	 * Standard function to create the standardised category tree
	 *
	 * @param  ID_TEXT		Notification code
	 * @param  ?ID_TEXT		The ID of where we're looking under (NULL: N/A)
	 * @return array 			Tree structure
	 */
	function create_category_tree($notification_code,$id)
	{
		require_code('catalogues');

		$name=substr($notification_code,strlen('catalogue_entry__'));

		if (is_null($id))
		{
			$total=$GLOBALS['SITE_DB']->query_value_null_ok('catalogue_categories','COUNT(*)',array('c_name'=>$name));
			if ($total>300) return parent::create_category_tree($notification_code,$id); // Too many, so just allow removing UI
		}

		$pagelinks=get_catalogue_category_tree($name,is_null($id)?NULL:intval($id),NULL,NULL,1);
		$filtered=array();
		foreach ($pagelinks as $p)
		{
			if (strval($p['id'])!==$id) $filtered[]=$p;
		}
		return $filtered;
	}

	/**
	 * Find the initial setting that members have for a notification code (only applies to the member_could_potentially_enable members).
	 *
	 * @param  ID_TEXT		Notification code
	 * @param  ?SHORT_TEXT	The category within the notification code (NULL: none)
	 * @return integer		Initial setting
	 */
	function get_initial_setting($notification_code,$category=NULL)
	{
		return A_NA;
	}

	/**
	 * Get a list of all the notification codes this hook can handle.
	 * (Addons can define hooks that handle whole sets of codes, so hooks are written so they can take wide authority)
	 *
	 * @return array			List of codes (mapping between code names, and a pair: section and labelling for those codes)
	 */
	function list_handled_codes()
	{
		$list=array();
		$catalogues=$GLOBALS['SITE_DB']->query_select('catalogues',array('c_name','c_title'),NULL,'WHERE c_name NOT LIKE \'\_%\'');
		foreach ($catalogues as $catalogue)
		{
			$catalogue_name=$catalogue['c_name'];
			$nl=do_lang('NOTIFICATION_TYPE_catalogue_entry__'.$catalogue_name,NULL,NULL,NULL,NULL,false);
			if (is_null($nl))
			{
				$nl=do_lang('NOTIFICATION_TYPE_catalogue_entry',get_translated_text($catalogue['c_title']));
			}
			$list['catalogue_entry__'.$catalogue_name]=array(do_lang('menus:CONTENT'),$nl);
		}
		return $list;
	}

	/**
	 * Get a list of members who have enabled this notification (i.e. have permission to AND have chosen to or are defaulted to).
	 *
	 * @param  ID_TEXT		Notification code
	 * @param  ?SHORT_TEXT	The category within the notification code (NULL: none)
	 * @param  ?array			List of member IDs we are restricting to (NULL: no restriction). This effectively works as a intersection set operator against those who have enabled.
	 * @param  integer		Start position (for pagination)
	 * @param  integer		Maximum (for pagination)
	 * @return array			A pair: Map of members to their notification setting, and whether there may be more
	 */
	function list_members_who_have_enabled($notification_code,$category=NULL,$to_member_ids=NULL,$start=0,$max=300)
	{
		$members=$this->_all_members_who_have_enabled($notification_code,$category,$to_member_ids,$start,$max);
		$members=$this->_all_members_who_have_enabled_with_page_access($members,'catalogues',$notification_code,$category,$to_member_ids,$start,$max);
		$members=$this->_all_members_who_have_enabled_with_category_access($members,'catalogues_category',$notification_code,$category,$to_member_ids,$start,$max);

		return $members;
	}
}
