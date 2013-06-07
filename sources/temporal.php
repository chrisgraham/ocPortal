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
 * @package		core
 */

/**
 * Standard code module initialisation function.
 */
function init__temporal()
{
	global $TIMEZONE_MEMBER_CACHE;
	$TIMEZONE_MEMBER_CACHE=array();
}

/**
 * Display a time period of seconds in a tidy human-readable way.
 *
 * @param  integer		Number of seconds
 * @return string			Human-readable period.
 */
function display_seconds_period($seconds)
{
	$hours=intval(floor(floatval($seconds)/60.0/60.0));
	$minutes=intval(floor(floatval($seconds)/60.0))-60*$hours;
	$seconds=$seconds-60*$minutes;

	$out='';
	if ($hours!=0) $out.=str_pad(strval($hours),2,'0',STR_PAD_LEFT).':';
	/*Expected if (($hours!=0) || ($minutes!=0)) */$out.=str_pad(strval($minutes),2,'0',STR_PAD_LEFT).':';
	$out.=str_pad(strval($seconds),2,'0',STR_PAD_LEFT);
	return $out;
}

/**
 * Display a time period in a tidy human-readable way.
 *
 * @param  integer		Number of seconds
 * @return string			Human-readable period.
 */
function display_time_period($seconds)
{
	if ($seconds<0) return '-'.display_time_period(-$seconds);

	if (($seconds<=3*60) && (($seconds%(60)!=0) || ($seconds==0))) return do_lang('SECONDS',integer_format($seconds));
	if (($seconds<=3*60*60) && ($seconds%(60*60)!=0)) return do_lang('MINUTES',integer_format(intval(round(floatval($seconds)/60.0))));
	if (($seconds<=3*60*60*24) && ($seconds%(60*60*24)!=0)) return do_lang('HOURS',integer_format(intval(round(floatval($seconds)/60.0/60.0))));
	return do_lang('DAYS',integer_format(intval(round(floatval($seconds)/60.0/60.0/24.0))));
}

/**
 * Set up the locale filter array from the terse language string specifying it.
 */
function make_locale_filter()
{
	global $LOCALE_FILTER;
	$LOCALE_FILTER=explode(',',do_lang('LOCALE_SUBST'));
	foreach ($LOCALE_FILTER as $i=>$filter)
	{
		if ($filter=='') unset($LOCALE_FILTER[$i]);
		else $LOCALE_FILTER[$i]=explode('=',$filter);
	}
}

/**
 * Get the timezone the server is configured with.
 *
 * @return string			Server timezone in "boring" format.
 */
function get_server_timezone()
{
	global $SERVER_TIMEZONE;
	if (is_string($SERVER_TIMEZONE))
	{
		if ($SERVER_TIMEZONE!='') return $SERVER_TIMEZONE;
	}

	return 'UTC';
}

/**
 * Get the timezone the site is running on.
 *
 * @return string			Site timezone in "boring" format.
 */
function get_site_timezone()
{
	$_timezone_site=get_value('timezone');
	if (is_null($_timezone_site))
	{
		$timezone_site=get_server_timezone();
	}
	elseif (is_numeric($_timezone_site))
	{
		$timezone_site=convert_timezone_offset_to_formal_timezone(floatval($_timezone_site));
		set_value('timezone',$timezone_site);
		set_value('timezone_old_offset',$_timezone_site);
	} else
	{
		$timezone_site=$_timezone_site;
	}
	return $timezone_site;
}

/**
 * Get a user's timezone.
 *
 * @param  ?MEMBER		Member for which the date is being rendered (NULL: current user)
 * @return string			Users timezone in "boring" format.
 */
