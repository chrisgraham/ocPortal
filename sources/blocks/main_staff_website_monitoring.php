<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/*NO_API_CHECK*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		core_adminzone_frontpage
 */

class Block_main_staff_website_monitoring
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
	 * Standard modular uninstall function.
	 */
	function uninstall()
	{
		$GLOBALS['SITE_DB']->drop_if_exists('sitewatchlist');
	}

	/**
	 * Standard modular install function.
	 *
	 * @param  ?integer	What version we're upgrading from (NULL: new install)
	 * @param  ?integer	What hack version we're upgrading from (NULL: new-install/not-upgrading-from-a-hacked-version)
	 */
	function install($upgrade_from=NULL,$upgrade_from_hack=NULL)
	{
		if ((is_null($upgrade_from)) || ($upgrade_from < 2))
		{
			$GLOBALS['SITE_DB']->create_table('sitewatchlist',array(
				'id'=>'*AUTO',
				'siteurl'=>'URLPATH',
				'site_name'=>'SHORT_TEXT',
			));

			$GLOBALS['SITE_DB']->query_insert('sitewatchlist',array(
				'siteurl'=>get_base_url(),
				'site_name'=>get_site_name(),
			));
		}
	}

	/**
	 * Function to find Alexa details of the site.
	 *
	 * @param  string		The URL of the site which you want to find out information on.)
	 * @return array		Returns a triple array with the rank, the amount of links, and the speed of the site.
	 */
	function getAlexaRank( $url )
	{
		require_lang('staff_checklist');

		require_code('files');
		$p=array();
		$result=http_download_file('http://data.alexa.com/data?cli=10&dat=s&url='.$url,NULL,false,false,'ocPortal',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1.0);
		if (preg_match('#<POPULARITY [^<>]*TEXT="([0-9]+){1,}"#si',$result,$p)!=0)
			$rank=integer_format(intval($p[1]));
		else $rank=do_lang('NA');
		if (preg_match('#<LINKSIN [^<>]*NUM="([0-9]+){1,}"#si',$result,$p)!=0)
			$links=integer_format(intval($p[1]));
		else $links='0';
		if (preg_match( '#<SPEED [^<>]*PCT="([0-9]+){1,}"#si',$result,$p)!=0)
			$speed='Top '.integer_format(100-intval($p[1])).'%';
		else $speed='?';

		// we would like, but cannot get (without an API key)...
		/*
			time on site
			reach (as a percentage)
			page views
			audience (i.e. what country views the site most)
		 */

		return array($rank,$links,$speed);
	}

	//convert a string to a 32-bit integer
	function StrToNum($str, $check, $magic)
	{
		$int_32_unit=4294967296.0;  // 2^32

		$length=strlen($str);
		for ($i=0; $i < $length; $i++)
		{
			$check *= $magic;
			//If the float is beyond the boundaries of integer (usually +/- 2.15e+9=2^31),
			//  the result of converting to integer is undefined
			//  refer to http://www.php.net/manual/en/language.types.integer.php
			if ((is_integer($check) && floatval($check) >= $int_32_unit) ||
				(is_float($check) && $check >= $int_32_unit))
			{
				$check=($check - $int_32_unit * intval($check / $int_32_unit));
				//if the check less than -2^31
				$check=($check < -2147483648.0) ? ($check + $int_32_unit) : $check;
				if (is_float($check)) $check=intval($check);
			}
			$check+=ord($str[$i]);
		}
		return is_integer($check)? $check : intval($check);
	}

	//genearate a hash for a url
	function HashURL($string)
	{
		$check1=$this->StrToNum($string, 0x1505, 0x21);
		$check2=$this->StrToNum($string, 0, 0x1003F);

		$check1=$check1 >> 2;
		$check1=(($check1 >> 4) & 0x3FFFFC0 ) | ($check1 & 0x3F);
		$check1=(($check1 >> 4) & 0x3FFC00 ) | ($check1 & 0x3FF);
		$check1=(($check1 >> 4) & 0x3C000 ) | ($check1 & 0x3FFF);

		$t1=(((($check1 & 0x3C0) << 4) | ($check1 & 0x3C)) <<2 ) | ($check2 & 0xF0F );
		$t2=@(((($check1 & 0xFFFFC000) << 4) | ($check1 & 0x3C00)) << 0xA) | ($check2 & 0xF0F0000 );

		return ($t1 | $t2);
	}

	//generate a checksum for the hash string
	function CheckHash($hashnum)
	{
		$check_byte=0;
		$flag=0;

		$hashstr=sprintf('%u', $hashnum) ;
		$length=strlen($hashstr);

		for ($i=$length - 1;  $i >= 0;  $i --)
		{
			$re=intval($hashstr[$i]);
			if (1 === ($flag % 2))
			{
				$re+=$re;
				$re=intval($re / 10) + ($re % 10);
			}
			$check_byte+=$re;
			$flag ++;
		}

		$check_byte=$check_byte % 10;
		if (0 !== $check_byte)
		{
			$check_byte=10 - $check_byte;
			if (1 === ($flag % 2) )
			{
				if (1 === ($check_byte % 2))
				{
					$check_byte+=9;
				}

				$check_byte=$check_byte >> 1;
			}
		}

		return '7'.strval($check_byte).$hashstr;
	}

	//return the pagerank checksum hash
	function getch($url)
	{
		return $this->CheckHash($this->HashURL($url));
	}

	//return the pagerank figure
	function getpr($url)
	{
		$ch=$this->getch($url);
		$errno='0';
		$errstr='';
		require_code('files');
		$data=http_download_file('http://toolbarqueries.google.com/tbr?client=navclient-auto&ch='.$ch.'&features=Rank&q=info:'.$url,NULL,false,false,'ocPortal',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1.0);
		if (is_null($data)) return '';
		$pos=strpos($data, "Rank_");
		if($pos === false)
		{
		} else
		{
			$pr=substr($data, $pos + 9);
			$pr=trim($pr);
			$pr=str_replace("\n",'',$pr);
			return $pr;
		}
		return NULL;
	}

	//return the pagerank figure
	function getPageRank($url)
	{
		if (preg_match('/^(http:\/\/)?([^\/]+)/i', $url)==0)
		{
			$url='http://'.$url;
		}
		$pr=$this->getpr($url);
		return $pr;
	}

	/**
	 * Standard modular run function.
	 *
	 * @param  array		A map of parameters.
	 * @return tempcode	The result of execution.
	 */
	function run($map)
	{
		define('GOOGLE_MAGIC',0xE6359A60);

		$links=post_param('website_monitoring_list_edit',NULL);
		if (!is_null($links))
		{
			$GLOBALS['SITE_DB']->query_delete('sitewatchlist');
			$items=explode("\n", $links);
			foreach ($items as $i)
			{
				$q=trim($i);
				if (!empty($q))
				{
					$bits=explode('=',$q);
					if (count($bits)>=2)
					{
						$last_bit=array_pop($bits);
						$bits=array(implode('=',$bits),$last_bit);
						$link=$bits[0];
						$site_name=$bits[1];
					} else
					{
						$link=$q;

						$site_name=$GLOBALS['SITE_DB']->query_value_null_ok('url_title_cache','t_title',array('t_url'=>$link));

						if ((is_null($site_name)) || (substr($site_name,0,1)=='!'))
						{
							$site_name='';
							$downloaded_at_link=http_download_file($link,3000,false);
							if (is_string($downloaded_at_link))
							{
								$matches=array();
								if (preg_match('#\s*<title[^>]*\s*>\s*(.*)\s*\s*<\s*/title\s*>#mi',$downloaded_at_link,$matches)!=0)
								{
									require_code('character_sets');

									$site_name=trim(str_replace('&ndash;','-',str_replace('&mdash;','-',@html_entity_decode(convert_to_internal_encoding($matches[1]),ENT_QUOTES,get_charset()))));
								}
							}
							$GLOBALS['SITE_DB']->query_insert('url_title_cache',array(
								't_url'=>$link,
								't_title'=>$site_name,
							),false,true); // To stop weird race-like conditions

							if ($site_name=='') $site_name=$link;
						}
					}
					$GLOBALS['SITE_DB']->query_insert('sitewatchlist',array('site_name'=>$site_name,'siteurl'=>fixup_protocolless_urls($link)));
				}
			}

			decache('main_staff_website_monitoring');
		}

		$rows=$GLOBALS['SITE_DB']->query_select('sitewatchlist');

		$sitesbeingwatched=array();
		$sitegriddata=array();
		if (count($rows)>0)
		{
			foreach ($rows as $r)
			{
				$alex=$this->getAlexaRank(($r['siteurl']));
				$sitesbeingwatched[$r['siteurl']]=$r['site_name'];
				$googleranking=integer_format(intval($this->getPageRank($r['siteurl'])));
				$alexaranking=$alex[0];
				$alexatraffic=$alex[1];

				$sitegriddata[]=array(
					'URL'=>$r['siteurl'],
					'GRANK'=>$googleranking,
					'ALEXAR'=>$alexaranking,
					'ALEXAT'=>$alexatraffic,
					'SITETITLE'=>$r['site_name'],
				);
			}
		}

		$map_comcode='';
		foreach ($map as $key=>$val) $map_comcode.=' '.$key.'="'.addslashes($val).'"';
		return do_template('BLOCK_MAIN_STAFF_WEBSITE_MONITORING',array('URL'=>get_self_url(),'BLOCK_NAME'=>'main_staff_website_monitoring','MAP'=>$map_comcode,'SITEURLS'=>$sitesbeingwatched,'GRIDDATA'=>$sitegriddata));
	}
}

