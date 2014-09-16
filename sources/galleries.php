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
 * @package		galleries
 */

/**
 * Standard code module initialisation function.
 */
function init__galleries()
{
	global $GALLERY_ENTRIES_CATS_USED;
	$GALLERY_ENTRIES_CATS_USED=NULL;
	global $GALLERY_PAIRS;
	$GALLERY_PAIRS=NULL;
	global $PT_PAIR_CACHE_G;
	$PT_PAIR_CACHE_G=array();
}

/**
 * Render an image box.
 *
 * @param  array			The video row
 * @param  ID_TEXT		The zone the galleries module is in
 * @return tempcode		The rendered box
 */
function render_image_box($row,$zone='_SEARCH')
{
	require_css('galleries');

	require_code('images');
	$url=build_url(array('page'=>'galleries','type'=>'image','id'=>$row['id']),$zone);
	$thumb_url=ensure_thumbnail($row['url'],$row['thumb_url'],'galleries','images',$row['id']);
	$description=get_translated_tempcode($row['comments']);
	$thumb=do_image_thumb($thumb_url,$description,true);
	$breadcrumbs=gallery_breadcrumbs($row['cat'],'root',false,$zone);

	$image_url=$row['url'];
	if (url_is_local($image_url)) $image_url=get_custom_base_url().'/'.$image_url;

	$title=$GLOBALS['SITE_DB']->query_value_null_ok('galleries','fullname',array('name'=>$row['cat']));
	if (is_null($title))
	{
		$gallery_title=do_lang('UNKNOWN');
	} else
	{
		$gallery_title=get_translated_text($title);
	}

	return do_template('GALLERY_IMAGE_BOX',array('ADD_DATE_RAW'=>strval($row['add_date']),'ID'=>strval($row['id']),'TITLE'=>get_translated_text($row['title']),'NOTES'=>$row['notes'],'GALLERY_TITLE'=>$gallery_title,'CAT'=>$row['cat'],'VIEWS'=>strval($row['image_views']),'BREADCRUMBS'=>$breadcrumbs,'URL'=>$url,'IMAGE_URL'=>$image_url,'DESCRIPTION'=>$description,'THUMB'=>$thumb,'THUMB_URL'=>$thumb_url));
}

/**
 * Render a video box.
 *
 * @param  array			The video row
 * @param  ID_TEXT		The zone the galleries module is in
 * @return tempcode		The rendered box
 */
function render_video_box($row,$zone='_SEARCH')
{
	require_css('galleries');

	require_code('images');
	$url=build_url(array('page'=>'galleries','type'=>'video','id'=>$row['id']),$zone);
	$thumb_url=ensure_thumbnail($row['url'],$row['thumb_url'],'galleries','videos',$row['id']);
	$description=get_translated_tempcode($row['comments']);
	$thumb=do_image_thumb($thumb_url,$description,true);
	$breadcrumbs=gallery_breadcrumbs($row['cat'],'root',false,$zone);

	$video_url=$row['url'];
	if (url_is_local($video_url)) $video_url=get_custom_base_url().'/'.$video_url;

	$title=$GLOBALS['SITE_DB']->query_value_null_ok('galleries','fullname',array('name'=>$row['cat']));
	if (is_null($title))
	{
		$gallery_title=do_lang('UNKNOWN');
	} else
	{
		$gallery_title=get_translated_text($title);
	}

	return do_template('GALLERY_VIDEO_BOX',array('ADD_DATE_RAW'=>strval($row['add_date']),'ID'=>strval($row['id']),'TITLE'=>get_translated_text($row['title']),'NOTES'=>$row['notes'],'GALLERY_TITLE'=>$gallery_title,'CAT'=>$row['cat'],'VIEWS'=>strval($row['video_views']),'BREADCRUMBS'=>$breadcrumbs,'URL'=>$url,'VIDEO_URL'=>$video_url,'DESCRIPTION'=>$description,'THUMB'=>$thumb,'THUMB_URL'=>$thumb_url,'VIDEO_WIDTH'=>strval($row['video_width']),'VIDEO_HEIGHT'=>strval($row['video_height']),'VIDEO_LENGTH'=>strval($row['video_length'])));
}

/**
 * Find the default number of images per page in the galleries.
 *
 * @return integer		Images per page
 */
function get_default_gallery_max()
{
	$option=get_option('gallery_selectors');
	if ($option=='') return 12;
	$selectors=explode(',',$option);
	return intval($selectors[0]);
}

/**
 * Find whether a certain gallery has any content (images, videos, or subgalleries).
 *
 * @param  ID_TEXT		The name of the gallery
 * @return boolean		The answer
 */
