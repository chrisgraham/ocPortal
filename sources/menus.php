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
 * @package		core_menus
 */

/**
 * Standard code module initialisation function.
 */
function init__menus()
{
	if (!defined('MIN_STAFF_ICONS_BEFORE_COLLAPSE')) define('MIN_STAFF_ICONS_BEFORE_COLLAPSE',25); // less than this icons means our admin menuing collapses to one screen
}

/**
 * Build a pseudo 'stored menu' out of do_next_menus hooks (we create database rows so we can render it as a normal stored menu).
 *
 * @param  array			The complete collection of hooks
 * @param  ID_TEXT		The encoded 'type' in the menu tree we are showing for at (textual parent)
 * @param  ?integer		The parent ID (NULL: no parent)
 * @return array			Faked database rows
 */
function build_stored_menu_hooked($collect,$type,$parent=NULL)
{
	$items=array();
	foreach ($collect as $i)
	{
		if (is_null($i)) continue;

		if ($i[0]==$type)
		{
			if (!has_actual_page_access(NULL,$i[2][0],$i[2][2])) continue;

			do
			{
				$rand_id=mt_rand(0,mt_getrandmax()); // mt_getrandmax is high, needs to be to stop $parent possibly being set as $rand_id. But we will loop just in case.
			}
			while ($rand_id===$parent);
			$url=build_url(array_merge(array('page'=>$i[2][0]),$i[2][1]),$i[2][2]);
			$map=array('id'=>$rand_id,'i_parent'=>$parent,'cap'=>is_object($i[3])?@strip_tags(html_entity_decode($i[3]->evaluate(),ENT_QUOTES,get_charset())):$i[3],'i_url'=>$url,'i_check_permissions'=>0,'i_expanded'=>0,'i_new_window'=>0,'i_page_only'=>'');
			if (is_null($parent))
			{
				switch ($i[2][1]['type'])
				{
					case 'start':
						$map['i_theme_img_code']='menu_items/management_navigation/start';
						break;
					case 'structure':
						$map['i_theme_img_code']='menu_items/management_navigation/structure';
						break;
					case 'security':
						$map['i_theme_img_code']='menu_items/management_navigation/security';
						break;
					case 'style':
						$map['i_theme_img_code']='menu_items/management_navigation/style';
						break;
					case 'setup':
						$map['i_theme_img_code']='menu_items/management_navigation/setup';
						break;
					case 'tools':
						$map['i_theme_img_code']='menu_items/management_navigation/tools';
						break;
					case 'usage':
						$map['i_theme_img_code']='menu_items/management_navigation/usage';
						break;
					case 'cms':
						$map['i_theme_img_code']='menu_items/management_navigation/cms';
						break;
				}
			} else
			{
				$map['i_theme_img_code']='bigicons/'.$i[1];
			}
			if (isset($i[2][1]['type']))
			{
				$items2=build_stored_menu_hooked($collect,$i[2][1]['type'],$rand_id);
				if ((count($items2)==0) && ($type=='')) continue;
			} else $items2=array();
			$items[]=$map;
			$items=array_merge($items,$items2);
		}
	}
	return $items;
}

/**
 * Build management menu.
 *
 * @return array			Faked database rows
 */
