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

class Hook_sw_stats
{

	/**
	 * Standard modular run function for features in the setup wizard.
	 *
	 * @return array		Current settings.
	 */
	function get_current_settings()
	{
		$settings=array();
		$settings['stats_store_time']=get_option('stats_store_time');
		return $settings;
	}

	/**
	 * Standard modular run function for features in the setup wizard.
	 *
	 * @param  array		Default values for the fields, from the install-profile.
	 * @return tempcode	An input field.
	 */
	function get_fields($field_defaults)
	{
		if (!addon_installed('stats')) return new ocp_tempcode();

		$field_defaults+=$this->get_current_settings(); // $field_defaults will take precedence, due to how "+" operator works in PHP

		$stats_store_time=$field_defaults['stats_store_time'];

		require_lang('stats');
		$fields=new ocp_tempcode();
		$fields->attach(form_input_integer(do_lang_tempcode('STORE_TIME'),do_lang_tempcode('CONFIG_OPTION_stats_store_time'),'stats_store_time',intval($stats_store_time),true));

		return $fields;
	}

	/**
	 * Standard modular run function for setting features from the setup wizard.
	 */
	function set_fields()
	{
		if (!addon_installed('stats')) return;

		set_option('stats_store_time',post_param('stats_store_time'));
	}

}


