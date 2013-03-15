<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 */

// Find ocPortal base directory, and chdir into it
global $FILE_BASE,$RELATIVE_PATH;
$FILE_BASE=(strpos(__FILE__,'./')===false)?__FILE__:realpath(__FILE__);
$FILE_BASE=dirname($FILE_BASE);
if (!is_file($FILE_BASE.'/sources/global.php')) // Need to navigate up a level further perhaps?
{
	$RELATIVE_PATH=basename($FILE_BASE);
	$FILE_BASE=dirname($FILE_BASE);
} else
{
	$RELATIVE_PATH='';
}
@chdir($FILE_BASE);

global $NON_PAGE_SCRIPT;
$NON_PAGE_SCRIPT=1;
global $FORCE_INVISIBLE_GUEST;
$FORCE_INVISIBLE_GUEST=0;
if (!is_file($FILE_BASE.'/sources/global.php')) exit('<!DOCTYPE html>'.chr(10).'<html lang="EN"><head><title>Critical startup error</title></head><body><h1>ocPortal startup error</h1><p>The second most basic ocPortal startup file, sources/global.php, could not be located. This is almost always due to an incomplete upload of the ocPortal system, so please check all files are uploaded correctly.</p><p>Once all ocPortal files are in place, ocPortal must actually be installed by running the installer. You must be seeing this message either because your system has become corrupt since installation, or because you have uploaded some but not all files from our manual installer package: the quick installer is easier, so you might consider using that instead.</p><p>ocProducts maintains full documentation for all procedures and tools, especially those for installation. These may be found on the <a href="http://ocportal.com">ocPortal website</a>. If you are unable to easily solve this problem, we may be contacted from our website and can help resolve it for you.</p><hr /><p style="font-size: 0.8em">ocPortal is a website engine created by ocProducts.</p></body></html>'); require($FILE_BASE.'/sources/global.php');


// Remap menus to use these images
$icons=fopen(get_file_base().'/data_custom/icon_map.csv','rt');
while (($line=fgetcsv($icons,1024))!==false)
{
	if (count($line)==2)
	{
		$where='';
		switch ($line[0])
		{
			case 'collab_features':
				$map=array('i_menu'=>$line[0],'i_url'=>'');
				$where=db_string_equal_to('i_menu',$line[0]).' AND '.db_string_equal_to('i_url','');
				break;

			case 'forum_base_url':
				$where=db_string_equal_to('i_url',get_forum_base_url(true));
				break;

			default:
				$where=db_string_equal_to('i_url',$line[0]);
		}
		$GLOBALS['SITE_DB']->query('UPDATE '.get_table_prefix().'menu_items SET i_theme_img_code=\'menu_items/'.db_escape_string($line[1]).'\''.' WHERE '.db_string_not_equal_to('i_menu','zone_menu').' AND '.$where);
	}
}

echo 'Installed';
