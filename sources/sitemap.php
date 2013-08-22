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
 * @package		core
 */

/*
Implementation notes...
 - We do not put edit/posting forms in our sitemap; that is, forms that begin an action on a specific resource
 - Nodes may not be (in fact, usually are not) written in a streamed tree order
 - Node children may be written if they do not have access permission (albeit flagged as such) but ONLY if there is a possibility they may have accessible children
*/

/**
 * Standard code module initialisation function.
 */
function init__sitemap()
{
	global $SITEMAPS_OUT_FILE,$SITEMAPS_OUT_PATH,$SITEMAPS_OUT_TEMPPATH;
	$SITEMAPS_OUT_FILE=NULL;
	$SITEMAPS_OUT_PATH=NULL;
	$SITEMAPS_OUT_TEMPPATH=NULL;

	define('DEPTH__PAGES',1);
	define('DEPTH__ENTRY_POINTS',2);
	define('DEPTH__CATEGORIES',3);
	define('DEPTH__ENTRIES',3);
}

/**
 * Top level function to (re)generate a Sitemap (xml file, Google-style).
 */
function sitemaps_build()
{
	$GLOBALS['NO_QUERY_LIMIT']=true;

	if (!is_guest())
	{
		warn_exit('Will not generate sitemap as non-Guest');
	}

	$path=get_custom_file_base().'/ocp_sitemap.xml';
	if (!file_exists($path))
	{
		if (!is_writable_wrap(dirname($path))) warn_exit(do_lang_tempcode('WRITE_ERROR_CREATE',escape_html('/')));
	} else
	{
		if (!is_writable_wrap($path)) warn_exit(do_lang_tempcode('WRITE_ERROR',escape_html('ocp_sitemap.xml')));
	}

	// Runs via a callback mechanism, so we don't need to load an arbitrary complex structure into memory.
	sitemaps_xml_initialise($path);
	spawn_page_crawl('pagelink_to_sitemapsxml',$GLOBALS['FORUM_DRIVER']->get_guest_id(),NULL,DEPTH__ENTRIES);
	sitemaps_xml_finished();

	// Ping search engines
	if (get_option('auto_submit_sitemap')=='1')
	{
		$ping=true;
		$base_url=get_base_url();
		$not_local=(substr($base_url,0,16)!='http://localhost') && (substr($base_url,0,16)!='http://127.0.0.1') && (substr($base_url,0,15)!='http://192.168.') && (substr($base_url,0,10)!='http://10.');
		if (($ping) && (get_option('site_closed')=='0') && ($not_local))
		{
			// Submit to search engines
			$services=array(
				'http://www.google.com/webmasters/tools/ping?sitemap=',
				'http://submissions.ask.com/ping?sitemap=',
				'http://www.bing.com/webmaster/ping.aspx?siteMap=',
				'http://search.yahooapis.com/SiteExplorerService/V1/updateNotification?appid=SitemapWriter&url=',
			);
			foreach ($services as $service)
			{
				http_download_file($service.urlencode(get_custom_base_url().'/ocp_sitemap.xml'),NULL,false);
			}
		}
	}
}

/**
 * Start up a search for page-links, writing results into the callback. Usually we pass a callback that builds a Sitemap XML file, but we don't need to- it can be anything.
 *
 * @param  string  	Callback function to send discovered page-links to.
 * @param  MEMBER		The member we are finding stuff for (we only find what the member can view).
 * @param  ?array		Page-links to skip (NULL: none). Currently this only works on pages, but may be expanded in the future.
 * @param  integer	Code for how deep we are tunnelling down, in terms of what kinds of things we'll go so far as to collect. Use DEPTH__* constants for the values.
 */
