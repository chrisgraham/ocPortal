<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2013

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

class Hook_occle_command_fix_perms
{
	/**
	 * Standard modular run function for OcCLE hooks.
	 *
	 * @param  array	The options with which the command was called
	 * @param  array	The parameters with which the command was called
	 * @param  array	A reference to the OcCLE filesystem object
	 * @return array	Array of stdcommand, stdhtml, stdout, and stderr responses
	 */
	function run($options,$parameters,&$occle_fs)
	{
		require_code('xhtml');

		if ((array_key_exists('h',$options)) || (array_key_exists('help',$options))) return array('',do_command_help('fix_perms',array('h'),array(true,true,true)),'','');
		else
		{
			if (!array_key_exists(0,$parameters)) return array('','','',do_lang('MISSING_PARAM','1','fix_perms'));
			if (!array_key_exists(1,$parameters)) return array('','','',do_lang('MISSING_PARAM','2','fix_perms'));
			if (!array_key_exists(2,$parameters)) return array('','','',do_lang('MISSING_PARAM','3','fix_perms'));

			$return=http_download_file(get_base_url().'/upgrader.php?check_perms=1&user='.$parameters[0].'&pass='.$parameters[1].'&root='.$parameters[2],NULL,false);
			if (is_null($return)) return array('','','',do_lang('HTTP_DOWNLOAD_NO_SERVER',get_base_url().'/upgrader.php?check_perms=1'));
			else
			{
				return array('',occle_make_normal_html_visible(extract_html_body($return)),'','');
			}
		}
	}

}
