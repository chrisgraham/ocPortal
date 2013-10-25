<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		workflows
 */


class Hook_do_next_menus_workflows
{

	/**
	 * Standard modular run function for do_next_menu hooks. They find links to put on standard navigation menus of the system.
	 *
	 * @return array			Array of links and where to show
	 */
	function run()
	{
		if (!addon_installed('workflows',true)) return array();

		require_lang('workflows');

		return array(
			array('cms','workflows',array('admin_workflow',array('type'=>'misc'),get_module_zone('admin_workflow')),do_lang_tempcode('ITEMS_HERE',do_lang_tempcode('WORKFLOWS'),make_string_tempcode(escape_html(integer_format($GLOBALS['SITE_DB']->query_select_value('workflow_requirements','COUNT(DISTINCT workflow_name)'))))),('DOC_WORKFLOWS')),
		);
	}

}


