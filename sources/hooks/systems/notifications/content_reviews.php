<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2013

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		content_reviews
 */

class Hook_Notification_content_reviews extends Hook_Notification__Staff
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

		$_hooks=find_all_hooks('systems','content_meta_aware');
		foreach (array_keys($_hooks) as $content_type)
		{
			require_code('content');
			$object=get_content_object($content_type);
			if (is_null($object)) continue;
			$info=$object->info();
			if (is_null($info)) continue;

			$lang=do_lang($info['content_type_label'],NULL,NULL,NULL,NULL,false);
			if (is_null($lang)) continue;

			$pagelinks[]=array(
				'id'=>$content_type,
				'title'=>$lang,
			);
		}

		sort_maps_by($pagelinks,'title');

		return $pagelinks;
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
		$list['content_reviews']=array(do_lang('menus:CONTENT'),do_lang('content_reviews:NOTIFICATION_TYPE_content_reviews'));
		$list['content_reviews__own']=array(do_lang('menus:CONTENT'),do_lang('content_reviews:NOTIFICATION_TYPE_content_reviews__own'));
		return $list;
	}
}
