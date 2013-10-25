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
 * @package		ecommerce
 */

class Hook_config_payment_gateway
{

	/**
	 * Gets the details relating to the config option.
	 *
	 * @return ?array		The details (NULL: disabled)
	 */
	function get_details()
	{
		return array(
			'human_name'=>'PAYMENT_GATEWAY',
			'type'=>'special',
			'category'=>'ECOMMERCE',
			'group'=>'PAYMENT_GATEWAY',
			'explanation'=>'CONFIG_OPTION_payment_gateway',
			'shared_hosting_restricted'=>'0',
			'list_options'=>'',
			'order_in_category_group'=>1,

			'addon'=>'ecommerce',
		);
	}

	/**
	 * Gets the default value for the config option.
	 *
	 * @return ?string		The default value (NULL: option is disabled)
	 */
	function get_default()
	{
		return 'paypal';
	}

	/**
	 * Field inputter (because the_type=special).
	 *
	 * @param  ID_TEXT		The config option name
	 * @param  array			The config row
	 * @param  tempcode		The field title
	 * @param  tempcode		The field description
	 * @return tempcode		The inputter
	 */
	function field_inputter($name,$myrow,$human_name,$explanation)
	{
		$list='';
		$all_via=find_all_hooks('systems','ecommerce_via');
		foreach (array_keys($all_via) as $via)
		{
			$list.=static_evaluate_tempcode(form_input_list_entry($via,$via==get_option($name)));
		}
		return form_input_list($human_name,$explanation,$name,make_string_tempcode($list));
	}

}