function spawn_page_crawl($callback,$member_id,$extra_filters=NULL,$depth=1)
{
	require_all_lang();
	require_code('zones2');

	if (is_null($extra_filters)) $extra_filters=array();

	$comcode_page_rows=$GLOBALS['SITE_DB']->query_select('comcode_pages',array('*'));

	$_zones=array();
	$zones=find_all_zones(false,true,true);

	// Reorder a bit
	$zones2=array();
	foreach (array('','site') as $zone_match)
	{
		foreach ($zones as $i=>$zone)
		{
			if ($zone[0]==$zone_match)
			{
				$zones2[]=$zone;
				unset($zones[$i]);
			}
		}
	}
	$zones2=array_merge($zones2,$zones);

	if (function_exists('set_time_limit')) @set_time_limit(0);
	disable_php_memory_limit();

	$GLOBALS['MEMORY_OVER_SPEED']=true;

	foreach ($zones2 as $z)
	{
		list($zone,$zone_title,,$zone_default_page)=$z;
		if (has_zone_access($member_id,$zone))
		{
			$done_zone_level=false;

			$_pages=array();
			$pages=find_all_pages_wrap($zone,false,false,FIND_ALL_PAGES__ALL);
			foreach ($pages as $page=>$page_type)
			{
				if (is_integer($page)) $page=strval($page);
				if (substr($page,0,6)=='panel_') continue;
				if (substr($page,0,1)=='_') continue;
				if (in_array($zone.':'.$page,$extra_filters)) continue;
				if ($page=='404') continue;
				if (($page=='forums') && (substr($page_type,0,7)=='modules') && ((get_forum_type()=='ocf') || (get_forum_type()=='none'))) continue;
				if (($page=='join') && (substr($page_type,0,7)=='modules') && (!is_guest($member_id))) continue;

				if (get_value('disable_sitemap_for__'.$page)==='1') continue;

				if (has_page_access($member_id,$page,$zone))
				{
					// Page level
					$_entrypoints=array();
					$__entrypoints=extract_module_functions_page($zone,$page,array('get_entry_points'));
					if (!is_null($__entrypoints[0]))
					{
						$entrypoints=is_array($__entrypoints[0])?call_user_func_array($__entrypoints[0][0],$__entrypoints[0][1]):((strpos($__entrypoints[0],'::')!==false)?NULL:eval($__entrypoints[0])); // The strpos thing is a little hack that allows it to work for base-class derived modules
						if (is_null($entrypoints))
						{
							$path=zone_black_magic_filterer($zone.(($zone=='')?'':'/').'pages/'.$page_type.'/'.$page.'.php',true);
							if ((!defined('HIPHOP_PHP')) && ((ini_get('memory_limit')!='-1') && (ini_get('memory_limit')!='0') || (get_option('has_low_memory_limit')==='1')) && (strpos(file_get_contents(get_file_base().'/'.$path),' extends standard_aed_module')!==false)) // Hackerish code when we have a memory limit. It's unfortunate, we'd rather execute in full
							{
								$new_code=str_replace(',parent::get_entry_points()','',str_replace('parent::get_entry_points(),','',$__entrypoints[0]));
								if (strpos($new_code,'parent::')!==false) continue;
								$entrypoints=eval($new_code);
							} else
							{
								require_code($path);
								if (class_exists('Mx_'.filter_naughty_harsh($page)))
								{
									$object=object_factory('Mx_'.filter_naughty_harsh($page));
								} else
								{
									$object=object_factory('Module_'.filter_naughty_harsh($page));
								}
								$entrypoints=$object->get_entry_points();
							}
						}
					} else $entrypoints=array('!');
					if (!is_array($entrypoints)) $entrypoints=array('!');
					if ($entrypoints==array('!'))
					{
						if ($zone_default_page==$page) $done_zone_level=true;

						$add_date=NULL;
						$edit_date=NULL;
						$pagelink=($zone_default_page==$page)?$zone:($zone.':'.$page);
						$title=titleify($page);
						if (substr($page_type,0,7)=='comcode')
						{
							foreach ($comcode_page_rows as $page_row)
							{
								if (($page_row['p_validated']==0) && ($page_row['the_page']==$page) && ($page_row['the_zone']==$zone))
								{
									continue 2;
								}
							}

							$path=zone_black_magic_filterer(((strpos($page_type,'_custom')!==false)?get_custom_file_base():get_file_base()).'/'.filter_naughty($zone).'/pages/'.filter_naughty($page_type).'/'.$page.'.txt');
							$add_date=filectime($path);
							$edit_date=filemtime($path);
							$page_contents=file_get_contents($path);
							$matches=array();
							if (preg_match('#\[title[^\]]*\]#',$page_contents,$matches)!=0)
							{
								$start=strpos($page_contents,$matches[0])+strlen($matches[0]);
								$end=strpos($page_contents,'[/title]',$start);
								$matches=array();
								if (preg_match('#^[^\[\{\&]*$#',substr($page_contents,$start,$end-$start),$matches)!=0)
								{
									$title=$matches[0];
								} else
								{
									$_title=comcode_to_tempcode(substr($page_contents,$start,$end-$start),NULL,true);
									$title=strip_tags(@html_entity_decode($_title->evaluate(),ENT_QUOTES,get_charset()));
								}
							}
						}
						elseif (substr($page_type,0,4)=='html')
						{
							$path=zone_black_magic_filterer(((strpos($page_type,'_custom')!==false)?get_custom_file_base():get_file_base()).'/'.filter_naughty($zone).'/pages/'.filter_naughty($page_type).'/'.$page.'.htm');
							$add_date=filectime($path);
							$edit_date=filemtime($path);
							$page_contents=file_get_contents($path);
							$matches=array();
							if (preg_match('#\<title[^\>]*\>#',$page_contents,$matches)!=0)
							{
								$start=strpos($page_contents,$matches[0])+strlen($matches[0]);
								$end=strpos($page_contents,'</title>',$start);
								$title=strip_tags(@html_entity_decode(substr($page_contents,$start,$end-$start),ENT_QUOTES,get_charset()));
							}
						}

						// Callback
						call_user_func_array($callback,array($pagelink,$zone,$add_date,$edit_date,($zone_default_page==$page)?1.0:0.8,$title));
					} elseif (count($entrypoints)!=0)
					{
						// Entry point level
						$done_top=false;
						if ($depth>=DEPTH__ENTRY_POINTS)
						{
							foreach ($entrypoints as $entrypoint=>$title)
							{
								if ($entrypoint=='!')
								{
									$pagelink=$zone.':'.$page;
									$done_top=true;
									if ($zone_default_page==$page) $done_zone_level=true;
								} else
								{
									$pagelink=$zone.':'.$page.':'.$entrypoint;
									if (($zone_default_page==$page) && ($entrypoint=='misc')) $done_zone_level=true;
								}

								// Callback
								call_user_func_array($callback,array($pagelink,((count($_entrypoints)>1)&&($entrypoint!='!'))?($zone.':'.$page):$zone,NULL,NULL,(($entrypoint=='!') || ($entrypoint=='misc'))?0.8:0.7,$title));
							}
						}
						//ksort($_entrypoints);
						$title=do_lang('MODULE_TRANS_NAME_'.$page,NULL,NULL,NULL,NULL,false);
						if (is_null($title)) $title=titleify(preg_replace('#^ocf\_#','',preg_replace('#^'.str_replace('#','\#',preg_quote($zone)).'_#','',preg_replace('#^'.str_replace('#','\#',preg_quote(str_replace('zone','',$zone))).'_#','',$page))));
						if ((count($_entrypoints)>1) && (!$done_top))
						{
							// Callback
							call_user_func_array($callback,array($zone.':'.$page,$zone,NULL,NULL,0.8,$title,false));
						}
					}

					// Categories
					if ($depth>=DEPTH__CATEGORIES)
					{
						$__sitemap_pagelinks=extract_module_functions_page($zone,$page,array('get_sitemap_pagelinks'),array($callback,$member_id,$depth,$zone.':'.$page.':'));
						if (!is_null($__sitemap_pagelinks[0]))
						{
							if (is_array($__sitemap_pagelinks[0]))
							{
								call_user_func_array($__sitemap_pagelinks[0][0],$__sitemap_pagelinks[0][1]);
							} else
							{
								eval($__sitemap_pagelinks[0]);
							}
						}
					}
				}
			}

			// Zone level
			if (!$done_zone_level) // Probably will never run actually (unless we didn't show pages), as start page will override
			{
				// Callback
				call_user_func_array($callback,array($zone,'',filectime(get_file_base().'/'.$zone),NULL,1.0,$zone_title));
			}
		}
	}
}

