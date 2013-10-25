<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		booking
 */


class Hook_do_next_menus_booking
{

	/**
	 * Standard modular run function for do_next_menu hooks. They find links to put on standard navigation menus of the system.
	 *
	 * @return array			Array of links and where to show
	 */
	function run()
	{
		require_lang('booking');

		return array(
			array('cms','booking',array('cms_booking',array(),get_page_zone('cms_booking')),do_lang_tempcode('BOOKINGS'),('DOC_BOOKING'))
		);
	}

}


