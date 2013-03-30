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
 * @package		core_comcode_pages
 */

require_code('resource_fs');

class Hook_occle_fs_comcode_pages extends resource_fs_base
{
	var $folder_resource_type='zone';
	var $file_resource_type='comcode_page';

	/**
	 * Standard modular introspection function.
	 *
	 * @return array			The properties available for the resource type
	 */
	function _enumerate_folder_properties()
	{
		return array(
			'human_title'=>'SHORT_TRANS',
			'default_page'=>'ID_TEXT',
			'header_text'=>'SHORT_TRANS',
			'theme'=>'ID_TEXT',
			'wide'=>'BINARY',
			'require_session'=>'BINARY',
			'displayed_in_menu'=>'BINARY',
		);
	}

	/**
	 * Standard modular date fetch function for OcCLE-fs resource hooks. Defined when getting an edit date is not easy.
	 *
	 * @param  array			Resource row (not full, but does contain the ID)
	 * @return ?TIME			The edit date or add date, whichever is higher (NULL: could not find one)
	 */
	function _get_folder_edit_date($row)
	{
		$query='SELECT MAX(date_and_time) FROM '.get_table_prefix().'adminlogs WHERE '.db_string_equal_to('param_a',$row['zone_name']).' AND  ('.db_string_equal_to('the_type','ADD_ZONE').' OR '.db_string_equal_to('the_type','EDIT_ZONE').')';
		return $GLOBALS['SITE_DB']->query_value_if_there($query);
	}

	/**
	 * Standard modular add function for OcCLE-fs resource hooks. Adds some resource with the given label and properties.
	 *
	 * @param  SHORT_TEXT	Filename OR Resource label
	 * @param  string			The path (blank: root / not applicable)
	 * @param  array			Properties (may be empty, properties given are open to interpretation by the hook but generally correspond to database fields)
	 * @return ~ID_TEXT		The resource ID (false: error)
	 */
	function _folder_add($filename,$path,$properties)
	{
		list($category_resource_type,$category)=$this->folder_convert_filename_to_id($path);
		if ($category!='') return false; // Only one depth allowed for this resource type

		list($properties,$label)=$this->_folder_magic_filter($filename,$path,$properties);

		require_code('zones2');

		$human_title=$this->_default_property_str($properties,'human_title');
		if ($human_title=='') $human_title=$label;
		$default_page=$this->_default_property_str($properties,'default_page');
		if ($default_page=='') $default_page='start';
		$header_text=$this->_default_property_str($properties,'header_text');
		$theme=$this->_default_property_str($properties,'theme');
		$wide=$this->_default_property_int($properties,'wide');
		$require_session=$this->_default_property_int($properties,'require_session');
		$displayed_in_menu=$this->_default_property_int($properties,'displayed_in_menu');

		$zone=$this->_create_name_from_label($label);

		actual_add_zone($zone,$human_title,$default_page,$header_text,$theme,$wide,$require_session,$displayed_in_menu);

		return $zone;
	}

