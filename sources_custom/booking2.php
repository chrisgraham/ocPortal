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

/*
This file deals specifically with maintaining the bookables, not specific bookings for them.
*/

/**
 * Get a do-next manager for bookings.
 *
 * @return tempcode	Booking do-next manager.
 */
function booking_do_next()
{
	require_lang('calendar');
	require_code('templates_donext');
	require_code('fields');
	return do_next_manager(get_screen_title('BOOKINGS'),comcode_lang_string('DOC_BOOKING'),
				array(
					/*	 type							  page	 params													 zone	  */
					has_specific_permission(get_member(),'submit_cat_highrange_content','cms_booking')?array('bookable',array('_SELF',array('type'=>'ad'),'_SELF'),do_lang('ADD_BOOKABLE')):NULL,
					has_specific_permission(get_member(),'edit_cat_highrange_content','cms_booking')?array('bookable',array('_SELF',array('type'=>'ed'),'_SELF'),do_lang('EDIT_BOOKABLE')):NULL,
					has_specific_permission(get_member(),'submit_cat_highrange_content','cms_booking')?array('supplement',array('_SELF',array('type'=>'av'),'_SELF'),do_lang('ADD_BOOKABLE_SUPPLEMENT')):NULL,
					has_specific_permission(get_member(),'edit_cat_highrange_content','cms_booking')?array('supplement',array('_SELF',array('type'=>'ev'),'_SELF'),do_lang('EDIT_BOOKABLE_SUPPLEMENT')):NULL,
					has_specific_permission(get_member(),'submit_cat_highrange_content','cms_booking')?array('blacked',array('_SELF',array('type'=>'ac'),'_SELF'),do_lang('ADD_BOOKABLE_BLACKED')):NULL,
					has_specific_permission(get_member(),'edit_cat_highrange_content','cms_booking')?array('blacked',array('_SELF',array('type'=>'ec'),'_SELF'),do_lang('EDIT_BOOKABLE_BLACKED')):NULL,
					has_specific_permission(get_member(),'submit_highrange_content','cms_booking')?array('booking',array('_SELF',array('type'=>'ab'),'_SELF'),do_lang('ADD_BOOKING')):NULL,
					has_specific_permission(get_member(),'edit_highrange_content','cms_booking')?array('booking',array('_SELF',array('type'=>'eb'),'_SELF'),do_lang('EDIT_BOOKING')):NULL,
					has_actual_page_access(get_member(),'calendar')?array('calendar',array('calendar',array('type'=>'misc','view'=>'month'),'_SEARCH'),do_lang('CALENDAR')):NULL,
				),
				do_lang('BOOKINGS')
	);
}

/**
 * For a member, find reconstituted booking request details for all bookings.
 *
 * @param  MEMBER		Member to find for.
 * @return array		Reconstituted booking details structure to check.
 */
function get_member_booking_request($member_id)
{
	$booking_ids=$GLOBALS['SITE_DB']->query_select('booking',array('id'),array('member_id'=>$member_id),'ORDER BY booked_at DESC');
	return get_booking_request_from_db(collapse_1d_complexity('id',$booking_ids));
}

/**
 * For a list of booking IDs (assumed to be from same member), reconstitute/simplify as much as possible, and return the booking details structure.
 *
 * @param  array		List of booking IDs.
 * @return array		Reconstituted booking details structure to check.
 */
function get_booking_request_from_db($booking_ids)
{
	$request=array();

	foreach ($booking_ids as $booking_id)
	{
		$booking=$GLOBALS['SITE_DB']->query_select('booking',array('*'),array('id'=>$booking_id),'',1);
		if (!array_key_exists(0,$booking)) warn_exit(do_lang_tempcode('MISSING_RESOURCE'));

		$supplements=$GLOBALS['SITE_DB']->query_select('booking_supplement',array('supplement_id','quantity','notes'),array('booking_id'=>$booking_id));

		$request[]=array(
			'bookable_id'=>$booking[0]['bookable_id'],
			'start_day'=>$booking[0]['b_day'],
			'start_month'=>$booking[0]['b_month'],
			'start_year'=>$booking[0]['b_year'],
			'end_day'=>$booking[0]['b_day'],
			'end_month'=>$booking[0]['b_month'],
			'end_year'=>$booking[0]['b_year'],
			'notes'=>$booking[0]['notes'],
			'supplements'=>list_to_map('supplement_id',$supplements),
			'quantity'=>1,
			'_rows'=>array($booking[0]), // Used by code that wants exact details, not standard part of booking details structure
		);
	}

	reconstitute_booking_requests($request);

	return $request;
}

