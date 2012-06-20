<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		static_export
 */


class Hook_do_next_menus_static_export
{

	/**
	 * Standard modular run function for do_next_menu hooks. They find links to put on standard navigation menus of the system.
	 *
	 * @return array			Array of links and where to show
	 */
	function run()
	{
		return array(
			array('Tools','admin_home',array('static_export',array('keep_theme'=>$GLOBALS['FORUM_DRIVER']->get_theme('')),'adminzone'),make_string_tempcode('Export static site copy'))
		);
	}

}


