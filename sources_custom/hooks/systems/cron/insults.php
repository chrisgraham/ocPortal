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

class Hook_cron_insults
{

	/**
	 * Standard modular run function for CRON hooks. Searches for tasks to perform.
	 */
	function run()
	{
		//if (!addon_installed('octhief')) return;

		require_lang('insults');

		// ensure it is done once per week		
		$time=time();
		$last_time=intval(get_value('last_insult_time'));
		if ($last_time>time()-24*60*60) return; // run it once a day
		set_value('last_insult_time',strval($time));

		// how many points a correct response will give
		$_insult_points=get_option('insult_points', true);
		if (is_null($_insult_points))
		{
			// add option and default value if not installed yet
			require_code('database_action');
			add_config_option('INSULT_POINTS','insult_points','integer','return \'10\';','POINTS','INSULT_TITLE');
		}
		$insult_points=(isset($_insult_points) && is_numeric($_insult_points))?intval($_insult_points):10;

		// who to insult?
		$selected_members=$GLOBALS['FORUM_DB']->query('SELECT id FROM '.$GLOBALS['FORUM_DB']->get_table_prefix().'f_members WHERE  id <> '.strval($GLOBALS['FORUM_DRIVER']->get_guest_id()).' ORDER BY RAND( ) ',2, NULL,true);
		$selected_member1=(isset($selected_members[0]['id']) && $selected_members[0]['id']>0)?$selected_members[0]['id']:0;
		$selected_member2=(isset($selected_members[1]['id']) && $selected_members[1]['id']>0)?$selected_members[1]['id']:0;

		// send insult to picked members
		if ($selected_member1!=0 && $selected_member2!=0)
		{
			$get_insult='';
			if (is_file(get_file_base().'/text_custom/'.user_lang().'/insults.txt'))
			{		
				$insults=file(get_file_base().'/text_custom/'.user_lang().'/insults.txt');
				$insults_array=array();
				foreach($insults as $insult)
				{
					$x=explode('=',$insult);
					$insults_array[]=$x[0];
				}

				$rand_key = array_rand($insults_array, 1);
				$rand_key = is_array($rand_key)?$rand_key[0]:$rand_key;

				$get_insult=$insults_array[$rand_key];
			}

			if ($get_insult!='')
			{
				global $SITE_INFO;

				$insult_pt_topic_post=do_lang('INSULT_EXPLANATION',get_site_name(),$get_insult,$insult_points);

				$subject=do_lang('INSULT_PT_TOPIC',$GLOBALS['FORUM_DRIVER']->get_username($selected_member2),$GLOBALS['FORUM_DRIVER']->get_username($selected_member1));

				require_code('ocf_topics_action');
				$topic_id=ocf_make_topic(NULL,$subject,'',1,1,0,0,0,$selected_member2,$selected_member1,true,0,NULL,'');

				require_code('ocf_posts_action');
				$post_id=ocf_make_post($topic_id,$subject,$insult_pt_topic_post,0,true,1,0,do_lang('SYSTEM'),NULL,NULL,$GLOBALS['FORUM_DRIVER']->get_guest_id(),NULL,NULL,NULL,false,true,NULL,true,$subject,0,NULL,true,true,true);

				require_code('ocf_topics_action2');
				send_pt_notification($post_id,$subject,$topic_id,$selected_member2,$selected_member1);
			}
		}
	}
}
