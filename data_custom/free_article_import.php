<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		free_article_import
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

global $NON_PAGE_SCRIPT;
$NON_PAGE_SCRIPT=1;
global $FORCE_INVISIBLE_GUEST;
$FORCE_INVISIBLE_GUEST=0;
if (!is_file($FILE_BASE.'/sources/global.php')) exit('<!DOCTYPE html>'.chr(10).'<html lang="EN"><head><title>Critical startup error</title></head><body><h1>ocPortal startup error</h1><p>The second most basic ocPortal startup file, sources/global.php, could not be located. This is almost always due to an incomplete upload of the ocPortal system, so please check all files are uploaded correctly.</p><p>Once all ocPortal files are in place, ocPortal must actually be installed by running the installer. You must be seeing this message either because your system has become corrupt since installation, or because you have uploaded some but not all files from our manual installer package: the quick installer is easier, so you might consider using that instead.</p><p>ocProducts maintains full documentation for all procedures and tools, especially those for installation. These may be found on the <a href="http://ocportal.com">ocPortal website</a>. If you are unable to easily solve this problem, we may be contacted from our website and can help resolve it for you.</p><hr /><p style="font-size: 0.8em">ocPortal is a website engine created by ocProducts.</p></body></html>'); require($FILE_BASE.'/sources/global.php');

if (function_exists('set_time_limit')) @set_time_limit(0);

require_code('news');

if (!$GLOBALS['FORUM_DRIVER']->is_super_admin(get_member())) access_denied();

// Create default news categories
$categories_path=get_custom_file_base().'/data_custom/free_article_import__categories.txt';
$categories_default=is_file($categories_path)?explode("\n",file_get_contents($categories_path)):array();
$categories_existing=collapse_2d_complexity('id','text_original',$GLOBALS['SITE_DB']->query_select('news_categories n JOIN '.get_table_prefix().'translate t ON t.id=n.nc_title',array('n.id','text_original')));
foreach ($categories_default as $category)
{
	$category=trim($category);
	if ($category=='') continue;

	if (!in_array($category,$categories_existing))
	{
		$id=add_news_category($category,'','');
		$categories_existing[$id]=$category;

		$groups=$GLOBALS['FORUM_DRIVER']->get_usergroup_list(false,true);
		foreach (array_keys($groups) as $group_id)
			$GLOBALS['SITE_DB']->query_insert('group_category_access',array('module_the_name'=>'news','category_name'=>strval($id),'group_id'=>$group_id));
	}
}

// Import news
$done=0;
$csvfile=fopen(get_custom_file_base().'/data_custom/free_article_import__articles.csv','rt');
fgetcsv($csvfile,1024000); // Skip header row
while (($r=fgetcsv($csvfile,1024000))!==false)
{
	$url=$r[1];

	if ($r[5]=='')
	{
		$parsed_url=parse_url($url);
		switch ($parsed_url['host'])
		{
			case 'ezinearticles.com':
				$r=parse_ezinearticles($r);
				break;
			case 'www.articlesbase.com':
				$r=parse_articlesbase($r);
				break;
			case 'www.articletrader.com':
				$r=parse_articletrader($r);
				break;
			default:
				warn_exit('No screen-scraping code written for articles on '.$parsed_url['host']);
		}
	}

	if ((empty($r[0])) || (empty($r[2])) || (empty($r[3])) || (empty($r[5])))
		warn_exit('Failed to get full data for '.$url);

	$main_news_category=array_search($r[0],$categories_existing);
	if ($main_news_category===false)
	{
		$id=add_news_category($r[0],'','');
		$categories_existing[$id]=$r[0];
		$main_news_category=$id;

		$groups=$GLOBALS['FORUM_DRIVER']->get_usergroup_list(false,true);
		foreach (array_keys($groups) as $group_id)
			$GLOBALS['SITE_DB']->query_insert('group_category_access',array('module_the_name'=>'news','category_name'=>strval($id),'group_id'=>$group_id));
	}
	$author=$r[2];
	$title=$r[3];
	$time=($r[4]=='')?time():strtotime($r[4]);
	$r[5]=trim($r[5]);
	$r[5]=preg_replace('#.*<body[^<>]*>\s*#si','',$r[5]);
	$r[5]=preg_replace('#\s*<h1[^<>]*>[^<>]*</h1>\s*#si','',$r[5]);
	$r[5]=preg_replace('#\s*</body>\s*</html>#si','',$r[5]);
	$news_article='[html]'.$r[5].'[/html]';
	$news=empty($r[6])?'':$r[6]; // Summary

	$test=$GLOBALS['SITE_DB']->query_select_value_if_there('news n JOIN '.get_table_prefix().'translate t ON t.id=n.title','n.id',array('text_original'=>$title,'date_and_time'=>$time));
	if (is_null($test)) // If does not exist yet
	{
		$id=add_news($title,$news,$author,1,1,1,1,'',$news_article,$main_news_category,NULL,$time);
		seo_meta_set_for_explicit('news',strval($id),$r[7],$news);

		$done++;
	}
}
fclose($csvfile);

