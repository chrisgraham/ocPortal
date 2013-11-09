<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		ocportalcom_support_credits
 */

class Hook_page_groupings_support_credits
{

	/**
	 * Standard modular run function for do_next_menu hooks. They find links to put on standard navigation menus of the system.
	 *
	 * @return array			List of tuple of links (page grouping, icon, do-next-style linking data), label, help (optional) and/or nulls
	 */
	function run()
	{
		return array(
			array('audit','menu/_generic_admin/tool',array('outstanding_credits',array(),'adminzone'),do_lang_tempcode('customers:UNSPENT_SUPPORT_CREDITS')),
			array('tools','menu/_generic_admin/tool',array('admin_customers',array(),'adminzone'),do_lang_tempcode('customers:CHARGE_CUSTOMER')),
		);
	}

}


