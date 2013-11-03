<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		classifieds
 */

class Hook_config_max_classified_listings_per_screen
{

	/**
	 * Gets the details relating to the config option.
	 *
	 * @return ?array		The details (NULL: disabled)
	 */
	function get_details()
	{
		return array(
			'human_name'=>'MAX_CLASSIFIED_LISTINGS_PER_SCREEN',
			'type'=>'integer',
			'category'=>'FEATURE',
			'group'=>'CLASSIFIEDS',
			'explanation'=>'CONFIG_OPTION_max_classified_listings_per_screen',
			'shared_hosting_restricted'=>'0',
			'list_options'=>'',
			'required'=>true,

			'addon'=>'classifieds',
		);
	}

	/**
	 * Gets the default value for the config option.
	 *
	 * @return ?string		The default value (NULL: option is disabled)
	 */
	function get_default()
	{
		return '30';
	}

}


