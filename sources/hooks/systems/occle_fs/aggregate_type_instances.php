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
 * @package		aggregate_types
 */

require_code('resource_fs');

class Hook_occle_fs_aggregate_type_instances extends resource_fs_base
{
	var $file_resource_type='aggregate_type_instance';

	/**
	 * Standard modular function for seeing how many resources are. Useful for determining whether to do a full rebuild.
	 *
	 * @param  ID_TEXT		The resource type
	 * @return integer		How many resources there are
	 */
	function get_resources_count($resource_type)
	{
		return $GLOBALS['SITE_DB']->query_select_value('aggregate_type_instances','COUNT(*)');
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
		$_ret=$GLOBALS['SITE_DB']->query_select('aggregate_type_instances',array('id'),array('aggregate_label'=>$label));
		$ret=array();
		foreach ($_ret as $r)
		{
			$ret[]=strval($r['id']);
		}
		return $ret;
	}

	/**
	 * Standard modular introspection function.
	 *
	 * @return array			The properties available for the resource type
	 */
	function _enumerate_file_properties()
	{
		return array(
			'aggregate_type'=>'ID_TEXT',
			'other_parameters'=>'LONG_TEXT',
			'add_date'=>'TIME',
			'edit_date'=>'?TIME',
		);
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

		require_code('aggregate_types');

		$aggregate_type=$this->_default_property_str($properties,'aggregate_type');
		if ($aggregate_type=='') $aggregate_type='example';
		$_other_parameters=$this->_default_property_str($properties,'other_parameters');
		$other_parameters=($_other_parameters=='')?array():unserialize($_other_parameters);
		$add_time=$this->_default_property_int_null($properties,'add_date');
		$edit_time=$this->_default_property_int_null($properties,'edit_date');

		$id=add_aggregate_type_instance($label,$aggregate_type,$other_parameters,$add_time,$edit_time,true,true);
		return strval($id);
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

		$rows=$GLOBALS['SITE_DB']->query_select('aggregate_type_instances',array('*'),array('id'=>intval($resource_id)),'',1);
		if (!array_key_exists(0,$rows)) return false;
		$row=$rows[0];

		return array(
			'label'=>$row['aggregate_label'],
			'aggregate_type'=>$row['aggregate_type'],
			'other_parameters'=>$row['other_parameters'],
			'add_date'=>$row['add_time'],
			'edit_date'=>$row['edit_time'],
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

		require_code('aggregate_types');

		$label=$this->_default_property_str($properties,'label');
		$aggregate_type=$this->_default_property_str($properties,'aggregate_type');
		if ($aggregate_type=='') $aggregate_type='example';
		$_other_parameters=$this->_default_property_str($properties,'other_parameters');
		$other_parameters=($_other_parameters=='')?array():unserialize($_other_parameters);

		edit_aggregate_type_instance(intval($resource_id),$label,$aggregate_type,$other_parameters,true);

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

		require_code('aggregate_types');
		delete_aggregate_type_instance(intval($resource_id));

		return true;
	}
}
