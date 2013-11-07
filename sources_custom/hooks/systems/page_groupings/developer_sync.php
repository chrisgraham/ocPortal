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
class Hook_page_groupings_developer_sync
{

	/**
	 * Standard modular run function for do_next_menu hooks. They find links to put on standard navigation menus of the system.
	 *
	 * @return array			List of tuple of links (page grouping, icon, do-next-style linking data), label, help (optional) and/or nulls
	 */
	function run()
	{
		return array(
			array('tools','menu/_generic_admin/tool',array('sql_dump',array(),'adminzone'),make_string_tempcode('Backup tools: Create SQL dump (MySQL syntax)')),
			array('tools','menu/_generic_admin/tool',array('tar_dump',array(),'adminzone'),make_string_tempcode('Backup tools: Create files dump (TAR file)')),
		);
	}

}


