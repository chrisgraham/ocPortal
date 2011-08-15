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
$version = ocp_version();
$version_for_name = preg_replace('/\./','',$version);


if(!file_exists($FILE_BASE.'/data_custom/addon_files.txt'))
{
	exit("File missing : <br />".$FILE_BASE.'/data_custom/addon_files.txt');
}
if(!file_exists($FILE_BASE.'/data_custom/addons-sheet.csv'))
{
	exit("File missing : <br />".$FILE_BASE.'/data_custom/addons-sheet.csv');
}

$file_list = get_file_list_of_addons($FILE_BASE);
$addon_list = get_details_of_addons($FILE_BASE);

foreach($addon_list as $addon => $val)
{
	$file = preg_replace('#^[\_\.\-]#','x',preg_replace('#[^\w\.\-]#','_',$addon)).$version_for_name.'.tar';
	if($addon == 'proper_name')
		continue;

	foreach($val as $k => $v)
	{
		if ($k=='dependencies')
		{
			$vs=explode(',',$v);
			$v='';
			foreach ($vs as $_v)
			{
				if ((!addon_installed($_v)) || (array_key_exists($_v,$addon_list)) || (!file_exists(get_file_base().'/exports/mods/'.$_v.'.tar')) || (!file_exists(get_file_base().'/imports/mods/'.$_v.'.tar')))
				{
					if ($v!='') $v.=',';
					$v.=$_v;
				}
			}
		}
		
		$$k = $v;
	}

	$files = array();
	if(isset($file_list[$addon]))
	{
		foreach($file_list[$addon] as $f)
		{
			$files[] = $f;
		}
	}

  	create_addon($file,$files,$name,$incompatibilities,$dependencies,$author,'ocProducts Ltd', @strval($version), $description,'exports/mods',$category, $license, $attribute);
}
header('Content-type: text/plain');
echo "All addons have been exported at 'export/mods/'";


