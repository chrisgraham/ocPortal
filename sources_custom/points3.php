<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2013

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		ocportalcom_support_credits
 */

/**
 * The UI for a points profile.
 *
 * @param  MEMBER			The ID of the member who is being viewed
 * @param  ?MEMBER		The ID of the member who is doing the viewing (NULL: current member)
 * @return tempcode		The UI
 */
function points_profile($member_id_of,$member_id_viewing)
{
	require_code('points');
	require_css('points');
	require_lang('points');

	require_javascript('javascript_validation');

	// Get info about viewing/giving user
	if (!is_guest($member_id_viewing))
	{
		$viewer_gift_points_available=get_gift_points_to_give($member_id_viewing);
	}

	// Get info about viewed user
	$name=$GLOBALS['FORUM_DRIVER']->get_username($member_id_of);
	if ((is_null($name)) || (is_guest($member_id_of))) warn_exit(do_lang_tempcode('MEMBER_NO_EXIST'));
	$title=get_screen_title('_POINTS',true,array(escape_html($name)));

	$profile_link=$GLOBALS['FORUM_DRIVER']->member_profile_url($member_id_of,false,true);

	// Show stats about $member_id_of
	$post_count=$GLOBALS['FORUM_DRIVER']->get_post_count($member_id_of);
	$_point_info=point_info($member_id_of);
	$points_gained_given=array_key_exists('points_gained_given',$_point_info)?$_point_info['points_gained_given']:0;
	$points_gained_rating=array_key_exists('points_gained_rating',$_point_info)?$_point_info['points_gained_rating']:0;
	$points_gained_voting=array_key_exists('points_gained_voting',$_point_info)?$_point_info['points_gained_voting']:0;
	$wiki_post_count=array_key_exists('points_gained_wiki',$_point_info)?$_point_info['points_gained_wiki']:0;
	$chat_post_count=array_key_exists('points_gained_chat',$_point_info)?$_point_info['points_gained_chat']:0;
	$points_used=points_used($member_id_of);
	$remaining=available_points($member_id_of);
	$gift_points_used=get_gift_points_used($member_id_of); //$_point_info['gift_points_used'];
	$gift_points_available=get_gift_points_to_give($member_id_of);
	$points_gained_credits=$GLOBALS['SITE_DB']->query_select_value('credit_purchases','SUM(num_credits)',array('member_id'=>$member_id_of,'purchase_validated'=>1));
	if (is_null($points_gained_credits)) $points_gained_credits=0;

	$points_posting=intval(get_option('points_posting'));
	$points_rating=intval(get_option('points_rating'));
	$points_voting=intval(get_option('points_voting'));
	$points_joining=intval(get_option('points_joining'));
	$points_wiki_posting=intval(get_option('points_wiki',true));
	$points_chat_posting=intval(get_option('points_chat',true));
	$points_per_day=intval(get_option('points_per_day',true));
	$points_per_daily_visit=intval(get_option('points_per_daily_visit',true));
	$points_credits=50;

	$days_joined=intval(floor(floatval(time()-$GLOBALS['FORUM_DRIVER']->get_member_join_timestamp($member_id_of))/(60.0*60.0*24.0)));
	$points_gained_auto=$points_per_day*$days_joined;

	$to=points_get_transactions('to',$member_id_of,$member_id_viewing);
	$from=points_get_transactions('from',$member_id_of,$member_id_viewing);

	// If we're staff, we can show the charge log too
	$chargelog_details=new ocp_tempcode();
	if (has_privilege($member_id_viewing,'view_charge_log'))
	{
		$start=get_param_integer('charges_start',0);
		$max=get_param_integer('charges_max',10);
		$sortables=array('date_and_time'=>do_lang_tempcode('DATE'),'amount'=>do_lang_tempcode('AMOUNT'));
		$test=explode(' ',get_param('sort','date_and_time DESC'),2);
		if (count($test)==1) $test[1]='DESC';
		list($sortable,$sort_order)=$test;
		if (((strtoupper($sort_order)!='ASC') && (strtoupper($sort_order)!='DESC')) || (!array_key_exists($sortable,$sortables)))
			log_hack_attack_and_exit('ORDERBY_HACK');
		inform_non_canonical_parameter('sort');

		$max_rows=$GLOBALS['SITE_DB']->query_select_value('chargelog','COUNT(*)',array('member_id'=>$member_id_of));
		$rows=$GLOBALS['SITE_DB']->query_select('chargelog c LEFT JOIN '.$GLOBALS['SITE_DB']->get_table_prefix().'translate t ON '.db_string_equal_to('language',user_lang()).' AND t.id=c.reason',array('*'),array('member_id'=>$member_id_of),'ORDER BY '.$sortable.' '.$sort_order,$max,$start);
		$charges=new ocp_tempcode();
		$fromname=get_site_name();
		$toname=$GLOBALS['FORUM_DRIVER']->get_username($member_id_of);
		if (is_null($toname)) $toname=do_lang('UNKNOWN');
		require_code('templates_results_table');
		$fields_title=results_field_title(array(do_lang_tempcode('DATE'),do_lang_tempcode('AMOUNT'),do_lang_tempcode('FROM'),do_lang_tempcode('TO'),do_lang_tempcode('REASON')),$sortables,'sort',$sortable.' '.$sort_order);
		foreach ($rows as $myrow)
		{
			$date=get_timezoned_date($myrow['date_and_time']);
			$amount=$myrow['amount'];

			if ((get_page_name()!='search') && (array_key_exists('text_parsed',$myrow)) && (!is_null($myrow['text_parsed'])) && ($myrow['text_parsed']!='') && ($myrow['reason']!=0))
			{
				$reason=new ocp_tempcode();
				if (!$reason->from_assembly($myrow['text_parsed'],true))
					$reason=get_translated_tempcode($myrow['reason']);
			} else
			{
				$reason=get_translated_tempcode($myrow['reason']);
			}

			$charges->attach(results_entry(array(escape_html($date),escape_html(integer_format($amount)),escape_html($fromname),escape_html($toname),$reason)));
		}
		$chargelog_details=results_table(do_lang_tempcode('CHARGES'),$start,'charges_start',$max,'charges_max',$max_rows,$fields_title,$charges,$sortables,$sortable,$sort_order,'sort');
	}

	// Show giving form
	if (is_guest($member_id_viewing))
	{
		$give_template=do_lang_tempcode('POINTS_MUST_LOGIN');
	} else
	{
		$have_negative_gift_points=has_privilege($member_id_viewing,'have_negative_gift_points');
		$enough_ok=(($viewer_gift_points_available>0) || ($have_negative_gift_points));
		$give_ok=(($member_id_viewing!=$member_id_of) || (has_privilege($member_id_viewing,'give_points_self')));
		if (($enough_ok) && ($give_ok))
		{
			// Show how many points are available also
			$give_url=build_url(array('page'=>'points','type'=>'give','id'=>$member_id_of),get_module_zone('points'));
			$give_template=do_template('POINTS_GIVE',array('_GUID'=>'a7663fab037412fd4e6a6404a4291939','GIVE_URL'=>$give_url,'MEMBER'=>strval($member_id_of),'VIEWER_GIFT_POINTS_AVAILABLE'=>$have_negative_gift_points?'':integer_format($viewer_gift_points_available)));
		}
		else $give_template=do_lang_tempcode('PE_LACKING_GIFT_POINTS');
		if (!$give_ok) $give_template=new ocp_tempcode();
	}

	return do_template('POINTS_PROFILE',array(
		'_GUID'=>'900deaa0bba64762271ca63bf1606d87',

		'TITLE'=>$title,
		'MEMBER'=>strval($member_id_of),
		'PROFILE_URL'=>$profile_link,
		'NAME'=>$name,

		'POINTS_JOINING'=>integer_format($points_joining),

		'POST_COUNT'=>integer_format($post_count),
		'POINTS_POSTING'=>integer_format($points_posting),
		'MULT_POINTS_POSTING'=>integer_format($points_posting*$post_count),

		'POINTS_PER_DAY'=>integer_format($points_per_day),
		'DAYS_JOINED'=>integer_format($days_joined),
		'MULT_POINTS_PER_DAY'=>integer_format($points_per_day*$days_joined),

		'WIKI_POST_COUNT'=>integer_format($wiki_post_count),
		'POINTS_WIKI_POSTING'=>integer_format($points_wiki_posting),
		'MULT_POINTS_WIKI_POSTING'=>integer_format($wiki_post_count*$points_wiki_posting),

		'CHAT_POST_COUNT'=>integer_format($chat_post_count),
		'POINTS_CHAT_POSTING'=>integer_format($points_chat_posting),
		'MULT_POINTS_CHAT_POSTING'=>integer_format($chat_post_count*$points_chat_posting),

		'POINTS_RATING'=>integer_format($points_rating),
		'POINTS_GAINED_RATING'=>integer_format($points_gained_rating),
		'MULT_POINTS_RATING'=>integer_format($points_rating*$points_gained_rating),

		'POINTS_CREDITS'=>integer_format($points_credits),
		'POINTS_GAINED_CREDITS'=>integer_format($points_gained_credits),
		'MULT_POINTS_CREDITS'=>integer_format($points_credits*$points_gained_credits),

		'POINTS_VOTING'=>integer_format($points_voting),
		'POINTS_GAINED_VOTING'=>integer_format($points_gained_voting),
		'MULT_POINTS_VOTING'=>integer_format($points_voting*$points_gained_voting),

		'POINTS_PER_DAILY_VISIT'=>integer_format($points_per_daily_visit),
		'POINTS_GAINED_GIVEN'=>integer_format($points_gained_given),
		'POINTS_USED'=>integer_format($points_used),
		'REMAINING'=>integer_format($remaining),
		'GIFT_POINTS_USED'=>integer_format($gift_points_used),
		'GIFT_POINTS_AVAILABLE'=>integer_format($gift_points_available),
		'TO'=>$to,
		'FROM'=>$from,
		'CHARGELOG_DETAILS'=>$chargelog_details,
		'GIVE'=>$give_template,
	));
}

