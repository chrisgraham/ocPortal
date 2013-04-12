<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2013

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		core
 */

// Find ocPortal base directory, and chdir into it
global $FILE_BASE,$RELATIVE_PATH;
$FILE_BASE=(strpos(__FILE__,'./')===false)?__FILE__:realpath(__FILE__);
$FILE_BASE=dirname($FILE_BASE);
if (!is_file($FILE_BASE.'/sources/global.php')) // Need to navigate up a level further perhaps?
{
	$RELATIVE_PATH=basename($FILE_BASE);
	$FILE_BASE=dirname($FILE_BASE);
} else
{
	$RELATIVE_PATH='';
}
@chdir($FILE_BASE);

global $FORCE_INVISIBLE_GUEST;
$FORCE_INVISIBLE_GUEST=0;
if (!is_file($FILE_BASE.'/sources/global.php')) exit('<!DOCTYPE html>'.chr(10).'<html lang="EN"><head><title>Critical startup error</title></head><body><h1>ocPortal startup error</h1><p>The second most basic ocPortal startup file, sources/global.php, could not be located. This is almost always due to an incomplete upload of the ocPortal system, so please check all files are uploaded correctly.</p><p>Once all ocPortal files are in place, ocPortal must actually be installed by running the installer. You must be seeing this message either because your system has become corrupt since installation, or because you have uploaded some but not all files from our manual installer package: the quick installer is easier, so you might consider using that instead.</p><p>ocProducts maintains full documentation for all procedures and tools, especially those for installation. These may be found on the <a href="http://ocportal.com">ocPortal website</a>. If you are unable to easily solve this problem, we may be contacted from our website and can help resolve it for you.</p><hr /><p style="font-size: 0.8em">ocPortal is a website engine created by ocProducts.</p></body></html>'); require($FILE_BASE.'/sources/global.php');

// Put code that you temporarily want executed into the function. DELETE THE CODE WHEN YOU'RE DONE.
// This is useful when performing quick and dirty upgrades (e.g. adding tables to avoid a reinstall)

require_code('database_action');
require_code('config2');
require_code('menus2');
$out=execute_temp();
if (!headers_sent())
{
	header('Content-Type: text/plain');
	@ini_set('ocproducts.xss_detect','0');
	if (!is_null($out)) echo is_object($out)?$out->evaluate():(is_bool($out)?($out?'true':'false'):$out);
	echo do_lang('SUCCESS');
}

/**
 * Execute some temporary code put into this function.
 *
 * @return  mixed		Arbitrary result to output, if no text has already gone out
 */