function gallery_has_content($name)
{
	$num_galleries=NULL;

	global $GALLERY_ENTRIES_CATS_USED;
	if (is_null($GALLERY_ENTRIES_CATS_USED))
	{
		$num_galleries=$GLOBALS['SITE_DB']->query_value('galleries','COUNT(*)');

		$GALLERY_ENTRIES_CATS_USED=array();
		$images_cats=$GLOBALS['SITE_DB']->query_select('images',array('DISTINCT cat'),($num_galleries<300)?array('validated'=>1):array('validated'=>1,'cat'=>$name));
		foreach ($images_cats as $images_cat)
			$GALLERY_ENTRIES_CATS_USED[$images_cat['cat']]=1;
		$videos_cats=$GLOBALS['SITE_DB']->query_select('videos',array('DISTINCT cat'),($num_galleries<300)?array('validated'=>1):array('validated'=>1,'cat'=>$name));
		foreach ($videos_cats as $videos_cat)
			$GALLERY_ENTRIES_CATS_USED[$videos_cat['cat']]=1;
	}
	if (array_key_exists($name,$GALLERY_ENTRIES_CATS_USED))
	{
		if ($num_galleries>=300) $GALLERY_ENTRIES_CATS_USED=NULL; // It's not right so reset it
		return true;
	}
	if ($num_galleries>=300) $GALLERY_ENTRIES_CATS_USED=NULL; // It's not right so reset it

	global $GALLERY_PAIRS;
	if (is_null($GALLERY_PAIRS))
	{
		if (is_null($num_galleries))
			$num_galleries=$GLOBALS['SITE_DB']->query_value('galleries','COUNT(*)');

		if ($num_galleries<300)
		{
			$GALLERY_PAIRS=collapse_2d_complexity('name','parent_id',$GLOBALS['SITE_DB']->query_select('galleries',array('name','parent_id')));
		} else
		{
			return !is_null($GLOBALS['SITE_DB']->query_value_null_ok('galleries','name',array('parent_id'=>$name)));
		}
	}
	foreach ($GALLERY_PAIRS as $_parent_id)
	{
		if ($_parent_id==$name) return true;
	}

	return false;
}

/**
 * Find the owner of a gallery.
 *
 * @param  ID_TEXT		The name of the gallery
 * @param  ?array			Gallery row (NULL: look it up)
 * @param  boolean		Only non-NULL if it is a personal gallery
 * @return ?MEMBER		The owner of the gallery (NULL: not a member owned gallery)
 */
function get_member_id_from_gallery_name($gallery_name,$row=NULL,$only_if_personal_gallery=false)
{
	$is_member=(substr($gallery_name,0,7)=='member_');
	if (!$is_member)
	{
		if ($only_if_personal_gallery) return NULL;

		if (is_null($row))
		{
			$rows=$GLOBALS['SITE_DB']->query_select('galleries',array('g_owner'),array('name'=>$gallery_name));
			if (!isset($rows[0])) warn_exit(do_lang_tempcode('MISSING_RESOURCE'));
			$row=$rows[0];
		}

		return $row['g_owner'];
	}
	return intval(substr($gallery_name,7,strpos($gallery_name,'_',7)-7));
}

/**
 * Get preview detailing for a video.
 *
 * @param  array			The database row of the video
 * @return tempcode		The preview
 */
function show_video_details($myrow)
{
	return do_template('GALLERY_VIDEO_INFO',array('HEIGHT'=>integer_format($myrow['video_height']),'WIDTH'=>integer_format($myrow['video_width']),'LENGTH'=>strval($myrow['video_length'])));
}

/**
 * Get preview detailing for a gallery.
 *
 * @param  array			The database row of the gallery
 * @param  ID_TEXT		The virtual root of the gallery
 * @param  boolean		Whether to show member stats if it is a member owned gallery
 * @param  ID_TEXT		The zone that the gallery module we are linking to is in
 * @param  boolean		Whether to not show anything if the gallery is empty
 * @param  boolean		Whether only to show 'preview' details
 * @return tempcode		The preview
 */
function show_gallery_box($child,$root='root',$show_member_stats_if_appropriate=false,$zone='_SEARCH',$quit_if_empty=true,$preview=false)
{
	$member_id=get_member_id_from_gallery_name($child['name'],$child,true);
	$url_map=array('page'=>'galleries','type'=>'misc','root'=>($root=='root')?NULL:$root,'id'=>$child['name']);
	if (get_page_name()=='galleries') $url_map+=propagate_ocselect();
	$url=build_url($url_map,$zone);
	$_title=get_translated_text($child['fullname']);
	$pic=$child['rep_image'];
	$is_member=!is_null($member_id);
	if (($pic=='') && ($is_member)) $pic=$GLOBALS['FORUM_DRIVER']->get_member_avatar_url($member_id);
	$add_date=get_timezoned_date($child['add_date'],false);
	$comments=get_translated_tempcode($child['description']);
	if ($show_member_stats_if_appropriate)
	{
		if (($is_member) && (get_forum_type()=='ocf'))
		{
			require_code('ocf_members');
			require_code('ocf_members2');
			$member_info=render_member_box($member_id,true);
		} else $member_info=new ocp_tempcode();
	} else $member_info=new ocp_tempcode();
	list($num_children,$num_images,$num_videos)=get_recursive_gallery_details($child['name']);
	if (($quit_if_empty) && ($num_images==0) && ($num_videos==0) && ($num_children==0)) return new ocp_tempcode();
	$thumb_order='ORDER BY id ASC';
	if (get_option('reverse_thumb_order')=='1') $thumb_order='ORDER BY id DESC';
	if ($pic=='')
	{
		$pic=$GLOBALS['SITE_DB']->query_value_null_ok('images','thumb_url',array('cat'=>$child['name'],'validated'=>1),$thumb_order);
		if ($pic==='')
		{
			require_code('images');
			$temp=$GLOBALS['SITE_DB']->query_select('images',array('id','url'),array('cat'=>$child['name'],'validated'=>1),$thumb_order,1);
			$thumb_url=ensure_thumbnail($temp[0]['url'],'','galleries','images',$temp[0]['id']);
		}
	}
	if (is_null($pic))
	{
		$pic=$GLOBALS['SITE_DB']->query_value_null_ok('videos','thumb_url',array('cat'=>$child['name'],'validated'=>1),$thumb_order);
	}
	if (is_null($pic)) $pic='';
	if (($pic!='') && (url_is_local($pic))) $pic=get_custom_base_url().'/'.$pic;
	if ($pic!='')
	{
		require_code('images');
		$thumb=do_image_thumb($pic,'');
	} else $thumb=new ocp_tempcode();
	if ($num_children==0)
	{
		if ($child['accept_videos']==0)
		{
			$lang=do_lang_tempcode('_SUBGALLERY_BITS_IMAGES',integer_format($num_images),integer_format($num_videos),integer_format($num_images+$num_videos));
		}
		elseif ($child['accept_images']==0)
		{
			$lang=do_lang_tempcode('_SUBGALLERY_BITS_VIDEOS',integer_format($num_images),integer_format($num_videos),integer_format($num_images+$num_videos));
		} else
		{
			$lang=do_lang_tempcode('_SUBGALLERY_BITS',integer_format($num_images),integer_format($num_videos),integer_format($num_images+$num_videos));
		}
	} else
	{
		if ($child['accept_videos']==0)
		{
			$lang=do_lang_tempcode('SUBGALLERY_BITS_IMAGES',integer_format($num_children),integer_format($num_images),array(integer_format($num_videos),integer_format($num_images+$num_videos)));
		}
		elseif ($child['accept_images']==0)
		{
			$lang=do_lang_tempcode('SUBGALLERY_BITS_VIDEOS',integer_format($num_children),integer_format($num_images),array(integer_format($num_videos),integer_format($num_images+$num_videos)));
		} else
		{
			$lang=do_lang_tempcode('SUBGALLERY_BITS',integer_format($num_children),integer_format($num_images),array(integer_format($num_videos),integer_format($num_images+$num_videos)));
		}
	}
	$tpl=do_template('GALLERY_BOX',array('_GUID'=>'0dbec2f11de63b0402471fe5c8b32865','NUM_VIDEOS'=>strval($num_videos),'NUM_IMAGES'=>strval($num_images),'NUM_CHILDREN'=>strval($num_children),'ID'=>$child['name'],'LANG'=>$lang,'ADD_DATE'=>$add_date,'ADD_DATE_RAW'=>strval($child['add_date']),'MEMBER_INFO'=>$member_info,'URL'=>$url,'THUMB'=>$thumb,'PIC'=>$pic,'TITLE'=>$_title,'COMMENTS'=>$comments));

	return $tpl;
}

