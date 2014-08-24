<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.


 NOTE TO PROGRAMMERS:
   Do not edit this file. If you need to make changes, save your changed file to the appropriate *_custom folder
   **** If you ignore this advice, then your website upgrades (e.g. for bug fixes) will likely kill your changes ****

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		calendar
 */

class Block_side_calendar
{

	/**
	 * Standard modular info function.
	 *
	 * @return ?array	Map of module info (NULL: module is disabled).
	 */
	function info()
	{
		$info=array();
		$info['author']='Chris Graham';
		$info['organisation']='ocProducts';
		$info['hacked_by']=NULL;
		$info['hack_version']=NULL;
		$info['version']=2;
		$info['locked']=false;
		$info['parameters']=array('param','zone','days','title','filter');
		return $info;
	}

	/**
	 * Standard modular cache function.
	 *
	 * @return ?array	Map of cache details (cache_on and ttl) (NULL: module is disabled).
	 */
	function cacheing_environment()
	{
		$info=array();
		$info['cache_on']='array(array_key_exists(\'title\',$map)?$map[\'title\']:NULL,array_key_exists(\'filter\',$map)?explode(",",$map[\'filter\']):NULL,array_key_exists(\'zone\',$map)?$map[\'zone\']:get_module_zone(\'calendar\'),date(\'d\',utctime_to_usertime()),array_key_exists(\'days\',$map)?$map[\'days\']:\'30\',array_key_exists(\'param\',$map)?$map[\'param\']:\'year\',date(\'Y-m\',utctime_to_usertime()))';
		$info['ttl']=60*24;
		return $info;
	}