/**
 * Initialise the writing to a Sitemaps XML file. You can only call one of these functions per time as it uses global variables for tracking.
 *
 * @param  PATH  		Where we will save to.
 */
function sitemaps_xml_initialise($file_path)
{
	global $SITEMAPS_OUT_FILE,$SITEMAPS_OUT_PATH,$SITEMAPS_OUT_TEMPPATH,$LOADED_MONIKERS;
	$SITEMAPS_OUT_TEMPPATH=ocp_tempnam('ocpsmap'); // We write to temporary path first to minimise the time our target file is invalid (during generation)
	$SITEMAPS_OUT_FILE=fopen($SITEMAPS_OUT_TEMPPATH,'wb');
	$SITEMAPS_OUT_PATH=$file_path;

	// Load ALL URL ID monikers (for efficiency)
	if ($GLOBALS['SITE_DB']->query_value('url_id_monikers','COUNT(*)',array('m_deprecated'=>0))<10000)
	{
		$query='SELECT m_moniker,m_resource_page,m_resource_type,m_resource_id FROM '.get_table_prefix().'url_id_monikers WHERE m_deprecated=0';
		$results=$GLOBALS['SITE_DB']->query_select('url_id_monikers',array('m_moniker','m_resource_page','m_resource_type','m_resource_id'),array('m_deprecated'=>0));
		foreach ($results as $result)
		{
			$LOADED_MONIKERS[$result['m_resource_page']][$result['m_resource_type']][$result['m_resource_id']]=$result['m_moniker'];
		}
	}

	// Load ALL guest permissions (for efficiency)
	$guest_id=$GLOBALS['FORUM_DRIVER']->get_guest_id();
	load_up_all_self_page_permissions($guest_id);
	load_up_all_module_category_permissions($guest_id);

	// Start of file
	$blob='<'.'?xml version="1.0" encoding="'.get_charset().'"?'.'>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
	';
	fwrite($SITEMAPS_OUT_FILE,$blob);
}