function get_users_timezone($member=NULL)
{
	if ($member===NULL) $member=get_member();

	global $TIMEZONE_MEMBER_CACHE;
	if (isset($TIMEZONE_MEMBER_CACHE[$member])) return $TIMEZONE_MEMBER_CACHE[$member];

	$timezone=get_param('keep_timezone',NULL);
	if (!is_null($timezone))
	{
		$TIMEZONE_MEMBER_CACHE[$member]=$timezone;
		return $timezone;
	}

	// Get user timezone
	if ((get_forum_type()=='ocf') && (!is_guest($member)))
	{
		$_timezone_member=$GLOBALS['FORUM_DRIVER']->get_member_row_field($member,'m_timezone_offset');
		if (is_integer($_timezone_member))
		{
			// Database upgrade needed
			$GLOBALS['FORUM_DB']->alter_table_field('f_members','m_timezone_offset','SHORT_TEXT');
		}
		if ((is_integer($_timezone_member)) || (is_numeric($_timezone_member))) // Old date, must upgrade
		{
			$_timezone_old_offset=get_value('timezone_old_offset');
			if (is_null($_timezone_old_offset)) $_timezone_old_offset='0';
			$timezone_member=convert_timezone_offset_to_formal_timezone(floatval($_timezone_member)+floatval($_timezone_old_offset));
		} else // Ah, simple: what member has set
		{
			$timezone_member=$_timezone_member;
		}
	} elseif ((function_exists('ocp_admirecookie')) && (get_option('is_on_timezone_detection')=='1') && (get_option('allow_international')=='1'))
	{
		$client_time=ocp_admirecookie('client_time');
		$client_time_ref=ocp_admirecookie('client_time_ref');

		if ((!is_null($client_time)) && (!is_null($client_time_ref))) // If the client-end has set a time cookie (only available on 2ND request) then we can auto-work-out the timezone
		{
			$client_time=preg_replace('# ([A-Z]{3})([\+\-]\d+)?( \([\w\s]+\))?( \d{4})?$#','${4}',$client_time);
			$timezone_dif=(floatval(strtotime($client_time))-(floatval($client_time_ref)))/60.0/60.0;

			$timezone_numeric=round($timezone_dif,1);
			if (abs($timezone_numeric)>100.0) $timezone_numeric=0.0;
			$timezone_member=convert_timezone_offset_to_formal_timezone($timezone_numeric);
		} else
		{
			$timezone_member=get_site_timezone();
		}
	} else // Ah, simple: site's default
	{
		$timezone_member=get_site_timezone();
	}

	$TIMEZONE_MEMBER_CACHE[$member]=$timezone_member;

	return $timezone_member;
}

/**
 * Given a timezone offset, make it into a formal timezone.
 *
 * @param  float			Timezone offset.
 * @return string			Users timezone in "boring" format.
 */
function convert_timezone_offset_to_formal_timezone($offset)
{
	$time_now=time();
	$expected=time()+intval(60*60*$offset);

	$zones=get_timezone_list();
	foreach (array_keys($zones) as $zone)
	{
		$converted=tz_time($time_now,$zone);
		if ($converted==$expected)
		{
			if (tz_time($time_now,get_server_timezone())==$converted) return get_server_timezone(); // Prefer to set the site timezone if it is currently the same
			return $zone;
		}
	}

	// Could not find one

	if (!is_numeric(get_value('timezone'))) return get_site_timezone();
	return get_server_timezone();
}

/**
 * Convert a UTC timestamp to a user timestamp. The user timestamp should not be pumped through get_timezoned_date as this already performs the conversions internally.
 * What complicate understanding of matters is that "user time" is not the timestamp that would exist on a user's PC, as all timestamps are meant to be stored in UTC. "user time" is offsetted to compensate, a virtual construct.
 *
 * @param  ?TIME			Input timestamp (NULL: now)
 * @param  ?MEMBER		Member for which the date is being rendered (NULL: current member)
 * @return TIME			Output timestamp
 */
function utctime_to_usertime($timestamp=NULL,$member=NULL)
{
	if (is_null($timestamp)) $timestamp=time();

	$timezone=get_users_timezone($member);

	return tz_time($timestamp,$timezone);
}

/**
 * Convert a user timestamp to a UTC timestamp. This is not a function to use much- you probably want utctime_to_usertime.
 * What complicate understanding of matters is that "user time" is not the timestamp that would exist on a user's PC, as all timestamps are meant to be stored in UTC. "user time" is offsetted to compensate, a virtual construct.
 *
 * @param  ?TIME			Input timestamp (NULL: now)
 * @param  ?MEMBER		Member for which the date is being rendered (NULL: current member)
 * @return TIME			Output timestamp
 */
function usertime_to_utctime($timestamp=NULL,$member=NULL)
{
	if (is_null($timestamp)) $timestamp=time();

	$timezone=get_users_timezone($member);

	$amount_forward=tz_time($timestamp,$timezone)-$timestamp;
	return $timestamp-$amount_forward;
}

/**
 * Format a local time/date according to locale settings. Combines best features of 'strftime' and 'date'.
 *
 * @param  string	The formatting string.
 * @param  ?TIME	The timestamp (NULL: now). Assumed to already be timezone-shifted as required
 * @return string	The formatted string.
 */
