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
	 * Standard modular function for seeing how many resources are. Useful for determining whether to do a full rebuild.
	 *
	 * @param  ID_TEXT		The resource type
	 * @return integer		How many resources there are
	 */
	function get_resources_count($resource_type)
	{
		switch ($resource_type)
		{
			case 'comcode_page':
				return $GLOBALS['SITE_DB']->query_select_value('comcode_pages','COUNT(*)');

			case 'zone':
				return $GLOBALS['SITE_DB']->query_select_value('zones','COUNT(*)');
		}
		return 0;
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
		switch ($resource_type)
		{
			case 'comcode_page':
				if (strpos($label,':')!==false)
				{
					list($zone,$page)=explode(':',$label,2);
					$where=array('the_zone'=>$zone,'the_page'=>$page);
				} else // comcode_page is the only Resource-FS hook where a codename-based-label going in may not go out. Fortunately a missing ':' fully implies that we can/should do a partial search, as no missing colon will be there for a label that ended up in-direct-use.
				{
					$page=$label;
					$where=array('the_page'=>$page);
				}

				$_ret=$GLOBALS['SITE_DB']->query_select('comcode_pages',array('the_zone','the_page'),$where);
				$ret=array();
				foreach ($_ret as $r)
				{
					$ret[]=$r['the_zone'].':'.$r['the_page'];
				}
				return $ret;

			case 'zone':
				$ret=$GLOBALS['SITE_DB']->query_select('zones',array('zone_name'),array('zone_name'=>$label));
				return collapse_1d_complexity('zone_name',$ret);
		}
		return array();
	}

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
	 * Standard modular date fetch function for resource-fs hooks. Defined when getting an edit date is not easy.
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
	 * Standard modular add function for resource-fs hooks. Adds some resource with the given label and properties.
	 *
	 * @param  LONG_TEXT		Filename OR Resource label
	 * @param  string			The path (blank: root / not applicable)
	 * @param  array			Properties (may be empty, properties given are open to interpretation by the hook but generally correspond to database fields)
	 * @return ~ID_TEXT		The resource ID (false: error)
	 */
	function folder_add($filename,$path,$properties)
	{
		if ($path!='') return false; // Only one depth allowed for this resource type

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

		$zone=actual_add_zone($zone,$human_title,$default_page,$header_text,$theme,$wide,$require_session,$displayed_in_menu,true);

		return $zone;
	}

	/**
	 * Standard modular load function for resource-fs hooks. Finds the properties for some resource.
	 *
	 * @param  SHORT_TEXT	Filename
	 * @param  string			The path (blank: root / not applicable). It may be a wildcarded path, as the path is used for content-type identification only. Filenames are globally unique across a hook; you can calculate the path using ->search.
	 * @return ~array			Details of the resource (false: error)
	 */
	function folder_load($filename,$path)
	{
		list($resource_type,$resource_id)=$this->folder_convert_filename_to_id($filename);

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
	 * Standard modular edit function for resource-fs hooks. Edits the resource to the given properties.
	 *
	 * @param  ID_TEXT		The filename
	 * @param  string			The path (blank: root / not applicable)
	 * @param  array			Properties (may be empty, properties given are open to interpretation by the hook but generally correspond to database fields)
	 * @return ~ID_TEXT		The resource ID (false: error, could not create via these properties / here)
	 */
	function folder_edit($filename,$path,$properties)
	{
		list($resource_type,$resource_id)=$this->folder_convert_filename_to_id($filename);

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

		$zone=actual_edit_zone($resource_id,$human_title,$default_page,$header_text,$theme,$wide,$require_session,$displayed_in_menu,$zone,true,true);

		return $resource_id;
	}

	/**
	 * Standard modular delete function for resource-fs hooks. Deletes the resource.
	 *
	 * @param  ID_TEXT		The filename
	 * @param  string			The path (blank: root / not applicable)
	 * @return boolean		Success status
	 */
	function folder_delete($filename,$path)
	{
		list($resource_type,$resource_id)=$this->folder_convert_filename_to_id($filename);

		require_code('zones2');

		actual_delete_zone($resource_id,true,true);

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
	 * Standard modular date fetch function for resource-fs hooks. Defined when getting an edit date is not easy.
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
	 * Standard modular add function for resource-fs hooks. Adds some resource with the given label and properties.
	 *
	 * @param  LONG_TEXT		Filename OR Resource label
	 * @param  string			The path (blank: root / not applicable)
	 * @param  array			Properties (may be empty, properties given are open to interpretation by the hook but generally correspond to database fields)
	 * @return ~ID_TEXT		The resource ID (false: error, could not create via these properties / here)
	 */
	function file_add($filename,$path,$properties)
	{
		list($category_resource_type,$category)=$this->folder_convert_filename_to_id($path);
		list($properties,$label)=$this->_file_magic_filter($filename,$path,$properties);

		if (is_null($category)) return false; // Folder not found

		$zone=$category;
		$page=$this->_create_name_from_label($label);
		$page=preg_replace('#^.*:#','',$page); // ID also contains zone, so strip that

		$lang=get_site_default_lang();
		$_parent_page=$this->_default_property_str($properties,'parent_page');
		$parent_page=($_parent_page=='')?'':$this->_create_name_from_label($_parent_page);
		$validated=$this->_default_property_int_null($properties,'validated');
		if (is_null($validated)) $validated=1;
		$edit_time=$this->_default_property_int_null($properties,'edit_date');
		$add_time=$this->_default_property_int_null($properties,'add_date');
		if (is_null($add_time)) $add_time=time();
		$show_as_edit=$this->_default_property_int($properties,'show_as_edit');
		$submitter=$this->_default_property_int_null($properties,'submitter');
		if (is_null($submitter)) $submitter=get_member();
		$text=$this->_default_property_str($properties,'text');

		$meta_keywords=$this->_default_property_str($properties,'meta_keywords');
		$meta_description=$this->_default_property_str($properties,'meta_description');

		$test=_request_page($page,$zone,NULL,NULL,true);
		if ($test!==false) $page.='_'.uniqid('',true); // Uniqify

		require_code('zones3');
		$full_path=save_comcode_page($zone,$page,$lang,$text,$validated,$parent_page,$add_time,$edit_time,$show_as_edit,$submitter,NULL,$meta_keywords,$meta_description);
		$page=basename($full_path,'.txt');

		return $zone.':'.$page;
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
		list($category_resource_type,$category)=$this->folder_convert_filename_to_id($path);

		$zone=$category;
		$page=$resource_id;
		$page=preg_replace('#^.*:#','',$page); // ID also contains zone, so strip that

		$rows=$GLOBALS['SITE_DB']->query_select('comcode_pages',array('*'),array('the_zone'=>$zone,'the_page'=>$page),'',1);
		if (!array_key_exists(0,$rows)) return false;
		$row=$rows[0];

		$text=array();
		require_code('site');
		foreach (array_keys(find_all_langs()) as $lang)
		{
			$result=_request_page($row['the_page'],$row['the_zone'],'comcode_custom',$lang,true);
			list(,,,$_lang,$full_path)=$result;
			if ($lang==$_lang)
				$text[$lang]=file_get_contents($full_path);
		}

		list($meta_keywords,$meta_description)=seo_meta_get_for('comcode_page',$row['the_zone'].':'.$row['the_page']);

		return array(
			'label'=>$row['the_zone'].':'.$row['the_page'],
			'text'=>$text,
			'parent_page'=>$row['p_parent_page'],
			'validated'=>$row['p_validated'],
			'show_as_edit'=>$row['p_show_as_edit'],
			'meta_keywords'=>$meta_keywords,
			'meta_description'=>$meta_description,
			'submitter'=>$row['p_submitter'],
			'add_date'=>$row['p_add_date'],
			'edit_date'=>$row['p_edit_date'],
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
		list($resource_type,$old_page)=$this->file_convert_filename_to_id($filename);
		list($category_resource_type,$category)=$this->folder_convert_filename_to_id($path);
		list($properties,)=$this->_file_magic_filter($filename,$path,$properties);

		if (is_null($category)) return false; // Folder not found

		$zone=$category;

		$label=$this->_default_property_str($properties,'label');
		$page=$this->_create_name_from_label($label);
		$page=preg_replace('#^.*:#','',$page); // ID also contains zone, so strip that

		$lang=get_site_default_lang();
		$parent_page=$this->_create_name_from_label($this->_default_property_str($properties,'parent_page'));
		$validated=$this->_default_property_int_null($properties,'validated');
		if (is_null($validated)) $validated=1;
		$edit_time=$this->_default_property_int_null($properties,'edit_date');
		$add_time=$this->_default_property_int_null($properties,'add_date');
		if (is_null($add_time)) $add_time=time();
		$show_as_edit=$this->_default_property_int($properties,'show_as_edit');
		$submitter=$this->_default_property_int_null($properties,'submitter');
		if (is_null($submitter)) $submitter=get_member();
		$text=$this->_default_property_str($properties,'text');

		$meta_keywords=$this->_default_property_str($properties,'meta_keywords');
		$meta_description=$this->_default_property_str($properties,'meta_description');

		if ($page!=$old_page)
		{
			$test=_request_page($page,$zone,NULL,NULL,true);
			if ($test!==false) $page.='_'.uniqid('',true); // Uniqify
		}

		require_code('zones3');
		$full_path=save_comcode_page($zone,$page,$lang,$text,$validated,$parent_page,$add_time,$edit_time,$show_as_edit,$submitter,$old_page,$meta_keywords,$meta_description);
		$page=basename($full_path,'.txt');

		return $zone.':'.$page;
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

		require_code('zones3');
		list($zone,$page)=explode(':',$resource_id,2);
		delete_ocp_page($zone,$page);

		return true;
	}
}
