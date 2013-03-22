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

class Hook_occle_fs_etc
{
	/**
	 * Standard modular listing function for OcCLE FS hooks.
	 *
	 * @param  array		The current meta-directory path
	 * @param  string		The root node of the current meta-directory
	 * @param  array		The current directory listing
	 * @param  array		A reference to the OcCLE filesystem object
	 * @return ~array 	The final directory listing (false: failure)
	 */
	function listing($meta_dir,$meta_root_node,$current_dir,&$occle_fs)
	{
		global $CONFIG_OPTIONS_CACHE;

		if (count($meta_dir)>0) return false; // Directory doesn't exist
		load_options();

		$listing=array();
		foreach (array_keys($CONFIG_OPTIONS_CACHE) as $option)
		{
			$listing[]=array(
				$option,
				OCCLEFS_FILE,
				NULL/*don't calculate a filesize*/,
				NULL/*don't specify a modification time*/,
			);
		}

		return $listing;
	}

	/**
	 * Standard modular directory creation function for OcCLE FS hooks.
	 *
	 * @param  array		The current meta-directory path
	 * @param  string		The root node of the current meta-directory
	 * @param  string		The new directory name
	 * @param  array		A reference to the OcCLE filesystem object
	 * @return boolean	Success?
	 */
	function make_directory($meta_dir,$meta_root_node,$new_dir_name,&$occle_fs)
	{
		return false;
	}

	/**
	 * Standard modular directory removal function for OcCLE FS hooks.
	 *
	 * @param  array		The current meta-directory path
	 * @param  string		The root node of the current meta-directory
	 * @param  string		The directory name
	 * @param  array		A reference to the OcCLE filesystem object
	 * @return boolean	Success?
	 */
	function remove_directory($meta_dir,$meta_root_node,$dir_name,&$occle_fs)
	{
		return false;
	}

	/**
	 * Standard modular file removal function for OcCLE FS hooks.
	 *
	 * @param  array		The current meta-directory path
	 * @param  string		The root node of the current meta-directory
	 * @param  string		The file name
	 * @param  array		A reference to the OcCLE filesystem object
	 * @return boolean	Success?
	 */
	function remove_file($meta_dir,$meta_root_node,$file_name,&$occle_fs)
	{
		if (count($meta_dir)>0) return false; // Directory doesn't exist
		delete_config_option($file_name);
		return true;
	}

	/**
	 * Standard modular file reading function for OcCLE FS hooks.
	 *
	 * @param  array		The current meta-directory path
	 * @param  string		The root node of the current meta-directory
	 * @param  string		The file name
	 * @param  array		A reference to the OcCLE filesystem object
	 * @return ~string		The file contents (false: failure)
	 */
	function read_file($meta_dir,$meta_root_node,$file_name,&$occle_fs)
	{
		if (count($meta_dir)>0) return false; // Directory doesn't exist
		return get_option($file_name,true);
	}

	/**
	 * Standard modular file writing function for OcCLE FS hooks.
	 *
	 * @param  array		The current meta-directory path
	 * @param  string		The root node of the current meta-directory
	 * @param  string		The file name
	 * @param  string		The new file contents
	 * @param  array		A reference to the OcCLE filesystem object
	 * @return boolean	Success?
	 */
	function write_file($meta_dir,$meta_root_node,$file_name,$contents,&$occle_fs)
	{
		require_code('config2');

		if (count($meta_dir)>0) return false; // Directory doesn't exist
		global $CONFIG_OPTIONS_CACHE;
		if (!array_key_exists($file_name,$CONFIG_OPTIONS_CACHE)) return false;
		set_option($file_name,$contents);
		return true;
	}

}

