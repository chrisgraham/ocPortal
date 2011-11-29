<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2011

 See text/EN/licence.txt for full licencing information.


 NOTE TO PROGRAMMERS:
   Do not edit this file. If you need to make changes, save your changed file to the appropriate *_custom folder
   **** If you ignore this advice, then your website upgrades (e.g. for bug fixes) will likely kill your changes ****

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		ocf_forum
 */

/**
 * Find the URL to a post.
 *
 * @param  AUTO_LINK		The post ID.
 * @return URLPATH		The URL.
 */
function find_post_id_url($post_id)
{
	$max=intval(get_option('forum_posts_per_page'));

	$id=$GLOBALS['FORUM_DB']->query_value_null_ok('f_posts','p_topic_id',array('id'=>$post_id));
	if (is_null($id)) warn_exit(do_lang_tempcode('MISSING_RESOURCE'));

	// What page is it on?
	$before=$GLOBALS['FORUM_DB']->query_value_null_ok_full('SELECT COUNT(*) FROM '.$GLOBALS['FORUM_DB']->get_table_prefix().'f_posts WHERE id<'.strval((integer)$post_id).' AND '.ocf_get_topic_where($id));
	$start=intval(floor(floatval($before)/floatval($max)))*$max;

	// Now redirect accordingly
	$map=array('page'=>'topicview','type'=>NULL,'id'=>$id,'start'=>($start==0)?NULL:$start);
	foreach ($_GET as $key=>$val)
		if ((substr($key,0,3)=='kfs') || (in_array($key,array('start','max')))) $map[$key]=$val;
	$_redirect=build_url($map,'_SELF',NULL,true);
	$redirect=$_redirect->evaluate();
	$redirect.='#post_'.strval($post_id);

	return $redirect;
}

/**
 * Find the URL to the latest unread post in a topic.
 *
 * @param  AUTO_LINK		The topic ID.
 * @return URLPATH		The URL.
 */
function find_first_unread_url($id)
{
	$max=intval(get_option('forum_posts_per_page'));

	$last_read_time=$GLOBALS['FORUM_DB']->query_value_null_ok('f_read_logs','l_time',array('l_member_id'=>get_member(),'l_topic_id'=>$id));
	if (is_null($last_read_time))
	{
		// Assumes that everything made in the last two weeks has not been read
		$unread_details=$GLOBALS['FORUM_DB']->query('SELECT id,p_time FROM '.$GLOBALS['FORUM_DB']->get_table_prefix().'f_posts WHERE p_topic_id='.strval((integer)$id).' AND p_time>'.strval(time()-60*60*24*intval(get_option('post_history_days'))).' ORDER BY id',1);
		if (array_key_exists(0,$unread_details))
		{
			$last_read_time=$unread_details[0]['p_time']-1;
		} else $last_read_time=0;
	}
	$first_unread_id=$GLOBALS['FORUM_DB']->query_value_null_ok_full('SELECT id FROM '.$GLOBALS['FORUM_DB']->get_table_prefix().'f_posts WHERE p_topic_id='.strval((integer)$id).' AND p_time>'.strval((integer)$last_read_time).' ORDER BY id');
	if (!is_null($first_unread_id))
	{
		// What page is it on?
		$before=$GLOBALS['FORUM_DB']->query_value_null_ok_full('SELECT COUNT(*) FROM '.$GLOBALS['FORUM_DB']->get_table_prefix().'f_posts WHERE id<'.strval((integer)$first_unread_id).' AND '.ocf_get_topic_where($id));
		$start=intval(floor(floatval($before)/floatval($max)))*$max;
	} else
	{
		$first_unread_id=-2;

		// What page is it on?
		$before=$GLOBALS['FORUM_DB']->query_value_null_ok_full('SELECT COUNT(*) FROM '.$GLOBALS['FORUM_DB']->get_table_prefix().'f_posts WHERE '.ocf_get_topic_where($id));
		$start=intval(floor(floatval($before)/floatval($max)))*$max;
		if ($start==$before) $start=$before-$max;
	}

	// Now redirect accordingly
	$map=array('page'=>'topicview','id'=>$id,'type'=>NULL,'start'=>($start==0)?NULL:$start);
	foreach ($_GET as $key=>$val)
		if ((substr($key,0,3)=='kfs') || (in_array($key,array('start','max')))) $map[$key]=$val;
	$_redirect=build_url($map,'_SELF',NULL,true);
	$redirect=$_redirect->evaluate();
	if ($first_unread_id>0) $redirect.='#post_'.strval($first_unread_id); else $redirect.='#first_unread';

	return $redirect;
}