function my_strftime($format,$timestamp=NULL)
{
	if (is_null($timestamp)) $timestamp=time();

	if (strpos(strtolower(PHP_OS),'win')===0)
		$format=str_replace('%e','%#d',$format);
	$ret=strftime(str_replace('%i',date('g',$timestamp),str_replace('%k',date('S',$timestamp),$format)),$timestamp);
	if ($ret===false) $ret='';
	return $ret;
}

/**
 * Get a nice formatted date from the specified Unix timestamp.
 *
 * @param  TIME			Input timestamp
 * @param  boolean		Whether to include the time in the output
 * @param  boolean		Whether to make this a verbose date (longer than usual)
 * @param  boolean		Whether to work in UTC time
 * @param  boolean		Whether contextual dates will be avoided
 * @param  ?MEMBER		Member for which the date is being rendered (NULL: current member)
 * @return string			Formatted time
 */
function get_timezoned_date($timestamp,$include_time=true,$verbose=false,$utc_time=false,$avoid_contextual_dates=false,$member=NULL)
{
	if (is_null($member)) $member=get_member();

	// Work out timezone
	$usered_timestamp=$utc_time?$timestamp:utctime_to_usertime($timestamp,$member);
	$usered_now_timestamp=$utc_time?time():utctime_to_usertime(time(),$member);

	if ($usered_timestamp<0)
	{
		if (@strftime('%Y',@mktime(0,0,0,1,1,1963))!='1963') return 'pre-1970';
	}

	// Render basic date
	$date_string1=($verbose)?do_lang('date_verbose_date'):do_lang('date_regular_date'); // The date renderer string
	$joiner=($verbose)?do_lang('date_verbose_joiner'):do_lang('date_regular_joiner');
	$date_string2=($include_time)?($verbose?do_lang('date_verbose_time'):do_lang('date_regular_time')):''; // The time renderer string
	$ret1=my_strftime($date_string1,$usered_timestamp);
	$ret2=($date_string2=='')?'':my_strftime($date_string2,$usered_timestamp);
	$ret=$ret1.(($ret2=='')?'':($joiner.$ret2));

	// If we can do contextual dates, have our shot
	if (get_option('use_contextual_dates')=='0') $avoid_contextual_dates=true;
	if (!$avoid_contextual_dates)
	{
		$today=my_strftime($date_string1,$usered_now_timestamp);

		if ($ret1==$today) // It is/was today
		{
			$ret=/*do_lang('TODAY').$joiner.*/$ret2;
			if ($ret=='') $ret=do_lang('TODAY'); // it'll be because avoid contextual dates is not on
		} else
		{
			$yesterday=my_strftime($date_string1,$usered_now_timestamp-24*60*60);
			if ($ret1==$yesterday) // It is/was yesterday
			{
				$ret=do_lang('YESTERDAY').(($ret2=='')?'':($joiner.$ret2));
			} else
			{
				$week=my_strftime('%U %Y',$usered_timestamp);
				$now_week=my_strftime('%U %Y',$usered_now_timestamp);
				if ($week==$now_week) // It is/was this week
				{
					$date_string1=do_lang('date_withinweek_date'); // The date renderer string
					$joiner=do_lang('date_withinweek_joiner');
					$date_string2=($include_time)?do_lang('date_regular_time'):''; // The time renderer string
					$ret1=my_strftime($date_string1,$usered_timestamp);
					$ret2=($date_string2=='')?'':my_strftime($date_string2,$usered_timestamp);
					$ret=$ret1.(($ret2=='')?'':($joiner.$ret2));
				} // We could go on, and check for month, and year, but it would serve little value - probably would make the user think more than help.
			}
		}
	}

	return locale_filter($ret);
}

/**
 * Filter locale-tainted strings through the locale filter.
 * Let's pretend a user's operating system doesn't fully support they're locale. They have a nice language pack, but whenever the O.S. is asked for dates in the chosen locale, it puts month names in English instead. The locale_filter function is used to cleanup these problems. It does a simple set of string replaces, as defined by the 'locale_subst' language string.
 *
 * @param  string			Tainted string
 * @return string			Filtered string
 */
function locale_filter($ret)
{
	global $LOCALE_FILTER;
	if ($LOCALE_FILTER===NULL) make_locale_filter();
	foreach ($LOCALE_FILTER as $filter)
		if (count($filter)==2) $ret=str_replace($filter[0],$filter[1],$ret);
	return $ret;
}

