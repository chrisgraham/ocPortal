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
 * @package		chat
 */

require_code('resource_fs');

class Hook_occle_fs_chat extends resource_fs_base
{
	var $file_resource_type='chat';

	/**
	 * Standard modular introspection function.
	 *
	 * @return array			The properties available for the resource type
	 */
	function _enumerate_file_properties()
	{
		return array(
			'welcome_message'=>'LONG_TRANS',
			'room_owner'=>'member',
			'allow'=>'SHORT_TEXT',
			'allow_groups'=>'SHORT_TEXT',
			'disallow'=>'SHORT_TEXT',
			'disallow_groups'=>'SHORT_TEXT',
			'room_lang'=>'LANGUAGE_NAME',
			'is_im'=>'BINARY',
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
		$query='SELECT MAX(date_and_time) FROM '.get_table_prefix().'adminlogs WHERE '.db_string_equal_to('param_a',strval($row['id'])).' AND  ('.db_string_equal_to('the_type','ADD_CHATROOM').' OR '.db_string_equal_to('the_type','EDIT_CHATROOM').')';
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

		require_code('chat2');

		$welcome=$this->_default_property_str($properties,'welcome_message');
		$room_owner=$this->_default_property_int_null($properties,'room_owner');
		$allow2=$this->_default_property_str($properties,'allow');
		$allow2_groups=$this->_default_property_str($properties,'allow_groups');
		$disallow2=$this->_default_property_str($properties,'disallow');
		$disallow2_groups=$this->_default_property_str($properties,'disallow_groups');
		$roomlang=$this->_default_property_str($properties,'room_lang');
		if ($roomlang=='') $roomlang=get_site_default_lang();
		$is_im=$this->_default_property_int($properties,'is_im');

		$id=add_chatroom($welcome,$label,$room_owner,$allow2,$allow2_groups,$disallow2,$disallow2_groups,$roomlang,$is_im);
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

		$rows=$GLOBALS['SITE_DB']->query_select('chat_rooms',array('*'),array('id'=>intval($resource_id)),'',1);
		if (!array_key_exists(0,$rows)) return false;
		$row=$rows[0];

		return array(
			'label'=>$row['room_name'],
			'welcome_message'=>$row['welcome_message'],
			'room_owner'=>$row['room_owner'],
			'allow'=>$row['allow_list'],
			'allow_groups'=>$row['allow_list_groups'],
			'disallow'=>$row['disallow_list'],
			'disallow_groups'=>$row['disallow_list_groups'],
			'room_lang'=>$row['room_lang'],
			'is_im'=>$row['is_im'],
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

		require_code('chat2');

		$label=$this->_default_property_str($properties,'label');
		$welcome=$this->_default_property_str($properties,'welcome_message');
		$room_owner=$this->_default_property_int_null($properties,'room_owner');
		$allow2=$this->_default_property_str($properties,'allow');
		$allow2_groups=$this->_default_property_str($properties,'allow_groups');
		$disallow2=$this->_default_property_str($properties,'disallow');
		$disallow2_groups=$this->_default_property_str($properties,'disallow_groups');
		$roomlang=$this->_default_property_str($properties,'room_lang');
		if ($roomlang=='') $roomlang=get_site_default_lang();
		$is_im=$this->_default_property_int($properties,'is_im');

		edit_chatroom(intval($resource_id),$welcome,$label,$room_owner,$allow2,$allow2_groups,$disallow2,$disallow2_groups,$roomlang);

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

		require_code('chat2');
		delete_chatroom(intval($resource_id));

		return true;
	}
}
