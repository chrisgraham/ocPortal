<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		ocportalcom
 */

/**
 * Module page class.
 */
class Module_admin_sites
{

	/**
	 * Standard modular info function.
	 *
	 * @return ?array	 Map of module info (NULL: module is disabled).
	 */
	function info()
	{
		$info=array();
		$info['author']='Chris Graham';
		$info['organisation']='ocProducts'; 
		$info['hacked_by']=NULL; 
		$info['hack_version']=NULL;
		$info['version']=2;
		$info['locked']=false;
		return $info;
	}

	/**
	 * Standard modular entry-point finder function.
	 *
	 * @return ?array	 A map of entry points (type-code=>language-code) (NULL: disabled).
	 */
	function get_entry_points()
	{
		return array();
	}

	/**
	 * Standard modular run function.
	 *
	 * @return tempcode	 The result of execution.
	 */
	function run()
	{
		return new ocp_tempcode();
	}

}

