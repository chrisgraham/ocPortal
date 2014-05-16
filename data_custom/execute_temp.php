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

// Put code that you temporarily want executed into the function. DELETE THE CODE WHEN YOU'RE DONE.
// This is useful when performing quick and dirty upgrades (e.g. adding tables to avoid a reinstall)

require_code('database_action');
require_code('config2');
require_code('menus2');
$out=execute_temp();
if (!headers_sent())
{
	header('Content-Type: text/plain');
	@ini_set('ocproducts.xss_detect','0');
	if (!is_null($out)) echo is_object($out)?$out->evaluate():(is_bool($out)?($out?'true':'false'):$out);
	echo do_lang('SUCCESS');
}

/**
 * Execute some temporary code put into this function.
 *
 * @return  mixed		Arbitrary result to output, if no text has already gone out
 */
function execute_temp()
{
	header('Content-Type: text/plain');
	@ini_set('ocproducts.xss_detect','0');

	$db_meta=$GLOBALS['SITE_DB']->query_select('db_meta',array('m_table','m_name'),array('m_type'=>'LONG_TRANS'));
	foreach ($db_meta as $dbm)
	{
		if ($dbm['m_table']=='f_members')
		{
			$submitter_field_name='id';
		} else
		{
			$submitter_field_name=$GLOBALS['SITE_DB']->query_value_null_ok('db_meta','m_name',array('m_type'=>'USER','m_table'=>$dbm['m_table']));
		}
		if ((!is_null($submitter_field_name)) && (($submitter_field_name=='id') || (strpos($submitter_field_name,'the_user')!==false) || (strpos($submitter_field_name,'submitter')!==false)))
		{
			$sql='UPDATE '.get_table_prefix().'translate t JOIN '.get_table_prefix().$dbm['m_table'].' r ON r.'.$dbm['m_name'].'=t.id SET text_parsed=\'\',source_user=r.'.$submitter_field_name;
			echo $sql.";\n";
			$db=$GLOBALS['SITE_DB'];
			if (substr($dbm['m_table'],0,2)=='f_') $db=$GLOBALS['FORUM_DB'];
			$db->query($sql);
		}
	}

	echo "SQL executed!\n\n";
}
