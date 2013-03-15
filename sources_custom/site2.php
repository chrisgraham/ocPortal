<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

if (!function_exists('_load_comcode_page_not_cached'))
{
	/**
	 * Load Comcode page from disk, then cache it.
	 *
	 * @param  PATH			The relative (to ocPortal's base directory) path to the page (e.g. pages/comcode/EN/start.txt)
	 * @param  ID_TEXT		The zone the page is being loaded from
	 * @param  ID_TEXT		The codename of the page
	 * @param  PATH			The file base to load from
	 * @param  ?array			Row from database (holds submitter etc) (NULL: no row, originated first from disk)
	 * @param  array			New row for database, used if necessary (holds submitter etc)
	 * @param  boolean		Whether the page is being included from another
	 * @return array			A triple: The page, Title to use, New Comcode page row
	 */
	function _load_comcode_page_not_cached($string,$zone,$codename,$file_base,$comcode_page_row,$new_comcode_page_row,$being_included=false)
	{
		global $COMCODE_PARSE_TITLE;

		$nql_backup=$GLOBALS['NO_QUERY_LIMIT'];
		$GLOBALS['NO_QUERY_LIMIT']=true;

		// Not cached :(
		$result=file_get_contents($file_base.'/'.$string);
		$non_trans_result=$result;
		if ((strpos($string,'/'.get_site_default_lang().'/')!==false) && (user_lang()!=get_site_default_lang()))
		{
			$result=google_translate($result,user_lang());
		}

		if (is_null($new_comcode_page_row['p_submitter']))
		{
			$as_admin=true;
			$members=$GLOBALS['FORUM_DRIVER']->member_group_query($GLOBALS['FORUM_DRIVER']->get_super_admin_groups(),1);
			if (count($members)!=0)
			{
				$new_comcode_page_row['p_submitter']=$GLOBALS['FORUM_DRIVER']->pname_id($members[key($members)]);
			} else
			{
				$new_comcode_page_row['p_submitter']=db_get_first_id()+1; // On OCF and most forums, this is the first admin member
			}
		}

		if (is_null($comcode_page_row)) // Default page. We need to find an admin to assign it to.
		{
			$page_submitter=$new_comcode_page_row['p_submitter'];
		} else
		{
			$as_admin=false; // Will only have admin privileges if $page_submitter has them
			$page_submitter=$comcode_page_row['p_submitter'];
		}


		// Parse and work out how to add
		$lang=user_lang();
		global $LAX_COMCODE;
		$temp=$LAX_COMCODE;
		$LAX_COMCODE=true;
		$_text2=comcode_to_tempcode($result,$page_submitter,$as_admin/*Ideally we assign $page_submitter based on this as well so it is safe if the Comcode cache is emptied*/,60,($being_included || (strpos($codename,'panel_')!==false))?'panel':NULL);
		$text2=$_text2->to_assembly();
		if (get_site_default_lang()!=$lang)
		{
			$non_trans__text2=comcode_to_tempcode($non_trans_result,$page_submitter,$as_admin/*Ideally we assign $page_submitter based on this as well so it is safe if the Comcode cache is emptied*/,60,($being_included || (strpos($codename,'panel_')!==false))?'panel':NULL);
			$non_trans_text2=$non_trans__text2->to_assembly();
		}
		$LAX_COMCODE=$temp;

		// Check it still needs inserting (it might actually be there, but not translated)
		$trans_key=$GLOBALS['SITE_DB']->query_value_null_ok('cached_comcode_pages','string_index',array('the_page'=>$codename,'the_zone'=>$zone,'the_theme'=>$GLOBALS['FORUM_DRIVER']->get_theme()));
		if (is_null($COMCODE_PARSE_TITLE)) $COMCODE_PARSE_TITLE='';
		$title_to_use=clean_html_title($COMCODE_PARSE_TITLE);
		if (!is_null($trans_key))
		{
			$_comcode_page_row=$GLOBALS['SITE_DB']->query_select('comcode_pages',array('*'),array('the_zone'=>$zone,'the_page'=>$codename),'',1);
			if (!array_key_exists(0,$_comcode_page_row))
			{
				$trans_key=NULL;
				$GLOBALS['SITE_DB']->query_delete('cached_comcode_pages',array('the_zone'=>$zone,'the_page'=>$codename,'the_theme'=>$GLOBALS['FORUM_DRIVER']->get_theme()));
			}
		}
		if (is_null($trans_key))
		{
			$index=$GLOBALS['SITE_DB']->query_insert('translate',array('source_user'=>$page_submitter,'broken'=>0,'importance_level'=>1,'text_original'=>$result,'text_parsed'=>$text2,'language'=>$lang),true,false,true);
			if (get_site_default_lang()!=$lang)
				$GLOBALS['SITE_DB']->query_insert('translate',array('id'=>$index,'source_user'=>$page_submitter,'broken'=>0,'importance_level'=>1,'text_original'=>$non_trans_result,'text_parsed'=>$non_trans_text2,'language'=>get_site_default_lang()),true,false,true);
			$GLOBALS['SITE_DB']->query_insert('cached_comcode_pages',array('the_zone'=>$zone,'the_page'=>$codename,'string_index'=>$index,'the_theme'=>$GLOBALS['FORUM_DRIVER']->get_theme(),'cc_page_title'=>insert_lang(clean_html_title($COMCODE_PARSE_TITLE),1,NULL,false,NULL,NULL,false,NULL,NULL,60,true,true)),false,true); // Race conditions
			decache('main_comcode_page_children');

			// Try and insert corresponding page; will silently fail if already exists. This is only going to add a row for a page that was not created in-system
			if (is_null($comcode_page_row))
			{
				$comcode_page_row=$new_comcode_page_row;
				$GLOBALS['SITE_DB']->query_insert('comcode_pages',$comcode_page_row,false,true);
			}
		} else
		{
			$comcode_page_row=$_comcode_page_row[0];

			// Check to see if it needs translating
			$test=$GLOBALS['SITE_DB']->query_value_null_ok('translate','id',array('id'=>$trans_key,'language'=>$lang));
			if (is_null($test))
			{
				$GLOBALS['SITE_DB']->query_insert('translate',array('id'=>$trans_key,'source_user'=>$page_submitter,'broken'=>0,'importance_level'=>1,'text_original'=>$result,'text_parsed'=>$text2,'language'=>$lang));
				$index=$trans_key;
			}
		}

		$GLOBALS['NO_QUERY_LIMIT']=$nql_backup;

		return array($_text2,$title_to_use,$comcode_page_row);
	}
}

