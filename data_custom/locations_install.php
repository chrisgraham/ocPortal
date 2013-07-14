<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2013

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

global $FORCE_INVISIBLE_GUEST;
$FORCE_INVISIBLE_GUEST=false;
if (!is_file($FILE_BASE.'/sources/global.php')) exit('<!DOCTYPE html>'.chr(10).'<html lang="EN"><head><title>Critical startup error</title></head><body><h1>ocPortal startup error</h1><p>The second most basic ocPortal startup file, sources/global.php, could not be located. This is almost always due to an incomplete upload of the ocPortal system, so please check all files are uploaded correctly.</p><p>Once all ocPortal files are in place, ocPortal must actually be installed by running the installer. You must be seeing this message either because your system has become corrupt since installation, or because you have uploaded some but not all files from our manual installer package: the quick installer is easier, so you might consider using that instead.</p><p>ocProducts maintains full documentation for all procedures and tools, especially those for installation. These may be found on the <a href="http://ocportal.com">ocPortal website</a>. If you are unable to easily solve this problem, we may be contacted from our website and can help resolve it for you.</p><hr /><p style="font-size: 0.8em">ocPortal is a website engine created by ocProducts.</p></body></html>'); require($FILE_BASE.'/sources/global.php');

$GLOBALS['SITE_DB']->create_table('locations',array(
	'id'=>'*AUTO',
	'l_place'=>'SHORT_TEXT',
	'l_type'=>'ID_TEXT',
	'l_continent'=>'ID_TEXT',
	'l_country'=>'ID_TEXT',
	'l_parent_1'=>'ID_TEXT',
	'l_parent_2'=>'ID_TEXT',
	'l_parent_3'=>'ID_TEXT',
	'l_population'=>'?INTEGER',
	'l_latitude'=>'?REAL',
	'l_longitude'=>'?REAL',
	//'l_postcode'=>'ID_TEXT',	Actually often many postcodes per location and/or poor alignment
));
$GLOBALS['SITE_DB']->create_index('locations','l_place',array('l_place'));
$GLOBALS['SITE_DB']->create_index('locations','l_country',array('l_country'));
$GLOBALS['SITE_DB']->create_index('locations','l_latitude',array('l_latitude'));
$GLOBALS['SITE_DB']->create_index('locations','l_longitude',array('l_longitude'));
//$GLOBALS['SITE_DB']->create_index('locations','l_postcode',array('l_postcode'));
