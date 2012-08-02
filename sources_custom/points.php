<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		ocportalcom_support_credits
 */

/**
 * Get the total points in the specified member's account; some of these will probably have been spent already
 *
 * @param  MEMBER			The member
 * @return integer		The number of points the member has
 */
function total_points($member)
{
	if (!has_specific_permission($member,'use_points')) return 0;

	global $TOTAL_POINTS_CACHE;
	if (array_key_exists($member,$TOTAL_POINTS_CACHE)) return $TOTAL_POINTS_CACHE[$member];

	$points_gained_posting=$GLOBALS['FORUM_DRIVER']->get_post_count($member);
	$_points_gained=point_info($member);
	$points_gained_given=array_key_exists('points_gained_given',$_points_gained)?$_points_gained['points_gained_given']:0;
	$points_gained_rating=array_key_exists('points_gained_rating',$_points_gained)?$_points_gained['points_gained_rating']:0;
	$points_gained_voting=array_key_exists('points_gained_voting',$_points_gained)?$_points_gained['points_gained_voting']:0;
	$points_gained_cedi=array_key_exists('points_gained_seedy',$_points_gained)?$_points_gained['points_gained_seedy']:0;
	$points_gained_chat=array_key_exists('points_gained_chat',$_points_gained)?$_points_gained['points_gained_chat']:0;
	$points_posting=intval(get_option('points_posting'));
	$points_rating=intval(get_option('points_rating'));
	$points_voting=intval(get_option('points_voting'));
	$points_joining=intval(get_option('points_joining'));
	$points_per_day=intval(get_option('points_per_day',true));
	$points_chat=intval(get_option('points_chat',true));
	$points_cedi=intval(get_option('points_cedi',true));
	$points_gained_auto=$points_per_day*intval(floor(floatval(time()-$GLOBALS['FORUM_DRIVER']->get_member_join_timestamp($member))/floatval(60*60*24)));
	$points=$points_joining+$points_gained_chat*$points_chat+$points_gained_cedi*$points_cedi+$points_gained_posting*$points_posting+$points_gained_given+$points_gained_rating*$points_rating+$points_gained_voting*$points_voting+$points_gained_auto;
	if ($GLOBALS['SITE_DB']->table_exists('credit_purchases'))
	{
		$credits=$GLOBALS['SITE_DB']->query_value('credit_purchases','SUM(num_credits)',array('member_id'=>$member,'purchase_validated'=>1));
		$points+=$credits*50;
	}

	$TOTAL_POINTS_CACHE[$member]=$points;

	return $points;
}
