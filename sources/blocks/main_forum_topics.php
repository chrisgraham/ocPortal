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
 * @package		forum_blocks
 */

class Block_main_forum_topics
{
	/**
	 * Find details of the block.
	 *
	 * @return ?array	Map of block info (NULL: block is disabled).
	 */
	function info()
	{
		$info=array();
		$info['author']='Chris Graham';
		$info['organisation']='ocProducts';
		$info['hacked_by']=NULL;
		$info['hack_version']=NULL;
		$info['version']=2;
		$info['locked']=false;
		$info['parameters']=array('param','limit','hot','date_key','username_key','title','check');
		return $info;
	}

	/**
	 * Find cacheing details for the block.
	 *
	 * @return ?array	Map of cache details (cache_on and ttl) (NULL: block is disabled).
	 */
	function cacheing_environment()
	{
		$info=array();
		$info['cache_on']='array(array_key_exists(\'check\',$map)?$map[\'check\']:\'0\',array_key_exists(\'title\',$map)?$map[\'title\']:\'\',array_key_exists(\'hot\',$map)?$map[\'hot\']:\'0\',array_key_exists(\'param\',$map)?$map[\'param\']:\'General chat\',array_key_exists(\'limit\',$map)?$map[\'limit\']:6,array_key_exists(\'date_key\',$map)?$map[\'date_key\']:\'lasttime\',array_key_exists(\'username_key\',$map)?$map[\'username_key\']:\'firstusername\')';
		$info['ttl']=(get_value('no_block_timeout')==='1')?60*60*24*365*5/*5 year timeout*/:10;
		return $info;
	}

