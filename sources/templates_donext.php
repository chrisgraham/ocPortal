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
 * @package		core_abstract_interfaces
 */

/**
 * Get the tempcode for a simplified admin do next manager.
 *
 * @return tempcode		The do next manager
 */
function do_next_manager_admin_simplified()
{
	breadcrumb_set_self(do_lang_tempcode('CMS'));

	$sections=new ocp_tempcode();
	$sections->attach(do_next_manager_hooked('CMS',NULL,'cms'));
	$sections->attach(do_next_manager_hooked('STRUCTURE',NULL,'structure'));
	$sections->attach(do_next_manager_hooked('USAGE',NULL,'usage'));
	$sections->attach(do_next_manager_hooked('STYLE',NULL,'style'));
	$sections->attach(do_next_manager_hooked('SETUP',NULL,'setup'));
	$sections->attach(do_next_manager_hooked('TOOLS',NULL,'tools'));
	$sections->attach(do_next_manager_hooked('SECURITY',NULL,'security'));
	$GLOBALS['HELPER_PANEL_TEXT']=do_lang_tempcode('SIMPLIFIED_STAFF_ADMIN');
	return do_template('DO_NEXT_SCREEN',array('INTRO'=>'','QUESTION'=>do_lang_tempcode('WHAT_NEXT'),'TITLE'=>get_screen_title(has_zone_access(get_member(),'adminzone')?'ADMIN_ZONE':'CMS'),'SECTIONS'=>$sections));
}

/**
 * Get the tempcode for a do next manager. A do next manager is a series of linked icons that are presented after performing an action. Modules that do not use do-next pages, usually use REFRESH_PAGE's.
 *
 * @param  ID_TEXT		The title of what we are doing (a language string)
 * @param  ?mixed			The language code for the docs of the hook defined do-next manager that we're creating OR tempcode for it (NULL: none)
 * @param  ID_TEXT		The menu 'type' we are doing (filters out any icons that don't match it)
 * @param  ?string		The title to use for the main links (a language string) (NULL: same as title)
 * @return tempcode		The do next manager
 */
function do_next_manager_hooked($title,$text,$type,$main_title=NULL)
{
	$links=array();

	if (is_null($main_title)) $main_title=$title;

	breadcrumb_set_self(do_lang_tempcode($title));

	$hooks=find_all_hooks('systems','do_next_menus');
	foreach (array_keys($hooks) as $hook)
	{
		require_code('hooks/systems/do_next_menus/'.filter_naughty_harsh($hook));
		$object=object_factory('Hook_do_next_menus_'.filter_naughty_harsh($hook),true);
		if (is_null($object)) continue;
		$info=$object->run(true);
		foreach ($info as $i)
		{
			if (is_null($i)) continue;

			if ($i[0]==$type)
			{
				array_shift($i);
				$links[]=$i;
			}
		}
	}

	global $M_SORT_KEY;
	$M_SORT_KEY=2;
	@usort($links,'multi_sort');

	if (!is_null($text))
	{
		if (strpos($text,' ')===false)
		{
			$_text=comcode_lang_string($text);
		} else $_text=make_string_tempcode($text);
	} else $_text=new ocp_tempcode();

	return do_next_manager(is_null($text)?NULL:get_screen_title($title),$_text,$links,do_lang($main_title));
}

