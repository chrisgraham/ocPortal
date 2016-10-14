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
 * @package		core_ocf
 */

/**
 * Make sure we are doing necessary join to be able to access the given field
 *
 * @param  object				Database connection
 * @param  array				Content type info
 * @param  ID_TEXT			Context (unused)
 * @param  array				List of joins (passed as reference)
 * @param  array				List of selects (passed as reference)
 * @param  ID_TEXT			The field to get
 * @param  string				The field value for this
 * @param  array				Database field data
 * @return ?array				A triple: Proper database field name to access with, The fields API table type (blank: no special table), The new filter value (NULL: error)
 */
function _members_ocselect($db,$info,$context,&$extra_join,&$extra_select,$filter_key,$field_val,$db_fields)
{
	// If it's trivial
	if (($filter_key=='id') || (preg_match('#^m\_[\w\_]+$#',$filter_key)!=0))
	{
		if (!array_key_exists($filter_key,$db_fields)) return NULL;
		return array($filter_key,'',$field_val);
	}

	// CPFS...
	// -------

	$join_sql=' LEFT JOIN '.$db->get_table_prefix().'f_member_custom_fields f ON f.mf_member_id=r.id';

	if (!in_array($join_sql,$extra_join))
		$extra_join[$filter_key]=$join_sql;

	$new_filter_key=$filter_key;
	if (is_numeric($filter_key))
	{
		$new_filter_key='field_'.$new_filter_key;
	}
	elseif ($filter_key=='gm_group_id')
	{
		$join_sql=' LEFT JOIN '.$db->get_table_prefix().'f_group_members gm ON gm.gm_member_id=r.id';

		if (!in_array($join_sql,$extra_join))
			$extra_join[$filter_key]=$join_sql;

		return array($new_filter_key,'',$field_val);
	}
	elseif (preg_match('#^field\_\d+$#',$filter_key)==0) // If it's not already correct
	{
		require_code('ocf_members');
		$cpf_id=find_cpf_field_id($filter_key);
		if (is_null($cpf_id)) return NULL;
		$new_filter_key='field_'.strval($cpf_id);
	} else
	{
		if (!array_key_exists($filter_key,$db_fields)) return NULL;
	}

	return array($new_filter_key,'',$field_val);
}

/**
 * Get a member display box. Some terminology refers to a member here as a 'poster', as this function is used in forum topics also.
 *
 * @param  mixed			Either a member ID or an array containing: ip_address, poster_num_warnings, poster, poster_posts, poster_points, poster_join_date_string, primary_group_name.
 * @param  boolean		Whether only to show 'preview' details
 * @param  ?array			An array of hooks. (NULL: lookup)
 * @param  ?array			An array of hook objects that allow us to collect additional mouse-over member information. (NULL: lookup)
 * @param  boolean		Whether to show the avatar
 * @param  ?array			Map of extra fields to show (NULL: none)
 * @return tempcode		The member box
 */
