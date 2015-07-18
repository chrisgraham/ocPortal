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
 * @package		ocf_forum
 */

class Hook_search_ocf_posts
{

	/**
	 * Standard modular info function.
	 *
	 * @return ?array	Map of module info (NULL: module is disabled).
	 */
	function info()
	{
		if (get_forum_type()!='ocf') return NULL;

		if (!has_actual_page_access(get_member(),'topicview')) return NULL;
		if ($GLOBALS['FORUM_DB']->query_value('f_posts','COUNT(*)')==0) return NULL;

		require_lang('ocf');

		$info=array();
		$info['lang']=do_lang_tempcode('SECTION_FORUMS');
		$info['default']=false;
		$info['special_on']=array();
		$info['special_off']=array('open'=>do_lang_tempcode('POST_SEARCH_OPEN'),'closed'=>do_lang_tempcode('POST_SEARCH_CLOSED'),'pinned'=>do_lang_tempcode('POST_SEARCH_PINNED'),'starter'=>do_lang_tempcode('POST_SEARCH_STARTER'));
		if (has_specific_permission(get_member(),'see_unvalidated')) $info['special_off']['unvalidated']=do_lang_tempcode('POST_SEARCH_UNVALIDATED');
		$info['category']='s.t_forum_id';
		$info['integer_category']=true;

		return $info;
	}

	/**
	 * Get details for an ajax-tree-list of entries for the content covered by this search hook.
	 *
	 * @return array			A pair: the hook, and the options
	 */
	function ajax_tree()
	{
		return array('choose_forum',array('compound_list'=>true));
	}

	/**
	 * Standard modular run function for search results.
	 *
	 * @param  string			Search string
	 * @param  boolean		Whether to only do a META (tags) search
	 * @param  ID_TEXT		Order direction
	 * @param  integer		Start position in total results
	 * @param  integer		Maximum results to return in total
	 * @param  boolean		Whether only to search titles (as opposed to both titles and content)
	 * @param  string			Where clause that selects the content according to the main search string (SQL query fragment) (blank: full-text search)
	 * @param  SHORT_TEXT	Username/Author to match for
	 * @param  ?MEMBER		Member-ID to match for (NULL: unknown)
	 * @param  TIME			Cutoff date
	 * @param  string			The sort type (gets remapped to a field in this function)
	 * @set    title add_date
	 * @param  integer		Limit to this number of results
	 * @param  string			What kind of boolean search to do
	 * @set    or and
	 * @param  string			Where constraints known by the main search code (SQL query fragment)
	 * @param  string			Comma-separated list of categories to search under
	 * @param  boolean		Whether it is a boolean search
	 * @return array			List of maps (template, orderer)
	 */
	function run($content,$only_search_meta,$direction,$max,$start,$only_titles,$content_where,$author,$author_id,$cutoff,$sort,$limit_to,$boolean_operator,$where_clause,$search_under,$boolean_search)
	{
		unset($limit_to);

		if (in_array($content,array(
			do_lang('POSTS_WITHIN_TOPIC'),
			do_lang('SEARCH_POSTS_WITHIN_TOPIC'),
			do_lang('SEARCH_FORUM_POSTS'),
			do_lang('_SEARCH_PRIVATE_TOPICS'),
		))) return array(); // Search placeholder label, not real search

		if (get_forum_type()!='ocf') return array();
		require_code('ocf_forums');
		require_code('ocf_posts');
		require_css('ocf');

		$remapped_orderer='';
		switch ($sort)
		{
			case 'title':
				$remapped_orderer='p_title';
				break;

			case 'add_date':
				$remapped_orderer='p_time';
				break;
		}

		require_lang('ocf');

		// Calculate our where clause (search)
		$sq=build_search_submitter_clauses('p_poster',$author_id,$author);
		if (is_null($sq)) return array(); else $where_clause.=$sq;
		if (!is_null($cutoff))
		{
			$where_clause.=' AND ';
			$where_clause.='p_time>'.strval($cutoff);
		}
		if (get_param_integer('option_ocf_posts_unvalidated',0)==1)
		{
			$where_clause.=' AND ';
			$where_clause.='r.p_validated=0';
		}
		if (get_param_integer('option_ocf_posts_open',0)==1)
		{
			$where_clause.=' AND ';
			$where_clause.='s.t_is_open=1';
		}
		if (get_param_integer('option_ocf_posts_closed',0)==1)
		{
			$where_clause.=' AND ';
			$where_clause.='s.t_is_open=0';
		}
		if (get_param_integer('option_ocf_posts_pinned',0)==1)
		{
			$where_clause.=' AND ';
			$where_clause.='s.t_pinned=1';
		}
		if (get_param_integer('option_ocf_posts_starter',0)==1)
		{
			$where_clause.=' AND ';
			$where_clause.='s.t_cache_first_post_id=r.id';
		}
		$where_clause.=' AND ';
		$where_clause.='t_forum_id IS NOT NULL AND (p_intended_solely_for IS NULL';
		if (!is_guest())
			$where_clause.=' OR (p_intended_solely_for='.strval((integer)get_member()).' OR p_poster='.strval((integer)get_member()).')';
		$where_clause.=')';

		if (!has_specific_permission(get_member(),'see_unvalidated'))
		{
			$where_clause.=' AND ';
			$where_clause.='p_validated=1';
		}

		// Calculate and perform query
		$translate_join_type=(get_value('alternate_search_join_type')==='1')?'LEFT JOIN':'JOIN';
		$rows=get_search_rows(NULL,NULL,$content,$boolean_search,$boolean_operator,$only_search_meta,$direction,$max,$start,$only_titles,'f_posts r '.$translate_join_type.' '.$GLOBALS['FORUM_DB']->get_table_prefix().'f_topics s ON r.p_topic_id=s.id',array('!','r.p_post'),$where_clause,$content_where,$remapped_orderer,'r.*,t_forum_id,t_cache_first_title',array('r.p_title','s.t_description'),'forums','t_forum_id');

		$out=array();
		foreach ($rows as $i=>$row)
		{
			$out[$i]['data']=$row;
			unset($rows[$i]);
			if (($remapped_orderer!='') && (array_key_exists($remapped_orderer,$row))) $out[$i]['orderer']=$row[$remapped_orderer]; elseif (substr($remapped_orderer,0,7)=='_rating') $out[$i]['orderer']=$row['compound_rating'];
		}

		return $out;
	}

	/**
	 * Standard modular run function for rendering a search result.
	 *
	 * @param  array		The data row stored when we retrieved the result
	 * @return tempcode	The output
	 */
	function render($row)
	{
		require_code('ocf_posts2');
		$tpl=render_post_box($row,false);
		$poster=$GLOBALS['FORUM_DRIVER']->member_profile_hyperlink($row['p_poster']);
		$date=get_timezoned_date($row['p_time']);
		if ($row['t_cache_first_title']=='')
		{
			$row['t_cache_first_title']=$GLOBALS['FORUM_DB']->query_value('f_posts','p_title',array('p_topic_id'=>$row['p_topic_id']),'ORDER BY p_time ASC');
		}
		$url=hyperlink($GLOBALS['FORUM_DRIVER']->topic_url($row['p_topic_id'],'',true),$row['t_cache_first_title']);
		$title=do_lang_tempcode('FORUM_POST_SEARCH_RESULT',escape_html(strval($row['id'])),$poster,array(escape_html($date),$url));

		return do_template('SIMPLE_PREVIEW_BOX',array('_GUID'=>'84ac17a5855ceed1c47c5d3ef6cf4f3d','TITLE'=>$title,'SUMMARY'=>$tpl));
	}

}


