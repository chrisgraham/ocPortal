<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		core_addon_management
 */

// Returns the file list of an addon. addon_name=>array(files);
function get_file_list_of_addons()
{
	if (!file_exists(get_file_base().'/data_custom/addon_files.txt'))
		exit('File missing: data_custom/addon_files.txt');

	$file_list=array();
	$files=array();
	$text=file(get_file_base().'/data_custom/addon_files.txt',FILE_IGNORE_NEW_LINES);
	// echo "<pre>";print_r($text);exit();
	$key='';
	foreach ($text as $i=>$val)
	{
		if (substr($val,0,3)==' - ')
		{
			$path=substr($val,3);   // Remove ' - ' in every path
			$files[]=$path;
		}
		elseif (@$text[$i+1][0]=='-') // New block of files
		{
			if (count($files)!=0)
			{
				$file_list[$key]=$files;
				$files=array();
			}
			$key =strtolower($val);
			$key=preg_replace('/[\s_]/','_',$key);
		}
	}
	if (count($files)!=0)
	{
		$file_list[$key]=$files;
	}
	return $file_list;
}

// Returns details of the addons
function get_details_of_addons()
{
	if (!file_exists(get_file_base().'/data_custom/addon_details.csv'))
		exit('File missing: data_custom/addon_details.csv');

	$addon_list=array();
	$fd=fopen (get_file_base().'/data_custom/addon_details.csv', "r");
	$header=fgetcsv($fd, 4096);

	// Go through each CSV line of the file
	while (!feof($fd))
	{
		$buffer=fgetcsv($fd, 4096); // declare an array to hold all of the contents of each

		$properties=array();
		foreach ($header as $k=>$h)
		{
			$properties[$h]=@trim($buffer[$k]);
		}
		$addon_name=$properties['Addon name'];

		if (($addon_name!='') && (substr($addon_name,0,1)!='#'))
			$addon_list[$addon_name]=$properties;
	}
	fclose ($fd);

	$all_files=get_file_list_of_addons();
	foreach (array_keys($all_files) as $addon_name)
	{
		if (!array_key_exists($addon_name,$addon_list))
		{
			$addon_list[$addon_name]=array(
				'Addon name'=>$addon_name,
				'Author'=>'ocProducts',
				'Help'=>'',
				'Requirements / Dependencies'=>'',
				'Incompatible with'=>'',
				'Category'=>'Uncategorised/Alpha',
				'License'=>'Same as ocPortal',
				'Attribute'=>'',
				'Notes'=>''
			);
		}
	}

	return $addon_list;
}

// Returns list of category
function category_list_from_details()
{
	$categories=array();
	$addons=get_details_of_addons();
	foreach ($addons as $addon)
	{
		$categories[]=$addon['Category'];
	}

	return array_unique($categories);
}

// Insert into database if the category does not exist
function check_and_add_category($category, $parentid=1)
{
	require_code('downloads2');
	$id=$GLOBALS['SITE_DB']->query_value_null_ok('download_categories c JOIN '.get_table_prefix().'translate t ON t.id=c.category','c.id AS id',array('parent_id'=>$parentid,'t.text_original'=>$category));
	if (is_null($id))
	{
		$cat_id=add_download_category($category,$parentid,'','','');
		$all_groups=$GLOBALS['FORUM_DRIVER']->get_usergroup_list(true);
		foreach (array_keys($all_groups) as $_group_id)
		{
			$GLOBALS['SITE_DB']->query_insert('group_category_access',array('module_the_name'=>'downloads','category_name'=>strval($cat_id),'group_id'=>$_group_id));
		}
		return $cat_id;
	}
	else
		return $id;
}

// Returns the category ID of a named category
function fetch_category_id($category)
{
	$category_id=$GLOBALS['SITE_DB']->query_value_null_ok('download_categories c JOIN '.get_table_prefix().'translate t ON t.id=c.category','c.id AS id',array('parent_id'=>1,'t.text_original'=>$category));

	return $category_id;
}

function get_addons_list_under_category($category)
{
	$categories=array();
	$addons=get_details_of_addons();
	$addons_here=array();
	foreach ($addons as $k=>$addon)
	{
		if ($addon['Category']==$category) $addons_here[]=$k;
	}
	return $addons_here;
}