/**
 * Get a nice formatted time from the specified Unix timestamp.
 *
 * @param  TIME			Input timestamp
 * @param  boolean		Whether contextual times will be avoided. Note that we don't currently use contextual (relative) times. This parameter may be used in the future.
 * @param  ?MEMBER		Member for which the time is being rendered (NULL: current member)
 * @param  boolean		Whether to work in UTC time
 * @return string			Formatted time
 */
function get_timezoned_time($timestamp,$avoid_contextual_dates=false,$member=NULL,$utc_time=false)
{
	if (is_null($member)) $member=get_member();

	if (get_option('use_contextual_dates')=='0') $avoid_contextual_dates=true;

	$date_string=do_lang('date_withinday');
	$usered_timestamp=$utc_time?$timestamp:utctime_to_usertime($timestamp,$member);
	$ret=my_strftime($date_string,$usered_timestamp);

	return locale_filter($ret);
}

/**
 * Check a POST inputted date for validity, and get the Unix timestamp for the inputted date.
 *
 * @param  ID_TEXT		The stub of the parameter name (stub_year, stub_month, stub_day, stub_hour, stub_minute)
 * @param  boolean		Whether to allow over get parameters also
 * @param  boolean		Whether to do timezone conversion
 * @return ?TIME			The timestamp of the date (NULL: no input date was chosen)
 */
function get_input_date($stub,$get_also=false,$do_timezone_conversion=true)
{
	require_code('temporal2');
	return _get_input_date($stub,$get_also,$do_timezone_conversion);
}

/**
 * For a UTC timestamp, find the equivalent virtualised local timestamp.
 *
 * @param  TIME				UTC time
 * @param  string				Timezone (boring style)
 * @return TIME				Virtualised local time
 */
function tz_time($time,$zone)
{
	if ($zone=='') $zone=get_server_timezone();
	if (function_exists('date_default_timezone_set'))
	{
		@date_default_timezone_set($zone); // @'d because invalid data would otherwise cause a PHP notice
	} else
	{
		@ini_set('date.timezone',$zone);
	}
	$ret=$time+intval(60.0*60.0*floatval(date('O',$time))/100.0);
	if (function_exists('date_default_timezone_set'))
	{
		date_default_timezone_set('UTC');
	} else
	{
		@ini_set('date.timezone','UTC');
	}
	return $ret;
}

/**
 * Get a list of timezones.
 *
 * @return array			Timezone (map between boring-style and human-readable name). Sorted in offset order then likelihood orde.
 */
