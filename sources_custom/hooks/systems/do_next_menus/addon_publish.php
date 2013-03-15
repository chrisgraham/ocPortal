<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		addon_publish
 */


class Hook_do_next_menus_addon_publish
{

	/**
	 * Standard modular run function for do_next_menu hooks. They find links to put on standard navigation menus of the system.
	 *
	 * @return array			Array of links and where to show
	 */
	function run()
	{
		return array(
			array('tools','admin_home',array('admin_generate_adhoc_upgrade',array(),'adminzone'),make_string_tempcode('Release tools: Create adhoc-upgrade-TAR/guidance')),
			array('tools','admin_home',array('build_addons',array(),'adminzone'),make_string_tempcode('Release tools: Build non-bundled addon TARs')),
			array('tools','admin_home',array('publish_addons_as_downloads',array(),'adminzone'),make_string_tempcode('ocPortal.com: Publish non-bundled addons')),
		);
	}

}


