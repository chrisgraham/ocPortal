<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.


 NOTE TO PROGRAMMERS:
   Do not edit this file. If you need to make changes, save your changed file to the appropriate *_custom folder
   **** If you ignore this advice, then your website upgrades (e.g. for bug fixes) will likely kill your changes ****

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		core_cleanup_tools
 */

class Hook_templates
{

	/**
	 * Standard modular info function.
	 *
	 * @return ?array	Map of module info (NULL: module is disabled).
	 */
	function info()
	{
		$info=array();
		$info['title']=do_lang_tempcode('TEMPLATE_CACHE');
		$info['description']=do_lang_tempcode('DESCRIPTION_TEMPLATES');
		$info['type']='cache';

		return $info;
	}

	/**
	 * Standard modular run function.
	 *
	 * @return tempcode	Results
	 */
	function run()
	{
		require_code('view_modes');
		erase_cached_templates();

		return new ocp_tempcode();
	}

}