/**
 * Get details of the contents of a gallery.
 *
 * @param  ID_TEXT		The name of the gallery
 * @param  boolean		Whether to test for videos when making counts (ignore this parameter - used internally)
 * @param  boolean		Whether to test for images when making counts (ignore this parameter - used internally)
 * @return array			A triplet: (num children, num images, num videos)
 */
function get_recursive_gallery_details($name,$test_videos=true,$test_images=true)
{
	static $total_categories=NULL;
	if (is_null($total_categories)) $total_categories=$GLOBALS['SITE_DB']->query_value('galleries','COUNT(*)');

	$num_images=$test_images?$GLOBALS['SITE_DB']->query_value('images','COUNT(*)',array('cat'=>$name)):0;
	$num_videos=$test_videos?$GLOBALS['SITE_DB']->query_value('videos','COUNT(*)',array('cat'=>$name)):0;

	if ($total_categories<200) // Make sure not too much, performance issue
	{
		$children=(strpos($name,'member_')!==false)?array():$GLOBALS['SITE_DB']->query_select('galleries',array('name','accept_images','accept_videos'),array('parent_id'=>$name));
		$num_children=0;
		foreach ($children as $child)
		{
			list($_num_children,$_num_images,$_num_videos)=get_recursive_gallery_details($child['name'],$child['accept_videos']==1,$child['accept_images']==1);
			$num_images+=$_num_images;
			$num_videos+=$_num_videos;
			if (get_option('show_empty_galleries')=='1')
			{
				$num_children+=$_num_children+1;
			} else
			{
				$num_children+=$_num_children+((($_num_images!=0) || ($_num_videos!=0))?1:0);
			}
		}
		return array($num_children,$num_images,$num_videos);
	}

	$num_children=(strpos($name,'member_')!==false)?0:$GLOBALS['SITE_DB']->query_value('galleries','COUNT(*)',array('parent_id'=>$name));
	return array($num_children,$num_images,$num_videos);
}

/**
 * See whether a gallery is a download gallery (designed as a filter).
 *
 * @param  ID_TEXT		The gallery name
 * @return boolean		Whether the gallery is a download gallery
 */
function only_download_galleries($cat)
{
	return (substr($cat,0,9)=='download_');
}

/**
 * See whether a gallery is NOT a download gallery (designed as a filter).
 *
 * @param  ID_TEXT		The gallery name
 * @return boolean		Whether the gallery is NOT a download gallery
 */
function only_conventional_galleries($cat)
{
	return (substr($cat,0,9)!='download_');
}

/**
 * See whether a gallery accepts some media (designed as a filter).
 *
 * @param  ID_TEXT		The gallery name
 * @return boolean		Whether the gallery accepts some media
 */
function only_galleries_accepting_media($cat)
{
	$_gallery_info=$GLOBALS['SITE_DB']->query_select('galleries',array('accept_images','accept_videos'),array('name'=>$cat),'',1);
	if (!array_key_exists(0,$_gallery_info)) return false;
	$gallery_info=$_gallery_info[0];
	return ($gallery_info['accept_images']==1 || $gallery_info['accept_videos']==1);
}

/**
 * See whether the GET parameter 'id' is of a gallery that is a member gallery of the given member gallery container, or just a normal gallery.
 *
 * @param  ID_TEXT		The gallery name
 * @param  ?MEMBER		Member we are filtering for (NULL: not needed)
 * @param  integer		The number of children for this gallery
 * @return boolean		The answer
 */
