<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		xml_db_manage
 */


class Hook_do_next_menus_xml_db_manage
{

	/**
	 * Standard modular run function for do_next_menu hooks. They find links to put on standard navigation menus of the system.
	 *
	 * @return array			Array of links and where to show
	 */
	function run()
	{
		return array(
			array('tools','admin_home',array('xml_dump',array(),'adminzone'),make_string_tempcode('Create SQL dump (MySQL syntax)'))
		);
	}

}


