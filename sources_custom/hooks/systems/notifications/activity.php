<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		core
 */

class Hook_Notification_activity extends Hook_Notification
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

		$notification_category=get_param('id',NULL);
		$done_in_url=is_null($notification_category);

		$types=addon_installed('chat')?$GLOBALS['SITE_DB']->query_select('chat_buddies',array('member_liked'),array('member_likes'=>get_member())):array(); // Only show options for friends to simplify
		$types2=$GLOBALS['SITE_DB']->query_select('notifications_enabled',array('l_code_category'),array('l_notification_code'=>substr($notification_code,0,80),'l_member_id'=>get_member())); // Already monitoring members who may not be friends
		foreach ($types2 as $type)
		{
			$types[]=array('member_liked'=>intval($type['l_code_category']));
		}
		foreach ($types as $type)
		{
			$username=$GLOBALS['FORUM_DRIVER']->get_username($type['member_liked']);

			if (!is_null($username))
			{
				$pagelinks[$type['member_liked']]=array(
					'id'=>strval($type['member_liked']),
					'title'=>$username,
				);
				if (!$done_in_url)
				{
					if (strval($type['member_liked'])==$notification_category) $done_in_url=true;
				}
			}
		}
		if (!$done_in_url)
		{
			$pagelinks[]=array(
				'id'=>$notification_category,
				'title'=>$GLOBALS['FORUM_DRIVER']->get_username(intval($notification_category)),
			);
		}
		global $M_SORT_KEY;
		$M_SORT_KEY='title';
		usort($pagelinks,'multi_sort');

		return array_values($pagelinks);
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
		$list['activity']=array(do_lang('ACTIVITY'),do_lang('NOTIFICATION_TYPE_activity'));
		return $list;
	}
}
