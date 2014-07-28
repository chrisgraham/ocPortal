<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		testing_platform
 */

/**
 * ocPortal test case class (unit testing).
 */
class ocp_merge_test_set extends ocp_test_case
{
	function testFullTableCoverage()
	{
		$non_core_tables=array(
			'activities',
			'addons',
			'addons_dependencies',
			'addons_files',
			'adminlogs',
			'autosave',
			'blocks',
			'bookable',
			'bookable_blacked',
			'bookable_blacked_for',
			'bookable_codes',
			'bookable_supplement',
			'bookable_supplement_for',
			'booking',
			'booking_supplement',
			'cached_comcode_pages',
			'cached_weather_codes',
			'cache_on',
			'calendar_jobs',
			'captchas',
			'catalogue_cat_treecache',
			'catalogue_childcountcache',
			'chat_active',
			'chat_events',
			'chat_messages',
			'classifieds_prices',
			'community_billboard',
			'credit_purchases',
			'cron_caching_requests',
			'digestives_consumed',
			'digestives_tin',
			'diseases',
			'edit_pings',
			'feature_lifetime_monitor',
			'f_group_join_log',
			'f_moderator_logs',
			'f_password_history',
			'f_post_history',
			'f_special_pt_access',
			'failedlogins',
			'hackattack',
			'import_parts_done',
			'import_session',
			'incoming_uploads',
			'iotd',
			'ip_country',
			'link_tracker',
			'logged',
			'logged_mail_messages',
			'long_values',
			'mayfeature',
			'members_diseases',
			'members_gifts',
			'member_tracking',
			'messages_to_render',
			'modules',
			'newsletter_drip_send',
			'occlechat',
			'ocgifts',
			'privilege_list',
			'quiz_member_last_visit',
			'referees_qualified_for',
			'referrer_override',
			'reported_content',
			'searches_logged',
			'sessions',
			'shopping_logging',
			'sites_advert_pings',
			'sites_deletion_codes',
			'sites_email',
			'sms_log',
			'staff_tips_dismissed',
			'task_queue',
			'temp_block_permissions',
			'test_sections',
			'translate_history',
			'trans_expecting',
			'tutorial_links',
			'url_id_monikers',
			'url_title_cache',
			'validated_once',
			'video_transcoding',
			'workflow_content',
			'workflow_content_status',
			'workflow_permissions',
			'workflow_requirements',

			// You should process orders before importing
			'shopping_cart',
			'shopping_order',
			'shopping_order_addresses',
			'shopping_order_details',

			// These are imported, but the test can't detect it
			'catalogue_efv_float',
			'catalogue_efv_integer',
		);

		$c=file_get_contents(get_file_base().'/sources/hooks/modules/admin_import/ocp_merge.php');
		$tables=$GLOBALS['SITE_DB']->query_select('db_meta',array('DISTINCT m_table'));
		foreach ($tables as $table)
		{
			if (!in_array($table['m_table'],$non_core_tables))
				$this->assertTrue(strpos($c,$table['m_table'])!==false,'No import defined for '.$table['m_table']);
		}
	}
}