/**
 * Get the tempcode for a do next manager. A do next manager is a series of linked icons that are presented after performing an action. Modules that do not use do-next pages, usually use REFRESH_PAGE's.
 *
 * @param  ?tempcode		The title of what we just did (should have been passed through get_screen_title already) (NULL: don't do full page)
 * @param  tempcode		The 'text' (actually, a full XHTML lump) to show on the page
 * @param  ?array			An array of entry types, with each array entry being -- an array consisting of the type codename and a URL array as per following parameters (NULL: none)
 * @param  ?string		The title to use for the main links (NULL: none)
 * @param  ?array			The URL used to 'add-one' (NULL: impossible)  (format: array of page, param, zone[, custom label])
 * @param  ?array			The URL used to 'edit-this' (NULL: impossible)  (format: array of page, param, zone[, custom label])
 * @param  ?array			The URL used to 'edit-one' (NULL: impossible)  (format: array of page, param, zone[, custom label])
 * @param  ?array			The URL used to 'view-this' (NULL: impossible)  (format: array of page, param, zone[, custom label])
 * @param  ?array			The URL used to 'view-archive' (NULL: impossible)  (format: array of page, param, zone[, custom label])
 * @param  ?array			The URL used to 'add-to-category' (NULL: impossible)  (format: array of page, param, zone[, custom label])
 * @param  ?array			The URL used to 'add-one-category' (NULL: impossible)  (format: array of page, param, zone[, custom label])
 * @param  ?array			The URL used to 'edit-one-category' (NULL: impossible)  (format: array of page, param, zone[, custom label])
 * @param  ?array			The URL used to 'edit-this-category' (NULL: impossible)  (format: array of page, param, zone[, custom label])
 * @param  ?array			The URL used to 'view-this-category' (NULL: impossible)  (format: array of page, param, zone[, custom label])
 * @param  ?array			An array of additional entry types, with each array entry being -- an array of type codename and a URL array as before (NULL: none)
 * @param  ?array			As before, but with category types (NULL: none)
 * @param  ?array			As before, but for an 'extra types' box of do next actions (NULL: none)
 * @param  ?mixed			The title to use for the extra types (NULL: none)
 * @param  ?tempcode		Introductory text (NULL: none)
 * @param  ?tempcode		Entries section title (NULL: default, Entries)
 * @param  ?tempcode		Categories section title (NULL: default, Categories)
 * @return tempcode		The do next manager
 */
