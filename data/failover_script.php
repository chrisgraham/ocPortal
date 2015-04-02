<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		failover
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

require($FILE_BASE.'/info.php');

if (php_sapi_name()!='cli')
{
	header('Content-type: text/plain');
}

$required_settings=array(
	'fast_spider_cache',
	'any_guest_cached_too',
	'failover_mode',
	'failover_message',
	'failover_cache_miss_message',
	'failover_loadtime_threshold',
	'failover_loadaverage_threshold',
	'failover_email_contact',
	'failover_check_urls',
	'base_url',
);

global $SITE_INFO;
foreach ($required_settings as $setting)
{
	if (empty($SITE_INFO[$setting]))
	{
		exit('Missing/empty info.php setting: '.$setting);
	}
}

if ($SITE_INFO['failover_mode']!='auto_on' && $SITE_INFO['failover_mode']!='auto_off')
{
	exit(); // Not enabled. No message, we don't want to push noise back into the CRON system.
}

// Check URLs
$context=array(
	'http'=>array(
		'user_agent'=>'ocportal_failover_test',
	)
);
$urls=explode(';',$SITE_INFO['failover_check_urls']);
foreach ($urls as $url)
{
	$full_url=$SITE_INFO['base_url'].'/'.$url;
	$full_url.=((strpos($full_url,'?')==false)?'?':'&').'keep_failover=0';

	$time_before=microtime(true);
	readfile($full_url,false,$context);
	$time_after=microtime(true);
	$time=$time_after-$time_before;

	if (strpos($http_response_header[0],'200')===false)
	{
		is_failing($full_url.'('.$http_response_header[0].')');
	}

	if ($time>=floatval($SITE_INFO['failover_loadtime_threshold'])
	{
		is_failing($full_url.'('.strval($time).' seconds)');
	}
}

// Check loadaverage (Unix-like)
if (function_exists('sys_getloadavg'))
{
	$result=sys_getloadavg();
	if ($result[1]>=floatval($SITE_INFO['failover_loadaverage_threshold']))
	{
		is_failing('load-average='.strval($result[1]));
	}
}

// Check loadaverage (Windows)
if (class_exists('COM'))
{
	$wmi=new COM('Winmgmts://');
	$server=$wmi->execquery('SELECT LoadPercentage FROM Win32_Processor');
	if (is_array($server))
	{
		$cpu_num=0;
		$load_total=0;
		foreach ($server as $cpu){
			$cpu_num++;
			$load_total+=$cpu->loadpercentage;
		}
		$load=round((float)$load_total/(float)$cpu_num);
		if ($cpu_num!=0)
		{
			if ($load>=floatval($SITE_INFO['failover_loadaverage_threshold']))
			{
				is_failing('load-average='.strval($load));
			}
		}
	}
}

// If we got this far, no problems
set_failover_mode('auto_off');

/**
 * A check has failed, inform contact(s) about it then exit.
 *
 * @param  string					Check that failed.
 */
function is_failing($url)
{
	if ($SITE_INFO['failover_mode']=='auto_off')
	{
		global $SITE_INFO;
		$emails=explode(';',$SITE_INFO['failover_email_contact']);
		foreach ($emails as $email)
		{
			$base_url=parse_url($SITE_INFO['base_url']);

			$subject='Failover mode activated for '.$base_url['host'];
			$message="Failover mode activated when running the following check:\n".$url."\n\nWhen the problem has been corrected it will automatically disable.\nIf this is a false alarm somehow you can force failover mode off manually by setting \$SITE_INFO['failover_mode']='off'; in info.php";
			mail($email,$subject,$message);
		}
	}

	set_failover_mode('auto_on');

	exit();
}

/**
 * Set failover mode to a new value.
 *
 * @param  string					New failover mode.
 */
function set_failover_mode($new_mode)
{
	global $FILE_BASE;
	$path=$FILE_BASE.'/info.php';
	$data=file_get_contents($path);
	$orig=$data;
	$data=preg_replace('#(\$SITE_INFO[\'failover_mode\']\s*=\s*\')[^\']+(\';)#',"\n".'$1'.addcslashes($new_mode).'$2',$data);
	if ($orig!=$data)
		file_put_contents($path,$data);
}
