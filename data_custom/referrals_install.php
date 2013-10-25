<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

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
if (!is_file($FILE_BASE.'/sources/global.php')) exit('<!DOCTYPE html>'."\n".'<html lang="EN"><head><title>Critical startup error</title></head><body><h1>ocPortal startup error</h1><p>The second most basic ocPortal startup file, sources/global.php, could not be located. This is almost always due to an incomplete upload of the ocPortal system, so please check all files are uploaded correctly.</p><p>Once all ocPortal files are in place, ocPortal must actually be installed by running the installer. You must be seeing this message either because your system has become corrupt since installation, or because you have uploaded some but not all files from our manual installer package: the quick installer is easier, so you might consider using that instead.</p><p>ocProducts maintains full documentation for all procedures and tools, especially those for installation. These may be found on the <a href="http://ocportal.com">ocPortal website</a>. If you are unable to easily solve this problem, we may be contacted from our website and can help resolve it for you.</p><hr /><p style="font-size: 0.8em">ocPortal is a website engine created by ocProducts.</p></body></html>'); require($FILE_BASE.'/sources/global.php');

$GLOBALS['SITE_DB']->create_table('referrer_override',array(
	'o_referrer'=>'*MEMBER',
	'o_scheme_name'=>'*ID_TEXT',
	'o_referrals_dif'=>'INTEGER',
	'o_is_qualified'=>'?BINARY',
));

$GLOBALS['SITE_DB']->create_table('referees_qualified_for',array(
	'id'=>'*AUTO',
	'q_referee'=>'MEMBER',
	'q_referrer'=>'MEMBER',
	'q_scheme_name'=>'ID_TEXT',
	'q_email_address'=>'SHORT_TEXT',
	'q_time'=>'TIME',
	'q_action'=>'ID_TEXT',
));

// Populate from current invites
$rows=$GLOBALS['FORUM_DB']->query_select('f_invites',array('i_email_address','i_time','i_inviter'),array('i_taken'=>1));
foreach ($rows as $row)
{
	$member_id=$GLOBALS['FORUM_DB']->query_select_value_if_there('f_members','id',array('m_email_address'=>$row['i_email_address']));
	if (!is_null($member_id))
	{
		$ini_file=parse_ini_file(get_custom_file_base().'/text_custom/referrals.txt',true);

		foreach (array_keys($ini_file) as $scheme_name)
		{
			$GLOBALS['SITE_DB']->query_insert('referees_qualified_for',array(
				'q_referee'=>$member_id,
				'q_referrer'=>$row['i_inviter'],
				'q_scheme_name'=>$scheme_name,
				'q_email_address'=>$row['i_email_address'],
				'q_time'=>$row['i_time'],
				'q_action'=>'',
			));
		}
	}
}

echo 'Installed';