/**
 * Turn a post row, into a detailed map of information that is suitable for use as display parameters for that post.
 *
 * @param  array		The post row.
 * @param  boolean	Whether the post is the only post in the topic.
 * @return array		The detailed map.
 */
function ocf_get_details_to_show_post($_postdetails,$only_post=false)
{
	$forum_id=$_postdetails['p_cache_forum_id'];

	$primary_group=ocf_get_member_primary_group($_postdetails['p_poster']);
	if (is_null($primary_group))
	{
		$_postdetails['p_poster']=db_get_first_id();
		$primary_group=db_get_first_id();
	}

	$post=array('id'=>$_postdetails['id'],
					'topic_id'=>$_postdetails['p_topic_id'],
					'title'=>$_postdetails['p_title'],
					'post'=>$_postdetails['trans_post'],
					'time'=>$_postdetails['p_time'],
					'time_string'=>get_timezoned_date($_postdetails['p_time']),
					'validated'=>$_postdetails['p_validated'],
					'is_emphasised'=>$_postdetails['p_is_emphasised'],
					'poster_username'=>$_postdetails['p_poster_name_if_guest'],
					'poster'=>$_postdetails['p_poster'],
					'has_history'=>!is_null($_postdetails['h_post_id'])
	);

	if (array_key_exists('post_original',$_postdetails))
	{
		$post['post_original']=$_postdetails['post_original'];
	}

	// Edited?
	if (!is_null($_postdetails['p_last_edit_by']))
	{
		$post['last_edit_by']=$_postdetails['p_last_edit_by'];
		$post['last_edit_time']=$_postdetails['p_last_edit_time'];
		$post['last_edit_time_string']=get_timezoned_date($_postdetails['p_last_edit_time']);
		$post['last_edit_by_username']=$GLOBALS['OCF_DRIVER']->get_username($_postdetails['p_last_edit_by']);
		if ($post['last_edit_by_username']=='') $post['last_edit_by_username']=do_lang('UNKNOWN'); // Shouldn't happen, but imported data can be weird
	}

	// Find title
	$title=addon_installed('ocf_member_titles')?$GLOBALS['OCF_DRIVER']->get_member_row_field($_postdetails['p_poster'],'m_title'):'';
	if ($title=='') $title=get_translated_text(ocf_get_group_property($primary_group,'title'),$GLOBALS['FORUM_DB']);
	$post['poster_title']=$title;

	// If this isn't guest posted, we can put some member details in
	if ((!is_null($_postdetails['p_poster'])) && ($_postdetails['p_poster']!=$GLOBALS['OCF_DRIVER']->get_guest_id()))
	{
		if (addon_installed('points'))
		{
			require_code('points');
			$post['poster_points']=total_points($_postdetails['p_poster']);
		}
		$post['poster_posts']=$GLOBALS['OCF_DRIVER']->get_member_row_field($_postdetails['p_poster'],'m_cache_num_posts');
		$post['poster_highlighted_name']=$GLOBALS['OCF_DRIVER']->get_member_row_field($_postdetails['p_poster'],'m_highlighted_name');

		// Signature
		if ((($GLOBALS['OCF_DRIVER']->get_member_row_field(get_member(),'m_views_signatures')==1) || (get_value('disable_views_sigs_option')==='1')) && ($_postdetails['p_skip_sig']==0) && (addon_installed('ocf_signatures')))
		{
			global $SIGNATURES_CACHE;
			if (array_key_exists($_postdetails['p_poster'],$SIGNATURES_CACHE))
			{
				$sig=$SIGNATURES_CACHE[$_postdetails['p_poster']];
			} else
			{
				$sig=get_translated_tempcode($GLOBALS['OCF_DRIVER']->get_member_row_field($_postdetails['p_poster'],'m_signature'),$GLOBALS['FORUM_DB']);
				$SIGNATURES_CACHE[$_postdetails['p_poster']]=$sig;
			}
			$post['signature']=$sig;
		}

		// Any custom fields to show?
		if (get_value('sep_cpf_join_setting')==='1')
		{
			$post['custom_fields']=ocf_get_all_custom_fields_match_member($_postdetails['p_poster'],((get_member()!=$_postdetails['p_poster']) && (!has_specific_permission(get_member(),'view_any_profile_field')))?1:NULL,((get_member()==$_postdetails['p_poster']) && (!has_specific_permission(get_member(),'view_any_profile_field')))?1:NULL,NULL,NULL,NULL,NULL,NULL,0,true);
		} else
		{
			$post['custom_fields']=ocf_get_all_custom_fields_match_member($_postdetails['p_poster'],((get_member()!=$_postdetails['p_poster']) && (!has_specific_permission(get_member(),'view_any_profile_field')))?1:NULL,((get_member()==$_postdetails['p_poster']) && (!has_specific_permission(get_member(),'view_any_profile_field')))?1:NULL,NULL,NULL,NULL,1);
		}

		// Usergroup
		$post['primary_group']=$primary_group;
		$post['primary_group_name']=ocf_get_group_name($primary_group);

		// Find avatar
		$avatar=$GLOBALS['OCF_DRIVER']->get_member_avatar_url($_postdetails['p_poster']);
		if ($avatar!='')
		{
			$post['poster_avatar']=$avatar;
		}

		// Any warnings?
		if ((has_specific_permission(get_member(),'see_warnings')) && (addon_installed('ocf_warnings')))
		{
			$num_warnings=$GLOBALS['OCF_DRIVER']->get_member_row_field($_postdetails['p_poster'],'m_cache_warnings');
			/*if ($num_warnings!=0)*/ $post['poster_num_warnings']=$num_warnings;
		}
		
		// Join date
		$post['poster_join_date']=$GLOBALS['OCF_DRIVER']->get_member_row_field($_postdetails['p_poster'],'m_join_time');
		$post['poster_join_date_string']=get_timezoned_date($post['poster_join_date']);
	}
	elseif ($_postdetails['p_poster']==$GLOBALS['OCF_DRIVER']->get_guest_id())
	{
		if (($_postdetails['p_poster_name_if_guest']==do_lang('SYSTEM')) && (addon_installed('ocf_member_avatars')))
		{
			$post['poster_avatar']=find_theme_image('ocf_default_avatars/default_set/ocp_fanatic');
		}
	}

	// Do we have any special controls over this post?
	if (ocf_may_edit_post_by($_postdetails['p_poster'],$forum_id)) $post['may_edit']=true;
	if ((ocf_may_delete_post_by($_postdetails['p_poster'],$forum_id)) && (!$only_post)) $post['may_delete']=true;

	// More
	if (has_specific_permission(get_member(),'see_ip')) $post['ip_address']=$_postdetails['p_ip_address'];
	if (!is_null($_postdetails['p_intended_solely_for'])) $post['intended_solely_for']=$_postdetails['p_intended_solely_for'];
	
	return $post;
}