/**
 * From single booking details, convert it into a reconstituted structure.
 *
 * @param  array		Booking details structure to check.
 * @return boolean	Whether any changes happened.
 */
function reconstitute_booking_requests(&$request)
{
	$changes=false;

	// Sort, so that we know we only merge when things are consecutive
	global $M_SORT_KEY;
	$M_SORT_KEY='bookable_id,start_year,start_month,start_day';
	usort($request,'multi_sort');

	$all_supplements=collapse_2d_complexity('id','price_is_per_period',$GLOBALS['SITE_DB']->query_select('bookable_supplement',array('id','price_is_per_period')));

	// Scan through, merging same things together and updating quantity
	for ($i=0;$i<count($request);$i++)
	{
		asort($request[$i]['supplements']);

		if ($i!=0)
		{
			$a=&$request[$i-1];
			$b=&$request[$i];

			if (($a['bookable_id']==$b['bookable_id']) && ($a['start_day']==$b['start_day']) && ($a['start_month']==$b['start_month']) && ($a['start_year']==$b['start_year']) && ($a['end_day']==$b['end_day']) && ($a['end_month']==$b['end_month']) && ($a['end_year']==$b['end_year']) && ($a['supplements']==$b['supplements']))
			{
				$a['quantity']+=$b['quantity'];
				$a['_rows']=array_merge($a['_rows'],$b['_rows']);
				unset($request[$i]);
				$request=array_values($request);
				$i--;

				$changes=true;
			}
		}
	}

	// Scan through, merging consequtive days on same bookable into sequences
	for ($i=0;$i<count($request);$i++)
	{
		if ($i!=0)
		{
			$a=&$request[$i-1];
			$b=&$request[$i];

			// List just those supplements which are per-period, so we can assure that the same ones are taken for both $a and $b (hence mergeable). If so we merge all, knowing the one-offs should be merged also.
			$a_filtered_supplements=$a['supplements'];
			foreach (array_keys($a_filtered_supplements) as $supplement_id)
			{
				if ($all_supplements[$supplement_id]==0) unset($a_filtered_supplements[$supplement_id]);
			}
			$b_filtered_supplements=$b['supplements'];
			foreach (array_keys($b_filtered_supplements) as $supplement_id)
			{
				if ($all_supplements[$supplement_id]==0) unset($b_filtered_supplements[$supplement_id]);
			}

			$a_end_timestamp=mktime(0,0,0,$a['end_month'],$a['end_day'],$a['end_year']);
			$b_start_timestamp=mktime(0,0,0,$b['start_month'],$b['start_day'],$b['start_year']);

			if (($a['bookable_id']==$b['bookable_id']) && ($a['quantity']==$b['quantity']) && (strtotime('+1 day',$a_end_timestamp)==$b_start_timestamp) && ($a_filtered_supplements==$b_filtered_supplements))
			{
				$a['end_day']=$b['end_day'];
				$a['end_month']=$b['end_month'];
				$a['end_year']=$b['end_year'];
				$a['supplements']+=$b['supplements'];
				$a['_rows']=array_merge($a['_rows'],$b['_rows']);
				if (($b['notes']!='') && (strpos($a['notes'],$b['notes'])===false)) $a['notes'].="\n\n".$b['notes'];
				unset($request[$i]);
				$request=array_values($request);
				$i--;

				$changes=true;
			}
		}
	}

	return $changes;
}

