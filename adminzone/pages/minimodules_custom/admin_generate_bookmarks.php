<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

header('Content-type: text/html; charset='.get_charset());
header('Content-Disposition: attachment; filename="bookmarks.html"');

$site_name=escape_html(get_site_name());

safe_ini_set('ocproducts.xss_detect','0');

echo <<<END
<!DOCTYPE NETSCAPE-Bookmark-file-1>
<!-- This is an automatically generated file.
     It will be read and overwritten.
     DO NOT EDIT! -->
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=UTF-8">
<TITLE>Bookmarks</TITLE>
<H1>Bookmarks Menu</H1>
<DL><p>
  <DT><H3>{$site_name}</H3>
  <DL><p>
END;

$comcode_page_rows=$GLOBALS['SITE_DB']->query_select('comcode_pages',array('*'));

require_all_lang();

$_zones=array();
$zones=find_all_zones(false,true);

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

require_code('zones2');

foreach ($zones2 as $z)
{
	list($zone,$zone_title,,)=$z;
	if (has_zone_access(get_member(),$zone))
	{
		$_pages=array();
		$pages=find_all_pages_wrap($zone);
		foreach ($pages as $page=>$page_type)
		{
			if (is_integer($page)) $page=strval($page);
			if (substr($page,0,6)=='panel_') continue;
			if (substr($page,0,1)=='_') continue;
			if ($page=='404') continue;
			if ($page=='sitemap') continue;
			if (($page=='forums') && (substr($page_type,0,7)=='modules') && ((get_forum_type()=='ocf') || (get_forum_type()=='none'))) continue;
			if (($page=='join') && (substr($page_type,0,7)=='modules') && (!is_guest())) continue;

			if (has_page_access(get_member(),$page,$zone))
			{
				$_entrypoints=array();
				$__entrypoints=extract_module_functions_page($zone,$page,array('get_entry_points'));
				if (!is_null($__entrypoints[0]))
				{
					$entrypoints=is_array($__entrypoints[0])?call_user_func_array($__entrypoints[0][0],$__entrypoints[0][1]):((strpos($__entrypoints[0],'::')!==false)?NULL:eval($__entrypoints[0])); // The strpos thing is a little hack that allows it to work for base-class derived modules
					if (is_null($entrypoints))
					{
						require_code(zone_black_magic_filterer($zone.'/pages/'.$page_type.'/'.$page.'.php',true));
						if (class_exists('Mx_'.filter_naughty_harsh($page)))
						{
							$object=object_factory('Mx_'.filter_naughty_harsh($page));
						} else
						{
							$object=object_factory('Module_'.filter_naughty_harsh($page));
						}
						$entrypoints=$object->get_entry_points();
					}
				} else $entrypoints=array('!');
				if (!is_array($entrypoints)) $entrypoints=array('!');
				if ($entrypoints==array('!'))
				{
					$url=build_url(array('page'=>$page),$zone,NULL,false,false,true);
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
						$page_contents=file_get_contents($path);
						$matches=array();
						if (preg_match('#\[title[^\]]*\]#',$page_contents,$matches)!=0)
						{
							$start=strpos($page_contents,$matches[0])+strlen($matches[0]);
							$end=strpos($page_contents,'[/title]',$start);
							$_title=comcode_to_tempcode(substr($page_contents,$start,$end-$start),NULL,true);
							$title=strip_tags(@html_entity_decode($_title->evaluate(),ENT_QUOTES,get_charset()));
						}
					}
					elseif (substr($page_type,0,4)=='html')
					{
						$path=zone_black_magic_filterer(((strpos($page_type,'_custom')!==false)?get_custom_file_base():get_file_base()).'/'.filter_naughty($zone).'/pages/'.filter_naughty($page_type).'/'.$page.'.htm');
						$page_contents=file_get_contents($path);
						$matches=array();
						if (preg_match('#\<title[^\>]*\>#',$page_contents,$matches)!=0)
						{
							$start=strpos($page_contents,$matches[0])+strlen($matches[0]);
							$end=strpos($page_contents,'</title>',$start);
							$title=strip_tags(@html_entity_decode(substr($page_contents,$start,$end-$start),ENT_QUOTES,get_charset()));
						}
					}
					$temp='<DT><A HREF="'.escape_html($url->evaluate()).'">'.escape_html($title).'</A>';
					$_pages[$title]=$temp;
				} elseif (count($entrypoints)!=0)
				{
					foreach ($entrypoints as $entrypoint=>$title)
					{
						if ($entrypoint=='!')
						{
							$url=build_url(array('page'=>$page),$zone,NULL,false,false,true);
						} else
						{
							$url=build_url(array('page'=>$page,'type'=>$entrypoint),$zone,NULL,false,false,true);
						}
						$_entrypoints[$title]='<DT><A HREF="'.escape_html($url->evaluate()).'">'.do_lang($title).'</A>';
					}
					//ksort($_entrypoints);
					$url=new ocp_tempcode();
					$title=do_lang('MODULE_TRANS_NAME_'.$page,NULL,NULL,NULL,NULL,false);
					if (is_null($title)) $title=titleify(preg_replace('#^ocf\_#','',preg_replace('#^'.str_replace('#','\#',preg_quote($zone)).'_#','',preg_replace('#^'.str_replace('#','\#',preg_quote(str_replace('zone','',$zone))).'_#','',$page))));
					if ((count($_entrypoints)==1) && ($url->is_empty()))
					{
						$temp_keys=array_keys($_entrypoints);
						$temp=$_entrypoints[$temp_keys[0]];
					} else
					{
						$temp='<DT><H3>'.escape_html($title).'</H3><DL><p>'.implode('',$_entrypoints).'</p></DL>';
					}
					$_pages[$title]=$temp;
				}
			}
		}
		$url=new ocp_tempcode();
		ksort($_pages);
		$temp='<DT><H3>'.escape_html($zone_title).'</H3><DL><p>'.implode('',$_pages).'</p></DL>';
		$_zones[]=$temp;
	}
}

foreach ($_zones as $zone)
{
	echo $zone;
}

echo <<<END
	</DL><p>
	</DL><p>
END;

exit();