function build_management_menu()
{
	if (is_guest()) return array();

	require_lang('menus');
	require_lang('security');

	$sections=array(
		'start'=>array('TOOLTIP'=>do_lang('MM_TOOLTIP_START'),'CURRENT'=>false,'URL'=>'adminzone:','CAPTION'=>do_lang('ADMIN_HOME'),'IMG'=>'menu_items/management_navigation/start'),
		'usage'=>array('TOOLTIP'=>do_lang('MM_TOOLTIP_USAGE'),'CURRENT'=>false,'URL'=>'adminzone:admin:usage','CAPTION'=>do_lang('USAGE'),'IMG'=>'menu_items/management_navigation/usage'),
		'security'=>array('TOOLTIP'=>do_lang('MM_TOOLTIP_SECURITY'),'CURRENT'=>false,'URL'=>'adminzone:admin:security','CAPTION'=>do_lang('SECURITY'),'IMG'=>'menu_items/management_navigation/security'),
		'setup'=>array('TOOLTIP'=>do_lang('MM_TOOLTIP_SETUP'),'CURRENT'=>false,'URL'=>'adminzone:admin:setup','CAPTION'=>do_lang('SETUP'),'IMG'=>'menu_items/management_navigation/setup'),
		'structure'=>array('TOOLTIP'=>do_lang('MM_TOOLTIP_STRUCTURE'),'CURRENT'=>false,'URL'=>'adminzone:admin:structure','CAPTION'=>do_lang('STRUCTURE'),'IMG'=>'menu_items/management_navigation/structure'),
		'style'=>array('TOOLTIP'=>do_lang('MM_TOOLTIP_STYLE'),'CURRENT'=>false,'URL'=>'adminzone:admin:style','CAPTION'=>do_lang('STYLE'),'IMG'=>'menu_items/management_navigation/style'),
		'tools'=>array('TOOLTIP'=>do_lang('MM_TOOLTIP_TOOLS'),'CURRENT'=>false,'URL'=>'adminzone:admin:tools','CAPTION'=>do_lang('TOOLS'),'IMG'=>'menu_items/management_navigation/tools'),
		'cms'=>array('TOOLTIP'=>do_lang('MM_TOOLTIP_CMS'),'CURRENT'=>false,'URL'=>'cms:cms','CAPTION'=>do_lang('CONTENT'),'IMG'=>'menu_items/management_navigation/cms'),
	);

	if ((get_page_name()=='admin') && (array_key_exists(get_param('type',''),$sections)))
	{
		$sections[get_param('type')]['CURRENT']=true;
	}
	if (get_page_name()=='cms')
	{
		$sections['cms']['CURRENT']=true;
	}
	if ((get_zone_name()=='adminzone') && (get_page_name()=='start'))
	{
		$sections['start']['CURRENT']=true;
	}

	if (((!has_specific_permission(get_member(),'avoid_simplified_adminzone_look')) || ($GLOBALS['FORUM_DRIVER']->is_super_admin(get_member()))) && (num_staff_icons()<MIN_STAFF_ICONS_BEFORE_COLLAPSE))
	{
		if (num_staff_icons()<MIN_STAFF_ICONS_BEFORE_COLLAPSE)
		{
			$sections=array();
			$sections['']=array('TOOLTIP'=>'','CURRENT'=>false,'URL'=>build_url(array('page'=>''),'site'),'CAPTION'=>do_lang('SITE'),'IMG'=>'menu_items/management_navigation/start');
			if (has_zone_access(get_member(),'adminzone')) $sections['start']=array('TOOLTIP'=>'','CURRENT'=>false,'URL'=>build_url(array('page'=>''),'adminzone'),'CAPTION'=>do_lang('GUIDE'),'IMG'=>'menu_items/management_navigation/setup');
			$sections['admin']=array('TOOLTIP'=>'','CURRENT'=>false,'URL'=>build_url(array('page'=>'cms'),'cms'),'CAPTION'=>do_lang('OPTIONS'),'IMG'=>'menu_items/management_navigation/cms');
		}
	}

	if (has_zone_access(get_member(),'adminzone'))
	{
		$docs_url=(get_option('show_docs')=='0')?build_url(array('page'=>'website'),'adminzone'):make_string_tempcode(brand_base_url().'/docs'.strval(ocp_version()).'/');
		$sections['docs']=array('TOOLTIP'=>do_lang('MM_TOOLTIP_DOCS'),'CURRENT'=>false,'URL'=>$docs_url,'CAPTION'=>do_lang('DOCS'),'IMG'=>'menu_items/management_navigation/docs');
	}

	$items=array();

	$hooks=find_all_hooks('systems','do_next_menus');
	$collect=array();
	foreach ($hooks as $hook=>$sources_dir)
	{
		$run_function=extract_module_functions(get_file_base().'/'.$sources_dir.'/hooks/systems/do_next_menus/'.$hook.'.php',array('run'),array(true));
		if (!is_null($run_function[0]))
		{
			$collect=array_merge($collect,is_array($run_function[0])?call_user_func_array($run_function[0][0],$run_function[0][1]):eval($run_function[0]));
		}
	}

	$i=1;
	require_all_lang();
	global $M_SORT_KEY;
	$M_SORT_KEY='cap';
	foreach ($sections as $type=>$section)
	{
		if ((count($sections)>4) || ($type=='admin'))
		{
			$virtual_type=($type=='admin')?'':$type;
			$items2=build_stored_menu_hooked($collect,$virtual_type,-$i);
			usort($items2,'multi_sort');
		} else
		{
			$items2=array();
		}
		if ((count($items2)!=0) || (is_object($section['URL'])) || ($section['URL']!=''))
		{
			$items[]=array('id'=>-$i,'i_parent'=>NULL,'cap'=>$section['CAPTION'],'i_caption_long'=>$section['TOOLTIP'],'i_url'=>$section['URL'],'i_theme_img_code'=>$section['IMG'],'i_check_permissions'=>1,'i_expanded'=>0,'i_new_window'=>0,'i_page_only'=>'');
			$items=array_merge($items,$items2);
			$i++;
		}
	}

	return $items;
}