/**
 * Find the future booking(s) IDs owned by a member.
 *
 * @param  ?MEMBER	Member ID (NULL: current user).
 * @return array		Booking IDs.
 */
function get_future_member_booking_ids($member=NULL)
{
	if (is_null($member)) $member=get_member();

	$day=intval(date('d'));
	$month=intval(date('m'));
	$year=intval(date('Y'));

	$booking_ids=$GLOBALS['SITE_DB']->query('SELECT * FROM '.get_table_prefix().'booking WHERE member_id='.strval($member).' AND (year>'.strval($year).' OR year='.strval($year).' AND month>'.strval($month).' OR year='.strval($year).' AND month='.strval($month).' AND day>='.strval($day).')');
	return $booking_ids;
}

/**
 * Delete a specific booking. To edit a booking you need to delete then re-add.
 *
 * @param  AUTO_LINK	Booking ID.
 */
function delete_booking($id)
{
	$GLOBALS['SITE_DB']->query_delete('booking',array('id'=>$id),'',1);
	$GLOBALS['SITE_DB']->query_delete('booking_supplement',array('booking_id'=>$id));
}

/**
 * Read bookable details from POST environment.
 *
 * @return array		Tuple:  bookable_details, blacked, codes, supplements.
 */
function get_bookable_details_from_form()
{
	$active_from=get_input_date('active_from');
	$active_to=get_input_date('active_to');
	if (!is_null($active_to))
	{
		if ($active_to<$active_from) warn_exit(do_lang_tempcode('DATE_AROUND'));
	}

	require_code('ecommerce');

	$bookable_details=array(
		'title'=>post_param('title'),
		'description'=>post_param('description'),
		'price'=>floatval(str_replace(ecommerce_get_currency_symbol(),'',post_param('price'))),
		'categorisation'=>post_param('categorisation'),
		'cycle_type'=>post_param('cycle_type'),
		'cycle_pattern'=>post_param('cycle_pattern'),
		'user_may_choose_code'=>post_param_integer('user_may_choose_code',0),
		'supports_notes'=>post_param_integer('supports_notes',0),
		'dates_are_ranges'=>post_param_integer('dates_are_ranges',0),

		'enabled'=>post_param_integer('enabled',0),
		'sort_order'=>post_param_integer('sort_order'),

		'active_from_day'=>intval(date('d',$active_from)),
		'active_from_month'=>intval(date('m',$active_from)),
		'active_from_year'=>intval(date('Y',$active_from)),
		'active_to_day'=>is_null($active_to)?NULL:intval(date('d',$active_to)),
		'active_to_month'=>is_null($active_to)?NULL:intval(date('m',$active_to)),
		'active_to_year'=>is_null($active_to)?NULL:intval(date('Y',$active_to)),
	);

	/*$blacked=array();
	$supplements=array();
	foreach (array_keys($_POST) as $key)
	{
		if (substr($key,0,8)=='blacked_')
		{
			if (post_param_integer($key,0)==1)
				$blacked[]=intval(substr($key,8));
		}

		if (substr($key,0,11)=='supplement_')
		{
			if (post_param_integer($key,0)==1)
				$supplements[]=intval(substr($key,11));
		}
	}*/
	if (!isset($_POST['blacked'])) $_POST['blacked']=array();
	$blacked=array_map('intval',$_POST['blacked']);
	if (!isset($_POST['supplements'])) $_POST['supplements']=array();
	$supplements=array_map('intval',$_POST['supplements']);

	$codes=explode("\n",post_param('codes',''));
	if ((count($codes)==1) && (is_numeric($codes[0])))
	{
		$codes=generate_random_booking_codes(intval($codes[0]));
	}

	return array($bookable_details,$codes,$blacked,$supplements);
}

/**
 * Generate a new set of booking codes.
 *
 * @param  integer	How many codes to generate.
 * @return array		The generated codes.
 */
function generate_random_booking_codes($num)
{
	$codes=array();
	while (count($codes)<$num)
	{
		$codes[substr(md5(uniqid('ocp_booking_',true)),0,5)]=1;
	}
	return array_keys($codes);
}