function render_member_box($poster_details,$preview=false,$hooks=NULL,$hook_objects=NULL,$show_avatar=true,$extra_fields=NULL)
{
	require_lang('ocf');
	require_css('ocf');

	// Have to build up $poster_details instead?
	if (!is_array($poster_details))
	{
		if (addon_installed('points'))
		{
			require_code('points');
			$points=integer_format(total_points($poster_details));
		} else $points='';
		require_code('ocf_members');
		$primary_group=ocf_get_member_primary_group($poster_details);
		if (is_null($primary_group)) return new ocp_tempcode();
		require_code('ocf_groups');
		$poster_details=array('poster'=>$poster_details,'poster_posts'=>$GLOBALS['OCF_DRIVER']->get_member_row_field($poster_details,'m_cache_num_posts'),'poster_join_date'=>$GLOBALS['OCF_DRIVER']->get_member_row_field($poster_details,'m_join_time'),'poster_join_date_string'=>get_timezoned_date($GLOBALS['OCF_DRIVER']->get_member_row_field($poster_details,'m_join_time')),'primary_group_name'=>ocf_get_group_name($primary_group));
		$poster_details['custom_fields']=ocf_get_all_custom_fields_match_member(
			$poster_details['poster'],
			((get_member()!=$poster_details['poster']) && (!has_specific_permission(get_member(),'view_any_profile_field')))?1:NULL, // public view
			((get_member()==$poster_details['poster']) && (!has_specific_permission(get_member(),'view_any_profile_field')))?1:NULL, // owner view
			NULL, // owner set
			0, // encrypted
			NULL, // required
			$preview?NULL:1, // show in posts
			$preview?1:NULL // show in post previews
		);
		if ($preview)
		{
			$poster_details['custom_fields_full']=ocf_get_all_custom_fields_match_member(
				$poster_details['poster'],
				((get_member()!=$poster_details['poster']) && (!has_specific_permission(get_member(),'view_any_profile_field')))?1:NULL, // public view
				((get_member()==$poster_details['poster']) && (!has_specific_permission(get_member(),'view_any_profile_field')))?1:NULL, // owner view
				NULL, // owner set
				0, // encrypted
				NULL, // required
				1, // show in posts
				0 // show in post previews
			);
		} else $poster_details['custom_fields_full']=$poster_details['custom_fields'];
		if ((has_specific_permission(get_member(),'see_warnings')) && (addon_installed('ocf_warnings')))
		{
			$num_warnings=$GLOBALS['OCF_DRIVER']->get_member_row_field($poster_details['poster'],'m_cache_warnings');
			/*if ($num_warnings!=0)*/ $poster_details['poster_num_warnings']=$num_warnings;
		}
		if (has_specific_permission(get_member(),'see_ip')) $poster_details['ip_address']=$GLOBALS['OCF_DRIVER']->get_member_row_field($poster_details['poster'],'m_ip_address');
	} else
	{
		$points=array_key_exists('points',$poster_details)?integer_format($poster_details['points']):'';
	}

	$member_id=$poster_details['poster'];

	if (is_null($hooks))
	{
		// Poster detail hooks
		$hooks=find_all_hooks('modules','topicview');
		$hook_objects=array();
		foreach (array_keys($hooks) as $hook)
		{
			require_code('hooks/modules/topicview/'.filter_naughty_harsh($hook));
			$object=object_factory('Hook_'.filter_naughty_harsh($hook),true);
			if (is_null($object)) continue;
			$hook_objects[$hook]=$object;
		}
	}

	$custom_fields=new ocp_tempcode();
	foreach ($poster_details['custom_fields'] as $name=>$value)
	{
		if ((!is_null($value)) && ($value!==''))
			$custom_fields->attach(do_template('OCF_MEMBER_BOX_CUSTOM_FIELD',array('_GUID'=>'10b72cd1ec240c315e56bc8a0f3a92a1','MEMBER_ID'=>strval($member_id),'NAME'=>@strval($name),'RAW'=>$value['RAW'],'VALUE'=>is_object($value['RENDERED'])?protect_from_escaping($value['RENDERED']):$value['RENDERED'])));
	}
	$custom_fields_full=new ocp_tempcode();
	if (array_key_exists('custom_fields_full',$poster_details))
	{
		foreach ($poster_details['custom_fields_full'] as $name=>$value)
		{
			if ((!is_null($value)) && ($value!==''))
				$custom_fields_full->attach(do_template('OCF_MEMBER_BOX_CUSTOM_FIELD',array('_GUID'=>'20b72cd1ec240c315e56bc8a0f3a92a1','MEMBER_ID'=>strval($member_id),'NAME'=>@strval($name),'RAW'=>$value['RAW'],'VALUE'=>is_object($value['RENDERED'])?protect_from_escaping($value['RENDERED']):$value['RENDERED'])));
		}
	}
	$ip_address=NULL;
	if (array_key_exists('ip_address',$poster_details))
		$ip_address=$poster_details['ip_address'];
	$num_warnings=NULL;
	if ((array_key_exists('poster_num_warnings',$poster_details)) && (addon_installed('ocf_warnings')))
		$num_warnings=integer_format($poster_details['poster_num_warnings']);
	$galleries=NULL;
	if ((addon_installed('galleries')) && (get_option('show_gallery_counts')=='1'))
	{
		$gallery_cnt=$GLOBALS['SITE_DB']->query_value_null_ok_full('SELECT COUNT(*) AS cnt FROM '.$GLOBALS['SITE_DB']->get_table_prefix().'galleries WHERE name LIKE \''.db_encode_like('member_'.strval($member_id).'_%').'\'');

		if ($gallery_cnt>1)
		{
			require_lang('galleries');
			$galleries=integer_format($gallery_cnt);
		}
	}
	$dob=NULL;
	$age=NULL;
	$day=$GLOBALS['OCF_DRIVER']->get_member_row_field($member_id,'m_dob_day');
	if (($GLOBALS['OCF_DRIVER']->get_member_row_field($member_id,'m_reveal_age')==1) && (!is_null($day)))
	{
		$month=$GLOBALS['OCF_DRIVER']->get_member_row_field($member_id,'m_dob_month');
		$year=$GLOBALS['OCF_DRIVER']->get_member_row_field($member_id,'m_dob_year');
		if (@strftime('%Y',@mktime(0,0,0,1,1,1963))!='1963') $dob=strval($year).'-'.str_pad(strval($month),2,'0',STR_PAD_LEFT).'-'.str_pad(strval($day),2,'0',STR_PAD_LEFT); else $dob=get_timezoned_date(mktime(12,0,0,$month,$day,$year),false,true);

		$age=intval(date('Y'))-$year;
		if ($month>intval(date('m'))) $age--;
		if (($month==intval(date('m'))) && ($day>intval(date('D')))) $age--;
	}

	if (!is_null($extra_fields))
	{
		foreach ($extra_fields as $key=>$val)
		{
			$custom_fields->attach(do_template('OCF_MEMBER_BOX_CUSTOM_FIELD',array('_GUID'=>'530f049d3b3065df2d1b69270aa93490','MEMBER_ID'=>strval($member_id),'NAME'=>@strval($key),'VALUE'=>($val))));
		}
	}

	foreach (array_keys($hooks) as $hook)
	{
		$hook_result=$hook_objects[$hook]->run($member_id);
		if (!is_null($hook_result))
			$custom_fields->attach($hook_result);
	}

	$_usergroups=$GLOBALS['FORUM_DRIVER']->get_members_groups($member_id,true);
	$all_usergroups=$GLOBALS['FORUM_DRIVER']->get_usergroup_list(true,false,false,$_usergroups);
	$usergroups=array();
	foreach ($_usergroups as $u)
	{
		if (array_key_exists($u,$all_usergroups))
			$usergroups[]=$all_usergroups[$u];
	}

	return do_template('OCF_MEMBER_BOX',array(
		'_GUID'=>'dfskfdsf9',
		'POSTER'=>strval($member_id),
		'POSTS'=>integer_format($poster_details['poster_posts']),
		'POINTS'=>$points,
		'JOIN_DATE_RAW'=>strval($poster_details['poster_join_date']),
		'JOIN_DATE'=>$poster_details['poster_join_date_string'],
		'PRIMARY_GROUP_NAME'=>$poster_details['primary_group_name'],
		'OTHER_USERGROUPS'=>$usergroups,
		'CUSTOM_FIELDS'=>$custom_fields,
		'CUSTOM_FIELDS_FULL'=>$custom_fields_full,
		'ONLINE'=>member_is_online($member_id),
		'AVATAR_URL'=>$show_avatar?$GLOBALS['FORUM_DRIVER']->get_member_avatar_url($member_id):'',
		'IP_ADDRESS'=>$ip_address,
		'NUM_WARNINGS'=>$num_warnings,
		'GALLERIES'=>$galleries,
		'DATE_OF_BIRTH'=>$dob,
		'AGE'=>is_null($age)?NULL:integer_format($age),
	));
}

