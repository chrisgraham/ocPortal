<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2011

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		core_addon_management
 */

// returns the file list of an addon. addon_name => array(files);

function get_file_list_of_addons($FILE_BASE)
{
	if (!file_exists($FILE_BASE.'/data_custom/addon_files.txt'))
		exit("File missing : <br />".$FILE_BASE.'/data_custom/addon_files.txt');

	$file_list = array();
	$files = array();
	$text = file($FILE_BASE.'/data_custom/addon_files.txt',FILE_IGNORE_NEW_LINES);
	// echo "<pre>";print_r($text);exit();
	$key = '';
	foreach($text as $i=>$val)
	{
		if (strpos($val,'-') !== 0 && $val != '')
		{
			if (strpos($val,'#') !== false)
			{
				$path = substr($val,4);   // Remove '# # ' in every path
				$files[] = $path;
			}
			elseif (@$text[$i+1][0]=='-') // New block of files
			{
				if (count($files))
				{
					$file_list[$key] = $files;
					$files = array();
				}
				$key =strtolower($val);
				$key = preg_replace('/[\s_]/','_',$key);
			}
		}
	}
	if (count($files))
	{
		$file_list[$key] = $files;
	}
	return $file_list;
}



// returns details of the addons
function get_details_of_addons($FILE_BASE)
{
	if (!file_exists($FILE_BASE.'/data_custom/addons-sheet.csv'))
		exit("File missing : <br />".$FILE_BASE.'/data_custom/addons-sheet.csv');

	$map = array(0 => 'name', 1 => 'author', 7 => 'description', 10 => 'dependencies', 11 => 'incompatibilities', 12 => 'category', 14 => 'license', 17 => 'attribute');
	$addon_list = array();
	$fd = fopen ($FILE_BASE.'/data_custom/addons-sheet.csv', "r");
	fgetcsv($fd, 4096); // Skip first (header)
	// initialize a loop to go through each line of the file
	while (!feof($fd))
	{
		$buffer = fgetcsv($fd, 4096); // declare an array to hold all of the contents of each

		$temp = array();
		foreach($map as $k => $v)
		{
			$temp[$v] = @trim($buffer[$k]);
		}
		$addon_name = @strtolower(trim($buffer[0]));
		$addon_name = preg_replace('/[\s_]/','_',$addon_name);

		if (($addon_name!='') && (substr($addon_name,0,1)!='#'))
			$addon_list[$addon_name] = $temp;
	}
	fclose ($fd);
	return $addon_list;
}

// returns list of category
function category_list_from_details($FILE_BASE)
{
	if (!file_exists($FILE_BASE.'/data_custom/addons-sheet.csv'))
		exit("File missing : <br />".$FILE_BASE.'/data_custom/addons-sheet.csv');

	$category_list = array();
	$fd = fopen ($FILE_BASE.'/data_custom/addons-sheet.csv', "r");
	fgetcsv($fd, 4096); // Skip first (header)
	// initialize a loop to go through each line of the file
	while (!feof($fd))
	{
		$buffer = fgetcsv($fd, 4096); // declare an array to hold all of the contents of each
		if (!in_array($buffer[12], $category_list) && $buffer[12] != '' )
		{
			$category_list[] = $buffer[12];
		}
	}
	return $category_list;
}

// insert into db if the category does not exist
function check_and_add_category($category, $parentid = 1)
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

// Retuens the category id
function fetch_category_id($category)
{
	$category_id=$GLOBALS['SITE_DB']->query_value_null_ok('download_categories c JOIN '.get_table_prefix().'translate t ON t.id=c.category','c.id AS id',array('parent_id'=>1,'t.text_original'=>$category));

	return $category_id;
}

function get_addons_list_under_category($category, $FILE_BASE)
{
	if (!file_exists($FILE_BASE.'/data_custom/addons-sheet.csv'))
		exit("File missing : <br />".$FILE_BASE.'/data_custom/addons-sheet.csv');

	$addon_list = array();
	$fd = fopen ($FILE_BASE.'/data_custom/addons-sheet.csv', "r");
	fgetcsv($fd, 4096); // Skip first (header)
	// initialize a loop to go through each line of the file
	while (!feof($fd))
	{
		$buffer = fgetcsv($fd, 4096); // declare an array to hold all of the contents of each

		if ($buffer[12] == $category)
		{
			$addon_name = @strtolower(trim($buffer[0]));
			$addon_name = preg_replace('/[\s_]/','_',$addon_name);

			if (($addon_name!='') && (substr($addon_name,0,1)!='#'))
				$addon_list[] = $addon_name;
		}
	}
	fclose ($fd);
	return $addon_list;
}

function get_basic_details_of_addons($category, $FILE_BASE)
{
	if (!file_exists($FILE_BASE.'/data_custom/addons-sheet.csv'))
		exit("File missing : <br />".$FILE_BASE.'/data_custom/addons-sheet.csv');

	$map = array(0 => 'name', 1 => 'author', 7 => 'description', 10 => 'dependencies', 11 => 'incompatibilities', 12 => 'category', 14 => 'license', 17 => 'attribute');
	$addon_list = array();
	$fd = fopen ($FILE_BASE.'/data_custom/addons-sheet.csv', "r");
	fgetcsv($fd, 4096); // Skip first (header)
	// initialize a loop to go through each line of the file
	while (!feof($fd))
	{
		$buffer = fgetcsv($fd, 4096); // declare an array to hold all of the contents of each

		if ($buffer[12] == $category)
		{
			$temp = array();
			foreach($map as $k => $v)
			{
				$temp[$v] = @trim($buffer[$k]);
			}
			$addon_name = @strtolower(trim($buffer[0]));
			$addon_name = preg_replace('/[\s_]/','_',$addon_name);
		
			if (($addon_name!='') && (substr($addon_name,0,1)!='#'))
				$addon_list[$addon_name] = $temp;
		}
	}
	fclose ($fd);
	return $addon_list;
}



