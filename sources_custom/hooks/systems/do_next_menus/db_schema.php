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


class Hook_do_next_menus_db_schema
{

	/**
	 * Standard modular run function for do_next_menu hooks. They find links to put on standard navigation menus of the system.
	 *
	 * @return array			Array of links and where to show
	 */
	function run()
	{
		return array(
			array('tools','admin_home',array('sql_schema_generate',array(),'adminzone'),make_string_tempcode('Doc build: Generate database schema')),
			array('tools','admin_home',array('sql_schema_generate_by_addon',array(),'adminzone'),make_string_tempcode('Doc build: Generate database schema, by addon')),
			array('tools','admin_home',array('sql_show_tables_by_addon',array(),'adminzone'),make_string_tempcode('Doc build: Show database tables, by addon'))
		);
	}

}


