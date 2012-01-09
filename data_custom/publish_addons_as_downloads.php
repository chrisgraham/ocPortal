<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 */

// FIX PATH
global $FILE_BASE,$RELATIVE_PATH;
$FILE_BASE=(strpos(__FILE__,'./')===false)?__FILE__:realpath(__FILE__);
$FILE_BASE=str_replace('\\\\','\\',$FILE_BASE);
if (substr($FILE_BASE,-4)=='.php')
{
	$a=strrpos($FILE_BASE,'/');
	if ($a===false) $a=0;
	$b=strrpos($FILE_BASE,'\\');
	if ($b===false) $b=0;
	$FILE_BASE=substr($FILE_BASE,0,($a>$b)?$a:$b);
}
if (!is_file($FILE_BASE.'/sources/global.php'))
{
	$a=strrpos($FILE_BASE,'/');
	if ($a===false) $a=0;
	$b=strrpos($FILE_BASE,'\\');
	if ($b===false) $b=0;
	$RELATIVE_PATH=substr($FILE_BASE,(($a>$b)?$a:$b)+1);
	$FILE_BASE=substr($FILE_BASE,0,($a>$b)?$a:$b);
} else
{
	$RELATIVE_PATH='';
}

@chdir($FILE_BASE);

if (!is_file($FILE_BASE.'/sources/global.php')) exit('<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">'.chr(10).'<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="EN" lang="EN"><head><title>Critical startup error</title></head><body><h1>ocPortal startup error</h1><p>The second most basic ocPortal startup file, sources/global.php, could not be located. This is almost always due to an incomplete upload of the ocPortal system, so please check all files are uploaded correctly.</p><p>Once all ocPortal files are in place, ocPortal must actually be installed by running the installer. You must be seeing this message either because your system has become corrupt since installation, or because you have uploaded some but not all files from our manual installer package: the quick installer is easier, so you might consider using that instead.</p><p>ocProducts maintains full documentation for all procedures and tools, especially those for installation. These may be found on the <a href="http://ocportal.com">ocPortal website</a>. If you are unable to easily solve this problem, we may be contacted from our website and can help resolve it for you.</p><hr /><p style="font-size: 0.8em">ocPortal is a website engine created by ocProducts.</p></body></html>'); 

require($FILE_BASE.'/sources/global.php');
require_code('addons');
require_code('dump_addons');
require_code('version');
require_code('downloads2');
$version = ocp_version_number();
$version_for_name = preg_replace('/\./','',float_to_raw_string($version));

$get_cat = get_param('cat',NULL);
if($get_cat === NULL)
{
	exit("Please pass the category name in the URL (?cat=name).");
}

// $file_list = get_file_list_of_addons();
$addon_list = get_details_of_addons();

$parent_id=$GLOBALS['SITE_DB']->query_value_null_ok('download_categories c JOIN '.get_table_prefix().'translate t ON t.id=c.category','c.id AS id',array('parent_id'=>1,'t.text_original'=>'Addons'));
$c_main_id = check_and_add_category($get_cat,$parent_id);

/*$cat_id=add_download_category('Themes',$c_main_id,'','','');
$all_groups=$GLOBALS['FORUM_DRIVER']->get_usergroup_list(true);
foreach (array_keys($all_groups) as $_group_id)
{
	$GLOBALS['SITE_DB']->query_insert('group_category_access',array('module_the_name'=>'downloads','category_name'=>strval($cat_id),'group_id'=>$_group_id));
}*/

header('Content-type: text/plain');

$admin=2;

