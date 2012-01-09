<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		core
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
require_css('global');
$out=get_dropbox_dir();



function get_dropbox_dir()
{
	require_code('developer_tools');
	destrictify();

	//get/set login details
	$hash=get_param('hash');
	$dbemail=get_value('db_username_'.$hash);
	$dbpassword=get_value('db_password_'.$hash);
	$sub_dir=get_value('db_sub_dir_'.$hash);

	$sub_dir_new=get_param('sub_dir','');
	$sub_dir=(isset($sub_dir_new) && strlen($sub_dir_new)>0)?$sub_dir_new:$sub_dir;
	$dbdir='';

	set_value('db_username_'.$hash,$dbemail);
	set_value('db_password_'.$hash,$dbpassword);
	set_value('db_sub_dir_'.$hash,$sub_dir);

	//include DropboxConnection class
	if (file_exists(get_file_base().'/sources_custom/DropboxConnection.php'))
		require(get_file_base().'/sources_custom/DropboxConnection.php');

	//remove "/" at the end of $sub_dir if any 
	while (preg_match('/\/$/', $sub_dir))
	{
		$sub_dir=substr($sub_dir,0,mb_strlen($sub_dir)-1);
	}
	echo "You are here: " . $sub_dir . "<hr>";

	try
	{
		$db_connection = new DropboxConnection($dbemail, $dbpassword);
		$directories=$db_connection->getdirs($dbdir."/".$sub_dir); 

		if (isset($sub_dir))
		{
			$parent_dir_array=explode("/",$sub_dir);
 			
			$parent_dir='';
			for ($x=0;$x<count($parent_dir_array)-1;$x++)
			{
				$parent_dir.=$parent_dir_array[$x] . "/"; 
			}
 			 
			echo "<a href='".find_script('dropbox_list')."?sub_dir=".$parent_dir."&hash=".$hash."'>../</a><br>";
		}
 		
		foreach ($directories as $directory)
		{
			echo "DIR - <a href='".find_script('dropbox_list')."?hash=".$hash."&sub_dir=".$sub_dir . "/".$directory."'>" . $directory . "</a><br>";
		}
		
		$files=$db_connection->getfiles($dbdir."/".$sub_dir); 

		foreach ($files as $file)
		{
			echo "<a href='".find_script('dropbox_get')."?hash=".$hash."&get=".$sub_dir . "/". $file[0] . "&w=" . $file[1] . "'>".$file[0]."</a><br>";
		}
	}
	catch(Exception $e)
	{
		echo '<span style="color: red">Error: ' . htmlspecialchars($e->getMessage()) . '</span>';
	}
}
