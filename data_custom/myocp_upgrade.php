<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.

*/

/*
This is a special script for upgrading MyOCP with minimal effort.

INSTRUCTIONS...

You must have already run an untar:
 - Generate as normal, on the news release for the version you're upgrading
 - Run something like:
  - cd /home/ocp/public_html/servers/myocp.com
  - wget -O upgrade.tar http://ocportal.com/upgrades/7.1.2-9%20beta3.tar
  - tar xvf upgrade.tar
  - rm upgrade.tar
Then run this script, http://shareddemo.myocp.com/data_custom/myocp_upgrade.php
You may need to call it multiple times, with ?from=<number>, if it is timing out
After running the main upgrade this script will tell you files to delete.

NOTES...

Plenty of room for improvement into the future here, e.g. we could move upgraded users over to a separate myOCP server as we upgrade them, then erase the old one later.
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
$FORCE_INVISIBLE_GUEST=true;
if (array_key_exists('ocf',$_GET)) $_GET['use_ocf']=1;

global $SITE_INFO;
$SITE_INFO['no_extra_closed_file']='1';

$_GET['keep_show_parse_errors']='1'; // So if things go wrong we can better see what
if (!is_file($FILE_BASE.'/sources/global.php')) exit('<!DOCTYPE html>'."\n".'<html lang="EN"><head><title>Critical startup error</title></head><body><h1>ocPortal startup error</h1><p>The second most basic ocPortal startup file, sources/global.php, could not be located. This is almost always due to an incomplete upload of the ocPortal system, so please check all files are uploaded correctly.</p><p>Once all ocPortal files are in place, ocPortal must actually be installed by running the installer. You must be seeing this message either because your system has become corrupt since installation, or because you have uploaded some but not all files from our manual installer package: the quick installer is easier, so you might consider using that instead.</p><p>ocProducts maintains full documentation for all procedures and tools, especially those for installation. These may be found on the <a href="http://ocportal.com">ocPortal website</a>. If you are unable to easily solve this problem, we may be contacted from our website and can help resolve it for you.</p><hr /><p style="font-size: 0.8em">ocPortal is a website engine created by ocProducts.</p></body></html>'); require($FILE_BASE.'/sources/global.php');


require_code('upgrade');
require_lang('upgrade');
require_code('shared_installs');
require_code('database_action');
require_code('config2');

// Integrity check only?
if (get_param_integer('integrity',0)==1)
{
	$integrity_check_output=preg_replace('#<input[^<>]*>#','',run_integrity_check());
	inform_exit(protect_from_escaping($integrity_check_output));
}

// Close site
set_option('closed',do_lang('FU_CLOSED_FOR_UPGRADES',get_site_name()));
set_option('site_closed','1');
@rename(get_file_base().'/closed.html.old',get_file_base().'/closed.html');

// Clear full cache
clear_caches_1();

// Reset demo
http_download_file(get_brand_base_url()'/data_custom/ocpcom_web_service.php?call=demo_reset');

// Run upgrade
global $SITE_INFO;
$u=current_share_user();
if (is_null($u)) warn_exit('Eh, this does not seem to be running on a shared site?');
upgrade_sharedinstall_sites(get_param_integer('from',1)-1);

// Save new SQL dump
$out_path=dirname(dirname(get_file_base())).'/uploads/website_specific/ocportal.com/myocp/template.sql';
if (!file_exists($out_path.'.tmp'))
{
	$cmd='/usr/bin/mysqldump -u'.escapeshellarg(substr(md5($SITE_INFO['db_site_user'].'_shareddemo'),0,16)).' -p'.escapeshellarg($SITE_INFO['db_site_password']).' '.escapeshellarg($SITE_INFO['db_site']).'_shareddemo';
	$cmd_secret='mysqldump -uxxx_shareddemo -pxxx xxx_shareddemo';
	$sql_dump_output='';
	$sql_dump_output.='<kbd>'.escape_html($cmd_secret).' > '.$out_path.'.tmp</kbd>:<br />';
	$result=shell_exec($cmd.' > '.$out_path.'.tmp');
	$sql_dump_output.=escape_html($result);
	if ((!is_file($out_path.'.tmp')) || (filesize($out_path.'.tmp')==0))
	{
		//echo $cmd.' > '.$out_path.'.tmp'; // Temporarily reenable ONLY when debugging, for security reasons
		warn_exit(protect_from_escaping('Failed to create SQL dump (maybe try on command line)...<br /><br />'.$sql_dump_output));
	}
}
@unlink($out_path);
rename($out_path.'.tmp',$out_path);

// Clear rest of cache
clear_caches_2();

// Integrity check
$integrity_check_output=preg_replace('#<input[^<>]*>#','',run_integrity_check());

// Done
set_option('site_closed','1');
@rename(get_file_base().'/closed.html',get_file_base().'/closed.html.old');
inform_exit(protect_from_escaping('Done! Now, on to the integrity check (action whatever you need to do manually)...<br /><br />'.$integrity_check_output));