/**
 * Build community menu.
 *
 * @return array			Faked database rows
 */
function build_community_menu()
{
	if (!addon_installed('ocf_forum')) return array();
	if (get_forum_type()!='ocf') return array();

	require_lang('ocf');
	require_lang('menus');
	//require_lang('chat');

	$sections=array(
		'forumview'=>array('LAST'=>false,'CURRENT'=>false,'URL'=>'_SEARCH:forumview','CAPTION'=>do_lang('SECTION_FORUMS'),'IMG'=>'menu_items/forum_navigation/forums'),
		'rules'=>array('LAST'=>false,'CURRENT'=>false,'URL'=>'_SEARCH:rules','CAPTION'=>do_lang('RULES'),'IMG'=>'menu_items/forum_navigation/rules'),
		'members'=>array('LAST'=>false,'CURRENT'=>false,'URL'=>'_SEARCH:members','CAPTION'=>do_lang('MEMBERS'),'IMG'=>'menu_items/forum_navigation/members'),
		'groups'=>array('LAST'=>false,'CURRENT'=>false,'URL'=>'_SEARCH:groups','CAPTION'=>do_lang('GROUPS'),'IMG'=>'menu_items/forum_navigation/groups'),
//		'points'=>array('LAST'=>false,'CURRENT'=>false,'URL'=>'_SEARCH:points','CAPTION'=>do_lang('POINTS'),'IMG'=>'menu_items/forum_navigation/points'),
//		'chat'=>array('LAST'=>false,'CURRENT'=>false,'URL'=>'_SEARCH:chat','CAPTION'=>do_lang('SHORT_SECTION_CHAT'),'IMG'=>'menu_items/forum_navigation/chat'),
//		'staff'=>array('LAST'=>false,'CURRENT'=>false,'URL'=>'_SEARCH:staff','CAPTION'=>do_lang('STAFF'),'IMG'=>'menu_items/forum_navigation/staff'),
		'vforums'=>array('LAST'=>false,'CURRENT'=>false,'URL'=>'_SEARCH:vforums:unread','CAPTION'=>do_lang('SHORT_TOPICS_UNREAD'),'TOOLTIP'=>do_lang('TOPICS_UNREAD'),'IMG'=>'menu_items/forum_navigation/unread_topics'),
	);

	if (addon_installed('recommend'))
	{
		require_lang('recommend');
		$sections['recommend']=array('LAST'=>true,'CURRENT'=>false,'URL'=>'_SEARCH:recommend','CAPTION'=>do_lang('SHORT_RECOMMEND_SITE'),'IMG'=>'menu_items/forum_navigation/recommend');
	}

	$items=array();

	$i=1;
	foreach ($sections as $section)
	{
		$items[]=array('id'=>$i,'i_parent'=>NULL,'cap'=>$section['CAPTION'],'i_url'=>$section['URL'],'i_theme_img_code'=>$section['IMG'],'i_check_permissions'=>1,'i_expanded'=>0,'i_new_window'=>0,'i_page_only'=>'','i_caption_long'=>array_key_exists('TOOLTIP',$section)?$section['TOOLTIP']:'');
		$i++;
	}

	return $items;
}

/**
 * Build zone menu.
 *
 * @return array			Faked database rows
 */
function build_zone_menu()
{
	$_zones=find_all_zones(false,true);
	$zones=array();
	$zones2=array();
	// Some adhoc reordering
	$zone_reorder_list=array('welcome','site','forum','collaboration','cms','adminzone','docs');
	foreach ($zone_reorder_list as $zone_reorder)
	{
		foreach ($_zones as $i=>$_zone)
		{
			list($zone,,)=$_zone;
			if ($zone==$zone_reorder)
			{
				$zones[]=$_zone;
				unset($_zones[$i]);
				break;
			}
		}
	}
	if (count($_zones)<40) // If not huge numbers of zones show all, otherwise will just leave the main ones
	{
		$zones=array_merge($zones,$_zones);
	}
	$items=array();

	$i=1;
	foreach ($zones as $_zone)
	{
		list($zone,$title,$display_in_menu)=$_zone;
		if ((has_zone_access(get_member(),$zone)) && ($display_in_menu==1))
		{
			$items[]=array('id'=>$i,'i_parent'=>NULL,'cap'=>escape_html($title),'i_url'=>$zone.':','i_check_permissions'=>0,'i_expanded'=>0,'i_new_window'=>0,'i_page_only'=>'');
		}
		$i++;
	}

	return $items;
}

