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

/* This file exists to alleviate PHP memory usage. It shaves over 100KB of memory need for any OCF request. */

/**
 * Get a map between smiley codes and templates representing the HTML-image-code for this smiley. The smilies present of course depend on the forum involved.
 *
 * @param  object			Link to the real forum driver
 * @param  ?MEMBER		Only emoticons the given member can see (NULL: don't care)
 * @return array			The map
 */
function _helper_apply_emoticons($this_ref,$member_id=NULL)
{
	global $IN_MINIKERNEL_VERSION;
	if ($IN_MINIKERNEL_VERSION==1) return array();

	$extra='';
	if (is_null($member_id))
	{
		global $EMOTICON_CACHE,$EMOTICON_LEVELS;
		if (!is_null($EMOTICON_CACHE)) return $EMOTICON_CACHE;
	} else
	{
		$extra=has_specific_permission(get_member(),'use_special_emoticons')?'':' AND e_is_special=0';
	}
	$EMOTICON_CACHE=array();
	$EMOTICON_LEVELS=array();

	$query='SELECT e_code,e_theme_img_code,e_relevance_level FROM '.$this_ref->connection->get_table_prefix().'f_emoticons WHERE e_relevance_level<4'.$extra;
	if (strpos(get_db_type(),'mysql')!==false) $query.=' ORDER BY LENGTH(e_code) DESC';
	$rows=$this_ref->connection->query($query);
	foreach ($rows as $myrow)
	{
		$tpl='EMOTICON_IMG_CODE_THEMED';
		$EMOTICON_CACHE[$myrow['e_code']]=array($tpl,$myrow['e_theme_img_code'],$myrow['e_code']);
		$EMOTICON_LEVELS[$myrow['e_code']]=$myrow['e_relevance_level'];
	}
	if (strpos(get_db_type(),'mysql')===false)
	{
		uksort($EMOTICON_CACHE,'strlen_sort');
		$EMOTICON_CACHE=array_reverse($EMOTICON_CACHE);
	}
	return $EMOTICON_CACHE;
}

/**
 * Makes a post in the specified forum, in the specified topic according to the given specifications. If the topic doesn't exist, it is created along with a spacer-post.
 * Spacer posts exist in order to allow staff to delete the first true post in a topic. Without spacers, this would not be possible with most forum systems. They also serve to provide meta information on the topic that cannot be encoded in the title (such as a link to the content being commented upon).
 *
 * @param  object			Link to the real forum driver
 * @param  SHORT_TEXT	The forum name
 * @param  SHORT_TEXT	The topic identifier (usually <content-type>_<content-id>)
 * @param  MEMBER			The member ID
 * @param  LONG_TEXT		The post title
 * @param  LONG_TEXT		The post content in Comcode format
 * @param  string			The topic title; must be same as content title if this is for a comment topic
 * @param  string			This is put together with the topic identifier to make a more-human-readable topic title or topic description (hopefully the latter and a $content_title title, but only if the forum supports descriptions)
 * @param  ?URLPATH		URL to the content (NULL: do not make spacer post)
 * @param  ?TIME			The post time (NULL: use current time)
 * @param  ?IP				The post IP address (NULL: use current members IP address)
 * @param  ?BINARY		Whether the post is validated (NULL: unknown, find whether it needs to be marked unvalidated initially). This only works with the OCF driver.
 * @param  ?BINARY		Whether the topic is validated (NULL: unknown, find whether it needs to be marked unvalidated initially). This only works with the OCF driver.
 * @param  boolean		Whether to skip post checks
 * @param  SHORT_TEXT	The name of the poster
 * @param  ?AUTO_LINK	ID of post being replied to (NULL: N/A)
 * @param  boolean		Whether the reply is only visible to staff
 * @param  ?ID_TEXT		DO NOT send notifications to: The notification code (NULL: no restriction)
 * @param  ?SHORT_TEXT	DO NOT send notifications to: The category within the notification code (NULL: none / no restriction)
 * @return array			Topic ID (may be NULL), and whether a hidden post has been made
 */
