<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		classifieds
 */

class Hook_do_next_menus_classifieds
{

	/**
	 * Standard modular run function for do_next_menu hooks. They find links to put on standard navigation menus of the system.
	 *
	 * @return array			Array of links and where to show
	 */
	function run()
	{
		require_lang('classifieds');

		return array(
			array('setup','classifieds',array('admin_classifieds',array(),'adminzone'),do_lang_tempcode('CLASSIFIEDS_PRICING'),('DOC_CLASSIFIEDS_PRICING'))
		);
	}

}


