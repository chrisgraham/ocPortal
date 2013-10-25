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
 * @package		match_key_permissions
 */

class Hook_occle_fs_extended_config__match_key_message
{

	/**
	 * Standard modular date fetch function for resource-fs hooks. Defined when getting an edit date is not easy.
	 *
	 * @return ?TIME			The edit date or add date, whichever is higher (NULL: could not find one)
	 */
	function _get_edit_date()
	{
		$query='SELECT MAX(date_and_time) FROM '.get_table_prefix().'adminlogs WHERE '.db_string_equal_to('the_type','PAGE_MATCH_KEY_ACCESS');
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
		require_code('xml_storage');

		$rows=$GLOBALS['SITE_DB']->query_select('match_key_messages',array('k_message','k_match_key'),NULL,'ORDER BY id');
		$rows2=array();
		foreach ($rows as $row)
		{
			$row2=array('message'=>'<lang>'.get_translated_text_xml($row['k_message'],'message',$GLOBALS['SITE_DB']).'</lang>','match_key'=>$row['k_match_key']);
			$rows2[]=$row2;
		}
		return serialize($rows2);
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
		require_code('xml_storage');

		$rows=$GLOBALS['SITE_DB']->query_select('match_key_messages',array('k_message'));
		foreach ($rows as $row)
		{
			delete_lang($row['k_message']);
		}
		$GLOBALS['SITE_DB']->query_delete('match_key_messages');

		$rows=@unserialize($contents);
		if ($rows===false) return false;
		foreach ($rows as $row)
		{
			$row2=array('k_message'=>insert_lang_xml($row['k_message']),'k_match_key'=>$row['k_match_key']);
			$GLOBALS['SITE_DB']->query_insert('match_key_messages',$row2);
		}
		return true;
	}

}