if (get_param_integer('import_addons',1)==1)
{
	$categories = category_list_from_details();
	//if(!is_dir("uploads/downloads/$get_cat"))
	//	mkdir("uploads/downloads/$get_cat");
	foreach($categories as $category)
	{
		$cid = check_and_add_category($category, $c_main_id);
	// exit('id : '.$cid);
		$addon_arr = get_addons_list_under_category($category);
		foreach($addon_arr as $addon)
		{
			$file = $addon.$version_for_name.'.tar';
			$from = get_custom_file_base().'/exports/mods/'.$addon.$version_for_name.'.tar';
			$to = get_custom_file_base()."/uploads/downloads/".$file;
			@unlink($to);
			copy($from, $to);
			$addon_path = 'uploads/downloads/'.$file;
		
			$fsize = filesize($addon_path);
			
			$test=$GLOBALS['SITE_DB']->query_value_null_ok('download_downloads','url',array('url'=>$addon_path));
			if (is_null($test))
			{
				$name = $addon_list[$addon]['Addon name'];
				$author = $addon_list[$addon]['Author'];
				$description = $addon_list[$addon]['Help'];
				$dependencies = $addon_list[$addon]['Requirements / Dependencies'];
				$incompatibilities = $addon_list[$addon]['Incompatible with'];
				$category = $addon_list[$addon]['Category'];
				$license = $addon_list[$addon]['License'];
				$attribute = $addon_list[$addon]['Attribute'];

				if ($dependencies!='') $description .= "
	
[title=\"2\"]System Requirements / Dependencies[/title]

$dependencies";
			if ($incompatibilities!='') $description .= "

[title=\"2\"]Incompatibilities[/title]

$incompatibilities";
			if ($license!='') $description .= "

[title=\"2\"]License[/title]

$license";
			if ($attribute!='') $description .= "

[title=\"2\"]Additional credits/attributions[/title]

$attribute";
				$downid = add_download($cid,$name,$addon_path,$description,$author,'',NULL,1,1,2,1,'',$addon.'.tar',$fsize,0,0,NULL,NULL,0,0,$admin);
				
				$url = "data_custom/addon_screenshots/".$name.".png";
				if (!file_exists(get_custom_file_base().'/'.$url)) $url = "data_custom/addon_screenshots/".strtolower($name).".png";
				if (!file_exists(get_custom_file_base().'/'.$url)) $url = "data_custom/addon_screenshots/".$addon.".png";
				if (file_exists(get_custom_file_base().'/'.$url))
					add_image('','download_'.strval($downid),'',str_replace(' ','%20',$url),'',1,0,0,0,'',NULL,NULL,NULL,0);
			}
		}
	}
	
	echo "All addons have been imported as downloads";
}

// Now themes

if (get_param_integer('import_themes',1)==1)
{
	$cid = check_and_add_category('Themes', $c_main_id);
	$cid = check_and_add_category('Professional Themes', $cid);
	
	$dh=opendir(get_custom_file_base().'/exports/mods');
	while (($file=readdir($dh))!==false)
	{
		if (preg_match('#^theme-.*\.tar$#',$file)!=0)
		{
			$from = get_custom_file_base().'/exports/mods/'.$file;
			$new_file = basename($file,'.tar').$version_for_name.'.tar';
			$to = get_custom_file_base()."/uploads/downloads/".$new_file;
			@unlink($to);
			copy($from, $to);
			$addon_path = 'uploads/downloads/'.$new_file;
	
			$fsize = filesize($addon_path);
	
			$test=$GLOBALS['SITE_DB']->query_value_null_ok('download_downloads','url',array('url'=>$addon_path));
			if (is_null($test))
			{
				require_code('tar');
				$tar=tar_open($from,'rb');
				$info_file=tar_get_file($tar,'mod.inf',true);
				$info=better_parse_ini_file(NULL,$info_file['data']);
				tar_close($tar);
	
				$name=$info['name'];
				$description=str_replace('\n',"\n",$info['description']);
				$author=$info['author'];
				
				$url = "data_custom/addon_screenshots/".preg_replace('#^theme-#','theme__',preg_replace('#\d+$#','',basename($file,'.tar'))).".png";
				if (!file_exists(get_custom_file_base().'/'.$url)) $url = "data_custom/addon_screenshots/".strtolower(preg_replace('#^theme-#','theme__',preg_replace('#\d+$#','',basename($file,'.tar')))).".png";

				$downid = add_download($cid,$name,$addon_path,$description,$author,'',NULL,1,1,2,1,'',$new_file,$fsize,0,0,NULL,NULL,0,0,$admin);

				if (file_exists(get_custom_file_base().'/'.$url))
					add_image('','download_'.strval($downid),'',str_replace(' ','%20',$url),'',1,0,0,0,'',NULL,NULL,NULL,0);
			}
		}
	}
	closedir($dh);
	
	echo "All themes have been imported as downloads";
}
