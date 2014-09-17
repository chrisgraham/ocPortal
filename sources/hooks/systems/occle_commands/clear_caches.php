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
 * @package		occle
 */

class Hook_occle_command_clear_caches
{
	/**
	 * Run function for OcCLE hooks.
	 *
	 * @param  array	The options with which the command was called
	 * @param  array	The parameters with which the command was called
	 * @param  object	A reference to the OcCLE filesystem object
	 * @return array	Array of stdcommand, stdhtml, stdout, and stderr responses
	 */
	function run($options,$parameters,&$occle_fs)
	{
		if ((array_key_exists('h',$options)) || (array_key_exists('help',$options))) return array('',do_command_help('clear_caches',array('h'),array(true)),'','');
		else
		{
			require_code('caches3');

			$_caches=array();
			if (array_key_exists(0,$parameters))
			{
				$caches=explode(',',$parameters[0]);
				foreach ($caches as $cache) $_caches[]=trim($cache);
			}

			$messages=static_evaluate_tempcode(ocportal_cleanup($_caches));
			if ($messages=='') $messages=do_lang('SUCCESS');
			return array('',$messages,'','');
		}
	}
}

