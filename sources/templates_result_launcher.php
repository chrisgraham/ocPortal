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
 * @package		core_abstract_interfaces
 */

/**
 * Get the tempcode for a results launcher.
 *
 * @param  tempcode		The title/name of the resource we are browsing through
 * @param  ID_TEXT		The page name we are launching into
 * @param  AUTO_LINK		The category ID we are browsing in
 * @param  integer		The maximum number of rows to show per browser page
 * @param  integer		The maximum number of rows in the entire dataset
 * @param  ID_TEXT		The page type this browser is browsing through (e.g. 'category')
 * @param  integer		The maximum number of quick-jump page links to show
 * @return tempcode		The results launcher
 */
function results_launcher($title,$page,$category_id,$max,$max_rows,$type,$max_page_links=5)
{
	if ($max<1) $max=1;

	require_javascript('javascript_pagination');

	$out=new ocp_tempcode();

	if ($max<$max_rows) // If they don't all fit on one page
	{
		$part=new ocp_tempcode();
		$num_pages=($max==0)?0:min(intval(ceil(floatval($max_rows)/floatval($max))),$max_page_links);
		for ($x=0;$x<$num_pages;$x++)
		{
			$cat_url=build_url(array('page'=>$page,'type'=>$type,'start'=>($x==0)?NULL:($x*$max),'id'=>$category_id),get_module_zone($page));
			$part->attach(do_template('RESULTS_LAUNCHER_PAGE_NUMBER_LINK',array('_GUID'=>'d19c001f3ecff62105f803d541f7d945','TITLE'=>$title,'URL'=>$cat_url,'P'=>strval($x+1))));
		}

		$num_pages=intval(ceil(floatval($max_rows)/floatval($max)));
		if ($num_pages>$max_page_links)
		{
			$url_stub=build_url(array('page'=>$page,'type'=>$type,'id'=>$category_id),'_SELF');
			$part->attach(do_template('RESULTS_LAUNCHER_CONTINUE',array('_GUID'=>'0a55d3c1274618c16bd6d8d2cf36676c','TITLE'=>$title,'MAX'=>strval($max),'NUM_PAGES'=>integer_format($num_pages),'URL_STUB'=>$url_stub)));
		}

		$out->attach(do_template('RESULTS_LAUNCHER_WRAP',array('_GUID'=>'c1c01ee07c456832e7e66a03f26c2288','PART'=>$part)));
	}

	return $out;
}