function _helper_make_post_forum_topic($this_ref,$forum_name,$topic_identifier,$member_id,$post_title,$post,$content_title,$topic_identifier_encapsulation_prefix,$content_url,$time,$ip,$validated,$topic_validated,$skip_post_checks,$poster_name_if_guest,$parent_id,$staff_only,$no_notify_for__notification_code,$no_notify_for__code_category)
{
	if (is_null($time)) $time=time();
	if (is_null($ip)) $ip=get_ip_address();

	require_code('comcode_check');
	check_comcode($post,NULL,false,NULL,true);

	require_code('ocf_topics');
	require_code('ocf_posts');
	//require_code('ocf_forums');
	require_lang('ocf');
	require_code('ocf_posts_action');
	require_code('ocf_posts_action2');

	if (!is_integer($forum_name))
	{
		$forum_id=$this_ref->forum_id_from_name($forum_name);
		if (is_null($forum_id)) warn_exit(do_lang_tempcode('MISSING_FORUM',escape_html($forum_name)));
	}
	else $forum_id=(integer)$forum_name;

	$topic_id=$this_ref->find_topic_id_for_topic_identifier($forum_name,$topic_identifier);

	$update_caching=false;
	$support_attachments=false;
	if ((!running_script('stress_test_loader')) && (get_page_name()!='admin_import'))
	{
		$update_caching=true;
		$support_attachments=true;
	}

	if (is_null($topic_id))
	{
		$is_starter=true;

		require_code('ocf_topics_action');
		$topic_id=ocf_make_topic($forum_id,$topic_identifier_encapsulation_prefix.': #'.$topic_identifier,'',$topic_validated,1,0,0,0,NULL,NULL,false,0,NULL,$content_url);

		if (strpos($topic_identifier,':')!==false)
		{
			// Sync comment_posted ones to also monitor the forum ones; no need for opposite way as comment ones already trigger forum ones
			$start=0;
			$max=300;
			require_code('notifications');
			$ob=_get_notification_ob_for_code('comment_posted');
			do
			{
				list($members,$possibly_has_more)=$ob->list_members_who_have_enabled('comment_posted',$topic_identifier,NULL,$start,$max);

				foreach ($members as $to_member_id=>$setting)
				{
					enable_notifications('ocf_topic',strval($topic_id),$to_member_id);
				}

				$start+=$max;
			}
			while ($possibly_has_more);
		}

		// Make spacer post
		if (!is_null($content_url))
		{
			$spacer_title=$content_title;
			$home_link=hyperlink($content_url,escape_html($content_title));
			$spacer_post='[semihtml]'.do_lang('SPACER_POST',$home_link->evaluate(),'','',get_site_default_lang()).'[/semihtml]';
			ocf_make_post($topic_id,$spacer_title,$spacer_post,0,true,1,0,do_lang('SYSTEM'),$ip,$time,db_get_first_id(),NULL,NULL,NULL,false,$update_caching,$forum_id,$support_attachments,$content_title,0,NULL,false,false,false,false);
			$is_starter=false;
		}

		$is_new=true;
	} else
	{
		$is_starter=false;
		$is_new=false;
	}
	$GLOBALS['LAST_TOPIC_ID']=$topic_id;
	$GLOBALS['LAST_TOPIC_IS_NEW']=$is_new;
	if ($post=='') return array(NULL,false);
	ocf_check_post($post,$topic_id,$member_id);
	$poster_name=$poster_name_if_guest;
	if ($poster_name=='') $poster_name=$this_ref->get_username($member_id);
	$post_id=ocf_make_post($topic_id,$post_title,$post,0,$is_starter,$validated,0,$poster_name,$ip,$time,$member_id,($staff_only?$GLOBALS['FORUM_DRIVER']->get_guest_id():NULL),NULL,NULL,false,$update_caching,$forum_id,$support_attachments,$content_title,0,NULL,false,$skip_post_checks,false,false,$parent_id);
	$GLOBALS['LAST_POST_ID']=$post_id;

	if ($is_new)
	{
		// Broken cache now for the rest of this page view - fix by flushing
		global $TOPIC_IDENTIFIERS_TO_IDS;
		$TOPIC_IDENTIFIERS_TO_IDS=array();
	}

	// Send out notifications
	$_url=build_url(array('page'=>'topicview','type'=>'findpost','id'=>$post_id),'forum',NULL,false,false,true,'post_'.strval($post_id));
	$url=$_url->evaluate();
	ocf_send_topic_notification($url,$topic_id,$forum_id,$member_id,!$is_new,$post,$content_title,NULL,false,$no_notify_for__notification_code,$no_notify_for__code_category);

	$is_hidden=false;
	if ((!running_script('stress_test_loader')) && (get_page_name()!='admin_import'))
	{
		$validated_actual=$this_ref->connection->query_value('f_posts','p_validated',array('id'=>$post_id));
		if ($validated_actual==0)
		{
			require_code('site');
			attach_message(do_lang_tempcode('SUBMIT_UNVALIDATED'),'inform');
			$is_hidden=true;
		}
	}

	return array($topic_id,$is_hidden);
}