@header('Content-type: text/plain');
echo 'Imported '.integer_format($done).' news articles.';

function parse_ezinearticles($r)
{
	// NB: You'll get security errors on this occasionally. You need to open up the URL manually, solve the CAPTCHA, then refresh.
	// The inbuilt cache will ensure the script can get to the end of the process.

	$f=http_download_file_cached($r[1]);

	$matches=array();
	preg_match('#&id=(\d+)#s',$r[1],$matches);
	$id=$matches[1];

	$matches=array();
	preg_match('#Submitted On (.*)\.#Us',$f,$matches);
	$date=html_entity_decode($matches[1],ENT_QUOTES,get_charset());

	$matches=array();
	preg_match('#<a href="[^"]*" rel="author" class="author-name" title="[^"]*">\s*(.*)\s*</a>#Us',$f,$matches);
	$author=html_entity_decode($matches[1],ENT_QUOTES,get_charset());

	$matches=array();
	preg_match('#<h1>(.*)</h1>#Us',$f,$matches);
	$title=html_entity_decode($matches[1],ENT_QUOTES,get_charset());

	$f=http_download_file_cached('http://ezinearticles.com/ezinepublisher/?id='.$id,$r[1]);

	$matches=array();
	preg_match('#<textarea id="formatted-article" wrap="physical" style="width:98%;height:200px;" readonly>(.*)</textarea>#Us',$f,$matches);
	$body=$matches[1];
	$body=preg_replace('#.*<body[^<>]*>\s*#si','',$body);
	$body=preg_replace('#\s*<h1[^<>]*>[^<>]*</h1>\s*#si','',$body);
	$body=preg_replace('#\s*</body>\s*</html>#si','',$body);
	$body=preg_replace('#^\s*<p>.*<br>\s*By .*</p>#U','',$body);

	$matches=array();
	preg_match('#<textarea rows="5" id="article-summary" cols="50" wrap="physical" readonly>(.*)</textarea>#Us',$f,$matches);
	$summary=html_entity_decode($matches[1],ENT_QUOTES,get_charset());

	$matches=array();
	preg_match('#<input type="text" id="article-keywords" size="75" value="([^"]*)" readonly>#Us',$f,$matches);
	$keywords=html_entity_decode($matches[1],ENT_QUOTES,get_charset());

	return array(
		$r[0], // Category
		$r[1], // URL
		$author,
		$title,
		$date,
		$body,
		$summary,
		$keywords,
	);
}

