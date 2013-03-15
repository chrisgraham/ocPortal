<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		related_members
 */

class Hook_Profiles_Tabs_related
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
		require_lang('related');

		return (get_ocp_cpf(do_lang('RELATED_CPF'),$member_id_of)!='');
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
		require_lang('related');

		$title=do_lang_tempcode('RELATED_MEMBERS');

		$order=150;

		if ($leave_to_ajax_if_possible) return array($title,NULL,$order);

		require_css('member_directory_boxes');

		$cpf_value=get_ocp_cpf(do_lang('RELATED_CPF'),$member_id_of);
		$ocselect=do_lang('RELATED_CPF').'='.$cpf_value.',id<>'.strval($GLOBALS['FORUM_DRIVER']->get_guest_id()).',id<>'.strval($member_id_of);
		$content=do_block('main_multi_content',array('param'=>'member','ocselect'=>$ocselect,'no_links'=>'1'));

		return array($title,$content,$order);
	}

}


