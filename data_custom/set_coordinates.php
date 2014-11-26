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

set_coordinates();

function set_coordinates()
{
	header('Content-Type: text/plain; charset='.get_charset());

	$_coords=get_param('coord','');
	$member_id=get_param_integer('mid',get_member());

	//prevent hack attepts
	if ($member_id!=get_member()) return;

	$coords=explode('_',$_coords);


	$latitude_cpf_id=$GLOBALS['FORUM_DB']->query_value_null_ok('f_custom_fields f LEFT JOIN '.$GLOBALS['FORUM_DB']->get_table_prefix().'translate t ON f.cf_name=t.id','f.id',array('text_original'=>'ocp_latitude'));

	$longitude_cpf_id=$GLOBALS['FORUM_DB']->query_value_null_ok('f_custom_fields f LEFT JOIN '.$GLOBALS['FORUM_DB']->get_table_prefix().'translate t ON f.cf_name=t.id','f.id',array('text_original'=>'ocp_longitude'));

	//are there latitude and longtitude custom profile fields ?
	if(is_null($longitude_cpf_id) || is_null($latitude_cpf_id)) return;

	//check for inputed coordinates
	if (!is_array($coords) || !isset($coords[0]) || !isset($coords[1])) return;

	$GLOBALS['FORUM_DB']->query_update('f_member_custom_fields',array('field_'.$latitude_cpf_id=>strval($coords[0]),'field_'.$longitude_cpf_id=>strval($coords[1])),array('mf_member_id'=>$member_id) );
}