function parse_articlesbase($r)
{
	$cookies=array_map('urldecode',array(
		'SPSI'=>'8209dce6e2947e79c6bf67fb7022ad39',
	));

	$f=http_download_file_cached($r[1],$r[1],$cookies);

	$matches=array();
	preg_match('#-(\d+)\.html$#Us',$r[1],$matches);
	$id=$matches[1];

	$matches=array();
	preg_match('#<span class="date">(.*)</span>#Us',$f,$matches);
	$date=html_entity_decode($matches[1],ENT_QUOTES,get_charset());

	$matches=array();
	if ((preg_match('#rel="author" itemprop="author">.*</a>\s*</strong>\s*<p>(.*) is #Us',$f,$matches)!=0) && (strlen($matches[1])<20))
	{
		$author=html_entity_decode($matches[1],ENT_QUOTES,get_charset());
	} else
	{
		preg_match('#rel="author" itemprop="author">(.*)</a>#Us',$f,$matches);
		$author=html_entity_decode($matches[1],ENT_QUOTES,get_charset());
	}

	$matches=array();
	preg_match('#<h1 class="atitle" itemprop="name">(.*)</h1>#Us',$f,$matches);
	$title=html_entity_decode($matches[1],ENT_QUOTES,get_charset());

	$f=http_download_file_cached('http://www.articlesbase.com/ezine/'.$id,$r[1],$cookies);

	$matches=array();
	preg_match('#<textarea id="ezine_html" onclick="\$\(this\).select\(\)">(.*)</textarea>#Us',$f,$matches);
	$body=$matches[1];
	$body=preg_replace('#\s*<h1[^<>]*>[^<>]*</h1>\s*#si','',$body);
	$body=preg_replace('#^\s*<strong>Author: .*</strong><br />#U','',$body);

	$matches=array();
	preg_match('#<textarea class="summary" id="ezine_summary">(.*)</textarea>#Us',$f,$matches);
	$summary=html_entity_decode($matches[1],ENT_QUOTES,get_charset());

	$matches=array();
	preg_match('#<input type="text" value="([^"]*)" />#Us',$f,$matches);
	$keywords=html_entity_decode($matches[1],ENT_QUOTES,get_charset());

	return array(
		$r[0], // Category
		$r[1], // URL
		$author,
		$title,
		$date,
		$body,
		$summary,
		$keywords,
	);
}

function parse_articletrader($r)
{
	$f=http_download_file_cached($r[1]);

	$matches=array();
	preg_match('#<a rel="nofollow" href=\'([^\']*)\'>Get Html Code</a>#Us',$f,$matches);
	$synd_url=$matches[1];

	$matches=array();
	preg_match("#<div style='font-size:80%;margin-top:0px'>Submitted by <a href='[^']*'>(.*)</a><br>\s*(.*)</div>#Us",$f,$matches);
	$author=html_entity_decode($matches[1],ENT_QUOTES,get_charset());
	$date=html_entity_decode($matches[2],ENT_QUOTES,get_charset());

	$matches=array();
	preg_match('#<h1 style="margin-bottom:3px">(.*)</h1>#Us',$f,$matches);
	$title=html_entity_decode($matches[1],ENT_QUOTES,get_charset());

	$f=http_download_file_cached('http://www.articletrader.com'.$synd_url,$r[1]);

	$matches=array();
	preg_match('#<textarea style="width:99%" rows=30>(.*)</textarea>#Us',$f,$matches);
	$body=html_entity_decode($matches[1],ENT_QUOTES,get_charset());
	$body=str_replace("\n",'<br />',$body);

	$summary='';

	$keywords='';

	return array(
		$r[0], // Category
		$r[1], // URL
		$author,
		$title,
		$date,
		$body,
		$summary,
		$keywords,
	);
}

function http_download_file_cached($url,$referer='',$cookies=NULL)
{
	require_code('files');
	@mkdir(get_custom_file_base().'/data_custom/free_article_import_cache');
	$cache_file=get_custom_file_base().'/data_custom/free_article_import_cache/'.md5($url).'.htm';
	if (is_file($cache_file))
	{
		$data=file_get_contents($cache_file);
	} else
	{
		sleep(3);

		$data=http_download_file($url,NULL,true,false,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36',NULL,$cookies,'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',NULL,'en-US,en;q=0.8',NULL,$referer);
		file_put_contents($cache_file,$data);
	}
	return $data;
}
