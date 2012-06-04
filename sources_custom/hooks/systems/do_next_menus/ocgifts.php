<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 */


class Hook_do_next_menus_ocgifts
{

	/**
	 * Standard modular run function for do_next_menu hooks. They find links to put on standard navigation menus of the system.
	 *
	 * @return array			Array of links and where to show
	 */
	function run()
	{
		require_lang('ocgifts');
		//if (!addon_installed('ocgifts')) return array();

		return array(
			array('setup','ocgifts',array('admin_ocgifts',array(),get_page_zone('admin_ocgifts')),do_lang_tempcode('MANAGE_GIFTS'),('DOC_OCGIFTS'))
		);
	}

}