	/**
	 * Standard modular run function.
	 *
	 * @param  array		A map of parameters.
	 * @return tempcode	The result of execution.
	 */
	function run($map)
	{
		require_code('calendar');
		require_lang('calendar');
		require_lang('dates');
		require_css('calendar');

		$year=intval(date('Y',utctime_to_usertime()));
		$month=intval(date('m',utctime_to_usertime()));
		$day=intval(date('d',utctime_to_usertime()));

		$zone=array_key_exists('zone',$map)?$map['zone']:get_module_zone('calendar');

		$filter_map=array_key_exists('filter',$map)?explode(",",$map['filter']):NULL;

		$filter=$this->get_filter($filter_map);

		//if(!is_null($filter_str)) $filter=explode(",",$filter_str):NULL;

		$box_title=array_key_exists('title',$map)?$map['title']:do_lang_tempcode('COMING_SOON');

		$calendar_url=build_url($filter+array('page'=>'calendar','type'=>'misc','view'=>'month','id'=>strval($year).'-'.strval($month)),$zone);

		$member=$GLOBALS['FORUM_DRIVER']->get_guest_id();

		$type=array_key_exists('param',$map)?$map['param']:'year';

		if ($type!='listing')
		{
			$period_start=mktime(0,0,0,$month,1,$year);
			$period_end=mktime(23,59,0,$month+1,0,$year);

			$happenings=calendar_matches($member,true,$period_start,$period_end,$filter);

			$entries=array();
			$priorities=array();

			for ($hap_i=0;$hap_i<count($happenings);$hap_i++)
			{
				$happening=$happenings[$hap_i];

				list($e_id,$event,$from,$to,$real_from,$real_to)=$happening;

				$view_id=date('Y-m',$real_from);

				if (is_numeric($e_id))
				{
					$map2=$filter+array('page'=>'calendar','type'=>'view','id'=>$event['e_id'],'day'=>$day,'date'=>$view_id,'back'=>'month');
					$url=build_url($map2,$zone);
				} else
				{
					$url=$e_id;
				}
				$icon=$event['t_logo'];
				$title=is_integer($event['e_title'])?get_translated_text($event['e_title']):$event['e_title'];
				$date=locale_filter(date(do_lang('calendar_date'),$real_from));
				$_day=intval(date('d',$from));
				if (!array_key_exists($_day,$entries))
				{
					$entries[$_day]=array('ID'=>strval($event['e_id']),'T_TITLE'=>array_key_exists('t_title',$event)?(is_string($event['t_title'])?$event['t_title']:get_translated_text($event['t_title'])):'RSS','PRIORITY'=>strval($event['e_priority']),'ICON'=>$icon,'TIME'=>$date,'TITLE'=>$title,'URL'=>$url);
					$priorities[$_day]=$event['e_priority'];
				} else
				{
					$entries[$_day]=(is_array($entries[$_day]))?2:($entries[$_day]+1);
					$priorities[$_day]=min($priorities[$_day],$event['e_priority']);
				}

				if (!is_null($to))
				{
					$test=date('d',$to);
					$test2=date('d',$from);
					if (((intval($test)>intval($test2)) || (intval(date('m',$to))!=intval(date('m',$from))) || (intval(date('Y',$to))!=intval(date('Y',$from)))))
					{
						$ntime=mktime(0,0,0,intval(date('m',$from)),intval($test2)+1,intval(date('Y',$from)));
						if ($ntime<$period_end)
							$happenings[]=array($e_id,$event,$ntime,$to,$real_from,$real_to);
					}
				}
			}

			$_period_start=mktime(0,0,0,$month,1,$year);
			$_period_end=mktime(0,0,0,$month+1,0,$year);
			$_days=intval(round(floatval($_period_end-$_period_start)/floatval(60*60*24)));

			$_entries=new ocp_tempcode();
			$__entries=new ocp_tempcode();
			$_dotw=date('D',$_period_start); // date() does not use locale so this is safe
			if (get_option('ssw')=='0')
			{
				$ex_array=array('Mon'=>0,'Tue'=>1,'Wed'=>2,'Thu'=>3,'Fri'=>4,'Sat'=>5,'Sun'=>6);
			} else
			{
				$ex_array=array('Sun'=>0,'Mon'=>1,'Tue'=>2,'Wed'=>3,'Thu'=>4,'Fri'=>5,'Sat'=>6);
			}
			$dotw=$ex_array[$_dotw];
			for ($j=0;$j<$dotw;$j++)
				$__entries->attach(do_template('CALENDAR_YEAR_MONTH_DAY_SPACER'));
			for ($j=1;$j<=$_days+1;$j++)
			{
				$date=strval($year).'-'.str_pad(strval($month),2,'0',STR_PAD_LEFT).'-'.str_pad(strval($j),2,'0',STR_PAD_LEFT);
				$date_formatted=locale_filter(date(do_lang('calendar_date'),mktime(0,0,0,$month,$j,$year)));
				$map2=$filter+array('page'=>'calendar','type'=>'misc','view'=>'day','id'=>$date);
				$day_url=build_url($map2,$zone);

				if (!array_key_exists($j,$entries))
				{
					$class='free_time';
					$__entries->attach(do_template('CALENDAR_YEAR_MONTH_DAY_FREE',array('_GUID'=>'d9ac194adf9fef87f3ee0161f0582b88','CURRENT'=>date('Y-m-d',utctime_to_usertime())==$date,'DAY_URL'=>$day_url,'DATE'=>$date_formatted,'DAY'=>strval($j),'CLASS'=>$class)));
				}
				elseif (is_array($entries[$j]))
				{
					$class='single';
					$events_and_priority_lang=do_lang_tempcode('TOTAL_EVENTS_AND_HIGHEST_PRIORITY','1',do_lang_tempcode('PRIORITY_'.strval($priorities[$j])));
					$__entries->attach(do_template('CALENDAR_YEAR_MONTH_DAY_ACTIVE',array_merge(array('CURRENT'=>date('Y-m-d',utctime_to_usertime())==$date,'DAY_URL'=>$day_url,'DATE'=>$date_formatted,'DAY'=>strval($j),'CLASS'=>$class,'COUNT'=>'1','EVENTS_AND_PRIORITY_LANG'=>$events_and_priority_lang),$entries[$j])));
				}
				else
				{
					$class='multiple';
					$e_count=integer_format($entries[$j]);
					$events_and_priority_lang=do_lang_tempcode('TOTAL_EVENTS_AND_HIGHEST_PRIORITY',make_string_tempcode($e_count),do_lang_tempcode('PRIORITY_'.strval($priorities[$j])));
					$__entries->attach(do_template('CALENDAR_YEAR_MONTH_DAY_ACTIVE',array('_GUID'=>'2190cdba146d5d18c01033fd0d9a09a1','CURRENT'=>date('Y-m-d',utctime_to_usertime())==$date,'DAY_URL'=>$day_url,'DATE'=>$date_formatted,'TITLE'=>'','TIME'=>'','URL'=>'','ID'=>'','PRIORITY'=>strval($priorities[$j]),'DAY'=>strval($j),'ICON'=>'','COUNT'=>$e_count,'EVENTS_AND_PRIORITY_LANG'=>$events_and_priority_lang)));
				}

				if ($dotw==6)
				{
					$_entries->attach(do_template('CALENDAR_YEAR_MONTH_DAY_ROW',array('_GUID'=>'4b4b1e5bcf541c66d1ba9a57c6521070','ENTRIES'=>$__entries)));
					$__entries=new ocp_tempcode();
					$dotw=0;
				} else $dotw++;
			}

			if (!$__entries->is_empty())
			{
				for ($j=$dotw;$j<7;$j++)
					$__entries->attach(do_template('CALENDAR_YEAR_MONTH_DAY_SPACER'));
				$_entries->attach(do_template('CALENDAR_YEAR_MONTH_DAY_ROW',array('_GUID'=>'262279cb164be0fa908ec57c27dd727b','ENTRIES'=>$__entries)));
			}

			return do_template('BLOCK_SIDE_CALENDAR',array('_GUID'=>'1324e98b4debf7ebd6d398fae65fe29f','CALENDAR_URL'=>$calendar_url,'ENTRIES'=>$_entries,'_MONTH'=>strval($_period_start),'MONTH'=>locale_filter(my_strftime(do_lang('calendar_month_in_year'),$_period_start))));
		}

		// Listing mode

		$period_start=mktime(0,0,0,$month,$day,$year);
		$num_days=array_key_exists('days',$map)?intval($map['days']):30;
		$period_end=$period_start+60*60*24*$num_days;

		$happenings=calendar_matches($member,true,$period_start-100*60*60*24,$period_end,$filter);

		$days=array();
		for ($hap_i=0;$hap_i<count($happenings);$hap_i++)
		{
			$happening=$happenings[$hap_i];

			list($e_id,$event,$from,$to,$real_from,$real_to)=$happening;

			if ((!is_null($to)) && ($to<$period_start)) continue;
			if ($real_from!=$from) continue; // We won't render continuations

			// Because we looked 100 days before (to find stuff that might be doing a span), we need to do an extra check to see if stuff is actually in our true window
			$starts_within=(($real_from>=$period_start) && ($real_from<$period_end));
			$ends_within=((!is_null($to)) && ($real_to>$period_start) && ($real_to<=$period_end));
			$spans=((!is_null($to)) && ($real_from<$period_start) && ($real_to>$period_end));
			if (!$starts_within && !$ends_within && !$spans) continue;

			$__day=date('Y-m-d',$from);
			$bits=explode('-',$__day);
			$day_start=mktime(12,0,0,intval($bits[1]),intval($bits[2]),intval($bits[0]));
			if (!array_key_exists($day_start,$days))
			{
				$date_section=get_timezoned_date($day_start,false); // Must be rendered in user's timezone not GMT, as GMT day may be ahead of the user's timezoned day and hence render the wrong contextual date.
				if ($from<$period_start)
					$date_section=do_lang('DATE_IN_PAST',$date_section);
				$days[$day_start]=array('TIMESTAMP'=>strval($day_start),'TIME'=>$date_section,'EVENTS'=>array());
			}

			$view_id=date('Y-m',$real_from);

			$icon=$event['t_logo'];
			$title=is_integer($event['e_title'])?get_translated_text($event['e_title']):$event['e_title'];
			if (is_numeric($e_id))
			{
				$map2=$filter+array('page'=>'calendar','type'=>'view','id'=>$event['e_id'],'day'=>$__day,'date'=>$view_id,'back'=>'month');
				$view_url=build_url($map2,$zone);
			} else
			{
				$view_url=$e_id;
			}
			$days[$day_start]['EVENTS'][]=array(
				'DESCRIPTION'=>is_string($event['e_content'])?protect_from_escaping($event['e_content']):get_translated_tempcode($event['e_content']),
				'TIMESTAMP'=>strval($real_from),
				'TIME'=>($real_from!=$from)?do_lang('EVENT_CONTINUES'):(is_null($event['e_start_hour'])?do_lang_tempcode('ALL_DAY_EVENT'):make_string_tempcode(get_timezoned_time($real_from,false,NULL,true))),
				'TIME_RAW'=>strval($real_from),
				'FROM_DAY'=>get_timezoned_date($real_from,!is_null($event['e_start_hour']),false,true),
				'TO_DAY'=>is_null($real_to)?NULL:get_timezoned_date($real_to,!is_null($event['e_end_hour']),false,true),
				'TO_DAY_RAW'=>is_null($real_to)?'':strval($real_to),
				'TIME_VCAL'=>date('Y-m-d',$real_from).' '.date('H:i:s',$real_from),
				'TO_TIME_VCAL'=>is_null($real_to)?NULL:(date('Y-m-d',$real_to).' '.date('H:i:s',$real_to)),
				'T_TITLE'=>array_key_exists('t_title',$event)?(is_string($event['t_title'])?$event['t_title']:get_translated_text($event['t_title'])):'RSS',
				'TITLE'=>is_string($event['e_title'])?protect_from_escaping($title):make_string_tempcode($title),
				'VIEW_URL'=>$view_url,
				'ICON'=>$icon,
			);

			$test=date('d',$to);
			$test2=date('d',$from);
			if ((!is_null($to)) && ((intval($test)>intval($test2)) || (intval(date('m',$to))!=intval(date('m',$from))) || (intval(date('Y',$to))!=intval(date('Y',$from)))))
			{
				$ntime=mktime(0,0,0,intval(date('m',$from)),intval($test2)+1,intval(date('Y',$from)));
				if ($ntime<$period_end)
					$happenings[]=array($e_id,$event,$ntime,$to,$real_from,$real_to);
			}
		}

		return do_template('BLOCK_SIDE_CALENDAR_LISTING',array('_GUID'=>'52afb27d866fa6b620a55d223e2fd3ae','DAYS'=>$days,'CALENDAR_URL'=>$calendar_url,'TITLE'=>$box_title));
	}

	/**
	 * Gets the type filter, if there is one.
	 *
	 * @param  array			What to filter according to block parameters
	 * @return array			The filter
	 */
	function get_filter($filter_map)
	{	
		$filter=array();

		if(!is_array($filter_map)) return $filter;

		$some_pos=false;

		$types=$GLOBALS['SITE_DB']->query_select('calendar_types',array('id'));

		foreach ($types as $type)
		{
			$t=$type['id'];
			$filter['int_'.strval($t)]=get_param_integer('int_'.strval($t),0);
			if (in_array(strval($type['id']),$filter_map)) $filter['int_'.strval($t)]=1;
			if ($filter['int_'.strval($t)]==1) $some_pos=true;
		}

		return $some_pos?$filter:array();
	}
}


