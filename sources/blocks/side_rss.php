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
 * @package		syndication_blocks
 */

class Block_side_rss
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
		$info['parameters']=array('param','max_entries','title','copyright','ticker');
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
		$info['cache_on']=array('block_side_rss__cache_on');
		$info['ttl']=intval(get_option('rss_update_time'));
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
		require_lang('news');
		require_css('news');
		require_code('obfuscate');

		$url=array_key_exists('param',$map)?$map['param']:'http://ocportal.com/backend.php?type=rss&mode=news';

		if (strpos($url,'{')!==false)
		{
			require_code('tempcode_compiler');
			$url=static_evaluate_tempcode(template_to_tempcode($url));
		}

		$ticker=(array_key_exists('ticker',$map)) && ($map['ticker']=='1');

		require_code('rss');
		$rss=new rss($url);
		if (!is_null($rss->error))
		{
			$GLOBALS['DO_NOT_CACHE_THIS']=true;
			require_code('failure');
			relay_error_notification(do_lang('ERROR_HANDLING_RSS_FEED',$url,$rss->error),false,'error_occurred_rss');
			if (cron_installed())
			{
				if (!$GLOBALS['FORUM_DRIVER']->is_staff(get_member())) return new ocp_tempcode();
			}
			return do_template('INLINE_WIP_MESSAGE',array('MESSAGE'=>htmlentities($rss->error)));
		}

		// Sorting
		$items=array();
		foreach ($rss->gleamed_items as $item)
		{
			if (!array_key_exists('clean_add_date',$item)) $item['clean_add_date']=time();
			$items[]=$item;
		}
		global $M_SORT_KEY;
		$M_SORT_KEY='clean_add_date';
		usort($items,'multi_sort');
		$items=array_reverse($items);

		global $NEWS_CATS;
		$NEWS_CATS=$GLOBALS['SITE_DB']->query_select('news_categories',array('*'),array('nc_owner'=>NULL));
		$NEWS_CATS=list_to_map('id',$NEWS_CATS);

		if (!array_key_exists('title',$rss->gleamed_feed)) $rss->gleamed_feed['title']=do_lang_tempcode('RSS_STREAM');
		if (array_key_exists('title',$map)) $rss->gleamed_feed['title']=$map['title'];

		// Reduce what we collected about the feed to a minimum. This is very awkward, as we don't know what's here.
		if (array_key_exists('author',$rss->gleamed_feed))
		{
			$__author=NULL;
			$_author_string=$rss->gleamed_feed['author'];
			if (array_key_exists('url',$rss->gleamed_feed)) $__author=hyperlink($rss->gleamed_feed['url'],escape_html($_author_string),true);
			elseif (array_key_exists('author_url',$rss->gleamed_feed)) $__author=hyperlink($rss->gleamed_feed['author_url'],escape_html($_author_string),true);
			elseif (array_key_exists('author_email',$rss->gleamed_feed)) $__author=hyperlink(mailto_obfuscated().obfuscate_email_address($rss->gleamed_feed['author_email']),escape_html($_author_string),true);
			if (!is_null($__author)) $_author_string=$__author->evaluate();
			$_author=do_lang_tempcode('RSS_SOURCE_FROM',$_author_string);
		} else $_author=new ocp_tempcode();
		if (!array_key_exists('copyright',$rss->gleamed_feed)) $rss->gleamed_feed['copyright']='';
		if (array_key_exists('copyright',$map)) $rss->gleamed_feed['copyright']=$map['copyright'];

		// Now for the actual stream contents
		$max=array_key_exists('max_entries',$map)?intval($map['max_entries']):5;
		$content=new ocp_tempcode();
		foreach ($items as $i=>$item)
		{
			if ($i>=$max) break;

			if (array_key_exists('full_url',$item)) $full_url=$item['full_url'];
			elseif (array_key_exists('guid',$item)) $full_url=$item['guid'];
			elseif (array_key_exists('comment_url',$item)) $full_url=$item['comment_url'];
			else $full_url='';

			$_title=$item['title'];
			$_title=array_key_exists('title',$item)?$item['title']:'';
			$date=array_key_exists('clean_add_date',$item)?get_timezoned_date($item['clean_add_date'],false):(array_key_exists('add_date',$item)?$item['add_date']:'');

			$content->attach(do_template('BLOCK_SIDE_RSS_SUMMARY',array('_GUID'=>'18f6d1ccfe980cc01bbdd2ee178c2410','TICKER'=>$ticker,'FEED_URL'=>$url,'FULL_URL'=>$full_url,'NEWS_TITLE'=>$_title,'DATE'=>$date,'DATE_RAW'=>array_key_exists('clean_add_date',$item)?strval($item['clean_add_date']):'','SUMMARY'=>array_key_exists('news',$item)?$item['news']:(array_key_exists('news_article',$item)?$item['news_article']:''))));
		}

		return do_template('BLOCK_SIDE_RSS',array('_GUID'=>'fe3319e942d75fedb83e4cf80f80e19f','TICKER'=>$ticker,'FEED_URL'=>$url,'TITLE'=>$rss->gleamed_feed['title'],'CONTENT'=>$content));
	}

}

/**
 * Find the cache signature for the block.
 *
 * @param  array	The block parameters.
 * @return array	The cache signature.
 */
function block_side_rss__cache_on($map)
{
	return array(cron_installed()?NULL:$GLOBALS['FORUM_DRIVER']->is_staff(get_member()),array_key_exists('max_entries',$map)?intval($map['max_entries']):10,array_key_exists('title',$map)?$map['title']:'',array_key_exists('copyright',$map)?$map['copyright']:'',array_key_exists('param',$map)?$map['param']:'');
}


