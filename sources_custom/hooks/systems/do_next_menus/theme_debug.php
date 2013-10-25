<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		theme_debug
 */


class Hook_do_next_menus_theme_debug
{

	/**
	 * Standard modular run function for do_next_menu hooks. They find links to put on standard navigation menus of the system.
	 *
	 * @return array			Array of links and where to show
	 */
	function run()
	{
		return array(
			array('style','admin_home',array('theme_debug',array(),''),make_string_tempcode('Theme testing / fixup tools')),
			array('style','admin_home',array('fix_partial_themewizard_css',array(),'adminzone'),make_string_tempcode('Fixup themewizard themes')),
			array('style','admin_home',array('css_check',array(),'adminzone'),make_string_tempcode('Look for unused CSS')),
		);
	}

}


