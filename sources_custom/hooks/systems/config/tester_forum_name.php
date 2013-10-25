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
 * @package		tester
 */

class Hook_config_tester_forum_name
{

	/**
	 * Gets the details relating to the config option.
	 *
	 * @return ?array		The details (NULL: disabled)
	 */
	function get_details()
	{
		return array(
			'human_name'=>'TESTER_FORUM_NAME',
			'type'=>'forum',
			'category'=>'FEATURE',
			'group'=>'TESTER',
			'explanation'=>'CONFIG_OPTION_tester_forum_name',
			'shared_hosting_restricted'=>'0',
			'list_options'=>'',
			'order_in_category_group'=>2,
			'required'=>true,

			'addon'=>'tester',
		);
	}

	/**
	 * Gets the default value for the config option.
	 *
	 * @return ?string		The default value (NULL: option is disabled)
	 */
	function get_default()
	{
		return do_lang('tester:DEFAULT_TESTER_FORUM','','','',get_site_default_lang());
	}

}


