<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		stats
 */

class Hook_cron_octhief
{

	/**
	 * Standard modular run function for CRON hooks. Searches for tasks to perform.
	 */
	function run()
	{
		//if (!addon_installed('octhief')) return;

		require_code('ocf_topics_action2');

		require_code('points');

		require_lang('octhief');

		// ensure it is done once per week		
		$time=time();
		$last_time=intval(get_value('last_thieving_time'));
		if ($last_time>time()-24*60*60*7) return;
		set_value('last_thieving_time',strval($time));

		$octhief_type=get_option('octhief_type', true);
		$octhief_type=(isset($octhief_type) && strlen($octhief_type)>0)?$octhief_type:'Members that are inactive, but has lots points';

		$_octhief_number=get_option('octhief_number', true);
		$octhief_number=(isset($_octhief_number) && is_numeric($_octhief_number))?intval($_octhief_number):1;

		$_octhief_points=get_option('octhief_points', true);
		$octhief_points=(isset($_octhief_points) && is_numeric($_octhief_points))?intval($_octhief_points):10;

		$octhief_group=get_option('octhief_group', true);
		$octhief_group=(isset($octhief_group) && strlen($octhief_group)>0)?$octhief_group:'Member';

		// start determining the various cases
		if($octhief_type == "Members that are inactive, but has lots points")
		{
			$all_members=$GLOBALS['FORUM_DRIVER']->get_top_posters(1000);
			$points=array();
			foreach ($all_members as $member)
			{
				$id=$GLOBALS['FORUM_DRIVER']->pname_id($member);
				$signin_time=$member['m_last_visit_time'];
				$points[$signin_time]=array('points'=>available_points($id),'id'=>$id);
			}

			ksort($points);

			//print_r($points);

			$octhief_number=(count($points) > $octhief_number)?$octhief_number:count($points);
			$theft_count=0;

			foreach ($points as $member)
			{
				$theft_count++;

				if ($theft_count>$octhief_number) break;

				// start stealing
				require_code('points2');
				require_lang('octhief');

				$total_points=$member['points'];
				$octhief_points=($octhief_points<$total_points)?$octhief_points:$total_points;

				$give_to_member=$GLOBALS['FORUM_DB']->query('SELECT id FROM '.$GLOBALS['FORUM_DB']->get_table_prefix().'f_members WHERE  id <> '.strval($GLOBALS['FORUM_DRIVER']->get_guest_id()).' AND id <> '.strval($member['id']).' ORDER BY RAND( ) ',1, NULL,true);

				$give_to_member=(isset($give_to_member[0]['id']) && $give_to_member[0]['id']>0)?$give_to_member[0]['id']:0;

				// get THIEF points
				charge_member($member['id'],$octhief_points,do_lang('THIEF_GET') . ' ' .strval($octhief_points).' point(-s) from you.');

				if ($give_to_member>0)
				{
					system_gift_transfer(do_lang('THIEF_GAVE_YOU').' '. strval($octhief_points).' point(-s)',$octhief_points,$give_to_member);

					require_code('ocf_topic_action');
					require_code('ocf_posts_action');

					$subject=do_lang('THIEF_PT_TOPIC',strval($octhief_points),$GLOBALS['FORUM_DRIVER']->get_username($member['id']),$GLOBALS['FORUM_DRIVER']->get_username($give_to_member));
					$topic_id=ocf_make_topic(NULL,$subject,'',1,1,0,0,0,$member['id'],$give_to_member,false,0,NULL,'');

					$post_id=ocf_make_post($topic_id,$subject,do_lang('THIEF_PT_TOPIC_POST'),0,true,1,0,NULL,NULL,NULL,$give_to_member,NULL,NULL,NULL,false,true,NULL,true,$subject,0,NULL,true,true,true);

					send_pt_notification($post_id,$subject,$topic_id,$give_to_member,$GLOBALS['FORUM_DRIVER']->pname_id($member));
					send_pt_notification($post_id,$subject,$topic_id,$GLOBALS['FORUM_DRIVER']->pname_id($member),$give_to_member);
				}
			}

		} elseif ($octhief_type == "Members that are rich")
		{
			$all_members=$GLOBALS['FORUM_DRIVER']->get_top_posters(100);
			$points=array();
			foreach ($all_members as $member)
			{
				$id=$GLOBALS['FORUM_DRIVER']->pname_id($member);
				$points[$id]=available_points($id);
			}
			arsort($points);

			$octhief_number=(count($points) > $octhief_number)?$octhief_number:count($points);
			$theft_count=0;

			foreach ($points as $member_id => $av_points)
			{
				$theft_count++;

				if ($theft_count>$octhief_number) break;

				// start stealing
				require_code('points2');
				require_lang('octhief');

				$total_points=$av_points;
				$octhief_points=($octhief_points<$total_points)?$octhief_points:$total_points;

				$give_to_member=$GLOBALS['FORUM_DB']->query('SELECT id FROM '.$GLOBALS['FORUM_DB']->get_table_prefix().'f_members WHERE  id <> '.strval($GLOBALS['FORUM_DRIVER']->get_guest_id()).' AND id <> '.strval($member_id).' ORDER BY RAND( ) ',1, NULL,true);

				$give_to_member=(isset($give_to_member[0]['id']) && $give_to_member[0]['id']>0)?$give_to_member[0]['id']:0;

				// get THIEF points
				charge_member($member_id,$octhief_points,do_lang('THIEF_GET') . ' ' .strval($octhief_points).' point(-s) from you.');

				if ($give_to_member>0)
				{
					system_gift_transfer(do_lang('THIEF_GAVE_YOU').' '. strval($octhief_points).' point(-s)',$octhief_points,$give_to_member);

					require_code('ocf_topic_action');
					require_code('ocf_posts_action');

					$subject=do_lang('THIEF_PT_TOPIC',strval($octhief_points));
					$topic_id=ocf_make_topic(NULL,$subject,'',1,1,0,0,0,$member_id,$give_to_member,false,0,NULL,'');

					$post_id=ocf_make_post($topic_id,$subject,do_lang('THIEF_PT_TOPIC_POST'),0,true,1,0,NULL,NULL,NULL,$give_to_member,NULL,NULL,NULL,false,true,NULL,true,$subject,0,NULL,true,true,true);

					send_pt_notification($post_id,$subject,$topic_id,$give_to_member,$member);
					send_pt_notification($post_id,$subject,$topic_id,$member,$give_to_member);
				}
			}

		} elseif ($octhief_type == "Members that are random")
		{
			$random_members=$GLOBALS['FORUM_DB']->query('SELECT id FROM '.$GLOBALS['FORUM_DB']->get_table_prefix().'f_members WHERE  id <> '.strval($GLOBALS['FORUM_DRIVER']->get_guest_id()).' ORDER BY RAND( ) ',$octhief_number, NULL,true);

			$octhief_number=(count($random_members) > $octhief_number)?$octhief_number:count($random_members);

			foreach ($random_members as $member)
			{
				// start stealing
				require_code('points2');
				require_lang('octhief');

				$total_points=available_points($member['id']);
				$octhief_points=($octhief_points<$total_points)?$octhief_points:$total_points;

				$give_to_member=$GLOBALS['FORUM_DB']->query('SELECT id FROM '.$GLOBALS['FORUM_DB']->get_table_prefix().'f_members WHERE  id <> '.strval($GLOBALS['FORUM_DRIVER']->get_guest_id()).' AND id <> '.strval($member['id']).' ORDER BY RAND( ) ',1, NULL,true);

				$give_to_member=(isset($give_to_member[0]['id']) && $give_to_member[0]['id']>0)?$give_to_member[0]['id']:0;

				// get THIEF points
				charge_member($member['id'],$octhief_points,do_lang('THIEF_GET') . ' ' .strval($octhief_points).' point(-s) from you.');

				if ($give_to_member!=0)
				{
					system_gift_transfer(do_lang('THIEF_GAVE_YOU').' '. strval($octhief_points).' point(-s)',$octhief_points,$give_to_member);

					require_code('ocf_topic_action');
					require_code('ocf_posts_action');

					$subject=do_lang('THIEF_PT_TOPIC',strval($octhief_points));
					$topic_id=ocf_make_topic(NULL,$subject,'',1,1,0,0,0,$member['id'],$give_to_member,false,0,NULL,'');

					$post_id=ocf_make_post($topic_id,$subject,do_lang('THIEF_PT_TOPIC_POST'),0,true,1,0,NULL,NULL,NULL,$give_to_member,NULL,NULL,NULL,false,true,NULL,true,$subject,0,NULL,true,true,true);

					send_pt_notification($post_id,$subject,$topic_id,$give_to_member,$member);
					send_pt_notification($post_id,$subject,$topic_id,$member,$give_to_member);
				}
			}

		} elseif ($octhief_type == "Members that are in a certain usergroup")
		{

			$groups=$GLOBALS['FORUM_DRIVER']->get_usergroup_list();

			$group_id=0;
			foreach ($groups as $id=>$group)
			{
				if($octhief_group==$group)
					$group_id=$id;
			}

			require_code('ocf_groups2');
			$members=ocf_get_group_members_raw($group_id);

			$octhief_number=(count($members) > $octhief_number)?$octhief_number:count($members);

			$members_to_steal_ids=array_rand($members, $octhief_number);

			if($octhief_number == 1)
				$members_to_steal_ids=array('0'=>$members_to_steal_ids);

			foreach ($members_to_steal_ids as $member_rand_key)
			{
				// start stealing
				require_code('points2');
				require_lang('octhief');

				//echo $members[$member_rand_key];
				$total_points=available_points($members[$member_rand_key]);
				$octhief_points=($octhief_points<$total_points)?$octhief_points:$total_points;

				$give_to_member=$GLOBALS['FORUM_DB']->query('SELECT id FROM '.$GLOBALS['FORUM_DB']->get_table_prefix().'f_members WHERE  id <> '.strval($GLOBALS['FORUM_DRIVER']->get_guest_id()).' AND id <> '.strval($members[$member_rand_key]).' ORDER BY RAND( ) ',1, NULL,true);

				$give_to_member=(isset($give_to_member[0]['id']) && $give_to_member[0]['id']>0)?$give_to_member[0]['id']:0;

				// get THIEF points
				charge_member($members[$member_rand_key],$octhief_points,do_lang('THIEF_GET') . ' ' .strval($octhief_points).' point(-s) from you.');

				if ($give_to_member!=0)
				{
					system_gift_transfer(do_lang('THIEF_GAVE_YOU').' '. strval($octhief_points).' point(-s)',$octhief_points,$give_to_member);

					require_code('ocf_topics_action');
					$subject=do_lang('THIEF_PT_TOPIC',strval($octhief_points));
					$topic_id=ocf_make_topic(NULL,$subject,'',1,1,0,0,0,$members[$member_rand_key],$give_to_member,false,0,NULL,'');

					require_code('ocf_posts_action');
					$post_id=ocf_make_post($topic_id,$subject,do_lang('THIEF_PT_TOPIC_POST'),0,true,1,0,NULL,NULL,NULL,$give_to_member,NULL,NULL,NULL,false,true,NULL,true,$subject,0,NULL,true,true,true);

					require_code('ocf_topics_action2');
					send_pt_notification($post_id,$subject,$topic_id,$give_to_member,$octhief_number);
					send_pt_notification($post_id,$subject,$topic_id,$octhief_number,$give_to_member);
				}
			}
		}
	}
}
