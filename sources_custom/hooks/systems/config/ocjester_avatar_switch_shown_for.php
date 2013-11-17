<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		oc_jester
 */

class Hook_config_ocjester_avatar_switch_shown_for
{
	/**
	 * Gets the details relating to the config option.
	 *
	 * @return ?array		The details (NULL: disabled)
	 */
	function get_details()
	{
		return array(
			'human_name'=>'OCJESTER_AVATAR_SWITCH_SHOWN_FOR',
			'type'=>'line',
			'category'=>'FEATURE',
			'group'=>'OCJESTER_TITLE',
			'explanation'=>'CONFIG_OPTION_ocjester_avatar_switch_shown_for',
			'shared_hosting_restricted'=>'0',
			'list_options'=>'',

			'addon'=>'oc_jester',
		);
	}

	/**
	 * Gets the default value for the config option.
	 *
	 * @return ?string		The default value (NULL: option is disabled)
	 */
	function get_default()
	{
		return '';
	}
}