/**
 * Take a stored menu identifier, and return an XHTML menu created from it.
 *
 * @param  ID_TEXT		The type of the menu (determines which templates to use)
 * @param  SHORT_TEXT	The menu identifier to use
 * @param  boolean		Whether to silently return blank if the menu does not exist
 * @return tempcode		The generated tempcode of the menu
 */
function build_stored_menu($type,$menu,$silent_failure=false)
{
	if (($menu=='admin_ocf') && (get_forum_type()!='ocf')) return $silent_failure?new ocp_tempcode():make_string_tempcode('NA_EM');

	if ($menu=='_bookmarks')
	{
		require_code('menus_bookmarks');
		$items=build_bookmarks_menu();
	}
	elseif ($menu=='_management')
	{
		$items=build_management_menu();
	}
	elseif ($menu=='_community')
	{
		$items=build_community_menu();
		if (count($items)==0) return new ocp_tempcode();
	}
	elseif ($menu=='_zone_menu')
	{
		$items=build_zone_menu();
	}
	elseif (substr($menu,0,3)=='!!!')
	{
		require_code('menus_sitemap');
		$parts=explode(':',substr($menu,3));
		$items=build_sitetree_menu($parts);
	} else
	{
		$items=persistant_cache_get(array('MENU',$menu));
		if (is_null($items))
		{
			$items=$GLOBALS['SITE_DB']->query_select('menu_items',array('id','i_caption_long','i_new_window','i_expanded','i_parent','i_caption','i_url','i_check_permissions','i_page_only','i_theme_img_code'),array('i_menu'=>$menu),'ORDER BY i_order');
			foreach ($items as $i=>$item)
			{
				$items[$i]['cap']=get_translated_text($item['i_caption']);
				$items[$i]['i_caption_long']=get_translated_text($item['i_caption_long']);
			}
			persistant_cache_set(array('MENU',$menu),$items);
		}
	}

	if ((count($items)==0) && (substr($menu,0,1)!='_') && (substr($menu,0,3)!='!!!'))
	{
		if ($silent_failure) return new ocp_tempcode();
		$redirect=get_self_url(true,true);
		$_add_url=build_url(array('page'=>'admin_menus','type'=>'edit','id'=>$menu,'redirect'=>$redirect,'wide'=>1),'adminzone');
		$add_url=$_add_url->evaluate();
		return do_template('INLINE_WIP_MESSAGE',array('MESSAGE'=>do_lang_tempcode('MISSING_MENU',escape_html($menu),escape_html($add_url))));
	}

	$i=0;
	$root=array(
		'type'=>'root',
		'caption'=>$type,
		'special'=>$menu,
		'children'=>array(),
		'only_on_page'=>NULL,
		'modifiers'=>array()
		);

	for ($i=0;$i<count($items);$i++)
	{
		if (array_key_exists($i,$items))
		{
			$item=$items[$i];

			// Search for children
			if (is_null($item['i_parent']))
			{
				$new_kids_on_the_block=build_stored_menu_branch($item,$items);

				// HACKHACK: Cleaner way preferable, but needs new DB field!
				if ((array_key_exists('i_caption_long',$item)) && (substr($item['i_caption_long'],0,3)=='!!!'))
				{
					$new_kids_on_the_block['caption_long']='';
				}
				// HACKHACK: Cleaner way preferable, but needs new DB field!
				if ((array_key_exists('i_caption_long',$item)) && (substr($item['i_caption_long'],0,2)=='@@'))
				{
					$new_kids_on_the_block['caption_long']='';
				}

				$root['children'][]=$new_kids_on_the_block;
			}
		}
	}

	$content=render_menu($root,NULL,$type,true);
	if (($menu[0]!='_') && (substr($menu,0,3)!='!!!') && (has_actual_page_access(get_member(),'admin_menus')))
	{
		$redirect=get_self_url(true,true);
		$url=build_url(array('page'=>'admin_menus','type'=>'edit','id'=>$root['special'],'redirect'=>$redirect,'wide'=>1,'clickable_sections'=>(($type=='popup') || ($type=='dropdown'))?1:0),'adminzone');
		$content->attach(do_template('MENU_STAFF_LINK',array('_GUID'=>'a5209ec65425bed1207e2f667d9116f6','TYPE'=>$type,'EDIT_URL'=>$url,'NAME'=>$menu)));
	}

	return $content;
}

/**
 * Build a menu branch map from a database row.
 *
 * @param  array			The database row
 * @param  array			List of all the database rows for this menu
 * @return array			The menu branch map
 */