if (!function_exists('_load_comcode_page_cache_off'))
{
	/**
	 * Load Comcode page from disk.
	 *
	 * @param  PATH			The relative (to ocPortal's base directory) path to the page (e.g. pages/comcode/EN/start.txt)
	 * @param  ID_TEXT		The zone the page is being loaded from
	 * @param  ID_TEXT		The codename of the page
	 * @param  PATH			The file base to load from
	 * @param  array			New row for database, used if nesessary (holds submitter etc)
	 * @param  boolean		Whether the page is being included from another
	 * @return array			A tuple: The page, New Comcode page row, Title
	 */
	function _load_comcode_page_cache_off($string,$zone,$codename,$file_base,$new_comcode_page_row,$being_included=false)
	{
		global $COMCODE_PARSE_TITLE;

		if (is_null($new_comcode_page_row['p_submitter']))
		{
			$as_admin=true;
			$members=$GLOBALS['FORUM_DRIVER']->member_group_query($GLOBALS['FORUM_DRIVER']->get_super_admin_groups(),1);
			if (count($members)!=0)
			{
				$new_comcode_page_row['p_submitter']=$GLOBALS['FORUM_DRIVER']->pname_id($members[key($members)]);
			} else
			{
				$new_comcode_page_row['p_submitter']=db_get_first_id()+1; // On OCF and most forums, this is the first admin member
			}
		}

		$_comcode_page_row=$GLOBALS['SITE_DB']->query_select('comcode_pages',array('*'),array('the_zone'=>$zone,'the_page'=>$codename),'',1);

		global $LAX_COMCODE;
		$temp=$LAX_COMCODE;
		$LAX_COMCODE=true;
		$result=file_get_contents($file_base.'/'.$string);
		if ((strpos($string,'/'.get_site_default_lang().'/')!==false) && (user_lang()!=get_site_default_lang()))
		{
			$result=google_translate($result,user_lang());
		}
		$lang=user_lang();
		$html=comcode_to_tempcode($result,array_key_exists(0,$_comcode_page_row)?$_comcode_page_row[0]['p_submitter']:get_member(),(!array_key_exists(0,$_comcode_page_row)) || (is_guest($_comcode_page_row[0]['p_submitter'])),60,($being_included || (strpos($codename,'panel_')!==false))?'panel':NULL);
		$LAX_COMCODE=$temp;
		$title_to_use=is_null($COMCODE_PARSE_TITLE)?NULL:clean_html_title($COMCODE_PARSE_TITLE);

		// Try and insert corresponding page; will silently fail if already exists. This is only going to add a row for a page that was not created in-system
		if (array_key_exists(0,$_comcode_page_row))
		{
			$comcode_page_row=$_comcode_page_row[0];
		} else
		{
			$comcode_page_row=$new_comcode_page_row;
			$GLOBALS['SITE_DB']->query_insert('comcode_pages',$comcode_page_row,false,true);
		}

		return array($html,$comcode_page_row,$title_to_use);
	}
}
