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
 * @package		ocf_post_templates
 */

require_code('resource_fs');

class Hook_occle_fs_post_templates extends resource_fs_base
{
	var $file_resource_type='post_template';

	/**
	 * Whether the filesystem hook is active.
	 *
	 * @return boolean		Whether it is
	 */
	function _is_active()
	{
		return (get_forum_type()=='ocf');
	}

	/**
	 * Standard modular introspection function.
	 *
	 * @return array			The properties available for the resource type
	 */
	function _enumerate_file_properties()
	{
		return array(
			'text'=>'LONG_TEXT',
			'forum_multi_code'=>'SHORT_TEXT',
			'use_default_forums'=>'BINARY',
		);
	}

	/**
	 * Standard modular date fetch function for OcCLE-fs resource hooks. Defined when getting an edit date is not easy.
	 *
	 * @param  array			Resource row (not full, but does contain the ID)
	 * @return ?TIME			The edit date or add date, whichever is higher (NULL: could not find one)
	 */
	function _get_file_edit_date($row)
	{
		$query='SELECT MAX(date_and_time) FROM '.get_table_prefix().'adminlogs WHERE '.db_string_equal_to('param_a',strval($row['id'])).' AND  ('.db_string_equal_to('the_type','ADD_POST_TEMPLATE').' OR '.db_string_equal_to('the_type','EDIT_POST_TEMPLATE').')';
		return $GLOBALS['SITE_DB']->query_value_if_there($query);
	}

	/**
	 * Standard modular add function for OcCLE-fs resource hooks. Adds some resource with the given label and properties.
	 *
	 * @param  SHORT_TEXT	Filename OR Resource label
	 * @param  string			The path (blank: root / not applicable)
	 * @param  array			Properties (may be empty, properties given are open to interpretation by the hook but generally correspond to database fields)
	 * @return ~ID_TEXT		The resource ID (false: error, could not create via these properties / here)
	 */
	function file_add($filename,$path,$properties)
	{
		list($category_resource_type,$category)=$this->folder_convert_filename_to_id($path);
		list($properties,$label)=$this->_file_magic_filter($filename,$path,$properties);

		require_code('ocf_general_action');

		$text=$this->_default_property_str($properties,'text');
		$forum_multi_code=$this->_default_property_str($properties,'forum_multi_code');
		$use_default_forums=$this->_default_property_int($properties,'use_default_forums');

		$id=ocf_make_post_template($label,$text,$forum_multi_code,$use_default_forums);
		return strval($id);
	}

	/**
	 * Standard modular load function for OcCLE-fs resource hooks. Finds the properties for some resource.
	 *
	 * @param  SHORT_TEXT	Filename
	 * @param  string			The path (blank: root / not applicable)
	 * @return ~array			Details of the resource (false: error)
	 */
	function _file_load($filename,$path)
	{
		list($resource_type,$resource_id)=$this->file_convert_filename_to_id($filename);

		$rows=$GLOBALS['FORUM_DB']->query_select('f_post_templates',array('*'),array('id'=>intval($resource_id)),'',1);
		if (!array_key_exists(0,$rows)) return false;
		$row=$rows[0];

		return array(
			'label'=>$row['t_title'],
			'text'=>$row['t_text'],
			'forum_multi_code'=>$row['t_forum_multi_code'],
			'use_default_forums'=>$row['use_default_forums'],
		);
	}

	/**
	 * Standard modular edit function for OcCLE-fs resource hooks. Edits the resource to the given properties.
	 *
	 * @param  ID_TEXT		The filename
	 * @param  string			The path (blank: root / not applicable)
	 * @param  array			Properties (may be empty, properties given are open to interpretation by the hook but generally correspond to database fields)
	 * @return boolean		Success status
	 */
	function file_edit($filename,$path,$properties)
	{
		list($resource_type,$resource_id)=$this->file_convert_filename_to_id($filename);

		require_code('ocf_general_action2');

		$label=$this->_default_property_str($properties,'label');
		$text=$this->_default_property_str($properties,'text');
		$forum_multi_code=$this->_default_property_str($properties,'forum_multi_code');
		$use_default_forums=$this->_default_property_int($properties,'use_default_forums');

		ocf_edit_post_template(intval($resource_id),$label,$text,$forum_multi_code,$use_default_forums);

		return true;
	}

	/**
	 * Standard modular delete function for OcCLE-fs resource hooks. Deletes the resource.
	 *
	 * @param  ID_TEXT		The filename
	 * @return boolean		Success status
	 */
	function file_delete($filename)
	{
		list($resource_type,$resource_id)=$this->file_convert_filename_to_id($filename);

		require_code('ocf_general_action2');
		ocf_delete_post_template(intval($resource_id));

		return true;
	}
}
