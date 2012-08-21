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
 * @package		core_ocf
 */

/**
 * Get a nice list for selection from the forum groupings.
 *
 * @param  ?AUTO_LINK	Category to avoid putting in the list (NULL: don't avoid any).
 * @param  ?AUTO_LINK	Category selected by default (NULL: no specific default).
 * @return tempcode		The list.
 */
function ocf_nice_get_forum_groupings($avoid=NULL,$it=NULL)
{
	$_m=$GLOBALS['FORUM_DB']->query_select('f_forum_groupings',array('*'));
	$entries=new ocp_tempcode();
	foreach ($_m as $m)
	{
		if ($m['id']!==$avoid) $entries->attach(form_input_list_entry(strval($m['id']),$it===$m['id'],$m['c_title']));
	}

	return $entries;
}

/**
 * Get a nice, formatted XHTML list of topics, in forum tree structure
 *
 * @param  ?AUTO_LINK	The currently selected topic (NULL: none selected)
 * @return tempcode		The list of topics
 */
function ocf_nice_get_topic_tree($it=NULL)
{
	$tree=ocf_get_topic_tree();

	$out=''; // XHTMLXHTML
	foreach ($tree as $forum)
	{
		foreach ($forum['entries'] as $topic_id=>$ttitle)
		{
			$selected=($topic_id==$it);
			$line=do_template('OCF_FORUM_TOPIC_LIST_LINE',array('_GUID'=>'d58e4176ef0efefa85c83a8b9fa2de51','PRE'=>$forum['breadcrumbs'],'TOPIC_TITLE'=>$ttitle));
			$out.='<option value="'.strval($topic_id).'"'.($selected?'selected="selected"':'').'>'.$line->evaluate().'</option>';
		}
	}

	if ($GLOBALS['XSS_DETECT']) ocp_mark_as_escaped($out);

	return make_string_tempcode($out);
}

/**
 * Get a list of maps containing all the topics, and path information, under the specified forum - and those beneath it, recursively.
 *
 * @param  ?AUTO_LINK	The forum being at the root of our recursion (NULL: true root forum)
 * @param  ?string		The breadcrumbs up to this point in the recursion (NULL: blank, as we are starting the recursion)
 * @param  ?ID_TEXT		The forum name of the $forum_id we are currently going through (NULL: look it up). This is here for efficiency reasons, as finding children IDs to recurse to also reveals the childs title
 * @param  ?integer		The number of recursive levels to search (NULL: all)
 * @return array			A list of maps for all forums. Each map entry containins the fields 'id' (forum ID) and 'breadcrumbs' (path to the forum, including the forums own title), and more.
 */
function ocf_get_topic_tree($forum_id=NULL,$breadcrumbs=NULL,$title=NULL,$levels=NULL)
{
	if (is_null($forum_id)) $forum_id=db_get_first_id();
	if (is_null($breadcrumbs)) $breadcrumbs='';

	if (!has_category_access(get_member(),'forums',strval($forum_id))) return array();

	// Put our title onto our breadcrumbs
	if (is_null($title)) $title=$GLOBALS['FORUM_DB']->query_select_value('f_forums','f_name',array('id'=>$forum_id));
	$breadcrumbs.=$title;

	// We'll be putting all children in this entire tree into a single list
	$children=array();
	$children[0]=array();
	$children[0]['id']=$forum_id;
	$children[0]['title']=$title;
	$children[0]['breadcrumbs']=$breadcrumbs;

	// Children of this forum
	$rows=$GLOBALS['FORUM_DB']->query_select('f_forums',array('id','f_name'),array('f_parent_forum'=>$forum_id),'ORDER BY f_forum_grouping_id,f_position',200);
	if (count($rows)==200) $rows=array(); // Too many, this method will suck
	$tmap=array('t_forum_id'=>$forum_id);
	if (!has_privilege(get_member(),'see_unvalidated')) $tmap['t_validated']=1;
	$children[0]['entries']=collapse_2d_complexity('id','t_cache_first_title',$GLOBALS['FORUM_DB']->query_select('f_topics',array('id','t_cache_first_title'),$tmap,'ORDER BY t_cache_first_time DESC',12));
	$children[0]['child_entry_count']=count($children[0]['entries']);
	if ($levels===0) // We throw them away now because they're not on the desired level
	{
		$children[0]['entries']=array();
	}
	$children[0]['child_count']=count($rows);
	$breadcrumbs.=' > ';
	if ($levels!==0)
	{
		foreach ($rows as $child)
		{
			$child_id=$child['id'];
			$child_title=$child['f_name'];
			$child_breadcrumbs=$breadcrumbs;

			$child_children=ocf_get_topic_tree($child_id,$child_breadcrumbs,$child_title,is_null($levels)?NULL:max(0,$levels-1));

			$children=array_merge($children,$child_children);
		}
	}

	return $children;
}