/**
 * Finalise the writing to a Sitemaps XML file.
 */
function sitemaps_xml_finished()
{
	global $SITEMAPS_OUT_FILE,$SITEMAPS_OUT_PATH,$SITEMAPS_OUT_TEMPPATH;

	// End of file
	$blob='
</urlset>
	';
	fwrite($SITEMAPS_OUT_FILE,$blob);

	// Copy to final path / tidy up
	fclose($SITEMAPS_OUT_FILE);
	@unlink($SITEMAPS_OUT_PATH);
	copy($SITEMAPS_OUT_TEMPPATH,$SITEMAPS_OUT_PATH);
	@unlink($SITEMAPS_OUT_TEMPPATH);
}

/**
 * Callback for writing a page-link into the Sitemaps XML file.
 *
 * @param  string		The page-link.
 * @param  string		The parent page-link in the ocPortal site tree.
 * @param  ?TIME		When the node was added (NULL: unknown).
 * @param  ?TIME 		When the node was last edited (NULL: unknown/never).
 * @param  float		The priority of this for spidering, 0.0-1.0.
 * @param  string		The title of the node.
 * @param  boolean	Whether the category is accessible by the user the sitemap is being generated for (Guest for a Sitemaps XML file).
 */
function pagelink_to_sitemapsxml($pagelink,$parent_pagelink,$add_date,$edit_date,$priority,$title,$accessible=true)
{
	global $SITEMAPS_OUT_FILE;

	if (!$accessible) return; // $accessible is false and we're not building up a structure, so just leave

	unset($parent_pagelink); // Structure not used for Sitemaps
	unset($title); // Title not used for Sitemaps

	list($zone,$attributes,$hash)=page_link_decode($pagelink);
	$langs=find_all_langs();
	foreach (array_keys($langs) as $lang)
	{
		$url=_build_url($attributes+(($lang==get_site_default_lang())?array():array('keep_lang'=>$lang)),$zone,NULL,false,false,true,$hash);

		$_lastmod_date=is_null($edit_date)?$add_date:$edit_date;
		if (!is_null($_lastmod_date))
		{
			$lastmod_date='<lastmod>'.xmlentities(date('Y-m-d\TH:i:s',$_lastmod_date).substr_replace(date('O',$_lastmod_date),':',3,0)).'</lastmod>';
		} else
		{
			$lastmod_date='<changefreq>yearly</changefreq>';
		}

		$url_blob='
   <url>
      <loc>'.xmlentities($url).'</loc>
      '.$lastmod_date.'
      <priority>'.float_to_raw_string($priority).'</priority>
   </url>
		';
		fwrite($SITEMAPS_OUT_FILE,$url_blob);
	}
}
