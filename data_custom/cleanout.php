<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

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

global $NON_PAGE_SCRIPT;
$NON_PAGE_SCRIPT=1;
global $FORCE_INVISIBLE_GUEST;
$FORCE_INVISIBLE_GUEST=0;
if (!is_file($FILE_BASE.'/sources/global.php')) exit('<!DOCTYPE html>'.chr(10).'<html lang="EN"><head><title>Critical startup error</title></head><body><h1>ocPortal startup error</h1><p>The second most basic ocPortal startup file, sources/global.php, could not be located. This is almost always due to an incomplete upload of the ocPortal system, so please check all files are uploaded correctly.</p><p>Once all ocPortal files are in place, ocPortal must actually be installed by running the installer. You must be seeing this message either because your system has become corrupt since installation, or because you have uploaded some but not all files from our manual installer package: the quick installer is easier, so you might consider using that instead.</p><p>ocProducts maintains full documentation for all procedures and tools, especially those for installation. These may be found on the <a href="http://ocportal.com">ocPortal website</a>. If you are unable to easily solve this problem, we may be contacted from our website and can help resolve it for you.</p><hr /><p style="font-size: 0.8em">ocPortal is a website engine created by ocProducts.</p></body></html>'); require($FILE_BASE.'/sources/global.php');

// Put code that you temporarily want executed into the function. DELETE THE CODE WHEN YOU'RE DONE.
// This is useful when performing quick and dirty upgrades (e.g. adding tables to avoid a reinstall)

$out=cleanup();
if (!headers_sent())
{
	header('Content-Type: text/plain; charset='.get_charset());
	safe_ini_set('ocproducts.xss_detect','0');
	if (!is_null($out)) echo is_object($out)?$out->evaluate():(is_bool($out)?($out?'true':'false'):$out);
	echo do_lang('SUCCESS');
}

/**
 * Execute some temporary code put into this function.
 *
 * @return  mixed		Arbitrary result to output, if no text has already gone out
 */
