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

global $NON_PAGE_SCRIPT;
$NON_PAGE_SCRIPT=1;
global $FORCE_INVISIBLE_GUEST;
$FORCE_INVISIBLE_GUEST=0;
if (!is_file($FILE_BASE.'/sources/global.php')) exit('<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">'.chr(10).'<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="EN" lang="EN"><head><title>Critical startup error</title></head><body><h1>ocPortal startup error</h1><p>The second most basic ocPortal startup file, sources/global.php, could not be located. This is almost always due to an incomplete upload of the ocPortal system, so please check all files are uploaded correctly.</p><p>Once all ocPortal files are in place, ocPortal must actually be installed by running the installer. You must be seeing this message either because your system has become corrupt since installation, or because you have uploaded some but not all files from our manual installer package: the quick installer is easier, so you might consider using that instead.</p><p>ocProducts maintains full documentation for all procedures and tools, especially those for installation. These may be found on the <a href="http://ocportal.com">ocPortal website</a>. If you are unable to easily solve this problem, we may be contacted from our website and can help resolve it for you.</p><hr /><p style="font-size: 0.8em">ocPortal is a website engine created by ocProducts.</p></body></html>'); require($FILE_BASE.'/sources/global.php');


require_code('database_action');
require_code('config2');
require_code('menus2');

require_code('developer_tools');  
require_code('database_action');

destrictify();

$octhief_type=get_option('octhief_type', true);
if(is_null($octhief_type))
{
	//add option and default value
	add_config_option('OCTHIEF_TYPE','octhief_type','list','return \'Members that are inactive, but has lots points\';','POINTSTORE','OCTHIEF_TITLE',0,'Members that are inactive, but has lots points|Members that are rich|Members that are random|Members that are in a certain usergroup');
}

$octhief_number=get_option('octhief_number', true);
if(is_null($octhief_number))
{
	//add option and default value
	add_config_option('OCTHIEF_NUMBER','octhief_number','integer','return \'1\';','POINTSTORE','OCTHIEF_TITLE');
}

$octhief_points=get_option('octhief_points', true);
if(is_null($octhief_points))
{
	//add option and default value
	add_config_option('OCTHIEF_POINTS','octhief_points','integer','return \'10\';','POINTSTORE','OCTHIEF_TITLE');
}

$octhief_group=get_option('octhief_group', true);
if(is_null($octhief_group))
{
	add_config_option('OCTHIEF_GROUP','octhief_group','usergroup','return do_lang(\'MEMBER\');','POINTSTORE','OCTHIEF_TITLE');
}

echo 'Installed';
