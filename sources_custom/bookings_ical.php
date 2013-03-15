<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		booking
 */

/**
 * Show bookables ical feed.
 */
function bookables_ical_script()
{
	require_code('calendar_ical');

	require_lang('booking');

	@ini_set('ocproducts.xss_detect','0');

//	header('Content-Type: text/calendar');
//	header('Content-Disposition: filename="bookables_export.ics"');

	if (function_exists('set_time_limit')) @set_time_limit(0);

	$query='SELECT * FROM '.get_table_prefix().'bookable WHERE enabled=1';
	$filter=get_param('filter','*');
	require_code('ocfiltering');
	$query.=' AND '.ocfilter_to_sqlfragment($filter,'id');
	$events=$GLOBALS['SITE_DB']->query($query);
	echo "BEGIN:VCALENDAR\n";
	echo "VERSION:2.0\n";
	echo "PRODID:-//ocProducts/ocPortal//NONSGML v1.0//EN\n";
	echo "CALSCALE:GREGORIAN\n";
	echo "X-WR-CALNAME:".ical_escape(get_site_name().': '.do_lang('BOOKABLE_EVENTS'))."\n";

	foreach ($events as $event)
	{
		echo "BEGIN:VEVENT\n";

		echo "DTSTAMP:".date('Ymd',$event['add_date'])."T".date('His',$event['add_date'])."\n";
		echo "CREATED:".date('Ymd',$event['add_date'])."T".date('His',$event['add_date'])."\n";
		if (!is_null($event['edit_date'])) echo "LAST-MODIFIED:".date('Ymd',time())."T".date('His',$event['edit_date'])."\n";

		echo "SUMMARY:".ical_escape(get_translated_text($event['title']))."\n";
		$description=get_translated_text($event['description']);
		echo "DESCRIPTION:".ical_escape($description)."\n";

		if (!is_guest($event['submitter']))
			echo "ORGANIZER;CN=".ical_escape($GLOBALS['FORUM_DRIVER']->get_username($event['submitter'])).";DIR=".ical_escape($GLOBALS['FORUM_DRIVER']->member_profile_url($event['submitter'])).":MAILTO:".ical_escape($GLOBALS['FORUM_DRIVER']->get_member_email_address($event['submitter']))."\n";
		echo "CATEGORIES:".ical_escape(get_translated_text($event['categorisation']))."\n";
		echo "CLASS:".(($event['price']==0.0)?'PUBLIC':'PRIVATE')."\n";
		echo "STATUS:".(($event['enabled']==1)?'CONFIRMED':'TENTATIVE')."\n";
		echo "UID:".ical_escape(strval($event['id']).'-bookable@'.get_base_url())."\n";
		$_url=build_url(array('page'=>'booking','type'=>'misc','filter'=>$event['id']),get_module_zone('booking'),NULL,false,false,true);
		$url=$_url->evaluate();
		echo "URL:".ical_escape($url)."\n";

		$time=mktime(0,0,0,$event['active_from_month'],$event['active_from_day'],$event['active_from_year']);
		$time2=mixed();
		if ($event['cycle_type']!='none')
		{
			$parts=explode(' ',$event['cycle_type']);
			if (count($parts)==1)
			{
				echo "DTSTART;TZ=".get_site_timezone().":".date('Ymd',$time)."\n";
				$recurrence_code='FREQ='.strtoupper($parts[0]);
				echo "RRULE:".$recurrence_code."\n";
			} else
			{
				for ($i=0;$i<strlen($parts[1]);$i++)
				{
					switch ($parts[0])
					{
						case 'daily':
							$time+=60*60*24;
							if (!is_null($time2)) $time2+=60*60*24;
							break;
						case 'weekly':
							$time+=60*60*24*7;
							if (!is_null($time2)) $time2+=60*60*24*7;
							break;
						case 'monthly':
							$days_in_month=intval(date('D',mktime(0,0,0,intval(date('m',$time))+1,0,intval(date('Y',$time)))));
							$time+=60*60*$days_in_month;
							if (!is_null($time2)) $time2+=60*60*$days_in_month;
							break;
						case 'yearly':
							$days_in_year=intval(date('Y',mktime(0,0,0,0,0,intval(date('Y',$time))+1)));
							$time+=60*60*24*$days_in_year;
							if (!is_null($time2)) $time2+=60*60*24*$days_in_year;
							break;
					}
					if ($parts[1][$i]!='0')
					{
						echo "DTSTART:".date('Ymd',$time)."\n";
						$recurrence_code='FREQ='.strtoupper($parts[0]);
						echo "RRULE:".$recurrence_code.";INTERVAL=".strval(strlen($parts[1])).";COUNT=1\n";
					}
				}
			}
		} else
		{
			echo "DTSTART:".date('Ymd',$time)."\n";

			if ($GLOBALS['FORUM_DRIVER']->is_staff(get_member()))
			{
				$attendees=$GLOBALS['SITE_DB']->query_select('booking',array('*'),array('bookable_id'=>$event['id']),'',5000/*reasonable limit*/);
				if (count($attendees)==5000) $attendees=array();
				foreach ($attendees as $attendee)
				{
					if (!is_guest($event['member_id']))
						echo "ATTENDEE;CN=".ical_escape($GLOBALS['FORUM_DRIVER']->get_username($attendee['member_id'])).";DIR=".ical_escape($GLOBALS['FORUM_DRIVER']->member_profile_url($attendee['member_id'])).":MAILTO:".ical_escape($GLOBALS['FORUM_DRIVER']->get_member_email_address($attendee['member_id']))."\n";
				}
			}
		}

		echo "END:VEVENT\n";
	}
	echo "END:VCALENDAR\n";
	exit();
}

