<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2013

 See text/EN/licence.txt for full licencing information.


 NOTE TO PROGRAMMERS:
   Do not edit this file. If you need to make changes, save your changed file to the appropriate *_custom folder
   **** If you ignore this advice, then your website upgrades (e.g. for bug fixes) will likely kill your changes ****

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		core_notifications
 */

/**
 * Standard code module initialisation function.
 */
function init__notification_poller()
{
	define('NOTIFICATION_POLL_FREQUENCY',intval(get_option('notification_poll_frequency')));

	define('NOTIFICATION_POLL_SAFETY_LAG_SECS',8); // Assume a request could have taken this long to happen, so we look back a little further even than NOTIFICATION_POLL_FREQUENCY
}

/**
 * Notification entry script.
 */
function notification_script()
{
	$type=get_param('type');
	switch ($type)
	{
		case 'mark_all_read':
			notification_mark_all_read_script();
			//break;	Intentionally continue on
		case 'poller':
			notification_poller_script();
			break;
		case 'display':
			notification_display_script();
			break;
	}
}

/**
 * Notification entry script.
 */
function notification_mark_all_read_script()
{
	$GLOBALS['SITE_DB']->query_update('digestives_tin',array('d_read'=>1),array('d_read'=>0,'d_to_member_id'=>get_member()));
}

/**
 * Notification entry script.
 */
function notification_display_script()
{
	header('Cache-Control: no-cache, must-revalidate'); // HTTP/1.1
	header('Expires: Mon, 26 Jul 1997 05:00:00 GMT'); // Date in the past
	header('Content-Type: text/plain');

	$max=post_param_integer('max',NULL);

	list($tpl,)=get_web_notifications($max);
	$tpl->evaluate_echo();
}

/**
 * Notification entry script.
 */
function notification_poller_script()
{
	$xml='';

	header('Cache-Control: no-cache, must-revalidate'); // HTTP/1.1
	header('Expires: Mon, 26 Jul 1997 05:00:00 GMT'); // Date in the past
	header('Content-Type: application/xml');
	$xml.='<'.'?xml version="1.0" encoding="'.get_charset().'" ?'.'>
<!DOCTYPE xc:content [
<!ENTITY euro "&#8364;">
<!ENTITY ldquo "&#8220;">
<!ENTITY rdquo "&#8221;">
<!ENTITY lsquo "&#8216;">
<!ENTITY rsquo "&#8217;">
<!ENTITY dagger "&#8224;">
<!ENTITY Dagger "&#8225;">
<!ENTITY permil "&#8240;">
<!ENTITY Scaron "&#352;">
<!ENTITY scaron "&#353;">
<!ENTITY Yuml "&#376;">
<!ENTITY ndash "&#8211;">
<!ENTITY mdash "&#8212;">
<!ENTITY hellip "&#8230;">
<!ENTITY copy "&#169;">
<!ENTITY nbsp " ">
<!ENTITY fnof "&#402;">
<!ENTITY reg "&#174;">
<!ENTITY trade "&#8482;">
<!ENTITY raquo "&#187;">
<!ENTITY frac14 "&#188;">
<!ENTITY frac12 "&#189;">
<!ENTITY frac34 "&#190;">
]>

<response>
	<result>
		<time>'.strval(time()).'</time>
	';

	$time_barrier=get_param_integer('time_barrier',time()-NOTIFICATION_POLL_FREQUENCY-NOTIFICATION_POLL_SAFETY_LAG_SECS);

	$max=get_param_integer('max',NULL);

	$forced_update=(get_param_integer('forced_update',0)==1);

	// Notifications

	if (is_guest())
	{
		$rows=array();
	} else
	{
		$query='SELECT * FROM '.get_table_prefix().'digestives_tin WHERE d_to_member_id='.strval(get_member());
		$query.=' AND d_date_and_time>='.strval($time_barrier);
		$query.=' AND d_read=0';
		$query.=' AND d_frequency='.strval(A_WEB_NOTIFICATION);
		$rows=$GLOBALS['SITE_DB']->query($query);
	}

	if ((count($rows)>0) || ($forced_update))
	{
		foreach ($rows as $row)
		{
			$xml.=web_notification_to_xml($row);
		}

		if (!is_null($max))
		{
			list($display,$unread)=get_web_notifications($max);
			$xml.='
				<display_web_notifications>'.$display->evaluate().'</display_web_notifications>
				<unread_web_notifications>'.strval($unread).'</unread_web_notifications>
			';
		}

		$GLOBALS['SITE_DB']->query('DELETE FROM '.get_table_prefix().'digestives_tin WHERE d_frequency='.strval(A_WEB_NOTIFICATION).' AND d_date_and_time<'.strval(time()-60*60*24*intval(get_option('notification_keep_days')))); // Only keep around for X days
	}

	// Private topics

	if (get_forum_type()=='ocf')
	{
		if (get_option('pt_notifications_as_web')=='0')
		{
			require_code('ocf_notifications');
			$rows=ocf_get_pp_rows(NULL,true,false,$time_barrier);

			if ((count($rows)>0) || ($forced_update))
			{
				foreach ($rows as $row)
				{
					$xml.=pt_to_xml($row);
				}

				if (!is_null($max))
				{
					list($display,$unread)=get_pts($max);
					$xml.='
						<display_pts>'.$display->evaluate().'</display_pts>
						<unread_pts>'.strval($unread).'</unread_pts>
					';
				}
			}
		}
	}

	$xml.='
	</result>
</response>
';
	echo $xml;
}

