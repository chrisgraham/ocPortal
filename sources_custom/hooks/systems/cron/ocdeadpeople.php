<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2011

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

		require_code('mail');

		//get just desease that should spead and are enabled
		$deseases_to_spread=$GLOBALS['SITE_DB']->query('SELECT * FROM '.get_table_prefix().'diseases WHERE (last_spread_time<('.strval(time()).'-(spread_rate*60*60)) OR  last_spread_time=0) AND enabled=1',NULL,NULL,true);
		if (is_null($deseases_to_spread)) return;

		foreach($deseases_to_spread as $desease)
		{
			//select infected by the desease members
			$sick_by_desease_members=$GLOBALS['FORUM_DB']->query('SELECT user_id FROM '.$GLOBALS['FORUM_DB']->get_table_prefix().'members_diseases WHERE sick=1 AND desease_id='.strval($desease['id']).' ',NULL, NULL,true);
			if (is_null($sick_by_desease_members)) return;

			$sick_members=array();
			foreach($sick_by_desease_members as $sick_member)
			{
				$sick_members[]=$sick_member['user_id'];
			}
			$sick_members[]=$GLOBALS['FORUM_DRIVER']->get_guest_id();

			foreach($sick_by_desease_members as $sick_member)
			{
				require_code('points2');
				require_lang('ocdeadpeople');

				//get desease points
				charge_member($sick_member['user_id'],$desease['points_per_spread'],do_lang('DESEASE_GET') . ' "'.$desease['name'].'"');

				$friends_a=array();
				if (addon_installed('chat'))
				{
					$rows=$GLOBALS['SITE_DB']->query('SELECT * FROM '.$GLOBALS['SITE_DB']->get_table_prefix().'chat_buddies WHERE member_likes='.strval(intval($sick_member['user_id'])).' OR member_liked='.strval(intval($sick_member['user_id'])).' ORDER BY date_and_time');

					//get friends
					foreach ($rows as $i=>$row)
					{
						if($row['member_likes']<>$sick_member['user_id'])
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
				foreach($friends_a as $friend)
				{
					if(!in_array($friend,$sick_members))
						$friends_healthy[]=$friend;
				}

				$to_infect = array_rand($friends_healthy);

				if(isset($friends_healthy[$to_infect]) && ($friends_healthy[$to_infect]<>0))
				{

					$member_rows=$GLOBALS['FORUM_DB']->query_select('members_diseases',array('*'),array('user_id'=>$friends_healthy[$to_infect],'desease_id'=>$desease['id']));
					
					$insert=true;
					$has_immunization=false;
					if(isset($member_rows[0]['user_id']) && $member_rows[0]['user_id']<>0)
					{
						//there is already a db member desease record
						$insert=false;
						if($member_rows[0]['immunisation']==1)
							$has_immunization=true;
					}
 
					if(!$has_immunization)
					{


						if($insert)
						{
							$GLOBALS['SITE_DB']->query_insert('members_diseases',array('user_id'=>$friends_healthy[$to_infect],'desease_id'=>$desease['id'],'sick'=>1,'cure'=>0,'immunisation'=>0));

							$cure_url='';
							//$cure_url=build_url(array('page'=>'pointstore','type'=>'action_done','id'=>'ocdeadpeople','desease'=>$desease['id'],'cure'=>1),'_SEARCH');
							$cure_url=build_url(array('page'=>'pointstore','type'=>'action','id'=>'ocdeadpeople'),'_SEARCH');
							$cure_url=$cure_url->evaluate();

							$message=do_lang('MAIL_MESSAGE',$desease['name'],$desease['name'],array($cure_url,get_site_name()),get_lang($friends_healthy[$to_infect]));
							$email_address=$GLOBALS['FORUM_DRIVER']->get_member_email_address($friends_healthy[$to_infect]);
							$member_name=$GLOBALS['FORUM_DRIVER']->get_username($friends_healthy[$to_infect]);

							mail_wrap(do_lang('MAIL_SUBJECT',get_site_name(),NULL,NULL,get_lang($friends_healthy[$to_infect])),$message,array($email_address),$member_name,'','',3,NULL,false,NULL,false,false);
						}
						else
						{
							$cure_url='';
							//$cure_url=build_url(array('page'=>'pointstore','type'=>'action_done','id'=>'ocdeadpeople','desease'=>$desease['id'],'cure'=>1),'_SEARCH');
							$cure_url=build_url(array('page'=>'pointstore','type'=>'action','id'=>'ocdeadpeople'),'_SEARCH');
							$cure_url=$cure_url->evaluate();

							$message=do_lang('MAIL_MESSAGE',$desease['name'],$desease['name'],array($cure_url,get_site_name()),get_lang($friends_healthy[$to_infect]));
							$email_address=$GLOBALS['FORUM_DRIVER']->get_member_email_address($friends_healthy[$to_infect]);
							$member_name=$GLOBALS['FORUM_DRIVER']->get_username($friends_healthy[$to_infect]);

							mail_wrap(do_lang('MAIL_SUBJECT',get_site_name(),NULL,NULL,get_lang($friends_healthy[$to_infect])),$message,array($email_address),$member_name,'','',3,NULL,false,NULL,false,false);

							//infect again the member
							$GLOBALS['SITE_DB']->query_update('members_diseases',array('user_id'=>$friends_healthy[$to_infect],'desease_id'=>$desease['id'],'sick'=>1,'cure'=>0,'immunisation'=>0),array('user_id'=>$friends_healthy[$to_infect],'desease_id'=>$desease['id']),'',1);
						}

						$sick_members[]=$friends_healthy[$to_infect];
					}
				}
			}


			//proceed with infecting random not immunalized member

			//get immunalized members first
			$immunalized_members_rows=$GLOBALS['FORUM_DB']->query('SELECT * FROM '.$GLOBALS['FORUM_DB']->get_table_prefix().'members_diseases WHERE desease_id='.strval($desease['id']).' AND immunisation =1',NULL,NULL,true);

			$immunalized_members=array();
			foreach($immunalized_members_rows as  $im_member)
			{
				$immunalized_members[]=$im_member['user_id'];
			}

			$sick_and_immunalized_members=array();
			$sick_and_immunalized_members=array_merge((array)$sick_members, (array)$immunalized_members);

			//create a csv list of members to be avoided - sick and immunalized members should be avoided !!!
			$avoid_members=implode(",",$sick_and_immunalized_members);

			$avoid_members=(strlen($avoid_members)==0)?'0':$avoid_members;

			$random_member=$GLOBALS['FORUM_DB']->query('SELECT id FROM '.$GLOBALS['FORUM_DB']->get_table_prefix().'f_members WHERE  id <> '.strval($GLOBALS['FORUM_DRIVER']->get_guest_id()).' AND id NOT IN ('.$avoid_members.')  ORDER BY RAND( ) ',1, NULL,true);

			//if there is a rondomly selected members that can be infected, otherwise all of the members are already infected or immunalized
			if(isset($random_member[0]['id']) && $random_member[0]['id']>0)
			{
		
				$member_rows=$GLOBALS['FORUM_DB']->query_select('members_diseases',array('*'),array('user_id'=>strval($random_member[0]['id']),'desease_id'=>$desease['id']));
				
				$insert=true;
				if(isset($member_rows[0]['user_id']) && $member_rows[0]['user_id']>0)
				{
					//there is already a db member desease record
					$insert=false;
				}

				if($insert)
				{
					$GLOBALS['SITE_DB']->query_insert('members_diseases',array('user_id'=>strval($random_member[0]['id']),'desease_id'=>$desease['id'],'sick'=>1,'cure'=>0,'immunisation'=>0));

					$cure_url='';
					//$cure_url=build_url(array('page'=>'pointstore','type'=>'action_done','id'=>'ocdeadpeople','desease'=>$desease['id'],'cure'=>1),'_SEARCH');
					$cure_url=build_url(array('page'=>'pointstore','type'=>'action','id'=>'ocdeadpeople'),'_SEARCH');
					$cure_url=$cure_url->evaluate();

					$message=do_lang('MAIL_MESSAGE',$desease['name'],$desease['name'],array($cure_url,get_site_name()),get_lang($friends_healthy[$to_infect]));
					$email_address=$GLOBALS['FORUM_DRIVER']->get_member_email_address($random_member[0]['id']);
					$member_name=$GLOBALS['FORUM_DRIVER']->get_username($random_member[0]['id']);

					mail_wrap(do_lang('MAIL_SUBJECT',get_site_name(),NULL,NULL,get_lang($friends_healthy[$to_infect])),$message,array($email_address),$member_name,'','',3,NULL,false,NULL,false,false);
				}
				else
				{
					//infect again the member
					$GLOBALS['SITE_DB']->query_update('members_diseases',array('user_id'=>strval($random_member[0]['id']),'desease_id'=>strval($desease['id']),'sick'=>1,'cure'=>0,'immunisation'=>0),array('user_id'=>strval($random_member[0]['id']),'desease_id'=>strval($desease['id'])),'',1);

					$cure_url='';
					//$cure_url=build_url(array('page'=>'pointstore','type'=>'action_done','id'=>'ocdeadpeople','desease'=>$desease['id'],'cure'=>1),'_SEARCH');
					$cure_url=build_url(array('page'=>'pointstore','type'=>'action','id'=>'ocdeadpeople'),'_SEARCH');
					$cure_url=$cure_url->evaluate();

					$message=do_lang('MAIL_MESSAGE',$desease['name'],$desease['name'],array($cure_url,get_site_name()),get_lang($friends_healthy[$to_infect]));
					$email_address=$GLOBALS['FORUM_DRIVER']->get_member_email_address($random_member[0]['id']);
					$member_name=$GLOBALS['FORUM_DRIVER']->get_username($random_member[0]['id']);

					mail_wrap(do_lang('MAIL_SUBJECT',get_site_name(),NULL,NULL,get_lang($friends_healthy[$to_infect])),$message,array($email_address),$member_name,'','',3,NULL,false,NULL,false,false);
				}
			}

			//record desease spreading
			$GLOBALS['SITE_DB']->query_update('diseases',array('last_spread_time'=>strval(time())),array('id'=>strval($desease['id'])),'',1);
		}
	}

}


