TODO

/**
 * Standard modular page-link finder function (does not return the main entry-points that are not inside the tree).
 *
 * @param  ?integer  The number of tree levels to computer (NULL: no limit)
 * @param  boolean	Whether to not return stuff that does not support permissions (unless it is underneath something that does).
 * @param  ?string	Position to start at in the tree. Does not need to be respected. (NULL: from root)
 * @param  boolean	Whether to avoid returning categories.
 * @return ?array	 	A tuple: 1) full tree structure [made up of (pagelink, permission-module, permissions-id, title, children, ?entry point for the children, ?children permission module, ?whether there are children) OR a list of maps from a get_* function] 2) permissions-page 3) optional base entry-point for the tree 4) optional permission-module 5) optional permissions-id (NULL: disabled).
 */
function get_page_links($max_depth=NULL,$require_permission_support=false,$start_at=NULL,$dont_care_about_categories=false)
{
	$permission_page='cms_catalogues';

	require_code('catalogues');
	require_lang('catalogues');

	$category_id=NULL;
	if (!is_null($start_at))
	{
		$matches=array();
		if (preg_match('#[^:]*:catalogues:type=index:id=(.*)#',$start_at,$matches)!=0)
		{
			$category_id=NULL;
			$adjusted_max_depth=is_null($max_depth)?NULL:(is_null($category_id)?$max_depth:$max_depth);
			$children=$dont_care_about_categories?array():get_catalogue_category_tree($matches[1],$category_id,NULL,NULL,$adjusted_max_depth,false);
			return array($children,$permission_page,'_SELF:_SELF:type=category:id=!','catalogues_category');
		}
		elseif (preg_match('#[^:]*:catalogues:type=category:id=(.*)#',$start_at,$matches)!=0)
		{
			$category_id=($matches[1]=='')?NULL:intval($matches[1]);
			$adjusted_max_depth=is_null($max_depth)?NULL:(is_null($category_id)?$max_depth:$max_depth);
			$catalogue_name=$GLOBALS['SITE_DB']->query_select_value('catalogue_categories','c_name',array('id'=>$category_id));
			$children=$dont_care_about_categories?array():get_catalogue_category_tree($catalogue_name,$category_id,NULL,NULL,$adjusted_max_depth,false);
			return array($children,$permission_page,'_SELF:_SELF:type=category:id=!','catalogues_category');
		}
	}

	$children=array();
	if ($dont_care_about_categories)
	{
		$rows=array();
	} else
	{
		$query='SELECT c.c_title,c.c_name,t.text_original FROM '.get_table_prefix().'catalogues c LEFT JOIN '.$GLOBALS['SITE_DB']->get_table_prefix().'translate t ON '.db_string_equal_to('language',user_lang()).' AND c.c_title=t.id';
		//if (db_has_subqueries($GLOBALS['SITE_DB']->connection_read))		Actually we want empty ones in sitemaps
		//	$query.=' WHERE EXISTS (SELECT * FROM '.get_table_prefix().'catalogue_entries e WHERE e.c_name=c.c_name)';
		$rows=$GLOBALS['SITE_DB']->query($query);
	}
	foreach ($rows as $row)
	{
		if (substr($row['c_name'],0,1)=='_') continue;

		if (is_null($row['text_original'])) $row['text_original']=get_translated_text($row['c_title']);
		$kids=array();
		if ((!is_null($max_depth)) || ($max_depth>1))
		{
			$adjusted_max_depth=is_null($max_depth)?NULL:(is_null($category_id)?($max_depth-2):($max_depth-1));
			$kids=get_catalogue_category_tree($row['c_name'],$category_id,NULL,NULL,$adjusted_max_depth,false);
		}
		$children[]=array('_SELF:_SELF:type=index:id='.$row['c_name'],'catalogues_catalogue',$row['c_name'],$row['text_original'],$kids,'_SELF:_SELF:type=category:id=!','catalogues_category',true);
		if (!$require_permission_support)
		{
			$children[]=array('_SELF:_SELF:type=atoz:catalogue_name='.$row['c_name'],'catalogues_catalogue',$row['c_name'],do_lang('DEFAULT__CATALOGUE_CATEGORY_ATOZ',$row['text_original']));
		}
	}

	return array($children,$permission_page,'_SELF:_SELF:type=misc:id=!');
}

/**
 * Convert a page link to a category ID and category permission module type.
 *
 * @param  string	The page link
 * @return ?array	The pair (NULL: permission modules not handled)
 */
function extract_page_link_permissions($page_link)
{
	$matches=array();
	if (preg_match('#^([^:]*):([^:]*):type=index:id=(.*)$#',$page_link,$matches)!=0)
		return array($matches[3],'catalogues_catalogue');
	preg_match('#^([^:]*):([^:]*):type=category:id=(.*)$#',$page_link,$matches);
	return array($matches[3],'catalogues_category');
}