/**
 * Generate a tempcode tree based selection list (ala nice_get_*) for choosing a forum OR a map of details. Also capable of getting comma-separated ancester forum lists. Also capable of displaying topic lists in the tree. In other words... this function is incredibly powerful, and complex.
 *
 * @param  ?MEMBER		The member that the view privileges are done for (NULL: current member).
 * @param  ?AUTO_LINK	The forum we are starting from (NULL: capture the whole tree).
 * @param  boolean		Whether to get a tempcode list (as opposed to a list of maps).
 * @param  ?array			The forum(s) to select by default (NULL: no preference). Only applies if !$topics_too. An array of AUTO_LINK's (for IDs) or strings (for names).
 * @param  string			The breadcrumbs at this point of the recursion (blank for the start).
 * @param  ?AUTO_LINK	ID of a forum to skip display/recursion for (NULL: none).
 * @param  ?boolean		Whether the child forums are ordered alphabetically (NULL: find from DB).
 * @param  boolean		Whether to generate a compound list (a list of all the ancesters, for each point in the forum tree) as well as the tree.
 * @param  ?integer		The number of recursive levels to search (NULL: all)
 * @param  boolean		Whether to generate tree statistics.
 * @return mixed			Each tempcode of the tree if $field_format or else a list of maps, OR (if $use_compound_list) a pair of the tempcode and the compound list.
 */