function build_stored_menu_branch($thisitem,$items)
{
	$i=0;
	$branch=array(
		'type'=>'link',
		'caption'=>$thisitem['cap'],
		'special'=>NULL,
		'children'=>array(),
		'only_on_page'=>NULL,
		'modifiers'=>array(),
		'caption_long'=>array_key_exists('i_caption_long',$thisitem)?$thisitem['i_caption_long']:'',
		'img'=>array_key_exists('i_theme_img_code',$thisitem)?$thisitem['i_theme_img_code']:'',
	);

	// HACKHACK: Cleaner way preferable, but needs new DB field!
	if ((array_key_exists('i_caption_long',$thisitem)) && (substr($thisitem['i_caption_long'],0,3)=='!!!'))
	{
		require_code('menus_sitemap');
		$extra=build_sitetree_menu(explode(':',substr($thisitem['i_caption_long'],3)));

		foreach ($extra as $e)
		{
			if (strpos($thisitem['i_url'],':root')!==false) $e['i_url'].=substr($thisitem['i_url'],strpos($thisitem['i_url'],':root'));
			elseif (strpos($thisitem['i_url'],':keep_')!==false) $e['i_url'].=substr($thisitem['i_url'],strpos($thisitem['i_url'],':keep_'));
			if (is_null($e['i_parent']))
				$e['i_parent']=$thisitem['id'];
			$items[]=$e;
		}
	}
	// HACKHACK: Cleaner way preferable, but needs new DB field!
	if ((array_key_exists('i_caption_long',$thisitem)) && (substr($thisitem['i_caption_long'],0,2)=='@@'))
	{
		$bits=explode('@@',$thisitem['i_caption_long']);
		$extra=array();
		foreach ($bits as $bit)
		{
			if ($bit=='') continue;

			$_extra=persistant_cache_get(array('MENU',$bit));
			if (is_null($_extra))
			{
				$_extra=$GLOBALS['SITE_DB']->query_select('menu_items',array('id','i_caption_long AS _i_caption_long','i_new_window','i_expanded','i_parent','i_caption AS _cap','i_url','i_check_permissions','i_page_only','i_theme_img_code'),array('i_menu'=>$bit),'ORDER BY i_order');
				foreach ($_extra as $i=>$_e)
				{
					$_extra[$i]['cap']=get_translated_text($_e['_cap']);
					$_extra[$i]['i_caption_long']=get_translated_text($_e['_i_caption_long']);
				}
				persistant_cache_set(array('MENU',$bit),$_extra);
			}

			$extra=array_merge($extra,$_extra);
		}

		foreach ($extra as $e)
		{
			if (strpos($thisitem['i_url'],':root')!==false) $e['i_url'].=substr($thisitem['i_url'],strpos($thisitem['i_url'],':root'));
			elseif (strpos($thisitem['i_url'],':keep_')!==false) $e['i_url'].=substr($thisitem['i_url'],strpos($thisitem['i_url'],':keep_'));
			if (is_null($e['i_parent']))
				$e['i_parent']=$thisitem['id'];
			$items[]=$e;
		}
	}

	foreach ($items as $item)
	{
		if ($item['i_parent']==$thisitem['id'])
		{
			$branch['type']='drawer';
			break;
		}
	}
	if ($branch['caption']=='')
	{
		$branch['type']='blank';
	} else
	{
		if ($branch['type']=='drawer')
		{
			if ($thisitem['i_expanded']==1) $branch['modifiers']['expanded']=1;

			for ($i=0;$i<count($items);$i++)
			{
				if (array_key_exists($i,$items))
				{
					$item=$items[$i];

					// Search for children
					if (($item['i_parent']==$thisitem['id']) && ($item['id']!=$thisitem['id'])/*Don't let DB errors cause crashes*/)
					{
						$new_kids_on_the_block=build_stored_menu_branch($item,$items);
						$branch['children'][]=$new_kids_on_the_block;
					}
				}
			}
		}

		$branch['only_on_page']=$thisitem['i_page_only'];
		if ($thisitem['i_new_window']==1) $branch['modifiers']['new_window']=1;
		if ($thisitem['i_check_permissions']==1) $branch['modifiers']['check_perms']=1;
		if ((array_key_exists('i_popup',$thisitem)) && ($thisitem['i_popup']==1))
		{
			$branch['modifiers']['popup']=1;
			$branch['width']=$thisitem['i_width'];
			$branch['height']=$thisitem['i_height'];
		}
		$branch['special']=$thisitem['i_url'];
	}
	return $branch;
}

/*
Menu branch structure:
	type[string]=root|drawer|page|blank
	caption[string] (is menu type for root)
	special[string] (for root is menu name, for link is url)
	children[array of menus]
	modifiers (special modifier codes that indicate things: ~->new_window, +->expanded, (-->nothing), ?->check_perms)
	only_to_page[string]
*/