function cleanup()
{
	$password=post_param('password',NULL);
	if (is_null($password))
	{
		@exit('<form action="#" method="post"><label>Master password <input type="password" name="password" value="" /></label><input type="submit" value="Delete programmed data" /></form>');
	}
	if (!check_master_password($password)) warn_exit('Access denied - you must pass the master password through correctly');

	/* Customise this. This is the list of delete functions needed */
	$purge=array(
		'delete_calendar_event',
		'delete_news_category',
		'delete_news',
		'ocf_delete_topic',
		'ocf_delete_forum',
		'ocf_delete_category',
		'ocf_delete_group',
		'ocf_delete_member',
	);

	$aggressive_meta_cleanup=true;
	$log_cache_wip_cleanup=true;
	$aggressive_action_cleanup=true;
	$clean_all_attachments=true;

	/* Actioning code follows... */

	if (function_exists('set_time_limit')) @set_time_limit(0);

	$GLOBALS['SITE_INFO']['no_email_output']='1';

	$purgeable=array(
		array(
			'delete_author',
			'authors',
			'authors',
			'author',
			array(),
		),

		array(
			'delete_award_type',
			'awards',
			'award_types',
			'id',
			array(),
		),

		array(
			'delete_bookmark',
			'bookmarks',
			'bookmarks',
			'id',
			array(),
		),

		array(
			'delete_event_type',
			'calendar2',
			'calendar_types',
			'id',
			array(db_get_first_id(),db_get_first_id()+1),
		),

		array(
			'delete_calendar_event',
			'calendar2',
			'calendar_events',
			'id',
			array(),
		),

		array(
			'delete_chatroom',
			'chat2',
			'chat_rooms',
			'room_name',
			array(),
		),

		array(
			'delete_download',
			'downloads2',
			'download_downloads',
			'id',
			array(),
		),

		array(
			'delete_download_licence',
			'downloads2',
			'download_licences',
			'id',
			array(),
		),

		array(
			'delete_download_category',
			'downloads2',
			'download_categories',
			'id',
			array(db_get_first_id()),
		),

		array(
			'delete_usergroup_subscription',
			'ecommerce',
			'f_usergroup_subs',
			'id',
			array(),
		),

		array(
			'delete_flagrant',
			'flagrant',
			'text',
			'id',
			array(),
		),

		array(
			'delete_image',
			'galleries2',
			'images',
			'id',
			array(),
		),

		array(
			'delete_video',
			'galleries2',
			'videos',
			'id',
			array(),
		),

		array(
			'delete_gallery',
			'galleries2',
			'galleries',
			'name',
			array('root'),
		),

		array(
			'delete_iotd',
			'iotds2',
			'iotd',
			'id',
			array(),
		),

		/*array( Probably unwanted
			'delete_menu_item',
			'menus2',
			'menu_items',
			'id',
		),*/

		array(
			'delete_news_category',
			'news',
			'news_categories',
			'id',
			array(db_get_first_id()),
		),

		array(
			'delete_news',
			'news',
			'news',
			'id',
			array(),
		),

		array(
			'delete_newsletter',
			'newsletter',
			'newsletters',
			'id',
			array(db_get_first_id()),
		),

		array(
			'ocf_delete_topic',
			'ocf_topics_action2',
			'f_topics',
			'id',
			array(),
			array('',NULL,false),
		),

		array(
			'ocf_delete_forum',
			'ocf_forums_action2',
			'f_forums',
			'id',
			array(db_get_first_id()),
		),

		array(
			'ocf_delete_category',
			'ocf_forums_action2',
			'f_categories',
			'id',
			array(db_get_first_id()),
		),

		array(
			'ocf_delete_post_template',
			'ocf_general_action2',
			'f_post_templates',
			'id',
			array(),
		),

		/*array(	Probably not wanted
			'ocf_delete_emoticon',
			'ocf_general_action2',
			'f_emoticons',
			'e_code',
			array(),
		),*/

		array(
			'ocf_delete_welcome_email',
			'ocf_general_action2',
			'f_welcome_emails',
			'id',
			array(),
		),

		array(
			'ocf_delete_group',
			'ocf_groups_action2',
			'f_groups',
			'id',
			array(db_get_first_id(),db_get_first_id()+1,db_get_first_id()+2,db_get_first_id()+3,db_get_first_id()+4,db_get_first_id()+5,db_get_first_id()+6,db_get_first_id()+7,db_get_first_id()+8),
		),

		array(
			'ocf_delete_member',
			'ocf_members_action2',
			'f_members',
			'id',
			array(db_get_first_id(),db_get_first_id()+1),
		),

		/*array(	Probably not wanted
			'ocf_delete_custom_field',
			'ocf_members_action2',
			'f_custom_fields',
			'id',
			array(),
		),*/

		array(
			'ocf_delete_warning',
			'ocf_moderation_action2',
			'f_warnings',
			'id',
			array(),
		),

		array(
			'ocf_delete_multi_moderation',
			'ocf_moderation_action2',
			'f_multi_moderations',
			'id',
			array(db_get_first_id()),
		),

		array(
			'delete_poll',
			'polls',
			'f_polls',
			'id',
			array(),
		),

		array(
			'delete_quiz',
			'quiz',
			'quizzes',
			'id',
			array(),
		),

		array(
			'delete_ticket_type',
			'tickets2',
			'ticket_types',
			'ticket_type',
			array(db_get_first_id()),
		),

		array(
			'actual_delete_catalogue',
			'catalogues2',
			'catalogues',
			'c_name',
			array(),
		),

		array(
			'actual_delete_catalogue_category',
			'catalogues2',
			'catalogue_categories',
			'id',
			array(),
		),

		array(
			'actual_delete_catalogue_entry',
			'catalogues2',
			'catalogue_entries',
			'id',
			array(),
		),

		/*array(	Probably not wanted
			'actual_delete_zone',
			'zones2',
			'zones',
			'zone_name',
			array('','site','adminzone','cms','collaboration','forum'),
		),*/

		/*array(	Probably not wanted
			'delete_ocp_page',
			'zones3',
			'comcode_pages',
			array('the_zone','the_page'),
			array(
				array('adminzone','netlink'),
				array('adminzone','panel_top'),
				array('adminzone','quotes'),
				array('adminzone','start'),
				array('cms','panel_top'),
				array('collaboration','about'),
				array('collaboration','panel_left'),
				array('collaboration','start'),
				array('forum','panel_left'),
				array('site','advertise'),
				array('site','donate'),
				array('site','guestbook'),
				array('site','help'),
				array('site','panel_left'),
				array('site','panel_right'),
				array('site','start'),
				array('site','userguide_chatcode'),
				array('site','userguide_comcode'),
				array('','404'),
				array('','feedback'),
				array('','keymap'),
				array('','panel_bottom'),
				array('','panel_left'),
				array('','panel_right'),
				array('','panel_top'),
				array('','privacy'),
				array('','recommend_help'),
				array('','rules'),
				array('','sitemap'),
				array('','start'),
			),
		),*/

		array(
			'cedi_delete_post',
			'cedi',
			'seedy_posts',
			'id',
			array(),
		),

		array(
			'cedi_delete_page',
			'cedi',
			'seedy_pages',
			'id',
			array(db_get_first_id()),
		),

		/*wordfilter - not really wanted */
	);

	$GLOBALS['NO_DB_SCOPE_CHECK']=true;

	foreach ($purgeable as $p)
	{
		list($function,$codefile,$table,$id_field,$skip)=$p;
		$extra_params=array_key_exists(5,$p)?$p[5]:array();
		if (in_array($function,$purge))
		{
			require_code($codefile);

			$start=0;
			do
			{
				$select=is_array($id_field)?$id_field:array($id_field);
				if ($function=='actual_delete_catalogue_category')
				{
					$select[]='cc_parent_id';
					$select[]='c_name';
				}
				$rows=$GLOBALS['SITE_DB']->query_select($table,$select,NULL,'',100,$start);
				foreach ($rows as $i=>$row)
				{
					if (($function=='actual_delete_catalogue_category') && ($row['cc_parent_id']===NULL) && ($GLOBALS['SITE_DB']->query_value('catalogue_catalogues','c_is_tree',array('c_name'=>$row['c_name']))==1))
					{
						unset($rows[$i]);
						continue;
					}

					if (($function=='ocf_delete_member') && ($GLOBALS['IS_SUPER_ADMIN']->get_member()))
					{
						$GLOBALS['SITE_DB']->query_update('comcode_pages',array('p_submitter'=>2),array('p_submitter'=>$row['id']));
					}

					if (in_array(is_array($id_field)?$row:$row[$id_field],$skip))
					{
						unset($rows[$i]);
						continue;
					}

					call_user_func_array($function,array_merge($row,$extra_params));
				}
				//$start+=100;	Actually, don't do this - as deletion will have changed offsets
			}
			while (count($rows)!=0);
		}
	}

	if ($aggressive_meta_cleanup)
	{
		$GLOBALS['SITE_DB']->query_delete('url_id_monikers');
		$GLOBALS['SITE_DB']->query_delete('chat_buddies');
		$GLOBALS['SITE_DB']->query_delete('transactions');
		$GLOBALS['SITE_DB']->query_delete('trans_expecting');
		$GLOBALS['SITE_DB']->query_delete('trackbacks');
		$GLOBALS['SITE_DB']->query_delete('subscriptions');
		$GLOBALS['SITE_DB']->query_delete('invoices');
		$GLOBALS['SITE_DB']->query_delete('review_supplement');
		$GLOBALS['SITE_DB']->query_delete('rating');
		$GLOBALS['SITE_DB']->query_delete('notifications_enabled');
	}

	if ($clean_all_attachments)
	{
		deldir_contents(get_custom_file_base().'/uploads/attachments',true);
		$GLOBALS['SITE_DB']->query_delete('attachment_refs');
		$GLOBALS['SITE_DB']->query_delete('attachments');
	}

	if ($log_cache_wip_cleanup)
	{
		$GLOBALS['SITE_DB']->query_delete('video_transcoding');
		$GLOBALS['SITE_DB']->query_delete('stats');
		$GLOBALS['SITE_DB']->query_delete('f_moderator_logs');
		$GLOBALS['SITE_DB']->query_delete('adminlogs');
		$GLOBALS['SITE_DB']->query_delete('import_id_remap');
		$GLOBALS['SITE_DB']->query_delete('import_parts_done');
		$GLOBALS['SITE_DB']->query_delete('import_session');
		$GLOBALS['SITE_DB']->query_delete('incoming_uploads');
		deldir_contents(get_custom_file_base().'/uploads/incoming_uploads',true);
		deldir_contents(get_custom_file_base().'/uploads/auto_thumbs',true);
		$GLOBALS['SITE_DB']->query_delete('hackattack');
		$GLOBALS['SITE_DB']->query_delete('link_tracker');
		$GLOBALS['SITE_DB']->query_delete('logged_mail_messages');
		$GLOBALS['SITE_DB']->query_delete('searches_logged');
		$GLOBALS['SITE_DB']->query_delete('sessions');
		$GLOBALS['SITE_DB']->query_delete('failedlogins');
		$GLOBALS['SITE_DB']->query_delete('autosave');
		$GLOBALS['SITE_DB']->query_delete('edit_pings');
		$GLOBALS['SITE_DB']->query_delete('f_read_logs');
		$GLOBALS['SITE_DB']->query_delete('leader_board');
		$GLOBALS['SITE_DB']->query_delete('member_tracking');
		$GLOBALS['SITE_DB']->query_delete('messages_to_render');
		$GLOBALS['SITE_DB']->query_delete('security_images');
		$GLOBALS['SITE_DB']->query_delete('sms_log');
		$GLOBALS['SITE_DB']->query_delete('temp_block_permissions');
		$GLOBALS['SITE_DB']->query_delete('url_title_cache');
		delete_value('users_online');
		delete_value('user_peak');
		delete_value('ocf_topic_count');
		delete_value('ocf_post_count');
		delete_value('ocf_newest_member_id');
		delete_value('ocf_newest_member_username');
		delete_value('last_space_check');
		delete_value('ocf_member_count');
		delete_value('last_occle_command');
		delete_value('site_bestmember');
		set_long_value('THEME_IMG_DIMS',NULL);
	}

	if ($aggressive_action_cleanup)
	{
		$l=$GLOBALS['SITE_DB']->query_select('gifts',array('reason AS l'));
		foreach ($l as $_l) delete_lang($_l['l']);
		$GLOBALS['SITE_DB']->query_delete('gifts');

		$l=$GLOBALS['SITE_DB']->query_select('chargelog',array('reason AS l'));
		foreach ($l as $_l) delete_lang($_l['l']);
		$GLOBALS['SITE_DB']->query_delete('chargelog');

		$GLOBALS['SITE_DB']->query_delete('seedy_changes');
		$GLOBALS['SITE_DB']->query_delete('usersubmitban_ip');
		$GLOBALS['SITE_DB']->query_delete('usersubmitban_member');
		$GLOBALS['SITE_DB']->query_delete('usersonline_track');
		$GLOBALS['SITE_DB']->query_delete('f_saved_warnings');
		$GLOBALS['SITE_DB']->query_delete('f_special_pt_access');
	}
}