function only_member_galleries_of_id($cat,$member_id,$child_count)
{
	if (substr($cat,0,7)!='member_') return ($child_count!=0);
	return (substr($cat,7,strlen(strval($member_id))+1)==strval($member_id).'_');
}

/**
 * Gets a gallery selection tree list, extending deeper from the given category_id, showing all sub(sub...)galleries.
 *
 * @param  ?ID_TEXT		The gallery to select by default (NULL: no specific default)
 * @param  ?string		A function name to filter galleries with (NULL: no filter)
 * @param  boolean		Whether displayed galleries must support images
 * @param  boolean		Whether displayed galleries must support videos
 * @param  boolean		Whether to NOT show member galleries that do not exist yet
 * @param  boolean		Whether to get a list of child galleries (not just direct ones, recursively), instead of just IDs
 * @param  ?MEMBER		Member we are filtering for (NULL: not needed)
 * @param  boolean		Whether to only show for what may be added to by the current member
 * @param  boolean		Whether to only show for what may be edited by the current member
 * @return tempcode		The tree list
 */
function nice_get_gallery_tree($it=NULL,$filter=NULL,$must_accept_images=false,$must_accept_videos=false,$purity=false,$use_compound_list=false,$member_id=NULL,$addable_filter=false,$editable_filter=false)
{
	$tree=get_gallery_tree('root','',NULL,false,$filter,$must_accept_images,$must_accept_videos,$purity,$use_compound_list,NULL,$member_id,$addable_filter,$editable_filter);
	if ($use_compound_list) $tree=$tree[0];

	$out=''; // XHTMLXHTML
	foreach ($tree as $category)
	{
		if (($addable_filter) && (!$category['addable'])) continue;

		$selected=($category['id']==$it);
		$out.='<option value="'.(!$use_compound_list?$category['id']:$category['compound_list']).'"'.($selected?' selected="selected"':'').'>'.escape_html($category['breadcrumbs']).'</option>';
	}

	if ($GLOBALS['XSS_DETECT']) ocp_mark_as_escaped($out);

	return make_string_tempcode($out);
}

/**
 * Gets a gallery selection tree list, extending deeper from the given category_id, showing all sub(sub...)galleries.
 *
 * @param  ?ID_TEXT		The gallery we are getting the tree starting from (NULL: root)
 * @param  string			The parent breadcrumbs at this point of the recursion
 * @param  ?array			The database row for the $category_id gallery (NULL: get it from the DB)
 * @param  boolean		Whether to include video/image statistics in the returned tree
 * @param  ?string		A function name to filter galleries with (NULL: no filter)
 * @param  boolean		Whether displayed galleries must support images
 * @param  boolean		Whether displayed galleries must support videos
 * @param  boolean		Whether to NOT show member galleries that do not exist yet
 * @param  boolean		Whether to get a list of child galleries (not just direct ones, recursively), instead of just IDs
 * @param  ?integer		The number of recursive levels to search (NULL: all)
 * @param  ?MEMBER		Member we are filtering for (NULL: not needed)
 * @param  boolean		Whether to only show for what may be added to by the current member
 * @param  boolean		Whether to only show for what may be edited by the current member
 * @return array			The tree structure, or if $use_compound_list, the tree structure built with pairs containing the compound list in addition to the child branches
 */
