<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		ad_success
 */

/*
Simple script to track advertising purchase successes.
Requires super_logging enabled.

Assumes 'from' GET parameter used to track what campaign hits came from.

May be very slow to run.
*/

$success=array();
$joining=array();
$failure=array();
$users_done=array();
$advertiser_sessions=$GLOBALS['SITE_DB']->query('SELECT the_user,s_get,ip,date_and_time FROM '.$GLOBALS['SITE_DB']->get_table_prefix().'stats WHERE date_and_time>'.(string)(time()-60*60*24*get_param_integer('days',1)).' AND s_get LIKE \''.db_encode_like('%<param>from=%').'\'');
foreach ($advertiser_sessions as $session)
{
	if (array_key_exists($session['the_user'],$users_done)) continue;
	$users_done[$session['the_user']]=1;

	$matches=array();
	if (!preg_match('#<param>from=([\w\d]+)</param>#',$session['s_get'],$matches)) continue;
	$from=$matches[1];
	$user=$session['the_user'];

	if (!array_key_exists($from,$success))
	{
		$success[$from]=0;
		$failure[$from]=0;
		$joining[$from]=0;
	}

	if (get_param_integer('track',0)==1)
	{
		echo '<b>Tracking information for <u>'.$from.'</u> visitor</b> ('.$session['ip'].')....<br />';
		$places=$GLOBALS['SITE_DB']->query('SELECT the_page,date_and_time,referer FROM '.$GLOBALS['SITE_DB']->get_table_prefix().'stats WHERE the_user='.(string)intval($user).' AND date_and_time>='.(string)intval($session['date_and_time']).' ORDER BY date_and_time');
		foreach ($places as $place)
		{
			echo '<p>'.escape_html($place['the_page']).' at '.date('Y-m-d H:i:s',$place['date_and_time']).' (from '.escape_html(substr($place['referer'],0,200)).')</p>';
		}
	}

	$ip=$GLOBALS['SITE_DB']->query_value_null_ok('stats','ip',array('the_page'=>'site/pages/modules/join.php','the_user'=>$user));
	$user=is_null($ip)?NULL:$GLOBALS['SITE_DB']->query_value_null_ok_full('SELECT the_user FROM '.$GLOBALS['SITE_DB']->get_table_prefix().'stats WHERE '.db_string_equal_to('ip',$ip).' AND the_user>0');
	if (!is_null($user)) $joining[$from]++;
	$test=is_null($user)?NULL:$GLOBALS['SITE_DB']->query_value_null_ok('stats','id',array('the_page'=>'site/pages/modules_custom/purchase.php','the_user'=>$user));
	if (!is_null($test)) $success[$from]++; else $failure[$from]++;
}

echo '<p><b>Summary</b>...</p>';
echo 'Successes...';
print_r($success);
echo '<br />';
echo 'Joinings...';
print_r($joining);
echo '<br />';
echo 'Failures...';
print_r($failure);

