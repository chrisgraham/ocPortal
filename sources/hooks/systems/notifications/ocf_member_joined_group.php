<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		core_ocf
 */

class Hook_Notification_ocf_member_joined_group extends Hook_Notification
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
		$pagelinks=array();

		$map=array();
		if (!has_specific_permission(get_member(),'see_hidden_groups')) $map['g_hidden']=0;
		$types=$GLOBALS['FORUM_DB']->query_select('f_groups',array('id','g_name'),$map);
		foreach ($types as $type)
		{
			$pagelinks[]=array(
				'id'=>$type['id'],
				'title'=>get_translated_text($type['g_name'],$GLOBALS['FORUM_DB']),
			);
		}
		global $M_SORT_KEY;
		$M_SORT_KEY='title';
		usort($pagelinks,'multi_sort');

		return $pagelinks;
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
		$list['ocf_member_joined_group']=array(do_lang('GROUPS'),do_lang('NOTIFICATION_TYPE_ocf_member_joined_group'));
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
		list($members,$maybe_more)=$this->_all_members_who_have_enabled($notification_code,$category,$to_member_ids,$start,$max);
		list($members,$maybe_more)=$this->_all_members_who_have_enabled_with_page_access(array($members,$maybe_more),'groups',$notification_code,$category,$to_member_ids,$start,$max);

		if (is_numeric($category)) // Filter if the group is hidden
		{
			$hidden=$GLOBALS['FORUM_DB']->query_value('f_groups','g_hidden',array('id'=>intval($category)));

			if ($hidden==1)
			{
				$members_new=array();
				foreach ($members as $member_id=>$setting)
				{
					if (has_specific_permission($member_id,'see_hidden_groups'))
						$members_new[$member_id]=$setting;
				}
				$members=$members_new;
			}
		}

		return array($members,$maybe_more);
	}
}
