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

class Hook_Notification_ocf_topic extends Hook_Notification
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
		require_code('ocf_forums2');

		$notification_category=get_param('id',NULL);
		$done_in_url=is_null($notification_category);

		$total=$GLOBALS['FORUM_DB']->query_value_null_ok('f_forums','COUNT(*)');
		if ($total>300) return parent::create_category_tree($notification_code,$id); // Too many, so just allow removing UI

		if (!is_null($id))
		{
			if (substr($id,0,6)!='forum:') warn_exit(do_lang_tempcode('INTERNAL_ERROR'));
			$id=substr($id,6);
		}

		$_pagelinks=ocf_get_forum_tree_secure(NULL,is_null($id)?NULL:intval($id),false,NULL,'',NULL,NULL,false,1);

		$pagelinks=array();
		foreach ($_pagelinks as $p)
		{
			$p['id']='forum:'.strval($p['id']);
			$p['title']=do_lang('A_FORUM',$p['title']);
			$pagelinks[]=$p;

			if (!$done_in_url)
			{
				if ('forum:'.$p['id']==$notification_category) $done_in_url=true;
			}
		}

		if (is_null($id)) // On root level add monitored topics too
		{
			$max_topic_rows=max(0,200-$total);
			$types2=$GLOBALS['SITE_DB']->query_select('notifications_enabled',array('l_code_category'),array('l_notification_code'=>'ocf_topic','l_member_id'=>get_member()),'ORDER BY id DESC',$max_topic_rows/*reasonable limit*/);
			if (count($types2)==$max_topic_rows) $types2=array(); // Too many to consider
			foreach ($types2 as $type)
			{
				if (is_numeric($type['l_code_category']))
				{
					$title=$GLOBALS['FORUM_DB']->query_value_null_ok('f_topics','t_cache_first_title',array('id'=>intval($type['l_code_category'])));
					if (!is_null($title))
					{
						$pagelinks[]=array(
							'id'=>$type['l_code_category'],
							'title'=>do_lang('A_TOPIC',$title),
						);

						if (!$done_in_url)
						{
							if ($type['l_code_category']==$notification_category) $done_in_url=true;
						}
					}
				}
			}
		}

		if ((!$done_in_url) && (is_numeric($notification_category)))
		{
			$title=$GLOBALS['FORUM_DB']->query_value_null_ok('f_topics','t_cache_first_title',array('id'=>intval($notification_category)));

			$pagelinks[]=array(
				'id'=>$notification_category,
				'title'=>do_lang('A_TOPIC',$title),
			);
		}

		return $pagelinks;
	}

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
		return A_NA;
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
		$list['ocf_topic']=array(do_lang('menus:CONTENT'),do_lang('NOTIFICATION_TYPE_ocf_topic'));
		return $list;
	}

	/**
	 * Find whether someone has permisson to view any notifications (yes) and possibly if they actually are.
	 *
	 * @param  ?ID_TEXT		Notification code (NULL: don't check if they are)
	 * @param  ?SHORT_TEXT	The category within the notification code (NULL: none)
	 * @param  MEMBER			Member to check against
	 * @return boolean		Whether they do
	 */
	function _is_member($only_if_enabled_on__notification_code,$only_if_enabled_on__category,$member_id)
	{
		if (is_null($only_if_enabled_on__notification_code)) return true;

		if (is_numeric($only_if_enabled_on__category)) // Also merge in people monitoring forum
		{
			$forum_details=$GLOBALS['FORUM_DB']->query_select('f_topics',array('t_forum_id','t_pt_from','t_pt_to'),array('id'=>intval($only_if_enabled_on__category)));
			$forum_id=$forum_details[0]['t_forum_id'];

			if (is_null($forum_id))
			{
				require_code('ocf_topics');
				if (!(($forum_details[0]['t_pt_from']==$member_id) || ($forum_details[0]['t_pt_to']==$member_id) || (ocf_has_special_pt_access(intval($only_if_enabled_on__category),$member_id)) || (!has_specific_permission($member_id,'view_other_pt'))))
					return false;
			}
		}

		return notifications_enabled($only_if_enabled_on__notification_code,$only_if_enabled_on__category,$member_id);
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
		if ((!is_numeric($category)) && (!is_null($category))) warn_exit(do_lang_tempcode('INTERNAL_ERROR')); // We should never be accessing as forum:<id>, that is used only behind the scenes

		list($members,$maybe_more)=$this->_all_members_who_have_enabled($notification_code,$category,$to_member_ids,$start,$max);

		if (is_numeric($category)) // This is a topic. Also merge in people monitoring forum
		{
			$forum_details=$GLOBALS['FORUM_DB']->query_select('f_topics',array('t_forum_id','t_pt_from','t_pt_to'),array('id'=>intval($category)));
			if (!array_key_exists(0,$forum_details)) return array(array(),false); // Topic deleted already?
			$forum_id=$forum_details[0]['t_forum_id'];

			if (!is_null($forum_id)) // Forum
			{
				list($members2,$maybe_more2)=$this->_all_members_who_have_enabled($notification_code,'forum:'.strval($forum_id),$to_member_ids,$start,$max);
				$members+=$members2;
				$maybe_more=$maybe_more || $maybe_more2;
			} else // Private topic, scan for participation against those already monitoring, for retroactive security (maybe someone lost access)
			{
				require_code('ocf_topics');
				$members_new=$members;
				foreach ($members as $member_id=>$setting)
				{
					if (($forum_details[0]['t_pt_from']==$member_id) || ($forum_details[0]['t_pt_to']==$member_id) || (ocf_has_special_pt_access(intval($category),$member_id)) || (!has_specific_permission($member_id,'view_other_pt')))
						$members_new[$member_id]=$setting;
				}
				$members=$members_new;
			}
		} else // This is a forum. Actually this code path should rarely if ever run - we don't dispatch notifications against forums, but topics (see above code branch).
		{
			$forum_id=intval(substr($category,6));
		}

		if (!is_null($forum_id))
		{
			list($members,$maybe_more)=$this->_all_members_who_have_enabled_with_zone_access(array($members,$maybe_more),'forum',$notification_code,$category,$to_member_ids,$start,$max);
			list($members,$maybe_more)=$this->_all_members_who_have_enabled_with_category_access(array($members,$maybe_more),'forums',$notification_code,strval($forum_id),$to_member_ids,$start,$max);
		} // We know PTs have been pre-filtered before notification is sent out, to limit them

		return array($members,$maybe_more);
	}
}