function do_next_manager($title,$text,$main=NULL,$main_title=NULL,$url_add_one=NULL,$url_edit_this=NULL,$url_edit_one=NULL,$url_view_this=NULL,$url_view_archive=NULL,$url_add_to_category=NULL,$url_add_one_category=NULL,$url_edit_one_category=NULL,$url_edit_this_category=NULL,$url_view_this_category=NULL,$entry_extras=NULL,$category_extras=NULL,$additional_extras=NULL,$additional_title=NULL,$intro=NULL,$entries_title=NULL,$categories_title=NULL)
{
	if (is_null($intro)) $intro=new ocp_tempcode();

	require_lang('do_next');

	require_css('do_next');

	global $BREADCRUMB_SET_SELF;
	if (is_null($BREADCRUMB_SET_SELF)) breadcrumb_set_self(is_null($main_title)?do_lang_tempcode('MENU'):make_string_tempcode($main_title));

	$sections=new ocp_tempcode();

	// Main section stuff (the "Main" section is not always shown - it is shown when the do-next screen is being used as a traditional menu, not as a followup-action screen)
	if (!is_null($main)) $sections->attach(_do_next_section($main,make_string_tempcode($main_title)));

	$current_page_type=get_param('type','');

	// Entry stuff
	$entry_passed=array('add_to_category','add_one','edit_this','edit_one','view_this','view_archive');
	$entry_passed_2=array();
	foreach ($entry_passed as $option)
	{
		$x=NULL;
		$auto_add=mixed();
		switch ($option)
		{
			case 'add_to_category':
				$x=$url_add_to_category;
				break;
			case 'add_one':
				$x=$url_add_one;
				if (($current_page_type=='_ad') || ($current_page_type=='_add_entry'))
				{
					if (get_param_integer('auto__add_one',0)==1)
					{
						$x[1]['auto__add_one']='1';
						$_url_redirect=build_url(array_merge(array('page'=>$x[0]),$x[1]),$x[2]);
						require_code('templates_redirect_screen');
						return redirect_screen($title,$_url_redirect,$text);
					}
					$auto_add='auto__add_one';
				}
				break;
			case 'edit_this':
				$x=$url_edit_this;
				break;
			case 'edit_one':
				$x=$url_edit_one;
				break;
			case 'view_this':
				$x=$url_view_this;
				if (!is_null($x))
				{
					$keep_simplified_donext=get_param_integer('keep_simplified_donext',NULL);
					if ((($keep_simplified_donext!==0) && (get_option('simplified_donext')=='1')) || ($keep_simplified_donext==1))
					{
						$_url_redirect=build_url(array_merge(array('page'=>$x[0]),$x[1]),$x[2]);
						require_code('templates_redirect_screen');
						return redirect_screen($title,$_url_redirect,$text);
					}
				}
				break;
			case 'view_archive':
				$x=$url_view_archive;
				break;
		}
		if (!is_null($x))
		{
			if (array_key_exists(3,$x)) $map=array($option,array($x[0],$x[1],$x[2]),$x[3]); else $map=array($option,$x);
			if (!is_null($auto_add)) $map[5]=$auto_add;
			$entry_passed_2[]=$map;
		}
	}
	if (!is_null($entry_extras)) $entry_passed_2=array_merge($entry_passed_2,$entry_extras);
	$sections->attach(_do_next_section($entry_passed_2,is_null($entries_title)?do_lang_tempcode('ENTRIES'):$entries_title));

	// Category stuff
	$category_passed=array('add_one_category','edit_one_category','edit_this_category','view_this_category');
	$category_passed_2=array();
	foreach ($category_passed as $option)
	{
		$x=NULL;
		$auto_add=mixed();
		switch ($option)
		{
			case 'add_one_category':
				$x=$url_add_one_category;
				if (($current_page_type=='_ac') || ($current_page_type=='_add_category'))
				{
					if (get_param_integer('auto__add_one_category',0)==1)
					{
						$x[1]['auto__add_one_category']='1';
						$_url_redirect=build_url(array_merge(array('page'=>$x[0]),$x[1]),$x[2]);
						require_code('templates_redirect_screen');
						return redirect_screen($title,$_url_redirect,$text);
					}
					$auto_add='auto__add_one_category';
				}
				break;
			case 'edit_one_category':
				$x=$url_edit_one_category;
				break;
			case 'edit_this_category':
				$x=$url_edit_this_category;
				break;
			case 'view_this_category':
				$x=$url_view_this_category;
				if (!is_null($x))
				{
					$keep_simplified_donext=get_param_integer('keep_simplified_donext',NULL);
					if ((($keep_simplified_donext!==0) && (get_option('simplified_donext')=='1')) || ($keep_simplified_donext==1))
					{
						$_url_redirect=build_url(array_merge(array('page'=>$x[0]),$x[1]),$x[2]);
						require_code('templates_redirect_screen');
						return redirect_screen($title,$_url_redirect,$text);
					}
				}
				break;
			case 'view_archive':
				$x=$url_view_archive;
				break;
		}
		if (!is_null($x))
		{
			if (array_key_exists(3,$x)) $map=array($option,array($x[0],$x[1],$x[2]),$x[3]); else $map=array($option,$x);
			if (!is_null($auto_add)) $map[5]=$auto_add;
			$category_passed_2[]=$map;
		}
	}
	if (!is_null($category_extras)) $category_passed_2=array_merge($category_passed_2,$category_extras);
	$sections->attach(_do_next_section($category_passed_2,is_null($categories_title)?do_lang_tempcode('CATEGORIES'):$categories_title));

	// Additional section stuff
	if (!is_null($additional_extras)) $sections->attach(_do_next_section($additional_extras,is_object($additional_title)?$additional_title:make_string_tempcode($additional_title)));

	if ((is_null($main)) && (get_option('global_donext_icons')=='1')) // What-next
	{
		// These go on a new row
		$disjunct_items=array(
							array('main_home',array(NULL,array(),'')),
							array('cms_home',array(NULL,array(),'cms')),
							array('admin_home',array(NULL,array(),'adminzone')),
		);
		$sections->attach(_do_next_section($disjunct_items,do_lang_tempcode('GLOBAL_NAVIGATION')));
		$question=do_lang_tempcode('WHERE_NEXT');
	} else // Where-next
	{
		$question=do_lang_tempcode('WHAT_NEXT');
	}

	if ($text->evaluate()==do_lang('SUCCESS'))
	{
		attach_message($text,'inform');
		$text=mixed();
	} else
	{
		//$GLOBALS['HELPER_PANEL_TEXT']=$text;
	}

	if (is_null($title)) return $sections;

	return do_template('DO_NEXT_SCREEN',array('_GUID'=>'a00e89bece6b7ce870ad5096930d5a94','INTRO'=>$intro,'TEXT'=>$text,'QUESTION'=>$question,'TITLE'=>$title,'SECTIONS'=>$sections));
}

