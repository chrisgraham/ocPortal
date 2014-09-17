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
 * @package		catalogues
 */

class Hook_content_meta_aware_catalogue_entry
{
	/**
	 * Get content type details. Provides information to allow task reporting, randomisation, and add-screen linking, to function.
	 *
	 * @param  ?ID_TEXT	The zone to link through to (NULL: autodetect).
	 * @param  ?ID_TEXT	Catalogue name for entry (NULL: unknown / N/A).
	 * @return ?array		Map of award content-type info (NULL: disabled).
	 */
	function info($zone=NULL,$catalogue_name=NULL)
	{
		return array(
			'supports_custom_fields'=>false,

			'content_type_label'=>'catalogues:CATALOGUE_ENTRY',

			'connection'=>$GLOBALS['SITE_DB'],
			'table'=>'catalogue_entries',
			'id_field'=>'id',
			'id_field_numeric'=>true,
			'parent_category_field'=>'cc_id',
			'parent_category_meta_aware_type'=>'catalogue_category',
			'is_category'=>false,
			'is_entry'=>true,
			'category_field'=>array('c_name','cc_id'), // For category permissions
			'category_type'=>array('catalogues_catalogue','catalogues_category'), // For category permissions
			'parent_spec__table_name'=>'catalogue_categories',
			'parent_spec__parent_name'=>'cc_parent_id',
			'parent_spec__field_name'=>'id',
			'category_is_string'=>array(true,false),

			'title_field'=>'CALL: generate_catalogue_entry_title',
			'title_field_dereference'=>false,
			'description_field'=>NULL,
			'thumb_field'=>'CALL: generate_catalogue_thumb_field',

			'view_page_link_pattern'=>'_SEARCH:catalogues:entry:_WILD',
			'edit_page_link_pattern'=>'_SEARCH:cms_catalogues:_ed:_WILD',
			'view_category_page_link_pattern'=>'_SEARCH:catalogues:category:_WILD',
			'add_url'=>(function_exists('has_submit_permission') && has_submit_permission('mid',get_member(),get_ip_address(),'cms_catalogues'))?(get_module_zone('cms_catalogues').':cms_catalogues:add_entry'.(is_null($catalogue_name)?'':(':catalogue_name='.$catalogue_name))):NULL,
			'archive_url'=>((!is_null($zone))?$zone:get_module_zone('catalogues')).':catalogues',

			'support_url_monikers'=>true,

			'views_field'=>'ce_views',
			'submitter_field'=>'ce_submitter',
			'add_time_field'=>'ce_add_date',
			'edit_time_field'=>'ce_edit_date',
			'date_field'=>'ce_add_date',
			'validated_field'=>'ce_validated',

			'seo_type_code'=>'catalogue_entry',

			'feedback_type_code'=>'catalogues',

			'permissions_type_code'=>(get_value('disable_cat_cat_perms')==='1')?NULL:'catalogues_category', // NULL if has no permissions

			'search_hook'=>'catalogue_entries',

			'addon_name'=>'catalogues',

			'cms_page'=>'cms_catalogues',
			'module'=>'catalogues',

			'ocselect'=>'catalogues::_catalogues_ocselect',
			'ocselect_protected_fields'=>array(), // These are ones even some staff should never know

			'occle_filesystem_hook'=>'catalogues',
			'occle_filesystem__is_folder'=>false,

			'rss_hook'=>'catalogues',

			'actionlog_regexp'=>'\w+_CATALOGUE_ENTRY',

			'supports_privacy'=>true,
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
		require_code('catalogues');

		return render_catalogue_entry_box($row,$zone,$give_context,$include_breadcrumbs,is_null($root)?NULL:intval($root),$guid);
	}
}

/**
 * Find a catalogue entry title.
 *
 * @param  array		The URL parts to search from.
 * @param  boolean	Whether to get the field title using resource-fs style.
 * @return string 	The field title.
 */
function generate_catalogue_entry_title($url_parts,$resourcefs_style=false)
{
	$catalogue_name=mixed();
	$fields=mixed();

	$unique_key_num=0;
	if ($resourcefs_style)
	{
		$catalogue_name=$GLOBALS['SITE_DB']->query_select_value('catalogue_entries','c_name',array('id'=>intval($url_parts['id'])));
		$fields=$GLOBALS['SITE_DB']->query_select('catalogue_fields',array('*'),array('c_name'=>$catalogue_name),'ORDER BY cf_order');
		foreach ($fields as $i=>$f)
		{
			if ($f['cf_type']=='codename')
			{
				$unique_key_num=$i;
				break;
			}
		}
	}

	require_code('catalogues');
	$field_values=get_catalogue_entry_field_values($catalogue_name,intval($url_parts['id']),array($unique_key_num),$fields);
	$field=$field_values[$unique_key_num];
	if (is_null($field)) return uniqid('',true);
	$value=$field['effective_value_pure'];
	return strip_comcode($value);
}

/**
 * Find a catalogue entry thumbnail.
 *
 * @param  array		The URL parts to search from.
 * @return string 	The field title.
 */
function generate_catalogue_thumb_field($url_parts)
{
	$unique_key_num=mixed();

	$catalogue_name=$GLOBALS['SITE_DB']->query_select_value('catalogue_entries','c_name',array('id'=>intval($url_parts['id'])));
	$fields=$GLOBALS['SITE_DB']->query_select('catalogue_fields',array('*'),array('c_name'=>$catalogue_name),'ORDER BY cf_order');
	foreach ($fields as $i=>$f)
	{
		if ($f['cf_type']=='picture')
		{
			$unique_key_num=$i;
			break;
		}
	}

	if ($unique_key_num===NULL) return '';

	require_code('catalogues');
	$field_values=get_catalogue_entry_field_values($catalogue_name,intval($url_parts['id']),array($unique_key_num),$fields);
	$field=$field_values[$unique_key_num];
	if (is_null($field)) return '';
	$value=$field['effective_value_pure'];
	return $value;
}
