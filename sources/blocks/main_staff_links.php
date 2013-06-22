<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		core_adminzone_frontpage
 */

class Block_main_staff_links
{

	/**
	 * Standard modular info function.
	 *
	 * @return ?array	Map of module info (NULL: module is disabled).
	 */
	function info()
	{
		$info=array();
		$info['author']='Jack Franklin';
		$info['organisation']='ocProducts';
		$info['hacked_by']=NULL;
		$info['hack_version']=NULL;
		$info['version']=3;
		$info['locked']=false;
		$info['parameters']=array();
		$info['update_require_upgrade']=1;
		return $info;
	}

	/**
	 * Standard modular uninstall function.
	 */
	function uninstall()
	{
		$GLOBALS['SITE_DB']->drop_if_exists('stafflinks');
	}

	/**
	 * Standard modular cache function.
	 *
	 * @return ?array	Map of cache details (cache_on and ttl) (NULL: module is disabled).
	 */
	function cacheing_environment()
	{
		$info=array();
		$info['cache_on']='(count($_POST)>0)?NULL:array()'; // No cache on POST as this is when we save text data
		$info['ttl']=60*5;
		return $info;
	}

	/**
	 * Standard modular install function.
	 *
	 * @param  ?integer	What version we're upgrading from (NULL: new install)
	 * @param  ?integer	What hack version we're upgrading from (NULL: new-install/not-upgrading-from-a-hacked-version)
	 */
	function install($upgrade_from=NULL,$upgrade_from_hack=NULL)
	{
		if ((is_null($upgrade_from)) || ($upgrade_from < 3))
		{
			$GLOBALS['SITE_DB']->create_table('stafflinks',array(
				'id'=>'*AUTO',
				'link'=>'URLPATH',
				'link_title'=>'SHORT_TEXT',
				'link_desc'=>'LONG_TEXT',
			));

			$default_links=array(
				'ocPortal.com'=>'http://ocportal.com/',
				'ocPortal.com (topics with unread posts)'=>'http://ocportal.com/forum/vforums/unread.htm',
				'ocProducts (web development services)'=>'http://ocproducts.com/',
				'Launchpad (ocPortal language translations)'=>'https://translations.launchpad.net/ocportal/+translations',
				'Google Alerts'=>'http://www.google.com/alerts',
				'Google Analytics'=>'http://www.google.com/analytics/',
				'Google Webmaster Tools'=>'https://www.google.com/webmasters/tools',
				'Google Apps (free gmail for domains, etc)'=>'http://www.google.com/apps/intl/en/group/index.html',
				'Google Chrome (web browser)'=>'http://www.google.com/chrome',
				'Google Chrome addons'=>'https://chrome.google.com/extensions/featured/web_dev',
				'Firefox (web browser)'=>'http://www.getfirefox.com/',
				'FireFox addons'=>'http://www.instantshift.com/2009/01/25/26-essential-firefox-add-ons-for-web-designers/',
				'Opera (web browser)'=>'http://www.opera.com/',
				'Internet Explorer Tester (for testing)'=>'http://www.my-debugbar.com/wiki/IETester/HomePage',
				'Paint.net (free graphics tool)'=>'http://www.getpaint.net/',
				'PNGGauntlet (compress PNG files, Windows)'=>'http://benhollis.net/software/pnggauntlet/',
				'ImageOptim (compress PNG files, Mac)'=>'http://imageoptim.pornel.net/',
				'Iconlet (free icons)'=>'http://www.iconlet.com/',
				'stock.xchng (free stock art)'=>'http://sxc.hu/',
				'Kompozer (Web design tool)'=>'http://www.kompozer.net/',
				'DiffMerge'=>'http://www.sourcegear.com/diffmerge/',
				'Jing (record screencasts)'=>'http://www.jingproject.com/',
				'Rackspace Cloud hosting'=>'http://www.rackspacecloud.com/1043-0-3-13.html',
				'GoDaddy (Domains and SSL certificates)'=>'http://www.jdoqocy.com/click-3972552-10378406',
				'SiteRay (site quality auditing)'=>'http://www.silktide.com/siteray',
				'Smashing Magazine (web design articles)'=>'http://www.smashingmagazine.com/',
				'w3schools (learn web technologies)'=>'http://www.w3schools.com/',
			);
			foreach ($default_links as $link_title=>$url)
			{
				$GLOBALS['SITE_DB']->query_insert('stafflinks',array(
					'link'=>$url,
					'link_title'=>$link_title,
					'link_desc'=>$link_title,
				));
			}
		}
	}

