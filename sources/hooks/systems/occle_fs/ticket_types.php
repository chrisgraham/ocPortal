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
 * @package		tickets
 */

require_code('content_fs');

class Hook_occle_fs_ticket_types extends content_fs_base
{
	var $file_content_type='ticket_type';

	/**
	 * Standard modular introspection function.
	 *
	 * @return array			The properties available for the content type
	 */
	function _enumerate_file_properties()
	{
		return array(
			'guest_emails_mandatory'=>'BINARY',
			'search_faq'=>'BINARY',
		);
	}

	/**
	 * Standard modular date fetch function for OcCLE-fs resource hooks. Defined when getting an edit date is not easy.
	 *
	 * @param  array			Content row (not full, but does contain the ID)
	 * @return ?TIME			The edit date or add date, whichever is higher (NULL: could not find one)
	 */
	function _get_file_edit_date($row)
	{
		$query='SELECT MAX(date_and_time) FROM '.get_table_prefix().'adminlogs WHERE '.db_string_equal_to('param_a',strval($row['id'])).' AND  ('.db_string_equal_to('the_type','ADD_TICKET_TYPE').' OR '.db_string_equal_to('the_type','EDIT_TICKET_TYPE').')';
		return $GLOBALS['SITE_DB']->query_value_if_there($query);
	}

	/**
	 * Standard modular add function for OcCLE-fs resource hooks. Adds some content with the given label and properties.
	 *
	 * @param  SHORT_TEXT	Filename OR Content label
	 * @param  string			The path (blank: root / not applicable)
	 * @param  array			Properties (may be empty, properties given are open to interpretation by the hook but generally correspond to database fields)
	 * @return ~ID_TEXT		The content ID (false: error, could not create via these properties / here)
	 */
	function file_add($filename,$path,$properties)
	{
		list($properties,$label)=$this->_file_magic_filter($filename,$path,$properties);

		require_code('tickets2');

		$guest_emails_mandatory=$this->_default_property_int($properties,'guest_emails_mandatory');
		$search_faq=$this->_default_property_int($properties,'search_faq');

		$id=add_ticket_type($label,$guest_emails_mandatory,$search_faq);
		return strval($id);
	}

	/**
	 * Standard modular load function for OcCLE-fs resource hooks. Finds the properties for some content.
	 *
	 * @param  SHORT_TEXT	Filename
	 * @param  string			The path (blank: root / not applicable)
	 * @return ~array			Details of the content (false: error)
	 */
	function _file_load($filename,$path)
	{
		list($content_type,$content_id)=$this->file_convert_filename_to_id($filename);

		$rows=$GLOBALS['SITE_DB']->query_select('ticket_types',array('*'),array('id'=>intval($content_id)),'',1);
		if (!array_key_exists(0,$rows)) return false;
		$row=$rows[0];

		return array(
			'label'=>$row['ticket_type'],
			'guest_emails_mandatory'=>$row['guest_emails_mandatory'],
			'search_faq'=>$row['search_faq'],
		);
	}

	/**
	 * Standard modular edit function for OcCLE-fs resource hooks. Edits the content to the given properties.
	 *
	 * @param  ID_TEXT		The filename
	 * @param  string			The path (blank: root / not applicable)
	 * @param  array			Properties (may be empty, properties given are open to interpretation by the hook but generally correspond to database fields)
	 * @return boolean		Success status
	 */
	function file_edit($filename,$path,$properties)
	{
		list($content_type,$content_id)=$this->file_convert_filename_to_id($filename);
		list($properties,)=$this->_file_magic_filter($filename,$path,$properties);

		require_code('tickets2');

		$label=$this->_default_property_str($properties,'label');
		$guest_emails_mandatory=$this->_default_property_int($properties,'guest_emails_mandatory');
		$search_faq=$this->_default_property_int($properties,'search_faq');

		edit_ticket_type(intval($content_id),$label,$guest_emails_mandatory,$search_faq);

		return true;
	}

	/**
	 * Standard modular delete function for OcCLE-fs resource hooks. Deletes the content.
	 *
	 * @param  ID_TEXT		The filename
	 * @return boolean		Success status
	 */
	function file_delete($filename)
	{
		list($content_type,$content_id)=$this->file_convert_filename_to_id($filename);

		require_code('tickets2');
		delete_ticket_type(intval($content_id));

		return true;
	}
}