/**
 * Get an array of topics in the given forum. Each topic is an array with the following attributes:
 * - id, the topic ID
 * - title, the topic title
 * - lastusername, the username of the last poster
 * - lasttime, the timestamp of the last reply
 * - closed, a Boolean for whether the topic is currently closed or not
 * - firsttitle, the title of the first post
 * - firstpost, the first post (only set if $show_first_posts was true)
 *
 * @param  object			Link to the real forum driver
 * @param  mixed			The forum name or an array of forum IDs
 * @param  integer		The limit
 * @param  integer		The start position
 * @param  integer		The total rows (not a parameter: returns by reference)
 * @param  SHORT_TEXT	The topic title filter
 * @param  SHORT_TEXT	The topic description filter
 * @param  boolean		Whether to show the first posts
 * @param  string			The date key to sort by
 * @set    lasttime firsttime
 * @param  boolean		Whether to limit to hot topics
 * @return ?array			The array of topics (NULL: error/none)
 */
function _helper_show_forum_topics($this_ref,$name,$limit,$start,&$max_rows,$filter_topic_title,$filter_topic_description,$show_first_posts,$date_key,$hot)
{
	if (is_integer($name)) $id_list='t_forum_id='.strval((integer)$name);
	elseif (!is_array($name))
	{
		$id=$this_ref->forum_id_from_name($name);
		if (is_null($id)) return NULL;
		$id_list='t_forum_id='.strval((integer)$id);
	} else
	{
		$id_list='';
		foreach (array_keys($name) as $id)
		{
			if ($id_list!='') $id_list.=' OR ';
			$id_list.='t_forum_id='.strval((integer)$id);
		}
		if ($id_list=='') return NULL;
	}

	if ($hot)
	{
		$hot_topic_definition=intval(get_option('hot_topic_definition'));
		$topic_filter_sup=' AND t_cache_num_posts/((t_cache_last_time-t_cache_first_time)/60/60/24+1)>'.strval($hot_topic_definition);
	} else $topic_filter_sup='';
	global $SITE_INFO;
	if (!(((isset($SITE_INFO['mysql_old'])) && ($SITE_INFO['mysql_old']=='1')) || ((!isset($SITE_INFO['mysql_old'])) && (is_file(get_file_base().'/mysql_old')))))
	{
		if (($filter_topic_title=='') && ($filter_topic_description==''))
		{
			$query='SELECT * FROM '.$this_ref->connection->get_table_prefix().'f_topics top WHERE ('.$id_list.')'.$topic_filter_sup;
		} else
		{
			$query='';
			$topic_filters=array();
			if ($filter_topic_title!='')
				$topic_filters[]='t_cache_first_title LIKE \''.db_encode_like($filter_topic_title).'\'';
			if ($filter_topic_description!='')
				$topic_filters[]='t_description LIKE \''.db_encode_like($filter_topic_description).'\'';
			foreach ($topic_filters as $topic_filter)
			{
				if ($query!='') $query.=' UNION ';
				$query.='SELECT * FROM '.$this_ref->connection->get_table_prefix().'f_topics top WHERE ('.$id_list.') AND '.$topic_filter.$topic_filter_sup;
			}
		}
	} else
	{
		$topic_filter='';
		if ($filter_topic_title!='')
			$topic_filter.='t_cache_first_title LIKE \''.db_encode_like($filter_topic_title).'\'';
		if ($filter_topic_description!='')
			$topic_filter.=' OR t_description LIKE \''.db_encode_like($filter_topic_description).'\'';
		if ($topic_filter!='')
			$topic_filter=' AND ('.$topic_filter.')';
		$query='SELECT * FROM '.$this_ref->connection->get_table_prefix().'f_topics top WHERE ('.$id_list.') '.$topic_filter.$topic_filter_sup;
	}

	$post_query_select='p.p_title,t.text_parsed,t.id,p.p_poster,p.p_poster_name_if_guest';
	$post_query_where='p_validated=1 AND p_topic_id=top.id '.not_like_spacer_posts('t.text_original');
	$post_query_sql='SELECT '.$post_query_select.' FROM '.$this_ref->connection->get_table_prefix().'f_posts p ';
	if (strpos(get_db_type(),'mysql')!==false) $post_query_sql.='USE INDEX(in_topic) ';
	$post_query_sql.='LEFT JOIN '.$this_ref->connection->get_table_prefix().'translate t ON t.id=p.p_post WHERE '.$post_query_where.' ORDER BY p_time,p.id';

	if (strpos(get_db_type(),'mysql')!==false) // So topics with no validated posts, or only spacer posts, are not drawn out only to then be filtered layer (meaning we don't get enough result)
		$query.=' AND EXISTS('.$post_query_sql.')';

	$max_rows=$this_ref->connection->query_value_null_ok_full(preg_replace('#(^| UNION )SELECT \* #','${1}SELECT COUNT(*) ',$query),false,true);
	if ($limit==0) return array();
	$rows=$this_ref->connection->query($query.' ORDER BY '.(($date_key=='lasttime')?'t_cache_last_time':'t_cache_first_time').' DESC',$limit,$start,false,true);

	$out=array();
	foreach ($rows as $i=>$r)
	{
		$out[$i]=array();
		$out[$i]['id']=$r['id'];
		$out[$i]['num']=$r['t_cache_num_posts'];
		$out[$i]['title']=$r['t_cache_first_title'];
		$out[$i]['description']=$r['t_description'];
		$out[$i]['firstusername']=$r['t_cache_first_username'];
		$out[$i]['lastusername']=$r['t_cache_last_username'];
		$out[$i]['firstmemberid']=$r['t_cache_first_member_id'];
		$out[$i]['lastmemberid']=$r['t_cache_last_member_id'];
		$out[$i]['firsttime']=$r['t_cache_first_time'];
		$out[$i]['lasttime']=$r['t_cache_last_time'];
		$out[$i]['closed']=1-$r['t_is_open'];
		$out[$i]['forum_id']=$r['t_forum_id'];

		$post_query_sql=str_replace('top.id',strval($out[$i]['id']),$post_query_sql);
		$fp_rows=$this_ref->connection->query($post_query_sql,1);
		if (!array_key_exists(0,$fp_rows))
		{
			unset($out[$i]);
			continue;
		}
		$out[$i]['firstusername']=$fp_rows[0]['p_poster_name_if_guest'];
		$out[$i]['firstmemberid']=$fp_rows[0]['p_poster'];
		$out[$i]['firsttitle']=$fp_rows[0]['p_title'];
		if ($show_first_posts)
		{
			$message=new ocp_tempcode();
			if ((get_page_name()!='search') && (!is_null($fp_rows[0]['text_parsed'])) && ($fp_rows[0]['text_parsed']!='') && ($fp_rows[0]['id']!=0))
			{
				if (!$message->from_assembly($fp_rows[0]['text_parsed'],true))
					$message=get_translated_tempcode($fp_rows[0]['id'],$GLOBALS['FORUM_DB']);
			} else $message=get_translated_tempcode($fp_rows[0]['id'],$GLOBALS['FORUM_DB']);
			$out[$i]['firstpost']=$message;
		}
	}
	if (count($out)!=0) return $out;
	return NULL;
}

