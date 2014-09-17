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
 * @package		polls
 */

class Hook_content_meta_aware_poll
{
	/**
	 * Get content type details. Provides information to allow task reporting, randomisation, and add-screen linking, to function.
	 *
	 * @param  ?ID_TEXT	The zone to link through to (NULL: autodetect).
	 * @return ?array		Map of award content-type info (NULL: disabled).
	 */
	function info($zone=NULL)
	{
		return array(
			'supports_custom_fields'=>true,

			'content_type_label'=>'polls:POLL',

			'connection'=>$GLOBALS['SITE_DB'],
			'table'=>'poll',
			'id_field'=>'id',
			'id_field_numeric'=>true,
			'parent_category_field'=>NULL,
			'parent_category_meta_aware_type'=>NULL,
			'is_category'=>false,
			'is_entry'=>true,
			'category_field'=>NULL, // For category permissions
			'category_type'=>NULL, // For category permissions
			'parent_spec__table_name'=>NULL,
			'parent_spec__parent_name'=>NULL,
			'parent_spec__field_name'=>NULL,
			'category_is_string'=>false,

			'title_field'=>'question',
			'title_field_dereference'=>true,
			'description_field'=>NULL,
			'thumb_field'=>NULL,

			'view_page_link_pattern'=>'_SEARCH:polls:view:_WILD',
			'edit_page_link_pattern'=>'_SEARCH:cms_polls:_ed:_WILD',
			'view_category_page_link_pattern'=>NULL,
			'add_url'=>(function_exists('has_submit_permission') && has_submit_permission('mid',get_member(),get_ip_address(),'cms_polls'))?(get_module_zone('cms_polls').':cms_polls:ad'):NULL,
			'archive_url'=>((!is_null($zone))?$zone:get_module_zone('polls')).':polls',

			'support_url_monikers'=>true,

			'views_field'=>'poll_views',
			'submitter_field'=>'submitter',
			'add_time_field'=>'add_time',
			'edit_time_field'=>'edit_date',
			'date_field'=>'add_time',
			'validated_field'=>NULL,

			'seo_type_code'=>NULL,

			'feedback_type_code'=>'polls',

			'permissions_type_code'=>NULL, // NULL if has no permissions

			'search_hook'=>'polls',

			'addon_name'=>'polls',

			'cms_page'=>'cms_polls',
			'module'=>'polls',

			'occle_filesystem_hook'=>'polls',
			'occle_filesystem__is_folder'=>false,

			'rss_hook'=>'polls',

			'actionlog_regexp'=>'\w+_POLL',
		);
	}

	/**
	 * Run function for content hooks. Renders a content box for an award/randomisation.
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
		require_code('polls');

		return render_poll_box(true,$row,$zone,false,$give_context,$guid);
	}
}
