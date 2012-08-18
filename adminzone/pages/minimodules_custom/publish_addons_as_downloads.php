<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

define('DOWNLOAD_OWNER',2); // Hard-coded ID of user that gets ownership of the downloads

require_code('addons');
require_code('dump_addons');
require_code('version');
require_code('version2');
require_code('downloads2');

$get_cat=get_param('cat',NULL);
if ($get_cat===NULL)
{
	exit('Please pass the category name in the URL (?cat=name).');
}
$version_branch=get_param('version_branch',NULL);
if ($version_branch===NULL)
{
	exit('Please pass the branch version in the URL (?version_branch=num.x).');
}

$addon_list=get_details_of_addons();

$parent_id=$GLOBALS['SITE_DB']->query_select_value_if_there('download_categories c JOIN '.get_table_prefix().'translate t ON t.id=c.category','c.id AS id',array('parent_id'=>1,'t.text_original'=>'Addons'));
$c_main_id=find_addon_category_download_category($get_cat,$parent_id);

if (get_param_integer('import_addons',1)==1)
{
	$addon_count=0;
	$categories=find_addon_category_list();
	foreach ($categories as $category)
	{
		$cid=find_addon_category_download_category($category,$c_main_id);
		$addon_arr=get_addons_list_under_category($category);
		foreach ($addon_arr as $addon)
		{
			$addon_count++;

			$file=$addon.'-'.$version_branch.'.tar';
			$from=get_custom_file_base().'/exports/addons/'.$addon.'-'.$version_branch.'.tar';
			$to=get_custom_file_base().'/uploads/downloads/'.$file;
			@unlink($to);
			if (!file_exists($from)) warn_exit('Missing: '.$from);
			if (!file_exists($to)) copy($from,$to);
			$addon_path='uploads/downloads/'.$file;

			$fsize=filesize($addon_path);

			$test=$GLOBALS['SITE_DB']->query_select_value_if_there('download_downloads','url',array('url'=>$addon_path));
			if (is_null($test))
			{
				$name=titleify($addon_list[$addon]['Addon name']);
				$author=$addon_list[$addon]['Author'];
				$description=$addon_list[$addon]['Help'];
				$dependencies=$addon_list[$addon]['Requirements / Dependencies'];
				$incompatibilities=$addon_list[$addon]['Incompatible with'];
				$category=$addon_list[$addon]['Category'];
				$license=$addon_list[$addon]['License'];
				$attribute=$addon_list[$addon]['Attribute'];

				if ($dependencies!='') $description.='

[title="2"]System Requirements / Dependencies[/title]

'.$dependencies;
			if ($incompatibilities!='') $description.='

[title="2"]Incompatibilities[/title]

'.$incompatibilities;
			if ($license!='') $description.='

[title="2"]License[/title]

'.$license;
			if ($attribute!='') $description.='

[title="2"]Additional credits/attributions[/title]

'.$attribute;
				$download_id=add_download($cid,$name,$addon_path,$description,$author,'',NULL,1,1,2,1,'',$addon.'.tar',$fsize,0,0,NULL,NULL,0,0,DOWNLOAD_OWNER);

				$url='data_custom/addon_screenshots/'.$addon.'.png';
				if (file_exists(get_custom_file_base().'/'.$url))
					add_image('','download_'.strval($download_id),'',$url,'',1,0,0,0,'',NULL,NULL,NULL,0);
			}
		}
	}

	echo ($addon_count==0)?'<p>No addons to import</p>':'<p>All addons have been imported as downloads</p>';
}

// Now themes

if (get_param_integer('import_themes',1)==1)
{
	$cid=find_addon_category_download_category('Themes',$c_main_id);
	$cid=find_addon_category_download_category('Professional Themes',$cid);

	$dh=opendir(get_custom_file_base().'/exports/addons');
	$theme_count=0;
	while (($file=readdir($dh))!==false)
	{
		if (preg_match('#^theme-.*\.tar$#',$file)!=0)
		{
			$theme_count++;

			$from=get_custom_file_base().'/exports/addons/'.$file;
			$new_file=basename($file,'.tar').'-'.$version_branch.'.tar';
			$to=get_custom_file_base().'/uploads/downloads/'.$new_file;
			@unlink($to);
			copy($from,$to);
			$addon_path='uploads/downloads/'.$new_file;

			$fsize=filesize($addon_path);

			$test=$GLOBALS['SITE_DB']->query_select_value_if_there('download_downloads','url',array('url'=>$addon_path));
			if (is_null($test))
			{
				require_code('tar');
				$tar=tar_open($from,'rb');
				$info_file=tar_get_file($tar,'addon.inf',true);
				$info=better_parse_ini_file(NULL,$info_file['data']);
				tar_close($tar);

				$name=$info['name'];
				$description=str_replace('\n',"\n",$info['description']);
				$author=$info['author'];

				$url='data_custom/addon_screenshots/'.preg_replace('#^theme-#','theme__',preg_replace('#\d+$#','',basename($file,'.tar'))).'.png';
				if (!file_exists(get_custom_file_base().'/'.$url)) $url='data_custom/addon_screenshots/'.strtolower(preg_replace('#^theme-#','theme__',preg_replace('#\d+$#','',basename($file,'.tar')))).'.png';

				$download_id=add_download($cid,$name,$addon_path,$description,$author,'',NULL,1,1,2,1,'',$new_file,$fsize,0,0,NULL,NULL,0,0,DOWNLOAD_OWNER);

				if (file_exists(get_custom_file_base().'/'.$url))
					add_image('','download_'.strval($download_id),'',str_replace(' ','%20',$url),'',1,0,0,0,'',NULL,NULL,NULL,0);
			}
		}
	}
	closedir($dh);

	echo ($theme_count==0)?'<p>No themes to import</p>':'<p>All themes have been imported as downloads</p>';
}