function get_timezone_list()
{
   return array(
      'Pacific/Niue'=>'(UTC-11:00) Niue, Pago Pago',
      'Pacific/Midway'=>'(UTC-11:00) Midway Island, Samoa',
      'Pacific/Apia'=>'(UTC-11:00) Apia',
      'Pacific/Fakaofo'=>'(UTC-10:00) Fakaofo, Johnston, Rarotonga',
      'America/Adak'=>'(UTC-10:00) Hawaii-Aleutian',
      'Pacific/Honolulu'=>'(UTC-10:00) Hawaii, Honolulu',
      'Pacific/Tahiti'=>'(UTC-10:00) Tahiti',
      'Pacific/Marquesas'=>'(UTC-09:30) Marquesas Islands',
      'America/Juneau'=>'(UTC-09:00) Juneau, Nome, Yakutat',
      'America/Anchorage'=>'(UTC-09:00) Alaska, Anchorage',
      'Pacific/Gambier'=>'(UTC-09:00) Gambier Islands',
      'Pacific/Pitcairn'=>'(UTC-08:00) Pitcairn Islands',
      'America/Tijuana'=>'(UTC-08:00) Baja California, Tijuana',
      'America/Dawson'=>'(UTC-08:00) Dawson, Vancouver, Whitehorse',
      'America/Los_Angeles'=>'(UTC-08:00) Los Angeles, Pacific Time (US & Canada)',
      'America/Boise'=>'(UTC-07:00) Boise',
      'America/Chihuahua'=>'(UTC-07:00) Chihuahua, La Paz (Mexico), Mazatlan',
      'America/Dawson_Creek'=>'(UTC-07:00) Dawson Creek',
      'America/Cambridge_Bay'=>'(UTC-07:00) Cambridge Bay, Edmonton, Inuvik, Yellowknife',
      'America/Denver'=>'(UTC-07:00) Denver, Mountain Time (US & Canada)',
      'America/Hermosillo'=>'(UTC-07:00) Hermosillo',
      'America/Phoenix'=>'(UTC-07:00) Arizona, Phoenix',
      'America/North_Dakota/Center'=>'(UTC-06:00) Center, New Salem',
      'America/Regina'=>'(UTC-06:00) Regina, Saskatchewan',
      'America/Guatemala'=>'(UTC-06:00) Central America, Guatemala',
      'America/Mexico_City'=>'(UTC-06:00) Guadalajara, Mexico City, Monterrey',
      'America/Belize'=>'(UTC-06:00) Belize, Costa Rica, El Salvador, Managua, Swift Current, Tegucigalpa',
      'America/Indiana/Knox'=>'(UTC-06:00) Knox, Menominee, Rainy River, Rankin Inlet, Winnipeg',
      'America/Chicago'=>'(UTC-06:00) Central Time (US & Canada), Chicago',
      'America/Merida'=>'(UTC-06:00) Merida',
      'Pacific/Easter'=>'(UTC-06:00) Easter Island',
      'Pacific/Galapagos'=>'(UTC-06:00) Galapagos',
      'America/Havana'=>'(UTC-05:00) Cuba',
      'America/Atikokan'=>'(UTC-05:00) Atikokan, Cayman, Jamaica, Panama, Port-au-Prince',
      'America/Detroit'=>'(UTC-05:00) Detroit, Grand Turk, Iqaluit, Louisville, Marengo, Monticello',
      'America/Montreal'=>'(UTC-05:00) Montreal, Nassau, Nipigon, Pangnirtung, Petersburg, Thunder Bay',
      'America/Toronto'=>'(UTC-05:00) Toronto, Vevay, Vincennes',
      'America/New_York'=>'(UTC-05:00) Eastern Time (US & Canada), New York',
      'America/Guayaquil'=>'(UTC-05:00) Guayaquil',
      'America/Bogota'=>'(UTC-05:00) Bogota, Lima, Quito',
      'America/Indiana/Indianapolis'=>'(UTC-05:00) Indiana (East), Indianapolis',
      'America/Caracas'=>'(UTC-04:30) Caracas',
      'America/Anguilla'=>'(UTC-04:00) Anguilla, Antigua, Curacao, Montserrat, St. Thomas',
      'Atlantic/Stanley'=>'(UTC-04:00) Faukland Islands',
      'Antarctica/Palmer'=>'(UTC-04:00) Palmer',
      'America/Aruba'=>'(UTC-04:00) Aruba, Barbados, Blanc-Sablon, Dominica, Grenada, Guadeloupe',
      'America/Martinique'=>'(UTC-04:00) Martinique, Port of Spain, Puerto Rico, Santo Domingo, St. Kitts, St. Lucia',
      'America/St_Vincent'=>'(UTC-04:00) St. Vincent, Tortola',
      'America/Goose_Bay'=>'(UTC-04:00) Atlantic Time (Goose Bay), Bermuda, Moncton',
      'America/Halifax'=>'(UTC-04:00) Atlantic Time (Canada), Halifax',
      'America/Boa_Vista'=>'(UTC-04:00) Boa Vista, Eirunepe, Porto Velho, Rio Branco',
      'America/Campo_Grande'=>'(UTC-04:00) Brazil, Cuiaba',
      'America/Manaus'=>'(UTC-04:00) Manaus',
      'America/Guyana'=>'(UTC-04:00) Guyana',
      'America/Thule'=>'(UTC-04:00) Thule',
      'America/Santiago'=>'(UTC-04:00) Santiago',
      'America/Asuncion'=>'(UTC-04:00) Asuncion',
      'America/La_Paz'=>'(UTC-04:00) Georgetown, La Paz (Bolivia), San Juan',
      'America/St_Johns'=>'(UTC-03:30) Newfoundland, St. Johns',
      'America/Argentina/Buenos_Aires'=>'(UTC-03:00) Buenos Aires',
      'America/Argentina/Catamarca'=>'(UTC-03:00) Catamarca, Cordoba, Jujuy, La Rioja, Mendoza, Rio Gallegos',
      'Antarctica/Rothera'=>'(UTC-03:00) Rothera, Tucuman, Ushuaia',
      'America/Araguaina'=>'(UTC-03:00) Araguaina, Bahia, Belem, Fortaleza, Maceio, Recife',
      'America/Sao_Paulo'=>'(UTC-03:00) Brasilia, Sao Paulo',
      'America/Godthab'=>'(UTC-03:00) Greenland',
      'America/Montevideo'=>'(UTC-03:00) Montevideo',
      'America/Cayenne'=>'(UTC-03:00) Cayenne',
      'America/Miquelon'=>'(UTC-03:00) Miquelon, St. Pierre',
      'America/Paramaribo'=>'(UTC-03:00) Paramaribo',
      'Atlantic/South_Georgia'=>'(UTC-02:00) South Georgia',
      'America/Noronha'=>'(UTC-02:00) Mid-Atlantic',
      'Atlantic/Azores'=>'(UTC-01:00) Azores',
      'Atlantic/Cape_Verde'=>'(UTC-01:00) Cape Verde Islands',
      'America/Scoresbysund'=>'(UTC-01:00) Scoresbysund',
      'Africa/El_Aaiun'=>'(UTC) El Aaiun, St. Helena',
      'Atlantic/Madeira'=>'(UTC) Madeira',
      'Europe/London'=>'(UTC) Belfast, Dublin, Edinburgh, Lisbon, London',
      'UTC'=>'(UTC) No daylight saving',
      'Africa/Abidjan'=>'(UTC) Abidjan, Accra, Bamako, Banjul, Bissau, Conakry',
      'Africa/Dakar'=>'(UTC) Dakar, Danmarkshavn, Freetown, Lome, Nouakchott, Ouagadougou',
      'Africa/Sao_Tome'=>'(UTC) Sao Tome',
      'Africa/Monrovia'=>'(UTC) Monrovia, Reykjavik',
      'Africa/Casablanca'=>'(UTC) Casablanca',
      'Atlantic/Canary'=>'(UTC) Canary, Faroe',
      'Europe/Belgrade'=>'(UTC+01:00) Belgrade, Bratislava, Budapest, Ljubljana, Prague',
      'Europe/Warsaw'=>'(UTC+01:00) Sarajevo, Skopje, Warsaw, Zagreb',
      'Europe/Andorra'=>'(UTC+01:00) Andorra, Ceuta, Gibraltar, Luxembourg, Malta, Monaco',
      'Europe/Oslo'=>'(UTC+01:00) Oslo, Tirane, Tunis, Vaduz, Zurich',
      'Africa/Windhoek'=>'(UTC+01:00) Windhoek',
      'Europe/Brussels'=>'(UTC+01:00) Brussels, Copenhagen, Madrid, Paris',
      'Africa/Algiers'=>'(UTC+01:00) Algiers, West Central Africa',
      'Europe/Amsterdam'=>'(UTC+01:00) Amsterdam, Berlin, Bern, Rome, Stockholm, Vienna',
      'Africa/Bangui'=>'(UTC+01:00) Bangui, Brazzaville, Douala, Kinshasa, Lagos, Libreville',
      'Africa/Luanda'=>'(UTC+01:00) Luanda, Malabo, Ndjamena, Niamey, Porto-Novo',
      'Asia/Gaza'=>'(UTC+02:00) Gaza',
      'Europe/Simferopol'=>'(UTC+02:00) Simferopol, Uzhgorod, Zaporozhye',
      'Africa/Bujumbura'=>'(UTC+02:00) Bujumbura, Gaborone, Kigali, Lubumbashi, Lusaka, Maputo',
      'Europe/Minsk'=>'(UTC+02:00) Minsk',
      'Africa/Tripoli'=>'(UTC+02:00) Tripoli',
      'Europe/Chisinau'=>'(UTC+02:00) Chisinau, Kaliningrad, Nicosia, Syria',
      'Africa/Cairo'=>'(UTC+02:00) Cairo',
      'Europe/Helsinki'=>'(UTC+02:00) Helsinki, Kiev, Riga, Sofia, Tallinn, Vilnius',
      'Europe/Athens'=>'(UTC+02:00) Athens, Bucharest, Istanbul',
      'Asia/Jerusalem'=>'(UTC+02:00) Jerusalem',
      'Asia/Amman'=>'(UTC+02:00) Amman',
      'Asia/Beirut'=>'(UTC+02:00) Beirut',
      'Africa/Blantyre'=>'(UTC+02:00) Blantyre, Harare, Pretoria',
      'Africa/Johannesburg'=>'(UTC+02:00) Johannesburg, Maseru, Mbabane',
      'Asia/Kuwait'=>'(UTC+03:00) Kuwait, Riyadh',
      'Asia/Aden'=>'(UTC+03:00) Aden, Bahrain',
      'Asia/Baghdad'=>'(UTC+03:00) Baghdad',
      'Asia/Qatar'=>'(UTC+03:00) Qatar, Syowa',
      'Africa/Nairobi'=>'(UTC+03:00) Nairobi',
      'Africa/Addis_Ababa'=>'(UTC+03:00) Addis Ababa, Antananarivo, Asmara, Comoro, Dar es Salaam, Djibouti',
      'Africa/Kampala'=>'(UTC+03:00) Kampala, Khartoum, Mayotte, Mogadishu',
      'Europe/Moscow'=>'(UTC+03:00) Moscow, St. Petersburg, Volgograd',
      'Asia/Tehran'=>'(UTC+03:30) Tehran',
      'Asia/Dubai'=>'(UTC+04:00) Abu Dhabi, Muscat',
      'Asia/Baku'=>'(UTC+04:00) Baku',
      'Asia/Yerevan'=>'(UTC+04:00) Yerevan',
      'Asia/Tbilisi'=>'(UTC+04:00) Tbilisi',
      'Indian/Mauritius'=>'(UTC+04:00) Mauritius, Port Louis',
      'Indian/Reunion'=>'(UTC+04:00) Reunion',
      'Europe/Samara'=>'(UTC+04:00) Samara',
      'Indian/Mahe'=>'(UTC+04:00) Mahe',
      'Asia/Kabul'=>'(UTC+04:30) Kabul',
      'Indian/Kerguelen'=>'(UTC+05:00) Kerguelen',
      'Indian/Maldives'=>'(UTC+05:00) Maldives',
      'Asia/Karachi'=>'(UTC+05:00) Islamabad, Karachi',
      'Asia/Dushanbe'=>'(UTC+05:00) Dushanbe',
      'Asia/Ashgabat'=>'(UTC+05:00) Ashgabat',
      'Asia/Samarkand'=>'(UTC+05:00) Samarkand',
      'Asia/Tashkent'=>'(UTC+05:00) Tashkent',
      'Asia/Aqtau'=>'(UTC+05:00) Aqtau, Aqtobe',
      'Asia/Oral'=>'(UTC+05:00) Oral',
      'Asia/Yekaterinburg'=>'(UTC+05:00) Ekaterinburg',
      'Asia/Calcutta'=>'(UTC+05:30) Chennai, Kolkata, Mumbai, New Delhi',
      'Asia/Colombo'=>'(UTC+05:30) Colombo, Sri Jayawardenepura',
      'Asia/Katmandu'=>'(UTC+05:45) Kathmandu',
      'Indian/Chagos'=>'(UTC+06:00) Chagos, Mawson, Vostok',
      'Asia/Thimphu'=>'(UTC+06:00) Thimphu',
      'Asia/Dhaka'=>'(UTC+06:00) Astana, Dhaka',
      'Asia/Qyzylorda'=>'(UTC+06:00) Qyzylorda',
      'Asia/Bishkek'=>'(UTC+06:00) Bishkek',
      'Asia/Almaty'=>'(UTC+06:00) Almaty, Novosibirsk',
      'Asia/Omsk'=>'(UTC+06:00) Omsk',
      'Indian/Cocos'=>'(UTC+06:30) Cocos',
      'Asia/Rangoon'=>'(UTC+06:30) Yangon (Rangoon)',
      'Indian/Christmas'=>'(UTC+07:00) Christmas, Davis, Pontianak, Saigon',
      'Asia/Hovd'=>'(UTC+07:00) Hovd',
      'Asia/Krasnoyarsk'=>'(UTC+07:00) Krasnoyarsk',
      'Asia/Phnom_Penh'=>'(UTC+07:00) Phnom Penh, Vientiane',
      'Asia/Bangkok'=>'(UTC+07:00) Bangkok, Hanoi, Jakarta',
      'Antarctica/Casey'=>'(UTC+08:00) Casey, Harbin, Kashgar, Kuching',
      'Asia/Brunei'=>'(UTC+08:00) Brunei',
      'Asia/Makassar'=>'(UTC+08:00) Makassar',
      'Asia/Shanghai'=>'(UTC+08:00) Shanghai',
      'Asia/Hong_Kong'=>'(UTC+08:00) Beijing, Chongqing, Hong Kong, Urumqi',
      'Asia/Macau'=>'(UTC+08:00) Macau',
      'Asia/Irkutsk'=>'(UTC+08:00) Irkutsk, Ulaan Bataar',
      'Asia/Manila'=>'(UTC+08:00) Manila',
      'Asia/Kuala_Lumpur'=>'(UTC+08:00) Kuala Lumpur, Singapore',
      'Asia/Taipei'=>'(UTC+08:00) Taipei',
      'Australia/Perth'=>'(UTC+08:00) Perth',
      'Australia/Eucla'=>'(UTC+08:45) Eucla',
      'Asia/Choibalsan'=>'(UTC+09:00) Choibalsan',
      'Asia/Jayapura'=>'(UTC+09:00) Jayapura',
      'Asia/Pyongyang'=>'(UTC+09:00) Pyongyang',
      'Asia/Seoul'=>'(UTC+09:00) Seoul',
      'Pacific/Palau'=>'(UTC+09:00) Palau',
      'Asia/Dili'=>'(UTC+09:00) Dili',
      'Asia/Tokyo'=>'(UTC+09:00) Osaka, Sapporo, Tokyo',
      'Asia/Yakutsk'=>'(UTC+09:00) Yakutsk',
      'Australia/Darwin'=>'(UTC+09:30) Darwin',
      'Australia/Broken_Hill'=>'(UTC+09:30) Broken Hill',
      'Australia/Adelaide'=>'(UTC+09:30) Adelaide',
      'Antarctica/DumontDUrville'=>'(UTC+10:00) DumontDUrville, Saipan',
      'Australia/Melbourne'=>'(UTC+10:00) Canberra, Melbourne, Sydney',
      'Australia/Currie'=>'(UTC+10:00) Currie, Lindeman',
      'Australia/Brisbane'=>'(UTC+10:00) Brisbane',
      'Asia/Sakhalin'=>'(UTC+10:00) Sakhalin',
      'Australia/Hobart'=>'(UTC+10:00) Hobart',
      'Pacific/Truk'=>'(UTC+10:00) Truk',
      'Asia/Vladivostok'=>'(UTC+10:00) Vladivostok',
      'Pacific/Guam'=>'(UTC+10:00) Guam, Port Moresby',
      'Australia/Lord_Howe'=>'(UTC+10:30) Lord Howe Island',
      'Asia/Magadan'=>'(UTC+11:00) Magadan, New Caledonia, Solomon Islands',
      'Pacific/Kosrae'=>'(UTC+11:00) Kosrae',
      'Pacific/Noumea'=>'(UTC+11:00) Noumea',
      'Pacific/Ponape'=>'(UTC+11:00) Ponape',
      'Pacific/Guadalcanal'=>'(UTC+11:00) Guadalcanal',
      'Pacific/Efate'=>'(UTC+11:00) Efate',
      'Pacific/Norfolk'=>'(UTC+11:30) Norfolk Island',
      'Asia/Anadyr'=>'(UTC+12:00) Anadyr',
      'Pacific/Wake'=>'(UTC+12:00) Wake',
      'Antarctica/McMurdo'=>'(UTC+12:00) McMurdo',
      'Pacific/Fiji'=>'(UTC+12:00) Fiji, Marshall Islands',
      'Pacific/Tarawa'=>'(UTC+12:00) Tarawa',
      'Asia/Kamchatka'=>'(UTC+12:00) Kamchatka',
      'Pacific/Kwajalein'=>'(UTC+12:00) Kwajalein, Majuro',
      'Pacific/Nauru'=>'(UTC+12:00) Nauru',
      'Pacific/Auckland'=>'(UTC+12:00) Auckland, Wellington',
      'Pacific/Funafuti'=>'(UTC+12:00) Funafuti',
      'Pacific/Wallis'=>'(UTC+12:00) Wallis',
      'Pacific/Chatham'=>'(UTC+12:45) Chatham Islands',
      'Pacific/Enderbury'=>'(UTC+13:00) Enderbury',
      'Pacific/Tongatapu'=>'(UTC+13:00) Nuku Alofa, Tongatapu',
      'Pacific/Kiritimati'=>'(UTC+14:00) Kiritimati'
   );
}

/**
 * Turn a boring timezone name into the pretty shortened list of ones Microsoft uses and others now use too.
 *
 * @param  string			Boring name
 * @return string			Nice name
 */
function make_nice_timezone_name($in)
{
	$list=get_timezone_list();
	if (array_key_exists($in,$list)) return $list[$in];
	return $in;
}