	/**
	 * Execute the block.
	 *
	 * @param  array		A map of parameters.
	 * @return tempcode	The result of execution.
	 */
	function run($map)
	{
		if (has_no_forum()) return new ocp_tempcode();

		require_css('news');

		// Read in variables
		$forum_name=array_key_exists('param',$map)?$map['param']:'General chat';
		$limit=array_key_exists('limit',$map)?intval($map['limit']):6;
		$hot=array_key_exists('hot',$map)?intval($map['hot']):0;
		$date_key=array_key_exists('date_key',$map)?$map['date_key']:'lasttime';
		if (($date_key!='lasttime') && ($date_key!='firsttime')) $date_key='firsttime';
		$username_key=array_key_exists('username_key',$map)?$map['username_key']:'firstusername';
		if (($username_key!='lastusername') && ($username_key!='firstusername')) $username_key='firstusername';
		$memberid_key=($username_key=='firstusername')?'firstmemberid':'lastmemberid';

		// Work out exactly what forums we're reading
		$forum_ids=array();
		if ((get_forum_type()=='ocf') && ((strpos($forum_name,',')!==false) || (strpos($forum_name,'*')!==false) || (preg_match('#\d[-\*\+]#',$forum_name)!=0) || (is_numeric($forum_name))))
		{
			require_code('ocfiltering');
			$forum_names=ocfilter_to_idlist_using_db($forum_name,'id','f_forums','f_forums','f_parent_forum','f_parent_forum','id',true,true,$GLOBALS['FORUM_DB']);
		} else
		{
			$forum_names=explode(',',$forum_name);
		}

		foreach ($forum_names as $forum_name)
		{
			if (!is_string($forum_name)) $forum_name=strval($forum_name);

			$forum_name=trim($forum_name);

			if ($forum_name=='<announce>')
			{
				$forum_id=NULL;
			} else
			{
				$forum_id=is_numeric($forum_name)?intval($forum_name):$GLOBALS['FORUM_DRIVER']->forum_id_from_name($forum_name);
			}

			if ((get_forum_type()=='ocf') && (array_key_exists('check',$map)) && ($map['check']=='1'))
			{
				if (!has_category_access(get_member(),'forums',strval($forum_id)))
					continue;
			}

			if (!is_null($forum_id))
			{
				$forum_ids[$forum_id]=$forum_name;
			}
		}

		// Block title
		$forum_name=array_key_exists('param',$map)?$map['param']:'General chat';
		if ((is_numeric($forum_name)) && (get_forum_type()=='ocf'))
		{
			$forum_name=$GLOBALS['FORUM_DB']->query_select_value_if_there('f_forums','f_name',array('id'=>intval($forum_name)));
			if (is_null($forum_name)) return paragraph(do_lang_tempcode('MISSING_RESOURCE'),'','red_alert');
		}
		$_title=do_lang_tempcode('ACTIVE_TOPICS_IN',escape_html($forum_name));
		if ((array_key_exists('title',$map)) && ($map['title']!='')) $_title=protect_from_escaping(escape_html($map['title']));

		// Add topic link
		if ((count($forum_names)==1) && (get_forum_type()=='ocf') && (!is_null($forum_id)))
		{
			$submit_url=build_url(array('page'=>'topics','type'=>'new_topic','id'=>$forum_id),get_module_zone('topics'));
			$add_name=do_lang_tempcode('ADD_TOPIC');
		} else
		{
			$submit_url=new ocp_tempcode();
			$add_name=new ocp_tempcode();
		}

		// Show all topics
		if (get_forum_type()=='ocf')
		{
			$forum_names_map=collapse_2d_complexity('id','f_name',$GLOBALS['FORUM_DB']->query('SELECT id,f_name FROM '.$GLOBALS['FORUM_DB']->get_table_prefix().'f_forums WHERE f_cache_num_posts>0'));
		} else
		{
			$forum_names_map=NULL;
		}
		if (!has_no_forum())
		{
			$max_rows=0;
			$topics=$GLOBALS['FORUM_DRIVER']->show_forum_topics($forum_ids,$limit,0,$max_rows,'',true,$date_key,$hot==1);

			$out=new ocp_tempcode();
			if (!is_null($topics))
			{
				sort_maps_by($topics,$date_key);
				$topics=array_reverse($topics,false);

				if ((count($topics)<$limit) && ($hot==1))
				{
					$more_topics=$GLOBALS['FORUM_DRIVER']->show_forum_topics($forum_ids,$limit,0,$max_rows,'',true,$date_key);
					if (is_null($more_topics)) $more_topics=array();
					$topics=array_merge($topics,$more_topics);
				}

				$done=0;
				$seen=array();
				foreach ($topics as $topic)
				{
					if (array_key_exists($topic['id'],$seen)) continue;
					$seen[$topic['id']]=1;

					$topic_url=$GLOBALS['FORUM_DRIVER']->topic_url($topic['id'],$forum_name,true);
					$topic_url_unread=mixed();
					if (get_forum_type()=='ocf')
					{
						$topic_url_unread=build_url(array('page'=>'topicview','id'=>$topic['id'],'type'=>'first_unread'),get_module_zone('topicview'),NULL,false,false,false,'first_unread');
					}
					$title=$topic['title'];
					$date=get_timezoned_date($topic[$date_key]);
					$username=$topic[$username_key];
					$member_id=array_key_exists($memberid_key,$topic)?$topic[$memberid_key]:NULL;
					if ((!is_null($forum_names_map)) && (!array_key_exists($topic['forum_id'],$forum_names_map))) continue; // Maybe Private Topic, slipped in via reference to a missing forum
					$forum_name=is_null($forum_names_map)?NULL:$forum_names_map[$topic['forum_id']];

					$out->attach(do_template('BLOCK_MAIN_FORUM_TOPICS_TOPIC',array(
						'_GUID'=>'ae4e351b3fa5422bf8ecdfb7e49076d1',
						'POST'=>$topic['firstpost'],
						'FORUM_ID'=>is_null($forum_names_map)?NULL:strval($topic['forum_id']),
						'FORUM_NAME'=>$forum_name,
						'TOPIC_URL'=>$topic_url,
						'TOPIC_URL_UNREAD'=>$topic_url_unread,
						'TITLE'=>$title,
						'DATE'=>$date,
						'DATE_RAW'=>strval($topic[$date_key]),
						'USERNAME'=>$username,
						'MEMBER_ID'=>is_null($member_id)?'':strval($member_id),
						'NUM_POSTS'=>integer_format($topic['num']),
					)));

					$done++;

					if ($done==$limit) break;
				}
			}
			if ($out->is_empty())
			{
				return do_template('BLOCK_NO_ENTRIES',array(
					'_GUID'=>'c76ab018a0746c2875c6cf69c92a01fb',
					'HIGH'=>false,
					'FORUM_NAME'=>array_key_exists('param',$map)?$map['param']:'General chat',
					'TITLE'=>$_title,
					'MESSAGE'=>do_lang_tempcode(($hot==1)?'NO_TOPICS_HOT':'NO_TOPICS'),
					'ADD_NAME'=>$add_name,
					'SUBMIT_URL'=>$submit_url,
				));
			}

			return do_template('BLOCK_MAIN_FORUM_TOPICS',array(
				'_GUID'=>'368b80c49a335ad035b00510681d5008',
				'TITLE'=>$_title,
				'CONTENT'=>$out,
				'FORUM_NAME'=>array_key_exists('param',$map)?$map['param']:'General chat',
				'SUBMIT_URL'=>$submit_url,
			));
		} else
		{
			return new ocp_tempcode();
		}
	}
}


