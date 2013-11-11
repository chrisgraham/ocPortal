<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		core
 */

// Find ocPortal base directory, and chdir into it
global $FILE_BASE,$RELATIVE_PATH;
$FILE_BASE=(strpos(__FILE__,'./')===false)?__FILE__:realpath(__FILE__);
$FILE_BASE=dirname($FILE_BASE);
if (!is_file($FILE_BASE.'/sources/global.php')) // Need to navigate up a level further perhaps?
{
	$RELATIVE_PATH=basename($FILE_BASE);
	$FILE_BASE=dirname($FILE_BASE);
} else
{
	$RELATIVE_PATH='';
}
@chdir($FILE_BASE);

global $FORCE_INVISIBLE_GUEST;
$FORCE_INVISIBLE_GUEST=false;
if (!is_file($FILE_BASE.'/sources/global.php')) exit('<!DOCTYPE html>'."\n".'<html lang="EN"><head><title>Critical startup error</title></head><body><h1>ocPortal startup error</h1><p>The second most basic ocPortal startup file, sources/global.php, could not be located. This is almost always due to an incomplete upload of the ocPortal system, so please check all files are uploaded correctly.</p><p>Once all ocPortal files are in place, ocPortal must actually be installed by running the installer. You must be seeing this message either because your system has become corrupt since installation, or because you have uploaded some but not all files from our manual installer package: the quick installer is easier, so you might consider using that instead.</p><p>ocProducts maintains full documentation for all procedures and tools, especially those for installation. These may be found on the <a href="http://ocportal.com">ocPortal website</a>. If you are unable to easily solve this problem, we may be contacted from our website and can help resolve it for you.</p><hr /><p style="font-size: 0.8em">ocPortal is a website engine created by ocProducts.</p></body></html>'); require($FILE_BASE.'/sources/global.php');

// Put code that you temporarily want executed into the function. DELETE THE CODE WHEN YOU'RE DONE.
// This is useful when performing quick and dirty upgrades (e.g. adding tables to avoid a reinstall)

require_code('database_action');
require_code('config2');
require_code('menus2');
$out=execute_temp();
if (!headers_sent())
{
	header('Content-Type: text/plain');
	@ini_set('ocproducts.xss_detect','0');
	if (!is_null($out)) echo is_object($out)?$out->evaluate():(is_bool($out)?($out?'true':'false'):$out);
	echo do_lang('SUCCESS');
}

/**
 * Execute some temporary code put into this function.
 *
 * @return  mixed		Arbitrary result to output, if no text has already gone out
 */
function execute_temp()
{
	require_code('sitemap');

	$pagelink='';
	$callback=NULL;
	$valid_node_types=NULL;
	$max_recurse_depth=20;
	$require_permission_support=false;
	$zone='_SEARCH';
	$consider_secondary_categories=true;
	$use_page_groupings=true;
	$consider_validation=false;
	$meta_gather=SITEMAP_GATHER__ALL;

	$node=retrieve_sitemap_node($pagelink,$callback,$valid_node_types,$max_recurse_depth,$require_permission_support,$zone,$use_page_groupings,$consider_secondary_categories,$consider_validation,$meta_gather);
	if (is_null($node)) @exit('NULL');
	var_dump(filter($node));
	exit();
}

function filter($node)
{
	if (isset($node['title']) && !array_key_exists('image',$node['extra_meta'])) {@var_dump($node);@exit('missing image meta data');}
	if (isset($node['title']) && !is_object($node['title'])) {@var_dump($node);@exit('Non-Tempcode title');}

	return array(
		'title'=>isset($node['title'])?$node['title']->evaluate():'',
		'image'=>isset($node['extra_meta']['image'])?$node['extra_meta']['image']:'',
		'pagelink'=>isset($node['pagelink'])?$node['pagelink']:NULL,
		'content_type'=>isset($node['content_type'])?$node['content_type']:NULL,
		'has_possible_children'=>isset($node['has_possible_children'])?$node['has_possible_children']:NULL,
		'children'=>isset($node['children'])?array_map('filter',$node['children']):NULL,
	);
}