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
 * @package		forum_blocks
 */

class Block_side_forum_news
{

	/**
	 * Standard modular info function.
	 *
	 * @return ?array	Map of module info (NULL: module is disabled).
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
		$info['parameters']=array('param','forum','date_key','title');
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
		$info['cache_on']='array(array_key_exists(\'title\',$map)?$map[\'title\']:\'\',array_key_exists(\'param\',$map)?$map[\'param\']:6,array_key_exists(\'forum\',$map)?$map[\'forum\']:\'Announcements\',array_key_exists(\'date_key\',$map)?$map[\'date_key\']:\'lasttime\')';
		$info['ttl']=15;
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
		if (has_no_forum()) return new ocp_tempcode();

		require_css('news');
		require_lang('news');

		$limit=array_key_exists('param',$map)?intval($map['param']):6;
		$forum_name=array_key_exists('forum',$map)?$map['forum']:do_lang('NEWS');

		$date_key=array_key_exists('date_key',$map)?$map['date_key']:'lasttime';

		$archive_url=NULL;
		$submit_url=new ocp_tempcode();

		$forum_ids=array();
		if ((get_forum_type()=='ocf') && ((strpos($forum_name,',')!==false) || (preg_match('#\d[-\*\+]#',$forum_name)!=0) || (is_numeric($forum_name))))
		{
			require_code('ocfiltering');
			$forum_names=ocfilter_to_idlist_using_db($forum_name,'id','f_forums','f_forums','f_parent_forum','f_parent_forum','id',true,true,$GLOBALS['FORUM_DB']);
		} else
		{
			$forum_names=explode(',',$forum_name);
		}
		foreach ($forum_names as $forum_name)
		{
			$forum_name=trim($forum_name);

			if ($forum_name=='<announce>')
			{
				$forum_id=NULL;
			} else
			{
				$forum_id=is_numeric($forum_name)?intval($forum_name):$GLOBALS['FORUM_DRIVER']->forum_id_from_name($forum_name);
			}

			if (!is_null($forum_id))
			{
				$forum_ids[$forum_id]=$forum_name;
			}

			if (!is_null($forum_id))
			{
				$forum_ids[$forum_id]=$forum_name;
				if (is_null($archive_url))
				{
					$archive_url=$GLOBALS['FORUM_DRIVER']->forum_url($forum_id); // First forum will count as archive
					if (get_forum_type()=='ocf')
					{
						$submit_url=build_url(array('page'=>'topics','type'=>'new_topic','id'=>$forum_id),get_module_zone('topics'));
					}
				}
			}
		}

		$_title=do_lang_tempcode('NEWS');
		if ((array_key_exists('title',$map)) && ($map['title']!='')) $_title=make_string_tempcode(escape_html($map['title']));

		if (get_forum_type()!='none')
		{
			$max_rows=0;
			$topics=$GLOBALS['FORUM_DRIVER']->show_forum_topics($forum_ids,$limit,0,$max_rows,'',false,$date_key);

			$out=new ocp_tempcode();
			if (!is_null($topics))
			{
				global $M_SORT_KEY;
				$M_SORT_KEY=$date_key;
				usort($topics,'multi_sort');
				$topics=array_reverse($topics,false);

				foreach ($topics as $topic)
				{
					$topic_url=$GLOBALS['FORUM_DRIVER']->topic_url($topic['id'],$forum_name);
					$title=$topic['title'];
					$date=get_timezoned_date($topic[$date_key],false);
	//				$username=$topic['lastusername'];

					$out->attach(do_template('BLOCK_SIDE_FORUM_NEWS_SUMMARY',array('_GUID'=>'4b7f4ce27cf683710fc9958e9606291c','REPLIES'=>strval($topic['num']),'FIRSTTIME'=>strval($topic['firsttime']),'LASTTIME'=>strval($topic['lasttime']),'CLOSED'=>strval($topic['closed']),'FIRSTUSERNAME'=>$topic['firstusername'],'LASTUSERNAME'=>$topic['lastusername'],'FIRSTMEMBERID'=>strval($topic['firstmemberid']),'LASTMEMBERID'=>strval($topic['lastmemberid']),'_DATE'=>strval($topic[$date_key]),'DATE'=>$date,'FULL_URL'=>$topic_url,'NEWS_TITLE'=>escape_html($title))));
				}
			}

			return do_template('BLOCK_SIDE_FORUM_NEWS',array('_GUID'=>'174fa5ce0d35d9b49dca6347c66494a5','FORUM_NAME'=>array_key_exists('forum',$map)?$map['forum']:do_lang('NEWS'),'TITLE'=>$_title,'CONTENT'=>$out,'SUBMIT_URL'=>$submit_url,'ARCHIVE_URL'=>is_null($archive_url)?'':$archive_url));
		} else
		{
			return new ocp_tempcode();
		}
	}

}