/**
 * Read supplement details from POST environment.
 *
 * @return array		Tuple: Supplement details, list of bookables.
 */
function get_bookable_supplement_details_from_form()
{
	if (!isset($_POST['bookables'])) $_POST['bookables']=array();
	$bookables=array_map('intval',$_POST['bookables']);

	return array(array(
		'price'=>floatval(post_param('price')),
		'price_is_per_period'=>post_param_integer('price_is_per_period',0),
		'supports_quantities'=>post_param_integer('supports_quantities',0),
		'title'=>post_param('title'),
		'promo_code'=>post_param('promo_code'),
		'supports_notes'=>post_param_integer('supports_notes',0),
		'sort_order'=>post_param_integer('sort_order'),
	),$bookables);
}

/**
 * Read blacked details from POST environment.
 *
 * @return array		Tuple: Blacked details, list of bookables.
 */
function get_bookable_blacked_details_from_form()
{
	if (!isset($_POST['bookables'])) $_POST['bookables']=array();
	$bookables=array_map('intval',$_POST['bookables']);

	$blacked_from=get_input_date('blacked_from');
	$blacked_to=get_input_date('blacked_to');

	if ($blacked_to<$blacked_from) warn_exit(do_lang_tempcode('DATE_AROUND'));

	return array(array(
		'blacked_from_day'=>intval(date('d',$blacked_from)),
		'blacked_from_month'=>intval(date('m',$blacked_from)),
		'blacked_from_year'=>intval(date('Y',$blacked_from)),
		'blacked_to_day'=>intval(date('d',$blacked_to)),
		'blacked_to_month'=>intval(date('m',$blacked_to)),
		'blacked_to_year'=>intval(date('Y',$blacked_to)),
		'blacked_explanation'=>post_param('blacked_explanation'),
	),$bookables);
}

/**
 * Add a bookable.
 *
 * @param  array		Bookable details.
 * @param  array		List of codes.
 * @param  ?array		List of black-outs (NULL: none).
 * @param  ?array		List of supplements (NULL: none).
 * @param  ?TIME		Add date (NULL: now).
 * @param  ?MEMBER	Submitting user (NULL: current user).
 * @return AUTO_LINK	Bookable ID.
 */
function add_bookable($bookable_details,$codes,$blacked=NULL,$supplements=NULL,$add_date=NULL,$submitter=NULL)
{
	if (is_null($blacked)) $blacked=array();
	if (is_null($supplements)) $supplements=array();

	if (is_null($add_date)) $add_date=time();
	if (is_null($submitter)) $submitter=get_member();

	$title=$bookable_details['title'];

	$bookable_details['title']=insert_lang($bookable_details['title'],1);
	$bookable_details['description']=insert_lang($bookable_details['description'],1);
	$bookable_details['categorisation']=insert_lang($bookable_details['categorisation'],1);

	$bookable_details['calendar_type']=NULL;
	$bookable_details['add_date']=$add_date;
	$bookable_details['edit_date']=NULL;
	$bookable_details['submitter']=$submitter;

	$bookable_id=$GLOBALS['SITE_DB']->query_insert('bookable',$bookable_details,true);

	require_code('calendar2');
	$external_feed=find_script('bookings_ical').'?id='.strval($bookable_id).'&pass='.md5('booking_salt_'.$GLOBALS['SITE_INFO']['admin_password']);
	$bookable_details['calendar_type']=add_event_type($title,'calendar/booking',$external_feed);

	$GLOBALS['SITE_DB']->query_update('bookable',array('calendar_type'=>$bookable_details['calendar_type']),array('id'=>$bookable_id),'',1);

	foreach ($blacked as $blacked_id)
	{
		$GLOBALS['SITE_DB']->query_insert('bookable_blacked_for',array(
			'blacked_id'=>$blacked_id,
			'bookable_id'=>$bookable_id,
		));
	}

	foreach ($codes as $code)
	{
		$GLOBALS['SITE_DB']->query_insert('bookable_codes',array(
			'bookable_id'=>$bookable_id,
			'code'=>$code,
		));
	}

	foreach ($supplements as $supplement_id)
	{
		$GLOBALS['SITE_DB']->query_insert('bookable_supplement_for',array(
			'supplement_id'=>$supplement_id,
			'bookable_id'=>$bookable_id,
		));
	}

	log_it('ADD_BOOKABLE',strval($bookable_id),$title);

	return $bookable_id;
}

