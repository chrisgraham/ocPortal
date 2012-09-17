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
 * Show a post, isolated of the other posts in it's topic.
 *
 * @param  array			The post row.
 * @param  boolean		Whether to include context (i.e. say WHAT this is, not just show the actual content). Also uses the post title, as opposed to the post's topic's title.
 * @param  boolean		Whether to embed a link to the topic.
 * @param  boolean		Whether to include breadcrumbs (if there are any)
 * @param  ?AUTO_LINK	Virtual root to use (NULL: none)
 * @param  ID_TEXT		Overridden GUID to send to templates (blank: none)
 * @return tempcode  	The isolated post.
 */
function render_post_box($row,$use_post_title=false,$give_context=true,$include_breadcrumbs=true,$root=NULL,$guid='')
{
	require_lang('ocf');
	require_css('ocf');

	require_code('ocf_groups');
	require_code('ocf_forums');

	// Poster title
	$primary_group=$GLOBALS['FORUM_DRIVER']->get_member_row_field($row['p_poster'],'m_primary_group');
	if (!is_null($primary_group))
	{
		if (addon_installed('ocf_member_titles'))
		{
			$poster_title=$GLOBALS['OCF_DRIVER']->get_member_row_field($row['p_poster'],'m_title');
			if ($poster_title=='') $poster_title=get_translated_text(ocf_get_group_property($primary_group,'title'),$GLOBALS['FORUM_DB']);
		} else $poster_title='';
		$avatar=$GLOBALS['FORUM_DRIVER']->get_member_avatar_url($row['p_poster']);
		$posters_groups=$GLOBALS['FORUM_DRIVER']->get_members_groups($row['p_poster'],true);
	} else
	{
		$poster_title='';
		$avatar='';
		$posters_groups=array();
	}

	// Avatar
	if (is_guest($row['p_poster']))
	{
		if ($row['p_poster_name_if_guest']==do_lang('SYSTEM'))
		{
			$avatar=find_theme_image('ocf_default_avatars/default_set/ocp_fanatic',true);
		}
	}
	if ($avatar!='')
	{
		$post_avatar=do_template('OCF_TOPIC_POST_AVATAR',array('_GUID'=>($guid!='')?$guid:'f5769e8994880817dc441f70bbeb070e','AVATAR'=>$avatar));
	} else $post_avatar=new ocp_tempcode();

	// Rank images
	$rank_images=new ocp_tempcode();
	foreach ($posters_groups as $group)
	{
		$rank_image=ocf_get_group_property($group,'rank_image');
		$group_leader=ocf_get_group_property($group,'group_leader');
		$group_name=ocf_get_group_name($group);
		$rank_image_pri_only=ocf_get_group_property($group,'rank_image_pri_only');
		if (($rank_image!='') && (($rank_image_pri_only==0) || ($group==$primary_group)))
		{
			$rank_images->attach(do_template('OCF_RANK_IMAGE',array('_GUID'=>($guid!='')?$guid:'4b1724a9d97f93e097cf49b50eeafa66','GROUP_NAME'=>$group_name,'USERNAME'=>$GLOBALS['FORUM_DRIVER']->get_username($row['p_poster']),'IMG'=>$rank_image,'IS_LEADER'=>$group_leader==$row['p_poster'])));
		}
	}

	// Poster details
	if ((!is_guest($row['p_poster'])) && (!is_null($primary_group)))
	{
		require_code('ocf_members2');
		$poster_details=render_member_box($row['p_poster'],false,NULL,NULL,false,NULL,false);
	} else
	{
		$custom_fields=new ocp_tempcode();
		$poster_details=new ocp_tempcode();
	}
	if ((!is_guest($row['p_poster'])) && (!is_null($primary_group)))
	{
		$poster=do_template('OCF_POSTER_MEMBER',array(
			'_GUID'=>($guid!='')?$guid:'ab1724a9d97f93e097cf49b50eeafa66',
			'ONLINE'=>member_is_online($row['p_poster']),
			'ID'=>strval($row['p_poster']),
			'POSTER_DETAILS'=>$poster_details,
			'PROFILE_URL'=>$GLOBALS['FORUM_DRIVER']->member_profile_url($row['p_poster'],false,true),
			'POSTER_USERNAME'=>$GLOBALS['FORUM_DRIVER']->get_username($row['p_poster']),
			'HIGHLIGHT_NAME'=>NULL,
		));
	} else
	{
		$poster=do_template('OCF_POSTER_GUEST',array('_GUID'=>($guid!='')?$guid:'bb1724a9d97f93e097cf49b50eeafa66','LOOKUP_IP_URL'=>'','POSTER_DETAILS'=>$poster_details,'POSTER_USERNAME'=>($row['p_poster_name_if_guest']!='')?$row['p_poster_name_if_guest']:do_lang('GUEST')));
	}

	// Last edited
	if (!is_null($row['p_last_edit_time']))
	{
		$last_edited=do_template('OCF_TOPIC_POST_LAST_EDITED',array(
			'_GUID'=>($guid!='')?$guid:'cb1724a9d97f93e097cf49b50eeafa66',
			'LAST_EDIT_DATE_RAW'=>is_null($row['p_last_edit_time'])?'':strval($row['p_last_edit_time']),
			'LAST_EDIT_DATE'=>get_timezoned_date($row['p_last_edit_time']),
			'LAST_EDIT_PROFILE_URL'=>is_null($row['p_last_edit_by'])?'':$GLOBALS['FORUM_DRIVER']->member_profile_url($row['p_last_edit_by'],false,true),
			'LAST_EDIT_USERNAME'=>is_null($row['p_last_edit_by'])?'':$GLOBALS['FORUM_DRIVER']->get_username($row['p_last_edit_by']),
		));
	} else $last_edited=new ocp_tempcode();
	$last_edited_raw=is_null($row['p_last_edit_time'])?'':strval($row['p_last_edit_time']);

	// Breadcrumbs
	$breadcrumbs=mixed();
	if ($include_breadcrumbs)
	{
		$breadcrumbs=ocf_forum_breadcrumbs($row['p_cache_forum_id'],NULL,NULL,false,is_null($root)?get_param_integer('keep_forum_root',NULL):$root);
	}

	// Misc stuff
	$poster_id=$row['p_poster'];
	$map=array('page'=>'topicview','type'=>'findpost','id'=>$row['id']);
	if (!is_null($root)) $map['keep_forum_root']=$root;
	$post_url=build_url($map,get_module_zone('topicview'));
	$post_url->attach('#post_'.strval($row['id']));
	if ((get_page_name()!='search') && (array_key_exists('text_parsed',$row)) && (!is_null($row['text_parsed'])) && ($row['text_parsed']!='') && ($row['p_post']!=0))
	{
		$post=new ocp_tempcode();
		if (!$post->from_assembly($row['text_parsed'],true))
			$post=get_translated_tempcode($row['p_post'],$GLOBALS['FORUM_DB']);
	} else
	{
		$post=get_translated_tempcode($row['p_post'],$GLOBALS['FORUM_DB']);
	}
	$post_date=get_timezoned_date($row['p_time']);
	$post_date_raw=$row['p_time'];
	if ($use_post_title)
	{
		$post_title=$row['p_title'];
	} else
	{
		$post_title=$GLOBALS['FORUM_DB']->query_select_value('f_topics','t_cache_first_title',array('id'=>$row['p_topic_id']));
		if ($row['p_title']!=$post_title) $post_title.=': '.$row['p_title'];
	}

	// Emphasis? PP to?
	$emphasis=new ocp_tempcode();
	if ($row['p_is_emphasised']==1)
	{
		$emphasis=do_lang_tempcode('IMPORTANT');
	}
	elseif (!is_null($row['p_intended_solely_for']))
	{
		$pp_to_username=$GLOBALS['FORUM_DRIVER']->get_username($row['p_intended_solely_for']);
		if (is_null($pp_to_username)) $pp_to_username=do_lang('UNKNOWN');
		$emphasis=do_lang('PP_TO',$pp_to_username);
	}

	// Feedback
	require_code('feedback');
	actualise_rating(true,'post',strval($row['id']),get_self_url(),$row['p_title']);
	$rating=display_rating(get_self_url(),$row['p_title'],'post',strval($row['id']),'RATING_INLINE_DYNAMIC',$row['p_poster']);

	// Render
	$tpl=do_template('OCF_POST_BOX',array(
		'_GUID'=>($guid!='')?$guid:'9456f4fe4b8fb1bf34f606fcb2bcc9d7',
		'GIVE_CONTEXT'=>$give_context,
		'URL'=>$post_url,
		'ID'=>strval($row['id']),
		'BREADCRUMBS'=>$breadcrumbs,
		'POST'=>do_template('OCF_TOPIC_POST',array(
			'_GUID'=>($guid!='')?$guid:'9456f4fe4b8fb1bf34f606fcb2bcc9d3',
			'ID'=>strval($row['id']),
			'GIVE_CONTEXT'=>$give_context,
			'TOPIC_FIRST_POST_ID'=>'',
			'TOPIC_FIRST_POSTER'=>'',
			'POST_ID'=>strval($row['id']),
			'URL'=>$post_url,
			'CLASS'=>($row['p_is_emphasised']==1)?'ocf_post_emphasis':((!is_null($row['p_intended_solely_for']))?'ocf_post_personal':''),
			'EMPHASIS'=>$emphasis,
			'FIRST_UNREAD'=>'',
			'POSTER_TITLE'=>$poster_title,
			'POST_TITLE'=>$post_title,
			'POST_DATE_RAW'=>strval($post_date_raw),
			'POST_DATE'=>$post_date,
			'POST'=>$post,
			'TOPIC_ID'=>is_null($row['p_topic_id'])?'':strval($row['p_topic_id']),
			'LAST_EDITED_RAW'=>$last_edited_raw,
			'LAST_EDITED'=>$last_edited,
			'POSTER_ID'=>strval($poster_id),
			'POSTER'=>$poster,
			'POSTER_DETAILS'=>$poster_details,
			'POST_AVATAR'=>$post_avatar,
			'RANK_IMAGES'=>$rank_images,
			'BUTTONS'=>'',
			'SIGNATURE'=>'',
			'UNVALIDATED'=>'',
			'DESCRIPTION'=>'',
			'PREVIEWING'=>true,
			'RATING'=>$rating,
		))
	));

	if ($give_context)
	{
		$poster=$GLOBALS['FORUM_DRIVER']->member_profile_hyperlink($row['p_poster']);
		$date=get_timezoned_date($row['p_time']);
		if (array_key_exists('t_cache_first_title',$row))
		{
			$topic_row=$row;
		} else
		{
			$topic_rows=$GLOBALS['FORUM_DB']->query_select('f_topics',array('*'),array('id'=>$row['p_topic_id']),'',1);
			if (array_key_exists(0,$topic_rows))
			{
				$topic_row=$topic_rows[0];
			} else
			{
				$topic_row=array('t_cache_first_title'=>'');
			}
		}
		if ($row['t_cache_first_title']=='')
		{
			$row['t_cache_first_title']=$GLOBALS['FORUM_DB']->query_select_value('f_posts','p_title',array('p_topic_id'=>$row['p_topic_id']),'ORDER BY p_time ASC',1);
		}
		$link=hyperlink($GLOBALS['FORUM_DRIVER']->topic_url($row['p_topic_id']),$topic_row['t_cache_first_title']);
		$title=do_lang_tempcode('FORUM_POST_ISOLATED_RESULT',escape_html(strval($row['id'])),$poster,array(escape_html($date),$link));

		return do_template('SIMPLE_PREVIEW_BOX',array(
			'_GUID'=>($guid!='')?$guid:'84ac17a5855ceed1c47c5d3ef6cf4f3d',
			'TITLE'=>$title,
			'SUMMARY'=>$tpl,
		));
	}

	return $tpl;
}
