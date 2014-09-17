<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.


 NOTE TO PROGRAMMERS:
   Do not edit this file. If you need to make changes, save your changed file to the appropriate *_custom folder
   **** If you ignore this advice, then your website upgrades (e.g. for bug fixes) will likely kill your changes ****

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		core_cleanup_tools
 */

class Hook_orphaned_lang_strings
{
	/**
	 * Find details about this cleanup hook.
	 *
	 * @return ?array	Map of cleanup hook info (NULL: hook is disabled).
	 */
	function info()
	{
		if (!multi_lang_content()) return NULL;

		if ($GLOBALS['SITE_DB']->query_select_value('translate','COUNT(*)')>10000) return NULL; // Too much, and we don't have much use for it outside development anyway

		$info=array();
		$info['title']=do_lang_tempcode('ORPHANED_LANG_STRINGS');
		$info['description']=do_lang_tempcode('DESCRIPTION_ORPHANED_LANG_STRINGS');
		$info['type']='optimise';

		return $info;
	}

	/**
	 * Run the cleanup hook action.
	 *
	 * @return tempcode	Results
	 */
	function run()
	{
		require_code('tasks');
		return call_user_func_array__long_task(do_lang('ORPHANED_LANG_STRINGS'),NULL,'find_orphaned_lang_strings');
	}
}