	/**
	 * Standard modular load function for OcCLE-fs resource hooks. Finds the properties for some resource.
	 *
	 * @param  SHORT_TEXT	Filename
	 * @param  string			The path (blank: root / not applicable)
	 * @return ~array			Details of the resource (false: error)
	 */
	function _folder_load($filename,$path)
	{
		list($resource_type,$resource_id)=$this->file_convert_filename_to_id($filename);

		$rows=$GLOBALS['SITE_DB']->query_select('zones',array('*'),array('zone_name'=>$resource_id),'',1);
		if (!array_key_exists(0,$rows)) return false;
		$row=$rows[0];

		return array(
			'label'=>$row['zone_name'],
			'human_title'=>$row['zone_title'],
			'default_page'=>$row['zone_default_page'],
			'header_text'=>$row['zone_header_text'],
			'theme'=>$row['zone_theme'],
			'wide'=>$row['zone_wide'],
			'require_session'=>$row['zone_require_session'],
			'displayed_in_menu'=>$row['zone_displayed_in_menu'],
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
	function folder_edit($filename,$path,$properties)
	{
		list($resource_type,$resource_id)=$this->file_convert_filename_to_id($filename);

		require_code('zones3');

		$label=$this->_default_property_str($properties,'label');
		$human_title=$this->_default_property_str($properties,'human_title');
		if ($human_title=='') $human_title=$label;
		$default_page=$this->_default_property_str($properties,'default_page');
		if ($default_page=='') $default_page='start';
		$header_text=$this->_default_property_str($properties,'header_text');
		$theme=$this->_default_property_str($properties,'theme');
		$wide=$this->_default_property_int($properties,'wide');
		$require_session=$this->_default_property_int($properties,'require_session');
		$displayed_in_menu=$this->_default_property_int($properties,'displayed_in_menu');

		$zone=$this->_create_name_from_label($label);

		actual_edit_zone($resource_id,$human_title,$default_page,$header_text,$theme,$wide,$require_session,$displayed_in_menu,$zone);

		return true;
	}

	/**
	 * Standard modular delete function for OcCLE-fs resource hooks. Deletes the resource.
	 *
	 * @param  ID_TEXT		The filename
	 * @return boolean		Success status
	 */
	function folder_delete($filename)
	{
		list($resource_type,$resource_id)=$this->folder_convert_filename_to_id($filename);

		require_code('zones2');

		actual_delete_zone($resource_id);

		return true;
	}

	/**
	 * Standard modular introspection function.
	 *
	 * @return array			The properties available for the resource type
	 */
	function _enumerate_file_properties()
	{
		return array(
			'text'=>'LONG_TRANS',
			'parent_page'=>'comcode_page',
			'validated'=>'BINARY',
			'show_as_edit'=>'BINARY',
			'meta_keywords'=>'LONG_TRANS',
			'meta_description'=>'LONG_TRANS',
			'submitter'=>'member',
			'add_date'=>'TIME',
			'edit_date'=>'?TIME',
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
		$query='SELECT MAX(date_and_time) FROM '.get_table_prefix().'adminlogs WHERE '.db_string_equal_to('param_a',$row['the_page']).' AND  '.db_string_equal_to('param_b',$row['the_zone']).' AND  ('.db_string_equal_to('the_type','COMCODE_PAGE_EDIT').')';
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
		if ($path=='') return false;

		list($category_resource_type,$category)=$this->folder_convert_filename_to_id($path);
		list($properties,$label)=$this->_file_magic_filter($filename,$path,$properties);

		$zone=$category;

		$file=$this->_create_name_from_label($label);

		$lang=get_site_default_lang();
		$parent_page=_create_name_from_label($this->_default_property_str($properties,'parent_page'));
		$validated=$this->_default_property_int_null($properties,'validated');
		if (is_null($validated)) $validated=1;
		$edit_time=$this->_default_property_int_null($properties,'edit_date');
		$add_time=$this->_default_property_int_null($properties,'add_date');
		if (is_null($add_time)) $add_time=time();
		$show_as_edit=$this->_default_property_int($properties,'show_as_edit');
		$submitter=$this->_default_property_int_null($properties,'submitter');
		if (is_null($submitter)) $submitter=get_member();
		$text=$this->_default_property_str($properties,'text');

		require_code('zones3');
		save_comcode_page($zone,$file,$lang,$text,$validated,$parent_page,$add_time,$edit_time,$show_as_edit,$submitter);

		return $zone.':'.$file;
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

		list($zone,$page)=explode(':',$resource_id,2);

		$rows=$GLOBALS['SITE_DB']->query_select('comcode_pages',array('*'),array('the_zone'=>$zone,'the_page'=>$page),'',1);
		if (!array_key_exists(0,$rows)) return false;
		$row=$rows[0];

		$text=array();
		require_code('site');
		foreach (array_keys(find_all_langs()) as $lang)
		{
			$result=_request_page($row['the_page'],$row['the_zone'],'comcode_custom',$lang,true);
			list(,,,$_lang,$path)=$result;
			if ($lang==$_lang)
				$text[$lang]=file_get_contents($path);
		}

		return array(
			'label'=>$row['the_zone'].':'.$row['the_page'],
			'text'=>$text,
			'parent_page'=>$row['p_parent_page'],
			'validated'=>$row['p_validated'],
			'show_as_edit'=>$row['p_show_as_edit'],
			'meta_keywords'=>$this->get_meta_keywords('comcode_page',$row['the_zone'].':'.$row['the_page']),
			'meta_description'=>$this->get_meta_description('comcode_page',$row['the_zone'].':'.$row['the_page']),
			'submitter'=>$row['p_submitter'],
			'add_date'=>$row['p_add_date'],
			'edit_date'=>$row['p_edit_date'],
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
		list($category_resource_type,$category)=$this->folder_convert_filename_to_id($path);
		list($resource_type,$resource_id)=$this->file_convert_filename_to_id($filename);

		$zone=$category;

		$label=$this->_default_property_str($properties,'label');
		$file=$this->_create_name_from_label($label);

		$lang=get_site_default_lang();
		$parent_page=_create_name_from_label($this->_default_property_str($properties,'parent_page'));
		$validated=$this->_default_property_int_null($properties,'validated');
		if (is_null($validated)) $validated=1;
		$edit_time=$this->_default_property_int_null($properties,'edit_date');
		$add_time=$this->_default_property_int_null($properties,'add_date');
		if (is_null($add_time)) $add_time=time();
		$show_as_edit=$this->_default_property_int($properties,'show_as_edit');
		$submitter=$this->_default_property_int_null($properties,'submitter');
		if (is_null($submitter)) $submitter=get_member();
		$text=$this->_default_property_str($properties,'text');

		require_code('zones3');
		save_comcode_page($zone,$file,$lang,$text,$validated,$parent_page,$add_time,$edit_time,$show_as_edit,$submitter,$resource_id);

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

		require_code('zones3');
		list($zone,$page)=explode(':',$resource_id,2);
		delete_ocp_page($zone,$page);

		return true;
	}
}
