<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		activity_feed
 */

class Hook_rss_activities
{

	/**
	 * Standard modular run function for RSS hooks.
	 *
	 * @param  string			A list of categories we accept from
	 * @param  TIME			Cutoff time, before which we do not show results from
	 * @param  string			Prefix that represents the template set we use
	 * @set    RSS_ ATOM_
	 * @param  string			The standard format of date to use for the syndication type represented in the prefix
	 * @param  integer		The maximum number of entries to return, ordering by date
	 * @return ?array			A pair: The main syndication section, and a title (NULL: error)
	 */
	function run($_filters,$cutoff,$prefix,$date_string,$max)
	{
		require_lang('activities');
		require_code('activities');

		list(,$where_clause)=get_activity_querying_sql(get_member(),($_filters=='*')?'all':'some_members',($_filters=='*')?NULL:array_map('intval',explode(',',$_filters)));

		$rows=$GLOBALS['SITE_DB']->query('SELECT * FROM '.get_table_prefix().'activities WHERE ('.$where_clause.') AND a_time>'.strval($cutoff).' ORDER BY a_time DESC',$max,0);

		$content=new ocp_tempcode();
		foreach ($rows as $row)
		{
			$id=strval($row['id']);
			$author=$GLOBALS['FORUM_DRIVER']->get_username($row['a_member_id']);
			if (is_null($author)) $author=do_lang('UNKNOWN');

			$news_date=date($date_string,$row['a_time']);
			$edit_date='';

			list($_title,)=render_activity($row);
			$news_title=xmlentities($_title->evaluate());
			$summary=xmlentities('');
			$news='';

			$category='';
			$category_raw='';

			$view_url=build_url(array('page'=>'members','type'=>'view','id'=>$row['a_member_id']),get_module_zone('members'),NULL,false,false,true);

			$if_comments=new ocp_tempcode();

			$content->attach(do_template($prefix.'ENTRY',array('VIEW_URL'=>$view_url,'SUMMARY'=>$summary,'EDIT_DATE'=>$edit_date,'IF_COMMENTS'=>$if_comments,'TITLE'=>$news_title,'CATEGORY_RAW'=>$category_raw,'CATEGORY'=>$category,'AUTHOR'=>$author,'ID'=>$id,'NEWS'=>$news,'DATE'=>$news_date)));
		}

		return array($content,do_lang('ACTIVITIES_TITLE'));
	}

}


