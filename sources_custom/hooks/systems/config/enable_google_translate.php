<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		google_translate
 */

class Hook_config_enable_google_translate
{
	/**
	 * Gets the details relating to the config option.
	 *
	 * @return ?array		The details (NULL: disabled)
	 */
	function get_details()
	{
		return array(
			'human_name'=>'ENABLE_GOOGLE_TRANSLATE',
			'type'=>'tick',
			'category'=>'SITE',
			'group'=>'INTERNATIONALISATION',
			'explanation'=>'CONFIG_OPTION_enable_google_translate',
			'shared_hosting_restricted'=>'0',
			'list_options'=>'',

			'addon'=>'google_translate',
		);
	}

	/**
	 * Gets the default value for the config option.
	 *
	 * @return ?string		The default value (NULL: option is disabled)
	 */
	function get_default()
	{
		return '0';
	}
}