/**
 * Render a stored menu to tempcode.
 *
 * @param  array			Menu details
 * @param  ?MEMBER		The member the menu is being built as (NULL: current member)
 * @param  ID_TEXT		The menu type (determines what templates get used)
 * @param  boolean		Whether to generate Comcode with admin privilege
 * @return tempcode		The generated tempcode of the menu
 */
function render_menu($menu,$source_member,$type,$as_admin=false)
{
	if (is_null($source_member)) $source_member=get_member();

	$content=new ocp_tempcode();

	if ((!isset($menu['type'])) || ($menu['type']!='root')) fatal_exit(do_lang_tempcode('INTERNAL_ERROR'));

	$codename=$menu['special'];

	// A bit of a hack to calculate the true number of rendered items...
	$new_children=array();
	foreach ($menu['children'] as $child)
	{
		$branch=render_menu_branch($child,$codename,$source_member,0,$type,$as_admin,$menu['children'],1);

		if (!is_null($branch[0]))
		{
			$new_children[]=$branch[0];
		}
	}
	$num=count($new_children);
	foreach ($new_children as $i=>$child)
	{
		if (is_object($child))
		{
			$content->attach($child);
		} else
		{
			$content->attach(do_template('MENU_BRANCH_'.filter_naughty_harsh($type),$child+array(
				'POSITION'=>strval($i),
				'LAST'=>$i==$num-1,
				'BRETHREN_COUNT'=>strval($num),
			),NULL,false,'MENU_BRANCH_tree'));
		}
	}

	return do_template('MENU_'.filter_naughty_harsh($type),array('CONTENT'=>$content,'MENU'=>$menu['special']),NULL,false,'MENU_tree');
}

/**
 * Render a menu branch to tempcode.
 *
 * @param  array			The menu branch map
 * @param  SHORT_TEXT	An identifier for the menu (will be used as a unique id by menu javascript code)
 * @param  MEMBER			The member the menu is being built as
 * @param  integer		The depth into the menu that this branch resides at
 * @param  ID_TEXT		The menu type (determines what templates get used)
 * @param  boolean		Whether to generate Comcode with admin privilege
 * @param  array			Array of all other branches
 * @param  integer		The level
 * @return array			A pair: array of parameters of the menu branch (or NULL if unrenderable, or Tempcode of something to attach), and whether it is expanded
 */