/**
 * Get the tempcode for a do next manager. A do next manager is a series of linked icons that are presented after performing an action. Modules that do not use do-next pages, usually use REFRESH_PAGE's.
 *
 * @param  array			A list of items (each item is a pair or a triple: <option,url[,field name=do_lang(option)]> ; url is a pair or a triple or a quarto also: <page,map[,zone[,warning]]>)
 * @param  tempcode		The title for the section
 * @return tempcode		The do next manager section
 */
function _do_next_section($list,$title)
{
	if (count($list)==0) return new ocp_tempcode();

	$next_items=new ocp_tempcode();

	$num_siblings=0;
	foreach ($list as $i=>$_option)
	{
        if ($_option === null) continue;

		$url=$_option[1];
		if (!is_null($url))
		{
			$zone=array_key_exists(2,$url)?$url[2]:'';
			$page=$url[0];
			if ($page=='_SELF') $page=get_page_name();
			if (((is_null($page)) && (has_zone_access(get_member(),$zone))) || ((!is_null($page)) && (has_actual_page_access(get_member(),$page,$zone))))
			{
				$num_siblings++;
			} else $list[$i]=NULL;
		} else $list[$i]=NULL;
	}
	$i=0;
	foreach ($list as $_option)
	{
		if (is_null($_option)) continue;

		$option=$_option[0];
		$url=$_option[1];
		$zone=array_key_exists(2,$url)?$url[2]:'';
		$page=$url[0];
		if ($page=='_SELF') $page=get_page_name();

		$description=(array_key_exists(2,$_option) && (!is_null($_option[2])))?$_option[2]:do_lang_tempcode('NEXT_ITEM_'.$option);
		$link=(is_null($page))?build_url(array_merge($url[1],array('page'=>'')),$zone):build_url(array_merge(array('page'=>$page),$url[1]),$zone);
		$doc=array_key_exists(3,$_option)?$_option[3]:'';
		if ((is_string($doc)) && ($doc!=''))
		{
			if (preg_match('#^[\w\d]+$#',$doc)==0)
			{
				$doc=comcode_to_tempcode($doc,NULL,true);
			} else
			{
				$doc=comcode_lang_string($doc);
			}
		}
		$target=array_key_exists(4,$_option)?$_option[4]:NULL;
		$auto_add=array_key_exists(5,$_option)?$_option[5]:NULL;
		$next_items->attach(do_template('DO_NEXT_ITEM',array('_GUID'=>'f39b6055d1127edb452595e7eeaf2f01','AUTO_ADD'=>$auto_add,'I'=>strval($i),'I2'=>strval(mt_rand(0,32000)).'_'.strval($i),'NUM_SIBLINGS'=>strval($num_siblings),'TARGET'=>$target,'PICTURE'=>$option,'DESCRIPTION'=>$description,'LINK'=>$link,'DOC'=>$doc,'WARNING'=>array_key_exists(3,$url)?$url[3]:'')));
		$i++;
	}

	if ($next_items->is_empty()) return new ocp_tempcode();

	return do_template('DO_NEXT_SECTION',array('_GUID'=>'18589e9e8ec1971f692cb76d71f33ec1','I'=>strval($i),'TITLE'=>$title,'CONTENT'=>$next_items));
}