/**
 * Get a bit of SQL to make sure that a DB field is not like a spacer post in any of the languages.
 *
 * @param  ID_TEXT		The field name
 * @return string			The SQL
 */
function not_like_spacer_posts($field)
{
	$ret='';
	$langs=find_all_langs();
	foreach (array_keys($langs) as $lang)
	{
		if ((@filesize(get_file_base().'/lang/'.$lang.'/global.ini')) || (@filesize(get_file_base().'/lang_custom/'.$lang.'/global.ini'))) // Check it's a real lang and not a stub dir
			$ret.=' AND '.$field.' NOT LIKE \'%'.db_encode_like(do_lang('SPACER_POST_MATCHER','','','',$lang).'%').'\'';
	}
	return $ret;
}

/**
 * Get an array of maps for the topic in the given forum.
 *
 * @param  object			Link to the real forum driver
 * @param  integer		The topic ID
 * @param  integer		The comment count will be returned here by reference
 * @param  ?integer		Maximum comments to returned (NULL: no limit)
 * @param  integer		Comment to start at
 * @param  boolean		Whether to mark the topic read
 * @param  boolean		Whether to show in reverse
 * @param  boolean		Whether to only load minimal details if it is a threaded topic
 * @param  ?array			List of post IDs to load (NULL: no filter)
 * @param  boolean		Whether to load spacer posts
 * @return mixed			The array of maps (Each map is: title, message, member, date) (-1 for no such forum, -2 for no such topic)
 */
