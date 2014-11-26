<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		ocportalcom
 */

function init__errorservice()
{
	define('OCP_SOLUTION_FORUM',283);
}

/**
 * Handler for ocPortal.com error message web service.
 */
function get_problem_match()
{
	$version=get_param('version');
	$error_message=get_param('error_message',false,true);

	$ret=get_problem_match_worker($error_message);
	header('Content-type: text/plain; charset='.get_charset());
	if (!is_null($ret))
	{
		$output=$ret[2]->evaluate();

		// Possible rebranding
		$brand=get_param('product');
		if (($brand!='ocPortal') && ($brand!=''))
		{
			$brand_base_url=get_param('product_site','');
			if ($brand_base_url!='')
			{
				$output=str_replace('ocPortal',$brand,$output);
				$output=str_replace('ocProducts','The Developers',$output);
				$output=str_replace('http://ocportal.com',$brand_base_url,$output);
			}
		}
		echo $output;
	}
}

/**
 * Find a match for a problem in the database.
 *
 * @param  string		The error that occurred
 * @return ?array		A tuple: the post ID, the full Comcode text, the Tempcode, the language string ID  (probably caller will only use post ID and Tempcode - but all available)
 */
function get_problem_match_worker($error_message)
{
	// Find matches. Stored in forum topics.
	$_data=$GLOBALS['FORUM_DB']->query_select('f_posts p LEFT JOIN '.$GLOBALS['FORUM_DB']->get_table_prefix().'translate t ON t.id=p.p_post',array('text_original','text_parsed','p.id','p_title','t.id AS l_id'),array('p_cache_forum_id'=>OCP_SOLUTION_FORUM));
	$matches=array();
	foreach ($_data as $d)
	{
		$regexp=str_replace('\.\.\.','.*',str_replace('xxx','.*',str_replace('#','\#',preg_quote($d['p_title']))));
		if (preg_match('#'.$regexp.'#',$error_message)!=0)
			$matches[$d['p_title']]=array($d['id'],$d['text_original'],$d['text_parsed'],$d['l_id']);
	}

	// Sort by how good the match is (string length)
	uksort($matches,'strlen_sort');

	// Return best-match result, after a cleanup
	$ret=array_pop($matches);
	if (!is_null($ret))
	{
		if ($ret[2]!='')
		{
			$tempcode=new ocp_tempcode();
			$tempcode->from_assembly($ret[2]);
			$ret[2]=$tempcode;
		} else $ret[2]=get_translated_tempcode($ret[3]);
	}
	return $ret;
}

