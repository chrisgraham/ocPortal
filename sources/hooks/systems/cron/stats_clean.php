<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.


 NOTE TO PROGRAMMERS:
   Do not edit this file. If you need to make changes, save your changed file to the appropriate *_custom folder
   **** If you ignore this advice, then your website upgrades (e.g. for bug fixes) will likely kill your changes ****

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		stats
 */

class Hook_cron_stats_clean
{

	/**
	 * Standard modular run function for CRON hooks. Searches for tasks to perform.
	 */
	function run()
	{
		if (!addon_installed('stats')) return;

		if (!$GLOBALS['SITE_DB']->table_is_locked('stats'))
			$GLOBALS['SITE_DB']->query('DELETE FROM '.get_table_prefix().'stats WHERE date_and_time<'.strval(time()-60*60*24*intval(get_option('stats_store_time'))));
	}

}