function _helper_get_forum_topic_posts($this_ref,$topic_id,&$count,$max,$start,$mark_read=true,$reverse=false,$light_if_threaded=false,$post_ids=NULL,$load_spacer_posts_too=false)
{
	if (is_null($topic_id))
	{
		$count=0;
		return (-2);
	}

	require_code('ocf_topics');

	$is_threaded=$this_ref->topic_is_threaded($topic_id);

	$extra_where='';
	if (!is_null($post_ids))
	{
		if (count($post_ids)==0)
		{
			$count=0;
			return array();
		}
		$extra_where=' AND (';
		foreach ($post_ids as $i=>$id)
		{
			if ($i!=0) $extra_where.=' OR ';
			$extra_where.='p.id='.strval($id);
		}
		$extra_where.=')';
	}

	$where='('.ocf_get_topic_where($topic_id).')';
	if (!$load_spacer_posts_too)
		$where.=not_like_spacer_posts('t.text_original');
	$where.=$extra_where;
	if (!has_specific_permission(get_member(),'see_unvalidated')) $where.=' AND (p_validated=1 OR ((p_poster<>'.strval($GLOBALS['FORUM_DRIVER']->get_guest_id()).' OR '.db_string_equal_to('p_ip_address',get_ip_address()).') AND p_poster='.strval((integer)get_member()).'))';
	$index=(strpos(get_db_type(),'mysql')!==false && !is_null($GLOBALS['SITE_DB']->query_value_null_ok('db_meta_indices','i_name',array('i_table'=>'f_posts','i_name'=>'in_topic'))))?'USE INDEX (in_topic)':'';

	$order=$reverse?'p_time DESC,p.id DESC':'p_time ASC,p.id ASC';
	if (($is_threaded) && (db_has_subqueries($this_ref->connection->connection_read)))
	{
		$order=(($reverse?'compound_rating ASC':'compound_rating DESC').','.$order);
	}

	if (($light_if_threaded) && ($is_threaded))
	{
		$select='p.id,p.p_parent_id,p.p_intended_solely_for,p.p_poster';
	} else
	{
		$select='p.*,text_parsed,text_original';
		if (!db_has_subqueries($GLOBALS['FORUM_DB']->connection_read))
		{
			$select.=',h.h_post_id';
		}
	}
	if (($is_threaded) && (db_has_subqueries($this_ref->connection->connection_read)))
	{
		$select.=',COALESCE((SELECT AVG(rating) FROM '.$this_ref->connection->get_table_prefix().'rating WHERE '.db_string_equal_to('rating_for_type','post').' AND rating_for_id=p.id),5) AS compound_rating';
	}
	if (!db_has_subqueries($GLOBALS['FORUM_DB']->connection_read))
	{
		$rows=$this_ref->connection->query('SELECT '.$select.' FROM '.$this_ref->connection->get_table_prefix().'f_posts p '.$index.' LEFT JOIN '.$this_ref->connection->get_table_prefix().'translate t ON t.id=p.p_post LEFT JOIN '.$GLOBALS['FORUM_DB']->get_table_prefix().'f_post_history h ON (h.h_post_id=p.id AND h.h_action_date_and_time=p.p_last_edit_time) WHERE '.$where.' ORDER BY '.$order,$max,$start);
	} else // Can use subquery to avoid having to assume p_last_edit_time was not chosen as null during avoidance of duplication of rows
	{
		$rows=$this_ref->connection->query('SELECT '.$select.', (SELECT h_post_id FROM '.$GLOBALS['FORUM_DB']->get_table_prefix().'f_post_history h WHERE (h.h_post_id=p.id) LIMIT 1) AS h_post_id FROM '.$this_ref->connection->get_table_prefix().'f_posts p '.$index.' LEFT JOIN '.$this_ref->connection->get_table_prefix().'translate t ON t.id=p.p_post WHERE '.$where.' ORDER BY '.$order,$max,$start);
	}
	$count=$this_ref->connection->query_value_null_ok_full('SELECT COUNT(*) FROM '.$this_ref->connection->get_table_prefix().'f_posts p '.$index.' LEFT JOIN '.$this_ref->connection->get_table_prefix().'translate t ON t.id=p.p_post WHERE '.$where);

	$out=array();
	foreach ($rows as $myrow)
	{
		if ((is_null($myrow['p_intended_solely_for'])) || ($myrow['p_intended_solely_for']==get_member()) || (($myrow['p_intended_solely_for']==$this_ref->get_guest_id()) && ($this_ref->is_staff(get_member()))))
		{
			$temp=$myrow; // Takes all OCF properties

			// Then sanitised for normal forum driver API too (involves repetition)
			$temp['parent_id']=$myrow['p_parent_id'];
			if ((!$light_if_threaded) || (!$is_threaded))
			{
				$temp['title']=$myrow['p_title'];
				$message=new ocp_tempcode();
				if ((get_page_name()=='search') || (is_null($myrow['text_parsed'])) || ($myrow['text_parsed']=='') || ($myrow['p_post']==0))
				{
					$message=get_translated_tempcode($myrow['p_post'],$GLOBALS['FORUM_DB']);
				} else
				{
					if (!$message->from_assembly($myrow['text_parsed'],true))
						$message=get_translated_tempcode($myrow['p_post'],$GLOBALS['FORUM_DB']);
				}
				$temp['message']=$message;
				$temp['message_comcode']=get_translated_text($myrow['p_post'],$GLOBALS['FORUM_DB']);
				$temp['user']=$myrow['p_poster'];
				if ($myrow['p_poster_name_if_guest']!='') $temp['username']=$myrow['p_poster_name_if_guest'];
				$temp['date']=$myrow['p_time'];
			}

			$out[]=$temp;
		}
	}

	if ($mark_read)
	{
		require_code('ocf_topics');
		ocf_ping_topic_read($topic_id);
	}

	return $out;
}

