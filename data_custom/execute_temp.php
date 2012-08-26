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
	require_code('blocks/main_staff_checklist');

	// Find if anything needs doing
	$outstanding=0;
	$rows=$GLOBALS['SITE_DB']->query_select('customtasks',array('*'));
	foreach($rows as $r)
	{
		$task_done=((!is_null($r['taskisdone'])) && (($r['recurinterval']==0) || (($r['recurevery']!='mins') || (time()<$r['taskisdone']+60*$r['recurinterval'])) && (($r['recurevery']!='hours') || (time()<$r['taskisdone']+60*60*$r['recurinterval'])) && (($r['recurevery']!='days') || (time()<$r['taskisdone']+24*60*60*$r['recurinterval'])) && (($r['recurevery']!='months') || (time()<$r['taskisdone']+31*24*60*60*$r['recurinterval']))));
		if (!$task_done) $outstanding++;
	}
	$_hooks=find_all_hooks('blocks','main_staff_checklist');
	foreach (array_keys($_hooks) as $hook)
	{
		require_code('hooks/blocks/main_staff_checklist/'.filter_naughty_harsh($hook));
		$object=object_factory('Hook_checklist_'.filter_naughty_harsh($hook),true);
		if (is_null($object)) continue;
		$ret=$object->run();
		if ((!is_null($ret)) && (count($ret)!=0))
		{
			foreach ($ret as $r)
			{
				if (!is_null($r[2]))
				{
					if ($r[2]>0)
						$outstanding++; // A tally of undone stuff
				} elseif (!is_null($r[1]))
				{
					if ($r[1]<0) // Needed doing in the past
						$outstanding++;
				}
			}
		}
	}

	if ($outstanding>0)
	{
		require_lang('staff_checklist');

		require_code('notifications');
		$subject=do_lang('STAFF_CHECKLIST_MAIL_SUBJECT',integer_format($outstanding),get_site_name(),NULL,get_site_default_lang());
		$adminzone_url=build_url(array('page'=>''),'adminzone',NULL,false,false,true);
		$message=do_lang('STAFF_CHECKLIST_MAIL_BODY',integer_format($outstanding),get_site_name(),static_evaluate_tempcode($adminzone_url),get_site_default_lang());
exit($message);
	}
}