function get_gallery_tree($category_id='root',$breadcrumbs='',$gallery_info=NULL,$do_stats=true,$filter=NULL,$must_accept_images=false,$must_accept_videos=false,$purity=false,$use_compound_list=false,$levels=NULL,$member_id=NULL,$addable_filter=false,$editable_filter=false)
{
	if ($levels==-1) return $use_compound_list?array(array(),''):array();

	if (is_null($category_id)) $category_id='root';

	if (!has_category_access(get_member(),'galleries',$category_id)) return $use_compound_list?array(array(),''):array();

	// Put our title onto our breadcrumbs
	if (is_null($gallery_info))
	{
		$_gallery_info=$GLOBALS['SITE_DB']->query_select('galleries',array('fullname','is_member_synched','accept_images','accept_videos'),array('name'=>$category_id),'',1);
		if (!array_key_exists(0,$_gallery_info)) warn_exit(do_lang_tempcode('_MISSING_RESOURCE',escape_html('gallery:'.$category_id)));
		$gallery_info=$_gallery_info[0];
	}
	$title=array_key_exists('text_original',$gallery_info)?$gallery_info['text_original']:get_translated_text($gallery_info['fullname']);
	$is_member_synched=$gallery_info['is_member_synched']==1;
	$accept_images=$gallery_info['accept_images']==1;
	$accept_videos=$gallery_info['accept_videos']==1;
	$breadcrumbs.=$title;

	$children=array();
	$sub=false;
	$query='FROM '.get_table_prefix().'galleries g LEFT JOIN '.get_table_prefix().'translate t ON '.db_string_equal_to('language',user_lang()).' AND g.fullname=t.id WHERE '.db_string_equal_to('parent_id',$category_id);
	if ((!is_null($filter)) && (!is_callable($filter)))
	{
		require_code('ocfiltering');
		$ocfilter=ocfilter_to_sqlfragment($filter,'name','galleries','parent_id','parent_id','name',false,false);
		$query.=' AND '.$ocfilter;
	}
	if (current(current($GLOBALS['SITE_DB']->query('SELECT COUNT(*) '.$query)))>=300)
	{
		$rows=$GLOBALS['SITE_DB']->query('SELECT text_original,name,fullname,accept_images,accept_videos,is_member_synched,g.fullname '.$query.' ORDER BY add_date',300);
	} else
	{
		$rows=$GLOBALS['SITE_DB']->query('SELECT text_original,name,fullname,accept_images,accept_videos,is_member_synched,g.fullname '.$query.' ORDER BY text_original ASC');
	}
	if (((is_null($filter)) || (!is_callable($filter)) || (call_user_func_array($filter,array($category_id,$member_id,count($rows))))) && ((!$must_accept_images) || (($accept_images) && (!$is_member_synched))) && ((!$must_accept_videos) || (($accept_videos) && (!$is_member_synched))))
	{
		// We'll be putting all children in this entire tree into a single list
		$children[0]['id']=$category_id;
		$children[0]['breadcrumbs']=$breadcrumbs;
		$children[0]['title']=$title;
		$children[0]['accept_images']=$gallery_info['accept_images'];
		$children[0]['accept_videos']=$gallery_info['accept_videos'];
		$children[0]['is_member_synched']=$gallery_info['is_member_synched'];
		if ($addable_filter)
		{
			$children[0]['addable']=(can_submit_to_gallery($category_id)!==false) && (has_submit_permission('mid',get_member(),get_ip_address(),'cms_galleries',array('galleries',$category_id)));
		}
		if ($editable_filter)
		{
			$can_submit=can_submit_to_gallery($category_id);
			$children[0]['editable']=has_edit_permission('cat_mid',get_member(),($can_submit===false)?NULL:$can_submit,'cms_galleries',array('galleries',$category_id));
		}
		if ($do_stats)
		{
			$good_row_count=0;
			foreach ($rows as $row)
			{
				if (((is_null($filter)) || (!is_callable($filter)) || (call_user_func_array($filter,array($row['name'],$member_id,1)))) && ((!$must_accept_images) || (($row['accept_images']) && ($row['is_member_synched']==0))) && ((!$must_accept_videos) || (($row['accept_videos']) && ($row['is_member_synched']==0))))
					$good_row_count++;
			}
			$children[0]['child_count']=$good_row_count;
			if (($good_row_count==0) && (!$purity) && ($gallery_info['is_member_synched'])) $children[0]['child_count']=1; // XHTMLXHTML
			$children[0]['video_count']=$GLOBALS['SITE_DB']->query_value('videos','COUNT(*)',array('cat'=>$category_id));
			$children[0]['image_count']=$GLOBALS['SITE_DB']->query_value('images','COUNT(*)',array('cat'=>$category_id));
		}
		$sub=true;
	}

	$can_submit=mixed();

	// Children of this category
	$breadcrumbs.=' > ';
	$found_own_gallery=false;
	$found_member_galleries=array($GLOBALS['FORUM_DRIVER']->get_guest_id()=>1);
	$compound_list=$category_id.',';
	foreach ($rows as $child)
	{
		if ($child['name']=='root') continue;

		$can_submit=can_submit_to_gallery($child['name']);
		if (($can_submit!==false) && ($can_submit>0))
		{
			$found_own_gallery=true;
			$found_member_galleries[$can_submit]=1;
		}

		if (($levels!==0) || ($use_compound_list))
		{
			$child_id=$child['name'];
			$child_breadcrumbs=$breadcrumbs;

			$child_children=get_gallery_tree($child_id,$child_breadcrumbs,$child,$do_stats,$filter,$must_accept_images,$must_accept_videos,$purity,$use_compound_list,is_null($levels)?NULL:($levels-1),$member_id,$addable_filter,$editable_filter);
			if ($use_compound_list)
			{
				list($child_children,$_compound_list)=$child_children;
				$compound_list.=$_compound_list;
			}

			if ($levels!==0)
				$children=array_merge($children,$child_children);
		}
	}
	if (($sub) && (array_key_exists(0,$children)))
	{
		$children[0]['compound_list']=$compound_list;
	}
	$done_for_all=false;
	if (($is_member_synched) && (!$purity) && ($levels!==0))
	{
		if ((has_specific_permission(get_member(),'can_submit_to_others_categories')) && (get_forum_type()=='ocf'))
		{
			ocf_require_all_forum_stuff();

			$members=$GLOBALS['FORUM_DB']->query_select('f_members',array('id','m_username','m_primary_group'),NULL,'ORDER BY m_username',100);
			if (count($members)!=100) // Performance tweak. Only do if we don't have too many results
			{
				$done_for_all=true;
				$group_membership=$GLOBALS['FORUM_DB']->query_select('f_group_members',array('gm_group_id','gm_member_id'),array('gm_validated'=>1));
				$group_permissions=$GLOBALS['SITE_DB']->query('SELECT group_id,the_page,the_value FROM '.$GLOBALS['SITE_DB']->get_table_prefix().'gsp WHERE '.db_string_equal_to('specific_permission','have_personal_category').' AND ('.db_string_equal_to('the_page','').' OR '.db_string_equal_to('the_page','cms_galleries').')');
				$is_super_admin=$GLOBALS['FORUM_DRIVER']->is_super_admin(get_member());
				foreach ($members as $_member)
				{
					$member=$_member['id'];
					$username=$_member['m_username'];

					$this_category_id='member_'.strval($member).'_'.$category_id;
					if ($member==get_member())
					{
						$has_permission=true;
					} else
					{
						$a=(in_array(array('group_id'=>$member['m_primary_group'],'the_page'=>'','the_value'=>1),$group_permissions));
						$b=(in_array(array('group_id'=>$member['m_primary_group'],'the_page'=>'cms_galleries','the_value'=>0),$group_permissions));
						$c=(in_array(array('group_id'=>$member['m_primary_group'],'the_page'=>'cms_galleries','the_value'=>1),$group_permissions));
						$has_permission=$is_super_admin;
						if ((($a) && (!$b)) || ($c))
							$has_permission=true;
						if (!$has_permission)
						{
							foreach ($group_membership as $_g)
							{
								if ($_g['gm_member_id']==$member)
								{
									$a=(in_array(array('group_id'=>$_g['gm_group_id'],'the_page'=>'','the_value'=>1),$group_permissions));
									$b=(in_array(array('group_id'=>$_g['gm_group_id'],'the_page'=>'cms_galleries','the_value'=>0),$group_permissions));
									$c=(in_array(array('group_id'=>$_g['gm_group_id'],'the_page'=>'cms_galleries','the_value'=>1),$group_permissions));
									if ((($a) && (!$b)) || ($c))
										$has_permission=true;
									break;
								}
							}
						}
					}
					if (($has_permission) && (!array_key_exists($member,$found_member_galleries)) && ((is_null($filter)) || (!is_callable($filter)) || (call_user_func_array($filter,array($this_category_id,$member_id,0)))))
					{
						$own_gallery=array();
						$own_gallery['id']=$this_category_id;
						$this_title=do_lang('NEW_PERSONAL_GALLERY_OF',$username,$title);
						$own_gallery['breadcrumbs']=$breadcrumbs.$this_title;
						$own_gallery['video_count']=0;
						$own_gallery['image_count']=0;
						$own_gallery['child_count']=0;
						$own_gallery['title']=$this_title;
						$own_gallery['accept_images']=$gallery_info['accept_images'];
						$own_gallery['accept_videos']=$gallery_info['accept_videos'];
						$own_gallery['is_member_synched']=0;
						$own_gallery['compound_list']=$compound_list;
						$own_gallery['addable']=true;
						$own_gallery['editable']=false;
						$children[]=$own_gallery;
						if ($member==get_member()) $found_own_gallery=true;
					}
				}
			}
		}

		if (((!$done_for_all) || (!$found_own_gallery)) && (!array_key_exists(get_member(),$found_member_galleries)) && (!is_guest()) && (!$purity) && (has_specific_permission(get_member(),'have_personal_category')))
		{
			$this_category_id='member_'.strval(get_member()).'_'.$category_id;
			if ((is_null($filter)) || (!is_callable($filter)) || (call_user_func_array($filter,array($this_category_id,$member_id,0))))
			{
				$own_gallery=array();
				$own_gallery['id']=$this_category_id;
				$this_title=do_lang('NEW_PERSONAL_GALLERY_OF',$GLOBALS['FORUM_DRIVER']->get_username(get_member()),$title);
				$own_gallery['breadcrumbs']=$breadcrumbs.$this_title;
				$own_gallery['video_count']=0;
				$own_gallery['image_count']=0;
				$own_gallery['child_count']=0;
				$own_gallery['title']=$this_title;
				$own_gallery['accept_images']=$gallery_info['accept_images'];
				$own_gallery['accept_videos']=$gallery_info['accept_videos'];
				$own_gallery['is_member_synched']=0;
				$own_gallery['addable']=true;
				$own_gallery['editable']=false;
				$own_gallery['compound_list']=$compound_list;
				$children[]=$own_gallery;
			}
		}
	}

	return $use_compound_list?array($children,$compound_list):$children;
}