/**
 * Edit a bookable.
 *
 * @param  AUTO_LINK	Bookable ID.
 * @param  array		Bookable details.
 * @param  array		List of codes.
 * @param  ?array		List of black-outs (NULL: no change).
 * @param  ?array		List of supplements (NULL: no change).
 */
function edit_bookable($bookable_id,$bookable_details,$codes,$blacked=NULL,$supplements=NULL)
{
	$_old_bookable=$GLOBALS['SITE_DB']->query_select('bookable',array('*'),array('id'=>$bookable_id),'',1);
	if (!array_key_exists(0,$_old_bookable)) warn_exit(do_lang_tempcode('MISSING_RESOURCE'));

	$title=$bookable_details['title'];

	$bookable_details['title']=lang_remap($_old_bookable[0]['title'],$bookable_details['title']);
	$bookable_details['description']=lang_remap($_old_bookable[0]['description'],$bookable_details['description']);
	$bookable_details['categorisation']=lang_remap($_old_bookable[0]['categorisation'],$bookable_details['categorisation']);

	$bookable_details['edit_date']=time();

	$bookable_details['calendar_type']=$_old_bookable[0]['calendar_type'];
	require_code('calendar2');
	$external_feed=find_script('bookings_ical').'?id='.strval($bookable_id).'&pass='.md5('booking_salt_'.$GLOBALS['SITE_INFO']['admin_password']);
	if ((is_null($bookable_details['calendar_type'])) && (is_null($GLOBALS['SITE_DB']->query_value_null_ok('calendar_types','id',array('id'=>$bookable_details['calendar_type'])))))
	{
		$bookable_details['calendar_type']=add_event_type($title,'calendar/booking',$external_feed);
	} else
	{
		edit_event_type($bookable_details['calendar_type'],$title,'calendar/booking',$external_feed);
	}

	$GLOBALS['SITE_DB']->query_update('bookable',$bookable_details,array('id'=>$bookable_id),'',1);

	$GLOBALS['SITE_DB']->query_delete('bookable_codes',array('bookable_id'=>$bookable_id));
	foreach ($codes as $code)
	{
		$GLOBALS['SITE_DB']->query_insert('bookable_codes',array(
			'bookable_id'=>$bookable_id,
			'code'=>$code,
		));
	}

	if (!is_null($blacked))
	{
		$GLOBALS['SITE_DB']->query_delete('bookable_blacked_for',array('bookable_id'=>$bookable_id));
		foreach ($blacked as $blacked_id)
		{
			$GLOBALS['SITE_DB']->query_insert('bookable_blacked_for',array(
				'blacked_id'=>$blacked_id,
				'bookable_id'=>$bookable_id,
			));
		}
	}

	if (!is_null($supplements))
	{
		$GLOBALS['SITE_DB']->query_delete('bookable_supplement_for',array('bookable_id'=>$bookable_id));
		foreach ($supplements as $supplement_id)
		{
			$GLOBALS['SITE_DB']->query_insert('bookable_supplement_for',array(
				'supplement_id'=>$supplement_id,
				'bookable_id'=>$bookable_id,
			));
		}
	}

	log_it('EDIT_BOOKABLE',strval($bookable_id),$title);
}

/**
 * Delete a bookable.
 *
 * @param  AUTO_LINK	Bookable ID.
 */
