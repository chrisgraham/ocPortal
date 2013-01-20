<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2013

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		ocportal_release_build
 */


class Hook_do_next_menus_ocportal_release_build
{

	/**
	 * Standard modular run function for do_next_menu hooks. They find links to put on standard navigation menus of the system.
	 *
	 * @return array			Array of links and where to show
	 */
	function run()
	{
		return array(
			array('tools','admin_home',array('plug_guid',array(),'adminzone'),make_string_tempcode('Release tools: Plug in missing GUIDs')),
			array('tools','admin_home',array('make_release',array(),'adminzone'),make_string_tempcode('Release tools: Make an ocPortal release')),
			array('tools','admin_home',array('push_bugfix',array(),'adminzone'),make_string_tempcode('Release tools: Push an ocPortal bugfix')),
		);
	}

}