/**
 * Read in a great big map of details relating to a topic.
 *
 * @param  ?AUTO_LINK	The ID of the topic we are getting details of (NULL: whispers).
 * @param  integer		The start row for getting details of posts in the topic (i.e. 0 is start of topic, higher is further through).
 * @param  integer		The maximum number of posts to get detail of.
 * @param  boolean		Whether we are viewing poll results for the topic (if there is no poll for the topic, this is irrelevant).
 * @return array			The map of details.
 */
function ocf_read_in_topic($topic_id,$start,$max,$view_poll_results=false)
{
	if (!is_null($topic_id))
	{
		$_topic_info=$GLOBALS['FORUM_DB']->query_select('f_topics',array('*'),array('id'=>$topic_id),'',1);
		if (!array_key_exists(0,$_topic_info)) warn_exit(do_lang_tempcode('MISSING_RESOURCE'));
		$topic_info=$_topic_info[0];

		// Are we allowed into here?
		//  Check forum
		$forum_id=$topic_info['t_forum_id'];
		if (!is_null($forum_id))
		{
			if (!has_category_access(get_member(),'forums',strval($forum_id))) access_denied('CATEGORY_ACCESS_LEVEL');
		} else
		{
			// It must be a personal topic. Do we have access?
			$from=$topic_info['t_pt_from'];
			$to=$topic_info['t_pt_to'];

			if (($from!=get_member()) && ($to!=get_member()) && (!ocf_has_special_pt_access($topic_id)) && (!has_specific_permission(get_member(),'view_other_pt')))
			{
				access_denied('SPECIFIC_PERMISSION','view_other_pt');
			}

			decache('_new_pp',array(get_member()));
		}
		//  Check validated
		if ($topic_info['t_validated']==0)
		{
			if (!has_specific_permission(get_member(),'jump_to_unvalidated'))
				access_denied('SPECIFIC_PERMISSION','jump_to_unvalidated');
		}

		// Some general info
		$out=array('num_views'=>$topic_info['t_num_views'],
						'num_posts'=>$topic_info['t_cache_num_posts'],
						'validated'=>$topic_info['t_validated'],
						'title'=>$topic_info['t_cache_first_title'],
						'description'=>$topic_info['t_description'],
						'emoticon'=>$topic_info['t_emoticon'],
						'forum_id'=>$topic_info['t_forum_id'],
						'first_post'=>$topic_info['t_cache_first_post'],
						'first_poster'=>$topic_info['t_cache_first_member_id'],
						'first_post_id'=>$topic_info['t_cache_first_post_id'],
						'pt_from'=>$topic_info['t_pt_from'],
						'pt_to'=>$topic_info['t_pt_to'],
						'is_open'=>$topic_info['t_is_open']);

		$GLOBALS['META_DATA']+=array(
			'created'=>date('Y-m-d',$topic_info['t_cache_first_time']),
			'creator'=>$topic_info['t_cache_first_username'],
			'publisher'=>'', // blank means same as creator
			'modified'=>date('Y-m-d',$topic_info['t_cache_last_time']),
			'type'=>'Forum topic',
			'title'=>$topic_info['t_cache_first_title'],
			'identifier'=>'_SEARCH:topicview:misc:'.strval($topic_id),
			'description'=>$topic_info['t_description'],
			'numcomments'=>strval($topic_info['t_cache_num_posts']),
		);

		// Poll?
		if (!is_null($topic_info['t_poll_id']))
		{
			require_code('ocf_polls');
			$voted_already=$GLOBALS['FORUM_DB']->query_value_null_ok('f_poll_votes','pv_member_id',array('pv_poll_id'=>$topic_info['t_poll_id'],'pv_member_id'=>get_member()));
			$out['poll']=ocf_poll_get_results($topic_info['t_poll_id'],$view_poll_results || (!is_null($voted_already)));
			$out['poll']['voted_already']=$voted_already;
			$out['poll_id']=$topic_info['t_poll_id'];
		}
		
		// Post query
		$where=ocf_get_topic_where($topic_id);
		$query='SELECT p.*,t.text_parsed AS _trans_post,t.text_original AS post_original,h.h_post_id FROM '.$GLOBALS['FORUM_DB']->get_table_prefix().'f_posts p LEFT JOIN '.$GLOBALS['FORUM_DB']->get_table_prefix().'f_post_history h ON (h.h_post_id=p.id AND h.h_action_date_and_time=p.p_last_edit_time) LEFT JOIN '.$GLOBALS['FORUM_DB']->get_table_prefix().'translate t ON '.db_string_equal_to('language',user_lang()).' AND p.p_post=t.id WHERE '.$where.' ORDER BY p_time,p.id';
	} else
	{
		$out=array('num_views'=>0,
						'num_posts'=>0,
						'validated'=>1,
						'title'=>do_lang('INLINE_PERSONAL_POSTS'),
						'description'=>'',
						'emoticon'=>'',
						'forum_id'=>NULL,
						'first_post'=>NULL,
						'first_poster'=>NULL,
						'first_post_id'=>NULL,
						'pt_from'=>NULL,
						'pt_to'=>NULL,
						'is_open'=>1);
						
		// Post query
		$where='p_intended_solely_for='.strval(get_member());
		$query='SELECT p.*,t.text_parsed AS _trans_post,t.text_original AS post_original,h.h_post_id FROM '.$GLOBALS['FORUM_DB']->get_table_prefix().'f_posts p LEFT JOIN '.$GLOBALS['FORUM_DB']->get_table_prefix().'f_post_history h ON (h.h_post_id=p.id AND h.h_action_date_and_time=p.p_last_edit_time) LEFT JOIN '.$GLOBALS['FORUM_DB']->get_table_prefix().'translate t ON '.db_string_equal_to('language',user_lang()).' AND p.p_post=t.id WHERE '.$where.' ORDER BY p_time,p.id';
	}

	// Posts
	$_postdetailss=$GLOBALS['FORUM_DB']->query($query,$max,$start);
	if (($start==0) && (count($_postdetailss)<$max)) $out['max_rows']=$max; // We know that they're all on this screen
	else $out['max_rows']=$GLOBALS['FORUM_DB']->query_value_null_ok_full('SELECT COUNT(*) FROM '.$GLOBALS['FORUM_DB']->get_table_prefix().'f_posts WHERE '.$where);
	$posts=array();
	// Precache member/group details in one fell swoop
	$members=array();
	foreach ($_postdetailss as $_postdetails)
	{
		$members[$_postdetails['p_poster']]=1;
		if ($out['title']=='') $out['title']=$_postdetails['p_title'];
	}
	$member_or_list='';
	foreach (array_keys($members) as $member)
	{
		if ($member_or_list!='') $member_or_list.=' OR ';
		$member_or_list.='m.id='.strval((integer)$member);
	}
	if ($member_or_list!='')
	{
		$member_rows=$GLOBALS['FORUM_DB']->query('SELECT m.*,text_parsed AS signature FROM '.$GLOBALS['FORUM_DB']->get_table_prefix().'f_members m LEFT JOIN '.$GLOBALS['FORUM_DB']->get_table_prefix().'translate t ON '.db_string_equal_to('language',user_lang()).' AND m.m_signature=t.id WHERE '.$member_or_list);
		global $TABLE_LANG_FIELDS;
		$member_rows_2=$GLOBALS['FORUM_DB']->query('SELECT f.* FROM '.$GLOBALS['FORUM_DB']->get_table_prefix().'f_member_custom_fields f WHERE '.str_replace('m.id','mf_member_id',$member_or_list),NULL,NULL,false,false,array_key_exists('f_member_custom_fields',$TABLE_LANG_FIELDS)?$TABLE_LANG_FIELDS['f_member_custom_fields']:array());
		$member_rows_3=$GLOBALS['FORUM_DB']->query('SELECT gm_group_id,gm_member_id FROM '.$GLOBALS['FORUM_DB']->get_table_prefix().'f_group_members WHERE gm_validated=1 AND ('.str_replace('m.id','gm_member_id',$member_or_list).')');
		global $MEMBER_CACHE_FIELD_MAPPINGS,$GROUP_MEMBERS_CACHE,$SIGNATURES_CACHE;
		$found_groups=array();
		foreach ($member_rows as $row)
		{
			$GLOBALS['OCF_DRIVER']->MEMBER_ROWS_CACHED[$row['id']]=$row;
	
			if (!ocf_is_ldap_member($row['id']))
			{
				// Primary
				$pg=$GLOBALS['OCF_DRIVER']->get_member_row_field($row['id'],'m_primary_group');
				$found_groups[$pg]=1;
				$GROUP_MEMBERS_CACHE[$row['id']][false][false]=array($pg=>1);
			}
	
			// Signature
			if ((get_page_name()!='search') && (!is_null($row['signature'])) && ($row['signature']!='') && ($row['m_signature']!=0))
			{
				$SIGNATURES_CACHE[$row['id']]=new ocp_tempcode();
				if (!$SIGNATURES_CACHE[$row['id']]->from_assembly($row['signature'],true))
					unset($SIGNATURES_CACHE[$row['id']]);
			}
		}
		foreach ($member_rows_2 as $row)
		{
			$MEMBER_CACHE_FIELD_MAPPINGS[$row['mf_member_id']]=$row;
		}
		foreach ($member_rows_3 as $row)
		{
			if (!ocf_is_ldap_member($row['gm_member_id']))
			{
				$GROUP_MEMBERS_CACHE[$row['gm_member_id']][false][false][$row['gm_group_id']]=1;
				$found_groups[$row['gm_group_id']]=1;
			}
		}

		ocf_ensure_groups_cached(array_keys($found_groups));
	}
	foreach ($_postdetailss as $_postdetails)
	{
		if ((get_page_name()=='search') || (is_null($_postdetails['_trans_post'])) || ($_postdetails['_trans_post']=='') || ($_postdetails['p_post']==0))
		{
			$_postdetails['trans_post']=get_translated_tempcode($_postdetails['p_post'],$GLOBALS['FORUM_DB']);
		} else
		{
			$_postdetails['trans_post']=new ocp_tempcode();
			if (!$_postdetails['trans_post']->from_assembly($_postdetails['_trans_post'],true))
				$_postdetails['trans_post']=get_translated_tempcode($_postdetails['p_post'],$GLOBALS['FORUM_DB']);
		}

		$posts[]=ocf_get_details_to_show_post($_postdetails,($start==0) && (count($_postdetailss)==1));
	}

	$out['posts']=$posts;

	// Any special topic/for-any-post-in-topic controls?
	if (!is_null($topic_id))
	{
		$out['last_poster']=$topic_info['t_cache_last_member_id'];
		$out['last_post_id']=$topic_info['t_cache_last_post_id'];
		if ((is_null($forum_id)) || (ocf_may_post_in_topic($forum_id,$topic_id,$topic_info['t_cache_last_member_id'])))
			$out['may_reply']=true;
		$out['is_being_tracked']=ocf_is_tracking_topic($topic_id);
		if (ocf_may_report_post()) $out['may_report_posts']=true;
		if (ocf_may_make_personal_topic()) $out['may_pt_members']=true;
		if (ocf_may_edit_topics_by($forum_id,get_member(),$topic_info['t_cache_first_member_id'])) $out['may_edit_topic']=true;
		if (ocf_may_warn_members()) $out['may_warn_members']=true;
		if (ocf_may_delete_topics_by($forum_id,get_member(),$topic_info['t_cache_first_member_id'])) $out['may_delete_topic']=true;
		if (ocf_may_perform_multi_moderation($forum_id)) $out['may_multi_moderate']=true;
		if (has_specific_permission(get_member(),'use_quick_reply')) $out['may_use_quick_reply']=true;
		$may_moderate_forum=ocf_may_moderate_forum($forum_id);
		if ($may_moderate_forum)
		{
			if ($topic_info['t_is_open']==0) $out['may_open_topic']=1; else $out['may_close_topic']=1;
			if ($topic_info['t_pinned']==0) $out['may_pin_topic']=1; else $out['may_unpin_topic']=1;
			if ($topic_info['t_sunk']==0) $out['may_sink_topic']=1; else $out['may_unsink_topic']=1;
			if ($topic_info['t_cascading']==0) $out['may_cascade_topic']=1; else $out['may_uncascade_topic']=1;
			$out['may_move_topic']=1;
			$out['may_post_closed']=1;
			$out['may_move_posts']=1;
			$out['may_delete_posts']=1;
			$out['may_validate_posts']=1;
			$out['may_make_personal']=1;
			$out['may_change_max']=1;
		} else
		{
			if (($topic_info['t_cache_first_member_id']==get_member()) && (has_specific_permission(get_member(),'close_own_topics')) && ($topic_info['t_is_open']==0))
			{
				$out['may_close_topic']=1;
			}
		}
		if (!is_null($topic_info['t_poll_id']))
		{
			require_code('ocf_polls');

			if (ocf_may_edit_poll_by($forum_id,$topic_info['t_cache_first_member_id']))
				$out['may_edit_poll']=1;
			if (ocf_may_delete_poll_by($forum_id,$topic_info['t_cache_first_member_id']))
				$out['may_delete_poll']=1;
		} else
		{
			require_code('ocf_polls');

			if (ocf_may_attach_poll($topic_id,$topic_info['t_cache_first_member_id'],!is_null($topic_info['t_poll_id']),$forum_id))
				$out['may_attach_poll']=1;
		}
	} else
	{
		$out['last_poster']=NULL;
		$out['last_post_id']=NULL;
		$out['may_reply']=false;
		$out['is_being_tracked']=false;
	}

	return $out;
}


