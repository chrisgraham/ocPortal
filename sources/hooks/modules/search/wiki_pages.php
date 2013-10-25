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
 * @package		wiki
 */

class Hook_search_wiki_pages
{

	/**
	 * Standard modular info function.
	 *
	 * @return ?array	Map of module info (NULL: module is disabled).
	 */
	function info()
	{
		if (!has_actual_page_access(get_member(),'wiki')) return NULL;
		if ($GLOBALS['SITE_DB']->query_select_value('wiki_pages','COUNT(*)')<=1) return NULL;

		require_lang('wiki');

		$info=array();
		$info['lang']=do_lang_tempcode('WIKI_PAGES');
		$info['default']=true;

		return $info;
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
		$remapped_orderer='';
		switch ($sort)
		{
			case 'title':
				$remapped_orderer='title';
				break;

			case 'add_date':
				$remapped_orderer='add_date';
				break;
		}

		require_code('wiki');
		require_lang('wiki');

		// Calculate our where clause (search)
		if ($author!='')
		{
			return array();
		}
		if (!is_null($cutoff))
		{
			$where_clause.=' AND ';
			$where_clause.='add_date>'.strval($cutoff);
		}

		// Calculate and perform query
		$rows=get_search_rows('wiki_page','id',$content,$boolean_search,$boolean_operator,$only_search_meta,$direction,$max,$start,$only_titles,'wiki_pages r',array('r.title','r.description'),$where_clause,$content_where,$remapped_orderer,'r.*',NULL,'wiki_page','id');

		$out=array();
		foreach ($rows as $i=>$row)
		{
			$out[$i]['data']=$row;
			unset($rows[$i]);
			if (($remapped_orderer!='') && (array_key_exists($remapped_orderer,$row))) $out[$i]['orderer']=$row[$remapped_orderer]; elseif (strpos($remapped_orderer,'_rating:')!==false) $out[$i]['orderer']=$row[$remapped_orderer];
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
		return render_wiki_page_box($row);
	}

}