function ocf_get_forum_tree_secure($member_id=NULL,$base_forum=NULL,$field_format=false,$selected_forum=NULL,$breadcrumbs='',$skip=NULL,$order_sub_alpha=NULL,$use_compound_list=false,$levels=NULL,$do_stats=false)
{
	if (($levels==-1) && (!$use_compound_list)) return $use_compound_list?array(array(),''):array();

	global $FORUM_TREE_SECURE_CACHE;

	if (is_null($member_id)) $member_id=get_member();
	if (is_null($order_sub_alpha))
	{
		if (is_null($base_forum)) $order_sub_alpha=false;
		else $order_sub_alpha=$GLOBALS['FORUM_DB']->query_select_value('f_forums','f_order_sub_alpha',array('id'=>$base_forum));
	}

	$out=array();
	$order=$order_sub_alpha?'f_name':'f_position,id';
	$forums=array();
	if (is_null($FORUM_TREE_SECURE_CACHE))
	{
		$FORUM_TREE_SECURE_CACHE=mixed();
		$num_forums=$GLOBALS['FORUM_DB']->query_select_value('f_forums','COUNT(*)');
		$FORUM_TREE_SECURE_CACHE=($num_forums>=300); // Mark it as 'huge'
	}
	if ($FORUM_TREE_SECURE_CACHE===true)
	{
		$forums=$GLOBALS['FORUM_DB']->query('SELECT id,f_order_sub_alpha,f_name,f_forum_grouping_id,f_parent_forum,f_position FROM '.$GLOBALS['FORUM_DB']->get_table_prefix().'f_forums WHERE id IS NOT NULL AND '.db_string_equal_to('f_redirection','').' AND '.(is_null($base_forum)?'f_parent_forum IS NULL':('f_parent_forum='.strval($base_forum))).' ORDER BY f_position',200/*reasonable limit*/);
	} else
	{
		if ((is_null($FORUM_TREE_SECURE_CACHE)) || ($FORUM_TREE_SECURE_CACHE===false))
		{
			$FORUM_TREE_SECURE_CACHE=$GLOBALS['FORUM_DB']->query('SELECT id,f_order_sub_alpha,f_name,f_forum_grouping_id,f_parent_forum,f_position FROM '.$GLOBALS['FORUM_DB']->get_table_prefix().'f_forums WHERE id IS NOT NULL AND '.db_string_equal_to('f_redirection','').' ORDER BY f_position');
		}
		foreach ($FORUM_TREE_SECURE_CACHE as $x)
		{
			if ($x['f_parent_forum']===$base_forum) $forums[]=$x;
		}
	}
	sort_maps_by($forums,$order);
	$compound_list='';
	foreach ($forums as $forum)
	{
		$access=has_category_access($member_id,'forums',strval($forum['id']));
		$cat_sort_key='!'.(is_null($forum['f_forum_grouping_id'])?'':strval($forum['f_forum_grouping_id']));

		if (($access) && ($skip!==$forum['id']) && ($levels!==0))
		{
			$cat_bit='';
			if (!is_null($forum['f_forum_grouping_id']))
			{
				global $GROUPING_TITLES;
				if (is_null($GROUPING_TITLES))
				{
					$GROUPING_TITLES=collapse_2d_complexity('id','c_title',$GLOBALS['FORUM_DB']->query_select('f_forum_groupings',array('id','c_title')));
				}
				$cat_bit=array_key_exists($forum['f_forum_grouping_id'],$GROUPING_TITLES)?$GROUPING_TITLES[$forum['f_forum_grouping_id']]:do_lang('NA');
			}
			if ($field_format)
			{
				$pre=($breadcrumbs=='')?'':($breadcrumbs.' > ');
				$below=ocf_get_forum_tree_secure($member_id,$forum['id'],true,$selected_forum,$pre.$forum['f_name'],$skip,$forum['f_order_sub_alpha'],$use_compound_list,NULL,$do_stats);
				if ($use_compound_list)
				{
					list($below,$_compound_list)=$below;
					$compound_list.=strval($forum['id']).','.$_compound_list;
				}
				$selected=false;
				if (!is_null($selected_forum))
				{
					foreach ($selected_forum as $s)
					{
						if ((is_integer($s)) && ($s==$forum['id'])) $selected=true;
						if ((is_string($s)) && ($s==$forum['f_name'])) $selected=true;
					}
				}
				$line=do_template('OCF_FORUM_LIST_LINE',array('_GUID'=>'2fb4bd9ed5c875de6155bef588c877f9','PRE'=>$pre,'NAME'=>$forum['f_name'],'CAT_BIT'=>$cat_bit));
				if (!array_key_exists($cat_sort_key,$out))
				{
					$out[$cat_sort_key]='';
				}

				$out[$cat_sort_key].='<option value="'.(!$use_compound_list?strval($forum['id']):(strval($forum['id']).','.$_compound_list)).'"'.($selected?' selected="selected"':'').'>'.$line->evaluate().'</option>';
				if ($levels!==0)
				$out[$cat_sort_key].=$below->evaluate();
			} else
			{
				if ($use_compound_list)
				{
					$below=ocf_get_forum_tree_secure($member_id,$forum['id'],true,$selected_forum,$forum['f_name'],$skip,$forum['f_order_sub_alpha'],$use_compound_list,NULL,$do_stats);
					list($below,$_compound_list)=$below;
					$compound_list.=strval($forum['id']).','.$_compound_list;
				}
				$element=array('id'=>$forum['id'],'compound_list'=>(!$use_compound_list?strval($forum['id']):(strval($forum['id']).','.$_compound_list)),'second_cat'=>$cat_bit,'title'=>$forum['f_name'],'group'=>$forum['f_forum_grouping_id'],'children'=>ocf_get_forum_tree_secure($member_id,$forum['id'],false,$selected_forum,$breadcrumbs,$skip,false,false,$levels,$do_stats));
				if ($do_stats)
				{
					$element['child_count']=$GLOBALS['FORUM_DB']->query_select_value('f_forums','COUNT(*)',array('f_parent_forum'=>$forum['id']));
				}
				if (!array_key_exists($cat_sort_key,$out))
				{
					$out[$cat_sort_key]=array();
				}
				$out[$cat_sort_key][]=$element;
			}
		}
	}

	// Up to now we worked into an array, so we could benefit from how it would auto-sort into the grouping>forum-position ordering ocPortal uses. Now we need to unzip it
	$real_out=mixed();
	if ($field_format)
	{
		$real_out='';
		foreach ($out as $str)
		{
			$real_out.=$str;
		}
	} else
	{
		$real_out=array();
		foreach ($out as $arr)
		{
			$real_out=array_merge($real_out,$arr);
		}
	}

	if ($field_format)
	{
		if ($GLOBALS['XSS_DETECT']) ocp_mark_as_escaped($real_out);
		$real_out=make_string_tempcode($real_out);
	}

	if ($use_compound_list) return array($real_out,$compound_list); else return $real_out;
}