/**
 * See whether the current member can submit to the named *member* gallery. Note - this function assumes that members have general submit permission, and does not check for gallery read access.
 *
 * @param  ID_TEXT			The gallery name
 * @return ~integer			The owner of the gallery (false: we aren't allowed to submit to it) (-2: not a member gallery)
 */
function can_submit_to_gallery($name)
{
	if (substr($name,0,7)!='member_')
	{
		if ($name=='root') return (-2);

		$parent_id=$GLOBALS['SITE_DB']->query_value_null_ok('galleries','parent_id',array('name'=>$name));
		if (is_null($parent_id)) return false; // No, does not even exist (probably a block was given a bad parameter)

		return can_submit_to_gallery($parent_id);
	}

	$parts=explode('_',$name);
	if (intval($parts[1])==get_member()) return intval($parts[1]);

	if (has_specific_permission(get_member(),'can_submit_to_others_categories')) return intval($parts[1]);

	return false;
}

/**
 * Get a UI element of a route from a known gallery back to the declared root of the tree.
 *
 * @param  ID_TEXT		The gallery name
 * @param  ID_TEXT		The virtual root
 * @param  boolean		Whether not to put a link at this point in the breadcrumbs (usually, because the viewer is already at it)
 * @param  ID_TEXT		The zone that the linked to gallery module is in
 * @return tempcode		The navigation element
 */
