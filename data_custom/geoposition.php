<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2011

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

require_code('locations_geopositioning');

header("Cache-Control: no-cache, must-revalidate"); // HTTP/1.1
header("Expires: Mon, 26 Jul 1997 05:00:00 GMT"); // Date in the past
header('Content-type: text/plain; charset='.get_charset());

safe_ini_set('ocproducts.xss_detect','0');

$lstring=get_param('lstring',NULL);
if (!is_null($lstring)) // Forward geopositioning (textlocation to full details)
{
	$url='http://maps.googleapis.com/maps/api/geocode/xml?address='.urlencode($lstring).'&sensor=false';
	if (isset($_COOKIE['google_bias'])) $url.='&region='.urlencode($_COOKIE['google_bias']);
	$result=http_download_file($url);
	$matches=array();
	if (preg_match('#<lat>([\-\d\.]+)</lat>\s*<lng>([\-\d\.]+)</lng>.*<lat>([\-\d\.]+)</lat>\s*<lng>([\-\d\.]+)</lng>.*<lat>([\-\d\.]+)</lat>\s*<lng>([\-\d\.]+)</lng>#s',$result,$matches)!=0)
	{
		echo '[';

		echo 'null';
		echo ',\''.addslashes($lstring).'\'';
		echo ','.float_to_raw_string(floatval($matches[1]));
		echo ','.float_to_raw_string(floatval($matches[2]));
		echo ','.float_to_raw_string(floatval($matches[3]));
		echo ','.float_to_raw_string(floatval($matches[4]));
		echo ','.float_to_raw_string(floatval($matches[5]));
		echo ','.float_to_raw_string(floatval($matches[6]));

		echo ']';
	}
} else // Reverse geopositioning (lat/long to full details)
{
	if (get_param_integer('use_google',0)==1)
	{
		$url='http://maps.googleapis.com/maps/api/geocode/xml?latlng='.urlencode(get_param('latitude')).','.urlencode(get_param('longitude')).'&sensor=false';
		if (isset($_COOKIE['google_bias'])) $url.='&region='.urlencode($_COOKIE['google_bias']);
		$result=http_download_file($url);
		$matches=array();
		if (preg_match('#<formatted_address>([^<>]*)</formatted_address>.*<lat>([\-\d\.]+)</lat>\s*<lng>([\-\d\.]+)</lng>.*<lat>([\-\d\.]+)</lat>\s*<lng>([\-\d\.]+)</lng>.*<lat>([\-\d\.]+)</lat>\s*<lng>([\-\d\.]+)</lng>#Us',$result,$matches)!=0)
		{
			echo '[';

			echo 'null';
			echo ',\''.addslashes($matches[1]).'\'';
			echo ','.float_to_raw_string(floatval($matches[2]));
			echo ','.float_to_raw_string(floatval($matches[3]));
			echo ','.float_to_raw_string(floatval($matches[4]));
			echo ','.float_to_raw_string(floatval($matches[5]));
			echo ','.float_to_raw_string(floatval($matches[6]));
			echo ','.float_to_raw_string(floatval($matches[7]));

			echo ']';
		}
	} else
	{
		$bits=find_nearest_location(floatval(get_param('latitude')),floatval(get_param('longitude')),get_param_integer('latitude_search_field',NULL),get_param_integer('longitude_search_field',NULL));
		if (!is_null($bits))
		{
			// Give out different IDs, depending on what the search fields were in.

			echo '[';

			if (isset($bits['id'])) echo strval($bits['id']); // Category or Location
			elseif (isset($bits['ce_id'])) echo strval($bits['ce_id']); // Entry
			else echo strval($bits['id']); // Location

			echo ',';

			if (isset($bits['cc_title']))
			{
				$done_one=false;
				echo '\'';
				$parent_id=$bits['id'];
				do
				{
					if (!is_null($parent_id))
					{
						$row=$GLOBALS['SITE_DB']->query_select('catalogue_categories',array('cc_parent_id','cc_title'),array('id'=>$parent_id),'',1);
						$parent_id=$row[0]['cc_parent_id'];
						if (!is_null($parent_id)) // Top level skipped also
						{
							if ($done_one) echo ', ';
							echo addslashes(get_translated_text($row[0]['cc_title']));
							$done_one=true;
						}
					}
				}
				while (!is_null($parent_id));
				echo '\'';
			}
			elseif (isset($bits['l_place']))
			{
				echo '\'';
				echo addslashes($bits['l_place']);
				if ($bits['l_parent_1']!='') echo ', '.addslashes($bits['l_parent_1']);
				if ($bits['l_parent_2']!='') echo ', '.addslashes($bits['l_parent_2']);
				if ($bits['l_parent_3']!='') echo ', '.addslashes($bits['l_parent_3']);
				if ($bits['l_country']!='') echo ', '.addslashes($bits['l_country']);
				echo '\'';
			}
			else echo '\'\'';

			echo ','.float_to_raw_string($bits['l_latitude'],10);
			echo ','.float_to_raw_string($bits['l_longitude'],10);

			echo ']';
		}
	}
}
