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
 * @package		news
 */

class Hook_content_meta_aware_news
{

	/**
	 * Standard modular info function for content hooks. Provides information to allow task reporting, randomisation, and add-screen linking, to function.
	 *
	 * @param  ?ID_TEXT	The zone to link through to (NULL: autodetect).
	 * @return ?array		Map of award content-type info (NULL: disabled).
	 */
	function info($zone=NULL)
	{
		return array(
			'supports_custom_fields'=>true,
			'content_type_label'=>'news:NEWS_ARTICLE',

			'connection'=>$GLOBALS['SITE_DB'],
			'table'=>'news',
			'id_field'=>'id',
			'id_field_numeric'=>true,
			'parent_category_field'=>'news_category',
			'parent_category_meta_aware_type'=>'news_category',
			'is_category'=>false,
			'is_entry'=>true,
			'category_field'=>'news_category', // For category permissions
			'category_type'=>'news', // For category permissions
			'parent_spec__table_name'=>'news_categories',
			'parent_spec__parent_name'=>NULL,
			'parent_spec__field_name'=>'id',
			'category_is_string'=>false,

			'title_field'=>'title',
			'title_field_dereference'=>true,
			'title_field_supports_comcode'=>true,

			'view_pagelink_pattern'=>'_SEARCH:news:view:_WILD',
			'edit_pagelink_pattern'=>'_SEARCH:cms_news:_ed:_WILD',
			'view_category_pagelink_pattern'=>'_SEARCH:news:misc:_WILD',
			'add_url'=>(function_exists('has_submit_permission') && has_submit_permission('mid',get_member(),get_ip_address(),'cms_news'))?(get_module_zone('cms_news').':cms_news:ad'):NULL,
			'archive_url'=>((!is_null($zone))?$zone:get_module_zone('news')).':news',

			'support_url_monikers'=>true,

			'views_field'=>'news_views',
			'submitter_field'=>'submitter',
			'add_time_field'=>'date_and_time',
			'edit_time_field'=>'edit_date',
			'date_field'=>'date_and_time',
			'validated_field'=>'validated',

			'seo_type_code'=>'news',

			'feedback_type_code'=>'news',

			'permissions_type_code'=>'news', // NULL if has no permissions

			'search_hook'=>'news',

			'addon_name'=>'news',

			'cms_page'=>'cms_news',
			'module'=>'news',

			'occle_filesystem_hook'=>'news',
			'occle_filesystem__is_folder'=>false,

			'rss_hook'=>'news',

			'actionlog_regexp'=>'\w+_NEWS',

			'supports_privacy'=>true,
		);
	}

	/**
	 * Standard modular run function for content hooks. Renders a content box for an award/randomisation.
	 *
	 * @param  array		The database row for the content
	 * @param  ID_TEXT	The zone to display in
	 * @param  boolean	Whether to include context (i.e. say WHAT this is, not just show the actual content)
	 * @param  boolean	Whether to include breadcrumbs (if there are any)
	 * @param  ?ID_TEXT	Virtual root to use (NULL: none)
	 * @param  boolean	Whether to copy through any filter parameters in the URL, under the basis that they are associated with what this box is browsing
	 * @param  ID_TEXT	Overridden GUID to send to templates (blank: none)
	 * @return tempcode	Results
	 */
	function run($row,$zone,$give_context=true,$include_breadcrumbs=true,$root=NULL,$attach_to_url_filter=false,$guid='')
	{
		require_code('news');

		return render_news_box($row,$zone,$give_context,false,$guid);
	}

}
