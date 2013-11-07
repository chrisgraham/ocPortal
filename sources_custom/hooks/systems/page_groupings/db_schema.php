<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		db_schema
 */

class Hook_page_groupings_db_schema
{

	/**
	 * Standard modular run function for do_next_menu hooks. They find links to put on standard navigation menus of the system.
	 *
	 * @return array			List of tuple of links (page grouping, icon, do-next-style linking data), label, help (optional) and/or nulls
	 */
	function run()
	{
		return array(
			array('tools','menu/_generic_admin/tool',array('sql_schema_generate',array(),'adminzone'),make_string_tempcode('Doc build: Generate database schema')),
			array('tools','menu/_generic_admin/tool',array('sql_schema_generate_by_addon',array(),'adminzone'),make_string_tempcode('Doc build: Generate database schema, by addon')),
			array('tools','menu/_generic_admin/tool',array('sql_show_tables_by_addon',array(),'adminzone'),make_string_tempcode('Doc build: Show database tables, by addon'))
		);
	}

}


