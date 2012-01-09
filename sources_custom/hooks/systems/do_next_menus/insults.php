<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 */


class Hook_do_next_menus_insults
{

	/**
	 * Standard modular run function for do_next_menu hooks. They find links to put on standard navigation menus of the system.
	 *
	 * @return array			Array of links and where to show
	 */
	function run()
	{
		require_lang('insults');
		//if (!addon_installed('insults')) return array();

		return array(
			array('setup','insults',array('insults',array(),get_page_zone('insults')),do_lang_tempcode('MANAGE_INSULTS'),('DOC_INSULTS'))
		);
	}

}


