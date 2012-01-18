<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		ocf_forum
 */

class Hook_Notification_ocf_new_pt extends Hook_Notification
{
	/**
	 * Find a bitmask of settings (email, SMS, etc) a notification code supports for listening on.
	 *
	 * @param  ID_TEXT		Notification code
	 * @return integer		Allowed settings
	 */
	function allowed_settings($notification_code)
	{
		return A__ALL & ~A_INSTANT_PT;
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
		return A_INSTANT_EMAIL;
	}

	/**
	 * Find the setting that members have for a notification code if they have done some action triggering automatic setting (e.g. posted within a topic).
	 *
	 * @param  ID_TEXT		Notification code
	 * @param  ?SHORT_TEXT	The category within the notification code (NULL: none)
	 * @return integer		Automatic setting
	 */
	function get_default_auto_setting($notification_code,$category=NULL)
	{
		return A_INSTANT_EMAIL;
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
		$list['ocf_new_pt']=array(do_lang('MESSAGES'),do_lang('NOTIFICATION_TYPE_ocf_new_pt'));
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
		$members=$this->_all_members_who_have_enabled_with_sp($members,'use_pt',$notification_code,$category,$to_member_ids,$start,$max);
		$members=$this->_all_members_who_have_enabled_with_zone_access($members,'forum',$notification_code,$category,$to_member_ids,$start,$max);

		return $members;
	}
}
