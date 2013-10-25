<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		ocf_forum
 */

class Hook_Profiles_Tabs_posts
{

	/**
	 * Find whether this hook is active.
	 *
	 * @param  MEMBER			The ID of the member who is being viewed
	 * @param  MEMBER			The ID of the member who is doing the viewing
	 * @return boolean		Whether this hook is active
	 */
	function is_active($member_id_of,$member_id_viewing)
	{
		return get_value('activities_and_posts')==='1';
	}

	/**
	 * Standard modular render function for profile tab hooks.
	 *
	 * @param  MEMBER			The ID of the member who is being viewed
	 * @param  MEMBER			The ID of the member who is doing the viewing
	 * @param  boolean		Whether to leave the tab contents NULL, if tis hook supports it, so that AJAX can load it later
	 * @return array			A triple: The tab title, the tab contents, the suggested tab order
	 */
	function render_tab($member_id_of,$member_id_viewing,$leave_to_ajax_if_possible=false)
	{
		$title=do_lang_tempcode('FORUM_POSTS');

		$order=20;

		if ($leave_to_ajax_if_possible) return array($title,NULL,$order);

		$topics=do_block('main_ocf_involved_topics',array('member_id'=>strval($member_id_of),'max'=>'10','start'=>'0'));
		$content=do_template('OCF_MEMBER_PROFILE_POSTS',array('_GUID'=>'365391fb674468b94c1e7006bc1279b8','MEMBER_ID'=>strval($member_id_of),'TOPICS'=>$topics));

		return array($title,$content,$order);
	}

}