/**
 * Standard modular new-style deep page-link finder function (does not return the main entry-points).
 *
 * @param  string  	Callback function to send discovered page-links to.
 * @param  MEMBER		The member we are finding stuff for (we only find what the member can view).
 * @param  integer	Code for how deep we are tunnelling down, in terms of whether we are getting entries as well as categories.
 * @param  string		Stub used to create page-links. This is passed in because we don't want to assume a zone or page name within this function.
 * @param  ?string	Where we're looking under (NULL: root of tree). We typically will NOT show a root node as there's often already an entry-point representing it.
 * @param  integer	Our recursion depth (used to calculate importance of page-link, used for instance by Google sitemap). Deeper is typically less important.
 * @param  ?array		Non-standard for API [extra parameter tacked on] (NULL: yet unknown). Contents of database table for performance.
 * @param  ?array		Non-standard for API [extra parameter tacked on] (NULL: yet unknown). Contents of database table for performance.
 */
function get_sitemap_pagelinks($callback,$member_id,$depth,$pagelink_stub,$parent_pagelink=NULL,$recurse_level=0,$category_data=NULL,$entry_data=NULL)
{
	$parent_pagelink_orig=$parent_pagelink;

	// This is where we start
	if (is_null($parent_pagelink))
	{
		$parent_pagelink=$pagelink_stub.':misc'; // This is the entry-point we're under
		$parent_attributes=array('id'=>NULL,'c_name'=>'');
	} else
	{
		list(,$parent_attributes,)=page_link_decode($parent_pagelink);
	}

	// We read in all data for efficiency
	if (is_null($category_data))
	{
		$query='SELECT c_name,d.id,t.text_original AS title,cc_add_date AS edit_date';
		$lots=($GLOBALS['SITE_DB']->query_select_value_if_there('catalogue_categories','COUNT(*)')>1000) && (db_has_subqueries($GLOBALS['SITE_DB']->connection_read));
		if ($lots)
		{
			$query.=',NULL AS parent_id';
		} else
		{
			$query.=',cc_parent_id AS parent_id';
		}
		$query.=' FROM '.get_table_prefix().'catalogue_categories d LEFT JOIN '.get_table_prefix().'translate t ON '.db_string_equal_to('language',user_lang()).' AND t.id=d.cc_title';
		$query.=' WHERE d.c_name NOT LIKE \''.db_encode_like('\_%').'\'';
		if ($lots)
		{
			$query.=' AND EXISTS (SELECT * FROM '.get_table_prefix().'catalogue_entries e WHERE e.cc_id=d.id)';
		}
		$category_data=list_to_map('id',$GLOBALS['SITE_DB']->query($query));
	}
	$query='SELECT c.* FROM '.get_table_prefix().'catalogues c';
	if (can_arbitrary_groupby())
		$query.=' JOIN '.get_table_prefix().'catalogue_entries e ON c.c_name=e.c_name';
	$query.=' WHERE c.c_name NOT LIKE \''.db_encode_like('\_%').'\'';
	if (can_arbitrary_groupby())
		$query.=' GROUP BY e.cc_id';
	$catalogues=list_to_map('c_name',$GLOBALS['SITE_DB']->query($query));

	if (!is_null($parent_pagelink_orig))
	{
		$parent_attributes['c_name']=$category_data[intval($parent_attributes['id'])]['c_name'];
	}

	// Subcategories
	foreach ($category_data as $row)
	{
		if (((!is_null($row['parent_id'])) && (strval($row['parent_id'])==$parent_attributes['id'])) || ((is_null($parent_pagelink_orig)) && (is_null($row['parent_id']))))
		{
			$pagelink=$pagelink_stub.'category:'.strval($row['id']);
			if (__CLASS__!='')
			{
				$this->get_sitemap_pagelinks($callback,$member_id,$depth,$pagelink_stub,$pagelink,$recurse_level+1,$category_data,$entry_data); // Recurse
			} else
			{
				call_user_func_array(__FUNCTION__,array($callback,$member_id,$depth,$pagelink_stub,$pagelink,$recurse_level+1,$category_data,$entry_data)); // Recurse
			}
			if ((has_category_access($member_id,'catalogues_catalogue',$row['c_name'])) && ((get_value('disable_cat_cat_perms')==='1') || (has_category_access($member_id,'catalogues_category',strval($row['id'])))))
			{
				call_user_func_array($callback,array($pagelink,$parent_pagelink,NULL,$row['edit_date'],max(0.7-$recurse_level*0.1,0.3),$row['title'])); // Callback
			} else // Not accessible: we need to copy the node through, but we will flag it 'Unknown' and say it's not accessible.
			{
				call_user_func_array($callback,array($pagelink,$parent_pagelink,NULL,$row['edit_date'],max(0.7-$recurse_level*0.1,0.3),do_lang('UNKNOWN'),false)); // Callback
			}
		}
	}

	// Entries
	if (($depth>=DEPTH__ENTRIES) && (has_category_access($member_id,'catalogues_catalogue',$parent_attributes['c_name'])) && ((get_value('disable_cat_cat_perms')==='1') || (has_category_access($member_id,'catalogues_category',$parent_attributes['id']))))
	{
		require_code('catalogues');

		$start=0;
		do
		{
			$privacy_join='';
			$privacy_where='';
			if (addon_installed('content_privacy'))
			{
				require_code('content_privacy');
				list($privacy_join,$privacy_where)=get_privacy_where_clause('catalogue_entry','d');
			}
			$entry_data=$GLOBALS['SITE_DB']->query('SELECT c_name,id,cc_id AS category_id,ce_add_date AS add_date,ce_edit_date AS edit_date,d.* FROM '.get_table_prefix().'catalogue_entries d'.$privacy_join.' WHERE cc_id='.strval(intval($parent_attributes['id'])).$privacy_where,500,$start);

			foreach ($entry_data as $row)
			{
				$map=get_catalogue_entry_map($row,$catalogues[$row['c_name']],'CATEGORY','DEFAULT',NULL,NULL,array(0));

				$row['title']=is_object($map['FIELD_0_PLAIN'])?$map['FIELD_0_PLAIN']->evaluate():$map['FIELD_0_PLAIN'];

				$pagelink=$pagelink_stub.'entry:'.strval($row['id']);
				call_user_func_array($callback,array($pagelink,$parent_pagelink,$row['add_date'],$row['edit_date'],0.2,$row['title'])); // Callback
			}

			$start+=500;
		}
		while (array_key_exists(0,$entry_data));
	}
}