	/**
	 * Standard modular run function.
	 *
	 * @param  array		A map of parameters.
	 * @return tempcode	The result of execution.
	 */
	function run($map)
	{
		require_lang('staff_checklist');

		$newdata=post_param('staff_links_edit', NULL);
		if (!is_null($newdata))
		{
			$items=explode("\n", $newdata);
			$GLOBALS['SITE_DB']->query_delete('stafflinks');

			foreach ($items as $i)
			{
				$q=trim($i);
				if(!empty($q))
				{
					$bits=explode('=',$q);
					if (count($bits)>=2)
					{
						$last_bit=array_pop($bits);
						$bits=array(implode('=',$bits),$last_bit);
						$link=$bits[0];
					} else
					{
						$link=$q;
					}

					$link_title=$GLOBALS['SITE_DB']->query_value_null_ok('url_title_cache','t_title',array('t_url'=>$link));

					if ((is_null($link_title)) || (substr($link_title,0,1)=='!'))
					{
						$link_title='';
						$downloaded_at_link=http_download_file($link,3000,false);
						if (is_string($downloaded_at_link))
						{
							$matches=array();
							if (preg_match('#\s*<title[^>]*\s*>\s*(.*)\s*\s*<\s*/title\s*>#mi',$downloaded_at_link,$matches)!=0)
							{
								require_code('character_sets');

								$link_title=trim(str_replace('&ndash;','-',str_replace('&mdash;','-',@html_entity_decode(convert_to_internal_encoding($matches[1]),ENT_QUOTES,get_charset()))));
							}
						}
						$GLOBALS['SITE_DB']->query_insert('url_title_cache',array(
							't_url'=>$link,
							't_title'=>$link_title,
						),false,true); // To stop weird race-like conditions
					}

					if (count($bits)==2)
					{
						$link_desc=$bits[1];
					} else
					{
						$link_desc=$link_title;
					}
					$GLOBALS['SITE_DB']->query_insert('stafflinks',array(
						'link'=>$link,
						'link_title'=>$link_title,
						'link_desc'=>$link_desc,
					));
				}
			}

			decache('main_staff_links');
		}

		$rows=$GLOBALS['SITE_DB']->query_select('stafflinks',array('*'));
		$formatted_staff_links=array();
		$unformatted_staff_links=array();
		foreach($rows as $r)
		{
			if ($r['link_title']=='') $r['link_title']=$r['link_desc'];
			if (strlen($r['link_title'])>strlen($r['link_desc'])) $r['link_title']=$r['link_desc'];

			$formatted_staff_links[]=array(
				'URL'=>$r['link'],
				'TITLE'=>$r['link_title'],
				'DESC'=>($r['link_title']==$r['link_desc'])?'':$r['link_desc'],
			);
			$unformatted_staff_links[]=array('LINKS'=>$r['link'].'='.$r['link_desc']);
		}

		$map_comcode='';
		foreach ($map as $key=>$val) $map_comcode.=' '.$key.'="'.addslashes($val).'"';
		return do_template('BLOCK_MAIN_STAFF_LINKS',array('URL'=>get_self_url(),'BLOCK_NAME'=>'main_staff_links','MAP'=>$map_comcode,'FORMATTED_LINKS'=>$formatted_staff_links,'UNFORMATTED_LINKS'=>$unformatted_staff_links));
	}

}