function execute_temp()
{
	add_config_option('ENABLE_HIGHLIGHT_NAME','enable_highlight_name','tick','return \'1\';','SECTION_FORUMS','USERNAMES_AND_PASSWORDS');
	add_config_option('ENABLE_USER_ONLINE_GROUPS','enable_user_online_groups','tick','return \'1\';','','');
	add_config_option('ALLOW_AUTO_NOTIFICATIONS','allow_auto_notifications','tick','return \'1\';','','');
	add_config_option('FINISH_PROFILE','finish_profile','tick','return \'1\';','','');
	add_config_option('USERNAME_PROFILE_LINKS','username_profile_links','tick','return \'0\';','','');
	add_config_option('SHOW_EMPTY_CPFS','show_empty_cpfs','tick','return \'0\';','','');
	add_config_option('SIMPLIFY_PRIVACY_OPTIONS','simplify_privacy_options','tick','return \'0\';','','');
	add_config_option('ENABLE_PRIVACY_TAB','enable_privacy_tab','tick','return \'1\';','','');
	add_config_option('SEQ_POST_IDS','seq_post_ids','tick','return \'0\';','','');
	add_config_option('THREADED_BUTTONS','threaded_buttons','tick','return \'1\';','','');
	add_config_option('MAX_FORUM_DETAIL','max_forum_detail','line','return \'100\';','','');
	add_config_option('MAX_FORUM_INSPECT','max_forum_inspect','line','return \'300\';','','');
	add_config_option('ENABLE_MARK_FORUM_READ','enable_mark_forum_read','tick','return \'1\';','','');
	add_config_option('ENABLE_MARK_TOPIC_UNREAD','enable_mark_topic_unread','tick','return \'1\';','','');
	add_config_option('DISABLE_FORUM_DUPE_BUTTONS','disable_forum_dupe_buttons','tick','return \'0\';','','');
	add_config_option('ENABLE_PT_FILTERING','enable_pt_filtering','tick','return \'1\';','','');
	add_config_option('INLINE_PP_ADVERTISE','inline_pp_advertise','tick','return \'1\';','','');
	add_config_option('ENABLE_MULTI_QUOTE','enable_multi_quote','tick','return \'1\';','','');
	add_config_option('ENABLE_ADD_TOPIC_BTN_IN_TOPIC','enable_add_topic_btn_in_topic','tick','return \'1\';','','');
	add_config_option('ENABLE_SKIP_SIG','enable_skip_sig','tick','return \'1\';','','');
	add_config_option('ENABLE_VIEWS_SIGS_OPTION','enable_views_sigs_option','tick','return \'1\';','','');
	add_config_option('ENABLE_PT_RESTRICT','enable_pt_restrict','tick','return \'1\';','','');
	add_config_option('ENABLE_SUNK','enable_sunk','tick','return \'1\';','','');
	add_config_option('ENABLE_POST_EMPHASIS','enable_post_emphasis','tick','return \'1\';','','');
	add_config_option('POLL_MEMBER_IP_RESTRICT','poll_member_ip_restrict','tick','return \'1\';','','');
	add_config_option('DISABLE_ECARDS','disable_ecards','tick','return \'0\';','','');
	add_config_option('GALLERY_FLOW_IS','gallery_flow_is','tick','return \'0\';','','');
	add_config_option('GALLERY_MEMBER_SYNCED','gallery_member_synced','tick','return \'1\';','','');
	add_config_option('GALLERY_WATERMARKS','gallery_watermarks','tick','return \'1\';','','');
	add_config_option('GALLERY_PERMISSIONS','gallery_permissions','tick','return \'1\';','','');
	add_config_option('GALLERY_REP_IMAGE','gallery_rep_image','tick','return \'1\';','','');
	add_config_option('GALLERY_FEEDBACK_FIELDS','gallery_feedback_fields','tick','return \'1\';','','');
	add_config_option('MANUAL_GALLERY_CODENAME','manual_gallery_codename','tick','return \'1\';','','');
	add_config_option('MANUAL_GALLERY_PARENT','manual_gallery_parent','tick','return \'1\';','','');
	add_config_option('MANUAL_GALLERY_MEDIA_TYPES','manual_gallery_media_types','tick','return \'1\';','','');
	add_config_option('PERSONAL_UNDER_MEMBERS','personal_under_members','tick','return \'0\';','','');
	add_config_option('ENABLE_CSV_RECOMMEND','enable_csv_recommend','tick','return \'1\';','','');
	add_config_option('ENABLE_BOOLEAN_SEARCH','enable_boolean_search','tick','return \'1\';','','');
	add_config_option('ENABLE_SECONDARY_NEWS','enable_secondary_news','tick','return \'1\';','','');
	add_config_option('PRIMARY_PAYPAL_EMAIL','primary_paypal_email','line','return \'\';','','');
	add_config_option('GIFT_REWARD_CHANCE','gift_reward_chance','line','return \'\';','','');
	add_config_option('GIFT_REWARD_AMOUNT','gift_reward_amount','line','return \'\';','','');
	add_config_option('CHAT_MESSAGE_CHECK_INTERVAL','chat_message_check_interval','line','return \'5000\';','','');
	add_config_option('CHAT_TRANSITORY_ALERT_TIME','chat_transitory_alert_time','line','return \'7000\';','','');
	add_config_option('CAPTCHA_SINGLE_GUESS','captcha_single_guess','tick','return \'0\';','','');
	add_config_option('FORCE_HTML_ONLY','force_html_only','tick','return \'0\';','','');
	add_config_option('WELCOME_NW_CHOICE','welcome_nw_choice','line','return \'\';','','');
	add_config_option('DLOAD_SEARCH_INDEX','dload_search_index','tick','return \'1\';','','');
	add_config_option('DISABLE_ANIMATIONS','disable_animations','tick','return \'0\';','','');
	add_config_option('BREADCRUMB_CROP_LENGTH','breadcrumb_crop_length','line','return \'\';','','');
	add_config_option('ENABLE_STAFF_NOTES','enable_staff_notes','tick','return \'1\';','','');
	add_config_option('DISABLE_THEME_IMG_BUTTONS','disable_theme_img_buttons','tick','return \'0\';','','');
	add_config_option('CALL_HOME','call_home','tick','return \'1\';','SITE','GENERAL');
	add_config_option('ENABLE_SEO_FIELDS','enable_seo_fields','list','return \'yes\';','','',0,'yes|no|only_on_edit');
	add_config_option('FORCE_LOCAL_TEMP_DIR','force_local_temp_dir','tick','return \'0\';','','');
	add_config_option('JPEG_QUALITY','jpeg_quality','line','return \'\';','SITE','GENERAL');
	add_config_option('PROXY','proxy','line','return \'NULL\';','SITE','GENERAL');
	add_config_option('PROXY_PORT','proxy_port','line','return \'NULL\';','SITE','GENERAL');
	add_config_option('PROXY_USER','proxy_user','line','return \'NULL\';','SITE','GENERAL');
	add_config_option('PROXY_PASSWORD','proxy_password','line','return \'NULL\';','SITE','GENERAL');
	add_config_option('MINUTES_BETWEEN_SENDS','minutes_between_sends','line','return \'10\';','SITE','GENERAL');
	add_config_option('MAILS_PER_SEND','mails_per_send','line','return \'60\';','SITE','GENERAL');
	add_config_option('SIMPLIFY_WYSIWYG_BY_PERMISSIONS','simplify_wysiwyg_by_permissions','tick','return \'0\';','SITE','_COMCODE');
	add_config_option('MAX_MONIKER_LENGTH','max_moniker_length','line','return \'\';','','');
	add_config_option('GOOGLE_TRANSLATE_API_KEY','google_translate_api_key','line','return \'\';','SITE','GENERAL');
	add_config_option('CLEANUP_FILES','cleanup_files','tick','return \'0\';','','');
	add_config_option('EDIT_UNDER','edit_under','tick','return \'1\';','','');
	add_config_option('USE_TRUE_FROM','use_true_from','tick','return \'0\';','','');
	add_config_option('ENABLE_FEEDBACK','enable_feedback','tick','return \'1\';','','');
	add_config_option('NO_AUTO_META','no_auto_meta','tick','return \'0\';','','');
	add_config_option('SESSION_PRUDENCE','session_prudence','tick','return \'0\';','','');
	add_config_option('ALLOW_OWN_RATE','allow_own_rate','tick','return \'0\';','','');
	add_config_option('MD_DEFAULT_SORT_ORDER','md_default_sort_order','list','return \'ASC\';','','',0,'ASC|DESC');
	add_config_option('GALLERY_ENTRIES_FLOW_PER_PAGE','gallery_entries_flow_per_page','line','return \'\';','','');

	add_config_option('important_groups_per_page','important_groups_per_page','line','return \'50\';','','');
	add_config_option('normal_groups_per_page','normal_groups_per_page','line','return \'20\';','','');
	add_config_option('members_per_page','members_per_page','line','return \'50\';','','');
	add_config_option('search_results_per_page','search_results_per_page','line','return \'10\';','','');
	add_config_option('gallery_entries_regular_per_page','gallery_entries_regular_per_page','line','return \'30\';','','');
	add_config_option('download_subcats_per_page','download_subcats_per_page','line','return \'30\';','FEATURE','SECTION_DOWNLOADS');
	add_config_option('download_entries_per_page','download_entries_per_page','line','return \'30\';','FEATURE','SECTION_DOWNLOADS');
	add_config_option('catalogue_subcats_per_page','catalogue_subcats_per_page','line','return \'30\';','','');
	add_config_option('catalogue_entries_per_page','catalogue_entries_per_page','line','return \'30\';','','');
	add_config_option('point_logs_per_page','point_logs_per_page','line','return \'10\';','','');
	add_config_option('news_categories_per_page','news_categories_per_page','line','return \'30\';','','');
	add_config_option('news_entries_per_page','news_entries_per_page','line','return \'30\';','','');
	add_config_option('awarded_items_per_page','awarded_items_per_page','line','return \'20\';','','');
	add_config_option('galleries_default_sort_order','galleries_default_sort_order','list','return \'DESC\';','','',0,'ASC|DESC');
	add_config_option('downloads_default_sort_order','downloads_default_sort_order','list','return \'ASC\';','FEATURE','SECTION_DOWNLOADS',0,'ASC|DESC');
	add_config_option('subgallery_link_limit','subgallery_link_limit','line','return \'200\';','','');
	add_config_option('general_safety_listing_limit','general_safety_listing_limit','line','return \'400\';','SITE','GENERAL');
}