/**
 * Load extra details for a list of posts. Does not need to return anything if forum driver doesn't support partial post loading (which is only useful for threaded topic partial-display).
 *
 * @param  object			Link to the real forum driver
 * @param  AUTO_LINK		Topic the posts come from
 * @param  array			List of post IDs
 * @return array			Extra details
 */
function _helper_get_post_remaining_details($this_ref,$topic_id,$post_ids)
{
	$count=0;
	$ret=_helper_get_forum_topic_posts($this_ref,$topic_id,$count,NULL,0,false,false,false,$post_ids,true);
	if (is_integer($ret)) return array();
	return $ret;
}

/**
 * Get an emoticon chooser template.
 *
 * @param  object			Link to the real forum driver
 * @param  string			The ID of the form field the emoticon chooser adds to
 * @return tempcode		The emoticon chooser template
 */
function _helper_get_emoticon_chooser($this_ref,$field_name)
{
	$extra=has_specific_permission(get_member(),'use_special_emoticons')?'':' AND e_is_special=0';
	$emoticons=$this_ref->connection->query('SELECT * FROM '.$this_ref->connection->get_table_prefix().'f_emoticons WHERE e_relevance_level=0'.$extra);
	$em=new ocp_tempcode();
	foreach ($emoticons as $emo)
	{
		$code=$emo['e_code'];
		if ($GLOBALS['XSS_DETECT']) ocp_mark_as_escaped($code);

		$em->attach(do_template('EMOTICON_CLICK_CODE',array('_GUID'=>'1a75f914e09f2325ad96ad679bcffe88','FIELD_NAME'=>$field_name,'CODE'=>$code,'IMAGE'=>apply_emoticons($code))));
	}

	return $em;
}

