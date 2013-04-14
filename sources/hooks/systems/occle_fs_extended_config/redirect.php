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
 * @package		redirects_editor
 */

class Hook_occle_fs_extended_config__redirect
{

	/**
	 * Standard modular date fetch function for resource-fs hooks. Defined when getting an edit date is not easy.
	 *
	 * @return ?TIME			The edit date or add date, whichever is higher (NULL: could not find one)
	 */
	function _get_edit_date()
	{
		$query='SELECT MAX(date_and_time) FROM '.get_table_prefix().'adminlogs WHERE '.db_string_equal_to('the_type','SET_REDIRECTS');
		return $GLOBALS['SITE_DB']->query_value_if_there($query);
	}

	/**
	 * Standard modular file reading function for OcCLE FS hooks.
	 *
	 * @param  array		The current meta-directory path
	 * @param  string		The root node of the current meta-directory
	 * @param  string		The file name
	 * @param  object		A reference to the OcCLE filesystem object
	 * @return ~string	The file contents (false: failure)
	 */
	function read_file($meta_dir,$meta_root_node,$file_name,&$occle_fs)
	{
		$rows=$GLOBALS['SITE_DB']->query_select('redirects',array('*'));
		return serialize($rows);
	}

	/**
	 * Standard modular file writing function for OcCLE FS hooks.
	 *
	 * @param  array		The current meta-directory path
	 * @param  string		The root node of the current meta-directory
	 * @param  string		The file name
	 * @param  string		The new file contents
	 * @param  object		A reference to the OcCLE filesystem object
	 * @return boolean	Success?
	 */
	function write_file($meta_dir,$meta_root_node,$file_name,$contents,&$occle_fs)
	{
		$GLOBALS['SITE_DB']->query_delete('redirects');
		$rows=@unserialize($contents);
		if ($rows===false) return false;
		foreach ($rows as $row)
		{
			$GLOBALS['SITE_DB']->query_insert('redirects',$row);
		}
		return true;
	}

}
