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
	$permission_page='cms_wiki';

	//if ($require_permission_support) return array(array(),$permission_page,'_SELF:_SELF:type=misc:id=!');

	require_code('wiki');
	$category_id=NULL;
	if (!is_null($start_at))
	{
		$matches=array();
		if (preg_match('#[^:]*:wiki:type=misc:id=(.*)#',$start_at,$matches)!=0) $category_id=intval($matches[1]);
	}

	$wiki_seen=array();
	$adjusted_max_depth=is_null($max_depth)?NULL:(is_null($category_id)?($max_depth-1):$max_depth);
	return array($dont_care_about_categories?array():get_wiki_page_tree($wiki_seen,$category_id,NULL,NULL,false,false,$adjusted_max_depth),$permission_page,'_SELF:_SELF:type=misc:id=!','wiki_page');
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
 */
function get_sitemap_pagelinks($callback,$member_id,$depth,$pagelink_stub,$parent_pagelink=NULL,$recurse_level=0,$category_data=NULL)
{
	// This is where we start
	if (is_null($parent_pagelink))
	{
		$parent_pagelink=$pagelink_stub.':misc'; // This is the entry-point we're under
		$parent_attributes=array('id'=>strval(db_get_first_id()));
	} else
	{
		list(,$parent_attributes,)=page_link_decode($parent_pagelink);
	}

	// We read in all data for efficiency
	if (is_null($category_data))
	{
		$category_data=$GLOBALS['SITE_DB']->query_select('wiki_pages c LEFT JOIN '.get_table_prefix().'wiki_children x ON x.child_id=c.id LEFT JOIN '.get_table_prefix().'translate t ON '.db_string_equal_to('language',user_lang()).' AND t.id=c.title',array('c.title AS _title','c.id','t.text_original AS title','parent_id','add_date'));
		$category_data=remove_duplicate_rows($category_data,'id');
	}

	// Subcategories
	foreach ($category_data as $row)
	{
		if (is_null($row['title'])) $row['title']=get_translated_text($row['_title']);

		if ((!is_null($row['parent_id'])) && (strval($row['parent_id'])==$parent_attributes['id']))
		{
			$pagelink=$pagelink_stub.'misc:'.strval($row['id']);
			if (__CLASS__!='')
			{
				$this->get_sitemap_pagelinks($callback,$member_id,$depth,$pagelink_stub,$pagelink,$recurse_level+1,$category_data); // Recurse
			} else
			{
				call_user_func_array(__FUNCTION__,array($callback,$member_id,$depth,$pagelink_stub,$pagelink,$recurse_level+1,$category_data)); // Recurse
			}
			if (has_category_access($member_id,'wiki_page',strval($row['id'])))
			{
				call_user_func_array($callback,array($pagelink,$parent_pagelink,$row['add_date'],NULL,max(0.7-$recurse_level*0.1,0.3),$row['title'])); // Callback
			} else // Not accessible: we need to copy the node through, but we will flag it 'Unknown' and say it's not accessible.
			{
				call_user_func_array($callback,array($pagelink,$parent_pagelink,$row['add_date'],NULL,max(0.7-$recurse_level*0.1,0.3),do_lang('UNKNOWN'),false)); // Callback
			}
		}
	}
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
	preg_match('#^([^:]*):([^:]*):type=misc:id=(.*)$#',$page_link,$matches);
	return array($matches[3],'wiki_page');
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
