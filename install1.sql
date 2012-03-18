DROP TABLE IF EXISTS `ocp_addons`;

CREATE TABLE `ocp_addons` (
  `addon_name` varchar(255) NOT NULL,
  `addon_author` varchar(255) NOT NULL,
  `addon_organisation` varchar(255) NOT NULL,
  `addon_version` varchar(255) NOT NULL,
  `addon_description` longtext NOT NULL,
  `addon_install_time` int(10) unsigned NOT NULL,
  PRIMARY KEY (`addon_name`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp_addons_dependencies`;

CREATE TABLE `ocp_addons_dependencies` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `addon_name` varchar(255) NOT NULL,
  `addon_name_dependant_upon` varchar(255) NOT NULL,
  `addon_name_incompatibility` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp_addons_files`;

CREATE TABLE `ocp_addons_files` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `addon_name` varchar(255) NOT NULL,
  `filename` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp_adminlogs`;

CREATE TABLE `ocp_adminlogs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `the_type` varchar(80) NOT NULL,
  `param_a` varchar(80) NOT NULL,
  `param_b` varchar(255) NOT NULL,
  `the_user` int(11) NOT NULL,
  `ip` varchar(40) NOT NULL,
  `date_and_time` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `xas` (`the_user`),
  KEY `ts` (`date_and_time`),
  KEY `aip` (`ip`),
  KEY `athe_type` (`the_type`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp_attachment_refs`;

CREATE TABLE `ocp_attachment_refs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `r_referer_type` varchar(80) NOT NULL,
  `r_referer_id` varchar(80) NOT NULL,
  `a_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp_attachments`;

CREATE TABLE `ocp_attachments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `a_member_id` int(11) NOT NULL,
  `a_file_size` int(11) DEFAULT NULL,
  `a_url` varchar(255) NOT NULL,
  `a_description` varchar(255) NOT NULL,
  `a_thumb_url` varchar(255) NOT NULL,
  `a_original_filename` varchar(255) NOT NULL,
  `a_num_downloads` int(11) NOT NULL,
  `a_last_downloaded_time` int(11) DEFAULT NULL,
  `a_add_time` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ownedattachments` (`a_member_id`),
  KEY `attachmentlimitcheck` (`a_add_time`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp_authors`;

CREATE TABLE `ocp_authors` (
  `author` varchar(80) NOT NULL,
  `url` varchar(255) NOT NULL,
  `forum_handle` int(11) DEFAULT NULL,
  `description` int(10) unsigned NOT NULL,
  `skills` int(10) unsigned NOT NULL,
  PRIMARY KEY (`author`),
  KEY `findmemberlink` (`forum_handle`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp_autosave`;

CREATE TABLE `ocp_autosave` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `a_member_id` int(11) NOT NULL,
  `a_key` longtext NOT NULL,
  `a_value` longtext NOT NULL,
  `a_time` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `myautosaves` (`a_member_id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp_award_archive`;

CREATE TABLE `ocp_award_archive` (
  `a_type_id` int(11) NOT NULL,
  `date_and_time` int(10) unsigned NOT NULL,
  `content_id` varchar(80) NOT NULL,
  `member_id` int(11) NOT NULL,
  PRIMARY KEY (`a_type_id`,`date_and_time`),
  KEY `awardquicksearch` (`content_id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp_award_types`;

CREATE TABLE `ocp_award_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `a_title` int(10) unsigned NOT NULL,
  `a_description` int(10) unsigned NOT NULL,
  `a_points` int(11) NOT NULL,
  `a_content_type` varchar(80) NOT NULL,
  `a_hide_awardee` tinyint(1) NOT NULL,
  `a_update_time_hours` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2;

insert into `ocp_award_types` values('1','94','95','0','download','1','168');

DROP TABLE IF EXISTS `ocp_banner_clicks`;

CREATE TABLE `ocp_banner_clicks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `c_date_and_time` int(10) unsigned NOT NULL,
  `c_member_id` int(11) NOT NULL,
  `c_ip_address` varchar(40) NOT NULL,
  `c_source` varchar(80) NOT NULL,
  `c_banner_id` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `clicker_ip` (`c_ip_address`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp_banner_types`;

CREATE TABLE `ocp_banner_types` (
  `id` varchar(80) NOT NULL,
  `t_is_textual` tinyint(1) NOT NULL,
  `t_image_width` int(11) NOT NULL,
  `t_image_height` int(11) NOT NULL,
  `t_max_file_size` int(11) NOT NULL,
  `t_comcode_inline` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `hottext` (`t_comcode_inline`)
) ENGINE=MyISAM;

insert into `ocp_banner_types` values('','0','468','60','80','0');

DROP TABLE IF EXISTS `ocp_banners`;

CREATE TABLE `ocp_banners` (
  `name` varchar(80) NOT NULL,
  `expiry_date` int(10) unsigned DEFAULT NULL,
  `submitter` int(11) NOT NULL,
  `img_url` varchar(255) NOT NULL,
  `b_title_text` varchar(255) NOT NULL,
  `the_type` tinyint(4) NOT NULL,
  `caption` int(10) unsigned NOT NULL,
  `campaign_remaining` int(11) NOT NULL,
  `site_url` varchar(255) NOT NULL,
  `hits_from` int(11) NOT NULL,
  `views_from` int(11) NOT NULL,
  `hits_to` int(11) NOT NULL,
  `views_to` int(11) NOT NULL,
  `importance_modulus` int(11) NOT NULL,
  `notes` longtext NOT NULL,
  `validated` tinyint(1) NOT NULL,
  `add_date` int(10) unsigned NOT NULL,
  `edit_date` int(10) unsigned DEFAULT NULL,
  `b_type` varchar(80) NOT NULL,
  PRIMARY KEY (`name`),
  KEY `banner_child_find` (`b_type`),
  KEY `the_type` (`the_type`),
  KEY `expiry_date` (`expiry_date`),
  KEY `badd_date` (`add_date`),
  KEY `topsites` (`hits_from`,`hits_to`),
  KEY `campaign_remaining` (`campaign_remaining`),
  KEY `bvalidated` (`validated`)
) ENGINE=MyISAM;

insert into `ocp_banners` values('advertise_here',null,'1','data/images/advertise_here.png','','2','142','0','http://chris4.com/git/site/index.php?page=advertise','0','0','0','0','10','Provided as default. This is a default banner (it shows when others are not available).','1','1332090674',null,''),
 ('donate',null,'1','data/images/donate.png','','0','143','0','http://chris4.com/git/site/index.php?page=donate','0','0','0','0','30','Provided as default.','1','1332090674',null,'');

DROP TABLE IF EXISTS `ocp_blocks`;

CREATE TABLE `ocp_blocks` (
  `block_name` varchar(80) NOT NULL,
  `block_author` varchar(80) NOT NULL,
  `block_organisation` varchar(80) NOT NULL,
  `block_hacked_by` varchar(80) NOT NULL,
  `block_hack_version` int(11) DEFAULT NULL,
  `block_version` int(11) NOT NULL,
  PRIMARY KEY (`block_name`)
) ENGINE=MyISAM;

insert into `ocp_blocks` values('bottom_forum_news','Chris Graham','ocProducts','',null,'2'),
 ('bottom_news','Chris Graham','ocProducts','',null,'2'),
 ('bottom_rss','Chris Graham','ocProducts','',null,'2'),
 ('main_as_zone_access','Chris Graham','ocProducts','',null,'2'),
 ('main_awards','Chris Graham','ocProducts','',null,'2'),
 ('main_banner_wave','Chris Graham','ocProducts','',null,'2'),
 ('main_block_help','Chris Graham','ocProducts','',null,'2'),
 ('main_cc_embed','Chris Graham','ocProducts','',null,'2'),
 ('main_code_documentor','Chris Graham','ocProducts','',null,'2'),
 ('main_comcode_page_children','Chris Graham','ocProducts','',null,'2'),
 ('main_comments','Chris Graham','ocProducts','',null,'2'),
 ('main_contact_catalogues','Chris Graham','ocProducts','',null,'2'),
 ('main_contact_simple','Chris Graham','ocProducts','',null,'2'),
 ('main_contact_us','Chris Graham','ocProducts','',null,'2'),
 ('main_content','Chris Graham','ocProducts','',null,'2'),
 ('main_count','Chris Graham','ocProducts','',null,'2'),
 ('main_countdown','Chris Graham','ocProducts','',null,'2'),
 ('main_custom_comcode_tags','Chris Graham','ocProducts','',null,'2'),
 ('main_custom_gfx','Chris Graham','ocProducts','',null,'1'),
 ('main_db_notes','Chris Graham','ocProducts','',null,'2'),
 ('main_download_category','Chris Graham','ocProducts','',null,'2'),
 ('main_download_tease','Chris Graham','ocProducts','',null,'2'),
 ('main_emoticon_codes','Chris Graham','ocProducts','',null,'2'),
 ('main_feedback','Chris Graham','ocProducts','',null,'1'),
 ('main_forum_news','Chris Graham','ocProducts','',null,'2'),
 ('main_forum_topics','Chris Graham','ocProducts','',null,'2'),
 ('main_gallery_embed','Chris Graham','ocProducts','',null,'2'),
 ('main_gallery_tease','Chris Graham','ocProducts','',null,'2'),
 ('main_greeting','Chris Graham','ocProducts','',null,'2'),
 ('main_image_fader','Chris Graham','ocProducts','',null,'2'),
 ('main_include_module','Chris Graham','ocProducts','',null,'1'),
 ('main_iotd','Chris Graham','ocProducts','',null,'2'),
 ('main_leader_board','Chris Graham','ocProducts','',null,'3'),
 ('main_multi_content','Chris Graham','ocProducts','',null,'2'),
 ('main_news','Chris Graham','ocProducts','',null,'2'),
 ('main_newsletter_signup','Chris Graham','ocProducts','',null,'2'),
 ('main_notes','Chris Graham','ocProducts','',null,'2'),
 ('main_only_if_match','Chris Graham','ocProducts','',null,'2'),
 ('main_poll','Chris Graham','ocProducts','',null,'2'),
 ('main_quotes','Chris Graham','ocProducts','',null,'2'),
 ('main_rating','Chris Graham','ocProducts','',null,'2'),
 ('main_recent_cc_entries','Chris Graham','ocProducts','',null,'2'),
 ('main_recent_downloads','Chris Graham','ocProducts','',null,'2'),
 ('main_recent_galleries','Chris Graham','ocProducts','',null,'2'),
 ('main_rss','Chris Graham','ocProducts','',null,'3'),
 ('main_screen_actions','Chris Graham','ocProducts','',null,'2'),
 ('main_search','Chris Graham','ocProducts','',null,'2'),
 ('main_sitemap','Chris Graham','ocProducts','',null,'2'),
 ('main_staff_actions','Chris Graham','ocProducts','',null,'2'),
 ('main_staff_checklist','Chris Graham','ocProducts','',null,'4'),
 ('main_staff_links','Jack Franklin','ocProducts','',null,'3'),
 ('main_staff_new_version','Chris Graham','ocProducts','',null,'2'),
 ('main_staff_tips','Chris Graham','ocProducts','',null,'2'),
 ('main_staff_website_monitoring','Jack Franklin','ocProducts','',null,'3'),
 ('main_top_downloads','Chris Graham','ocProducts','',null,'2'),
 ('main_top_galleries','Chris Graham','ocProducts','',null,'2'),
 ('main_topsites','Chris Graham','ocProducts','',null,'2'),
 ('main_trackback','Philip Withnall','ocProducts','',null,'1'),
 ('side_calendar','Chris Graham','ocProducts','',null,'2'),
 ('side_forum_news','Chris Graham','ocProducts','',null,'2'),
 ('side_language','Chris Graham','ocProducts','',null,'2'),
 ('side_network','Chris Graham','ocProducts','',null,'2'),
 ('side_news','Chris Graham','ocProducts','',null,'2'),
 ('side_news_archive','Chris Graham','ocProducts','',null,'2'),
 ('side_news_categories','Chris Graham','ocProducts','',null,'2'),
 ('side_ocf_personal_topics','Chris Graham','ocProducts','',null,'2'),
 ('side_personal_stats','Chris Graham','ocProducts','',null,'2'),
 ('side_printer_friendly','Chris Graham','ocProducts','',null,'2'),
 ('side_root_galleries','Chris Graham','ocProducts','',null,'2'),
 ('side_rss','Chris Graham','ocProducts','',null,'2'),
 ('side_shoutbox','Chris Graham','ocProducts','',null,'3'),
 ('side_stats','Chris Graham','ocProducts','',null,'3'),
 ('side_stored_menu','Chris Graham','ocProducts','',null,'2'),
 ('side_tag_cloud','Chris Graham','ocProducts','',null,'3'),
 ('side_users_online','Chris Graham','ocProducts','',null,'3'),
 ('side_weather','Manuprathap','ocProducts','',null,'6'),
 ('side_zone_jump','Chris Graham','ocProducts','',null,'2');

DROP TABLE IF EXISTS `ocp_bookmarks`;

CREATE TABLE `ocp_bookmarks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `b_owner` int(11) NOT NULL,
  `b_folder` varchar(255) NOT NULL,
  `b_title` varchar(255) NOT NULL,
  `b_page_link` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp_cache`;

CREATE TABLE `ocp_cache` (
  `cached_for` varchar(80) NOT NULL,
  `identifier` varchar(40) NOT NULL,
  `the_value` longtext NOT NULL,
  `date_and_time` int(10) unsigned NOT NULL,
  `the_theme` varchar(80) NOT NULL,
  `lang` varchar(5) NOT NULL,
  `langs_required` longtext NOT NULL,
  PRIMARY KEY (`cached_for`,`identifier`,`the_theme`,`lang`),
  KEY `cached_ford` (`date_and_time`),
  KEY `cached_fore` (`cached_for`),
  KEY `cached_forf` (`lang`),
  KEY `cached_forg` (`identifier`),
  KEY `cached_forh` (`the_theme`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp_cache_on`;

CREATE TABLE `ocp_cache_on` (
  `cached_for` varchar(80) NOT NULL,
  `cache_on` longtext NOT NULL,
  `cache_ttl` int(11) NOT NULL,
  PRIMARY KEY (`cached_for`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp_cached_comcode_pages`;

CREATE TABLE `ocp_cached_comcode_pages` (
  `the_zone` varchar(80) NOT NULL,
  `the_page` varchar(80) NOT NULL,
  `string_index` int(10) unsigned NOT NULL,
  `the_theme` varchar(80) NOT NULL,
  `cc_page_title` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`the_zone`,`the_page`,`the_theme`),
  KEY `ftjoin_ccpt` (`cc_page_title`),
  KEY `ftjoin_ccsi` (`string_index`),
  KEY `ccp_join` (`the_page`,`the_zone`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp_cached_weather_codes`;

CREATE TABLE `ocp_cached_weather_codes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `w_string` varchar(255) NOT NULL,
  `w_code` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp_calendar_events`;

CREATE TABLE `ocp_calendar_events` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `e_submitter` int(11) NOT NULL,
  `e_views` int(11) NOT NULL,
  `e_title` int(10) unsigned NOT NULL,
  `e_content` int(10) unsigned NOT NULL,
  `e_add_date` int(10) unsigned NOT NULL,
  `e_edit_date` int(10) unsigned DEFAULT NULL,
  `e_recurrence` varchar(80) NOT NULL,
  `e_recurrences` int(11) DEFAULT NULL,
  `e_seg_recurrences` tinyint(1) NOT NULL,
  `e_start_year` int(11) NOT NULL,
  `e_start_month` int(11) NOT NULL,
  `e_start_day` int(11) NOT NULL,
  `e_start_hour` int(11) DEFAULT NULL,
  `e_start_minute` int(11) DEFAULT NULL,
  `e_end_year` int(11) DEFAULT NULL,
  `e_end_month` int(11) DEFAULT NULL,
  `e_end_day` int(11) DEFAULT NULL,
  `e_end_hour` int(11) DEFAULT NULL,
  `e_end_minute` int(11) DEFAULT NULL,
  `e_timezone` varchar(80) NOT NULL,
  `e_do_timezone_conv` tinyint(1) NOT NULL,
  `e_is_public` tinyint(1) NOT NULL,
  `e_priority` int(11) NOT NULL,
  `allow_rating` tinyint(1) NOT NULL,
  `allow_comments` tinyint(4) NOT NULL,
  `allow_trackbacks` tinyint(1) NOT NULL,
  `notes` longtext NOT NULL,
  `e_type` int(11) NOT NULL,
  `validated` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `e_views` (`e_views`),
  KEY `ces` (`e_submitter`),
  KEY `publicevents` (`e_is_public`),
  KEY `e_type` (`e_type`),
  KEY `eventat` (`e_start_year`,`e_start_month`,`e_start_day`,`e_start_hour`,`e_start_minute`),
  KEY `e_add_date` (`e_add_date`),
  KEY `validated` (`validated`),
  KEY `ftjoin_etitle` (`e_title`),
  KEY `ftjoin_econtent` (`e_content`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp_calendar_interests`;

CREATE TABLE `ocp_calendar_interests` (
  `i_member_id` int(11) NOT NULL,
  `t_type` int(11) NOT NULL,
  PRIMARY KEY (`i_member_id`,`t_type`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp_calendar_jobs`;

CREATE TABLE `ocp_calendar_jobs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `j_time` int(10) unsigned NOT NULL,
  `j_reminder_id` int(11) DEFAULT NULL,
  `j_member_id` int(11) DEFAULT NULL,
  `j_event_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `applicablejobs` (`j_time`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp_calendar_reminders`;

CREATE TABLE `ocp_calendar_reminders` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `e_id` int(11) NOT NULL,
  `n_member_id` int(11) NOT NULL,
  `n_seconds_before` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp_calendar_types`;

CREATE TABLE `ocp_calendar_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `t_title` int(10) unsigned NOT NULL,
  `t_logo` varchar(255) NOT NULL,
  `t_external_feed` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=9;

insert into `ocp_calendar_types` values('1','144','calendar/system_command',''),
 ('2','145','calendar/general',''),
 ('3','146','calendar/birthday',''),
 ('4','147','calendar/public_holiday',''),
 ('5','148','calendar/vacation',''),
 ('6','149','calendar/appointment',''),
 ('7','150','calendar/commitment',''),
 ('8','151','calendar/anniversary','');

DROP TABLE IF EXISTS `ocp_catalogue_cat_treecache`;

CREATE TABLE `ocp_catalogue_cat_treecache` (
  `cc_id` int(11) NOT NULL,
  `cc_ancestor_id` int(11) NOT NULL,
  PRIMARY KEY (`cc_id`,`cc_ancestor_id`),
  KEY `cc_ancestor_id` (`cc_ancestor_id`)
) ENGINE=MyISAM;

insert into `ocp_catalogue_cat_treecache` values('1','1'),
 ('2','2'),
 ('4','4'),
 ('5','5');

DROP TABLE IF EXISTS `ocp_catalogue_categories`;

CREATE TABLE `ocp_catalogue_categories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `c_name` varchar(80) NOT NULL,
  `cc_title` int(10) unsigned NOT NULL,
  `cc_description` int(10) unsigned NOT NULL,
  `rep_image` varchar(255) NOT NULL,
  `cc_notes` longtext NOT NULL,
  `cc_add_date` int(10) unsigned NOT NULL,
  `cc_parent_id` int(11) DEFAULT NULL,
  `cc_move_target` int(11) DEFAULT NULL,
  `cc_move_days_lower` int(11) NOT NULL,
  `cc_move_days_higher` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `catstoclean` (`cc_move_target`),
  KEY `cataloguefind` (`c_name`),
  KEY `cc_parent_id` (`cc_parent_id`),
  KEY `ftjoin_cctitle` (`cc_title`),
  KEY `ftjoin_ccdescrip` (`cc_description`)
) ENGINE=MyISAM AUTO_INCREMENT=7;

insert into `ocp_catalogue_categories` values('1','projects','162','163','','','1332090683',null,null,'30','60'),
 ('2','hosted','190','191','','','1332090683',null,null,'30','60'),
 ('3','links','196','197','','','1332090683',null,null,'30','60'),
 ('4','faqs','214','215','','','1332090683',null,null,'30','60'),
 ('5','contacts','246','247','','','1332090683',null,null,'30','60'),
 ('6','products','258','259','','','1332090683',null,null,'30','60');

DROP TABLE IF EXISTS `ocp_catalogue_childcountcache`;

CREATE TABLE `ocp_catalogue_childcountcache` (
  `cc_id` int(11) NOT NULL,
  `c_num_rec_children` int(11) NOT NULL,
  `c_num_rec_entries` int(11) NOT NULL,
  PRIMARY KEY (`cc_id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp_catalogue_efv_float`;

CREATE TABLE `ocp_catalogue_efv_float` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cf_id` int(11) NOT NULL,
  `ce_id` int(11) NOT NULL,
  `cv_value` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fcv_value` (`cv_value`),
  KEY `fcf_id` (`cf_id`),
  KEY `fce_id` (`ce_id`),
  KEY `cefv_f_combo` (`ce_id`,`cf_id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp_catalogue_efv_integer`;

CREATE TABLE `ocp_catalogue_efv_integer` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cf_id` int(11) NOT NULL,
  `ce_id` int(11) NOT NULL,
  `cv_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `itv_value` (`cv_value`),
  KEY `icf_id` (`cf_id`),
  KEY `ice_id` (`ce_id`),
  KEY `cefv_i_combo` (`ce_id`,`cf_id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp_catalogue_efv_long`;

CREATE TABLE `ocp_catalogue_efv_long` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cf_id` int(11) NOT NULL,
  `ce_id` int(11) NOT NULL,
  `cv_value` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cefv_l_combo` (`ce_id`,`cf_id`),
  KEY `lcf_id` (`cf_id`),
  KEY `lce_id` (`ce_id`),
  FULLTEXT KEY `lcv_value` (`cv_value`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp_catalogue_efv_long_trans`;

CREATE TABLE `ocp_catalogue_efv_long_trans` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cf_id` int(11) NOT NULL,
  `ce_id` int(11) NOT NULL,
  `cv_value` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cefv_lt_combo` (`ce_id`,`cf_id`),
  KEY `ltcf_id` (`cf_id`),
  KEY `ltce_id` (`ce_id`),
  KEY `ltcv_value` (`cv_value`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp_catalogue_efv_short`;

CREATE TABLE `ocp_catalogue_efv_short` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cf_id` int(11) NOT NULL,
  `ce_id` int(11) NOT NULL,
  `cv_value` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cefv_s_combo` (`ce_id`,`cf_id`),
  KEY `iscv_value` (`cv_value`),
  KEY `scf_id` (`cf_id`),
  KEY `sce_id` (`ce_id`),
  FULLTEXT KEY `scv_value` (`cv_value`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp_catalogue_efv_short_trans`;

CREATE TABLE `ocp_catalogue_efv_short_trans` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cf_id` int(11) NOT NULL,
  `ce_id` int(11) NOT NULL,
  `cv_value` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cefv_st_combo` (`ce_id`,`cf_id`),
  KEY `stcf_id` (`cf_id`),
  KEY `stce_id` (`ce_id`),
  KEY `stcv_value` (`cv_value`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp_catalogue_entries`;

CREATE TABLE `ocp_catalogue_entries` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `c_name` varchar(80) NOT NULL,
  `cc_id` int(11) NOT NULL,
  `ce_submitter` int(11) NOT NULL,
  `ce_add_date` int(10) unsigned NOT NULL,
  `ce_edit_date` int(10) unsigned DEFAULT NULL,
  `ce_views` int(11) NOT NULL,
  `ce_views_prior` int(11) NOT NULL,
  `ce_validated` tinyint(1) NOT NULL,
  `notes` longtext NOT NULL,
  `allow_rating` tinyint(1) NOT NULL,
  `allow_comments` tinyint(4) NOT NULL,
  `allow_trackbacks` tinyint(1) NOT NULL,
  `ce_last_moved` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ce_views` (`ce_views`),
  KEY `ces` (`ce_submitter`),
  KEY `ce_validated` (`ce_validated`),
  KEY `ce_add_date` (`ce_add_date`),
  KEY `ce_c_name` (`c_name`),
  KEY `ce_cc_id` (`cc_id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp_catalogue_entry_linkage`;

CREATE TABLE `ocp_catalogue_entry_linkage` (
  `catalogue_entry_id` int(11) NOT NULL,
  `content_type` varchar(80) NOT NULL,
  `content_id` varchar(80) NOT NULL,
  PRIMARY KEY (`catalogue_entry_id`),
  KEY `custom_fields` (`content_type`,`content_id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp_catalogue_fields`;

CREATE TABLE `ocp_catalogue_fields` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `c_name` varchar(80) NOT NULL,
  `cf_name` int(10) unsigned NOT NULL,
  `cf_description` int(10) unsigned NOT NULL,
  `cf_type` varchar(80) NOT NULL,
  `cf_order` int(11) NOT NULL,
  `cf_defines_order` tinyint(4) NOT NULL,
  `cf_visible` tinyint(1) NOT NULL,
  `cf_searchable` tinyint(1) NOT NULL,
  `cf_default` longtext NOT NULL,
  `cf_required` tinyint(1) NOT NULL,
  `cf_put_in_category` tinyint(1) NOT NULL,
  `cf_put_in_search` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=43;

insert into `ocp_catalogue_fields` values('1','projects','154','155','short_trans','0','1','1','1','','1','1','1'),
 ('2','projects','156','157','user','1','0','1','1','','1','1','1'),
 ('3','projects','158','159','long_trans','2','0','1','1','','1','1','1'),
 ('4','projects','160','161','integer','3','0','1','1','','1','1','1'),
 ('5','modifications','168','169','short_trans','0','1','1','1','','1','1','1'),
 ('6','modifications','170','171','picture','1','0','1','1','','0','1','1'),
 ('7','modifications','172','173','short_trans','2','0','1','1','','1','1','1'),
 ('8','modifications','174','175','url','3','0','1','1','','0','1','1'),
 ('9','modifications','176','177','long_trans','4','0','1','1','','1','1','1'),
 ('10','modifications','178','179','short_text','5','0','1','1','','1','1','1'),
 ('11','hosted','184','185','short_trans','0','1','1','1','','1','1','1'),
 ('12','hosted','186','187','url','1','0','1','1','','0','1','1'),
 ('13','hosted','188','189','long_trans','2','0','1','1','','0','1','1'),
 ('14','links','198','199','short_trans','0','1','1','1','','1','1','1'),
 ('15','links','200','201','url','1','0','1','1','','1','0','1'),
 ('16','links','202','203','long_trans','2','0','1','1','','0','1','1'),
 ('17','faqs','208','209','short_trans','0','0','1','1','','1','1','1'),
 ('18','faqs','210','211','long_trans','1','0','1','1','','1','1','1'),
 ('19','faqs','212','213','auto_increment','2','1','0','1','','0','1','1'),
 ('20','contacts','220','221','short_text','0','0','1','1','','1','1','1'),
 ('21','contacts','222','223','short_text','1','1','1','1','','1','1','1'),
 ('22','contacts','224','225','short_text','2','0','1','1','','1','1','1'),
 ('23','contacts','226','227','short_text','3','0','1','1','','1','1','1'),
 ('24','contacts','228','229','short_text','4','0','1','1','','1','1','1'),
 ('25','contacts','230','231','short_text','5','0','1','1','','1','1','1'),
 ('26','contacts','232','233','short_text','6','0','1','1','','1','1','1'),
 ('27','contacts','234','235','short_text','7','0','1','1','','1','1','1'),
 ('28','contacts','236','237','short_text','8','0','1','1','','1','1','1'),
 ('29','contacts','238','239','short_text','9','0','1','1','','1','1','1'),
 ('30','contacts','240','241','long_text','10','0','1','1','','1','1','1'),
 ('31','contacts','242','243','long_text','11','0','1','1','','1','1','1'),
 ('32','contacts','244','245','picture','12','0','1','1','','1','1','1'),
 ('33','products','260','261','short_trans','0','1','1','1','','1','1','1'),
 ('34','products','262','263','random','1','0','1','1','','1','1','1'),
 ('35','products','264','265','float','2','0','1','1','','1','1','1'),
 ('36','products','266','267','integer','3','0','1','0','','0','1','1'),
 ('37','products','268','269','integer','4','0','0','0','','0','0','0'),
 ('38','products','270','271','list','5','0','0','0','No|Yes','1','0','0'),
 ('39','products','272','273','list','6','0','0','0','0%|5%|17.5%','1','0','0'),
 ('40','products','274','275','picture','7','0','1','1','','0','1','1'),
 ('41','products','276','277','float','8','0','0','0','','1','0','0'),
 ('42','products','278','279','long_trans','9','0','1','1','','1','1','1');

DROP TABLE IF EXISTS `ocp_catalogues`;

CREATE TABLE `ocp_catalogues` (
  `c_name` varchar(80) NOT NULL,
  `c_title` int(10) unsigned NOT NULL,
  `c_description` int(10) unsigned NOT NULL,
  `c_display_type` tinyint(4) NOT NULL,
  `c_is_tree` tinyint(1) NOT NULL,
  `c_notes` longtext NOT NULL,
  `c_add_date` int(10) unsigned NOT NULL,
  `c_submit_points` int(11) NOT NULL,
  `c_ecommerce` tinyint(1) NOT NULL,
  `c_send_view_reports` varchar(80) NOT NULL,
  PRIMARY KEY (`c_name`)
) ENGINE=MyISAM;

insert into `ocp_catalogues` values('projects','152','153','0','0','','1332090683','30','0','never'),
 ('modifications','166','167','1','0','','1332090683','60','0','never'),
 ('hosted','182','183','0','0','','1332090683','0','0','never'),
 ('links','194','195','2','1','','1332090683','0','0','never'),
 ('faqs','206','207','0','0','','1332090683','0','0','never'),
 ('contacts','218','219','0','0','','1332090683','30','0','never'),
 ('products','256','257','1','1','','1332090683','0','1','never');

DROP TABLE IF EXISTS `ocp_chargelog`;

CREATE TABLE `ocp_chargelog` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `amount` int(11) NOT NULL,
  `reason` int(10) unsigned NOT NULL,
  `date_and_time` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp_chat_active`;

CREATE TABLE `ocp_chat_active` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `member_id` int(11) NOT NULL,
  `room_id` int(11) DEFAULT NULL,
  `date_and_time` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `active_ordering` (`date_and_time`),
  KEY `member_select` (`member_id`),
  KEY `room_select` (`room_id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp_chat_blocking`;

CREATE TABLE `ocp_chat_blocking` (
  `member_blocker` int(11) NOT NULL,
  `member_blocked` int(11) NOT NULL,
  `date_and_time` int(10) unsigned NOT NULL,
  PRIMARY KEY (`member_blocker`,`member_blocked`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp_chat_buddies`;

CREATE TABLE `ocp_chat_buddies` (
  `member_likes` int(11) NOT NULL,
  `member_liked` int(11) NOT NULL,
  `date_and_time` int(10) unsigned NOT NULL,
  PRIMARY KEY (`member_likes`,`member_liked`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp_chat_events`;

CREATE TABLE `ocp_chat_events` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `e_type_code` varchar(80) NOT NULL,
  `e_member_id` int(11) NOT NULL,
  `e_room_id` int(11) DEFAULT NULL,
  `e_date_and_time` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `event_ordering` (`e_date_and_time`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp_chat_messages`;

CREATE TABLE `ocp_chat_messages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `system_message` tinyint(1) NOT NULL,
  `ip_address` varchar(40) NOT NULL,
  `room_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `date_and_time` int(10) unsigned NOT NULL,
  `the_message` int(10) unsigned NOT NULL,
  `text_colour` varchar(255) NOT NULL,
  `font_name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ordering` (`date_and_time`),
  KEY `room_id` (`room_id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp_chat_rooms`;

CREATE TABLE `ocp_chat_rooms` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `room_name` varchar(255) NOT NULL,
  `room_owner` int(11) DEFAULT NULL,
  `allow_list` longtext NOT NULL,
  `allow_list_groups` longtext NOT NULL,
  `disallow_list` longtext NOT NULL,
  `disallow_list_groups` longtext NOT NULL,
  `room_language` varchar(5) NOT NULL,
  `c_welcome` int(10) unsigned NOT NULL,
  `is_im` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `room_name` (`room_name`),
  KEY `is_im` (`is_im`,`room_name`),
  KEY `first_public` (`is_im`,`id`),
  KEY `allow_list` (`allow_list`(30))
) ENGINE=MyISAM AUTO_INCREMENT=2;

insert into `ocp_chat_rooms` values('1','General chat',null,'','','','','EN','296','0');

DROP TABLE IF EXISTS `ocp_chat_sound_effects`;

CREATE TABLE `ocp_chat_sound_effects` (
  `s_member` int(11) NOT NULL,
  `s_effect_id` varchar(80) NOT NULL,
  `s_url` varchar(255) NOT NULL,
  PRIMARY KEY (`s_member`,`s_effect_id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp_comcode_pages`;

CREATE TABLE `ocp_comcode_pages` (
  `the_zone` varchar(80) NOT NULL,
  `the_page` varchar(80) NOT NULL,
  `p_parent_page` varchar(80) NOT NULL,
  `p_validated` tinyint(1) NOT NULL,
  `p_edit_date` int(10) unsigned DEFAULT NULL,
  `p_add_date` int(10) unsigned NOT NULL,
  `p_submitter` int(11) NOT NULL,
  `p_show_as_edit` tinyint(1) NOT NULL,
  PRIMARY KEY (`the_zone`,`the_page`),
  KEY `p_submitter` (`p_submitter`),
  KEY `p_add_date` (`p_add_date`),
  KEY `p_validated` (`p_validated`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp_config`;

CREATE TABLE `ocp_config` (
  `the_name` varchar(80) NOT NULL,
  `human_name` varchar(80) NOT NULL,
  `c_set` tinyint(1) NOT NULL,
  `config_value` longtext NOT NULL,
  `the_type` varchar(80) NOT NULL,
  `eval` varchar(255) NOT NULL,
  `the_page` varchar(80) NOT NULL,
  `section` varchar(80) NOT NULL,
  `explanation` varchar(80) NOT NULL,
  `shared_hosting_restricted` tinyint(1) NOT NULL,
  `c_data` varchar(255) NOT NULL,
  PRIMARY KEY (`the_name`)
) ENGINE=MyISAM;

insert into `ocp_config` values('encryption_key','ENCRYPTION_KEY','0','','line','require_code(\'encryption\');return is_encryption_available()?\'\':NULL;','PRIVACY','ADVANCED','CONFIG_OPTION_encryption_key','0',''),
 ('decryption_key','DECRYPTION_KEY','0','','line','require_code(\'encryption\');return is_encryption_available()?\'\':NULL;','PRIVACY','ADVANCED','CONFIG_OPTION_decryption_key','0',''),
 ('is_on_post_titles','IS_ON_POST_TITLES','0','','tick','return is_null($old=get_value(\'no_post_titles\'))?\'0\':invert_value($old);','SECTION_FORUMS','GENERAL','CONFIG_OPTION_is_on_post_titles','0',''),
 ('is_on_anonymous_posts','IS_ON_ANONYMOUS_POSTS','0','','tick','return is_null($old=get_value(\'ocf_no_anonymous_post\'))?\'0\':invert_value($old);','SECTION_FORUMS','GENERAL','CONFIG_OPTION_is_on_anonymous_posts','0',''),
 ('is_on_timezone_detection','IS_ON_TIMEZONE_DETECTION','0','','tick','return is_null($old=get_value(\'no_js_timezone_detect\'))?\'0\':invert_value($old);','SECTION_FORUMS','GENERAL','CONFIG_OPTION_is_on_timezone_detection','0',''),
 ('is_on_topic_descriptions','IS_ON_TOPIC_DESCRIPTIONS','0','','tick','return is_null($old=get_value(\'no_topic_descriptions\'))?\'1\':invert_value($old);','SECTION_FORUMS','GENERAL','CONFIG_OPTION_is_on_topic_descriptions','0',''),
 ('is_on_topic_emoticons','IS_ON_TOPIC_EMOTICONS','0','','tick','return is_null($old=get_value(\'ocf_no_topic_emoticons\'))?\'1\':invert_value($old);','SECTION_FORUMS','GENERAL','CONFIG_OPTION_is_on_topic_emoticons','0',''),
 ('default_preview_guests','DEFAULT_PREVIEW_GUESTS','0','','tick','return is_null($old=get_value(\'no_default_preview_guests\'))?\'0\':invert_value($old);','SECTION_FORUMS','GENERAL','CONFIG_OPTION_default_preview_guests','0',''),
 ('forced_preview_option','FORCED_PREVIEW_OPTION','0','','tick','return is_null($old=get_value(\'no_forced_preview_option\'))?\'0\':invert_value($old);','SECTION_FORUMS','GENERAL','CONFIG_OPTION_forced_preview_option','0',''),
 ('overt_whisper_suggestion','OVERT_WHISPER_SUGGESTION','0','','tick','return is_null($old=get_value(\'disable_overt_whispering\'))?\'1\':invert_value($old);','SECTION_FORUMS','GENERAL','CONFIG_OPTION_overt_whisper_suggestion','0',''),
 ('is_on_invisibility','IS_ON_INVISIBILITY','0','','tick','return is_null($old=get_value(\'no_invisible_option\'))?\'0\':invert_value($old);','SECTION_FORUMS','GENERAL','CONFIG_OPTION_is_on_invisibility','0',''),
 ('allow_alpha_search','ALLOW_ALPHA_SEARCH','0','','tick','return is_null($old=get_value(\'allow_alpha_search\'))?\'0\':$old;','SECTION_FORUMS','GENERAL','CONFIG_OPTION_allow_alpha_search','0',''),
 ('allow_email_disable','ALLOW_EMAIL_DISABLE','0','','tick','return is_null($old=get_value(\'disable_allow_emails_field\'))?\'1\':invert_value($old);','SECTION_FORUMS','GENERAL','CONFIG_OPTION_allow_email_disable','0',''),
 ('max_member_title_length','MAX_MEMBER_TITLE_LENGTH','0','','integer','return addon_installed(\'ocf_member_titles\')?\'20\':NULL;','SECTION_FORUMS','GENERAL','CONFIG_OPTION_max_member_title_length','0',''),
 ('httpauth_is_enabled','HTTPAUTH_IS_ENABLED','0','','tick','return \'0\';','SECTION_FORUMS','ADVANCED','CONFIG_OPTION_httpauth_is_enabled','1',''),
 ('post_history_days','POST_HISTORY_DAYS','0','','integer','return \'21\';','SECTION_FORUMS','GENERAL','CONFIG_OPTION_post_history_days','1',''),
 ('forum_posts_per_page','FORUM_POSTS_PER_PAGE','0','','integer','return has_no_forum()?NULL:\'20\';','SECTION_FORUMS','GENERAL','CONFIG_OPTION_forum_posts_per_page','0',''),
 ('forum_topics_per_page','FORUM_TOPICS_PER_PAGE','0','','integer','return has_no_forum()?NULL:\'30\';','SECTION_FORUMS','GENERAL','CONFIG_OPTION_forum_topics_per_page','0',''),
 ('prevent_shouting','PREVENT_SHOUTING','0','','tick','return has_no_forum()?NULL:\'1\';','SECTION_FORUMS','GENERAL','CONFIG_OPTION_prevent_shouting','0',''),
 ('restricted_usernames','RESTRICTED_USERNAMES','0','','line','return do_lang(\'GUEST\').\', \'.do_lang(\'STAFF\').\', \'.do_lang(\'ADMIN\').\', \'.do_lang(\'MODERATOR\').\', googlebot\';','SECTION_FORUMS','GENERAL','CONFIG_OPTION_restricted_usernames','0',''),
 ('require_new_member_validation','REQUIRE_NEW_MEMBER_VALIDATION','0','','tick','return \'0\';','SECTION_FORUMS','USERNAMES_AND_PASSWORDS','CONFIG_OPTION_require_new_member_validation','0',''),
 ('reported_posts_forum','REPORTED_POSTS_FORUM','0','','forum','return (has_no_forum()||(!addon_installed(\'ocf_reported_posts\')))?NULL:do_lang(\'ocf:REPORTED_POSTS_FORUM\');','SECTION_FORUMS','GENERAL','CONFIG_OPTION_reported_posts_forum','0',''),
 ('one_per_email_address','ONE_PER_EMAIL_ADDRESS','0','','tick','return \'1\';','SECTION_FORUMS','GENERAL','CONFIG_OPTION_one_per_email_address','0',''),
 ('hot_topic_definition','HOT_TOPIC_DEFINITION','0','','integer','return has_no_forum()?NULL:\'20\';','SECTION_FORUMS','GENERAL','CONFIG_OPTION_hot_topic_definition','0',''),
 ('minimum_password_length','MINIMUM_PASSWORD_LENGTH','0','','integer','return \'4\';','SECTION_FORUMS','USERNAMES_AND_PASSWORDS','CONFIG_OPTION_minimum_password_length','0',''),
 ('maximum_password_length','MAXIMUM_PASSWORD_LENGTH','0','','integer','return \'20\';','SECTION_FORUMS','USERNAMES_AND_PASSWORDS','CONFIG_OPTION_maximum_password_length','0',''),
 ('minimum_username_length','MINIMUM_USERNAME_LENGTH','0','','integer','return \'1\';','SECTION_FORUMS','USERNAMES_AND_PASSWORDS','CONFIG_OPTION_minimum_username_length','0',''),
 ('maximum_username_length','MAXIMUM_USERNAME_LENGTH','0','','integer','return \'20\';','SECTION_FORUMS','USERNAMES_AND_PASSWORDS','CONFIG_OPTION_maximum_username_length','0',''),
 ('prohibit_password_whitespace','PROHIBIT_PASSWORD_WHITESPACE','0','','tick','return \'1\';','SECTION_FORUMS','USERNAMES_AND_PASSWORDS','CONFIG_OPTION_prohibit_password_whitespace','0',''),
 ('prohibit_username_whitespace','PROHIBIT_USERNAME_WHITESPACE','0','','tick','return \'0\';','SECTION_FORUMS','USERNAMES_AND_PASSWORDS','CONFIG_OPTION_prohibit_username_whitespace','0',''),
 ('random_avatars','ASSIGN_RANDOM_AVATARS','0','','tick','return addon_installed(\'ocf_member_avatars\')?\'1\':NULL;','SECTION_FORUMS','GENERAL','CONFIG_OPTION_random_avatars','0',''),
 ('club_forum_parent_forum','CLUB_FORUM_PARENT_FORUM','0','','forum','return has_no_forum()?NULL:strval(db_get_first_id());','SECTION_FORUMS','GENERAL','CONFIG_OPTION_club_forum_parent_forum','0',''),
 ('club_forum_parent_category','CLUB_FORUM_PARENT_CATEGORY','0','','category','return has_no_forum()?NULL:strval(db_get_first_id());','SECTION_FORUMS','GENERAL','CONFIG_OPTION_club_forum_parent_category','0',''),
 ('delete_trashed_pts','DELETE_TRASHED_PTS','0','','tick','return has_no_forum()?NULL:\'0\';','SECTION_FORUMS','GENERAL','CONFIG_OPTION_delete_trashed_pts','0',''),
 ('probation_usergroup','PROBATION_USERGROUP','0','','usergroup','return do_lang(\'PROBATION\');','SECTION_FORUMS','USERNAMES_AND_PASSWORDS','CONFIG_OPTION_probation_usergroup','0',''),
 ('show_first_join_page','SHOW_FIRST_JOIN_PAGE','0','','tick','return \'1\';','SECTION_FORUMS','USERNAMES_AND_PASSWORDS','CONFIG_OPTION_show_first_join_page','0',''),
 ('skip_email_confirm_join','SKIP_EMAIL_CONFIRM_JOIN','0','','tick','return \'1\';','SECTION_FORUMS','USERNAMES_AND_PASSWORDS','CONFIG_OPTION_skip_email_confirm_join','0',''),
 ('no_dob_ask','NO_DOB_ASK','0','','tick','return \'0\';','SECTION_FORUMS','USERNAMES_AND_PASSWORDS','CONFIG_OPTION_no_dob_ask','0',''),
 ('allow_international','ALLOW_INTERNATIONAL','0','','tick','return \'1\';','SECTION_FORUMS','USERNAMES_AND_PASSWORDS','CONFIG_OPTION_allow_international','0',''),
 ('allow_email_from_staff_disable','ALLOW_EMAIL_FROM_STAFF_DISABLE','0','','tick','return \'0\';','SECTION_FORUMS','GENERAL','CONFIG_OPTION_allow_email_from_staff_disable','0',''),
 ('intro_forum_id','INTRO_FORUM_ID','0','','?forum','return \'\';','SECTION_FORUMS','USERNAMES_AND_PASSWORDS','CONFIG_OPTION_intro_forum_id','0',''),
 ('signup_fullname','SIGNUP_FULLNAME','0','','tick','return \'0\';','SECTION_FORUMS','USERNAMES_AND_PASSWORDS','CONFIG_OPTION_signup_fullname','0',''),
 ('is_on_coppa','COPPA_ENABLED','0','','tick','return \'0\';','PRIVACY','GENERAL','CONFIG_OPTION_is_on_coppa','0',''),
 ('privacy_fax','FAX_NUMBER','0','','line','return \'\';','PRIVACY','GENERAL','CONFIG_OPTION_privacy_fax','0',''),
 ('privacy_postal_address','ADDRESS','0','','text','return \'\';','PRIVACY','GENERAL','CONFIG_OPTION_privacy_postal_address','0',''),
 ('is_on_invites','INVITES_ENABLED','0','','tick','return \'0\';','SECTION_FORUMS','GENERAL','CONFIG_OPTION_is_on_invites','0',''),
 ('invites_per_day','INVITES_PER_DAY','0','','float','return \'1\';','SECTION_FORUMS','GENERAL','CONFIG_OPTION_invites_per_day','0',''),
 ('url_monikers_enabled','URL_MONIKERS_ENABLED','0','','tick','return \'1\';','SITE','ADVANCED','CONFIG_OPTION_url_monikers_enabled','0',''),
 ('backup_time','BACKUP_REGULARITY','0','','integer','return \'168\';','ADMIN','CHECK_LIST','CONFIG_OPTION_backup_time','1',''),
 ('backup_server_hostname','BACKUP_SERVER_HOSTNAME','0','','line','return \'\';','FEATURE','BACKUP','CONFIG_OPTION_backup_server_hostname','0',''),
 ('backup_server_port','BACKUP_SERVER_PORT','0','','integer','return \'21\';','FEATURE','BACKUP','CONFIG_OPTION_backup_server_port','0',''),
 ('backup_server_user','BACKUP_SERVER_USER','0','','line','return \'\';','FEATURE','BACKUP','CONFIG_OPTION_backup_server_user','0',''),
 ('backup_server_password','BACKUP_SERVER_PASSWORD','0','','line','return \'\';','FEATURE','BACKUP','CONFIG_OPTION_backup_server_password','0',''),
 ('backup_server_path','BACKUP_SERVER_PATH','0','','line','return \'\';','FEATURE','BACKUP','CONFIG_OPTION_backup_server_path','0',''),
 ('backup_overwrite','BACKUP_OVERWRITE','0','','tick','return \'0\';','FEATURE','BACKUP','CONFIG_OPTION_backup_overwrite','0',''),
 ('is_on_block_cache','BLOCK_CACHE','0','','tick','return $GLOBALS[\'SEMI_DEBUG_MODE\']?\'0\':\'1\';','SITE','CACHES','CONFIG_OPTION_is_on_block_cache','1',''),
 ('is_on_template_cache','TEMPLATE_CACHE','0','','tick','return \'1\';','SITE','CACHES','CONFIG_OPTION_is_on_template_cache','1',''),
 ('is_on_comcode_page_cache','COMCODE_PAGE_CACHE','0','','tick','return \'1\';','SITE','CACHES','CONFIG_OPTION_is_on_comcode_page_cache','1',''),
 ('is_on_lang_cache','LANGUAGE_CACHE','0','','tick','return \'1\';','SITE','CACHES','CONFIG_OPTION_is_on_lang_cache','1',''),
 ('mod_rewrite','MOD_REWRITE','0','','tick','return \'0\'; /*function_exists(\'apache_get_modules\')?\'1\':\'0\';*/','SITE','ADVANCED','CONFIG_OPTION_mod_rewrite','0',''),
 ('session_expiry_time','SESSION_EXPIRY_TIME','0','','integer','return \'1\';','SECURITY','GENERAL','CONFIG_OPTION_session_expiry_time','0',''),
 ('is_on_trackbacks','TRACKBACKS','0','','tick','return \'0\';','FEATURE','USER_INTERACTION','CONFIG_OPTION_is_on_trackbacks','0',''),
 ('unzip_dir','UNZIP_DIR','0','','line','return (DIRECTORY_SEPARATOR==\'/\')?\'/tmp/\':ocp_srv(\'TMP\');','SITE','ARCHIVES','CONFIG_OPTION_unzip_dir','1',''),
 ('unzip_cmd','UNZIP_CMD','0','','line','return \'/usr/bin/unzip -o @_SRC_@ -x -d @_DST_@\';','SITE','ARCHIVES','CONFIG_OPTION_unzip_cmd','1',''),
 ('smtp_sockets_use','ENABLED','0','','tick','return \'0\';','SITE','SMTP','CONFIG_OPTION_smtp_sockets_use','1',''),
 ('smtp_sockets_host','HOST','0','','line','return \'mail.yourispwhateveritis.net\';','SITE','SMTP','CONFIG_OPTION_smtp_sockets_host','1',''),
 ('smtp_sockets_port','PORT','0','','line','return \'25\';','SITE','SMTP','CONFIG_OPTION_smtp_sockets_port','1',''),
 ('smtp_sockets_username','USERNAME','0','','line','return \'\';','SITE','SMTP','CONFIG_OPTION_smtp_sockets_username','1',''),
 ('smtp_sockets_password','PASSWORD','0','','line','return \'\';','SITE','SMTP','CONFIG_OPTION_smtp_sockets_password','1',''),
 ('smtp_from_address','EMAIL_ADDRESS','0','','line','return \'\';','SITE','SMTP','CONFIG_OPTION_smtp_from_address','1',''),
 ('use_security_images','USE_SECURITY_IMAGES','0','','tick','return \'1\';','SECURITY','GENERAL','CONFIG_OPTION_use_security_images','0',''),
 ('enable_https','HTTPS_SUPPORT','0','','tick','return \'0\';','SECURITY','GENERAL','CONFIG_OPTION_enable_https','1',''),
 ('send_error_emails_ocproducts','SEND_ERROR_EMAILS_OCPRODUCTS','0','','tick','return 1;','SITE','ADVANCED','CONFIG_OPTION_send_error_emails_ocproducts','1',''),
 ('low_space_check','LOW_DISK_SPACE_SUBJECT','0','','integer','return \'20\';','SITE','GENERAL','CONFIG_OPTION_low_space_check','0',''),
 ('detect_lang_forum','DETECT_LANG_FORUM','0','','tick','return \'1\';','SITE','ADVANCED','CONFIG_OPTION_detect_lang_forum','0',''),
 ('detect_lang_browser','DETECT_LANG_BROWSER','0','','tick','return \'0\';','SITE','ADVANCED','CONFIG_OPTION_detect_lang_browser','0',''),
 ('allow_audio_videos','ALLOW_AUDIO_VIDEOS','0','','tick','return \'1\';','SITE','ADVANCED','CONFIG_OPTION_allow_audio_videos','0',''),
 ('validation','VALIDATION','0','','tick','return \'0\';','SITE','VALIDATION','CONFIG_OPTION_validation','1',''),
 ('validation_xhtml','VALIDATION_XHTML','0','','tick','return \'1\';','SITE','VALIDATION','CONFIG_OPTION_validation_xhtml','1',''),
 ('validation_wcag','VALIDATION_WCAG','0','','tick','return \'1\';','SITE','VALIDATION','CONFIG_OPTION_validation_wcag','1',''),
 ('validation_css','VALIDATION_CSS','0','','tick','return \'0\';','SITE','VALIDATION','CONFIG_OPTION_validation_css','1',''),
 ('validation_javascript','VALIDATION_JAVASCRIPT','0','','tick','return \'0\';','SITE','VALIDATION','CONFIG_OPTION_validation_javascript','1',''),
 ('validation_compat','VALIDATION_COMPAT','0','','tick','return \'0\';','SITE','VALIDATION','CONFIG_OPTION_validation_compat','1',''),
 ('validation_ext_files','VALIDATION_EXT_FILES','0','','tick','return \'0\';','SITE','VALIDATION','CONFIG_OPTION_validation_ext_files','1',''),
 ('max_download_size','MAX_SIZE','0','','integer','return \'20000\';','SITE','UPLOAD','CONFIG_OPTION_max_download_size','0',''),
 ('sms_username','USERNAME','0','','line','return addon_installed(\'sms\')?\'\':NULL;','FEATURE','SMS','CONFIG_OPTION_sms_username','0',''),
 ('sms_password','PASSWORD','0','','line','return addon_installed(\'sms\')?\'\':NULL;','FEATURE','SMS','CONFIG_OPTION_sms_password','0',''),
 ('sms_api_id','API_ID','0','','integer','return addon_installed(\'sms\')?\'\':NULL;','FEATURE','SMS','CONFIG_OPTION_sms_api_id','0',''),
 ('sms_low_limit','SMS_LOW_LIMIT','0','','integer','return addon_installed(\'sms\')?\'10\':NULL;','FEATURE','SMS','CONFIG_OPTION_sms_low_limit','0',''),
 ('sms_high_limit','SMS_HIGH_LIMIT','0','','integer','return addon_installed(\'sms\')?\'20\':NULL;','FEATURE','SMS','CONFIG_OPTION_sms_high_limit','0',''),
 ('sms_low_trigger_limit','SMS_LOW_TRIGGER_LIMIT','0','','integer','return addon_installed(\'sms\')?\'50\':NULL;','FEATURE','SMS','CONFIG_OPTION_sms_low_trigger_limit','0',''),
 ('sms_high_trigger_limit','SMS_HIGH_TRIGGER_LIMIT','0','','integer','return addon_installed(\'sms\')?\'100\':NULL;','FEATURE','SMS','CONFIG_OPTION_sms_high_trigger_limit','0',''),
 ('allowed_post_submitters','ALLOWED_POST_SUBMITTERS','0','','text','return \'\';','SECURITY','ADVANCED','CONFIG_OPTION_allowed_post_submitters','1',''),
 ('is_on_strong_forum_tie','STRONG_FORUM_TIE','0','','tick','return \'0\';','FEATURE','USER_INTERACTION','CONFIG_OPTION_is_on_strong_forum_tie','1',''),
 ('is_on_preview_validation','VALIDATION_ON_PREVIEW','0','','tick','return \'1\';','SITE','VALIDATION','CONFIG_OPTION_is_on_preview_validation','1',''),
 ('show_inline_stats','SHOW_INLINE_STATS','0','','tick','return \'1\';','SITE','GENERAL','CONFIG_OPTION_show_inline_stats','0',''),
 ('simplified_donext','SIMPLIFIED_DONEXT','0','','tick','return \'0\';','SITE','ADVANCED','CONFIG_OPTION_simplified_donext','0',''),
 ('anti_leech','ANTI_LEECH','0','','tick','return \'0\';','SECURITY','GENERAL','CONFIG_OPTION_anti_leech','0',''),
 ('ssw','SSW','0','','tick','return \'0\';','SITE','GENERAL','CONFIG_OPTION_ssw','0',''),
 ('bottom_show_admin_menu','ADMIN_MENU','0','','tick','return \'1\';','FEATURE','BOTTOM_LINKS','CONFIG_OPTION_bottom_show_admin_menu','0',''),
 ('bottom_show_top_button','TOP_LINK','0','','tick','return \'0\';','FEATURE','BOTTOM_LINKS','CONFIG_OPTION_bottom_show_top_button','0',''),
 ('bottom_show_feedback_link','FEEDBACK_LINK','0','','tick','return \'1\';','FEATURE','BOTTOM_LINKS','CONFIG_OPTION_bottom_show_feedback_link','0',''),
 ('bottom_show_privacy_link','PRIVACY_LINK','0','','tick','return \'1\';','FEATURE','BOTTOM_LINKS','CONFIG_OPTION_bottom_show_privacy_link','0',''),
 ('bottom_show_sitemap_button','SITEMAP_LINK','0','','tick','return \'1\';','FEATURE','BOTTOM_LINKS','CONFIG_OPTION_bottom_show_sitemap_button','0',''),
 ('forum_show_personal_stats_posts','COUNT_POSTSCOUNT','0','','tick','return has_no_forum()?NULL:\'0\';','BLOCKS','PERSONAL_BLOCK','CONFIG_OPTION_forum_show_personal_stats_posts','0',''),
 ('forum_show_personal_stats_topics','COUNT_TOPICSCOUNT','0','','tick','return ((has_no_forum()) || (get_forum_type()!=\'ocf\'))?NULL:\'0\';','BLOCKS','PERSONAL_BLOCK','CONFIG_OPTION_forum_show_personal_stats_topics','0',''),
 ('ocp_show_personal_adminzone_link','ADMIN_ZONE_LINK','0','','tick','return \'1\';','BLOCKS','PERSONAL_BLOCK','CONFIG_OPTION_ocp_show_personal_adminzone_link','0',''),
 ('ocp_show_conceded_mode_link','CONCEDED_MODE_LINK','0','','tick','return \'0\';','BLOCKS','PERSONAL_BLOCK','CONFIG_OPTION_ocp_show_conceded_mode_link','0',''),
 ('ocp_show_su','SU','0','','tick','return has_no_forum()?NULL:\'1\';','BLOCKS','PERSONAL_BLOCK','CONFIG_OPTION_ocp_show_su','0',''),
 ('ocp_show_staff_page_actions','PAGE_ACTIONS','0','','tick','return \'1\';','THEME','GENERAL','CONFIG_OPTION_ocp_show_staff_page_actions','0',''),
 ('ocf_show_profile_link','MY_PROFILE_LINK','0','','tick','return has_no_forum()?NULL:\'1\';','BLOCKS','PERSONAL_BLOCK','CONFIG_OPTION_ocf_show_profile_link','0',''),
 ('ocp_show_personal_usergroup','_USERGROUP','0','','tick','return has_no_forum()?NULL:\'0\';','BLOCKS','PERSONAL_BLOCK','CONFIG_OPTION_ocp_show_personal_usergroup','0',''),
 ('ocp_show_personal_last_visit','LAST_HERE','0','','tick','return has_no_forum()?NULL:\'0\';','BLOCKS','PERSONAL_BLOCK','CONFIG_OPTION_ocp_show_personal_last_visit','0',''),
 ('ocp_show_avatar','AVATAR','0','','tick','return (has_no_forum() || ((get_forum_type()==\'ocf\') && (!addon_installed(\'ocf_member_avatars\'))))?NULL:\'0\';','BLOCKS','PERSONAL_BLOCK','CONFIG_OPTION_ocp_show_avatar','0',''),
 ('panel_width','PANEL_WIDTH','0','','line','return \'13.3em\';','THEME','GENERAL','CONFIG_OPTION_panel_width','0',''),
 ('panel_width_spaced','PANEL_WIDTH_SPACED','0','','line','return \'14.3em\';','THEME','GENERAL','CONFIG_OPTION_panel_width_spaced','0',''),
 ('root_zone_login_theme','ROOT_ZONE_LOGIN_THEME','0','','tick','return \'0\';','THEME','GENERAL','CONFIG_OPTION_root_zone_login_theme','0',''),
 ('use_custom_zone_menu','USE_CUSTOM_ZONE_MENU','0','','tick','return \'1\';','THEME','GENERAL','CONFIG_OPTION_use_custom_zone_menu','0',''),
 ('tray_support','TRAY_SUPPORT','0','','tick','return \'1\';','THEME','GENERAL','CONFIG_OPTION_tray_support','0',''),
 ('show_docs','SHOW_DOCS','0','','tick','return \'1\';','SITE','ADVANCED','CONFIG_OPTION_show_docs','0',''),
 ('captcha_noise','CAPTCHA_NOISE','0','','tick','return addon_installed(\'captcha\')?\'1\':NULL;','SITE','ADVANCED','CONFIG_OPTION_captcha_noise','0',''),
 ('captcha_on_feedback','CAPTCHA_ON_FEEDBACK','0','','tick','return addon_installed(\'captcha\')?\'0\':NULL;','SITE','ADVANCED','CONFIG_OPTION_captcha_on_feedback','0',''),
 ('show_post_validation','SHOW_POST_VALIDATION','0','','tick','return \'1\';','SITE','ADVANCED','CONFIG_OPTION_show_post_validation','0',''),
 ('ip_forwarding','IP_FORWARDING','0','','tick','return \'0\';','SITE','ENVIRONMENT','CONFIG_OPTION_ip_forwarding','0',''),
 ('force_meta_refresh','FORCE_META_REFRESH','0','','tick','return \'0\';','SITE','ENVIRONMENT','CONFIG_OPTION_force_meta_refresh','0',''),
 ('use_contextual_dates','USE_CONTEXTUAL_DATES','0','','tick','return \'1\';','SITE','ADVANCED','CONFIG_OPTION_use_contextual_dates','0',''),
 ('eager_wysiwyg','EAGER_WYSIWYG','0','','tick','return \'0\';','SITE','ADVANCED','CONFIG_OPTION_eager_wysiwyg','0',''),
 ('website_email','WEBSITE_EMAIL','0','','line','$staff_address=get_option(\'staff_address\'); $website_email=\'website@\'.get_domain(); if (substr($staff_address,-strlen(get_domain())-1)==\'@\'.get_domain()) $website_email=$staff_address; return $website_email;','SITE','EMAIL','CONFIG_OPTION_website_email','0',''),
 ('enveloper_override','ENVELOPER_OVERRIDE','0','','tick','return \'0\';','SITE','EMAIL','CONFIG_OPTION_enveloper_override','0',''),
 ('bcc','BCC','0','','tick','return \'1\';','SITE','EMAIL','CONFIG_OPTION_bcc','0',''),
 ('allow_ext_images','ALLOW_EXT_IMAGES','0','','tick','return \'0\';','SITE','EMAIL','CONFIG_OPTION_allow_ext_images','0',''),
 ('htm_short_urls','HTM_SHORT_URLS','0','','tick','return \'0\';','SITE','ADVANCED','CONFIG_OPTION_htm_short_urls','0',''),
 ('ip_strict_for_sessions','IP_STRICT_FOR_SESSIONS','0','','tick','return \'1\';','SECURITY','GENERAL','CONFIG_OPTION_ip_strict_for_sessions','0',''),
 ('enable_previews','ENABLE_PREVIEWS','0','','tick','return \'1\';','SITE','PREVIEW','CONFIG_OPTION_enable_previews','0',''),
 ('enable_keyword_density_check','ENABLE_KEYWORD_DENSITY_CHECK','0','','tick','return \'0\';','SITE','PREVIEW','CONFIG_OPTION_enable_keyword_density_check','0',''),
 ('enable_spell_check','ENABLE_SPELL_CHECK','0','','tick','return function_exists(\'pspell_check\')?\'0\':NULL;','SITE','PREVIEW','CONFIG_OPTION_enable_spell_check','0',''),
 ('enable_markup_validation','ENABLE_MARKUP_VALIDATION','0','','tick','return \'0\';','SITE','PREVIEW','CONFIG_OPTION_enable_markup_validation','0',''),
 ('enable_image_fading','ENABLE_IMAGE_FADING','0','','tick','return \'1\';','THEME','GENERAL','CONFIG_OPTION_enable_image_fading','0',''),
 ('auto_submit_sitemap','AUTO_SUBMIT_SITEMAP','0','','tick','return \'0\';','SITE','GENERAL','CONFIG_OPTION_auto_submit_sitemap','0',''),
 ('user_postsize_errors','USER_POSTSIZE_ERRORS','0','','tick','return is_null($old=get_value(\'no_user_postsize_errors\'))?\'1\':invert_value($old);','SITE','UPLOAD','CONFIG_OPTION_user_postsize_errors','0',''),
 ('automatic_meta_extraction','AUTOMATIC_META_EXTRACTION','0','','tick','return is_null($old=get_value(\'no_auto_meta\'))?\'1\':invert_value($old);','SITE','GENERAL','CONFIG_OPTION_automatic_meta_extraction','0',''),
 ('is_on_emoticon_choosers','IS_ON_EMOTICON_CHOOSERS','0','','tick','return is_null($old=get_value(\'no_emoticon_choosers\'))?\'1\':invert_value($old);','THEME','GENERAL','CONFIG_OPTION_is_on_emoticon_choosers','0',''),
 ('deeper_admin_breadcrumbs','DEEPER_ADMIN_BREADCRUMBS','0','','tick','return is_null($old=get_value(\'no_admin_menu_assumption\'))?\'1\':invert_value($old);','SITE','ADVANCED','CONFIG_OPTION_deeper_admin_breadcrumbs','0',''),
 ('has_low_memory_limit','HAS_LOW_MEMORY_LIMIT','0','','tick','return is_null($old=get_value(\'has_low_memory_limit\'))?((ini_get(\'memory_limit\')==\'-1\' || ini_get(\'memory_limit\')==\'0\' || ini_get(\'memory_limit\')==\'\')?\'0\':NULL):$old;','SITE','ADVANCED','CONFIG_OPTION_has_low_memory_limit','0',''),
 ('is_on_comcode_page_children','IS_ON_COMCODE_PAGE_CHILDREN','0','','tick','return is_null($old=get_value(\'disable_comcode_page_children\'))?\'1\':invert_value($old);','SITE','ADVANCED','CONFIG_OPTION_is_on_comcode_page_children','0',''),
 ('global_donext_icons','GLOBAL_DONEXT_ICONS','0','','tick','return is_null($old=get_value(\'disable_donext_global\'))?\'1\':invert_value($old);','SITE','ADVANCED','CONFIG_OPTION_global_donext_icons','0',''),
 ('no_stats_when_closed','NO_STATS_WHEN_CLOSED','0','','tick','return \'1\';','SITE','CLOSED_SITE','CONFIG_OPTION_no_stats_when_closed','0',''),
 ('no_bot_stats','NO_BOT_STATS','0','','tick','return \'0\';','SITE','GENERAL','CONFIG_OPTION_no_bot_stats','0',''),
 ('filesystem_caching','FILE_SYSTEM_CACHING','0','','tick','return \'0\';','SITE','CACHES','CONFIG_OPTION_filesystem_caching','0',''),
 ('java_upload','ENABLE_JAVA_UPLOAD','0','','tick','return \'0\';','SITE','JAVA_UPLOAD','CONFIG_OPTION_java_upload','0',''),
 ('java_ftp_host','JAVA_FTP_HOST','0','','line','return ocp_srv(\'HTTP_HOST\');','SITE','JAVA_UPLOAD','CONFIG_OPTION_java_ftp_host','0',''),
 ('java_username','JAVA_FTP_USERNAME','0','','line','return \'anonymous\';','SITE','JAVA_UPLOAD','CONFIG_OPTION_java_username','0',''),
 ('java_password','JAVA_FTP_PASSWORD','0','','line','return \'someone@example.com\';','SITE','JAVA_UPLOAD','CONFIG_OPTION_java_password','0',''),
 ('java_ftp_path','JAVA_FTP_PATH','0','','line','return \'/public_html/uploads/incoming/\';','SITE','JAVA_UPLOAD','CONFIG_OPTION_java_ftp_path','0',''),
 ('advanced_admin_cache','ADVANCED_ADMIN_CACHE','0','','tick','return \'0\';','SITE','CACHES','CONFIG_OPTION_advanced_admin_cache','0',''),
 ('collapse_user_zones','COLLAPSE_USER_ZONES','0','','tick','return \'1\';','SITE','GENERAL','CONFIG_OPTION_collapse_user_zones','0',''),
 ('check_broken_urls','CHECK_BROKEN_URLS','0','','tick','return \'1\';','SITE','_COMCODE','CONFIG_OPTION_check_broken_urls','0',''),
 ('google_analytics','GOOGLE_ANALYTICS','0','','line','return \'\';','SITE','GENERAL','CONFIG_OPTION_google_analytics','0',''),
 ('fixed_width','FIXED_WIDTH','0','','tick','return \'1\';','THEME','GENERAL','CONFIG_OPTION_fixed_width','0',''),
 ('show_content_tagging','SHOW_CONTENT_TAGGING','0','','tick','return \'0\';','THEME','GENERAL','CONFIG_OPTION_show_content_tagging','0',''),
 ('show_content_tagging_inline','SHOW_CONTENT_TAGGING_INLINE','0','','tick','return \'0\';','THEME','GENERAL','CONFIG_OPTION_show_content_tagging_inline','0',''),
 ('show_screen_actions','SHOW_SCREEN_ACTIONS','0','','tick','return \'0\';','THEME','GENERAL','CONFIG_OPTION_show_screen_actions','0',''),
 ('ocp_show_personal_sub_links','PERSONAL_SUB_LINKS','0','','tick','return \'1\';','BLOCKS','PERSONAL_BLOCK','CONFIG_OPTION_ocp_show_personal_sub_links','0',''),
 ('long_google_cookies','LONG_GOOGLE_COOKIES','0','','tick','return \'0\';','SITE','GENERAL','CONFIG_OPTION_long_google_cookies','0',''),
 ('remember_me_by_default','REMEMBER_ME_BY_DEFAULT','0','','tick','return \'0\';','SITE','GENERAL','CONFIG_OPTION_remember_me_by_default','0',''),
 ('detect_javascript','DETECT_JAVASCRIPT','0','','tick','return \'0\';','SITE','ADVANCED','CONFIG_OPTION_detect_javascript','0',''),
 ('mobile_support','MOBILE_SUPPORT','0','','tick','return \'1\';','SITE','GENERAL','CONFIG_OPTION_mobile_support','0',''),
 ('mail_queue','MAIL_QUEUE','0','','tick','return \'1\';','SITE','EMAIL','CONFIG_OPTION_mail_queue','0',''),
 ('mail_queue_debug','MAIL_QUEUE_DEBUG','0','','tick','return \'0\';','SITE','EMAIL','CONFIG_OPTION_mail_queue_debug','0',''),
 ('comments_to_show_in_thread','COMMENTS_TO_SHOW_IN_THREAD','0','','integer','return \'200\';','FEATURE','USER_INTERACTION','CONFIG_OPTION_comments_to_show_in_thread','0',''),
 ('max_thread_depth','MAX_THREAD_DEPTH','0','','integer','return \'6\';','FEATURE','USER_INTERACTION','CONFIG_OPTION_max_thread_depth','0',''),
 ('site_name','SITE_NAME','0','','line','return do_lang(\'UNNAMED\');','SITE','GENERAL','CONFIG_OPTION_site_name','0',''),
 ('site_scope','SITE_SCOPE','0','','transline','return \'???\';','SITE','GENERAL','CONFIG_OPTION_site_scope','0',''),
 ('description','DESCRIPTION','0','','transline','return \'\';','SITE','GENERAL','CONFIG_OPTION_description','0',''),
 ('copyright','COPYRIGHT','0','','transline','return \'Copyright &copy; \'.get_site_name().\' \'.date(\'Y\').\'\';','SITE','GENERAL','CONFIG_OPTION_copyright','0',''),
 ('welcome_message','WELCOME_MESSAGE','0','','transtext','return \'\';','SITE','GENERAL','CONFIG_OPTION_welcome_message','0',''),
 ('main_forum_name','MAIN_FORUM_NAME','0','','forum','return has_no_forum()?NULL:do_lang(\'DEFAULT_FORUM_TITLE\',\'\',\'\',\'\',get_site_default_lang());','FEATURE','USER_INTERACTION','CONFIG_OPTION_main_forum_name','0',''),
 ('keywords','KEYWORDS','0','','line','return \'\';','SITE','GENERAL','CONFIG_OPTION_keywords','0',''),
 ('gzip_output','GZIP_OUTPUT','0','','tick','return \'0\';','SITE','ADVANCED','CONFIG_OPTION_gzip_output','1',''),
 ('forum_in_portal','FORUM_IN_PORTAL','0','','tick','return has_no_forum()?NULL:\'0\';','SITE','ENVIRONMENT','CONFIG_OPTION_forum_in_portal','1',''),
 ('staff_address','EMAIL','0','','line','return \'staff@\'.get_domain();','SITE','EMAIL','CONFIG_OPTION_staff_address','0',''),
 ('is_on_gd','GD','0','','tick','return function_exists(\'imagetypes\')?\'1\':\'0\';','SITE','ENVIRONMENT','CONFIG_OPTION_is_on_gd','1',''),
 ('is_on_folder_create','FOLDER_CREATE','0','','tick','return \'1\';','SITE','ENVIRONMENT','CONFIG_OPTION_is_on_folder_create','1',''),
 ('site_closed','CLOSED_SITE','0','','tick','return \'1\';','SITE','CLOSED_SITE','CONFIG_OPTION_site_closed','0',''),
 ('closed','MESSAGE','0','','transtext','return do_lang(\'BEING_INSTALLED\');','SITE','CLOSED_SITE','CONFIG_OPTION_closed','0',''),
 ('maximum_users','MAXIMUM_USERS','0','','integer','return \'100\';','SITE','CLOSED_SITE','CONFIG_OPTION_maximum_users','1',''),
 ('cc_address','CC_ADDRESS','0','','line','return \'\';','SITE','EMAIL','CONFIG_OPTION_cc_address','0',''),
 ('log_php_errors','LOG_PHP_ERRORS','0','','tick','return \'1\';','SITE','LOGGING','CONFIG_OPTION_log_php_errors','0',''),
 ('display_php_errors','DISPLAY_PHP_ERRORS','0','','tick','return \'0\';','SITE','LOGGING','CONFIG_OPTION_display_php_errors','0',''),
 ('valid_types','FILE_TYPES','0','','line','return \'swf,sql,odg,odp,odt,ods,ps,pdf,doc,ppt,csv,xls,docx,pptx,xlsx,pub,txt,psd,tga,tif,gif,png,ico,bmp,jpg,jpeg,flv,avi,mov,3gp,mpg,mpeg,mp4,webm,asf,wmv,ram,ra,rm,qt,zip,tar,rar,gz,wav,mp3,ogg,ogv,torrent,php,css,tpl,ini,eml\';','SECURITY','UPLOADED_FILES','CONFIG_OPTION_valid_types','0',''),
 ('valid_images','IMAGE_TYPES','0','','line','return \'jpg,jpeg,gif,png,ico\';','SECURITY','UPLOADED_FILES','CONFIG_OPTION_valid_images','0',''),
 ('is_on_rating','RATING','0','','tick','return \'1\';','FEATURE','USER_INTERACTION','CONFIG_OPTION_is_on_rating','0',''),
 ('is_on_comments','COMMENTS','0','','tick','return has_no_forum()?NULL:\'1\';','FEATURE','USER_INTERACTION','CONFIG_OPTION_is_on_comments','0',''),
 ('comments_forum_name','COMMENTS_FORUM_NAME','0','','forum','return has_no_forum()?NULL:do_lang(\'COMMENT_FORUM_NAME\',\'\',\'\',\'\',get_site_default_lang());','FEATURE','USER_INTERACTION','CONFIG_OPTION_comments_forum_name','0',''),
 ('comment_text','COMMENT_FORM_TEXT','0','','transtext','return has_no_forum()?NULL:static_evaluate_tempcode(do_template(\'COMMENTS_DEFAULT_TEXT\'));','FEATURE','USER_INTERACTION','CONFIG_OPTION_comment_text','0',''),
 ('thumb_width','THUMB_WIDTH','0','','integer','return \'200\';','FEATURE','IMAGES','CONFIG_OPTION_thumb_width','0',''),
 ('max_image_size','IMAGES','0','','integer','return \'700\';','SITE','UPLOAD','CONFIG_OPTION_max_image_size','0',''),
 ('users_online_time','USERS_ONLINE_TIME','0','','integer','return \'5\';','SITE','LOGGING','CONFIG_OPTION_users_online_time','0',''),
 ('system_flagrant','SYSTEM_FLAGRANT','0','','transline','return \'\';','SITE','GENERAL','CONFIG_OPTION_system_flagrant','0',''),
 ('messaging_forum_name','_MESSAGING_FORUM_NAME','0','','forum','return do_lang(\'MESSAGING_FORUM_NAME\',\'\',\'\',\'\',get_site_default_lang());','FEATURE','CONTACT_US_MESSAGING','CONFIG_OPTION_messaging_forum_name','0',''),
 ('occle_chat_announce','OCCLE_CHAT_ANNOUNCE','0','','tick','return \'0\';','SITE','ADVANCED','CONFIG_OPTION_occle_chat_announce','0',''),
 ('bottom_show_occle_button','OCCLE_BUTTON','0','','tick','return (get_file_base()!=get_custom_file_base())?\'0\':\'1\';','FEATURE','BOTTOM_LINKS','CONFIG_OPTION_bottom_show_occle_button','0',''),
 ('ldap_is_enabled','LDAP_IS_ENABLED','0','','tick','return \'0\';','SECTION_FORUMS','LDAP','CONFIG_OPTION_ldap_is_enabled','1',''),
 ('ldap_is_windows','LDAP_IS_WINDOWS','0','','tick','return (DIRECTORY_SEPARATOR==\'/\')?\'0\':\'1\';','SECTION_FORUMS','LDAP','CONFIG_OPTION_ldap_is_windows','1',''),
 ('ldap_allow_joining','LDAP_ALLOW_JOINING','0','','tick','return \'0\';','SECTION_FORUMS','LDAP','CONFIG_OPTION_ldap_allow_joining','1',''),
 ('ldap_hostname','LDAP_HOSTNAME','0','','line','return \'localhost\';','SECTION_FORUMS','LDAP','CONFIG_OPTION_ldap_hostname','1',''),
 ('ldap_base_dn','LDAP_BASE_DN','0','','line','return \'dc=chris4,dc=com\';','SECTION_FORUMS','LDAP','CONFIG_OPTION_ldap_base_dn','1',''),
 ('ldap_bind_rdn','USERNAME','0','','line','return (DIRECTORY_SEPARATOR==\'/\')?\'NotManager\':\'NotAdministrator\';','SECTION_FORUMS','LDAP','CONFIG_OPTION_ldap_bind_rdn','1',''),
 ('ldap_bind_password','PASSWORD','0','','line','return \'\';','SECTION_FORUMS','LDAP','CONFIG_OPTION_ldap_bind_password','1',''),
 ('windows_auth_is_enabled','WINDOWS_AUTHENTICATION','0','','tick','return \'0\';','SECTION_FORUMS','LDAP','CONFIG_OPTION_windows_auth_is_enabled','0',''),
 ('ldap_login_qualifier','LDAP_LOGIN_QUALIFIER','0','','line','return is_null($old=get_value(\'ldap_login_qualifier\'))?\'\':$old;','SECTION_FORUMS','LDAP','CONFIG_OPTION_ldap_login_qualifier','0',''),
 ('ldap_group_search_qualifier','LDAP_GROUP_SEARCH_QUALIFIER','0','','line','return \'ou=Group\';','SECTION_FORUMS','LDAP','CONFIG_OPTION_ldap_group_search_qualifier','0',''),
 ('ldap_member_search_qualifier','LDAP_MEMBER_SEARCH_QUALIFIER','0','','line','return (get_option(\'ldap_is_windows\')==\'0\')?\'cn=Users\':\'ou=People\';','SECTION_FORUMS','LDAP','CONFIG_OPTION_ldap_member_search_qualifier','0',''),
 ('ldap_member_property','LDAP_MEMBER_PROPERTY','0','','line','return (get_option(\'ldap_is_windows\')==\'0\')?\'uid\':\'sAMAccountName\';','SECTION_FORUMS','LDAP','CONFIG_OPTION_ldap_member_property','0',''),
 ('ldap_none_bind_logins','LDAP_NONE_BIND_LOGINS','0','','tick','return \'1\';','SECTION_FORUMS','LDAP','CONFIG_OPTION_ldap_none_bind_logins','0',''),
 ('ldap_version','LDAP_VERSION','0','','integer','return \'3\';','SECTION_FORUMS','LDAP','CONFIG_OPTION_ldap_version','0',''),
 ('ldap_group_class','LDAP_GROUP_CLASS','0','','line','return \'posixGroup\';','SECTION_FORUMS','LDAP','CONFIG_OPTION_ldap_group_class','0',''),
 ('ldap_member_class','LDAP_MEMBER_CLASS','0','','line','return \'posixAccount\';','SECTION_FORUMS','LDAP','CONFIG_OPTION_ldap_member_class','0',''),
 ('bottom_show_realtime_rain_button','REALTIME_RAIN_BUTTON','0','','tick','return \'0\';','FEATURE','BOTTOM_LINKS','CONFIG_OPTION_bottom_show_realtime_rain_button','0',''),
 ('staff_text','PAGE_TEXT','0','','transtext','return do_lang(\'POST_STAFF\');','SECURITY','STAFF','CONFIG_OPTION_staff_text','0',''),
 ('is_on_staff_filter','MEMBER_FILTER','0','','tick','return \'0\';','SECURITY','STAFF','CONFIG_OPTION_is_on_staff_filter','1',''),
 ('is_on_sync_staff','SYNCHRONISATION','0','','tick','return \'0\';','SECURITY','STAFF','CONFIG_OPTION_is_on_sync_staff','1',''),
 ('super_logging','SUPER_LOGGING','0','','tick','return \'1\';','SITE','LOGGING','CONFIG_OPTION_super_logging','1',''),
 ('stats_store_time','STORE_TIME','0','','integer','return \'124\';','SITE','LOGGING','CONFIG_OPTION_stats_store_time','1',''),
 ('templates_store_revisions','STORE_REVISIONS','0','','tick','return \'1\';','ADMIN','EDIT_TEMPLATES','CONFIG_OPTION_templates_store_revisions','0',''),
 ('templates_number_revisions_show','SHOW_REVISIONS','0','','integer','return \'5\';','ADMIN','EDIT_TEMPLATES','CONFIG_OPTION_templates_number_revisions_show','0',''),
 ('is_on_banners','ENABLE_BANNERS','0','','tick','return \'1\';','FEATURE','BANNERS','CONFIG_OPTION_is_on_banners','0',''),
 ('money_ad_code','MONEY_AD_CODE','0','','text','return \'\';','FEATURE','BANNERS','CONFIG_OPTION_money_ad_code','1',''),
 ('advert_chance','ADVERT_CHANCE','0','','float','return \'5\';','FEATURE','BANNERS','CONFIG_OPTION_advert_chance','1',''),
 ('points_ADD_BANNER','ADD_BANNER','0','','integer','return addon_installed(\'points\')?\'0\':NULL;','POINTS','COUNT_POINTS_GIVEN','CONFIG_OPTION_points_ADD_BANNER','0',''),
 ('use_banner_permissions','PERMISSIONS','0','','tick','return \'0\';','FEATURE','BANNERS','CONFIG_OPTION_use_banner_permissions','0',''),
 ('banner_autosize','BANNER_AUTOSIZE','0','','tick','return is_null($old=get_value(\'banner_autosize\'))?\'0\':$old;','FEATURE','BANNERS','CONFIG_OPTION_banner_autosize','0',''),
 ('admin_banners','ADMIN_BANNERS','0','','tick','return is_null($old=get_value(\'always_banners\'))?\'0\':$old;','FEATURE','BANNERS','CONFIG_OPTION_admin_banners','0',''),
 ('calendar_show_stats_count_events','EVENTS','0','','tick','return addon_installed(\'stats_block\')?\'0\':NULL;','BLOCKS','STATISTICS','CONFIG_OPTION_calendar_show_stats_count_events','0',''),
 ('calendar_show_stats_count_events_this_week','_EVENTS_THIS_WEEK','0','','tick','return addon_installed(\'stats_block\')?\'0\':NULL;','BLOCKS','STATISTICS','CONFIG_OPTION_calendar_show_stats_count_events_this_week','0',''),
 ('calendar_show_stats_count_events_this_month','_EVENTS_THIS_MONTH','0','','tick','return addon_installed(\'stats_block\')?\'0\':NULL;','BLOCKS','STATISTICS','CONFIG_OPTION_calendar_show_stats_count_events_this_month','0',''),
 ('calendar_show_stats_count_events_this_year','_EVENTS_THIS_YEAR','0','','tick','return addon_installed(\'stats_block\')?\'0\':NULL;','BLOCKS','STATISTICS','CONFIG_OPTION_calendar_show_stats_count_events_this_year','0',''),
 ('points_cedi','CEDI_MAKE_POST','0','','integer','return addon_installed(\'points\')?\'10\':NULL;','POINTS','COUNT_POINTS_GIVEN','CONFIG_OPTION_points_cedi','0',''),
 ('cedi_show_stats_count_pages','CEDI_PAGES','0','','tick','return addon_installed(\'stats_block\')?\'0\':NULL;','BLOCKS','STATISTICS','CONFIG_OPTION_cedi_show_stats_count_pages','0',''),
 ('cedi_show_stats_count_posts','CEDI_POSTS','0','','tick','return addon_installed(\'stats_block\')?\'0\':NULL;','BLOCKS','STATISTICS','CONFIG_OPTION_cedi_show_stats_count_posts','0',''),
 ('chat_flood_timelimit','FLOOD_TIMELIMIT','0','','integer','return \'5\';','FEATURE','SECTION_CHAT','CONFIG_OPTION_chat_flood_timelimit','0',''),
 ('chat_default_post_colour','CHAT_OPTIONS_COLOUR_NAME','0','','colour','return \'inherit\';','FEATURE','SECTION_CHAT','CONFIG_OPTION_chat_default_post_colour','0',''),
 ('chat_default_post_font','CHAT_OPTIONS_TEXT_NAME','0','','list','return \'Verdana\';','FEATURE','SECTION_CHAT','CONFIG_OPTION_chat_default_post_font','0','Arial|Courier|Georgia|Impact|Times| Trebuchet|Verdana|Tahoma|Geneva|Helvetica'),
 ('chat_private_room_deletion_time','PRIVATE_ROOM_DELETION_TIME','0','','integer','return \'1440\';','FEATURE','SECTION_CHAT','CONFIG_OPTION_chat_private_room_deletion_time','0',''),
 ('username_click_im','USERNAME_CLICK_IM','0','','tick','return \'0\';','FEATURE','SECTION_CHAT','CONFIG_OPTION_username_click_im','0',''),
 ('points_chat','CHATTING','0','','integer','return addon_installed(\'points\')?\'1\':NULL;','POINTS','COUNT_POINTS_GIVEN','CONFIG_OPTION_points_chat','0',''),
 ('chat_show_stats_count_users','COUNT_CHATTERS','0','','tick','return addon_installed(\'stats_block\')?\'0\':NULL;','BLOCKS','STATISTICS','CONFIG_OPTION_chat_show_stats_count_users','0',''),
 ('chat_show_stats_count_rooms','ROOMS','0','','tick','return addon_installed(\'stats_block\')?\'0\':NULL;','BLOCKS','STATISTICS','CONFIG_OPTION_chat_show_stats_count_rooms','0',''),
 ('chat_show_stats_count_messages','COUNT_CHATPOSTS','0','','tick','return addon_installed(\'stats_block\')?\'0\':NULL;','BLOCKS','STATISTICS','CONFIG_OPTION_chat_show_stats_count_messages','0',''),
 ('sitewide_im','SITEWIDE_IM','0','','tick','return \'0\';','FEATURE','SECTION_CHAT','CONFIG_OPTION_sitewide_im','0',''),
 ('group_private_chatrooms','GROUP_PRIVATE_CHATROOMS','0','','tick','return is_null($old=get_value(\'no_group_private_chatrooms\'))?\'1\':invert_value($old);','FEATURE','SECTION_CHAT','CONFIG_OPTION_group_private_chatrooms','0',''),
 ('maximum_download','MAXIMUM_DOWNLOAD','0','','integer','return \'15\';','SITE','CLOSED_SITE','CONFIG_OPTION_maximum_download','0',''),
 ('show_dload_trees','SHOW_DLOAD_TREES','0','','tick','return \'0\';','FEATURE','SECTION_DOWNLOADS','CONFIG_OPTION_show_dload_trees','1',''),
 ('points_ADD_DOWNLOAD','ADD_DOWNLOAD','0','','integer','return addon_installed(\'points\')?\'150\':NULL;','POINTS','COUNT_POINTS_GIVEN','CONFIG_OPTION_points_ADD_DOWNLOAD','0',''),
 ('downloads_show_stats_count_total','_SECTION_DOWNLOADS','0','','tick','return addon_installed(\'stats_block\')?\'0\':NULL;','BLOCKS','STATISTICS','CONFIG_OPTION_downloads_show_stats_count_total','0',''),
 ('downloads_show_stats_count_archive','TOTAL_DOWNLOADS_IN_ARCHIVE','0','','tick','return addon_installed(\'stats_block\')?\'0\':NULL;','BLOCKS','STATISTICS','CONFIG_OPTION_downloads_show_stats_count_archive','0',''),
 ('downloads_show_stats_count_downloads','_COUNT_DOWNLOADS','0','','tick','return addon_installed(\'stats_block\')?\'0\':NULL;','BLOCKS','STATISTICS','CONFIG_OPTION_downloads_show_stats_count_downloads','0',''),
 ('downloads_show_stats_count_bandwidth','_COUNT_BANDWIDTH','0','','tick','return addon_installed(\'stats_block\')?\'0\':NULL;','BLOCKS','STATISTICS','CONFIG_OPTION_downloads_show_stats_count_bandwidth','0',''),
 ('immediate_downloads','IMMEDIATE_DOWNLOADS','0','','tick','return \'0\';','FEATURE','SECTION_DOWNLOADS','CONFIG_OPTION_immediate_downloads','0',''),
 ('download_gallery_root','DOWNLOAD_GALLERY_ROOT','0','','line','return is_null($old=get_value(\'download_gallery_root\'))?(addon_installed(\'galleries\')?\'root\':NULL):$old;','FEATURE','SECTION_DOWNLOADS','CONFIG_OPTION_download_gallery_root','0',''),
 ('points_ADD_IMAGE','ADD_IMAGE','0','','integer','return addon_installed(\'points\')?\'100\':NULL;','POINTS','COUNT_POINTS_GIVEN','CONFIG_OPTION_points_ADD_IMAGE','0',''),
 ('points_ADD_VIDEO','ADD_VIDEO','0','','integer','return addon_installed(\'points\')?\'100\':NULL;','POINTS','COUNT_POINTS_GIVEN','CONFIG_OPTION_points_ADD_VIDEO','0',''),
 ('default_video_width','DEFAULT_VIDEO_WIDTH','0','','integer','return \'320\';','FEATURE','GALLERIES','CONFIG_OPTION_default_video_width','0',''),
 ('default_video_height','DEFAULT_VIDEO_HEIGHT','0','','integer','return \'240\';','FEATURE','GALLERIES','CONFIG_OPTION_default_video_height','0',''),
 ('maximum_image_size','MAXIMUM_IMAGE_SIZE','0','','integer','return \'1024\';','FEATURE','GALLERIES','CONFIG_OPTION_maximum_image_size','0',''),
 ('max_personal_gallery_images_low','GALLERY_IMAGE_LIMIT_LOW','0','','integer','return \'5\';','FEATURE','GALLERIES','CONFIG_OPTION_max_personal_gallery_images_low','0',''),
 ('max_personal_gallery_images_high','GALLERY_IMAGE_LIMIT_HIGH','0','','integer','return \'10\';','FEATURE','GALLERIES','CONFIG_OPTION_max_personal_gallery_images_high','0',''),
 ('max_personal_gallery_videos_low','GALLERY_VIDEO_LIMIT_LOW','0','','integer','return \'2\';','FEATURE','GALLERIES','CONFIG_OPTION_max_personal_gallery_videos_low','0',''),
 ('max_personal_gallery_videos_high','GALLERY_VIDEO_LIMIT_HIGH','0','','integer','return \'5\';','FEATURE','GALLERIES','CONFIG_OPTION_max_personal_gallery_videos_high','0',''),
 ('galleries_show_stats_count_galleries','GALLERIES','0','','tick','return addon_installed(\'stats_block\')?\'0\':NULL;','BLOCKS','STATISTICS','CONFIG_OPTION_galleries_show_stats_count_galleries','0',''),
 ('galleries_show_stats_count_images','IMAGES','0','','tick','return addon_installed(\'stats_block\')?\'0\':NULL;','BLOCKS','STATISTICS','CONFIG_OPTION_galleries_show_stats_count_images','0',''),
 ('galleries_show_stats_count_videos','VIDEOS','0','','tick','return addon_installed(\'stats_block\')?\'0\':NULL;','BLOCKS','STATISTICS','CONFIG_OPTION_galleries_show_stats_count_videos','0',''),
 ('show_empty_galleries','SHOW_EMPTY_GALLERIES','0','','tick','return \'1\';','FEATURE','GALLERIES','CONFIG_OPTION_show_empty_galleries','0',''),
 ('gallery_name_order','GALLERY_NAME_ORDER','0','','tick','return \'0\';','FEATURE','GALLERIES','CONFIG_OPTION_gallery_name_order','0',''),
 ('gallery_selectors','GALLERY_SELECTORS','0','','line','return is_null($old=get_value(\'gallery_selectors\'))?\'12,24,36,64,128\':$old;','FEATURE','GALLERIES','CONFIG_OPTION_gallery_selectors','0',''),
 ('reverse_thumb_order','REVERSE_THUMB_ORDER','0','','tick','return is_null($old=get_value(\'reverse_thumb_order\'))?\'0\':$old;','FEATURE','GALLERIES','CONFIG_OPTION_reverse_thumb_order','0',''),
 ('show_gallery_counts','SHOW_GALLERY_COUNTS','0','','tick','return is_null($old=get_value(\'show_gallery_counts\'))?((get_forum_type()==\'ocf\')?\'0\':NULL):$old;','FEATURE','GALLERIES','CONFIG_OPTION_show_gallery_counts','0',''),
 ('video_bitrate','VIDEO_BITRATE','0','','integer','return \'1000\';','FEATURE','TRANSCODING','CONFIG_OPTION_video_bitrate','0',''),
 ('audio_bitrate','AUDIO_BITRATE','0','','integer','return \'192\';','FEATURE','TRANSCODING','CONFIG_OPTION_audio_bitrate','0',''),
 ('video_width_setting','VIDEO_WIDTH_SETTING','0','','integer','return \'720\';','FEATURE','TRANSCODING','CONFIG_OPTION_video_width_setting','0',''),
 ('video_height_setting','VIDEO_HEIGHT_SETTING','0','','integer','return \'480\';','FEATURE','TRANSCODING','CONFIG_OPTION_video_height_setting','0',''),
 ('transcoding_zencoder_api_key','TRANSCODING_ZENCODER_API_KEY','0','','line','return \'\';','FEATURE','TRANSCODING','CONFIG_OPTION_transcoding_zencoder_api_key','0',''),
 ('transcoding_zencoder_ftp_path','TRANSCODING_ZENCODER_FTP_PATH','0','','line','return \'\';','FEATURE','TRANSCODING','CONFIG_OPTION_transcoding_zencoder_ftp_path','0',''),
 ('transcoding_server','TRANSCODING_SERVER','0','','line','return \'\';','FEATURE','TRANSCODING','CONFIG_OPTION_transcoding_server','0',''),
 ('ffmpeg_path','FFMPEG_PATH','0','','line','return \'\';','FEATURE','TRANSCODING','CONFIG_OPTION_ffmpeg_path','0',''),
 ('points_CHOOSE_IOTD','CHOOSE_IOTD','0','','integer','return addon_installed(\'points\')?\'35\':NULL;','POINTS','COUNT_POINTS_GIVEN','CONFIG_OPTION_points_CHOOSE_IOTD','0',''),
 ('points_ADD_IOTD','ADD_IOTD','0','','integer','return addon_installed(\'points\')?\'150\':NULL;','POINTS','COUNT_POINTS_GIVEN','CONFIG_OPTION_points_ADD_IOTD','0',''),
 ('iotd_update_time','IOTD_REGULARITY','0','','integer','return \'24\';','ADMIN','CHECK_LIST','CONFIG_OPTION_iotd_update_time','0',''),
 ('points_ADD_NEWS','ADD_NEWS','0','','integer','return addon_installed(\'points\')?\'225\':NULL;','POINTS','COUNT_POINTS_GIVEN','CONFIG_OPTION_points_ADD_NEWS','0',''),
 ('news_update_time','NEWS_REGULARITY','0','','integer','return \'168\';','ADMIN','CHECK_LIST','CONFIG_OPTION_news_update_time','0',''),
 ('blog_update_time','BLOG_REGULARITY','0','','integer','return \'168\';','ADMIN','CHECK_LIST','CONFIG_OPTION_blog_update_time','0',''),
 ('ping_url','PING_URL','0','','text','return \'http://pingomatic.com/ping/?title={title}&blogurl={url}&rssurl={rss}\';','FEATURE','NEWS_AND_RSS','CONFIG_OPTION_ping_url','0',''),
 ('news_show_stats_count_total_posts','TOTAL_NEWS_ENTRIES','0','','tick','return addon_installed(\'stats_block\')?\'0\':NULL;','BLOCKS','STATISTICS','CONFIG_OPTION_news_show_stats_count_total_posts','0',''),
 ('news_show_stats_count_blogs','BLOGS','0','','tick','return addon_installed(\'stats_block\')?\'0\':NULL;','BLOCKS','STATISTICS','CONFIG_OPTION_news_show_stats_count_blogs','0',''),
 ('newsletter_text','PAGE_TEXT','0','','transtext','return \'\';','FEATURE','NEWSLETTER','CONFIG_OPTION_newsletter_text','0',''),
 ('newsletter_title','TITLE','0','','line','return get_option(\'site_name\').\' \'.ocp_mb_strtolower(do_lang(\'NEWSLETTER\'));','FEATURE','NEWSLETTER','CONFIG_OPTION_newsletter_title','0',''),
 ('interest_levels','USE_INTEREST_LEVELS','0','','tick','return \'0\';','FEATURE','NEWSLETTER','CONFIG_OPTION_interest_levels','0',''),
 ('points_joining','JOINING','0','','integer','return \'40\';','POINTS','COUNT_POINTS_GIVEN','CONFIG_OPTION_points_joining','0',''),
 ('points_posting','MAKE_POST','0','','integer','return \'5\';','POINTS','COUNT_POINTS_GIVEN','CONFIG_OPTION_points_posting','0',''),
 ('points_rating','RATING','0','','integer','return \'5\';','POINTS','COUNT_POINTS_GIVEN','CONFIG_OPTION_points_rating','0',''),
 ('points_voting','VOTING','0','','integer','return \'5\';','POINTS','COUNT_POINTS_GIVEN','CONFIG_OPTION_points_voting','0',''),
 ('points_if_liked','POINTS_IF_LIKED','0','','integer','return \'5\';','POINTS','COUNT_POINTS_GIVEN','CONFIG_OPTION_points_if_liked','0',''),
 ('points_show_personal_stats_points_left','COUNT_POINTS_LEFT','0','','tick','return \'0\';','BLOCKS','PERSONAL_BLOCK','CONFIG_OPTION_points_show_personal_stats_points_left','0',''),
 ('points_show_personal_stats_points_used','COUNT_POINTS_USED','0','','tick','return \'0\';','BLOCKS','PERSONAL_BLOCK','CONFIG_OPTION_points_show_personal_stats_points_used','0',''),
 ('points_show_personal_stats_gift_points_left','COUNT_GIFT_POINTS_LEFT','0','','tick','return \'0\';','BLOCKS','PERSONAL_BLOCK','CONFIG_OPTION_points_show_personal_stats_gift_points_left','0',''),
 ('points_show_personal_stats_gift_points_used','COUNT_GIFT_POINTS_USED','0','','tick','return \'0\';','BLOCKS','PERSONAL_BLOCK','CONFIG_OPTION_points_show_personal_stats_gift_points_used','0',''),
 ('points_show_personal_stats_total_points','COUNT_POINTS_EVER','0','','tick','return \'0\';','BLOCKS','PERSONAL_BLOCK','CONFIG_OPTION_points_show_personal_stats_total_points','0',''),
 ('points_per_day','POINTS_PER_DAY','0','','integer','return \'0\';','POINTS','COUNT_POINTS_GIVEN','CONFIG_OPTION_points_per_day','0',''),
 ('points_per_daily_visit','POINTS_PER_DAILY_VISIT','0','','integer','return \'0\';','POINTS','COUNT_POINTS_GIVEN','CONFIG_OPTION_points_per_daily_visit','0',''),
 ('is_on_highlight_name_buy','ENABLE_PURCHASE','0','','tick','return (get_forum_type()!=\'ocf\')?false:\'1\';','POINTSTORE','NAME_HIGHLIGHTING','CONFIG_OPTION_is_on_highlight_name_buy','0',''),
 ('highlight_name','COST_highlight_name','0','','integer','return (get_forum_type()!=\'ocf\')?false:\'2000\';','POINTSTORE','NAME_HIGHLIGHTING','CONFIG_OPTION_highlight_name','0',''),
 ('is_on_topic_pin_buy','ENABLE_PURCHASE','0','','tick','return (!addon_installed(\'ocf_forum\'))?false:\'1\';','POINTSTORE','TOPIC_PINNING','CONFIG_OPTION_is_on_topic_pin_buy','0',''),
 ('topic_pin','COST_topic_pin','0','','integer','return (!addon_installed(\'ocf_forum\'))?false:\'180\';','POINTSTORE','TOPIC_PINNING','CONFIG_OPTION_topic_pin','0',''),
 ('is_on_gambling_buy','ENABLE_PURCHASE','0','','tick','return \'1\';','POINTSTORE','GAMBLING','CONFIG_OPTION_is_on_gambling_buy','0',''),
 ('minimum_gamble_amount','MINIMUM_GAMBLE_AMOUNT','0','','integer','return \'6\';','POINTSTORE','GAMBLING','CONFIG_OPTION_minimum_gamble_amount','0',''),
 ('maximum_gamble_amount','MAXIMUM_GAMBLE_AMOUNT','0','','integer','return \'200\';','POINTSTORE','GAMBLING','CONFIG_OPTION_maximum_gamble_amount','0',''),
 ('maximum_gamble_multiplier','MAXIMUM_GAMBLE_MULTIPLIER','0','','integer','return \'200\';','POINTSTORE','GAMBLING','CONFIG_OPTION_maximum_gamble_multiplier','0',''),
 ('average_gamble_multiplier','AVERAGE_GAMBLE_MULTIPLIER','0','','integer','return \'85\';','POINTSTORE','GAMBLING','CONFIG_OPTION_average_gamble_multiplier','0',''),
 ('banner_setup','COST_banner_setup','0','','integer','return (!addon_installed(\'banners\'))?false:\'750\';','POINTSTORE','BANNERS','CONFIG_OPTION_banner_setup','0',''),
 ('banner_imp','COST_banner_imp','0','','integer','return (!addon_installed(\'banners\'))?false:\'700\';','POINTSTORE','BANNERS','CONFIG_OPTION_banner_imp','0',''),
 ('banner_hit','COST_banner_hit','0','','integer','return (!addon_installed(\'banners\'))?false:\'20\';','POINTSTORE','BANNERS','CONFIG_OPTION_banner_hit','0',''),
 ('quota','COST_quota','0','','integer','return \'2\';','POINTSTORE','POP3','CONFIG_OPTION_quota','0',''),
 ('text','COST_text','0','','integer','return (!addon_installed(\'flagrant\'))?false:\'700\';','POINTSTORE','FLAGRANT_MESSAGE','CONFIG_OPTION_text','0',''),
 ('is_on_banner_buy','ENABLE_PURCHASE','0','','tick','return (!addon_installed(\'banners\'))?false:\'1\';','POINTSTORE','BANNERS','CONFIG_OPTION_is_on_banner_buy','0',''),
 ('initial_banner_hits','HITS_ALLOCATED','0','','integer','return (!addon_installed(\'banners\'))?false:\'100\';','POINTSTORE','BANNERS','CONFIG_OPTION_initial_banner_hits','0',''),
 ('is_on_pop3_buy','ENABLE_PURCHASE','0','','tick','return \'0\';','POINTSTORE','POP3','CONFIG_OPTION_is_on_pop3_buy','1',''),
 ('initial_quota','QUOTA','0','','integer','return \'200\';','POINTSTORE','POP3','CONFIG_OPTION_initial_quota','1',''),
 ('max_quota','MAX_QUOTA','0','','integer','return \'10000\';','POINTSTORE','POP3','CONFIG_OPTION_max_quota','1',''),
 ('mail_server','MAIL_SERVER','0','','line','return \'mail.\'.get_domain();','POINTSTORE','POP3','CONFIG_OPTION_mail_server','1',''),
 ('pop_url','POP3_MAINTAIN_URL','0','','line','return \'http://\'.get_domain().\':2082/frontend/x/mail/addpop2.html\';','POINTSTORE','POP3','CONFIG_OPTION_pop_url','1',''),
 ('quota_url','QUOTA_MAINTAIN_URL','0','','line','return \'http://\'.get_domain().\':2082/frontend/x/mail/pops.html\';','POINTSTORE','POP3','CONFIG_OPTION_quota_url','1',''),
 ('is_on_forw_buy','ENABLE_PURCHASE','0','','tick','return \'0\';','POINTSTORE','FORWARDING','CONFIG_OPTION_is_on_forw_buy','1',''),
 ('forw_url','FORW_MAINTAIN_URL','0','','line','return \'http://\'.get_domain().\':2082/frontend/x/mail/addfwd.html\';','POINTSTORE','FORWARDING','CONFIG_OPTION_forw_url','1',''),
 ('is_on_flagrant_buy','ENABLE_PURCHASE','0','','tick','return (!addon_installed(\'flagrant\'))?false:\'1\';','POINTSTORE','FLAGRANT_MESSAGE','CONFIG_OPTION_is_on_flagrant_buy','0',''),
 ('points_ADD_POLL','ADD_POLL','0','','integer','return addon_installed(\'points\')?\'150\':NULL;','POINTS','COUNT_POINTS_GIVEN','CONFIG_OPTION_points_ADD_POLL','0',''),
 ('points_CHOOSE_POLL','CHOOSE_POLL','0','','integer','return addon_installed(\'points\')?\'35\':NULL;','POINTS','COUNT_POINTS_GIVEN','CONFIG_OPTION_points_CHOOSE_POLL','0',''),
 ('poll_update_time','POLL_REGULARITY','0','','integer','return \'168\';','ADMIN','CHECK_LIST','CONFIG_OPTION_poll_update_time','0',''),
 ('payment_gateway','PAYMENT_GATEWAY','0','','line','return \'paypal\';','ECOMMERCE','ECOMMERCE','CONFIG_OPTION_payment_gateway','0',''),
 ('use_local_payment','USE_LOCAL_PAYMENT','0','','tick','return \'0\';','ECOMMERCE','ECOMMERCE','CONFIG_OPTION_use_local_payment','0',''),
 ('ipn_password','IPN_PASSWORD','0','','line','return \'\';','ECOMMERCE','ECOMMERCE','CONFIG_OPTION_ipn_password','0',''),
 ('ipn_digest','IPN_DIGEST','0','','line','return \'\';','ECOMMERCE','ECOMMERCE','CONFIG_OPTION_ipn_digest','0',''),
 ('vpn_username','VPN_USERNAME','0','','line','return \'\';','ECOMMERCE','ECOMMERCE','CONFIG_OPTION_vpn_username','0',''),
 ('vpn_password','VPN_PASSWORD','0','','line','return \'\';','ECOMMERCE','ECOMMERCE','CONFIG_OPTION_vpn_password','0',''),
 ('callback_password','CALLBACK_PASSWORD','0','','line','return \'\';','ECOMMERCE','ECOMMERCE','CONFIG_OPTION_callback_password','0',''),
 ('pd_address','POSTAL_ADDRESS','0','','text','return \'\';','ECOMMERCE','ECOMMERCE','CONFIG_OPTION_pd_address','0',''),
 ('pd_email','EMAIL_ADDRESS','0','','line','return get_option(\'staff_address\');','ECOMMERCE','ECOMMERCE','CONFIG_OPTION_pd_email','0',''),
 ('pd_number','PHONE_NUMBER','0','','line','return \'\';','ECOMMERCE','ECOMMERCE','CONFIG_OPTION_pd_number','0',''),
 ('currency','CURRENCY','0','','line','return \'GBP\';','ECOMMERCE','ECOMMERCE','CONFIG_OPTION_currency','0',''),
 ('ecommerce_test_mode','ECOMMERCE_TEST_MODE','0','','tick','return \'0\';','ECOMMERCE','ECOMMERCE','CONFIG_OPTION_ecommerce_test_mode','0',''),
 ('ipn_test','IPN_ADDRESS_TEST','0','','line','return get_option(\'staff_address\');','ECOMMERCE','ECOMMERCE','CONFIG_OPTION_ipn_test','0',''),
 ('ipn','IPN_ADDRESS','0','','line','return get_option(\'staff_address\');','ECOMMERCE','ECOMMERCE','CONFIG_OPTION_ipn','0',''),
 ('quiz_show_stats_count_total_open','QUIZZES','0','','tick','return addon_installed(\'stats_block\')?\'0\':NULL;','BLOCKS','STATISTICS','CONFIG_OPTION_quiz_show_stats_count_total_open','0',''),
 ('points_ADD_QUIZ','ADD_QUIZ','0','','integer','return addon_installed(\'points\')?\'0\':NULL;','POINTS','COUNT_POINTS_GIVEN','CONFIG_OPTION_points_ADD_QUIZ','0',''),
 ('shipping_cost_factor','SHIPPING_COST_FACTOR','0','','float','return \'0\';','ECOMMERCE','ECOMMERCE','CONFIG_OPTION_shipping_cost_factor','1',''),
 ('allow_opting_out_of_tax','ALLOW_OPTING_OUT_OF_TAX','0','','tick','return \'1\';','ECOMMERCE','ECOMMERCE','CONFIG_OPTION_allow_opting_out_of_tax','0',''),
 ('tester_forum_name','TESTER_FORUM_NAME','0','','forum','return do_lang(\'DEFAULT_TESTER_FORUM\');','FEATURE','TESTER','CONFIG_OPTION_tester_forum_name','0',''),
 ('bug_report_text','BUG_REPORT_TEXT','0','','text','return do_lang(\'DEFAULT_BUG_REPORT_TEMPLATE\');','FEATURE','TESTER','CONFIG_OPTION_bug_report_text','0',''),
 ('ticket_member_forums','TICKET_MEMBER_FORUMS','0','','tick','return \'0\';','FEATURE','SUPPORT_TICKETS','CONFIG_OPTION_ticket_member_forums','0',''),
 ('ticket_type_forums','TICKET_TYPE_FORUMS','0','','tick','return \'0\';','FEATURE','SUPPORT_TICKETS','CONFIG_OPTION_ticket_type_forums','0',''),
 ('ticket_text','PAGE_TEXT','0','','transtext','return do_lang(\'NEW_TICKET_WELCOME\');','FEATURE','SUPPORT_TICKETS','CONFIG_OPTION_ticket_text','0',''),
 ('ticket_forum_name','TICKET_FORUM_NAME','0','','forum','require_lang(\'tickets\'); return do_lang(\'TICKET_FORUM_NAME\',\'\',\'\',\'\',get_site_default_lang());','FEATURE','SUPPORT_TICKETS','CONFIG_OPTION_ticket_forum_name','0',''),
 ('points_COMCODE_PAGE_ADD','COMCODE_PAGE_ADD','0','','integer','return addon_installed(\'points\')?\'10\':NULL;','POINTS','COUNT_POINTS_GIVEN','CONFIG_OPTION_points_COMCODE_PAGE_ADD','0',''),
 ('store_revisions','STORE_REVISIONS','0','','tick','return \'1\';','ADMIN','COMCODE_PAGE_MANAGEMENT','CONFIG_OPTION_store_revisions','0',''),
 ('number_revisions_show','SHOW_REVISIONS','0','','integer','return \'5\';','ADMIN','COMCODE_PAGE_MANAGEMENT','CONFIG_OPTION_number_revisions_show','0',''),
 ('filedump_show_stats_count_total_files','FILEDUMP_COUNT_FILES','0','','tick','return addon_installed(\'stats_block\')?\'0\':NULL;','BLOCKS','STATISTICS','CONFIG_OPTION_filedump_show_stats_count_total_files','0',''),
 ('filedump_show_stats_count_total_space','FILEDUMP_DISK_USAGE','0','','tick','return addon_installed(\'stats_block\')?\'0\':NULL;','BLOCKS','STATISTICS','CONFIG_OPTION_filedump_show_stats_count_total_space','0',''),
 ('leaderboard_start_date','LEADERBOARD_START_DATE','0','','date','return strval(filemtime(get_file_base().\'/index.php\'));','POINTS','POINT_LEADERBOARD','CONFIG_OPTION_leaderboard_start_date','0',''),
 ('is_on_rss','ENABLE_RSS','0','','tick','return \'1\';','FEATURE','NEWS_AND_RSS','CONFIG_OPTION_is_on_rss','0',''),
 ('rss_update_time','UPDATE_TIME','0','','integer','return \'60\';','FEATURE','NEWS_AND_RSS','CONFIG_OPTION_rss_update_time','0',''),
 ('is_rss_advertised','ENABLE_RSS_ADVERTISING','0','','tick','return \'0\';','FEATURE','NEWS_AND_RSS','CONFIG_OPTION_is_rss_advertised','0',''),
 ('network_links','NETWORK_LINKS','0','','line','return get_base_url().\'/netlink.php\';','SITE','ENVIRONMENT','CONFIG_OPTION_network_links','1',''),
 ('forum_show_stats_count_members','COUNT_MEMBERS','0','','tick','return addon_installed(\'stats_block\')?\'1\':NULL;','BLOCKS','STATISTICS','CONFIG_OPTION_forum_show_stats_count_members','0',''),
 ('forum_show_stats_count_topics','COUNT_TOPICS','0','','tick','return addon_installed(\'stats_block\')?\'1\':NULL;','BLOCKS','STATISTICS','CONFIG_OPTION_forum_show_stats_count_topics','0',''),
 ('forum_show_stats_count_posts','COUNT_POSTS','0','','tick','return addon_installed(\'stats_block\')?\'1\':NULL;','BLOCKS','STATISTICS','CONFIG_OPTION_forum_show_stats_count_posts','0',''),
 ('forum_show_stats_count_posts_today','COUNT_POSTSTODAY','0','','tick','return addon_installed(\'stats_block\')?\'0\':NULL;','BLOCKS','STATISTICS','CONFIG_OPTION_forum_show_stats_count_posts_today','0',''),
 ('activity_show_stats_count_users_online','COUNT_ONSITE','0','','tick','return addon_installed(\'stats_block\')?\'0\':NULL;','BLOCKS','STATISTICS','CONFIG_OPTION_activity_show_stats_count_users_online','0',''),
 ('activity_show_stats_count_users_online_record','COUNT_ONSITE_RECORD','0','','tick','return addon_installed(\'stats_block\')?\'0\':NULL;','BLOCKS','STATISTICS','CONFIG_OPTION_activity_show_stats_count_users_online_record','0',''),
 ('activity_show_stats_count_users_online_forum','COUNT_ONFORUMS','0','','tick','return ((get_forum_type()!=\'ocf\') && (addon_installed(\'stats_block\')))?\'0\':NULL;','BLOCKS','STATISTICS','CONFIG_OPTION_activity_show_stats_count_users_online_forum','0',''),
 ('activity_show_stats_count_page_views_today','PAGE_VIEWS_TODAY','0','','tick','return addon_installed(\'stats_block\')?\'0\':NULL;','BLOCKS','STATISTICS','CONFIG_OPTION_activity_show_stats_count_page_views_today','0',''),
 ('activity_show_stats_count_page_views_this_week','PAGE_VIEWS_THIS_WEEK','0','','tick','return addon_installed(\'stats_block\')?\'0\':NULL;','BLOCKS','STATISTICS','CONFIG_OPTION_activity_show_stats_count_page_views_this_week','0',''),
 ('activity_show_stats_count_page_views_this_month','PAGE_VIEWS_THIS_MONTH','0','','tick','return addon_installed(\'stats_block\')?\'0\':NULL;','BLOCKS','STATISTICS','CONFIG_OPTION_activity_show_stats_count_page_views_this_month','0',''),
 ('forum_show_stats_count_members_active_today','MEMBERS_ACTIVE_TODAY','0','','tick','return ((get_forum_type()==\'ocf\') && (!has_no_forum()) && (addon_installed(\'stats_block\')))?\'0\':NULL;','BLOCKS','STATISTICS','CONFIG_OPTION_forum_show_stats_count_members_active_today','0',''),
 ('forum_show_stats_count_members_active_this_week','MEMBERS_ACTIVE_THIS_WEEK','0','','tick','return ((get_forum_type()==\'ocf\') && (!has_no_forum()) && (addon_installed(\'stats_block\')))?\'0\':NULL;','BLOCKS','STATISTICS','CONFIG_OPTION_forum_show_stats_count_members_active_this_week','0',''),
 ('forum_show_stats_count_members_active_this_month','MEMBERS_ACTIVE_THIS_MONTH','0','','tick','return ((get_forum_type()==\'ocf\') && (!has_no_forum()) && (addon_installed(\'stats_block\')))?\'0\':NULL;','BLOCKS','STATISTICS','CONFIG_OPTION_forum_show_stats_count_members_active_this_month','0',''),
 ('forum_show_stats_count_members_new_today','MEMBERS_NEW_TODAY','0','','tick','return ((get_forum_type()==\'ocf\') && (!has_no_forum()) && (addon_installed(\'stats_block\')))?\'0\':NULL;','BLOCKS','STATISTICS','CONFIG_OPTION_forum_show_stats_count_members_new_today','0',''),
 ('forum_show_stats_count_members_new_this_week','MEMBERS_NEW_THIS_WEEK','0','','tick','return ((get_forum_type()==\'ocf\') && (!has_no_forum()) && (addon_installed(\'stats_block\')))?\'0\':NULL;','BLOCKS','STATISTICS','CONFIG_OPTION_forum_show_stats_count_members_new_this_week','0',''),
 ('forum_show_stats_count_members_new_this_month','MEMBERS_NEW_THIS_MONTH','0','','tick','return ((get_forum_type()==\'ocf\') && (!has_no_forum()) && (addon_installed(\'stats_block\')))?\'0\':NULL;','BLOCKS','STATISTICS','CONFIG_OPTION_forum_show_stats_count_members_new_this_month','0',''),
 ('usersonline_show_newest_member','SHOW_NEWEST_MEMBER','0','','tick','return ((has_no_forum()) || (get_forum_type()!=\'ocf\'))?NULL:\'0\';','BLOCKS','USERS_ONLINE_BLOCK','CONFIG_OPTION_usersonline_show_newest_member','0',''),
 ('usersonline_show_birthdays','BIRTHDAYS','0','','tick','return ((has_no_forum()) || (get_forum_type()!=\'ocf\'))?NULL:\'0\';','BLOCKS','USERS_ONLINE_BLOCK','CONFIG_OPTION_usersonline_show_birthdays','0',''),
 ('points_RECOMMEND_SITE','RECOMMEND_SITE','0','','integer','return addon_installed(\'points\')?\'350\':NULL;','POINTS','COUNT_POINTS_GIVEN','CONFIG_OPTION_points_RECOMMEND_SITE','0',''),
 ('supermembers_text','PAGE_TEXT','0','','transtext','return do_lang(\'SUPERMEMBERS_TEXT\');','SECURITY','SUPER_MEMBERS','CONFIG_OPTION_supermembers_text','0','');

DROP TABLE IF EXISTS `ocp_cron_caching_requests`;

CREATE TABLE `ocp_cron_caching_requests` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `c_codename` varchar(80) NOT NULL,
  `c_map` longtext NOT NULL,
  `c_timezone` varchar(80) NOT NULL,
  `c_is_bot` tinyint(1) NOT NULL,
  `c_in_panel` tinyint(1) NOT NULL,
  `c_interlock` tinyint(1) NOT NULL,
  `c_store_as_tempcode` tinyint(1) NOT NULL,
  `c_lang` varchar(5) NOT NULL,
  `c_theme` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `c_compound` (`c_codename`,`c_theme`,`c_lang`,`c_timezone`),
  KEY `c_is_bot` (`c_is_bot`),
  KEY `c_in_panel` (`c_in_panel`),
  KEY `c_interlock` (`c_interlock`),
  KEY `c_store_as_tempcode` (`c_store_as_tempcode`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp_custom_comcode`;

CREATE TABLE `ocp_custom_comcode` (
  `tag_tag` varchar(80) NOT NULL,
  `tag_title` int(10) unsigned NOT NULL,
  `tag_description` int(10) unsigned NOT NULL,
  `tag_replace` longtext NOT NULL,
  `tag_example` longtext NOT NULL,
  `tag_parameters` varchar(255) NOT NULL,
  `tag_enabled` tinyint(1) NOT NULL,
  `tag_dangerous_tag` tinyint(1) NOT NULL,
  `tag_block_tag` tinyint(1) NOT NULL,
  `tag_textual_tag` tinyint(1) NOT NULL,
  PRIMARY KEY (`tag_tag`)
) ENGINE=MyISAM;

insert into `ocp_custom_comcode` values('facebook_video','96','97','{$SET,VIDEO,{$PREG_REPLACE,(http://.*\\?v=)?(\\w+)(.*)?,$\\{2\\},{content}}}<object width=\"640\" height=\"385\"><param name=\"movie\" value=\"http://www.facebook.com/v/{$GET*,VIDEO};hl=en_US\"></param><param name=\"allowFullScreen\" value=\"true\"></param><param name=\"allowscriptaccess\" value=\"always\"></param><embed src=\"http://www.facebook.com/v/{$GET*,VIDEO};hl=en_US\" type=\"application/x-shockwave-flash\" allowscriptaccess=\"always\" allowfullscreen=\"true\" width=\"640\" height=\"385\"></embed></object>','[facebook_video]http://www.facebook.com/video/video.php?v=10150307159560581[/facebook_video]','','1','0','1','0'),
 ('youtube','98','99','{$SET,VIDEO,{$PREG_REPLACE,(http://.*\\?v=)?(http://youtu.be/)?([\\w\\-]+)(.*)?,$\\{3\\},{$STRIP_TAGS,{content}}}}<object width=\"480\" height=\"385\"><param name=\"movie\" value=\"http://www.youtube.com/v/{$GET*,VIDEO}?fs=1&amp;hl=en_US\"></param><param name=\"allowFullScreen\" value=\"true\"></param><param name=\"allowscriptaccess\" value=\"always\"></param><embed src=\"http://www.youtube.com/v/{$GET*,VIDEO}?fs=1&amp;hl=en_US\" type=\"application/x-shockwave-flash\" allowscriptaccess=\"always\" allowfullscreen=\"true\" width=\"480\" height=\"385\"></embed></object>','[youtube]http://www.youtube.com/watch?v=ZDFFHaz9GsY[/youtube]','','1','0','1','0');

DROP TABLE IF EXISTS `ocp_customtasks`;

CREATE TABLE `ocp_customtasks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tasktitle` varchar(255) NOT NULL,
  `datetimeadded` int(10) unsigned NOT NULL,
  `recurinterval` int(11) NOT NULL,
  `recurevery` varchar(80) NOT NULL,
  `taskisdone` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=12;

insert into `ocp_customtasks` values('1','Set up website configuration and structure','1332090723','0','',null),
 ('2','Make \'favicon\' theme image','1332090723','0','',null),
 ('3','Make \'appleicon\' (webclip) theme image','1332090723','0','',null),
 ('4','Make/install custom theme','1332090723','0','',null),
 ('5','Add your content','1332090723','0','',null),
 ('6','[page=\"adminzone:admin_themes:edit_image:logo/trimmed-logo:theme=default\"]Customise your mail/RSS logo[/page]','1332090723','0','',null),
 ('7','[page=\"adminzone:admin_themes:_edit_templates:theme=default:f0file=MAIL.tpl\"]Customise your \'MAIL\' template[/page]','1332090723','0','',null),
 ('8','[url=\"P3P Wizard (set up privacy policy)\"]http://www.p3pwiz.com/[/url]','1332090723','0','',null),
 ('9','[url=\"Submit to Google\"]http://www.google.com/addurl/[/url]','1332090723','0','',null),
 ('10','[url=\"Submit to OpenDMOZ\"]http://www.dmoz.org/add.html[/url]','1332090723','0','',null),
 ('11','[url=\"Submit to Bing\"]http://www.bing.com/webmaster/SubmitSitePage.aspx[/url]','1332090723','0','',null);