/**
 * Find if a certain member may be PTd by a certain member.
 *
 * @param  MEMBER		Member to be PT'd
 * @param  ?MEMBER	Member to PT. (NULL: current member)
 * @return boolean	Whether the PT may be created
 */
function ocf_may_whisper($target,$member_id=NULL)
{
	if (is_null($member_id)) $member_id=get_member();

	if (get_value('disable_pt_restrict')==='1')
	{
		return true;
	}

	if ($target==$member_id) return true;

	if (has_specific_permission($member_id,'pt_anyone')) return true;
	$pt_allow=$GLOBALS['OCF_DRIVER']->get_member_row_field($target,'m_pt_allow');
	if ($pt_allow=='*') return true;

	global $MAY_WHISPER_CACHE;
	$key=serialize(array($target,$member_id));
	if (array_key_exists($key,$MAY_WHISPER_CACHE))
		return $MAY_WHISPER_CACHE[$key];
	$MAY_WHISPER_CACHE=array();

	require_code('ocfiltering');
	$groups=$GLOBALS['FORUM_DRIVER']->get_members_groups($member_id);
	$answer=count(array_intersect(ocfilter_to_idlist_using_memory($pt_allow,$GLOBALS['FORUM_DRIVER']->get_usergroup_list(false,false,false,NULL,$member_id)),$groups))!=0;

	if ((!$answer) && (addon_installed('chat')))
	{
		$rows=$GLOBALS['SITE_DB']->query_select('chat_buddies',array('date_and_time'),array('member_likes'=>$target,'member_liked'=>$member_id),'',1);
		if (count($rows)!=0) $answer=true;
	}

	$MAY_WHISPER_CACHE[$key]=$answer;
	return $answer;
}