/**
 * Get web notification templating.
 *
 * @param  ?integer		Number of notifications to show (NULL: no limit)
 * @param  integer		Start offset
 * @return array			A pair: Templating, Max rows
 */
function get_web_notifications($max=NULL,$start=0)
{
	if (is_guest()) return array(new ocp_tempcode(),0);

	$where=array(
		'd_to_member_id'=>get_member(),
		'd_frequency'=>A_WEB_NOTIFICATION,
	);

	$rows=$GLOBALS['SITE_DB']->query_select('digestives_tin',array('*'),$where,'ORDER BY d_date_and_time DESC',$max,$start);
	$out=new ocp_tempcode();
	foreach ($rows as $row)
	{
		$member_id=$row['d_from_member_id'];
		$username=$GLOBALS['FORUM_DRIVER']->get_username($member_id,true);
		$from_url=$GLOBALS['FORUM_DRIVER']->member_profile_url($member_id,true);
		$avatar_url=$GLOBALS['FORUM_DRIVER']->get_member_avatar_url($member_id);

		$_message=comcode_to_tempcode($row['d_message']);

		$url=mixed();
		switch ($row['d_notification_code'])
		{
			case 'ocf_topic':
				if (is_numeric($row['d_code_category'])) // Straight forward topic notification
				{
					$url=$GLOBALS['FORUM_DRIVER']->topic_url(intval($row['d_code_category']),'',true);
				}
				break;
		}

		$rendered=do_template('NOTIFICATION_WEB',array(
			'ID'=>strval($row['id']),
			'SUBJECT'=>$row['d_subject'],
			'MESSAGE'=>$_message,
			'FROM_USERNAME'=>$username,
			'FROM_MEMBER_ID'=>strval($member_id),
			'URL'=>$url,
			'FROM_URL'=>$from_url,
			'FROM_AVATAR_URL'=>$avatar_url,
			'PRIORITY'=>strval($row['d_priority']),
			'DATE_TIMESTAMP'=>strval($row['d_date_and_time']),
			'DATE_WRITTEN_TIME'=>get_timezoned_time($row['d_date_and_time']),
			'NOTIFICATION_CODE'=>$row['d_notification_code'],
			'CODE_CATEGORY'=>$row['d_code_category'],
			'HAS_READ'=>($row['d_read']==1),
		));
		$out->attach($rendered);
	}

	$max_rows=$GLOBALS['SITE_DB']->query_select_value('digestives_tin','COUNT(*)',$where+array('d_read'=>0));

	return array($out,$max_rows);
}

/**
 * Get XML for sending a notification to the current user's web browser.
 *
 * @param  array			Notification row
 * @return string			The XML
 */
function web_notification_to_xml($row)
{
	$member_id=$row['d_from_member_id'];
	$username=$GLOBALS['FORUM_DRIVER']->get_username($member_id,true);
	$from_url=$GLOBALS['FORUM_DRIVER']->member_profile_url($member_id,true);
	$avatar_url=$GLOBALS['FORUM_DRIVER']->get_member_avatar_url($member_id);

	$_message=comcode_to_tempcode($row['d_message']);

	$rendered=do_template('NOTIFICATION_WEB_DESKTOP',array(
		'ID'=>strval($row['id']),
		'SUBJECT'=>$row['d_subject'],
		'MESSAGE'=>$_message,
		'FROM_USERNAME'=>$username,
		'FROM_MEMBER_ID'=>strval($member_id),
		'FROM_URL'=>$from_url,
		'FROM_AVATAR_URL'=>$avatar_url,
		'PRIORITY'=>strval($row['d_priority']),
		'DATE_TIMESTAMP'=>strval($row['d_date_and_time']),
		'DATE_WRITTEN_TIME'=>get_timezoned_time($row['d_date_and_time']),
		'NOTIFICATION_CODE'=>$row['d_notification_code'],
		'CODE_CATEGORY'=>$row['d_code_category'],
	));

	//sound="'.(($row['d_priority']<3)?'on':'off').'"
	return '
		<web_notification
			id="'.strval($row['id']).'"
			subject="'.escape_html($row['d_subject']).'"
			rendered="'.escape_html($rendered->evaluate()).'"
			message="'.escape_html(static_evaluate_tempcode($_message)).'"
			from_username="'.escape_html($username).'"
			from_member_id="'.escape_html(strval($member_id)).'"
			from_url="'.escape_html($from_url).'"
			from_avatar_url="'.escape_html($avatar_url).'"
			priority="'.escape_html(strval($row['d_priority'])).'"
			date_timestamp="'.escape_html(strval($row['d_date_and_time'])).'"
			date_written_time="'.escape_html(get_timezoned_time($row['d_date_and_time'])).'"
			notification_code="'.escape_html($row['d_notification_code']).'"
			code_category="'.escape_html($row['d_code_category']).'"
			sound="on"
		/>
	';
}

