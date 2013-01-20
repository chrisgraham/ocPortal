<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2013

 See text/EN/licence.txt for full licencing information.

*/

class upon_query_add_mentor
{
	function run($ob,$query,$max,$start,$fail_ok,$get_insert_id,$ret)
	{
		if (running_script('stress_test_loader')) return;
		if (get_page_name()=='admin_import') return;

		if (!isset($GLOBALS['FORUM_DB'])) return;
		if ($GLOBALS['IN_MINIKERNEL_VERSION']==1) return;

		//if (strpos($query,$GLOBALS['FORUM_DB']->get_table_prefix().'f_members')!==false && strpos($query,'BY RAND')==false) // to test without registration
		if (strpos($query,'INTO '.$GLOBALS['FORUM_DB']->get_table_prefix().'f_members')!==false)
		{
			load_user_stuff();
			if (method_exists($GLOBALS['FORUM_DRIVER'],'forum_layer_initialise')) $GLOBALS['FORUM_DRIVER']->forum_layer_initialise();
			global $FORCE_INVISIBLE_GUEST,$MEMBER_CACHED, $SESSION_CACHE;
			$FORCE_INVISIBLE_GUEST=false;
			$MEMBER_CACHED=NULL;

			if(!isset($SESSION_CACHE) || !is_array($SESSION_CACHE)) $SESSION_CACHE=array();

			$mentor_usergroup=get_option('mentor_usergroup',true);
			if (is_null($mentor_usergroup)) return;

			require_code('ocf_topics');
			require_code('ocf_forums');
			require_code('ocf_topics_action');
			require_code('ocf_posts_action');
			require_code('ocf_topics_action2');
			require_code('ocf_posts_action2');
			require_code('ocf_members');
			require_code('ocf_members2');

			require_lang('ocbestbuddy');

			$mentor_usergroup_id=0; //0 ?

			$groups=$GLOBALS['FORUM_DRIVER']->get_usergroup_list();
			foreach($groups as $group_id=>$group)
			{
				if($group==$mentor_usergroup) $mentor_usergroup_id=$group_id;
			}

			$random_mentor=$GLOBALS['FORUM_DB']->query('SELECT id FROM '.$GLOBALS['FORUM_DB']->get_table_prefix().'f_members m LEFT JOIN '.$GLOBALS['FORUM_DB']->get_table_prefix().'f_group_members g ON (g.gm_member_id=m.id AND gm_validated=1) WHERE gm_group_id='.strval($mentor_usergroup_id).' OR m_primary_group='.strval($mentor_usergroup_id).' ORDER BY RAND( ) LIMIT 1',NULL, NULL,true);

			$mentor_id=(isset($random_mentor[0]['id']) && !is_null($random_mentor[0]['id']))?$random_mentor[0]['id']:0;
			if ($mentor_id==0) return;
			$member_id=$ret;
			$time=time();

			$GLOBALS['SITE_DB']->query_delete('chat_friends',array(
				'member_likes'=>$mentor_id,
				'member_liked'=>$member_id
			),'',1); // Just in case page refreshed

			$GLOBALS['SITE_DB']->query_insert('chat_friends',array(
				'member_likes'=>$mentor_id,
				'member_liked'=>$member_id,
				'date_and_time'=>$time
			));

			$GLOBALS['SITE_DB']->query_delete('members_mentors',array(
				'member_id'=>$member_id,
				'mentor_id'=>$mentor_id,
			),'',1); // Just in case page refreshed

			$GLOBALS['SITE_DB']->query_insert('members_mentors',array(
				'member_id'=>$member_id,
				'mentor_id'=>$mentor_id,
			));

			log_it('MAKE_FRIEND',strval($mentor_id),strval($member_id));

			$subject=do_lang('MENTOR_PT_TOPIC',$GLOBALS['FORUM_DRIVER']->get_username($mentor_id),$GLOBALS['FORUM_DRIVER']->get_username($member_id));
			$topic_id=ocf_make_topic(NULL,$subject,'',1,1,0,0,0,$mentor_id,$member_id,false,0,NULL,'');
			$post_id=ocf_make_post($topic_id,$subject,do_lang('MENTOR_PT_TOPIC_POST',$GLOBALS['FORUM_DRIVER']->get_username($mentor_id),$GLOBALS['FORUM_DRIVER']->get_username($member_id),get_site_name()),0,true,1,0,NULL,NULL,NULL,$mentor_id,NULL,NULL,NULL,false,true,NULL,true,$subject,0,NULL,true,true,true);
			send_pt_notification($post_id,$subject,$topic_id,$member_id,$mentor_id);
			send_pt_notification($post_id,$subject,$topic_id,$mentor_id,$member_id);
		}
	}
}
