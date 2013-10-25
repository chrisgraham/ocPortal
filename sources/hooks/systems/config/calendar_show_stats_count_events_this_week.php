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
 * @package		calendar
 */

class Hook_config_calendar_show_stats_count_events_this_week
{

	/**
	 * Gets the details relating to the config option.
	 *
	 * @return ?array		The details (NULL: disabled)
	 */
	function get_details()
	{
		return array(
			'human_name'=>'_EVENTS_THIS_WEEK',
			'type'=>'tick',
			'category'=>'BLOCKS',
			'group'=>'STATISTICS',
			'explanation'=>'CONFIG_OPTION_calendar_show_stats_count_events_this_week',
			'shared_hosting_restricted'=>'0',
			'list_options'=>'',

			'addon'=>'calendar',
		);
	}

	/**
	 * Gets the default value for the config option.
	 *
	 * @return ?string		The default value (NULL: option is disabled)
	 */
	function get_default()
	{
		return addon_installed('stats_block')?'0':NULL;
	}

}