function gallery_breadcrumbs($category_id,$root='root',$no_link_for_me_sir=true,$zone='')
{
	if ($category_id=='') $category_id='root'; // To fix corrupt data

	$url_map=array('page'=>'galleries','type'=>'misc','id'=>$category_id,'root'=>($root=='root')?NULL:$root);
	if (get_page_name()=='galleries') $url_map+=propagate_ocselect();
	$url=build_url($url_map,$zone);

	if (($category_id==$root) || ($category_id=='root'))
	{
		if ($no_link_for_me_sir) return new ocp_tempcode();
		$title=get_translated_text($GLOBALS['SITE_DB']->query_value('galleries','fullname',array('name'=>$category_id)));
		return hyperlink($url,escape_html($title),false,false,do_lang_tempcode('GO_BACKWARDS_TO',$title),NULL,NULL,'up');
	}

	global $PT_PAIR_CACHE_G;
	if (!array_key_exists($category_id,$PT_PAIR_CACHE_G))
	{
		$category_rows=$GLOBALS['SITE_DB']->query_select('galleries',array('parent_id','fullname'),array('name'=>$category_id),'',1);
		if (!array_key_exists(0,$category_rows)) return new ocp_tempcode();//fatal_exit(do_lang_tempcode('CAT_NOT_FOUND',escape_html($category_id)));
		$PT_PAIR_CACHE_G[$category_id]=$category_rows[0];
	}

	$title=get_translated_text($PT_PAIR_CACHE_G[$category_id]['fullname']);
	if (!$no_link_for_me_sir)
	{
		$tpl_url=do_template('BREADCRUMB_SEPARATOR');
		$tpl_url->attach(hyperlink($url,escape_html($title),false,false,do_lang_tempcode('GO_BACKWARDS_TO',$title),NULL,NULL,'up'));
	} else $tpl_url=new ocp_tempcode();

	if ($PT_PAIR_CACHE_G[$category_id]['parent_id']==$category_id) fatal_exit(do_lang_tempcode('RECURSIVE_TREE_CHAIN',escape_html($category_id)));

	if ((get_value('personal_under_members')==='1') && (get_forum_type()=='ocf')) // TODO: Make proper option
	{
		$owner=get_member_id_from_gallery_name($PT_PAIR_CACHE_G[$category_id]['parent_id'],NULL,true);
		if (!is_null($owner))
		{
			$below=new ocp_tempcode();
			foreach (array(array('_SEARCH:members:misc',do_lang_tempcode('MEMBERS')),array('_SEARCH:members:view:'.strval($owner).'#tab__galleries',do_lang_tempcode('MEMBER_PROFILE',escape_html($GLOBALS['FORUM_DRIVER']->get_username($owner))))) as $i=>$bits)
			{
				list($page_link,$title)=$bits;
				list($zone,$map,$hash)=page_link_decode($page_link);
				if (get_page_name()=='galleries') $map+=propagate_ocselect();
				$url=build_url($map,$zone,NULL,false,false,false,$hash);
				if ($i!=0) $below->attach(do_template('BREADCRUMB_SEPARATOR'));
				$below->attach(hyperlink($url,escape_html($title),false,false,do_lang_tempcode('GO_BACKWARDS_TO',$title),NULL,NULL,'up'));
			}
			$below->attach($tpl_url);
			return $below;
		}
	}

	$below=gallery_breadcrumbs($PT_PAIR_CACHE_G[$category_id]['parent_id'],$root,false,$zone);

	$below->attach($tpl_url);
	return $below;
}

/**
 * Get a nice, formatted XHTML list of gallery entries, in gallery tree structure
 *
 * @param  ID_TEXT		The table we are working with
 * @set    images videos
 * @param  ?ID_TEXT		The currently selected entry (NULL: none selected)
 * @param  ?AUTO_LINK	Only show images/videos submitted by this member (NULL: no filter)
 * @param  boolean		Whether to get a list of child galleries (not just direct ones, recursively), instead of just IDs
 * @param  boolean		Whether to only show for what may be edited by the current member
 * @return tempcode		The list of entries
 */
function nice_get_gallery_content_tree($table,$it=NULL,$submitter=NULL,$use_compound_list=false,$editable_filter=false)
{
	$tree=get_gallery_content_tree($table,$submitter,NULL,NULL,NULL,NULL,$use_compound_list,$editable_filter);
	if ($use_compound_list) $tree=$tree[0];

	$out=''; // XHTMLXHTML
	foreach ($tree as $gallery)
	{
		foreach ($gallery['entries'] as $eid=>$etitle)
		{
			$selected=($eid==$it);
			$line=do_template('GALLERY_ENTRY_LIST_LINE',array('_GUID'=>'5a6fac8a768e049f9cc6c2d4ec77eeca','BREADCRUMBS'=>$gallery['breadcrumbs'],'URL'=>$etitle));
			$out.='<option value="'.(!$use_compound_list?strval($eid):$gallery['compound_list']).'"'.($selected?'selected="selected"':'').'>'.$line->evaluate().'</option>';
		}
	}

	if ($GLOBALS['XSS_DETECT']) ocp_mark_as_escaped($out);

	return make_string_tempcode($out);
}

/**
 * Get a list of maps containing all the gallery entries, and path information, under the specified gallery - and those beneath it, recursively.
 *
 * @param  ID_TEXT		The table we are working with
 * @set    images videos
 * @param  ?AUTO_LINK	Only show images/videos submitted by this member (NULL: no filter)
 * @param  ?ID_TEXT		The gallery being at the root of our recursion (NULL: true root)
 * @param  ?string		The breadcrumbs up to this point in the recursion (NULL: blank, as we are starting the recursion)
 * @param  ?ID_TEXT		The name of the $gallery we are currently going through (NULL: look it up). This is here for efficiency reasons, as finding children IDs to recurse to also reveals the childs title
 * @param  ?integer		The number of recursive levels to search (NULL: all)
 * @param  boolean		Whether to get a list of child galleries (not just direct ones, recursively), instead of just IDs
 * @param  boolean		Whether to only show for what may be edited by the current member
 * @return array			A list of maps for all galleries. Each map entry containins the fields 'id' (gallery ID) and 'breadcrumbs' (path to the category, including the categories own title), and more. Or if $use_compound_list, the tree structure built with pairs containing the compound list in addition to the child branches
 */
