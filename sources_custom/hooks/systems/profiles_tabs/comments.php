<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		member_comments
 */

class Hook_Profiles_Tabs_comments
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
		return true;
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
		require_lang('member_comments');

		$title=do_lang_tempcode('MEMBER_COMMENTS');

		$order=25;

		if ($leave_to_ajax_if_possible && count($_POST)==0) return array($title,NULL,$order);

		$forum_name=do_lang('MEMBER_COMMENTS_FORUM_NAME');
		$forum_id=$GLOBALS['FORUM_DRIVER']->forum_id_from_name($forum_name);
		if (is_null($forum_id))
		{
			require_code('ocf_forums_action');
			$forum_grouping_id=$GLOBALS['FORUM_DB']->query_value('f_categories','MIN(id)');
			$forum_grouping_id=ocf_make_forum($forum_name,'',$forum_grouping_id,array(),db_get_first_id()/*parent*/,20/*position*/,1,1,'','','','last_post',1/*is threaded*/);
		}

		// The member who 'owns' the tab should be receiving notifications
		require_code('notifications');
		$username=$GLOBALS['FORUM_DRIVER']->get_username($member_id_of);
		$main_map=array(
			'l_member_id'=>$member_id_of,
			'l_notification_code'=>'comment_posted',
			'l_code_category'=>'block_main_comments_'.$username.'_member',
		);
		$test=$GLOBALS['SITE_DB']->query_value_null_ok('notifications_enabled','id',$main_map);
		if (is_null($test))
		{
			$GLOBALS['SITE_DB']->query_insert('notifications_enabled',array(
				'l_setting'=>A_INSTANT_EMAIL,
			)+$main_map);
		}

		$content=do_template('OCF_MEMBER_PROFILE_COMMENTS',array('MEMBER_ID'=>strval($member_id_of),'FORUM_NAME'=>$forum_name));
		$content->handle_symbol_preprocessing();

		return array($title,$content,$order);
	}

}


