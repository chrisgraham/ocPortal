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
	@header('Content-type: text/plain');

	$dodgy_addons=array();
	$hooks=find_all_hooks('systems','addon_registry');
	$hook_keys=array_keys($hooks);
	$hook_files=array();
	foreach ($hook_keys as $hook)
	{
		if (substr($hook,0,4)=='core') continue;

		$path=get_custom_file_base().'/sources/hooks/systems/addon_registry/'.filter_naughty_harsh($hook).'.php';
		if (!file_exists($path))
		{
			$path=get_file_base().'/sources/hooks/systems/addon_registry/'.filter_naughty_harsh($hook).'.php';
		}
		$hook_files[$hook]=file_get_contents($path);
	}
	ksort($hook_files);
	foreach ($hook_files as $addon_name=>$hook_file)
	{
		$matches=array();
		if (preg_match('#function get_file_list\(\)\s*\{([^\}]*)\}#',$hook_file,$matches)!=0)
		{
			if (!defined('HIPHOP_PHP'))
			{
				$hooks_files=eval($matches[1]);
			} else
			{
				require_code('hooks/systems/addon_registry/'.$addon_name);
				$hook=object_factory('Hook_addon_registry_'.$addon_name);
				$hooks_files=$hook->get_file_list();
			}
			$dodgy_addons[$addon_name]=false;
			foreach ($hooks_files as $file)
			{
				if (strpos($file,'/')===false)
				{
					if (substr($file,-4)=='.tpl') $file='themes/default/templates/'.$file;
					elseif (substr($file,-4)=='.css') $file='themes/default/css/'.$file;
				}
				if (!file_exists(get_file_base().'/'.$file))
				{
					$dodgy_addons[$addon_name]=true;
				}
			}

			if ($dodgy_addons[$addon_name])
			{
				foreach ($hooks_files as $file)
				{
					echo $file."\n";
				}
			}
		}
	}
}