function render_menu_branch($branch,$codename,$source_member,$level,$type,$as_admin,$all_branches,$the_level=1)
{
	global $REDIRECTED_TO;

	$caption=mixed(); // Initialise type to mixed
	if ((is_string($branch['caption'])) && (strpos($branch['caption'],'[')!==false))
	{
		$caption=comcode_to_tempcode($branch['caption'],$source_member,$as_admin);
	} else $caption=$branch['caption'];

	if ((!is_null($branch['only_on_page'])) && ($branch['only_on_page']!=''))
	{
		if (strpos($branch['only_on_page'],'{')!==false)
		{
			require_code('tempcode_compiler');
			$branch['only_on_page']=static_evaluate_tempcode(template_to_tempcode($branch['only_on_page']));
		}
		if (($branch['only_on_page']!='') && (!match_key_match($branch['only_on_page'])))
			return array(NULL,false); // We are not allowed to render this on this page
	}

	$current_zone=false;
	$current_page=false;
	$expand_this=false;
	$tooltip=array_key_exists('caption_long',$branch)?$branch['caption_long']:'';
	if (is_null($tooltip)) $tooltip=''; // Caused by corrupt in DB. translate table join failed due to corrupt lang string reference
	$dp=$GLOBALS['ZONE']['zone_default_page'];
	$url=mixed();

	// Spacers
	if ($branch['type']=='blank')
	{
		return array(
			do_template(
				'MENU_SPACER_'.filter_naughty_harsh($type),
				array(
					// Useful contextual information
					'MENU'=>$codename,
					'TOP_LEVEL'=>$the_level==1,
					'THE_LEVEL'=>strval($the_level),

					// Hints for current-page rendering
					'CURRENT'=>$current_page,
					'CURRENT_ZONE'=>$current_zone,
				),
				NULL,
				false,
				'MENU_SPACER_tree'
			),
			false
		);
	}

	// Normal branches...

	$users_current_zone=get_zone_name();

	// Work out the final URL to use
	$url=$branch['special'];
	if (is_object($url)) // Try and convert it to a page-link, if we can
	{
		if ((isset($url->seq_parts)) && (isset($url->seq_parts[0])) && ($url->seq_parts[0][3]=='PAGE_LINK'))
		{
			$url=$url->seq_parts[0][1][0];
			if (is_object($url)) $url=$url->evaluate();
		} elseif ((isset($url->bits)) && (isset($url->bits[0])) && ($url->bits[0][2]=='PAGE_LINK'))
		{
			$url=$url->bits[0][3][0];
			if (is_object($url)) $url=$url->evaluate();
		} elseif (substr($url->evaluate(),0,strlen(get_base_url()))==get_base_url())
		{
			$page_link=url_to_pagelink($url->evaluate(),true,true);
			if ($page_link!='') $url=$page_link;
		}
	}
	if (!is_object($url))
	{
		$parts=array();
		if ((preg_match('#^([\w-]*):([\w-]+|[^/]|$)((:(.*))*)#',$url,$parts)!=0) && ($parts[1]!='mailto')) // Specially encoded page link. Complex regexp to make sure URLs do not match
		{
			$page_link=$url;
			list($zone_name,$map,$hash)=page_link_decode($url);
			if (($zone_name=='forum') && (get_forum_type()!='ocf')) return array(NULL,false);
			if (!isset($map['page'])) $map['page']=get_zone_default_page($zone_name);

			// If we need to check access
			if (array_key_exists('check_perms',$branch['modifiers']))
			{
				if (!has_zone_access(get_member(),$zone_name)) return array(NULL,false);
				if (!has_page_access(get_member(),$map['page'],$zone_name)) return array(NULL,false);
			}

			// Scan for Tempcode symbols etc
			foreach ($map as $key=>$val)
			{
				if (strpos($val,'{')!==false)
				{
					require_code('tempcode_compiler');
					$map[$key]=template_to_tempcode($val);
				}
			}

			$url=build_url($map,$zone_name,NULL,false,false,false,$hash);

			// See if this is current page
			$somewhere_definite=false;
			$_parts=array();
			foreach ($all_branches as $_branch)
			{
				if (!is_string($_branch['special'])) continue;

				if (preg_match('#([\w-]*):([\w-]+|[^/]|$)((:(.*))*)#',$_branch['special'],$_parts)!=0)
				{
					if ($_parts[1]==$users_current_zone) $somewhere_definite=true;
				}
			}
			$current_zone=(($zone_name==$users_current_zone) || ((!is_null($REDIRECTED_TO)) && ($zone_name==$REDIRECTED_TO['r_to_zone']) && (!$somewhere_definite))); // This code is a bit smart, as zone menus usually have a small number of zones on them - redirects will be counted into the zone redirected to, so long as there is no more suitable zone and so long as it is not a transparent redirect
			if (($zone_name==$users_current_zone) || ((!is_null($REDIRECTED_TO)) && ($zone_name==$REDIRECTED_TO['r_to_zone']) && (array_key_exists('page',$map)) && ($map['page']==$REDIRECTED_TO['r_to_page'])))
			{
				$current_page=true;
				foreach ($map as $k=>$v)
				{
					if (is_integer($v)) $v=strval($v);
					if (is_object($v)) $v=$v->evaluate();
					if (($v=='') && ($k=='page'))
					{
						$v='start';
						if ($zone_name==$users_current_zone) // More precision if current zone (don't want to do query for any zone)
						{
							global $ZONE;
							$v=$ZONE['zone_default_page'];
						}
					}
					$pv=get_param($k,($k=='page')?$dp:NULL,true);
					if (($pv!==$v) && (($k!='page') || (is_null($REDIRECTED_TO)) || ((!is_null($REDIRECTED_TO)) && (($v!==$REDIRECTED_TO['r_to_page']) || ($zone_name!=$REDIRECTED_TO['r_to_zone'])))) && (($k!='type') || ($v!='misc')) && (($v!=$dp) || ($k!='page') || (get_param('page','')!='')) && (substr($k,0,5)!='keep_'))
					{
						$current_page=false;
						break;
					}
				}
			}
		} else // URL, not page-link
		{
			$page_link='';

			$sym_pos=mixed();
			$sym_pos=is_null($url)?false:strpos($url,'{$');
			if ($sym_pos!==false) // Specially encoded $ symbols
			{
				$_url=new ocp_tempcode();
				$len=strlen($url);
				$prev=0;
				do
				{
					$p_len=$sym_pos+1;
					$balance=1;
					while (($p_len<$len) && ($balance!=0))
					{
						if ($url[$p_len]=='{') $balance++; elseif ($url[$p_len]=='}') $balance--;
						$p_len++;
					}

					$_url->attach(substr($url,$prev,$sym_pos-$prev));
					$_ret=new ocp_tempcode();
					$_ret->parse_from($url,$sym_pos,$p_len);
					$_url->attach($_ret);
					$prev=$p_len;
					$sym_pos=strpos($url,'{$',$sym_pos+1);
				}
				while ($sym_pos!==false);
				$_url->attach(substr($url,$prev));
				$url=$_url;
			}
		}
	} else
	{
		$page_link=NULL;
	}

	// Children
	$children=new ocp_tempcode();
	$display='block';
	if ($branch['type']=='drawer')
	{
		$new_children=array();
		foreach ($branch['children'] as $i=>$child)
		{
			list($children2,$_expand_this)=render_menu_branch($child,$codename,$source_member,$level+1,$type,$as_admin,$all_branches,$the_level+1);
			if ($_expand_this) $expand_this=true;
			if (($children2!=='') && (!is_null($children2)))
			{
				$new_children[]=$children2;
			}
		}
		$num=count($new_children);
		foreach ($new_children as $i=>$child)
		{
			if (is_object($child))
			{
				$children->attach($child);
			} else
			{
				$children->attach(do_template('MENU_BRANCH_'.filter_naughty_harsh($type),$child+array(
					'POSITION'=>strval($i),
					'LAST'=>$i==$num-1,
					'BRETHREN_COUNT'=>strval($num),
				),NULL,false,'MENU_BRANCH_tree'));
			}
		}
		if ($children->is_empty() && (is_string($url) && $url == '' || is_object($url) && $url->is_empty())) return array(NULL,false); // Nothing here!
		if ((!array_key_exists('expanded',$branch['modifiers'])) && (!$expand_this) && (!$current_page))
		{
			$display=has_js()?'none':'block'; // We remap to 'none' using JS. If no JS, it remains visible. Once we have learn't we have JS, we don't need to do it again
		} else $display='block';
	}

	// Data cleanups
	$escape=(is_string($caption)) && (!array_key_exists('comcode',$branch['modifiers']));
	if ($escape) $caption=escape_html($caption);

	// Access key
	if ($page_link==='_SEARCH:help') $accesskey='6';
	elseif ($page_link==='_SEARCH:rules') $accesskey='7';
	elseif ($page_link==='_SEARCH:staff:type=misc') $accesskey='5';
	else $accesskey='';

	// Other properties
	$popup=array_key_exists('popup',$branch['modifiers']);
	$popup_width='';
	$popup_height='';
	if ($popup)
	{
		$popup_width=strval($branch['width']);
		$popup_height=strval($branch['height']);
	}
	$new_window=array_key_exists('new_window',$branch['modifiers']);

	// Render!
	$rendered_branch=array(
		// Useful
		'RANDOM'=>substr(md5(uniqid('')),0,7),

		// Basic properties
		'CAPTION'=>$caption,
		'IMG'=>array_key_exists('img',$branch)?$branch['img']:'',

		// Link properties
		'URL'=>$url,'PAGE_LINK'=>$page_link,
		'ACCESSKEY'=>$accesskey,
		'POPUP'=>$popup,
		'POPUP_WIDTH'=>$popup_width,
		'POPUP_HEIGHT'=>$popup_height,
		'NEW_WINDOW'=>$new_window,
		'TOOLTIP'=>$tooltip,

		// To do with children
		'CHILDREN'=>$children,
		'DISPLAY'=>$display,

		// Useful contextual information
		'MENU'=>$codename,
		'TOP_LEVEL'=>$the_level==1,
		'THE_LEVEL'=>strval($the_level),

		// Hints for current-page rendering
		'CURRENT'=>$current_page,
		'CURRENT_ZONE'=>$current_zone,
	);

	return array($rendered_branch,$current_page || $expand_this);
}

/**
 * Find the number of icons the member of staff has.
 *
 * @return integer			The count
 */
function num_staff_icons()
{
	$allowed_icons=0;

	require_all_lang();
	load_up_all_self_page_permissions(get_member());

	$hooks=find_all_hooks('systems','do_next_menus');
	foreach ($hooks as $hook=>$sources_dir)
	{
		$run_function=extract_module_functions(get_file_base().'/'.$sources_dir.'/hooks/systems/do_next_menus/'.$hook.'.php',array('run'));
		if (!is_null($run_function[0]))
		{
			$info=is_array($run_function[0])?call_user_func_array($run_function[0][0],$run_function[0][1]):eval($run_function[0]);

			foreach ($info as $i)
			{
				if (is_null($i)) continue;
				if ($i[0]=='') continue;

				if (has_actual_page_access(get_member(),$i[2][0],$i[2][2])) $allowed_icons++;
			}
		}
	}

	return $allowed_icons;
}

