<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		developer_sync
 */


class Hook_do_next_menus_developer_sync
{

	/**
	 * Standard modular run function for do_next_menu hooks. They find links to put on standard navigation menus of the system.
	 *
	 * @return array			Array of links and where to show
	 */
	function run()
	{
		return array(
			array('tools','admin_home',array('sql_dump',array(),'adminzone'),make_string_tempcode('Backup tools: Create SQL dump (MySQL syntax)')),
			array('tools','admin_home',array('tar_dump',array(),'adminzone'),make_string_tempcode('Backup tools: Create files dump (TAR file)')),
		);
	}

}