<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.


 NOTE TO PROGRAMMERS:
   Do not edit this file. If you need to make changes, save your changed file to the appropriate *_custom folder
   **** If you ignore this advice, then your website upgrades (e.g. for bug fixes) will likely kill your changes ****

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		?
 */

class Hook_sitemap_?
{
	/**
	 * Convert a page link to a category ID and category permission module type.
	 *
	 * @param  ID_TEXT		The page-link.
	 * @return boolean		Whether the page-link is handled by this hook.
	 */
	function handles_pagelink($pagelink)
	{
		?
	}

	/**
	 * Find details of a position in the sitemap.
	 *
	 * @param  ID_TEXT  		The page-link we are finding.
	 * @param  ?string  		Callback function to send discovered page-links to (NULL: return).
	 * @param  ?array			List of node content types we will return/recurse-through (NULL: no limit)
	 * @param  ?integer		How deep to go from the sitemap root (NULL: no limit).
	 * @param  integer		Our recursion depth (used to limit recursion, or to calculate importance of page-link, used for instance by Google sitemap [deeper is typically less important]).
	 * @param  boolean		Only go so deep as needed to find nodes with permission-support (typically, stopping prior to the entry-level).
	 * @param  ID_TEXT		The zone we will consider ourselves to be operating in (needed due to transparent redirects feature)
	 * @param  boolean		Whether to filter out non-validated content.
	 * @param  boolean		Whether to consider secondary categorisations for content that primarily exists elsewhere.
	 * @param  integer		A bitmask of SITEMAP_GATHER_* constants, of extra data to include.
	 * @return ?array			Result structure (NULL: working via callback).
	 */
	function get_node($pagelink,$callback=NULL,$valid_node_content_types=NULL,$max_recurse_depth=NULL,$recurse_level=0,$require_permission_support=false,$zone='_SEARCH',$consider_secondary_categories=false,$consider_validation=false,$meta_gather=0)
	{
		return array(
			'title'=>?,
			'content_type'=>?,
			'content_id'=>?,
			'pagelink'=>?,
			'sitemap_priority'=>?, // 0.0 to 1.0
			'sitemap_changefreq'=>?, // always|hourly|daily|weekly|monthly|yearly|never
			'extra_meta'=>array(
				'description'=>?,
				'image'=>?,
				'image_2x'=>?,
				'add_date'=>?,
				'edit_date'=>?,
				'submitter'=>?,
				'views'=>?,
				'rating'=>?,
				'meta_keywords'=>?,
				'meta_description'=>?,
				'categories'=>array(?),
				'db_row'=>array(?),
			),
			'permissions'=>array(
				array(
					'type'=>'privilege',
					'privilege'=>?
					'permission_module'=>?,
					'category_name'=>?,
					'page_name'=>?,
				),
				array(
					'type'=>'zone',
					'zone_name'=>?,
				),
				array(
					'type'=>'page',
					'zone_name'=>?,
					'page_name'=>?,
				),
				array(
					'type'=>'category',
					'permission_module'=>?,
					'category_name'=>?,
					'page_name'=>?,
				),
			),
			'child_pagelink_pattern'=>?,
			'child_permission_module'=>?,
			'has_possible_children'=>?,
			'children'=>array(
				? ...
			),
		);
	}

	/**
	 * Convert a page link to a category ID and category permission module type.
	 *
	 * @param  string	The page link
	 * @return ?array	The pair (NULL: permission modules not handled)
	 */
	function extract_child_pagelink_permission_pair($pagelink)
	{
		$matches=array();
		preg_match('#^([^:]*):([^:]*):type=misc:id=(.*)$#',$pagelink,$matches);
		return array($matches[3],'?');
	}
}