/**
 * Show bookings ical feed (NB: the event type for this is admins only, unless edited).
 */
function bookings_ical_script()
{
	$pass_ok=get_param('pass','')==md5('booking_salt_'.$GLOBALS['SITE_INFO']['admin_password']);
	if ((!$pass_ok) && (!$GLOBALS['FORUM_DRIVER']->is_super_admin(get_member())))
		access_denied('I_ERROR');

	require_code('calendar_ical');
	require_code('booking');

	@ini_set('ocproducts.xss_detect','0');

	if ($pass_ok)
	{
		header('Content-Type: text/calendar');
		header('Content-Disposition: filename="bookings_export.ics"');
	} // If not, it's an admin testing, so just display contents

	if (function_exists('set_time_limit')) @set_time_limit(0);

	$time=get_param_integer('from',time());
	if ($time<0) $time=time()+60*60*24*$time;

	require_lang('booking');

	$id=get_param_integer('id');
	$where='bookable_id='.strval($id).' AND (b_year>'.date('Y',$time).' OR (b_year='.date('Y',$time).' AND b_month>'.date('m',$time).') OR (b_year='.date('Y',$time).' AND b_month='.date('m',$time).' AND b_day>='.date('d',$time).'))';
	$members_with_bookings=$GLOBALS['SITE_DB']->query('SELECT DISTINCT member_id FROM '.get_table_prefix().'booking WHERE '.$where.' ORDER BY booked_at DESC',10000/*reasonable limit*/);
	echo "BEGIN:VCALENDAR\n";
	echo "VERSION:2.0\n";
	echo "PRODID:-//ocProducts/ocPortal//NONSGML v1.0//EN\n";
	echo "CALSCALE:GREGORIAN\n";
	$bookable_category=get_translated_text($GLOBALS['SITE_DB']->query_value('bookable','title',array('id'=>$id)));
	echo "X-WR-CALNAME:".ical_escape(get_site_name().': '.do_lang('BOOKINGS').': '.$bookable_category)."\n";

	require_code('booking2');
	require_lang('booking');

	$max_time=time();

	foreach ($members_with_bookings as $member_with_booking)
	{
		$bookings=$GLOBALS['SITE_DB']->query('SELECT id FROM '.get_table_prefix().'booking WHERE ('.$where.') AND member_id='.strval($member_with_booking['member_id']).' ORDER BY booked_at DESC',10000/*reasonable limit*/);

		$request=get_booking_request_from_db(collapse_1d_complexity('id',$bookings));

		foreach ($request as $i=>$r)
		{
			$booking=$r['_rows'][0];
			$codes='';
			foreach ($r['_rows'] as $row)
			{
				if ($codes!='') $codes.=', ';
				$codes.=$row['code_allocation'];
			}

			$supplements=$GLOBALS['SITE_DB']->query_select('booking_supplement a JOIN '.get_table_prefix().'bookable_supplement b ON a.supplement_id=b.id',array('quantity','notes','title'),array(
				'booking_id'=>$booking['id'],
			));

			$_url=build_url(array('page'=>'cms_booking','type'=>'_eb','id'=>find_booking_under($booking['member_id'],$booking['id'])),get_module_zone('cms_booking'),NULL,false,false,true);
			$url=$_url->evaluate();

			$time_start=mktime(0,0,0,$r['start_month'],$r['start_day'],$r['start_year']);
			$time_end=mktime(0,0,0,$r['end_month'],$r['end_day']+1,$r['end_year']);
			if ($time_end>$max_time) $max_time=$time_end;

			$description=$booking['notes'];
			foreach ($supplements as $supplement)
			{
				$description.="\n\n+ ".get_translated_text($supplement['title']).'x'.integer_format($supplement['quantity']);
				if ($supplement['notes']!='') $description.=' ('.$supplement['notes'].')';
			}

			for ($j=0;$j<$r['quantity'];$j++)
			{
				echo "BEGIN:VEVENT\n";

				echo "DTSTAMP:".date('Ymd',$booking['booked_at'])."T".date('His',$booking['booked_at'])."\n";
				echo "CREATED:".date('Ymd',$booking['booked_at'])."T".date('His',$booking['booked_at'])."\n";

				echo "SUMMARY:".ical_escape($bookable_category/*do_lang('TAKEN',$codes)*/)."\n";
				echo "DESCRIPTION:".ical_escape($description)."\n";

				if (!is_guest($booking['member_id']))
					echo "ORGANIZER;CN=".ical_escape($GLOBALS['FORUM_DRIVER']->get_username($booking['member_id'])).";DIR=".ical_escape($GLOBALS['FORUM_DRIVER']->member_profile_url($booking['member_id'])).":MAILTO:".ical_escape($GLOBALS['FORUM_DRIVER']->get_member_email_address($booking['member_id']))."\n";
				echo "CATEGORIES:".ical_escape($bookable_category)."\n";
				echo "CLASS:PRIVATE\n";
				echo "STATUS:".(($booking['paid_at']!==NULL)?'CONFIRMED':'TENTATIVE')."\n";
				echo "UID:".ical_escape(strval($booking['id']).'-booking@'.get_base_url())."\n";
				echo "URL:".ical_escape($url)."\n";

				echo "DTSTART:".str_pad($r['start_year'],4,'0',STR_PAD_LEFT).str_pad($r['start_month'],2,'0',STR_PAD_LEFT).str_pad($r['start_day'],2,'0',STR_PAD_LEFT)."\n";
				echo "DTEND:".str_pad($r['end_year'],4,'0',STR_PAD_LEFT).str_pad($r['end_month'],2,'0',STR_PAD_LEFT).str_pad($r['end_day'],2,'0',STR_PAD_LEFT)."\n";
				echo 'TZID:'.get_site_timezone()."\n";

				echo "END:VEVENT\n";
			}
		}
	}

	// Show free slots
	if (get_param_integer('free',0)==1)
	{
		$codes_in_total=collapse_1d_complexity('code',$GLOBALS['SITE_DB']->query_select('bookable_codes',array('code'),array('bookable_id'=>$id)));
		$i=$time;
		$up_to=strtotime('+2 days',$max_time);
		do
		{
			$day=intval(date('d',$i));
			$month=intval(date('m',$i));
			$year=intval(date('Y',$i));
			$codes_taken_already=collapse_1d_complexity('code_allocation',$GLOBALS['SITE_DB']->query_select('booking',array('code_allocation'),array('b_day'=>$day,'b_month'=>$month,'b_year'=>$year)));

			foreach (array_diff($codes_in_total,$codes_taken_already) as $code)
			{
				echo "BEGIN:VEVENT\n";

				echo "DTSTAMP:".date('Ymd',time())."T".date('His',time())."\n";
				echo "CREATED:".date('Ymd',time())."T".date('His',time())."\n";

				echo "SUMMARY:".ical_escape(do_lang('NOT_TAKEN',$code))."\n";

				echo "CATEGORIES:".ical_escape($bookable_category)."\n";
				echo "CLASS:PUBLIC\n";
				echo "STATUS:TENTATIVE\n";
				echo "UID:".ical_escape(strval($day).'/'.strval($month).'/'.strval($year).'-'.$code.'-booking@'.get_base_url())."\n";
				$_url=build_url(array('page'=>'cms_booking','type'=>'ab','bookable_id'=>$id,'day'=>$day,'month'=>$month,'year'=>$year,'code'=>$code),get_module_zone('cms_booking'),NULL,false,false,true);
				$url=$_url->evaluate();
				echo "URL:".ical_escape($url)."\n";

				$time=mktime(0,0,0,$month,$day,$year);
				if ($time>$max_time) $max_time=$time;
				echo "DTSTART:".date('Ymd',$time)."\n";

				echo "END:VEVENT\n";
			}

			$i=strtotime('+1 day',$i);
		}
		while ($i<=$up_to);
	}

	echo "END:VCALENDAR\n";
	exit();
}
