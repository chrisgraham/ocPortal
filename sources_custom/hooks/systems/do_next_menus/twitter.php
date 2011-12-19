<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2011

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		twitter_support
 */

class Hook_do_next_menus_twitter
{

	/**
	 * Standard modular run function for do_next_menu hooks. They find links to put on standard navigation menus of the system.
	 *
	 * @return array			Array of links and where to show
	 */
	function run()
	{
		require_lang('twitter');

		return array(
			array('setup','twitter',array('twitter_oauth',array(),'adminzone'),do_lang_tempcode('TWITTER_SYNDICATION'),('DOC_TWITTER_SYNDICATION'))
		);
	}

}