/**
 * Get PTs templating.
 *
 * @param  ?integer		Number of PTs to show (NULL: no limit)
 * @param  integer		Start offset
 * @return array			A pair: Templating, Max rows
 */
function get_pts($max=NULL,$start=0)
{
	if (get_forum_type()!='ocf') return array(new ocp_tempcode(),0);

	if (is_guest()) return array(new ocp_tempcode(),0);

	ocf_require_all_forum_stuff();

	require_code('ocf_notifications');
	$rows=ocf_get_pp_rows($max,false,false);
	$max_rows=count(ocf_get_pp_rows(intval(get_option('general_safety_listing_limit')),true,false));

	$out=new ocp_tempcode();
	foreach ($rows as $i=>$topic)
	{
		$topic_url=build_url(array('page'=>'topicview','id'=>$topic['id'],'type'=>'findpost'),get_module_zone('topicview'));
		$topic_url->attach('#post_'.strval($topic['id']));
		$title=$topic['t_cache_first_title'];
		$date=get_timezoned_date($topic['t_cache_last_time'],true);
		$username=$topic['t_cache_last_username'];
		$member_link=$GLOBALS['OCF_DRIVER']->member_profile_url($topic['t_cache_last_member_id'],false,true);
		$num_posts=$topic['t_cache_num_posts'];

		$is_unread=($topic['t_cache_last_time']>time()-60*60*24*intval(get_option('post_history_days'))) && ((is_null($topic['l_time'])) || ($topic['l_time']<$topic['p_time']));

		$out->attach(do_template('TOPIC_LIST',array(
			'POSTER_URL'=>$member_link,
			'TOPIC_URL'=>$topic_url,
			'TITLE'=>$title,
			'DATE'=>$date,
			'DATE_RAW'=>strval($topic['t_cache_last_time']),
			'USERNAME'=>$username,
			'POSTER_ID'=>strval($topic['t_cache_last_member_id']),
			'NUM_POSTS'=>integer_format($num_posts),
			'HAS_READ'=>!$is_unread,
		)));

		if ($i===$max) break;
	}

	return array($out,$max_rows);
}

/**
 * Get XML for sending a PT alert to the current user's web browser.
 *
 * @param  array			Notification row
 * @return string			The XML
 */
function pt_to_xml($row)
{
	$member_id=$row['p_poster'];
	$username=$GLOBALS['FORUM_DRIVER']->get_username($member_id,true);
	$url=$GLOBALS['FORUM_DRIVER']->member_profile_url($member_id,true);
	$avatar_url=$GLOBALS['FORUM_DRIVER']->get_member_avatar_url($member_id);

	$_message=get_translated_tempcode($row['p_post']);

	$rendered=do_template('NOTIFICATION_PT_DESKTOP',array(
		'ID'=>strval($row['p_id']),
		'SUBJECT'=>$row['t_cache_first_title'],
		'MESSAGE'=>$_message,
		'FROM_USERNAME'=>$username,
		'FROM_MEMBER_ID'=>strval($member_id),
		'URL'=>$url,
		'FROM_AVATAR_URL'=>$avatar_url,
		'DATE_TIMESTAMP'=>strval($row['p_time']),
		'DATE_WRITTEN_TIME'=>get_timezoned_time($row['p_time']),
	));

	return '
		<pt
			id="'.strval($row['p_id']).'"
			subject="'.escape_html($row['t_cache_first_title']).'"
			rendered="'.escape_html($rendered->evaluate()).'"
			message="'.escape_html(static_evaluate_tempcode($_message)).'"
			from_username="'.escape_html($username).'"
			from_member_id="'.escape_html(strval($member_id)).'"
			url="'.escape_html($url).'"
			from_avatar_url="'.escape_html($avatar_url).'"
			date_timestamp="'.escape_html(strval($row['p_time'])).'"
			date_written_time="'.escape_html(get_timezoned_time($row['p_time'])).'"
			sound="on"
		/>
	';
}