function delete_bookable($bookable_id)
{
	if (!is_null($GLOBALS['SITE_DB']->query_value_null_ok('booking','id',array('bookable_id'=>$bookable_id))))
		warn_exit(do_lang_tempcode('CANNOT_DELETE_BOOKINGS_EXIST'));

	$_old_bookable=$GLOBALS['SITE_DB']->query_select('bookable',array('*'),array('id'=>$bookable_id),'',1);
	if (!array_key_exists(0,$_old_bookable)) warn_exit(do_lang_tempcode('MISSING_RESOURCE'));

	$title=get_translated_text($_old_bookable[0]['title']);

	delete_lang($_old_bookable[0]['title']);
	delete_lang($_old_bookable[0]['description']);
	delete_lang($_old_bookable[0]['categorisation']);

	$calendar_type=$_old_bookable[0]['calendar_type'];
	if ((is_null($calendar_type)) && (is_null($GLOBALS['SITE_DB']->query_value_null_ok('calendar_types','id',array('id'=>$calendar_type)))) && ($GLOBALS['SITE_DB']->query_value('calendar_events','COUNT(*)',array('e_type'=>$calendar_type))==0))
	{
		require_code('calendar2');
		delete_event_type($calendar_type);
	}

	$GLOBALS['SITE_DB']->query_delete('bookable',array('id'=>$bookable_id),'',1);

	$GLOBALS['SITE_DB']->query_delete('bookable_blacked_for',array('bookable_id'=>$bookable_id));

	$GLOBALS['SITE_DB']->query_delete('bookable_codes',array('bookable_id'=>$bookable_id));

	$GLOBALS['SITE_DB']->query_delete('bookable_supplement_for',array('bookable_id'=>$bookable_id));

	log_it('DELETE_BOOKABLE',strval($bookable_id),$title);
}

/**
 * Add a bookable supplement.
 *
 * @param  array		Supplement details.
 * @param  ?array		List of bookables to associate to (NULL: none).
 * @return AUTO_LINK	Supplement ID.
 */
function add_bookable_supplement($details,$bookables=NULL)
{
	if (is_null($bookables)) $bookables=array();

	$title=$details['title'];

	$details['title']=insert_lang($details['title'],1);

	$supplement_id=$GLOBALS['SITE_DB']->query_insert('bookable_supplement',$details,true);

	foreach ($bookables as $bookable_id)
	{
		$GLOBALS['SITE_DB']->query_insert('bookable_supplement_for',array(
			'supplement_id'=>$supplement_id,
			'bookable_id'=>$bookable_id,
		));
	}

	log_it('ADD_BOOKABLE_SUPPLEMENT',strval($supplement_id),$title);

	return $supplement_id;
}

/**
 * Edit a bookable supplement.
 *
 * @param  AUTO_LINK	Supplement ID.
 * @param  array		Supplement details.
 * @param  ?array		List of bookables to associate to (NULL: no change).
 */
function edit_bookable_supplement($supplement_id,$details,$bookables=NULL)
{
	if (is_null($bookables)) $bookables=array();

	$title=$details['title'];

	$_old_supplement=$GLOBALS['SITE_DB']->query_select('bookable_supplement',array('*'),array('id'=>$supplement_id),'',1);
	if (!array_key_exists(0,$_old_supplement)) warn_exit(do_lang_tempcode('MISSING_RESOURCE'));

	lang_remap($_old_supplement[0]['title'],$details['title']);
	unset($details['title']);

	$GLOBALS['SITE_DB']->query_update('bookable_supplement',$details,array('id'=>$supplement_id),'',1);

	if (!is_null($bookables))
	{
		$GLOBALS['SITE_DB']->query_delete('bookable_supplement_for',array('supplement_id'=>$supplement_id));
		foreach ($bookables as $bookable_id)
		{
			$GLOBALS['SITE_DB']->query_insert('bookable_supplement_for',array(
				'supplement_id'=>$supplement_id,
				'bookable_id'=>$bookable_id,
			));
		}
	}

	log_it('EDIT_BOOKABLE_SUPPLEMENT',strval($supplement_id),$title);
}

/**
 * Delete a bookable supplement.
 *
 * @param  AUTO_LINK	Supplement ID.
 */