function get_gallery_content_tree($table,$submitter=NULL,$gallery=NULL,$breadcrumbs=NULL,$title=NULL,$levels=NULL,$use_compound_list=false,$editable_filter=false)
{
	if (is_null($gallery)) $gallery='root';

	if (!has_category_access(get_member(),'galleries',$gallery)) return array();

	if (is_null($breadcrumbs)) $breadcrumbs='';

	// Put our title onto our breadcrumbs
	if (is_null($title)) $title=get_translated_text($GLOBALS['SITE_DB']->query_value('galleries','fullname',array('name'=>$gallery)));
	$breadcrumbs.=$title;

	// We'll be putting all children in this entire tree into a single list
	$children=array();
	$children[0]=array();
	$children[0]['id']=$gallery;
	$children[0]['title']=$title;
	$children[0]['breadcrumbs']=$breadcrumbs;

	$compound_list=$gallery.',';

	// Children of this category
	$rows=$GLOBALS['SITE_DB']->query_select('galleries',array('name','fullname'),array('parent_id'=>$gallery),'ORDER BY add_date DESC',300);
	$where=array('cat'=>$gallery);
	if (!is_null($submitter)) $where['submitter']=$submitter;
	$erows=$GLOBALS['SITE_DB']->query_select($table,array('id','url','submitter','title'),$where,'ORDER BY add_date DESC',300);
	$children[0]['entries']=array();
	foreach ($erows as $row)
	{
		if (($editable_filter) && (!has_edit_permission('mid',get_member(),$row['submitter'],'cms_galleries',array('galleries',$gallery)))) continue;
		$e_title=get_translated_text($row['title']);
		if ($e_title=='') $e_title=basename($row['url']);
		$children[0]['entries'][$row['id']]=$e_title;
	}
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
			$child_id=$child['name'];
			$child_title=get_translated_text($child['fullname']);
			$child_breadcrumbs=$breadcrumbs;

			$child_children=get_gallery_content_tree($table,$submitter,$child_id,$child_breadcrumbs,$child_title,is_null($levels)?NULL:($levels-1),$use_compound_list,$editable_filter);
			if ($use_compound_list)
			{
				list($child_children,$_compound_list)=$child_children;
				$compound_list.=$_compound_list;
			}

			$children=array_merge($children,$child_children);
		}
	}
	$children[0]['compound_list']=$compound_list;

	return $use_compound_list?array($children,$compound_list):$children;
}

/**
 * Show a gallery media item (not an image, something more complex)
 *
 * @param  URLPATH		URL to media
 * @param  URLPATH		URL to thumbnail
 * @param  integer		Width
 * @param  integer		Height
 * @param  integer		Length
 * @param  ?ID_TEXT		Original filename of media file (NULL: find from URL)
 * @return tempcode		Displayed media
 */
function show_gallery_media($url,$thumb_url,$width,$height,$length,$orig_filename=NULL)
{
	require_lang('galleries');

	if (url_is_local($thumb_url)) $thumb_url=get_custom_base_url().'/'.$thumb_url;
	$full_url=url_is_local($url)?(get_custom_base_url().'/'.$url):$url;
	$extension=get_file_extension(is_null($orig_filename)?$url:$orig_filename);

	require_code('mime_types');
	$mime_type=get_mime_type($extension);
	if ($extension=='swf')
	{
		$mime_type='application/x-shockwave-flash';
		$tpl='GALLERY_SWF';
	} else
	{
		switch ($mime_type)
		{
			case 'application/pdf':
				$tpl='GALLERY_PDF';
				break;
			case 'video/quicktime':
				$tpl='GALLERY_VIDEO_QT';
				break;
			case 'audio/x-pn-realaudio':
				$tpl='GALLERY_VIDEO_RM';
				break;
			case 'video/x-flv':
			case 'video/mp4':
			case 'audio/x-mpeg':
			case 'video/webm':
				if (addon_installed('jwplayer'))
				{
					$tpl='GALLERY_VIDEO_FLV';
					break;
				}
			default:
				$ve_hooks=find_all_hooks('systems','video_embed');
				foreach (array_keys($ve_hooks) as $ve_hook)
				{
					require_code('hooks/systems/video_embed/'.$ve_hook);
					$ve_ob=object_factory('Hook_video_embed_'.$ve_hook);
					$ve_test=$ve_ob->get_template_name_and_id($url);
					if (!is_null($ve_test))
					{
						list($tpl,$full_url)=$ve_test;
						break 2;
					}
				}

				$tpl='GALLERY_VIDEO_GENERAL';
		}
	}
	return do_template($tpl,array('THUMB_URL'=>$thumb_url,'URL'=>$full_url,'LENGTH'=>strval($length),'WIDTH'=>strval($width),'HEIGHT'=>strval($height),'MIME_TYPE'=>$mime_type));
}

/**
 * Get a comma-separated list of allowed file types for video upload.
 *
 * @return string			Allowed file types
 */
function get_allowed_video_file_types()
{
	$supported='3gp,asf,avi,flv,m4v,mov,mp4,mpe,mpeg,mpg,ogg,ogv,qt,ra,ram,rm,webm,wmv';
	if (get_option('allow_audio_videos')=='1')
	{
		$supported.=',mid,mp3,wav,wma';
	}
	$supported.=',pdf';
	if (has_specific_permission(get_member(),'use_very_dangerous_comcode'))
	{
		$supported.=',swf';
	}
	return $supported;
}
