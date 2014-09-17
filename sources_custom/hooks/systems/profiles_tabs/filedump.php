<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		filedump
 */

class Hook_Profiles_Tabs_filedump
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
		return (($member_id_of==$member_id_viewing) || (has_privilege($member_id_viewing,'assume_any_member')));
	}

	/**
	 * Render function for profile tab hooks.
	 *
	 * @param  MEMBER			The ID of the member who is being viewed
	 * @param  MEMBER			The ID of the member who is doing the viewing
	 * @param  boolean		Whether to leave the tab contents NULL, if tis hook supports it, so that AJAX can load it later
	 * @return array			A tuple: The tab title, the tab contents, the suggested tab order, the icon
	 */
	function render_tab($member_id_of,$member_id_viewing,$leave_to_ajax_if_possible=false)
	{
		enforce_personal_access($member_id_of,NULL,NULL,$member_id_viewing);

		require_lang('filedump');

		$title=do_lang_tempcode('_FILEDUMP');

		$order=70;

		if ($leave_to_ajax_if_possible) return array($title,NULL,$order,'menu/cms/filedump');

		$content=do_template('OCF_MEMBER_PROFILE_FILEDUMP',array('_GUID'=>'87c683590a6e2d435d877cec1c97baba','MEMBER_ID'=>strval($member_id_of)));

		return array($title,$content,$order,'menu/cms/filedump');
	}
}


