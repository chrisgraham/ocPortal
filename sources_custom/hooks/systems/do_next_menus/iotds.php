<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		iotds
 */


class Hook_do_next_menus_iotds
{

	/**
	 * Standard modular run function for do_next_menu hooks. They find links to put on standard navigation menus of the system.
	 *
	 * @return array			Array of links and where to show
	 */
	function run()
	{
		return array(
			array('cms','menu/rich_content/iotds',array('cms_iotds',array('type'=>'misc'),get_module_zone('cms_iotds')),do_lang_tempcode('ITEMS_HERE',do_lang_tempcode('iotds:IOTDS'),make_string_tempcode(escape_html(integer_format($GLOBALS['SITE_DB']->query_select_value_if_there('iotd','COUNT(*)',NULL,'',true))))),'iotds:DOC_IOTDS'),
			array('rich_content','menu/rich_content/iotds',array('iotds',array(),get_module_zone('iotds')),do_lang_tempcode('iotds:IOTDS')),
		);
	}

}


