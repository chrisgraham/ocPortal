<?php

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		group_points
 */

function total_points($member)
{
	$points=non_overrided__total_points($member);

	$totalised_group_points=0;

	$group_points=get_group_points();

	$groups=$GLOBALS['FORUM_DRIVER']->get_members_groups($member);
	foreach ($groups as $group)
	{
		$totalised_group_points+=isset($group_points[$group]['p_points_one_off'])?$group_points[$group]['p_points_one_off']:0;
	}

	global $TOTAL_POINTS_CACHE;
	$TOTAL_POINTS_CACHE[$member]=$points+$totalised_group_points;
	return $points+$totalised_group_points;
}

function get_group_points()
{
	$_group_points=$GLOBALS['SITE_DB']->query_select('group_points',array('*'),NULL,'',NULL,NULL,true);
	if (is_null($_group_points))
	{
		$group_points=array();

		install_group_points_stuff();
	} else
	{
		$group_points=list_to_map('p_group_id',$_group_points);
	}
	return $group_points;
}

function install_group_points_stuff()
{
	$GLOBALS['SITE_DB']->create_table('group_points',array(
		'p_group_id'=>'*GROUP',
		'p_points_one_off'=>'INTEGER',
		'p_points_per_month'=>'INTEGER',
	));
}

function get_group_points()
{
	return list_to_map('p_group_id',$GLOBALS['SITE_DB']->query_select('group_points',array('*')));
}