function delete_bookable_supplement($supplement_id)
{
	$_old_supplement=$GLOBALS['SITE_DB']->query_select('bookable_supplement',array('*'),array('id'=>$supplement_id),'',1);
	if (!array_key_exists(0,$_old_supplement)) warn_exit(do_lang_tempcode('MISSING_RESOURCE'));

	$title=get_translated_text($_old_supplement[0]['title']);

	delete_lang($_old_supplement[0]['title']);

	$GLOBALS['SITE_DB']->query_delete('bookable_supplement',array('id'=>$supplement_id),'',1);

	$GLOBALS['SITE_DB']->query_delete('bookable_supplement_for',array('supplement_id'=>$supplement_id));

	log_it('DELETE_BOOKABLE_SUPPLEMENT',strval($supplement_id),$title);
}

/**
 * Add a bookable blacked.
 *
 * @param  array		Blacked details.
 * @param  ?array		List of bookables to associate to (NULL: none).
 * @return AUTO_LINK	Blacked ID.
 */
function add_bookable_blacked($details,$bookables=NULL)
{
	if (is_null($bookables)) $bookables=array();

	$blacked_explanation=$details['blacked_explanation'];

	$details['blacked_explanation']=insert_lang($details['blacked_explanation'],1);

	$blacked_id=$GLOBALS['SITE_DB']->query_insert('bookable_blacked',$details,true);

	foreach ($bookables as $bookable_id)
	{
		$GLOBALS['SITE_DB']->query_insert('bookable_blacked_for',array(
			'blacked_id'=>$blacked_id,
			'bookable_id'=>$bookable_id,
		));
	}

	log_it('ADD_BOOKABLE_BLACKED',strval($blacked_id),$blacked_explanation);

	return $blacked_id;
}

/**
 * Edit a bookable blacked.
 *
 * @param  AUTO_LINK	Blacked ID.
 * @param  array		Blacked details.
 * @param  ?array		List of bookables to associate to (NULL: no change).
 */
function edit_bookable_blacked($blacked_id,$details,$bookables=NULL)
{
	$blacked_explanation=$details['blacked_explanation'];

	$_old_blacked=$GLOBALS['SITE_DB']->query_select('bookable_blacked',array('*'),array('id'=>$blacked_id),'',1);
	if (!array_key_exists(0,$_old_blacked)) warn_exit(do_lang_tempcode('MISSING_RESOURCE'));

	lang_remap($_old_blacked[0]['blacked_explanation'],$details['blacked_explanation']);
	unset($details['blacked_explanation']);

	$GLOBALS['SITE_DB']->query_update('bookable_blacked',$details,array('id'=>$blacked_id),'',1);

	if (!is_null($bookables))
	{
		$GLOBALS['SITE_DB']->query_delete('bookable_blacked_for',array('blacked_id'=>$blacked_id));
		foreach ($bookables as $bookable_id)
		{
			$GLOBALS['SITE_DB']->query_insert('bookable_blacked_for',array(
				'blacked_id'=>$blacked_id,
				'bookable_id'=>$bookable_id,
			));
		}
	}

	log_it('EDIT_BOOKABLE_BLACKED',strval($blacked_id),$blacked_explanation);
}

/**
 * Delete a bookable blacked.
 *
 * @param  AUTO_LINK	Blacked ID.
 */
function delete_bookable_blacked($blacked_id)
{
	$_old_blacked=$GLOBALS['SITE_DB']->query_select('bookable_blacked',array('*'),array('id'=>$blacked_id),'',1);
	if (!array_key_exists(0,$_old_blacked)) warn_exit(do_lang_tempcode('MISSING_RESOURCE'));

	$blacked_explanation=get_translated_text($_old_blacked[0]['blacked_explanation']);

	delete_lang($_old_blacked[0]['blacked_explanation']);

	$GLOBALS['SITE_DB']->query_delete('bookable_blacked',array('id'=>$blacked_id),'',1);

	$GLOBALS['SITE_DB']->query_delete('bookable_blacked_for',array('blacked_id'=>$blacked_id));

	log_it('DELETE_BOOKABLE_BLACKED',strval($blacked_id),$blacked_explanation);
}
