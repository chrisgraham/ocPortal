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

class Hook_cron_ocdeadpeople
{

	/**
	 * Standard modular run function for CRON hooks. Searches for tasks to perform.
	 */
	function run()
	{
		//if (!addon_installed('ocdeadpeople')) return;

		// ensure it is done once per week
		$time=time();
		$last_time=intval(get_value('last_dead_time'));
		if ($last_time>time()-24*60*60) return; // run it once a day
		set_value('last_dead_time',strval($time));

		// get just disease that should spead and are enabled
		$diseases_to_spread=$GLOBALS['SITE_DB']->query('SELECT * FROM '.get_table_prefix().'diseases WHERE (last_spread_time<('.strval(time()).'-(spread_rate*60*60)) OR  last_spread_time=0) AND enabled=1',NULL,NULL,true);
		if (is_null($diseases_to_spread)) return;

		foreach ($diseases_to_spread as $disease)
		{
			// select infected by the disease members
			$sick_by_disease_members=$GLOBALS['SITE_DB']->query('SELECT user_id FROM '.$GLOBALS['SITE_DB']->get_table_prefix().'members_diseases WHERE sick=1 AND disease_id='.strval($disease['id']).' ',NULL, NULL,true);
			if (is_null($sick_by_disease_members)) return;

			$sick_members=array();
			foreach ($sick_by_disease_members as $sick_member)
			{
				$sick_members[]=$sick_member['user_id'];
			}
			$sick_members[]=$GLOBALS['FORUM_DRIVER']->get_guest_id();

			foreach ($sick_by_disease_members as $sick_member)
			{
				require_code('points2');
				require_lang('ocdeadpeople');

				// charge disease points
				charge_member($sick_member['user_id'],$disease['points_per_spread'],do_lang('DISEASE_GET') . ' "'.$disease['name'].'"');

				// pick a random friend to infect
				$friends_a=array();
				if (addon_installed('chat'))
				{
					$rows=$GLOBALS['SITE_DB']->query('SELECT * FROM '.$GLOBALS['SITE_DB']->get_table_prefix().'chat_buddies WHERE member_likes='.strval(intval($sick_member['user_id'])).' OR member_liked='.strval(intval($sick_member['user_id'])).' ORDER BY date_and_time');

					// get friends
					foreach ($rows as $i=>$row)
					{
						if ($row['member_likes']!=$sick_member['user_id'])
						{
							$friends_a[$row['member_likes']]=$row['member_likes'];
						}
						else
						{
							$friends_a[$row['member_liked']]=$row['member_liked'];
						}
					}
				}

				$friends_list=implode(",",$friends_a);
				$friends_healthy=array();
				foreach ($friends_a as $friend)
				{
					if (!in_array($friend,$sick_members))
						$friends_healthy[]=$friend;
				}

				$to_infect=array_rand($friends_healthy);

				if (isset($friends_healthy[$to_infect]) && ($friends_healthy[$to_infect]!=0))
				{
					$member_rows=$GLOBALS['SITE_DB']->query_select('members_diseases',array('*'),array('user_id'=>$friends_healthy[$to_infect],'disease_id'=>$disease['id']));

					$insert=true;
					$has_immunization=false;
					if (isset($member_rows[0]['user_id']) && $member_rows[0]['user_id']!=0)
					{
						// there is already a db member disease record
						$insert=false;
						if ($member_rows[0]['immunisation']==1)
							$has_immunization=true;
					}

					if (!$has_immunization)
					{
						//$cure_url=build_url(array('page'=>'pointstore','type'=>'action_done','id'=>'ocdeadpeople','disease'=>$disease['id'],'cure'=>1),'_SEARCH');
						$cure_url=build_url(array('page'=>'pointstore','type'=>'action','id'=>'ocdeadpeople'),'_SEARCH',NULL,false,false,true);
						$cure_url=$cure_url->evaluate();

						if ($insert)
						{
							// infect the member for the first time
							$GLOBALS['SITE_DB']->query_insert('members_diseases',array('user_id'=>$friends_healthy[$to_infect],'disease_id'=>$disease['id'],'sick'=>1,'cure'=>0,'immunisation'=>0));
						} else
						{
							// infect the member again
							$GLOBALS['SITE_DB']->query_update('members_diseases',array('user_id'=>$friends_healthy[$to_infect],'disease_id'=>$disease['id'],'sick'=>1,'cure'=>0,'immunisation'=>0),array('user_id'=>$friends_healthy[$to_infect],'disease_id'=>$disease['id']),'',1);
						}

						$message=do_lang('DISEASES_MAIL_MESSAGE',$disease['name'],$disease['name'],array($cure_url,get_site_name()),get_lang($friends_healthy[$to_infect]));
						dispatch_notification('got_disease',NULL,do_lang('DISEASES_MAIL_SUBJECT',get_site_name(),$disease['name'],NULL,get_lang($friends_healthy[$to_infect])),$message,array($friends_healthy[$to_infect]),A_FROM_SYSTEM_PRIVILEGED);

						$sick_members[]=$friends_healthy[$to_infect];
					}
				}
			}


			// proceed with infecting a random but not immunised member (disease initiation)
			// =============================================================================

			// get immunised members first
			$immunised_members_rows=$GLOBALS['SITE_DB']->query('SELECT * FROM '.$GLOBALS['SITE_DB']->get_table_prefix().'members_diseases WHERE disease_id='.strval($disease['id']).' AND immunisation=1',NULL,NULL,true);
			$immunised_members=array();
			foreach ($immunised_members_rows as  $im_member)
			{
				$immunised_members[]=$im_member['user_id'];
			}

			$sick_and_immunised_members=array();
			$sick_and_immunised_members=array_merge($sick_members,$immunised_members);

			// create a csv list of members to be avoided - sick and immunised members should be avoided !!!
			$avoid_members=implode(',',$sick_and_immunised_members);

			$avoid_members=(strlen($avoid_members)==0)?'0':$avoid_members;

			// if there is a rondomly selected members that can be infected, otherwise all of the members are already infected or immunised
			$random_member=$GLOBALS['SITE_DB']->query('SELECT id FROM '.$GLOBALS['FORUM_DB']->get_table_prefix().'f_members WHERE id<>'.strval($GLOBALS['FORUM_DRIVER']->get_guest_id()).' AND id NOT IN ('.$avoid_members.') ORDER BY RAND()',1,NULL,true);
			if (isset($random_member[0]['id']) && $random_member[0]['id']>0)
			{
				$member_rows=$GLOBALS['SITE_DB']->query_select('members_diseases',array('*'),array('user_id'=>strval($random_member[0]['id']),'disease_id'=>$disease['id']));

				$insert=true;
				if (isset($member_rows[0]['user_id']) && $member_rows[0]['user_id']>0)
				{
					// there is already a db member disease record
					$insert=false;
				}

				require_code('notifications');

				//$cure_url=build_url(array('page'=>'pointstore','type'=>'action_done','id'=>'ocdeadpeople','disease'=>$disease['id'],'cure'=>1),'_SEARCH');
				$cure_url=build_url(array('page'=>'pointstore','type'=>'action','id'=>'ocdeadpeople'),'_SEARCH',NULL,false,false,true);
				$cure_url=$cure_url->evaluate();

				if ($insert)
				{
					// infect the member for the first time
					$GLOBALS['SITE_DB']->query_insert('members_diseases',array('user_id'=>strval($random_member[0]['id']),'disease_id'=>$disease['id'],'sick'=>1,'cure'=>0,'immunisation'=>0));
				} else
				{
					// infect the member again
					$GLOBALS['SITE_DB']->query_update('members_diseases',array('user_id'=>strval($random_member[0]['id']),'disease_id'=>$disease['id'],'sick'=>1,'cure'=>0,'immunisation'=>0),array('user_id'=>strval($random_member[0]['id']),'disease_id'=>strval($disease['id'])),'',1);
				}

				$message=do_lang('DISEASES_MAIL_MESSAGE',$disease['name'],$disease['name'],array($cure_url,get_site_name()),get_lang($random_member[0]['id']));
				dispatch_notification('got_disease',NULL,do_lang('DISEASES_MAIL_SUBJECT',get_site_name(),$disease['name'],NULL,get_lang($random_member[0]['id'])),$message,array($random_member[0]['id']),A_FROM_SYSTEM_PRIVILEGED);
			}

			// record disease spreading
			$GLOBALS['SITE_DB']->query_update('diseases',array('last_spread_time'=>strval(time())),array('id'=>strval($disease['id'])),'',1);
		}
	}

}


