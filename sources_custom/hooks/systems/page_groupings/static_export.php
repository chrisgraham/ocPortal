<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		static_export
 */

class Hook_page_groupings_static_export
{

	/**
	 * Standard modular run function for do_next_menu hooks. They find links to put on standard navigation menus of the system.
	 *
	 * @return array			List of tuple of links (page grouping, icon, do-next-style linking data), label, help (optional) and/or nulls
	 */
	function run()
	{
		return array(
			array('tools','menu/_generic_admin/tool',array('static_export',array('keep_theme'=>$GLOBALS['FORUM_DRIVER']->get_theme('')),'adminzone'),make_string_tempcode('Export static site (tar)')),
			array('tools','menu/_generic_admin/tool',array('static_export',array('dir'=>'1','keep_theme'=>$GLOBALS['FORUM_DRIVER']->get_theme('')),'adminzone'),make_string_tempcode('Export static site (exports/static, with mtimes)')),
		);
	}

}


