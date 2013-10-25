<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

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

class Block_side_ocf_private_topics
{

	/**
	 * Standard modular info function.
	 *
	 * @return ?array	Map of module info (NULL: module is disabled).
	 */
	function info()
	{
		if (get_forum_type()!='ocf') return NULL;

		$info=array();
		$info['author']='Chris Graham';
		$info['organisation']='ocProducts';
		$info['hacked_by']=NULL;
		$info['hack_version']=NULL;
		$info['version']=2;
		$info['locked']=false;
		$info['parameters']=array();
		return $info;
	}

	/**
	 * Standard modular cache function.
	 *
	 * @return ?array	Map of cache details (cache_on and ttl) (NULL: module is disabled).
	 */
	function cacheing_environment()
	{
		$info=array();
		$info['cache_on']='array(get_member())';
		$info['ttl']=(get_value('no_block_timeout')==='1')?60*60*24*365*5/*5 year timeout*/:60*100;
		return $info;
	}

	/**
	 * Standard modular run function.
	 *
	 * @param  array		A map of parameters.
	 * @return tempcode	The result of execution.
	 */
	function run($map)
	{
		if (get_forum_type()!='ocf') return new ocp_tempcode();

		if (is_guest()) return new ocp_tempcode();

		ocf_require_all_forum_stuff();

		require_code('ocf_notifications');

		// Only show what's new in week. Some forums may want to tweak this, but forums themselves only mark unread topics for a week.
		$rows=ocf_get_pp_rows();
		require_lang('ocf');
		$out=new ocp_tempcode();
		foreach ($rows as $topic)
		{
			$topic_url=build_url(array('page'=>'topicview','id'=>$topic['id'],'type'=>'findpost'),get_module_zone('topicview'));
			$topic_url->attach('#post_'.strval($topic['id']));
			$title=$topic['t_cache_first_title'];
			$date=get_timezoned_date($topic['t_cache_last_time'],true);
			$username=$topic['t_cache_last_username'];
			$member_link=$GLOBALS['OCF_DRIVER']->member_profile_url($topic['t_cache_last_member_id'],false,true);
			$num_posts=$topic['t_cache_num_posts'];

			$is_unread=($topic['t_cache_last_time']>time()-60*60*24*intval(get_option('post_history_days'))) && ((is_null($topic['l_time'])) || ($topic['l_time']<$topic['p_time']));

			$out->attach(do_template('TOPIC_LIST',array('_GUID'=>'05beab5a3fab191df988bf101f44a47a','POSTER_URL'=>$member_link,
				'TOPIC_URL'=>$topic_url,
				'TITLE'=>$title,
				'DATE'=>$date,
				'DATE_RAW'=>strval($topic['t_cache_last_time']),
				'USERNAME'=>$username,
				'POSTER_ID'=>strval($topic['t_cache_last_member_id']),
				'NUM_POSTS'=>integer_format($num_posts),
				'HAS_READ'=>!$is_unread,
			)));
		}
		$send_url=build_url(array('page'=>'topics','type'=>'new_pt','redirect'=>SELF_REDIRECT),get_module_zone('topics'));
		if (!ocf_may_make_private_topic()) $send_url=new ocp_tempcode();
		$view_url=build_url(array('page'=>'members','type'=>'view','id'=>get_member()),get_module_zone('members'),NULL,true,false,false,'tab__pts');
		return do_template('BLOCK_SIDE_OCF_PRIVATE_TOPICS',array('_GUID'=>'9376cd47884a78f3d1914c176b67ee28','SEND_URL'=>$send_url,'VIEW_URL'=>$view_url,'CONTENT'=>$out,'FORUM_NAME'=>do_lang_tempcode('PRIVATE_TOPICS')));
	}

}


