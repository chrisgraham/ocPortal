<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		tester
 */

class Hook_content_meta_aware_tester
{
    /**
	 * Get content type details. Provides information to allow task reporting, randomisation, and add-screen linking, to function.
	 *
	 * @param  ?ID_TEXT	The zone to link through to (NULL: autodetect).
	 * @return ?array		Map of award content-type info (NULL: disabled).
	 */
    public function info($zone = null)
    {
        return array(
            'supports_custom_fields' => false,

            'content_type_label' => 'tester:TEST_SECTION',

            'connection' => $GLOBALS['SITE_DB'],
            'table' => 'tests',
            'id_field' => 'id',
            'id_field_numeric' => true,
            'parent_category_field' => 't_section',
            'parent_category_meta_aware_type' => NULL,
            'is_category' => false,
            'is_entry' => true,
            'category_field' => NULL, // For category permissions
            'category_type' => NULL, // For category permissions
            'category_is_string' => false,

            'title_field' => NULL,
            'title_field_dereference' => false,
            'description_field' => NULL,
            'thumb_field' => NULL,

            'view_page_link_pattern' => '_SEARCH:tester:report:_WILD',
            'edit_page_link_pattern' => '_SEARCH:tester:_ed:_WILD',
            'view_category_page_link_pattern' => NULL,
            'add_url' => (has_submit_permission('mid',get_member(),get_ip_address(),'tester'))?(get_module_zone('tester') . ':tester:ad'):null,
            'archive_url' => ((!is_null($zone))?$zone:get_module_zone('tester')) . ':tester',

            'support_url_monikers' => true,

            'views_field' => NULL,
            'submitter_field' => 't_assigned_to',
            'add_time_field' => NULL,
            'edit_time_field' => NULL,
            'date_field' => NULL,
            'validated_field' => NULL,

            'seo_type_code' => NULL,

            'feedback_type_code' => 'bug_report',

            'permissions_type_code' => NULL, // NULL if has no permissions

            'search_hook' => NULL,

            'addon_name' => 'tester',

            'cms_page' => 'cms_chat',
            'module' => 'tester',

            'occle_filesystem_hook' => NULL,
            'occle_filesystem__is_folder' => false,

            'rss_hook' => NULL,

            'actionlog_regexp' => '\w+_TEST',
        );
    }
}
