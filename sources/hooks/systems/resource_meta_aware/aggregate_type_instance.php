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
 * @package		aggregate_types
 */

class Hook_resource_meta_aware_aggregate_type_instance
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
			'supports_custom_fields'=>false,

			'content_type_label'=>'AGGREGATE_TYPE_INSTANCES',

			'connection'=>$GLOBALS['SITE_DB'],
			'table'=>'aggregate_type_instances',
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
			'category_is_string'=>true,

			'title_field'=>'aggregate_label',
			'title_field_dereference'=>false,

			'view_pagelink_pattern'=>NULL,
			'edit_pagelink_pattern'=>'_SEARCH:admin_aggregate_types:_ed:_WILD',
			'view_category_pagelink_pattern'=>NULL,
			'add_url'=>(function_exists('get_member') && has_actual_page_access(get_member(),'admin_aggregate_types'))?(get_module_zone('admin_aggregate_types').':admin_aggregate_types:ad'):NULL,
			'archive_url'=>NULL,

			'support_url_monikers'=>false,

			'views_field'=>NULL,
			'submitter_field'=>NULL,
			'add_time_field'=>'add_time',
			'edit_time_field'=>'edit_time',
			'date_field'=>'add_time',
			'validated_field'=>NULL,

			'seo_type_code'=>NULL,

			'feedback_type_code'=>NULL,

			'permissions_type_code'=>NULL, // NULL if has no permissions

			'search_hook'=>NULL,

			'addon_name'=>'aggregate_types',

			'cms_page'=>'admin_aggregate_types',
			'module'=>NULL,

			'occle_filesystem_hook'=>'aggregate_type_instances',
			'occle_filesystem__is_folder'=>false,

			'rss_hook'=>NULL,

			'actionlog_regexp'=>'\w+_AGGREGATE_TYPE_INSTANCE',
		);
	}

}
