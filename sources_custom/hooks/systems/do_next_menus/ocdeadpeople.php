<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2011

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 */


class Hook_do_next_menus_ocdeadpeople
{

	/**
	 * Standard modular run function for do_next_menu hooks. They find links to put on standard navigation menus of the system.
	 *
	 * @return array			Array of links and where to show
	 */
	function run()
	{
		require_lang('ocdeadpeople');
		//if (!addon_installed('ocdeadpeople')) return array();

		return array(
			array('setup','ocdeadpeoplelog',array('admin_ocdeadpeople',array('type'=>'misc'),get_module_zone('admin_ocdeadpeople')),do_lang_tempcode('MANAGE_DESEASES'),('DOC_OCDEADPEOPLE'))
		);
	}

}


