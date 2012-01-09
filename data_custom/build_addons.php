<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2011

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
require_code('version');
require_code('dump_addons');
$version=ocp_version_number();
$version_for_name=preg_replace('/\./','',float_to_raw_string($version));

header('Content-type: text/plain');

if (!file_exists($FILE_BASE.'/data_custom/addon_files.txt'))
{
	exit("File missing : <br />".$FILE_BASE.'/data_custom/addon_files.txt');
}
if (!file_exists($FILE_BASE.'/data_custom/addons-sheet.csv'))
{
	exit("File missing : <br />".$FILE_BASE.'/data_custom/addons-sheet.csv');
}

@set_time_limit(0);

if (get_param_integer('export_bundled_addons',1)==1)
{
	$addons=find_all_hooks('systems','addon_registry');
	foreach (array_keys($addons) as $name)
	{
		$addon_row=read_addon_info($name);

		// Archive it off to exports/mods
		if (file_exists(get_file_base().'/sources/hooks/systems/addon_registry/'.$name.'.php')) // New ocProducts style (assumes maintained by ocProducts if it's done like this)
		{
			$file=preg_replace('#^[\_\.\-]#','x',preg_replace('#[^\w\.\-]#','_',$name)).'.tar';
		} else // Traditional ocPortal style
		{
			$file=preg_replace('#^[\_\.\-]#','x',preg_replace('#[^\w\.\-]#','_',$name)).date('-dmY-Hm',time()).'.tar';
		}
		
		$new_addon_files=array();
		foreach ($addon_row['addon_files'] as $_file)
		{
			if (substr($_file,-9)!='.editfrom') // This would have been added back in automatically
				$new_addon_files[]=$_file;
		}

		create_addon($file,$new_addon_files,$addon_row['addon_name'],implode(',',$addon_row['addon_incompatibilities']),implode(',',$addon_row['addon_dependencies']),$addon_row['addon_author'],$addon_row['addon_organisation'],$addon_row['addon_version'],$addon_row['addon_description'],'exports/mods');
	}
	echo "All bundled addons have been exported to 'export/mods/'\n";
}

if (get_param_integer('export_addons',1)==1)
{
	$file_list=get_file_list_of_addons();
	$addon_list=get_details_of_addons();
	
	foreach ($file_list as $addon => $files)
	{
		if ($addon == 'proper_name')
			continue;
	
		if (!isset($addon_list[$addon]))
		{
			$addon_list[$addon]=array(
				'name' => $addon,
				'incompatibilities' => '',
				'dependencies' => '',
				'author' => 'ocProducts',
				'version' => '1.0',
				'description' => '',
			);
		}
	
		$val=$addon_list[$addon];
	
		$file=preg_replace('#^[\_\.\-]#','x',preg_replace('#[^\w\.\-]#','_',$addon)).$version_for_name.'.tar';
	
		$name = $addon_list[$addon]['Addon name'];
		$author = $addon_list[$addon]['Author'];
		$description = $addon_list[$addon]['Help'];
		$dependencies = $addon_list[$addon]['Requirements / Dependencies'];
		$incompatibilities = $addon_list[$addon]['Incompatible with'];
		$category = $addon_list[$addon]['Category'];
		$license = $addon_list[$addon]['License'];
		$attribute = $addon_list[$addon]['Attribute'];

		// Formalise dependencies
		$vs=explode(',',$dependencies);
		$dependencies='';
		foreach ($vs as $_v)
		{
			if ((!addon_installed($_v)) || (array_key_exists($_v,$addon_list)) || (!file_exists(get_file_base().'/exports/mods/'.$_v.'.tar')) || (!file_exists(get_file_base().'/imports/mods/'.$_v.'.tar')))
			{
				if ($dependencies!='') $dependencies.=',';
				$dependencies.=$_v;
			}
		}

		create_addon($file,$files,$name,$incompatibilities,$dependencies,$author,'ocProducts Ltd', @strval($version), $description,'exports/mods');
	}
	echo "All non-bundled addons have been exported to 'export/mods/'\n";
}

if (get_param_integer('export_themes',1)==1)
{
	require_code('themes2');
	require_code('files2');
	$themes=find_all_themes();
	
	$page_files=get_directory_contents(get_custom_file_base().'/','');
	foreach (array_keys($themes) as $theme)
	{
		if ($theme=='default') continue;
		
		$name='';
		$description='';
		$author='ocProducts';
		$ini_file=(($theme=='default')?get_file_base():get_custom_file_base()).'/themes/'.filter_naughty($theme).'/theme.ini';
		if (file_exists($ini_file))
		{
			$details=better_parse_ini_file($ini_file);
			if (array_key_exists('title',$details)) $name=$details['title'];
			if (array_key_exists('description',$details)) $description=$details['description'];
			if ((array_key_exists('author',$details)) && ($details['author']!='admin')) $author=$details['author'];
		}
	
		$file='theme-'.preg_replace('#^[\_\.\-]#','x',preg_replace('#[^\w\.\-]#','_',$theme)).$version_for_name.'.tar';
	
		$files2=array();
		$theme_files=get_directory_contents(get_custom_file_base().'/themes/'.$theme,'themes/'.$theme);
		foreach ($theme_files as $file2)
		{
			if ((substr($file2,-4)!='.tcp') && (substr($file2,-4)!='.tcd') && (substr($file2,-9)!='.editfrom'))
				$files2[]=$file2;
		}
		foreach ($page_files as $file2)
		{
			$matches=array();
			$regexp='#^((\w+)/)?pages/comcode_custom/[^/]*/'.str_replace('#','\#',preg_quote($theme)).'\_\_([\w\_]+)\.txt$#';
			if ((preg_match($regexp,$file2,$matches)!=0) && ($matches[1]!='docs'.strval(ocp_version())))
			{
				$files2[]=dirname($file2).'/'.substr(basename($file2),strlen($theme)+2);
			}
		}
		$_GET['keep_theme_test']='1';
		$_GET['theme']=$theme;
		create_addon($file,$files2,$name,'','',$author,'ocProducts Ltd','1.0',$description,'exports/mods');
	}
	
	echo "All themes have been exported to 'export/mods/'";
}
