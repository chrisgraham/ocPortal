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
 * @package		custom_comcode
 */

require_code('resource_fs');

class Hook_occle_fs_custom_comcode_tags extends resource_fs_base
{
	var $file_resource_type='custom_comcode_tag';

	/**
	 * Standard modular function for seeing how many resources are. Useful for determining whether to do a full rebuild.
	 *
	 * @param  ID_TEXT		The resource type
	 * @return integer		How many resources there are
	 */
	function get_resources_count($resource_type)
	{
		return $GLOBALS['SITE_DB']->query_select_value('custom_comcode','COUNT(*)');
	}

	/**
	 * Standard modular function for searching for a resource by label.
	 *
	 * @param  ID_TEXT		The resource type
	 * @param  LONG_TEXT		The resource label
	 * @return array			A list of resource IDs
	 */
	function find_resource_by_label($resource_type,$label)
	{
		$ret=$GLOBALS['SITE_DB']->query_select('custom_comcode',array('tag_tag'),array('tag_tag'=>$label));
		return collapse_1d_complexity('tag_tag',$ret);
	}

	/**
	 * Standard modular introspection function.
	 *
	 * @return array			The properties available for the resource type
	 */
	function _enumerate_file_properties()
	{
		return array(
			'title'=>'SHORT_TRANS',
			'description'=>'SHORT_TRANS',
			'replace'=>'LONG_TEXT',
			'example'=>'LONG_TEXT',
			'parameters'=>'SHORT_TEXT',
			'enabled'=>'BINARY',
			'dangerous_tag'=>'BINARY',
			'block_tag'=>'BINARY',
			'textual_tag'=>'BINARY'
		);
	}

	/**
	 * Standard modular date fetch function for resource-fs hooks. Defined when getting an edit date is not easy.
	 *
	 * @param  array			Resource row (not full, but does contain the ID)
	 * @return ?TIME			The edit date or add date, whichever is higher (NULL: could not find one)
	 */
	function _get_file_edit_date($row)
	{
		$query='SELECT MAX(date_and_time) FROM '.get_table_prefix().'adminlogs WHERE '.db_string_equal_to('param_a',$row['tag_tag']).' AND  ('.db_string_equal_to('the_type','ADD_CUSTOM_COMCODE_TAG').' OR '.db_string_equal_to('the_type','EDIT_CUSTOM_COMCODE_TAG').')';
		return $GLOBALS['SITE_DB']->query_value_if_there($query);
	}

	/**
	 * Standard modular add function for resource-fs hooks. Adds some resource with the given label and properties.
	 *
	 * @param  LONG_TEXT		Filename OR Resource label
	 * @param  string			The path (blank: root / not applicable)
	 * @param  array			Properties (may be empty, properties given are open to interpretation by the hook but generally correspond to database fields)
	 * @return ~ID_TEXT		The resource ID (false: error, could not create via these properties / here)
	 */
	function file_add($filename,$path,$properties)
	{
		list($properties,$label)=$this->_file_magic_filter($filename,$path,$properties);

		$tag=$this->_create_name_from_label($label);
		$title=$this->_default_property_str($properties,'title');
		$description=$this->_default_property_str($properties,'description');
		$replace=$this->_default_property_str($properties,'replace');
		$example=$this->_default_property_str($properties,'example');
		$parameters=$this->_default_property_str($properties,'parameters');
		$enabled=$this->_default_property_int($properties,'enabled');
		$dangerous_tag=$this->_default_property_int($properties,'dangerous_tag');
		$block_tag=$this->_default_property_int($properties,'block_tag');
		$textual_tag=$this->_default_property_int($properties,'textual_tag');

		require_code('custom_comcode');
		$tag=add_custom_comcode_tag($tag,$title,$description,$replace,$example,$parameters,$enabled,$dangerous_tag,$block_tag,$textual_tag,true);

		return $tag;
	}

	/**
	 * Standard modular load function for resource-fs hooks. Finds the properties for some resource.
	 *
	 * @param  SHORT_TEXT	Filename
	 * @param  string			The path (blank: root / not applicable). It may be a wildcarded path, as the path is used for content-type identification only. Filenames are globally unique across a hook; you can calculate the path using ->search.
	 * @return ~array			Details of the resource (false: error)
	 */
	function file_load($filename,$path)
	{
		list($resource_type,$resource_id)=$this->file_convert_filename_to_id($filename);

		$rows=$GLOBALS['SITE_DB']->query_select('custom_comcode',array('*'),array('tag_tag'=>$resource_id),'',1);
		if (!array_key_exists(0,$rows)) return false;
		$row=$rows[0];

		return array(
			'label'=>$row['tag_tag'],
			'title'=>$row['tag_title'],
			'description'=>$row['tag_description'],
			'replace'=>$row['tag_replace'],
			'example'=>$row['tag_example'],
			'parameters'=>$row['tag_parameters'],
			'enabled'=>$row['tag_enabled'],
			'dangerous_tag'=>$row['tag_dangerous_tag'],
			'block_tag'=>$row['tag_block_tag'],
			'textual_tag'=>$row['tag_textual_tag']
		);
	}

	/**
	 * Standard modular edit function for resource-fs hooks. Edits the resource to the given properties.
	 *
	 * @param  ID_TEXT		The filename
	 * @param  string			The path (blank: root / not applicable)
	 * @param  array			Properties (may be empty, properties given are open to interpretation by the hook but generally correspond to database fields)
	 * @return ~ID_TEXT		The resource ID (false: error, could not create via these properties / here)
	 */
	function file_edit($filename,$path,$properties)
	{
		list($resource_type,$resource_id)=$this->file_convert_filename_to_id($filename);
		list($properties,)=$this->_file_magic_filter($filename,$path,$properties);

		$label=$this->_default_property_str($properties,'label');
		$tag=$this->_create_name_from_label($label);
		$title=$this->_default_property_str($properties,'title');
		$description=$this->_default_property_str($properties,'description');
		$replace=$this->_default_property_str($properties,'replace');
		$example=$this->_default_property_str($properties,'example');
		$parameters=$this->_default_property_str($properties,'parameters');
		$enabled=$this->_default_property_int($properties,'enabled');
		$dangerous_tag=$this->_default_property_int($properties,'dangerous_tag');
		$block_tag=$this->_default_property_int($properties,'block_tag');
		$textual_tag=$this->_default_property_int($properties,'textual_tag');

		$_title=$GLOBALS['SITE_DB']->query_select_value('custom_comcode','tag_title',array('tag_tag'=>$resource_id));
		$_description=$GLOBALS['SITE_DB']->query_select_value('custom_comcode','tag_description',array('tag_tag'=>$resource_id));

		$tag=edit_custom_comcode_tag($resource_id,$tag,$title,$description,$replace,$example,$parameters,$enabled,$dangerous_tag,$block_tag,$textual_tag,true);

		return $resource_id;
	}

	/**
	 * Standard modular delete function for resource-fs hooks. Deletes the resource.
	 *
	 * @param  ID_TEXT		The filename
	 * @param  string			The path (blank: root / not applicable)
	 * @return boolean		Success status
	 */
	function file_delete($filename,$path)
	{
		list($resource_type,$resource_id)=$this->file_convert_filename_to_id($filename);

		delete_custom_comcode_tag($resource_id);

		return true;
	}
}
