DROP TABLE IF EXISTS `ocp_hackattack`;

CREATE TABLE `ocp_hackattack` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `url` varchar(255) NOT NULL,
  `data_post` longtext NOT NULL,
  `user_agent` varchar(255) NOT NULL,
  `referer` varchar(255) NOT NULL,
  `user_os` varchar(255) NOT NULL,
  `the_user` int(11) NOT NULL,
  `date_and_time` int(10) unsigned NOT NULL,
  `ip` varchar(40) NOT NULL,
  `reason` varchar(80) NOT NULL,
  `reason_param_a` varchar(255) NOT NULL,
  `reason_param_b` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `otherhacksby` (`ip`),
  KEY `h_date_and_time` (`date_and_time`)
) ENGINE=MyISAM CHARACTER SET=latin1;


DROP TABLE IF EXISTS `ocp_https_pages`;

CREATE TABLE `ocp_https_pages` (
  `https_page_name` varchar(80) NOT NULL,
  PRIMARY KEY (`https_page_name`)
) ENGINE=MyISAM CHARACTER SET=latin1;


DROP TABLE IF EXISTS `ocp_images`;

CREATE TABLE `ocp_images` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cat` varchar(80) NOT NULL,
  `url` varchar(255) NOT NULL,
  `thumb_url` varchar(255) NOT NULL,
  `comments` int(10) unsigned NOT NULL,
  `allow_rating` tinyint(1) NOT NULL,
  `allow_comments` tinyint(4) NOT NULL,
  `allow_trackbacks` tinyint(1) NOT NULL,
  `notes` longtext NOT NULL,
  `submitter` int(11) NOT NULL,
  `validated` tinyint(1) NOT NULL,
  `add_date` int(10) unsigned NOT NULL,
  `edit_date` int(10) unsigned DEFAULT NULL,
  `image_views` int(11) NOT NULL,
  `title` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `image_views` (`image_views`),
  KEY `category_list` (`cat`),
  KEY `i_validated` (`validated`),
  KEY `xis` (`submitter`),
  KEY `iadd_date` (`add_date`),
  KEY `ftjoin_icomments` (`comments`)
) ENGINE=MyISAM CHARACTER SET=latin1;


DROP TABLE IF EXISTS `ocp_import_id_remap`;

CREATE TABLE `ocp_import_id_remap` (
  `id_old` varchar(80) NOT NULL,
  `id_new` int(11) NOT NULL,
  `id_type` varchar(80) NOT NULL,
  `id_session` int(11) NOT NULL,
  PRIMARY KEY (`id_old`,`id_type`,`id_session`)
) ENGINE=MyISAM CHARACTER SET=latin1;


DROP TABLE IF EXISTS `ocp_import_parts_done`;

CREATE TABLE `ocp_import_parts_done` (
  `imp_id` varchar(255) NOT NULL,
  `imp_session` int(11) NOT NULL,
  PRIMARY KEY (`imp_id`,`imp_session`)
) ENGINE=MyISAM CHARACTER SET=latin1;


DROP TABLE IF EXISTS `ocp_import_session`;

CREATE TABLE `ocp_import_session` (
  `imp_old_base_dir` varchar(255) NOT NULL,
  `imp_db_name` varchar(80) NOT NULL,
  `imp_db_user` varchar(80) NOT NULL,
  `imp_hook` varchar(80) NOT NULL,
  `imp_db_table_prefix` varchar(80) NOT NULL,
  `imp_refresh_time` int(11) NOT NULL,
  `imp_session` int(11) NOT NULL,
  PRIMARY KEY (`imp_session`)
) ENGINE=MyISAM CHARACTER SET=latin1;


DROP TABLE IF EXISTS `ocp_incoming_uploads`;

CREATE TABLE `ocp_incoming_uploads` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `i_submitter` int(11) NOT NULL,
  `i_date_and_time` int(10) unsigned NOT NULL,
  `i_orig_filename` varchar(255) NOT NULL,
  `i_save_url` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM CHARACTER SET=latin1;


DROP TABLE IF EXISTS `ocp_invoices`;

CREATE TABLE `ocp_invoices` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `i_type_code` varchar(80) NOT NULL,
  `i_member_id` int(11) NOT NULL,
  `i_state` varchar(80) NOT NULL,
  `i_amount` varchar(255) NOT NULL,
  `i_special` varchar(255) NOT NULL,
  `i_time` int(10) unsigned NOT NULL,
  `i_note` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM CHARACTER SET=latin1;


DROP TABLE IF EXISTS `ocp_iotd`;

CREATE TABLE `ocp_iotd` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `url` varchar(255) NOT NULL,
  `i_title` int(10) unsigned NOT NULL,
  `caption` int(10) unsigned NOT NULL,
  `thumb_url` varchar(255) NOT NULL,
  `is_current` tinyint(1) NOT NULL,
  `allow_rating` tinyint(1) NOT NULL,
  `allow_comments` tinyint(4) NOT NULL,
  `allow_trackbacks` tinyint(1) NOT NULL,
  `notes` longtext NOT NULL,
  `used` tinyint(1) NOT NULL,
  `date_and_time` int(10) unsigned DEFAULT NULL,
  `iotd_views` int(11) NOT NULL,
  `submitter` int(11) NOT NULL,
  `add_date` int(10) unsigned NOT NULL,
  `edit_date` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `iotd_views` (`iotd_views`),
  KEY `get_current` (`is_current`),
  KEY `ios` (`submitter`),
  KEY `iadd_date` (`add_date`),
  KEY `date_and_time` (`date_and_time`),
  KEY `ftjoin_icap` (`caption`)
) ENGINE=MyISAM CHARACTER SET=latin1;


DROP TABLE IF EXISTS `ocp_ip_country`;

CREATE TABLE `ocp_ip_country` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `begin_num` int(10) unsigned NOT NULL,
  `end_num` int(10) unsigned NOT NULL,
  `country` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM CHARACTER SET=latin1;


DROP TABLE IF EXISTS `ocp_leader_board`;

CREATE TABLE `ocp_leader_board` (
  `lb_member` int(11) NOT NULL,
  `lb_points` int(11) NOT NULL,
  `date_and_time` int(10) unsigned NOT NULL,
  PRIMARY KEY (`lb_member`,`date_and_time`)
) ENGINE=MyISAM CHARACTER SET=latin1;


DROP TABLE IF EXISTS `ocp_link_tracker`;

CREATE TABLE `ocp_link_tracker` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `c_date_and_time` int(10) unsigned NOT NULL,
  `c_member_id` int(11) NOT NULL,
  `c_ip_address` varchar(40) NOT NULL,
  `c_url` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM CHARACTER SET=latin1;


DROP TABLE IF EXISTS `ocp_logged_mail_messages`;

CREATE TABLE `ocp_logged_mail_messages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `m_subject` longtext NOT NULL,
  `m_message` longtext NOT NULL,
  `m_to_email` longtext NOT NULL,
  `m_to_name` longtext NOT NULL,
  `m_from_email` varchar(255) NOT NULL,
  `m_from_name` varchar(255) NOT NULL,
  `m_priority` tinyint(4) NOT NULL,
  `m_attachments` longtext NOT NULL,
  `m_no_cc` tinyint(1) NOT NULL,
  `m_as` int(11) NOT NULL,
  `m_as_admin` tinyint(1) NOT NULL,
  `m_in_html` tinyint(1) NOT NULL,
  `m_date_and_time` int(10) unsigned NOT NULL,
  `m_member_id` int(11) NOT NULL,
  `m_url` longtext NOT NULL,
  `m_queued` tinyint(1) NOT NULL,
  `m_template` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `recentmessages` (`m_date_and_time`),
  KEY `queued` (`m_queued`)
) ENGINE=MyISAM CHARACTER SET=latin1;


DROP TABLE IF EXISTS `ocp_long_values`;

CREATE TABLE `ocp_long_values` (
  `the_name` varchar(80) NOT NULL,
  `the_value` longtext NOT NULL,
  `date_and_time` int(10) unsigned NOT NULL,
  PRIMARY KEY (`the_name`)
) ENGINE=MyISAM CHARACTER SET=latin1;


DROP TABLE IF EXISTS `ocp_match_key_messages`;

CREATE TABLE `ocp_match_key_messages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `k_message` int(10) unsigned NOT NULL,
  `k_match_key` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM CHARACTER SET=latin1;


DROP TABLE IF EXISTS `ocp_member_category_access`;

CREATE TABLE `ocp_member_category_access` (
  `active_until` int(10) unsigned NOT NULL,
  `module_the_name` varchar(80) NOT NULL,
  `category_name` varchar(80) NOT NULL,
  `member_id` int(11) NOT NULL,
  PRIMARY KEY (`active_until`,`module_the_name`,`category_name`,`member_id`),
  KEY `mcaname` (`module_the_name`,`category_name`),
  KEY `mcamember_id` (`member_id`)
) ENGINE=MyISAM CHARACTER SET=latin1;


DROP TABLE IF EXISTS `ocp_member_page_access`;

CREATE TABLE `ocp_member_page_access` (
  `active_until` int(10) unsigned NOT NULL,
  `page_name` varchar(80) NOT NULL,
  `zone_name` varchar(80) NOT NULL,
  `member_id` int(11) NOT NULL,
  PRIMARY KEY (`active_until`,`page_name`,`zone_name`,`member_id`),
  KEY `mzaname` (`page_name`,`zone_name`),
  KEY `mzamember_id` (`member_id`)
) ENGINE=MyISAM CHARACTER SET=latin1;


DROP TABLE IF EXISTS `ocp_member_tracking`;

CREATE TABLE `ocp_member_tracking` (
  `mt_member_id` int(11) NOT NULL,
  `mt_cache_username` varchar(80) NOT NULL,
  `mt_time` int(10) unsigned NOT NULL,
  `mt_page` varchar(80) NOT NULL,
  `mt_type` varchar(80) NOT NULL,
  `mt_id` varchar(80) NOT NULL,
  PRIMARY KEY (`mt_member_id`,`mt_time`,`mt_page`,`mt_type`,`mt_id`),
  KEY `mt_page` (`mt_page`),
  KEY `mt_id` (`mt_page`,`mt_id`,`mt_type`)
) ENGINE=MyISAM CHARACTER SET=latin1;


DROP TABLE IF EXISTS `ocp_member_zone_access`;

CREATE TABLE `ocp_member_zone_access` (
  `active_until` int(10) unsigned NOT NULL,
  `zone_name` varchar(80) NOT NULL,
  `member_id` int(11) NOT NULL,
  PRIMARY KEY (`active_until`,`zone_name`,`member_id`),
  KEY `mzazone_name` (`zone_name`),
  KEY `mzamember_id` (`member_id`)
) ENGINE=MyISAM CHARACTER SET=latin1;


DROP TABLE IF EXISTS `ocp_menu_items`;

CREATE TABLE `ocp_menu_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `i_menu` varchar(80) NOT NULL,
  `i_order` int(11) NOT NULL,
  `i_parent` int(11) DEFAULT NULL,
  `i_caption` int(10) unsigned NOT NULL,
  `i_caption_long` int(10) unsigned NOT NULL,
  `i_url` varchar(255) NOT NULL,
  `i_check_permissions` tinyint(1) NOT NULL,
  `i_expanded` tinyint(1) NOT NULL,
  `i_new_window` tinyint(1) NOT NULL,
  `i_page_only` varchar(80) NOT NULL,
  `i_theme_img_code` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `menu_extraction` (`i_menu`)
) ENGINE=MyISAM CHARACTER SET=latin1 AUTO_INCREMENT=56;

insert into `ocp_menu_items` values('1','root_website','0',null,'100','101',':','0','0','0','',''),
 ('2','root_website','1',null,'102','103','_SEARCH:rules','0','0','0','',''),
 ('3','main_features','2',null,'104','105','site:','0','0','0','',''),
 ('4','main_features','3',null,'106','107','_SEARCH:help','0','0','0','',''),
 ('5','main_features','4',null,'108','109','_SEARCH:rules','0','0','0','',''),
 ('6','main_community','5',null,'110','111','_SEARCH:members:type=misc','0','0','0','',''),
 ('7','main_community','6',null,'112','113','_SEARCH:groups:type=misc','0','0','0','',''),
 ('8','member_features','7',null,'114','115','_SEARCH:join:type=misc','1','0','0','',''),
 ('9','member_features','8',null,'116','117','_SEARCH:lostpassword:type=misc','0','0','0','',''),
 ('10','collab_website','9',null,'118','119','collaboration:','0','0','0','',''),
 ('11','collab_website','10',null,'120','121','collaboration:about','0','0','0','',''),
 ('12','forum_features','11',null,'122','123','_SEARCH:rules','0','0','0','',''),
 ('13','forum_features','12',null,'124','125','_SEARCH:members:type=misc','0','0','0','',''),
 ('14','zone_menu','13',null,'126','127','site:','1','0','0','',''),
 ('15','zone_menu','14',null,'128','129','forum:','1','0','0','',''),
 ('16','zone_menu','15',null,'130','131','collaboration:','1','0','0','',''),
 ('17','zone_menu','16',null,'132','133','cms:','1','0','0','',''),
 ('18','zone_menu','17',null,'134','135','adminzone:','1','0','0','',''),
 ('19','collab_features','0',null,'138','139','_SELF:authors:type=misc','0','0','0','',''),
 ('20','collab_features','1',null,'140','141','_SEARCH:cms_authors:type=_ad','0','0','1','',''),
 ('21','main_content','2',null,'164','165','_SEARCH:catalogues:type=index:id=projects','0','0','0','',''),
 ('22','main_content','3',null,'180','181','_SEARCH:catalogues:type=index:id=modifications','0','0','0','',''),
 ('23','main_content','4',null,'192','193','_SEARCH:catalogues:type=index:id=hosted','0','0','0','',''),
 ('24','main_content','5',null,'204','205','_SEARCH:catalogues:type=index:id=links','0','0','0','',''),
 ('25','main_content','6',null,'216','217','_SEARCH:catalogues:type=index:id=faqs','0','0','0','',''),
 ('26','main_content','7',null,'248','249','_SEARCH:catalogues:type=index:id=contacts','0','0','0','',''),
 ('27','collab_features','8',null,'250','251','','0','0','0','',''),
 ('28','collab_features','9','27','252','253','_SEARCH:catalogues:id=projects:type=index','0','0','1','',''),
 ('29','collab_features','10','27','254','255','_SEARCH:cms_catalogues:catalogue_name=projects:type=add_entry','0','0','1','',''),
 ('45','ecommerce_features','26',null,'349','350','_SEARCH:shopping:type=my_orders','0','0','0','',''),
 ('31','main_content','12',null,'286','287','_SEARCH:cedi:type=misc','0','0','0','',''),
 ('32','cedi_features','13',null,'288','289','_SEARCH:cedi:type=misc','0','0','0','',''),
 ('33','cedi_features','14',null,'290','291','_SEARCH:cedi:type=random','0','0','0','',''),
 ('34','cedi_features','15',null,'292','293','_SEARCH:cedi:type=changes','0','0','0','',''),
 ('35','cedi_features','16',null,'294','295','_SEARCH:cedi:type=tree','0','0','0','',''),
 ('36','main_community','17',null,'299','300','_SEARCH:chat:type=misc','0','0','0','',''),
 ('37','main_content','18',null,'303','304','_SEARCH:downloads:type=misc','0','0','0','',''),
 ('38','main_content','19',null,'305','306','_SEARCH:galleries:type=misc','0','0','0','',''),
 ('39','main_community','20',null,'321','322','_SEARCH:pointstore:type=misc','0','0','0','',''),
 ('40','ecommerce_features','21',null,'339','340','_SEARCH:purchase:type=misc','0','0','0','',''),
 ('41','ecommerce_features','22',null,'341','342','_SEARCH:invoices:type=misc','0','0','0','',''),
 ('42','ecommerce_features','23',null,'343','344','_SEARCH:subscriptions:type=misc','0','0','0','',''),
 ('43','main_website','24',null,'345','346','_SEARCH:quiz:type=misc','0','0','0','',''),
 ('44','forum_features','25',null,'347','348','_SEARCH:search:type=misc:id=ocf_posts','0','0','0','',''),
 ('46','main_website','27',null,'365','366','_SEARCH:staff:type=misc','0','0','0','',''),
 ('47','main_website','28',null,'369','370','_SEARCH:tickets:type=misc','0','0','0','',''),
 ('48','forum_features','0',null,'371','372','_SEARCH:forumview:type=misc','0','0','0','',''),
 ('49','forum_features','1',null,'373','374','_SEARCH:forumview:type=pt','0','0','0','',''),
 ('50','forum_features','2',null,'375','376','_SEARCH:vforums:type=misc','0','0','0','',''),
 ('51','forum_features','3',null,'377','378','_SEARCH:vforums:type=unread','0','0','0','',''),
 ('52','forum_features','4',null,'379','380','_SEARCH:vforums:type=recently_read','0','0','0','',''),
 ('53','collab_features','5',null,'381','382','_SEARCH:filedump:type=misc','0','0','0','',''),
 ('54','root_website','100',null,'383','384','_SEARCH:recommend:from={$REPLACE,:,%3A,{$SELF_URL&,0,0,0,from=<null>}}','0','0','0','',''),
 ('55','collab_website','101',null,'385','386','_SEARCH:supermembers','0','0','0','','');

DROP TABLE IF EXISTS `ocp_messages_to_render`;

CREATE TABLE `ocp_messages_to_render` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `r_session_id` int(11) NOT NULL,
  `r_message` longtext NOT NULL,
  `r_type` varchar(80) NOT NULL,
  `r_time` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `forsession` (`r_session_id`)
) ENGINE=MyISAM CHARACTER SET=latin1;


DROP TABLE IF EXISTS `ocp_modules`;

CREATE TABLE `ocp_modules` (
  `module_the_name` varchar(80) NOT NULL,
  `module_author` varchar(80) NOT NULL,
  `module_organisation` varchar(80) NOT NULL,
  `module_hacked_by` varchar(80) NOT NULL,
  `module_hack_version` int(11) DEFAULT NULL,
  `module_version` int(11) NOT NULL,
  PRIMARY KEY (`module_the_name`)
) ENGINE=MyISAM CHARACTER SET=latin1;

insert into `ocp_modules` values('admin_permissions','Chris Graham','ocProducts','',null,'7'),
 ('admin_version','Chris Graham','ocProducts','',null,'14'),
 ('admin','Chris Graham','ocProducts','',null,'2'),
 ('admin_actionlog','Chris Graham','ocProducts','',null,'2'),
 ('admin_addons','Chris Graham','ocProducts','',null,'3'),
 ('admin_awards','Chris Graham','ocProducts','',null,'3'),
 ('admin_backup','Chris Graham','ocProducts','',null,'3'),
 ('admin_banners','Chris Graham','ocProducts','',null,'2'),
 ('admin_bulkupload','Chris Graham','ocProducts','',null,'2'),
 ('admin_chat','Chris Graham','ocProducts','',null,'2'),
 ('admin_cleanup','Chris Graham','ocProducts','',null,'3'),
 ('admin_config','Chris Graham','ocProducts','',null,'12'),
 ('admin_custom_comcode','Chris Graham','ocProducts','',null,'2'),
 ('admin_debrand','Chris Graham','ocProducts','',null,'2'),
 ('admin_ecommerce','Chris Graham','ocProducts','',null,'2'),
 ('admin_emaillog','Chris Graham','ocProducts','',null,'2'),
 ('admin_errorlog','Chris Graham','ocProducts','',null,'2'),
 ('admin_flagrant','Chris Graham','ocProducts','',null,'3'),
 ('admin_import','Chris Graham','ocProducts','',null,'5'),
 ('admin_invoices','Chris Graham','ocProducts','',null,'2'),
 ('admin_ipban','Chris Graham','ocProducts','',null,'4'),
 ('admin_lang','Chris Graham','ocProducts','',null,'2'),
 ('admin_lookup','Chris Graham','ocProducts','',null,'2'),
 ('admin_menus','Chris Graham','ocProducts','',null,'2'),
 ('admin_messaging','Chris Graham','ocProducts','',null,'2'),
 ('admin_newsletter','Chris Graham','ocProducts','',null,'2'),
 ('admin_notifications','Chris Graham','ocProducts','',null,'1'),
 ('admin_occle','Philip Withnall','ocProducts','',null,'2'),
 ('admin_ocf_categories','Chris Graham','ocProducts','',null,'2'),
 ('admin_ocf_customprofilefields','Chris Graham','ocProducts','',null,'2'),
 ('admin_ocf_emoticons','Chris Graham','ocProducts','',null,'2'),
 ('admin_ocf_forums','Chris Graham','ocProducts','',null,'2'),
 ('admin_ocf_groups','Chris Graham','ocProducts','',null,'2'),
 ('admin_ocf_history','Chris Graham','ocProducts','',null,'2'),
 ('admin_ocf_join','Chris Graham','ocProducts','',null,'2'),
 ('admin_ocf_ldap','Chris Graham','ocProducts','',null,'4'),
 ('admin_ocf_merge_members','Chris Graham','ocProducts','',null,'2'),
 ('admin_ocf_multimoderations','Chris Graham','ocProducts','',null,'2'),
 ('admin_ocf_post_templates','Chris Graham','ocProducts','',null,'2'),
 ('admin_ocf_welcome_emails','Chris Graham','ocProducts','',null,'3'),
 ('admin_orders','Manuprathap','ocProducts','',null,'2'),
 ('admin_phpinfo','Chris Graham','ocProducts','',null,'2'),
 ('admin_points','Chris Graham','ocProducts','',null,'2'),
 ('admin_pointstore','Chris Graham','ocProducts','',null,'2'),
 ('admin_quiz','Chris Graham','ocProducts','',null,'2'),
 ('admin_realtime_rain','Chris Graham','ocProducts','',null,'1'),
 ('admin_redirects','Chris Graham','ocProducts','',null,'3'),
 ('admin_security','Chris Graham','ocProducts','',null,'3'),
 ('admin_setupwizard','Chris Graham','ocProducts','',null,'2'),
 ('admin_sitetree','Chris Graham','ocProducts','',null,'4'),
 ('admin_ssl','Chris Graham','ocProducts','',null,'2'),
 ('admin_staff','Chris Graham','ocProducts','',null,'3'),
 ('admin_stats','Philip Withnall','ocProducts','',null,'7'),
 ('admin_themes','Chris Graham','ocProducts','',null,'4'),
 ('admin_themewizard','Allen Ellis','ocProducts','',null,'2'),
 ('admin_tickets','Chris Graham','ocProducts','',null,'2'),
 ('admin_trackbacks','Chris Graham','ocProducts','',null,'2'),
 ('admin_unvalidated','Chris Graham','ocProducts','',null,'2'),
 ('admin_wordfilter','Chris Graham','ocProducts','',null,'3'),
 ('admin_xml_storage','Chris Graham','ocProducts','',null,'2'),
 ('admin_zones','Chris Graham','ocProducts','',null,'2'),
 ('authors','Chris Graham','ocProducts','',null,'3'),
 ('awards','Chris Graham','ocProducts','',null,'2'),
 ('banners','Chris Graham','ocProducts','',null,'5'),
 ('bookmarks','Chris Graham','ocProducts','',null,'2'),
 ('calendar','Chris Graham','ocProducts','',null,'6'),
 ('catalogues','Chris Graham','ocProducts','',null,'6'),
 ('cedi','Chris Graham','ocProducts','',null,'8'),
 ('chat','Philip Withnall','ocProducts','',null,'11'),
 ('contactmember','Chris Graham','ocProducts','',null,'2'),
 ('downloads','Chris Graham','ocProducts','',null,'6'),
 ('galleries','Chris Graham','ocProducts','',null,'7'),
 ('groups','Chris Graham','ocProducts','',null,'2'),
 ('invoices','Chris Graham','ocProducts','',null,'2'),
 ('iotds','Chris Graham','ocProducts','',null,'4'),
 ('leader_board','Chris Graham','ocProducts','',null,'2'),
 ('members','Chris Graham','ocProducts','',null,'2'),
 ('news','Chris Graham','ocProducts','',null,'5'),
 ('newsletter','Chris Graham','ocProducts','',null,'9'),
 ('notifications','Chris Graham','ocProducts','',null,'1'),
 ('onlinemembers','Chris Graham','ocProducts','',null,'2'),
 ('points','Chris Graham','ocProducts','',null,'6'),
 ('pointstore','Allen Ellis','ocProducts','',null,'4'),
 ('polls','Chris Graham','ocProducts','',null,'5'),
 ('purchase','Chris Graham','ocProducts','',null,'4'),
 ('quiz','Chris Graham','ocProducts','',null,'5'),
 ('search','Chris Graham','ocProducts','',null,'4'),
 ('shopping','Manuprathap','ocProducts','',null,'6'),
 ('staff','Chris Graham','ocProducts','',null,'2'),
 ('subscriptions','Chris Graham','ocProducts','',null,'4'),
 ('tester','Chris Graham','ocProducts','',null,'2'),
 ('tickets','Chris Graham','ocProducts','',null,'5'),
 ('warnings','Chris Graham','ocProducts','',null,'2'),
 ('forumview','Chris Graham','ocProducts','',null,'2'),
 ('topics','Chris Graham','ocProducts','',null,'2'),
 ('topicview','Chris Graham','ocProducts','',null,'2'),
 ('vforums','Chris Graham','ocProducts','',null,'2'),
 ('cms','Chris Graham','ocProducts','',null,'2'),
 ('cms_authors','Chris Graham','ocProducts','',null,'3'),
 ('cms_banners','Chris Graham','ocProducts','',null,'2'),
 ('cms_blogs','Chris Graham','ocProducts','',null,'2'),
 ('cms_calendar','Chris Graham','ocProducts','',null,'2'),
 ('cms_catalogues','Chris Graham','ocProducts','',null,'2'),
 ('cms_cedi','Chris Graham','ocProducts','',null,'4'),
 ('cms_chat','Philip Withnall','ocProducts','',null,'3'),
 ('cms_comcode_pages','Chris Graham','ocProducts','',null,'4'),
 ('cms_downloads','Chris Graham','ocProducts','',null,'2'),
 ('cms_galleries','Chris Graham','ocProducts','',null,'2'),
 ('cms_iotds','Chris Graham','ocProducts','',null,'2'),
 ('cms_news','Chris Graham','ocProducts','',null,'2'),
 ('cms_ocf_groups','Chris Graham','ocProducts','',null,'2'),
 ('cms_polls','Chris Graham','ocProducts','',null,'2'),
 ('cms_quiz','Chris Graham','ocProducts','',null,'2'),
 ('filedump','Chris Graham','ocProducts','',null,'3'),
 ('forums','Chris Graham','ocProducts','',null,'2'),
 ('join','Chris Graham','ocProducts','',null,'2'),
 ('login','Chris Graham','ocProducts','',null,'2'),
 ('lostpassword','Chris Graham','ocProducts','',null,'2'),
 ('recommend','Chris Graham','ocProducts','',null,'2'),
 ('supermembers','Chris Graham','ocProducts','',null,'2');

DROP TABLE IF EXISTS `ocp_msp`;

CREATE TABLE `ocp_msp` (
  `active_until` int(10) unsigned NOT NULL,
  `member_id` int(11) NOT NULL,
  `specific_permission` varchar(80) NOT NULL,
  `the_page` varchar(80) NOT NULL,
  `module_the_name` varchar(80) NOT NULL,
  `category_name` varchar(80) NOT NULL,
  `the_value` tinyint(1) NOT NULL,
  PRIMARY KEY (`active_until`,`member_id`,`specific_permission`,`the_page`,`module_the_name`,`category_name`),
  KEY `mspname` (`specific_permission`,`the_page`,`module_the_name`,`category_name`),
  KEY `mspmember_id` (`member_id`)
) ENGINE=MyISAM CHARACTER SET=latin1;


DROP TABLE IF EXISTS `ocp_news`;

CREATE TABLE `ocp_news` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_and_time` int(10) unsigned NOT NULL,
  `title` int(10) unsigned NOT NULL,
  `news` int(10) unsigned NOT NULL,
  `news_article` int(10) unsigned NOT NULL,
  `allow_rating` tinyint(1) NOT NULL,
  `allow_comments` tinyint(4) NOT NULL,
  `allow_trackbacks` tinyint(1) NOT NULL,
  `notes` longtext NOT NULL,
  `author` varchar(80) NOT NULL,
  `submitter` int(11) NOT NULL,
  `validated` tinyint(1) NOT NULL,
  `edit_date` int(10) unsigned DEFAULT NULL,
  `news_category` int(11) NOT NULL,
  `news_views` int(11) NOT NULL,
  `news_image` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `news_views` (`news_views`),
  KEY `findnewscat` (`news_category`),
  KEY `newsauthor` (`author`),
  KEY `nes` (`submitter`),
  KEY `headlines` (`date_and_time`,`id`),
  KEY `nvalidated` (`validated`),
  KEY `ftjoin_ititle` (`title`),
  KEY `ftjoin_nnews` (`news`),
  KEY `ftjoin_nnewsa` (`news_article`)
) ENGINE=MyISAM CHARACTER SET=latin1;


DROP TABLE IF EXISTS `ocp_news_categories`;

CREATE TABLE `ocp_news_categories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nc_title` int(10) unsigned NOT NULL,
  `nc_owner` int(11) DEFAULT NULL,
  `nc_img` varchar(80) NOT NULL,
  `notes` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ncs` (`nc_owner`)
) ENGINE=MyISAM CHARACTER SET=latin1 AUTO_INCREMENT=8;

insert into `ocp_news_categories` values('1','312',null,'newscats/general',''),
 ('2','313',null,'newscats/technology',''),
 ('3','314',null,'newscats/difficulties',''),
 ('4','315',null,'newscats/community',''),
 ('5','316',null,'newscats/entertainment',''),
 ('6','317',null,'newscats/business',''),
 ('7','318',null,'newscats/art','');

DROP TABLE IF EXISTS `ocp_news_category_entries`;

CREATE TABLE `ocp_news_category_entries` (
  `news_entry` int(11) NOT NULL,
  `news_entry_category` int(11) NOT NULL,
  PRIMARY KEY (`news_entry`,`news_entry_category`),
  KEY `news_entry_category` (`news_entry_category`)
) ENGINE=MyISAM CHARACTER SET=latin1;


DROP TABLE IF EXISTS `ocp_news_rss_cloud`;

CREATE TABLE `ocp_news_rss_cloud` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `rem_procedure` varchar(80) NOT NULL,
  `rem_port` tinyint(4) NOT NULL,
  `rem_path` varchar(255) NOT NULL,
  `rem_protocol` varchar(80) NOT NULL,
  `rem_ip` varchar(40) NOT NULL,
  `watching_channel` varchar(255) NOT NULL,
  `register_time` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM CHARACTER SET=latin1;


DROP TABLE IF EXISTS `ocp_newsletter`;

CREATE TABLE `ocp_newsletter` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `join_time` int(10) unsigned NOT NULL,
  `code_confirm` int(11) NOT NULL,
  `the_password` varchar(33) NOT NULL,
  `pass_salt` varchar(80) NOT NULL,
  `language` varchar(80) NOT NULL,
  `n_forename` varchar(255) NOT NULL,
  `n_surname` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `welcomemails` (`join_time`),
  KEY `code_confirm` (`code_confirm`)
) ENGINE=MyISAM CHARACTER SET=latin1;


DROP TABLE IF EXISTS `ocp_newsletter_archive`;

CREATE TABLE `ocp_newsletter_archive` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_and_time` int(11) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `newsletter` longtext NOT NULL,
  `language` varchar(80) NOT NULL,
  `importance_level` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM CHARACTER SET=latin1;


DROP TABLE IF EXISTS `ocp_newsletter_drip_send`;

CREATE TABLE `ocp_newsletter_drip_send` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `d_inject_time` int(10) unsigned NOT NULL,
  `d_subject` varchar(255) NOT NULL,
  `d_message` longtext NOT NULL,
  `d_html_only` tinyint(1) NOT NULL,
  `d_to_email` varchar(255) NOT NULL,
  `d_to_name` varchar(255) NOT NULL,
  `d_from_email` varchar(255) NOT NULL,
  `d_from_name` varchar(255) NOT NULL,
  `d_priority` tinyint(4) NOT NULL,
  `d_template` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `d_inject_time` (`d_inject_time`)
) ENGINE=MyISAM CHARACTER SET=latin1;


DROP TABLE IF EXISTS `ocp_newsletter_periodic`;

CREATE TABLE `ocp_newsletter_periodic` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `np_message` longtext NOT NULL,
  `np_subject` longtext NOT NULL,
  `np_lang` varchar(5) NOT NULL,
  `np_send_details` longtext NOT NULL,
  `np_html_only` tinyint(1) NOT NULL,
  `np_from_email` varchar(255) NOT NULL,
  `np_from_name` varchar(255) NOT NULL,
  `np_priority` tinyint(4) NOT NULL,
  `np_csv_data` longtext NOT NULL,
  `np_frequency` varchar(255) NOT NULL,
  `np_day` tinyint(4) NOT NULL,
  `np_in_full` tinyint(1) NOT NULL,
  `np_template` varchar(80) NOT NULL,
  `np_last_sent` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM CHARACTER SET=latin1;


DROP TABLE IF EXISTS `ocp_newsletter_subscribe`;

CREATE TABLE `ocp_newsletter_subscribe` (
  `newsletter_id` int(11) NOT NULL,
  `the_level` tinyint(4) NOT NULL,
  `email` varchar(255) NOT NULL,
  PRIMARY KEY (`newsletter_id`,`email`),
  KEY `peopletosendto` (`the_level`)
) ENGINE=MyISAM CHARACTER SET=latin1;


DROP TABLE IF EXISTS `ocp_newsletters`;

CREATE TABLE `ocp_newsletters` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` int(10) unsigned NOT NULL,
  `description` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM CHARACTER SET=latin1 AUTO_INCREMENT=2;

insert into `ocp_newsletters` values('1','319','320');

DROP TABLE IF EXISTS `ocp_notification_lockdown`;

CREATE TABLE `ocp_notification_lockdown` (
  `l_notification_code` varchar(80) NOT NULL,
  `l_setting` int(11) NOT NULL,
  PRIMARY KEY (`l_notification_code`)
) ENGINE=MyISAM CHARACTER SET=latin1;


DROP TABLE IF EXISTS `ocp_notifications_enabled`;

CREATE TABLE `ocp_notifications_enabled` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `l_member_id` int(11) NOT NULL,
  `l_notification_code` varchar(80) NOT NULL,
  `l_code_category` varchar(255) NOT NULL,
  `l_setting` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `l_member_id` (`l_member_id`,`l_notification_code`),
  KEY `l_code_category` (`l_code_category`)
) ENGINE=MyISAM CHARACTER SET=latin1;


DROP TABLE IF EXISTS `ocp_occlechat`;

CREATE TABLE `ocp_occlechat` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `c_message` longtext NOT NULL,
  `c_url` varchar(255) NOT NULL,
  `c_incoming` tinyint(1) NOT NULL,
  `c_timestamp` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM CHARACTER SET=latin1;


DROP TABLE IF EXISTS `ocp_poll`;

CREATE TABLE `ocp_poll` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `question` int(10) unsigned NOT NULL,
  `option1` int(10) unsigned NOT NULL,
  `option2` int(10) unsigned NOT NULL,
  `option3` int(10) unsigned DEFAULT NULL,
  `option4` int(10) unsigned DEFAULT NULL,
  `option5` int(10) unsigned DEFAULT NULL,
  `option6` int(10) unsigned NOT NULL,
  `option7` int(10) unsigned NOT NULL,
  `option8` int(10) unsigned DEFAULT NULL,
  `option9` int(10) unsigned DEFAULT NULL,
  `option10` int(10) unsigned DEFAULT NULL,
  `votes1` int(11) NOT NULL,
  `votes2` int(11) NOT NULL,
  `votes3` int(11) NOT NULL,
  `votes4` int(11) NOT NULL,
  `votes5` int(11) NOT NULL,
  `votes6` int(11) NOT NULL,
  `votes7` int(11) NOT NULL,
  `votes8` int(11) NOT NULL,
  `votes9` int(11) NOT NULL,
  `votes10` int(11) NOT NULL,
  `allow_rating` tinyint(1) NOT NULL,
  `allow_comments` tinyint(4) NOT NULL,
  `allow_trackbacks` tinyint(1) NOT NULL,
  `notes` longtext NOT NULL,
  `num_options` tinyint(4) NOT NULL,
  `is_current` tinyint(1) NOT NULL,
  `date_and_time` int(10) unsigned DEFAULT NULL,
  `submitter` int(11) NOT NULL,
  `add_time` int(11) NOT NULL,
  `poll_views` int(11) NOT NULL,
  `edit_date` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `poll_views` (`poll_views`),
  KEY `get_current` (`is_current`),
  KEY `ps` (`submitter`),
  KEY `padd_time` (`add_time`),
  KEY `date_and_time` (`date_and_time`),
  KEY `ftjoin_pq` (`question`),
  KEY `ftjoin_po1` (`option1`),
  KEY `ftjoin_po2` (`option2`),
  KEY `ftjoin_po3` (`option3`),
  KEY `ftjoin_po4` (`option4`),
  KEY `ftjoin_po5` (`option5`)
) ENGINE=MyISAM CHARACTER SET=latin1;


DROP TABLE IF EXISTS `ocp_poll_votes`;

CREATE TABLE `ocp_poll_votes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `v_poll_id` int(11) NOT NULL,
  `v_voter_id` int(11) DEFAULT NULL,
  `v_voter_ip` varchar(40) NOT NULL,
  `v_vote_for` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `v_voter_id` (`v_voter_id`),
  KEY `v_voter_ip` (`v_voter_ip`),
  KEY `v_vote_for` (`v_vote_for`)
) ENGINE=MyISAM CHARACTER SET=latin1;


DROP TABLE IF EXISTS `ocp_prices`;

CREATE TABLE `ocp_prices` (
  `name` varchar(80) NOT NULL,
  `price` int(11) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=MyISAM CHARACTER SET=latin1;


DROP TABLE IF EXISTS `ocp_pstore_customs`;

CREATE TABLE `ocp_pstore_customs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `c_title` int(10) unsigned NOT NULL,
  `c_description` int(10) unsigned NOT NULL,
  `c_enabled` tinyint(1) NOT NULL,
  `c_cost` int(11) NOT NULL,
  `c_one_per_member` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM CHARACTER SET=latin1;


DROP TABLE IF EXISTS `ocp_pstore_permissions`;

CREATE TABLE `ocp_pstore_permissions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `p_title` int(10) unsigned NOT NULL,
  `p_description` int(10) unsigned NOT NULL,
  `p_enabled` tinyint(1) NOT NULL,
  `p_cost` int(11) NOT NULL,
  `p_hours` int(11) NOT NULL,
  `p_type` varchar(80) NOT NULL,
  `p_specific_permission` varchar(80) NOT NULL,
  `p_zone` varchar(80) NOT NULL,
  `p_page` varchar(80) NOT NULL,
  `p_module` varchar(80) NOT NULL,
  `p_category` varchar(80) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM CHARACTER SET=latin1;


DROP TABLE IF EXISTS `ocp_quiz_entries`;

CREATE TABLE `ocp_quiz_entries` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `q_time` int(10) unsigned NOT NULL,
  `q_member` int(11) NOT NULL,
  `q_quiz` int(11) NOT NULL,
  `q_results` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM CHARACTER SET=latin1;


DROP TABLE IF EXISTS `ocp_quiz_entry_answer`;

CREATE TABLE `ocp_quiz_entry_answer` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `q_entry` int(11) NOT NULL,
  `q_question` int(11) NOT NULL,
  `q_answer` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM CHARACTER SET=latin1;


DROP TABLE IF EXISTS `ocp_quiz_member_last_visit`;

CREATE TABLE `ocp_quiz_member_last_visit` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `v_time` int(10) unsigned NOT NULL,
  `v_member_id` int(11) NOT NULL,
  `v_quiz_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM CHARACTER SET=latin1;


DROP TABLE IF EXISTS `ocp_quiz_question_answers`;

CREATE TABLE `ocp_quiz_question_answers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `q_question` int(11) NOT NULL,
  `q_answer_text` int(10) unsigned NOT NULL,
  `q_is_correct` tinyint(1) NOT NULL,
  `q_order` int(11) NOT NULL,
  `q_explanation` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM CHARACTER SET=latin1;


DROP TABLE IF EXISTS `ocp_quiz_questions`;

CREATE TABLE `ocp_quiz_questions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `q_long_input_field` tinyint(1) NOT NULL,
  `q_num_choosable_answers` int(11) NOT NULL,
  `q_quiz` int(11) NOT NULL,
  `q_question_text` int(10) unsigned NOT NULL,
  `q_order` int(11) NOT NULL,
  `q_required` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM CHARACTER SET=latin1;


DROP TABLE IF EXISTS `ocp_quiz_winner`;

CREATE TABLE `ocp_quiz_winner` (
  `q_quiz` int(11) NOT NULL,
  `q_entry` int(11) NOT NULL,
  `q_winner_level` int(11) NOT NULL,
  PRIMARY KEY (`q_quiz`,`q_entry`)
) ENGINE=MyISAM CHARACTER SET=latin1;


DROP TABLE IF EXISTS `ocp_quizzes`;

CREATE TABLE `ocp_quizzes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `q_timeout` int(11) DEFAULT NULL,
  `q_name` int(10) unsigned NOT NULL,
  `q_start_text` int(10) unsigned NOT NULL,
  `q_end_text` int(10) unsigned NOT NULL,
  `q_notes` longtext NOT NULL,
  `q_percentage` int(11) NOT NULL,
  `q_open_time` int(10) unsigned NOT NULL,
  `q_close_time` int(10) unsigned DEFAULT NULL,
  `q_num_winners` int(11) NOT NULL,
  `q_redo_time` int(11) DEFAULT NULL,
  `q_type` varchar(80) NOT NULL,
  `q_add_date` int(10) unsigned NOT NULL,
  `q_validated` tinyint(1) NOT NULL,
  `q_submitter` int(11) NOT NULL,
  `q_points_for_passing` int(11) NOT NULL,
  `q_tied_newsletter` int(11) DEFAULT NULL,
  `q_end_text_fail` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `q_validated` (`q_validated`),
  KEY `ftjoin_qstarttext` (`q_start_text`)
) ENGINE=MyISAM CHARACTER SET=latin1;


DROP TABLE IF EXISTS `ocp_rating`;

CREATE TABLE `ocp_rating` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `rating_for_type` varchar(80) NOT NULL,
  `rating_for_id` varchar(80) NOT NULL,
  `rating_member` int(11) NOT NULL,
  `rating_ip` varchar(40) NOT NULL,
  `rating_time` int(10) unsigned NOT NULL,
  `rating` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `alt_key` (`rating_for_type`,`rating_for_id`)
) ENGINE=MyISAM CHARACTER SET=latin1;


DROP TABLE IF EXISTS `ocp_redirects`;

CREATE TABLE `ocp_redirects` (
  `r_from_page` varchar(80) NOT NULL,
  `r_from_zone` varchar(80) NOT NULL,
  `r_to_page` varchar(80) NOT NULL,
  `r_to_zone` varchar(80) NOT NULL,
  `r_is_transparent` tinyint(1) NOT NULL,
  PRIMARY KEY (`r_from_page`,`r_from_zone`)
) ENGINE=MyISAM CHARACTER SET=latin1;

insert into `ocp_redirects` values('rules','site','rules','','1'),
 ('rules','forum','rules','','1'),
 ('authors','collaboration','authors','site','1'),
 ('panel_top','collaboration','panel_top','','1'),
 ('panel_top','forum','panel_top','','1');

DROP TABLE IF EXISTS `ocp_review_supplement`;

CREATE TABLE `ocp_review_supplement` (
  `r_post_id` int(11) NOT NULL,
  `r_rating_type` varchar(80) NOT NULL,
  `r_rating` tinyint(4) NOT NULL,
  `r_topic_id` int(11) NOT NULL,
  `r_rating_for_id` varchar(80) NOT NULL,
  `r_rating_for_type` varchar(80) NOT NULL,
  PRIMARY KEY (`r_post_id`,`r_rating_type`),
  KEY `rating_for_id` (`r_rating_for_id`)
) ENGINE=MyISAM CHARACTER SET=latin1;


DROP TABLE IF EXISTS `ocp_sales`;

CREATE TABLE `ocp_sales` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_and_time` int(10) unsigned NOT NULL,
  `memberid` int(11) NOT NULL,
  `purchasetype` varchar(80) NOT NULL,
  `details` varchar(255) NOT NULL,
  `details2` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM CHARACTER SET=latin1;


DROP TABLE IF EXISTS `ocp_searches_logged`;

CREATE TABLE `ocp_searches_logged` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `s_member_id` int(11) NOT NULL,
  `s_time` int(10) unsigned NOT NULL,
  `s_primary` varchar(255) NOT NULL,
  `s_auxillary` longtext NOT NULL,
  `s_num_results` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `past_search` (`s_primary`),
  FULLTEXT KEY `past_search_ft` (`s_primary`)
) ENGINE=MyISAM CHARACTER SET=latin1;


DROP TABLE IF EXISTS `ocp_searches_saved`;

CREATE TABLE `ocp_searches_saved` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `s_title` varchar(255) NOT NULL,
  `s_member_id` int(11) NOT NULL,
  `s_time` int(10) unsigned NOT NULL,
  `s_primary` varchar(255) NOT NULL,
  `s_auxillary` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM CHARACTER SET=latin1;


DROP TABLE IF EXISTS `ocp_security_images`;

CREATE TABLE `ocp_security_images` (
  `si_session_id` int(11) NOT NULL,
  `si_time` int(10) unsigned NOT NULL,
  `si_code` int(11) NOT NULL,
  PRIMARY KEY (`si_session_id`),
  KEY `si_time` (`si_time`)
) ENGINE=MyISAM CHARACTER SET=latin1;


DROP TABLE IF EXISTS `ocp_seedy_changes`;

CREATE TABLE `ocp_seedy_changes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `the_action` varchar(80) NOT NULL,
  `the_page` int(11) NOT NULL,
  `date_and_time` int(10) unsigned NOT NULL,
  `ip` varchar(40) NOT NULL,
  `the_user` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM CHARACTER SET=latin1;


DROP TABLE IF EXISTS `ocp_seedy_children`;

CREATE TABLE `ocp_seedy_children` (
  `parent_id` int(11) NOT NULL,
  `child_id` int(11) NOT NULL,
  `the_order` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`parent_id`,`child_id`)
) ENGINE=MyISAM CHARACTER SET=latin1;


DROP TABLE IF EXISTS `ocp_seedy_pages`;

CREATE TABLE `ocp_seedy_pages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` int(10) unsigned NOT NULL,
  `notes` longtext NOT NULL,
  `description` int(10) unsigned NOT NULL,
  `add_date` int(10) unsigned NOT NULL,
  `seedy_views` int(11) NOT NULL,
  `hide_posts` tinyint(1) NOT NULL,
  `submitter` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `seedy_views` (`seedy_views`),
  KEY `sps` (`submitter`),
  KEY `sadd_date` (`add_date`),
  KEY `ftjoin_spt` (`title`),
  KEY `ftjoin_spd` (`description`)
) ENGINE=MyISAM CHARACTER SET=latin1 AUTO_INCREMENT=2;

insert into `ocp_seedy_pages` values('1','282','','283','1332090686','0','0','1');

DROP TABLE IF EXISTS `ocp_seedy_posts`;

CREATE TABLE `ocp_seedy_posts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `page_id` int(11) NOT NULL,
  `the_message` int(10) unsigned NOT NULL,
  `date_and_time` int(10) unsigned NOT NULL,
  `validated` tinyint(1) NOT NULL,
  `seedy_views` int(11) NOT NULL,
  `the_user` int(11) NOT NULL,
  `edit_date` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `seedy_views` (`seedy_views`),
  KEY `spos` (`the_user`),
  KEY `posts_on_page` (`page_id`),
  KEY `cdate_and_time` (`date_and_time`),
  KEY `svalidated` (`validated`),
  KEY `ftjoin_spm` (`the_message`)
) ENGINE=MyISAM CHARACTER SET=latin1;


DROP TABLE IF EXISTS `ocp_seo_meta`;

CREATE TABLE `ocp_seo_meta` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `meta_for_type` varchar(80) NOT NULL,
  `meta_for_id` varchar(80) NOT NULL,
  `meta_keywords` int(10) unsigned NOT NULL,
  `meta_description` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `alt_key` (`meta_for_type`,`meta_for_id`)
) ENGINE=MyISAM CHARACTER SET=latin1 AUTO_INCREMENT=2;

insert into `ocp_seo_meta` values('1','gallery','root','310','311');

DROP TABLE IF EXISTS `ocp_sessions`;

CREATE TABLE `ocp_sessions` (
  `the_session` int(11) NOT NULL,
  `last_activity` int(10) unsigned NOT NULL,
  `the_user` int(11) NOT NULL,
  `ip` varchar(40) NOT NULL,
  `session_confirmed` tinyint(1) NOT NULL,
  `session_invisible` tinyint(1) NOT NULL,
  `cache_username` varchar(255) NOT NULL,
  `the_zone` varchar(80) NOT NULL,
  `the_page` varchar(80) NOT NULL,
  `the_type` varchar(80) NOT NULL,
  `the_id` varchar(80) NOT NULL,
  `the_title` varchar(255) NOT NULL,
  PRIMARY KEY (`the_session`),
  KEY `delete_old` (`last_activity`),
  KEY `the_user` (`the_user`),
  KEY `userat` (`the_zone`,`the_page`,`the_type`,`the_id`)
) ENGINE=MEMORY;


DROP TABLE IF EXISTS `ocp_shopping_cart`;

CREATE TABLE `ocp_shopping_cart` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `session_id` int(11) NOT NULL,
  `ordered_by` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `product_code` varchar(255) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price_pre_tax` double NOT NULL,
  `price` double NOT NULL,
  `product_description` longtext NOT NULL,
  `product_type` varchar(255) NOT NULL,
  `product_weight` double NOT NULL,
  `is_deleted` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`,`ordered_by`,`product_id`),
  KEY `ordered_by` (`ordered_by`),
  KEY `session_id` (`session_id`),
  KEY `product_id` (`product_id`)
) ENGINE=MyISAM CHARACTER SET=latin1;


DROP TABLE IF EXISTS `ocp_shopping_logging`;

CREATE TABLE `ocp_shopping_logging` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `e_member_id` int(11) NOT NULL,
  `session_id` int(11) NOT NULL,
  `ip` varchar(40) NOT NULL,
  `last_action` varchar(255) NOT NULL,
  `date_and_time` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`,`e_member_id`),
  KEY `calculate_bandwidth` (`date_and_time`)
) ENGINE=MyISAM CHARACTER SET=latin1;


DROP TABLE IF EXISTS `ocp_shopping_order`;

CREATE TABLE `ocp_shopping_order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `c_member` int(11) NOT NULL,
  `session_id` int(11) NOT NULL,
  `add_date` int(10) unsigned NOT NULL,
  `tot_price` double NOT NULL,
  `order_status` varchar(80) NOT NULL,
  `notes` longtext NOT NULL,
  `transaction_id` varchar(255) NOT NULL,
  `purchase_through` varchar(255) NOT NULL,
  `tax_opted_out` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `finddispatchable` (`order_status`),
  KEY `soc_member` (`c_member`),
  KEY `sosession_id` (`session_id`),
  KEY `soadd_date` (`add_date`),
  KEY `recent_shopped` (`add_date`)
) ENGINE=MyISAM CHARACTER SET=latin1;


DROP TABLE IF EXISTS `ocp_shopping_order_addresses`;

CREATE TABLE `ocp_shopping_order_addresses` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(11) DEFAULT NULL,
  `address_name` varchar(255) NOT NULL,
  `address_street` longtext NOT NULL,
  `address_city` varchar(255) NOT NULL,
  `address_zip` varchar(255) NOT NULL,
  `address_country` varchar(255) NOT NULL,
  `receiver_email` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=MyISAM CHARACTER SET=latin1;


DROP TABLE IF EXISTS `ocp_shopping_order_details`;

CREATE TABLE `ocp_shopping_order_details` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(11) DEFAULT NULL,
  `p_id` int(11) DEFAULT NULL,
  `p_name` varchar(255) NOT NULL,
  `p_code` varchar(255) NOT NULL,
  `p_type` varchar(255) NOT NULL,
  `p_quantity` int(11) NOT NULL,
  `p_price` double NOT NULL,
  `included_tax` double NOT NULL,
  `dispatch_status` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `p_id` (`p_id`),
  KEY `order_id` (`order_id`)
) ENGINE=MyISAM CHARACTER SET=latin1;


DROP TABLE IF EXISTS `ocp_sitewatchlist`;

CREATE TABLE `ocp_sitewatchlist` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `siteurl` varchar(255) NOT NULL,
  `site_name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM CHARACTER SET=latin1 AUTO_INCREMENT=2;

insert into `ocp_sitewatchlist` values('1','http://chris4.com/git','');

DROP TABLE IF EXISTS `ocp_sms_log`;

CREATE TABLE `ocp_sms_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `s_member_id` int(11) NOT NULL,
  `s_time` int(10) unsigned NOT NULL,
  `s_trigger_ip` varchar(40) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sms_log_for` (`s_member_id`,`s_time`),
  KEY `sms_trigger_ip` (`s_trigger_ip`)
) ENGINE=MyISAM CHARACTER SET=latin1;


DROP TABLE IF EXISTS `ocp_sp_list`;

CREATE TABLE `ocp_sp_list` (
  `p_section` varchar(80) NOT NULL,
  `the_name` varchar(80) NOT NULL,
  `the_default` tinyint(1) NOT NULL,
  PRIMARY KEY (`the_name`,`the_default`)
) ENGINE=MyISAM CHARACTER SET=latin1;

insert into `ocp_sp_list` values('SUBMISSION','edit_highrange_content','0'),
 ('SUBMISSION','edit_midrange_content','0'),
 ('SUBMISSION','delete_own_lowrange_content','0'),
 ('STAFF_ACTIONS','restore_content_history','0'),
 ('STAFF_ACTIONS','view_content_history','0'),
 ('SUBMISSION','edit_lowrange_content','0'),
 ('SUBMISSION','edit_own_highrange_content','0'),
 ('SUBMISSION','search_engine_links','0'),
 ('SUBMISSION','can_submit_to_others_categories','0'),
 ('SUBMISSION','delete_own_midrange_content','0'),
 ('SUBMISSION','delete_own_highrange_content','0'),
 ('SUBMISSION','delete_lowrange_content','0'),
 ('SUBMISSION','delete_midrange_content','0'),
 ('SUBMISSION','delete_highrange_content','0'),
 ('SUBMISSION','edit_own_midrange_content','0'),
 ('SUBMISSION','bypass_validation_midrange_content','0'),
 ('SUBMISSION','bypass_validation_highrange_content','0'),
 ('STAFF_ACTIONS','access_overrun_site','0'),
 ('STAFF_ACTIONS','view_profiling_modes','0'),
 ('GENERAL_SETTINGS','bypass_word_filter','0'),
 ('STAFF_ACTIONS','see_stack_dump','0'),
 ('STAFF_ACTIONS','see_php_errors','0'),
 ('_COMCODE','comcode_nuisance','0'),
 ('_COMCODE','comcode_dangerous','0'),
 ('STAFF_ACTIONS','bypass_bandwidth_restriction','0'),
 ('STAFF_ACTIONS','access_closed_site','0'),
 ('GENERAL_SETTINGS','remove_page_split','0'),
 ('_COMCODE','allow_html','0'),
 ('GENERAL_SETTINGS','bypass_flood_control','0'),
 ('GENERAL_SETTINGS','see_software_docs','0'),
 ('GENERAL_SETTINGS','avoid_simplified_adminzone_look','0'),
 ('GENERAL_SETTINGS','sees_javascript_error_alerts','0'),
 ('GENERAL_SETTINGS','view_revision_history','0'),
 ('SUBMISSION','exceed_filesize_limit','0'),
 ('SUBMISSION','mass_delete_from_ip','0'),
 ('SUBMISSION','scheduled_publication_times','0'),
 ('GENERAL_SETTINGS','open_virtual_roots','0'),
 ('_COMCODE','use_very_dangerous_comcode','0'),
 ('POLLS','vote_in_polls','1'),
 ('SUBMISSION','have_personal_category','1'),
 ('_FEEDBACK','comment','1'),
 ('_FEEDBACK','rate','1'),
 ('SUBMISSION','set_own_author_profile','1'),
 ('SUBMISSION','bypass_validation_lowrange_content','1'),
 ('SUBMISSION','submit_lowrange_content','1'),
 ('SUBMISSION','submit_midrange_content','1'),
 ('SUBMISSION','submit_highrange_content','1'),
 ('SUBMISSION','edit_own_lowrange_content','1'),
 ('GENERAL_SETTINGS','jump_to_unvalidated','1'),
 ('GENERAL_SETTINGS','see_unvalidated','0'),
 ('SUBMISSION','draw_to_server','0'),
 ('STAFF_ACTIONS','may_enable_staff_notifications','0'),
 ('SECTION_FORUMS','run_multi_moderations','1'),
 ('SECTION_FORUMS','use_pt','1'),
 ('SECTION_FORUMS','edit_personal_topic_posts','1'),
 ('SECTION_FORUMS','may_unblind_own_poll','1'),
 ('SECTION_FORUMS','may_report_post','1'),
 ('SECTION_FORUMS','view_member_photos','1'),
 ('SECTION_FORUMS','use_quick_reply','1'),
 ('SECTION_FORUMS','view_profiles','1'),
 ('SECTION_FORUMS','own_avatars','1'),
 ('SECTION_FORUMS','rename_self','0'),
 ('SECTION_FORUMS','use_special_emoticons','0'),
 ('SECTION_FORUMS','view_any_profile_field','0'),
 ('SECTION_FORUMS','disable_lost_passwords','0'),
 ('SECTION_FORUMS','close_own_topics','0'),
 ('SECTION_FORUMS','edit_own_polls','0'),
 ('SECTION_FORUMS','double_post','0'),
 ('SECTION_FORUMS','see_warnings','0'),
 ('SECTION_FORUMS','see_ip','0'),
 ('SECTION_FORUMS','may_choose_custom_title','0'),
 ('SECTION_FORUMS','delete_account','0'),
 ('SECTION_FORUMS','view_other_pt','0'),
 ('SECTION_FORUMS','view_poll_results_before_voting','0'),
 ('SECTION_FORUMS','moderate_personal_topic','0'),
 ('SECTION_FORUMS','member_maintenance','0'),
 ('SECTION_FORUMS','probate_members','0'),
 ('SECTION_FORUMS','warn_members','0'),
 ('SECTION_FORUMS','control_usergroups','0'),
 ('SECTION_FORUMS','multi_delete_topics','0'),
 ('SECTION_FORUMS','show_user_browsing','0'),
 ('SECTION_FORUMS','see_hidden_groups','0'),
 ('SECTION_FORUMS','pt_anyone','0'),
 ('_COMCODE','reuse_others_attachments','1'),
 ('STAFF_ACTIONS','assume_any_member','0'),
 ('GENERAL_SETTINGS','use_sms','0'),
 ('GENERAL_SETTINGS','sms_higher_limit','0'),
 ('GENERAL_SETTINGS','sms_higher_trigger_limit','0'),
 ('STAFF_ACTIONS','delete_content_history','0'),
 ('SUBMISSION','submit_cat_highrange_content','0'),
 ('SUBMISSION','submit_cat_midrange_content','0'),
 ('SUBMISSION','submit_cat_lowrange_content','0'),
 ('SUBMISSION','edit_cat_highrange_content','0'),
 ('SUBMISSION','edit_cat_midrange_content','0'),
 ('SUBMISSION','edit_cat_lowrange_content','0'),
 ('SUBMISSION','delete_cat_highrange_content','0'),
 ('SUBMISSION','delete_cat_midrange_content','0'),
 ('SUBMISSION','delete_cat_lowrange_content','0'),
 ('SUBMISSION','edit_own_cat_highrange_content','0'),
 ('SUBMISSION','edit_own_cat_midrange_content','0'),
 ('SUBMISSION','edit_own_cat_lowrange_content','0'),
 ('SUBMISSION','delete_own_cat_highrange_content','0'),
 ('SUBMISSION','delete_own_cat_midrange_content','0'),
 ('SUBMISSION','delete_own_cat_lowrange_content','0'),
 ('SUBMISSION','mass_import','0'),
 ('BANNERS','full_banner_setup','0'),
 ('BANNERS','view_anyones_banner_stats','0'),
 ('BANNERS','banner_free','0'),
 ('CALENDAR','view_calendar','1'),
 ('CALENDAR','add_public_events','1'),
 ('CALENDAR','view_personal_events','0'),
 ('CALENDAR','sense_personal_conflicts','0'),
 ('CALENDAR','view_event_subscriptions','0'),
 ('CATALOGUES','high_catalogue_entry_timeout','0'),
 ('SEEDY','seedy_manage_tree','0'),
 ('SECTION_CHAT','create_private_room','1'),
 ('SECTION_CHAT','start_im','1'),
 ('SECTION_CHAT','moderate_my_private_rooms','1'),
 ('SECTION_CHAT','ban_chatters_from_rooms','0'),
 ('GALLERIES','may_download_gallery','0'),
 ('GALLERIES','high_personal_gallery_limit','0'),
 ('GALLERIES','no_personal_gallery_limit','0'),
 ('IOTDS','choose_iotd','0'),
 ('NEWSLETTER','change_newsletter_subscriptions','0'),
 ('POINTS','use_points','1'),
 ('POINTS','give_points_self','0'),
 ('POINTS','have_negative_gift_points','0'),
 ('POINTS','give_negative_points','0'),
 ('POINTS','view_charge_log','0'),
 ('POINTS','trace_anonymous_gifts','0'),
 ('POLLS','choose_poll','0'),
 ('ECOMMERCE','access_ecommerce_in_test_mode','0'),
 ('QUIZZES','bypass_quiz_repeat_time_restriction','0'),
 ('TESTER','perform_tests','0'),
 ('TESTER','add_tests','1'),
 ('TESTER','edit_own_tests','1'),
 ('SUPPORT_TICKETS','support_operator','0'),
 ('SUPPORT_TICKETS','view_others_tickets','0'),
 ('FILE_DUMP','upload_anything_filedump','0'),
 ('FILE_DUMP','upload_filedump','1'),
 ('FILE_DUMP','delete_anything_filedump','0');

DROP TABLE IF EXISTS `ocp_staff_tips_dismissed`;

CREATE TABLE `ocp_staff_tips_dismissed` (
  `t_member` int(11) NOT NULL,
  `t_tip` varchar(80) NOT NULL,
  PRIMARY KEY (`t_member`,`t_tip`)
) ENGINE=MyISAM CHARACTER SET=latin1;


DROP TABLE IF EXISTS `ocp_stafflinks`;

CREATE TABLE `ocp_stafflinks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `link` varchar(255) NOT NULL,
  `link_title` varchar(255) NOT NULL,
  `link_desc` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM CHARACTER SET=latin1 AUTO_INCREMENT=29;

insert into `ocp_stafflinks` values('1','http://ocportal.com/','ocPortal.com','ocPortal.com'),
 ('2','http://ocportal.com/forum/vforums/unread.htm','ocPortal.com (topics with unread posts)','ocPortal.com (topics with unread posts)'),
 ('3','http://ocproducts.com/','ocProducts (web development services)','ocProducts (web development services)'),
 ('4','https://translations.launchpad.net/ocportal/+translations','Launchpad (ocPortal language translations)','Launchpad (ocPortal language translations)'),
 ('5','http://www.google.com/alerts','Google Alerts','Google Alerts'),
 ('6','http://www.google.com/analytics/','Google Analytics','Google Analytics'),
 ('7','https://www.google.com/webmasters/tools','Google Webmaster Tools','Google Webmaster Tools'),
 ('8','http://www.google.com/apps/intl/en/group/index.html','Google Apps (free gmail for domains, etc)','Google Apps (free gmail for domains, etc)'),
 ('9','http://www.google.com/chrome','Google Chrome (web browser)','Google Chrome (web browser)'),
 ('10','https://chrome.google.com/extensions/featured/web_dev','Google Chrome addons','Google Chrome addons'),
 ('11','http://www.getfirefox.com/','Firefox (web browser)','Firefox (web browser)'),
 ('12','http://www.instantshift.com/2009/01/25/26-essential-firefox-add-ons-for-web-designers/','FireFox addons','FireFox addons'),
 ('13','http://www.opera.com/','Opera (web browser)','Opera (web browser)'),
 ('14','http://www.my-debugbar.com/wiki/IETester/HomePage','Internet Explorer Tester (for testing)','Internet Explorer Tester (for testing)'),
 ('15','http://www.getpaint.net/','Paint.net (free graphics tool)','Paint.net (free graphics tool)'),
 ('16','http://benhollis.net/software/pnggauntlet/','PNGGauntlet (compress PNG files, Windows)','PNGGauntlet (compress PNG files, Windows)'),
 ('17','http://imageoptim.pornel.net/','ImageOptim (compress PNG files, Mac)','ImageOptim (compress PNG files, Mac)'),
 ('18','http://www.iconlet.com/','Iconlet (free icons)','Iconlet (free icons)'),
 ('19','http://sxc.hu/','stock.xchng (free stock art)','stock.xchng (free stock art)'),
 ('20','http://www.kompozer.net/','Kompozer (Web design tool)','Kompozer (Web design tool)'),
 ('21','http://www.sourcegear.com/diffmerge/','DiffMerge','DiffMerge'),
 ('22','http://www.jingproject.com/','Jing (record screencasts)','Jing (record screencasts)'),
 ('23','http://www.elief.com/billing/aff.php?aff=035','Elief hosting (quality shared hosting)','Elief hosting (quality shared hosting)'),
 ('24','http://www.rackspacecloud.com/1043-0-3-13.html','Rackspace Cloud hosting','Rackspace Cloud hosting'),
 ('25','http://www.jdoqocy.com/click-3972552-10378406','GoDaddy (Domains and SSL certificates)','GoDaddy (Domains and SSL certificates)'),
 ('26','http://www.silktide.com/siteray','SiteRay (site quality auditing)','SiteRay (site quality auditing)'),
 ('27','http://www.smashingmagazine.com/','Smashing Magazine (web design articles)','Smashing Magazine (web design articles)'),
 ('28','http://www.w3schools.com/','w3schools (learn web technologies)','w3schools (learn web technologies)');

DROP TABLE IF EXISTS `ocp_stats`;

CREATE TABLE `ocp_stats` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `the_page` varchar(255) NOT NULL,
  `ip` varchar(40) NOT NULL,
  `the_user` int(11) NOT NULL,
  `date_and_time` int(10) unsigned NOT NULL,
  `referer` varchar(255) NOT NULL,
  `get` varchar(255) NOT NULL,
  `post` longtext NOT NULL,
  `browser` varchar(255) NOT NULL,
  `milliseconds` int(11) NOT NULL,
  `operating_system` varchar(255) NOT NULL,
  `access_denied_counter` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `member_track_1` (`the_user`),
  KEY `member_track_2` (`ip`),
  KEY `pages` (`the_page`),
  KEY `date_and_time` (`date_and_time`),
  KEY `milliseconds` (`milliseconds`),
  KEY `referer` (`referer`),
  KEY `browser` (`browser`),
  KEY `operating_system` (`operating_system`)
) ENGINE=MyISAM CHARACTER SET=latin1;


DROP TABLE IF EXISTS `ocp_subscriptions`;

CREATE TABLE `ocp_subscriptions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `s_type_code` varchar(80) NOT NULL,
  `s_member_id` int(11) NOT NULL,
  `s_state` varchar(80) NOT NULL,
  `s_amount` varchar(255) NOT NULL,
  `s_special` varchar(255) NOT NULL,
  `s_time` int(10) unsigned NOT NULL,
  `s_auto_fund_source` varchar(80) NOT NULL,
  `s_auto_fund_key` varchar(255) NOT NULL,
  `s_via` varchar(80) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM CHARACTER SET=latin1;


DROP TABLE IF EXISTS `ocp_temp_block_permissions`;

CREATE TABLE `ocp_temp_block_permissions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `p_session_id` int(11) NOT NULL,
  `p_block_constraints` longtext NOT NULL,
  `p_time` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM CHARACTER SET=latin1;


DROP TABLE IF EXISTS `ocp_test_sections`;

CREATE TABLE `ocp_test_sections` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `s_section` varchar(255) NOT NULL,
  `s_notes` longtext NOT NULL,
  `s_inheritable` tinyint(1) NOT NULL,
  `s_assigned_to` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM CHARACTER SET=latin1;


DROP TABLE IF EXISTS `ocp_tests`;

CREATE TABLE `ocp_tests` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `t_section` int(11) NOT NULL,
  `t_test` longtext NOT NULL,
  `t_assigned_to` int(11) DEFAULT NULL,
  `t_enabled` tinyint(1) NOT NULL,
  `t_status` int(11) NOT NULL,
  `t_inherit_section` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM CHARACTER SET=latin1;


DROP TABLE IF EXISTS `ocp_text`;

CREATE TABLE `ocp_text` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `the_message` int(10) unsigned NOT NULL,
  `days` int(11) NOT NULL,
  `order_time` int(10) unsigned NOT NULL,
  `activation_time` int(10) unsigned DEFAULT NULL,
  `active_now` tinyint(1) NOT NULL,
  `notes` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `findflagrant` (`active_now`)
) ENGINE=MyISAM CHARACTER SET=latin1;


DROP TABLE IF EXISTS `ocp_theme_images`;

CREATE TABLE `ocp_theme_images` (
  `id` varchar(255) NOT NULL,
  `theme` varchar(40) NOT NULL,
  `path` varchar(255) NOT NULL,
  `lang` varchar(5) NOT NULL,
  PRIMARY KEY (`id`,`theme`,`lang`),
  KEY `theme` (`theme`,`lang`)
) ENGINE=MyISAM CHARACTER SET=latin1;

insert into `ocp_theme_images` values('favicon','default','favicon.ico','EN'),
 ('appleicon','default','appleicon.png','EN');

DROP TABLE IF EXISTS `ocp_ticket_types`;

CREATE TABLE `ocp_ticket_types` (
  `ticket_type` int(10) unsigned NOT NULL,
  `guest_emails_mandatory` tinyint(1) NOT NULL,
  `search_faq` tinyint(1) NOT NULL,
  `cache_lead_time` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`ticket_type`)
) ENGINE=MyISAM CHARACTER SET=latin1;

insert into `ocp_ticket_types` values('367','0','0',null),
 ('368','0','0',null);

DROP TABLE IF EXISTS `ocp_tickets`;

CREATE TABLE `ocp_tickets` (
  `ticket_id` varchar(255) NOT NULL,
  `topic_id` int(11) NOT NULL,
  `forum_id` int(11) NOT NULL,
  `ticket_type` int(10) unsigned NOT NULL,
  PRIMARY KEY (`ticket_id`)
) ENGINE=MyISAM CHARACTER SET=latin1;


DROP TABLE IF EXISTS `ocp_trackbacks`;

CREATE TABLE `ocp_trackbacks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `trackback_for_type` varchar(80) NOT NULL,
  `trackback_for_id` varchar(80) NOT NULL,
  `trackback_ip` varchar(40) NOT NULL,
  `trackback_time` int(10) unsigned NOT NULL,
  `trackback_url` varchar(255) NOT NULL,
  `trackback_title` varchar(255) NOT NULL,
  `trackback_excerpt` longtext NOT NULL,
  `trackback_name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `trackback_for_type` (`trackback_for_type`),
  KEY `trackback_for_id` (`trackback_for_id`),
  KEY `trackback_time` (`trackback_time`)
) ENGINE=MyISAM CHARACTER SET=latin1;


DROP TABLE IF EXISTS `ocp_trans_expecting`;

CREATE TABLE `ocp_trans_expecting` (
  `id` varchar(80) NOT NULL,
  `e_purchase_id` varchar(80) NOT NULL,
  `e_item_name` varchar(255) NOT NULL,
  `e_member_id` int(11) NOT NULL,
  `e_amount` varchar(255) NOT NULL,
  `e_ip_address` varchar(40) NOT NULL,
  `e_session_id` int(11) NOT NULL,
  `e_time` int(10) unsigned NOT NULL,
  `e_length` int(11) DEFAULT NULL,
  `e_length_units` varchar(80) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM CHARACTER SET=latin1;


DROP TABLE IF EXISTS `ocp_transactions`;

CREATE TABLE `ocp_transactions` (
  `id` varchar(80) NOT NULL,
  `purchase_id` varchar(80) NOT NULL,
  `status` varchar(255) NOT NULL,
  `reason` varchar(255) NOT NULL,
  `amount` varchar(255) NOT NULL,
  `t_currency` varchar(80) NOT NULL,
  `linked` varchar(80) NOT NULL,
  `t_time` int(10) unsigned NOT NULL,
  `item` varchar(255) NOT NULL,
  `pending_reason` varchar(255) NOT NULL,
  `t_memo` longtext NOT NULL,
  `t_via` varchar(80) NOT NULL,
  PRIMARY KEY (`id`,`t_time`)
) ENGINE=MyISAM CHARACTER SET=latin1;


DROP TABLE IF EXISTS `ocp_translate`;

CREATE TABLE `ocp_translate` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `language` varchar(5) NOT NULL,
  `importance_level` tinyint(4) NOT NULL,
  `text_original` longtext NOT NULL,
  `text_parsed` longtext NOT NULL,
  `broken` tinyint(1) NOT NULL,
  `source_user` int(11) NOT NULL,
  PRIMARY KEY (`id`,`language`),
  KEY `importance_level` (`importance_level`),
  KEY `equiv_lang` (`text_original`(4)),
  KEY `decache` (`text_parsed`(2)),
  FULLTEXT KEY `search` (`text_original`)
) ENGINE=MyISAM CHARACTER SET=latin1 AUTO_INCREMENT=403;

insert into `ocp_translate` values('1','EN','1','','','0','1'),
 ('2','EN','1','Admin Zone','','0','1'),
 ('3','EN','1','Collaboration Zone','','0','1'),
 ('4','EN','1','','','0','1'),
 ('5','EN','1','Content Management','','0','1'),
 ('6','EN','1','Guides','','0','1'),
 ('7','EN','1','Welcome','','0','1'),
 ('8','EN','1','Admin Zone','','0','1'),
 ('9','EN','1','Site','','0','1'),
 ('10','EN','1','Collaboration Zone','','0','1'),
 ('11','EN','1','Content Management','','0','1'),
 ('12','EN','1','Forum','','0','1'),
 ('13','EN','1','Forums','','0','1'),
 ('14','EN','2','About me','','0','1'),
 ('15','EN','2','Some personally written information.','','0','1'),
 ('16','EN','2','Skype ID','','0','1'),
 ('17','EN','2','Your Skype ID.','','0','1'),
 ('18','EN','2','Facebook profile','','0','1'),
 ('19','EN','2','A link to your Facebook profile.','','0','1'),
 ('20','EN','2','Google+ profile','','0','1'),
 ('21','EN','2','A link to your Google+ profile.','','0','1'),
 ('22','EN','2','Twitter account','','0','1'),
 ('23','EN','2','Your Twitter name (for example, \'charlie12345\').','','0','1'),
 ('24','EN','2','Interests','','0','1'),
 ('25','EN','2','A summary of your interests.','','0','1'),
 ('26','EN','2','Location','','0','1'),
 ('27','EN','2','Your geographical location.','','0','1'),
 ('28','EN','2','Occupation','','0','1'),
 ('29','EN','2','Your occupation.','','0','1'),
 ('30','EN','2','Staff notes','','0','1'),
 ('31','EN','2','Notes on this member, only viewable by staff.','','0','1'),
 ('32','EN','2','Guests','','0','1'),
 ('33','EN','2','Guest user','','0','1'),
 ('34','EN','2','Administrators','','0','1'),
 ('35','EN','2','Site director','','0','1'),
 ('36','EN','2','Super-moderators','','0','1'),
 ('37','EN','2','Site staff','','0','1'),
 ('38','EN','2','Super-members','','0','1'),
 ('39','EN','2','Super-member','','0','1'),
 ('40','EN','2','Local hero','','0','1'),
 ('41','EN','2','Standard member','','0','1'),
 ('42','EN','2','Old timer','','0','1'),
 ('43','EN','2','Standard member','','0','1'),
 ('44','EN','2','Local','','0','1'),
 ('45','EN','2','Standard member','','0','1'),
 ('46','EN','2','Regular','','0','1'),
 ('47','EN','2','Standard member','','0','1'),
 ('48','EN','2','Newbie','','0','1'),
 ('49','EN','2','Standard member','','0','1'),
 ('50','EN','2','Probation','','0','1'),
 ('51','EN','2','Members will be considered to be in this usergroup (and only this usergroup) if and whilst they have been placed on probation. This usergroup behaves like any other, and therefore may also be manually placed into it.','','0','1'),
 ('52','EN','2','','','0','1'),
 ('53','EN','3','','','0','1'),
 ('54','EN','2','','','0','1'),
 ('55','EN','3','','','0','1'),
 ('56','EN','2','','','0','1'),
 ('57','EN','3','','','0','1'),
 ('58','EN','2','','','0','1'),
 ('59','EN','3','','','0','1'),
 ('60','EN','2','','','0','1'),
 ('61','EN','3','','','0','1'),
 ('62','EN','2','','','0','1'),
 ('63','EN','3','','','0','1'),
 ('64','EN','2','','','0','1'),
 ('65','EN','3','','','0','1'),
 ('66','EN','3','Trash','','0','1'),
 ('67','EN','4','','return unserialize(\"a:6:{i:0;a:1:{i:0;a:5:{i:0;s:37:\\\"string_attach_4f661710bab452.35545218\\\";i:1;a:0:{}i:2;i:1;i:3;s:0:\\\"\\\";i:4;s:0:\\\"\\\";}}i:1;a:0:{}i:2;s:10:\\\":container\\\";i:3;N;i:4;N;i:5;s:66:\\\"\\$TPL_FUNCS[\'string_attach_4f661710bab452.35545218\']=\\\"echo \\\\\\\"\\\\\\\";\\\";\\n\\\";}\");\n','0','1'),
 ('68','EN','4','','return unserialize(\"a:6:{i:0;a:1:{i:0;a:5:{i:0;s:37:\\\"string_attach_4f661710bade92.78045630\\\";i:1;a:0:{}i:2;i:1;i:3;s:0:\\\"\\\";i:4;s:0:\\\"\\\";}}i:1;a:0:{}i:2;s:10:\\\":container\\\";i:3;N;i:4;N;i:5;s:66:\\\"\\$TPL_FUNCS[\'string_attach_4f661710bade92.78045630\']=\\\"echo \\\\\\\"\\\\\\\";\\\";\\n\\\";}\");\n','0','1'),
 ('69','EN','3','','','0','1'),
 ('70','EN','3','','','0','1'),
 ('71','EN','3','','','0','1'),
 ('72','EN','3','','','0','1'),
 ('73','EN','3','','','0','1'),
 ('74','EN','3','','','0','1'),
 ('75','EN','4','','return unserialize(\"a:6:{i:0;a:1:{i:0;a:5:{i:0;s:37:\\\"string_attach_4f661710bbd3d0.93197112\\\";i:1;a:0:{}i:2;i:1;i:3;s:0:\\\"\\\";i:4;s:0:\\\"\\\";}}i:1;a:0:{}i:2;s:10:\\\":container\\\";i:3;N;i:4;N;i:5;s:66:\\\"\\$TPL_FUNCS[\'string_attach_4f661710bbd3d0.93197112\']=\\\"echo \\\\\\\"\\\\\\\";\\\";\\n\\\";}\");\n','0','1'),
 ('76','EN','4','','return unserialize(\"a:6:{i:0;a:1:{i:0;a:5:{i:0;s:37:\\\"string_attach_4f661710bbfec2.14388323\\\";i:1;a:0:{}i:2;i:1;i:3;s:0:\\\"\\\";i:4;s:0:\\\"\\\";}}i:1;a:0:{}i:2;s:10:\\\":container\\\";i:3;N;i:4;N;i:5;s:66:\\\"\\$TPL_FUNCS[\'string_attach_4f661710bbfec2.14388323\']=\\\"echo \\\\\\\"\\\\\\\";\\\";\\n\\\";}\");\n','0','1'),
 ('77','EN','3','','','0','1'),
 ('78','EN','3','','','0','1'),
 ('79','EN','3','','','0','1'),
 ('80','EN','3','','','0','1'),
 ('81','EN','3','','','0','1'),
 ('82','EN','3','','','0','1'),
 ('83','EN','4','','return unserialize(\"a:6:{i:0;a:1:{i:0;a:5:{i:0;s:37:\\\"string_attach_4f661710bcc933.19430014\\\";i:1;a:0:{}i:2;i:1;i:3;s:0:\\\"\\\";i:4;s:0:\\\"\\\";}}i:1;a:0:{}i:2;s:10:\\\":container\\\";i:3;N;i:4;N;i:5;s:66:\\\"\\$TPL_FUNCS[\'string_attach_4f661710bcc933.19430014\']=\\\"echo \\\\\\\"\\\\\\\";\\\";\\n\\\";}\");\n','0','1'),
 ('84','EN','4','','return unserialize(\"a:6:{i:0;a:1:{i:0;a:5:{i:0;s:37:\\\"string_attach_4f661710bce1c6.54984498\\\";i:1;a:0:{}i:2;i:1;i:3;s:0:\\\"\\\";i:4;s:0:\\\"\\\";}}i:1;a:0:{}i:2;s:10:\\\":container\\\";i:3;N;i:4;N;i:5;s:66:\\\"\\$TPL_FUNCS[\'string_attach_4f661710bce1c6.54984498\']=\\\"echo \\\\\\\"\\\\\\\";\\\";\\n\\\";}\");\n','0','1'),
 ('85','EN','3','','','0','1'),
 ('86','EN','3','','','0','1'),
 ('87','EN','3','','','0','1'),
 ('88','EN','3','','','0','1'),
 ('89','EN','3','','','0','1'),
 ('90','EN','3','','','0','1'),
 ('91','EN','4','This is the inbuilt forum system (known as OCF).\n\nA forum system is a tool for communication between members; it consists of posts, organised into topics: each topic is a line of conversation.\n\nThe website software provides support for a number of different forum systems, and each forum handles authentication of members: OCF is the built-in forum, which provides seamless integration between the main website, the forums, and the inbuilt member accounts system.','return unserialize(\"a:6:{i:0;a:7:{i:0;a:5:{i:0;s:37:\\\"string_attach_4f661711486134.14173370\\\";i:1;a:0:{}i:2;i:1;i:3;s:0:\\\"\\\";i:4;s:0:\\\"\\\";}i:1;a:5:{i:0;s:37:\\\"string_attach_4f6617114862f8.05056137\\\";i:1;a:0:{}i:2;i:1;i:3;s:0:\\\"\\\";i:4;s:0:\\\"\\\";}i:2;a:5:{i:0;s:37:\\\"string_attach_4f661711486492.66728217\\\";i:1;a:0:{}i:2;i:1;i:3;s:0:\\\"\\\";i:4;s:0:\\\"\\\";}i:3;a:5:{i:0;s:37:\\\"string_attach_4f6617114d23f4.86954486\\\";i:1;a:0:{}i:2;i:1;i:3;s:0:\\\"\\\";i:4;s:0:\\\"\\\";}i:4;a:5:{i:0;s:37:\\\"string_attach_4f6617114d2598.40103278\\\";i:1;a:0:{}i:2;i:1;i:3;s:0:\\\"\\\";i:4;s:0:\\\"\\\";}i:5;a:5:{i:0;s:37:\\\"string_attach_4f6617114d2717.32348490\\\";i:1;a:0:{}i:2;i:1;i:3;s:0:\\\"\\\";i:4;s:0:\\\"\\\";}i:6;a:5:{i:0;s:37:\\\"string_attach_4f661711575bf2.93706228\\\";i:1;a:0:{}i:2;i:1;i:3;s:0:\\\"\\\";i:4;s:0:\\\"\\\";}}i:1;a:0:{}i:2;s:7:\\\"(mixed)\\\";i:3;s:0:\\\"\\\";i:4;N;i:5;s:945:\\\"\\$TPL_FUNCS[\'string_attach_4f661711486134.14173370\']=\\\"echo \\\\\\\"This is the inbuilt forum system (known as OCF).\\\\\\\";\\\";\\n\\$TPL_FUNCS[\'string_attach_4f6617114862f8.05056137\']=\\\"echo \\\\\\\"<br />\\\\\\\";\\\";\\n\\$TPL_FUNCS[\'string_attach_4f661711486492.66728217\']=\\\"echo \\\\\\\"<br />\\\\\\\";\\\";\\n\\$TPL_FUNCS[\'string_attach_4f6617114d23f4.86954486\']=\\\"echo \\\\\\\"A forum system is a tool for communication between members; it consists of posts, organised into topics: each topic is a line of conversation.\\\\\\\";\\\";\\n\\$TPL_FUNCS[\'string_attach_4f6617114d2598.40103278\']=\\\"echo \\\\\\\"<br />\\\\\\\";\\\";\\n\\$TPL_FUNCS[\'string_attach_4f6617114d2717.32348490\']=\\\"echo \\\\\\\"<br />\\\\\\\";\\\";\\n\\$TPL_FUNCS[\'string_attach_4f661711575bf2.93706228\']=\\\"echo \\\\\\\"The website software provides support for a number of different forum systems, and each forum handles authentication of members: OCF is the built-in forum, which provides seamless integration between the main website, the forums, and the inbuilt member accounts system.\\\\\\\";\\\";\\n\\\";}\");\n','0','1'),
 ('92','EN','2','ocp_mobile_phone_number','','0','1'),
 ('93','EN','2','This should be the mobile phone number in international format, devoid of any national or international outgoing access codes. For instance, a typical UK (44) number might be nationally known as \'01234 123456\', but internationally and without outgoing access codes would be \'441234123456\'.','','0','1'),
 ('94','EN','2','Download of the week','','0','1'),
 ('95','EN','2','The best downloads in the download system, chosen every week.','','0','1'),
 ('96','EN','2','Embed Facebook videos','','0','1'),
 ('97','EN','2','Embed Facebook videos into your content.','','0','1'),
 ('98','EN','2','Embed YouTube videos','','0','1'),
 ('99','EN','2','Embed YouTube videos into your content.','','0','1'),
 ('100','EN','1','Front page','','0','1'),
 ('101','EN','1','','','0','1'),
 ('102','EN','1','Rules','','0','1'),
 ('103','EN','1','','','0','1'),
 ('104','EN','1','Front page','','0','1'),
 ('105','EN','1','','','0','1'),
 ('106','EN','1','Guide','','0','1'),
 ('107','EN','1','','','0','1'),
 ('108','EN','1','Rules','','0','1'),
 ('109','EN','1','','','0','1'),
 ('110','EN','1','Members','','0','1'),
 ('111','EN','1','','','0','1'),
 ('112','EN','1','Usergroups','','0','1'),
 ('113','EN','1','','','0','1'),
 ('114','EN','1','Join','','0','1'),
 ('115','EN','1','','','0','1'),
 ('116','EN','1','Reset password','','0','1'),
 ('117','EN','1','','','0','1'),
 ('118','EN','1','Front page','','0','1'),
 ('119','EN','1','','','0','1'),
 ('120','EN','1','About','','0','1'),
 ('121','EN','1','','','0','1'),
 ('122','EN','1','Rules','','0','1'),
 ('123','EN','1','','','0','1'),
 ('124','EN','1','Members','','0','1'),
 ('125','EN','1','','','0','1'),
 ('126','EN','1','Site','','0','1'),
 ('127','EN','1','','','0','1'),
 ('128','EN','1','Forums','','0','1'),
 ('129','EN','1','','','0','1'),
 ('130','EN','1','Collaboration Zone','','0','1'),
 ('131','EN','1','','','0','1'),
 ('132','EN','1','Content Management','','0','1'),
 ('133','EN','1','','','0','1'),
 ('134','EN','1','Admin Zone','','0','1'),
 ('135','EN','1','','','0','1'),
 ('136','EN','2','','','0','1'),
 ('137','EN','3','','','0','1'),
 ('138','EN','1','View my author profile','','0','1'),
 ('139','EN','1','','','0','1'),
 ('140','EN','1','Configure my author profile','','0','1'),
 ('141','EN','1','This link is a shortcut: the menu will change','','0','1'),
 ('142','EN','1','Advertise here!','return unserialize(\"a:6:{i:0;a:1:{i:0;a:5:{i:0;s:37:\\\"string_attach_4f661732eb0ac9.90138419\\\";i:1;a:0:{}i:2;i:1;i:3;s:0:\\\"\\\";i:4;s:0:\\\"\\\";}}i:1;a:0:{}i:2;s:10:\\\":container\\\";i:3;N;i:4;N;i:5;s:81:\\\"\\$TPL_FUNCS[\'string_attach_4f661732eb0ac9.90138419\']=\\\"echo \\\\\\\"Advertise here!\\\\\\\";\\\";\\n\\\";}\");\n','0','1'),
 ('143','EN','1','Please donate to keep this site alive','return unserialize(\"a:6:{i:0;a:1:{i:0;a:5:{i:0;s:37:\\\"string_attach_4f661732eb7925.31341370\\\";i:1;a:0:{}i:2;i:1;i:3;s:0:\\\"\\\";i:4;s:0:\\\"\\\";}}i:1;a:0:{}i:2;s:10:\\\":container\\\";i:3;N;i:4;N;i:5;s:103:\\\"\\$TPL_FUNCS[\'string_attach_4f661732eb7925.31341370\']=\\\"echo \\\\\\\"Please donate to keep this site alive\\\\\\\";\\\";\\n\\\";}\");\n','0','1'),
 ('144','EN','2','(System command)','','0','1'),
 ('145','EN','2','General','','0','1'),
 ('146','EN','2','Birthday','','0','1'),
 ('147','EN','2','Public holiday','','0','1'),
 ('148','EN','2','Vacation','','0','1'),
 ('149','EN','2','Appointment','','0','1'),
 ('150','EN','2','Task','','0','1'),
 ('151','EN','2','Anniversary','','0','1'),
 ('152','EN','2','Super-member projects','','0','1'),
 ('153','EN','3','These are projects listed by super-members, designed to: advertise project existence, detail current progress, and solicit help.','return unserialize(\"a:6:{i:0;a:1:{i:0;a:5:{i:0;s:37:\\\"string_attach_4f66173b5a4052.58288014\\\";i:1;a:0:{}i:2;i:1;i:3;s:0:\\\"\\\";i:4;s:0:\\\"\\\";}}i:1;a:0:{}i:2;s:10:\\\":container\\\";i:3;N;i:4;N;i:5;s:194:\\\"\\$TPL_FUNCS[\'string_attach_4f66173b5a4052.58288014\']=\\\"echo \\\\\\\"These are projects listed by super-members, designed to: advertise project existence, detail current progress, and solicit help.\\\\\\\";\\\";\\n\\\";}\");\n','0','1'),
 ('154','EN','3','Name','','0','1'),
 ('155','EN','3','The name for this.','return unserialize(\"a:6:{i:0;a:1:{i:0;a:5:{i:0;s:37:\\\"string_attach_4f66173b5b4643.52716870\\\";i:1;a:0:{}i:2;i:1;i:3;s:0:\\\"\\\";i:4;s:0:\\\"\\\";}}i:1;a:0:{}i:2;s:10:\\\":container\\\";i:3;N;i:4;N;i:5;s:84:\\\"\\$TPL_FUNCS[\'string_attach_4f66173b5b4643.52716870\']=\\\"echo \\\\\\\"The name for this.\\\\\\\";\\\";\\n\\\";}\");\n','0','1'),
 ('156','EN','3','Maintainer','','0','1'),
 ('157','EN','3','The maintainer of this project.','return unserialize(\"a:6:{i:0;a:1:{i:0;a:5:{i:0;s:37:\\\"string_attach_4f66173b5cbb93.52396199\\\";i:1;a:0:{}i:2;i:1;i:3;s:0:\\\"\\\";i:4;s:0:\\\"\\\";}}i:1;a:0:{}i:2;s:10:\\\":container\\\";i:3;N;i:4;N;i:5;s:97:\\\"\\$TPL_FUNCS[\'string_attach_4f66173b5cbb93.52396199\']=\\\"echo \\\\\\\"The maintainer of this project.\\\\\\\";\\\";\\n\\\";}\");\n','0','1'),
 ('158','EN','3','Description','','0','1'),
 ('159','EN','3','A concise description for this.','return unserialize(\"a:6:{i:0;a:1:{i:0;a:5:{i:0;s:37:\\\"string_attach_4f66173b5d8199.48072332\\\";i:1;a:0:{}i:2;i:1;i:3;s:0:\\\"\\\";i:4;s:0:\\\"\\\";}}i:1;a:0:{}i:2;s:10:\\\":container\\\";i:3;N;i:4;N;i:5;s:97:\\\"\\$TPL_FUNCS[\'string_attach_4f66173b5d8199.48072332\']=\\\"echo \\\\\\\"A concise description for this.\\\\\\\";\\\";\\n\\\";}\");\n','0','1'),
 ('160','EN','3','Project progress','','0','1'),
 ('161','EN','3','The estimated percentage of completion of this project.','return unserialize(\"a:6:{i:0;a:1:{i:0;a:5:{i:0;s:37:\\\"string_attach_4f66173b5e2e10.30725128\\\";i:1;a:0:{}i:2;i:1;i:3;s:0:\\\"\\\";i:4;s:0:\\\"\\\";}}i:1;a:0:{}i:2;s:10:\\\":container\\\";i:3;N;i:4;N;i:5;s:121:\\\"\\$TPL_FUNCS[\'string_attach_4f66173b5e2e10.30725128\']=\\\"echo \\\\\\\"The estimated percentage of completion of this project.\\\\\\\";\\\";\\n\\\";}\");\n','0','1'),
 ('162','EN','2','Super-member projects','','0','1'),
 ('163','EN','3','These are projects listed by super-members, designed to: advertise project existence, detail current progress, and solicit help.','return unserialize(\"a:6:{i:0;a:1:{i:0;a:5:{i:0;s:37:\\\"string_attach_4f66173b5ed697.47368703\\\";i:1;a:0:{}i:2;i:1;i:3;s:0:\\\"\\\";i:4;s:0:\\\"\\\";}}i:1;a:0:{}i:2;s:10:\\\":container\\\";i:3;N;i:4;N;i:5;s:194:\\\"\\$TPL_FUNCS[\'string_attach_4f66173b5ed697.47368703\']=\\\"echo \\\\\\\"These are projects listed by super-members, designed to: advertise project existence, detail current progress, and solicit help.\\\\\\\";\\\";\\n\\\";}\");\n','0','1'),
 ('164','EN','1','Super-member projects','','0','1'),
 ('165','EN','1','','','0','1'),
 ('166','EN','2','Modifications','','0','1'),
 ('167','EN','3','These are mods that may be applied.','return unserialize(\"a:6:{i:0;a:1:{i:0;a:5:{i:0;s:37:\\\"string_attach_4f66173b626057.51151338\\\";i:1;a:0:{}i:2;i:1;i:3;s:0:\\\"\\\";i:4;s:0:\\\"\\\";}}i:1;a:0:{}i:2;s:10:\\\":container\\\";i:3;N;i:4;N;i:5;s:101:\\\"\\$TPL_FUNCS[\'string_attach_4f66173b626057.51151338\']=\\\"echo \\\\\\\"These are mods that may be applied.\\\\\\\";\\\";\\n\\\";}\");\n','0','1'),
 ('168','EN','3','Name','','0','1'),
 ('169','EN','3','The name for this.','return unserialize(\"a:6:{i:0;a:1:{i:0;a:5:{i:0;s:37:\\\"string_attach_4f66173b62e143.08875870\\\";i:1;a:0:{}i:2;i:1;i:3;s:0:\\\"\\\";i:4;s:0:\\\"\\\";}}i:1;a:0:{}i:2;s:10:\\\":container\\\";i:3;N;i:4;N;i:5;s:84:\\\"\\$TPL_FUNCS[\'string_attach_4f66173b62e143.08875870\']=\\\"echo \\\\\\\"The name for this.\\\\\\\";\\\";\\n\\\";}\");\n','0','1'),
 ('170','EN','3','Image','','0','1'),
 ('171','EN','3','A logo for this modification.','return unserialize(\"a:6:{i:0;a:1:{i:0;a:5:{i:0;s:37:\\\"string_attach_4f66173b636087.25139477\\\";i:1;a:0:{}i:2;i:1;i:3;s:0:\\\"\\\";i:4;s:0:\\\"\\\";}}i:1;a:0:{}i:2;s:10:\\\":container\\\";i:3;N;i:4;N;i:5;s:95:\\\"\\$TPL_FUNCS[\'string_attach_4f66173b636087.25139477\']=\\\"echo \\\\\\\"A logo for this modification.\\\\\\\";\\\";\\n\\\";}\");\n','0','1'),
 ('172','EN','3','Status','','0','1'),
 ('173','EN','3','The status of this modification. This can be any text string, such as: Completed, Planning, Development or Testing.','return unserialize(\"a:6:{i:0;a:1:{i:0;a:5:{i:0;s:37:\\\"string_attach_4f66173b645591.82582132\\\";i:1;a:0:{}i:2;i:1;i:3;s:0:\\\"\\\";i:4;s:0:\\\"\\\";}}i:1;a:0:{}i:2;s:10:\\\":container\\\";i:3;N;i:4;N;i:5;s:181:\\\"\\$TPL_FUNCS[\'string_attach_4f66173b645591.82582132\']=\\\"echo \\\\\\\"The status of this modification. This can be any text string, such as: Completed, Planning, Development or Testing.\\\\\\\";\\\";\\n\\\";}\");\n','0','1'),
 ('174','EN','3','URL','','0','1'),
 ('175','EN','3','The entered text will be interpreted as a URL, and used as a hyperlink.','return unserialize(\"a:6:{i:0;a:1:{i:0;a:5:{i:0;s:37:\\\"string_attach_4f66173b64d630.34218582\\\";i:1;a:0:{}i:2;i:1;i:3;s:0:\\\"\\\";i:4;s:0:\\\"\\\";}}i:1;a:0:{}i:2;s:10:\\\":container\\\";i:3;N;i:4;N;i:5;s:137:\\\"\\$TPL_FUNCS[\'string_attach_4f66173b64d630.34218582\']=\\\"echo \\\\\\\"The entered text will be interpreted as a URL, and used as a hyperlink.\\\\\\\";\\\";\\n\\\";}\");\n','0','1'),
 ('176','EN','3','Description','','0','1'),
 ('177','EN','3','A concise description for this.','return unserialize(\"a:6:{i:0;a:1:{i:0;a:5:{i:0;s:37:\\\"string_attach_4f66173b65aa68.13458241\\\";i:1;a:0:{}i:2;i:1;i:3;s:0:\\\"\\\";i:4;s:0:\\\"\\\";}}i:1;a:0:{}i:2;s:10:\\\":container\\\";i:3;N;i:4;N;i:5;s:97:\\\"\\$TPL_FUNCS[\'string_attach_4f66173b65aa68.13458241\']=\\\"echo \\\\\\\"A concise description for this.\\\\\\\";\\\";\\n\\\";}\");\n','0','1'),
 ('178','EN','3','Author','','0','1'),
 ('179','EN','3','The author of this entry.','return unserialize(\"a:6:{i:0;a:1:{i:0;a:5:{i:0;s:37:\\\"string_attach_4f66173b6618e3.69525845\\\";i:1;a:0:{}i:2;i:1;i:3;s:0:\\\"\\\";i:4;s:0:\\\"\\\";}}i:1;a:0:{}i:2;s:10:\\\":container\\\";i:3;N;i:4;N;i:5;s:91:\\\"\\$TPL_FUNCS[\'string_attach_4f66173b6618e3.69525845\']=\\\"echo \\\\\\\"The author of this entry.\\\\\\\";\\\";\\n\\\";}\");\n','0','1'),
 ('180','EN','1','Modifications','','0','1'),
 ('181','EN','1','','','0','1'),
 ('182','EN','2','Hosted sites','','0','1'),
 ('183','EN','3','These are sites hosted by us.','return unserialize(\"a:6:{i:0;a:1:{i:0;a:5:{i:0;s:37:\\\"string_attach_4f66173b68e007.61335760\\\";i:1;a:0:{}i:2;i:1;i:3;s:0:\\\"\\\";i:4;s:0:\\\"\\\";}}i:1;a:0:{}i:2;s:10:\\\":container\\\";i:3;N;i:4;N;i:5;s:95:\\\"\\$TPL_FUNCS[\'string_attach_4f66173b68e007.61335760\']=\\\"echo \\\\\\\"These are sites hosted by us.\\\\\\\";\\\";\\n\\\";}\");\n','0','1'),
 ('184','EN','2','Name','','0','1'),
 ('185','EN','3','The name for this.','return unserialize(\"a:6:{i:0;a:1:{i:0;a:5:{i:0;s:37:\\\"string_attach_4f66173b69e3e4.10164868\\\";i:1;a:0:{}i:2;i:1;i:3;s:0:\\\"\\\";i:4;s:0:\\\"\\\";}}i:1;a:0:{}i:2;s:10:\\\":container\\\";i:3;N;i:4;N;i:5;s:84:\\\"\\$TPL_FUNCS[\'string_attach_4f66173b69e3e4.10164868\']=\\\"echo \\\\\\\"The name for this.\\\\\\\";\\\";\\n\\\";}\");\n','0','1'),
 ('186','EN','2','URL','','0','1'),
 ('187','EN','3','The entered text will be interpreted as a URL, and used as a hyperlink.','return unserialize(\"a:6:{i:0;a:1:{i:0;a:5:{i:0;s:37:\\\"string_attach_4f66173b6a82e6.31704119\\\";i:1;a:0:{}i:2;i:1;i:3;s:0:\\\"\\\";i:4;s:0:\\\"\\\";}}i:1;a:0:{}i:2;s:10:\\\":container\\\";i:3;N;i:4;N;i:5;s:137:\\\"\\$TPL_FUNCS[\'string_attach_4f66173b6a82e6.31704119\']=\\\"echo \\\\\\\"The entered text will be interpreted as a URL, and used as a hyperlink.\\\\\\\";\\\";\\n\\\";}\");\n','0','1'),
 ('188','EN','2','Description','','0','1'),
 ('189','EN','3','A concise description for this.','return unserialize(\"a:6:{i:0;a:1:{i:0;a:5:{i:0;s:37:\\\"string_attach_4f66173b6af4d7.75112088\\\";i:1;a:0:{}i:2;i:1;i:3;s:0:\\\"\\\";i:4;s:0:\\\"\\\";}}i:1;a:0:{}i:2;s:10:\\\":container\\\";i:3;N;i:4;N;i:5;s:97:\\\"\\$TPL_FUNCS[\'string_attach_4f66173b6af4d7.75112088\']=\\\"echo \\\\\\\"A concise description for this.\\\\\\\";\\\";\\n\\\";}\");\n','0','1'),
 ('190','EN','2','Hosted sites','','0','1'),
 ('191','EN','3','These are sites hosted by us.','return unserialize(\"a:6:{i:0;a:1:{i:0;a:5:{i:0;s:37:\\\"string_attach_4f66173b6b73d2.78912326\\\";i:1;a:0:{}i:2;i:1;i:3;s:0:\\\"\\\";i:4;s:0:\\\"\\\";}}i:1;a:0:{}i:2;s:10:\\\":container\\\";i:3;N;i:4;N;i:5;s:95:\\\"\\$TPL_FUNCS[\'string_attach_4f66173b6b73d2.78912326\']=\\\"echo \\\\\\\"These are sites hosted by us.\\\\\\\";\\\";\\n\\\";}\");\n','0','1'),
 ('192','EN','1','Hosted sites','','0','1'),
 ('193','EN','1','','','0','1'),
 ('194','EN','2','Links','','0','1'),
 ('195','EN','3','Warning: these sites are outside our control.','return unserialize(\"a:6:{i:0;a:1:{i:0;a:5:{i:0;s:37:\\\"string_attach_4f66173b6ee670.98545948\\\";i:1;a:0:{}i:2;i:1;i:3;s:0:\\\"\\\";i:4;s:0:\\\"\\\";}}i:1;a:0:{}i:2;s:10:\\\":container\\\";i:3;N;i:4;N;i:5;s:111:\\\"\\$TPL_FUNCS[\'string_attach_4f66173b6ee670.98545948\']=\\\"echo \\\\\\\"Warning: these sites are outside our control.\\\\\\\";\\\";\\n\\\";}\");\n','0','1'),
 ('196','EN','1','Links','','0','1'),
 ('197','EN','3','','return unserialize(\"a:6:{i:0;a:1:{i:0;a:5:{i:0;s:37:\\\"string_attach_4f66173b6f5d61.42116410\\\";i:1;a:0:{}i:2;i:1;i:3;s:0:\\\"\\\";i:4;s:0:\\\"\\\";}}i:1;a:0:{}i:2;s:10:\\\":container\\\";i:3;N;i:4;N;i:5;s:66:\\\"\\$TPL_FUNCS[\'string_attach_4f66173b6f5d61.42116410\']=\\\"echo \\\\\\\"\\\\\\\";\\\";\\n\\\";}\");\n','0','1'),
 ('198','EN','2','Title','','0','1'),
 ('199','EN','3','A concise title for this.','return unserialize(\"a:6:{i:0;a:1:{i:0;a:5:{i:0;s:37:\\\"string_attach_4f66173b6fc604.03792929\\\";i:1;a:0:{}i:2;i:1;i:3;s:0:\\\"\\\";i:4;s:0:\\\"\\\";}}i:1;a:0:{}i:2;s:10:\\\":container\\\";i:3;N;i:4;N;i:5;s:91:\\\"\\$TPL_FUNCS[\'string_attach_4f66173b6fc604.03792929\']=\\\"echo \\\\\\\"A concise title for this.\\\\\\\";\\\";\\n\\\";}\");\n','0','1'),
 ('200','EN','2','URL','','0','1'),
 ('201','EN','3','The entered text will be interpreted as a URL, and used as a hyperlink.','return unserialize(\"a:6:{i:0;a:1:{i:0;a:5:{i:0;s:37:\\\"string_attach_4f66173b712e33.23645043\\\";i:1;a:0:{}i:2;i:1;i:3;s:0:\\\"\\\";i:4;s:0:\\\"\\\";}}i:1;a:0:{}i:2;s:10:\\\":container\\\";i:3;N;i:4;N;i:5;s:137:\\\"\\$TPL_FUNCS[\'string_attach_4f66173b712e33.23645043\']=\\\"echo \\\\\\\"The entered text will be interpreted as a URL, and used as a hyperlink.\\\\\\\";\\\";\\n\\\";}\");\n','0','1'),
 ('202','EN','2','Description','','0','1'),
 ('203','EN','3','A concise description for this.','return unserialize(\"a:6:{i:0;a:1:{i:0;a:5:{i:0;s:37:\\\"string_attach_4f66173b722fa1.42426233\\\";i:1;a:0:{}i:2;i:1;i:3;s:0:\\\"\\\";i:4;s:0:\\\"\\\";}}i:1;a:0:{}i:2;s:10:\\\":container\\\";i:3;N;i:4;N;i:5;s:97:\\\"\\$TPL_FUNCS[\'string_attach_4f66173b722fa1.42426233\']=\\\"echo \\\\\\\"A concise description for this.\\\\\\\";\\\";\\n\\\";}\");\n','0','1'),
 ('204','EN','1','Links','','0','1'),
 ('205','EN','1','','','0','1'),
 ('206','EN','2','Frequently Asked Questions','','0','1'),
 ('207','EN','3','If you have questions that are not covered in our FAQ, please post them in an appropriate forum.','return unserialize(\"a:6:{i:0;a:1:{i:0;a:5:{i:0;s:37:\\\"string_attach_4f66173b76d7c5.75797260\\\";i:1;a:0:{}i:2;i:1;i:3;s:0:\\\"\\\";i:4;s:0:\\\"\\\";}}i:1;a:0:{}i:2;s:10:\\\":container\\\";i:3;N;i:4;N;i:5;s:162:\\\"\\$TPL_FUNCS[\'string_attach_4f66173b76d7c5.75797260\']=\\\"echo \\\\\\\"If you have questions that are not covered in our FAQ, please post them in an appropriate forum.\\\\\\\";\\\";\\n\\\";}\");\n','0','1'),
 ('208','EN','2','Question','','0','1'),
 ('209','EN','3','The question asked.','return unserialize(\"a:6:{i:0;a:1:{i:0;a:5:{i:0;s:37:\\\"string_attach_4f66173b77e0a2.40903955\\\";i:1;a:0:{}i:2;i:1;i:3;s:0:\\\"\\\";i:4;s:0:\\\"\\\";}}i:1;a:0:{}i:2;s:10:\\\":container\\\";i:3;N;i:4;N;i:5;s:85:\\\"\\$TPL_FUNCS[\'string_attach_4f66173b77e0a2.40903955\']=\\\"echo \\\\\\\"The question asked.\\\\\\\";\\\";\\n\\\";}\");\n','0','1'),
 ('210','EN','2','Answer','','0','1'),
 ('211','EN','3','The answer(s) to the question.','return unserialize(\"a:6:{i:0;a:1:{i:0;a:5:{i:0;s:37:\\\"string_attach_4f66173b788f17.27139578\\\";i:1;a:0:{}i:2;i:1;i:3;s:0:\\\"\\\";i:4;s:0:\\\"\\\";}}i:1;a:0:{}i:2;s:10:\\\":container\\\";i:3;N;i:4;N;i:5;s:96:\\\"\\$TPL_FUNCS[\'string_attach_4f66173b788f17.27139578\']=\\\"echo \\\\\\\"The answer(s) to the question.\\\\\\\";\\\";\\n\\\";}\");\n','0','1'),
 ('212','EN','2','Order','','0','1'),
 ('213','EN','3','The order priority this entry has in the category.','return unserialize(\"a:6:{i:0;a:1:{i:0;a:5:{i:0;s:37:\\\"string_attach_4f66173b795283.69179764\\\";i:1;a:0:{}i:2;i:1;i:3;s:0:\\\"\\\";i:4;s:0:\\\"\\\";}}i:1;a:0:{}i:2;s:10:\\\":container\\\";i:3;N;i:4;N;i:5;s:116:\\\"\\$TPL_FUNCS[\'string_attach_4f66173b795283.69179764\']=\\\"echo \\\\\\\"The order priority this entry has in the category.\\\\\\\";\\\";\\n\\\";}\");\n','0','1'),
 ('214','EN','2','Frequently Asked Questions','','0','1'),
 ('215','EN','3','If you have questions that are not covered in our FAQ, please post them in an appropriate forum.','return unserialize(\"a:6:{i:0;a:1:{i:0;a:5:{i:0;s:37:\\\"string_attach_4f66173b7a35c5.90852878\\\";i:1;a:0:{}i:2;i:1;i:3;s:0:\\\"\\\";i:4;s:0:\\\"\\\";}}i:1;a:0:{}i:2;s:10:\\\":container\\\";i:3;N;i:4;N;i:5;s:162:\\\"\\$TPL_FUNCS[\'string_attach_4f66173b7a35c5.90852878\']=\\\"echo \\\\\\\"If you have questions that are not covered in our FAQ, please post them in an appropriate forum.\\\\\\\";\\\";\\n\\\";}\");\n','0','1'),
 ('216','EN','1','Frequently Asked Questions','','0','1'),
 ('217','EN','1','','','0','1'),
 ('218','EN','2','Contacts','','0','1'),
 ('219','EN','3','A contacts/address-book.','return unserialize(\"a:6:{i:0;a:1:{i:0;a:5:{i:0;s:37:\\\"string_attach_4f66173b7d4183.48168792\\\";i:1;a:0:{}i:2;i:1;i:3;s:0:\\\"\\\";i:4;s:0:\\\"\\\";}}i:1;a:0:{}i:2;s:10:\\\":container\\\";i:3;N;i:4;N;i:5;s:90:\\\"\\$TPL_FUNCS[\'string_attach_4f66173b7d4183.48168792\']=\\\"echo \\\\\\\"A contacts/address-book.\\\\\\\";\\\";\\n\\\";}\");\n','0','1'),
 ('220','EN','3','Forename','','0','1'),
 ('221','EN','2','','','0','1'),
 ('222','EN','3','Surname','','0','1'),
 ('223','EN','2','','','0','1'),
 ('224','EN','3','E-mail address','','0','1'),
 ('225','EN','2','','','0','1'),
 ('226','EN','3','Company','','0','1'),
 ('227','EN','2','','','0','1'),
 ('228','EN','3','Home address','','0','1'),
 ('229','EN','2','','','0','1'),
 ('230','EN','3','City','','0','1'),
 ('231','EN','2','','','0','1'),
 ('232','EN','3','Home phone number','','0','1'),
 ('233','EN','2','','','0','1'),
 ('234','EN','3','Work phone number','','0','1'),
 ('235','EN','2','','','0','1'),
 ('236','EN','3','Homepage','','0','1'),
 ('237','EN','2','','','0','1'),
 ('238','EN','3','Instant messenger handle','','0','1'),
 ('239','EN','2','','','0','1'),
 ('240','EN','3','Events relating to them','','0','1'),
 ('241','EN','2','','','0','1'),
 ('242','EN','3','Notes','','0','1'),
 ('243','EN','2','','','0','1'),
 ('244','EN','3','Photo','','0','1'),
 ('245','EN','2','','','0','1'),
 ('246','EN','2','Contacts','','0','1'),
 ('247','EN','3','','return unserialize(\"a:6:{i:0;a:1:{i:0;a:5:{i:0;s:37:\\\"string_attach_4f66173b82fbb3.25630389\\\";i:1;a:0:{}i:2;i:1;i:3;s:0:\\\"\\\";i:4;s:0:\\\"\\\";}}i:1;a:0:{}i:2;s:10:\\\":container\\\";i:3;N;i:4;N;i:5;s:66:\\\"\\$TPL_FUNCS[\'string_attach_4f66173b82fbb3.25630389\']=\\\"echo \\\\\\\"\\\\\\\";\\\";\\n\\\";}\");\n','0','1'),
 ('248','EN','1','Contacts','','0','1'),
 ('249','EN','1','','','0','1'),
 ('250','EN','1','Super-member projects','','0','1'),
 ('251','EN','1','','','0','1'),
 ('252','EN','1','View','','0','1'),
 ('253','EN','1','This link is a shortcut: the menu will change','','0','1'),
 ('254','EN','1','Add','','0','1'),
 ('255','EN','1','This link is a shortcut: the menu will change','','0','1'),
 ('256','EN','2','Products','','0','1'),
 ('257','EN','2','These are products for sale from this website.','','0','1'),
 ('258','EN','1','Products home','','0','1'),
 ('259','EN','3','','return unserialize(\"a:6:{i:0;a:1:{i:0;a:5:{i:0;s:37:\\\"string_attach_4f66173bc8e707.15571232\\\";i:1;a:0:{}i:2;i:1;i:3;s:0:\\\"\\\";i:4;s:0:\\\"\\\";}}i:1;a:0:{}i:2;s:10:\\\":container\\\";i:3;N;i:4;N;i:5;s:66:\\\"\\$TPL_FUNCS[\'string_attach_4f66173bc8e707.15571232\']=\\\"echo \\\\\\\"\\\\\\\";\\\";\\n\\\";}\");\n','0','1'),
 ('260','EN','3','Product title','','0','1'),
 ('261','EN','3','A concise title for this.','return unserialize(\"a:6:{i:0;a:1:{i:0;a:5:{i:0;s:37:\\\"string_attach_4f66173bc93d05.51273006\\\";i:1;a:0:{}i:2;i:1;i:3;s:0:\\\"\\\";i:4;s:0:\\\"\\\";}}i:1;a:0:{}i:2;s:10:\\\":container\\\";i:3;N;i:4;N;i:5;s:91:\\\"\\$TPL_FUNCS[\'string_attach_4f66173bc93d05.51273006\']=\\\"echo \\\\\\\"A concise title for this.\\\\\\\";\\\";\\n\\\";}\");\n','0','1'),
 ('262','EN','3','Product code','','0','1'),
 ('263','EN','3','The codename for the product','return unserialize(\"a:6:{i:0;a:1:{i:0;a:5:{i:0;s:37:\\\"string_attach_4f66173bc9f430.17670927\\\";i:1;a:0:{}i:2;i:1;i:3;s:0:\\\"\\\";i:4;s:0:\\\"\\\";}}i:1;a:0:{}i:2;s:10:\\\":container\\\";i:3;N;i:4;N;i:5;s:94:\\\"\\$TPL_FUNCS[\'string_attach_4f66173bc9f430.17670927\']=\\\"echo \\\\\\\"The codename for the product\\\\\\\";\\\";\\n\\\";}\");\n','0','1'),
 ('264','EN','3','Net price','','0','1'),
 ('265','EN','3','The price, before tax is added, in the primary currency of this website.','return unserialize(\"a:6:{i:0;a:1:{i:0;a:5:{i:0;s:37:\\\"string_attach_4f66173bca96b5.82907382\\\";i:1;a:0:{}i:2;i:1;i:3;s:0:\\\"\\\";i:4;s:0:\\\"\\\";}}i:1;a:0:{}i:2;s:10:\\\":container\\\";i:3;N;i:4;N;i:5;s:138:\\\"\\$TPL_FUNCS[\'string_attach_4f66173bca96b5.82907382\']=\\\"echo \\\\\\\"The price, before tax is added, in the primary currency of this website.\\\\\\\";\\\";\\n\\\";}\");\n','0','1'),
 ('266','EN','3','Stock level','','0','1'),
 ('267','EN','3','The stock level of the product (leave blank if no stock counting is to be done).','return unserialize(\"a:6:{i:0;a:1:{i:0;a:5:{i:0;s:37:\\\"string_attach_4f66173bcb2a67.23116387\\\";i:1;a:0:{}i:2;i:1;i:3;s:0:\\\"\\\";i:4;s:0:\\\"\\\";}}i:1;a:0:{}i:2;s:10:\\\":container\\\";i:3;N;i:4;N;i:5;s:146:\\\"\\$TPL_FUNCS[\'string_attach_4f66173bcb2a67.23116387\']=\\\"echo \\\\\\\"The stock level of the product (leave blank if no stock counting is to be done).\\\\\\\";\\\";\\n\\\";}\");\n','0','1'),
 ('268','EN','3','Stock level warn-threshold','','0','1'),
 ('269','EN','3','Send out a notification to the staff if the stock goes below this level (leave blank if no stock counting is to be done).','return unserialize(\"a:6:{i:0;a:1:{i:0;a:5:{i:0;s:37:\\\"string_attach_4f66173bcba8f9.60490332\\\";i:1;a:0:{}i:2;i:1;i:3;s:0:\\\"\\\";i:4;s:0:\\\"\\\";}}i:1;a:0:{}i:2;s:10:\\\":container\\\";i:3;N;i:4;N;i:5;s:187:\\\"\\$TPL_FUNCS[\'string_attach_4f66173bcba8f9.60490332\']=\\\"echo \\\\\\\"Send out a notification to the staff if the stock goes below this level (leave blank if no stock counting is to be done).\\\\\\\";\\\";\\n\\\";}\");\n','0','1'),
 ('270','EN','3','Stock maintained','','0','1'),
 ('271','EN','3','Whether stock will be maintained. If the stock is not maintained then users will not be able to purchase it if the stock runs out.','return unserialize(\"a:6:{i:0;a:1:{i:0;a:5:{i:0;s:37:\\\"string_attach_4f66173bcc1627.19818783\\\";i:1;a:0:{}i:2;i:1;i:3;s:0:\\\"\\\";i:4;s:0:\\\"\\\";}}i:1;a:0:{}i:2;s:10:\\\":container\\\";i:3;N;i:4;N;i:5;s:196:\\\"\\$TPL_FUNCS[\'string_attach_4f66173bcc1627.19818783\']=\\\"echo \\\\\\\"Whether stock will be maintained. If the stock is not maintained then users will not be able to purchase it if the stock runs out.\\\\\\\";\\\";\\n\\\";}\");\n','0','1'),
 ('272','EN','3','Product tax rate','','0','1'),
 ('273','EN','3','The tax rates that products can be assigned.','return unserialize(\"a:6:{i:0;a:1:{i:0;a:5:{i:0;s:37:\\\"string_attach_4f66173bccb8a0.95610593\\\";i:1;a:0:{}i:2;i:1;i:3;s:0:\\\"\\\";i:4;s:0:\\\"\\\";}}i:1;a:0:{}i:2;s:10:\\\":container\\\";i:3;N;i:4;N;i:5;s:110:\\\"\\$TPL_FUNCS[\'string_attach_4f66173bccb8a0.95610593\']=\\\"echo \\\\\\\"The tax rates that products can be assigned.\\\\\\\";\\\";\\n\\\";}\");\n','0','1'),
 ('274','EN','3','Product image','','0','1'),
 ('275','EN','3','Upload an image of your product.','return unserialize(\"a:6:{i:0;a:1:{i:0;a:5:{i:0;s:37:\\\"string_attach_4f66173bcd3e48.31269639\\\";i:1;a:0:{}i:2;i:1;i:3;s:0:\\\"\\\";i:4;s:0:\\\"\\\";}}i:1;a:0:{}i:2;s:10:\\\":container\\\";i:3;N;i:4;N;i:5;s:98:\\\"\\$TPL_FUNCS[\'string_attach_4f66173bcd3e48.31269639\']=\\\"echo \\\\\\\"Upload an image of your product.\\\\\\\";\\\";\\n\\\";}\");\n','0','1'),
 ('276','EN','3','Product weight','','0','1'),
 ('277','EN','3','The weight, in whatever units are assumed by the shipping costs programmed-in to this website.','return unserialize(\"a:6:{i:0;a:1:{i:0;a:5:{i:0;s:37:\\\"string_attach_4f66173bcdb5a1.28918831\\\";i:1;a:0:{}i:2;i:1;i:3;s:0:\\\"\\\";i:4;s:0:\\\"\\\";}}i:1;a:0:{}i:2;s:10:\\\":container\\\";i:3;N;i:4;N;i:5;s:160:\\\"\\$TPL_FUNCS[\'string_attach_4f66173bcdb5a1.28918831\']=\\\"echo \\\\\\\"The weight, in whatever units are assumed by the shipping costs programmed-in to this website.\\\\\\\";\\\";\\n\\\";}\");\n','0','1'),
 ('278','EN','3','Product description','','0','1'),
 ('279','EN','3','A concise description for this.','return unserialize(\"a:6:{i:0;a:1:{i:0;a:5:{i:0;s:37:\\\"string_attach_4f66173bce2370.61104280\\\";i:1;a:0:{}i:2;i:1;i:3;s:0:\\\"\\\";i:4;s:0:\\\"\\\";}}i:1;a:0:{}i:2;s:10:\\\":container\\\";i:3;N;i:4;N;i:5;s:97:\\\"\\$TPL_FUNCS[\'string_attach_4f66173bce2370.61104280\']=\\\"echo \\\\\\\"A concise description for this.\\\\\\\";\\\";\\n\\\";}\");\n','0','1'),
 ('280','EN','1','Products','','0','1'),
 ('281','EN','1','','','0','1'),
 ('282','EN','1','CEDI home','','0','1'),
 ('283','EN','2','','return unserialize(\"a:6:{i:0;a:1:{i:0;a:5:{i:0;s:37:\\\"string_attach_4f66173ee958f4.36227935\\\";i:1;a:0:{}i:2;i:1;i:3;s:0:\\\"\\\";i:4;s:0:\\\"\\\";}}i:1;a:0:{}i:2;s:10:\\\":container\\\";i:3;N;i:4;N;i:5;s:66:\\\"\\$TPL_FUNCS[\'string_attach_4f66173ee958f4.36227935\']=\\\"echo \\\\\\\"\\\\\\\";\\\";\\n\\\";}\");\n','0','1'),
 ('284','EN','2','ocp_points_gained_seedy','','0','1'),
 ('285','EN','2','','','0','1'),
 ('286','EN','1','CEDI','','0','1'),
 ('287','EN','1','','','0','1'),
 ('288','EN','1','CEDI','','0','1'),
 ('289','EN','1','','','0','1'),
 ('290','EN','1','Random page','','0','1'),
 ('291','EN','1','','','0','1'),
 ('292','EN','1','CEDI change-log','','0','1'),
 ('293','EN','1','','','0','1'),
 ('294','EN','1','Tree','','0','1'),
 ('295','EN','1','','','0','1'),
 ('296','EN','2','','','0','1'),
 ('297','EN','2','ocp_points_gained_chat','','0','1'),
 ('298','EN','2','','','0','1'),
 ('299','EN','1','Chat lobby','','0','1'),
 ('300','EN','1','','','0','1'),
 ('301','EN','2','Downloads home','','0','1'),
 ('302','EN','3','','return unserialize(\"a:6:{i:0;a:1:{i:0;a:5:{i:0;s:37:\\\"string_attach_4f6617432e72a7.59056797\\\";i:1;a:0:{}i:2;i:1;i:3;s:0:\\\"\\\";i:4;s:0:\\\"\\\";}}i:1;a:0:{}i:2;s:10:\\\":container\\\";i:3;N;i:4;N;i:5;s:66:\\\"\\$TPL_FUNCS[\'string_attach_4f6617432e72a7.59056797\']=\\\"echo \\\\\\\"\\\\\\\";\\\";\\n\\\";}\");\n','0','1'),
 ('303','EN','1','Downloads','','0','1'),
 ('304','EN','1','','','0','1'),
 ('305','EN','1','Galleries','','0','1'),
 ('306','EN','1','','','0','1'),
 ('307','EN','2','','return unserialize(\"a:6:{i:0;a:1:{i:0;a:5:{i:0;s:37:\\\"string_attach_4f66174840a251.76028862\\\";i:1;a:0:{}i:2;i:1;i:3;s:0:\\\"\\\";i:4;s:0:\\\"\\\";}}i:1;a:0:{}i:2;s:10:\\\":container\\\";i:3;N;i:4;N;i:5;s:66:\\\"\\$TPL_FUNCS[\'string_attach_4f66174840a251.76028862\']=\\\"echo \\\\\\\"\\\\\\\";\\\";\\n\\\";}\");\n','0','1'),
 ('308','EN','2','','return unserialize(\"a:6:{i:0;a:1:{i:0;a:5:{i:0;s:37:\\\"string_attach_4f66174840cc68.83939268\\\";i:1;a:0:{}i:2;i:1;i:3;s:0:\\\"\\\";i:4;s:0:\\\"\\\";}}i:1;a:0:{}i:2;s:10:\\\":container\\\";i:3;N;i:4;N;i:5;s:66:\\\"\\$TPL_FUNCS[\'string_attach_4f66174840cc68.83939268\']=\\\"echo \\\\\\\"\\\\\\\";\\\";\\n\\\";}\");\n','0','1'),
 ('309','EN','1','Galleries home','','0','1'),
 ('310','EN','2','home,galleries','','0','1'),
 ('311','EN','2','','','0','1'),
 ('312','EN','2','General','','0','1'),
 ('313','EN','2','Technology','','0','1'),
 ('314','EN','2','Difficulties','','0','1'),
 ('315','EN','2','Community','','0','1'),
 ('316','EN','2','Entertainment','','0','1'),
 ('317','EN','2','Business','','0','1'),
 ('318','EN','2','Art','','0','1'),
 ('319','EN','2','General','','0','1'),
 ('320','EN','2','General messages will be sent out in this newsletter.','','0','1'),
 ('321','EN','1','Point-store','','0','1'),
 ('322','EN','1','','','0','1'),
 ('323','EN','2','ocp_currency','','0','1'),
 ('324','EN','2','','','0','1'),
 ('325','EN','2','ocp_payment_cardholder_name','','0','1'),
 ('326','EN','2','','','0','1'),
 ('327','EN','2','ocp_payment_type','','0','1'),
 ('328','EN','2','','','0','1'),
 ('329','EN','2','ocp_payment_card_number','','0','1'),
 ('330','EN','2','','','0','1'),
 ('331','EN','2','ocp_payment_card_start_date','','0','1'),
 ('332','EN','2','','','0','1'),
 ('333','EN','2','ocp_payment_card_expiry_date','','0','1'),
 ('334','EN','2','','','0','1'),
 ('335','EN','2','ocp_payment_card_issue_number','','0','1'),
 ('336','EN','2','','','0','1'),
 ('337','EN','2','ocp_payment_card_cv2','','0','1'),
 ('338','EN','2','','','0','1'),
 ('339','EN','1','Purchasing','','0','1'),
 ('340','EN','1','','','0','1'),
 ('341','EN','1','Invoices','','0','1'),
 ('342','EN','1','','','0','1'),
 ('343','EN','1','Subscriptions','','0','1'),
 ('344','EN','1','','','0','1'),
 ('345','EN','1','Quizzes','','0','1'),
 ('346','EN','1','','','0','1'),
 ('347','EN','1','Search','','0','1'),
 ('348','EN','1','This link is a shortcut: the menu will change','','0','1'),
 ('349','EN','1','Orders','','0','1'),
 ('350','EN','1','','','0','1'),
 ('351','EN','2','ocp_firstname','','0','1'),
 ('352','EN','2','','','0','1'),
 ('353','EN','2','ocp_lastname','','0','1'),
 ('354','EN','2','','','0','1'),
 ('355','EN','2','ocp_building_name_or_number','','0','1'),
 ('356','EN','2','','','0','1'),
 ('357','EN','2','ocp_city','','0','1'),
 ('358','EN','2','','','0','1'),
 ('359','EN','2','ocp_state','','0','1'),
 ('360','EN','2','','','0','1'),
 ('361','EN','2','ocp_post_code','','0','1'),
 ('362','EN','2','','','0','1'),
 ('363','EN','2','ocp_country','','0','1'),
 ('364','EN','2','','','0','1'),
 ('365','EN','1','Staff','','0','1'),
 ('366','EN','1','','','0','1'),
 ('367','EN','1','Other','','0','1'),
 ('368','EN','1','Complaint','','0','1'),
 ('369','EN','1','Support tickets','','0','1'),
 ('370','EN','1','','','0','1'),
 ('371','EN','1','Forum home','','0','1'),
 ('372','EN','1','','','0','1'),
 ('373','EN','1','Private Topics','','0','1'),
 ('374','EN','1','','','0','1'),
 ('375','EN','1','Posts since last visit','','0','1'),
 ('376','EN','1','','','0','1'),
 ('377','EN','1','Topics with unread posts','','0','1'),
 ('378','EN','1','','','0','1'),
 ('379','EN','1','Recently-read topics','','0','1'),
 ('380','EN','1','','','0','1'),
 ('381','EN','1','File/Media library','','0','1'),
 ('382','EN','1','','','0','1'),
 ('383','EN','1','Recommend site','','0','1'),
 ('384','EN','1','','','0','1'),
 ('385','EN','1','Super-members','','0','1'),
 ('386','EN','1','','','0','1'),
 ('387','EN','2','ocp_points_used','','0','1'),
 ('388','EN','2','','','0','1'),
 ('389','EN','2','ocp_gift_points_used','','0','1'),
 ('390','EN','2','','','0','1'),
 ('391','EN','2','ocp_points_gained_given','','0','1'),
 ('392','EN','2','','','0','1'),
 ('393','EN','2','ocp_points_gained_rating','','0','1'),
 ('394','EN','2','','','0','1'),
 ('395','EN','2','ocp_points_gained_voting','','0','1'),
 ('396','EN','2','','','0','1'),
 ('397','EN','2','ocp_sites','','0','1'),
 ('398','EN','2','','','0','1'),
 ('399','EN','2','ocp_role','','0','1'),
 ('400','EN','2','','','0','1'),
 ('401','EN','2','ocp_fullname','','0','1'),
 ('402','EN','2','','','0','1');

DROP TABLE IF EXISTS `ocp_translate_history`;

CREATE TABLE `ocp_translate_history` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `lang_id` int(11) NOT NULL,
  `language` varchar(5) NOT NULL,
  `text_original` longtext NOT NULL,
  `broken` tinyint(1) NOT NULL,
  `action_member` int(11) NOT NULL,
  `action_time` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`,`language`)
) ENGINE=MyISAM CHARACTER SET=latin1;


DROP TABLE IF EXISTS `ocp_tutorial_links`;

CREATE TABLE `ocp_tutorial_links` (
  `the_name` varchar(80) NOT NULL,
  `the_value` longtext NOT NULL,
  PRIMARY KEY (`the_name`)
) ENGINE=MyISAM CHARACTER SET=latin1;


DROP TABLE IF EXISTS `ocp_url_id_monikers`;

CREATE TABLE `ocp_url_id_monikers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `m_resource_page` varchar(80) NOT NULL,
  `m_resource_type` varchar(80) NOT NULL,
  `m_resource_id` varchar(80) NOT NULL,
  `m_moniker` varchar(255) NOT NULL,
  `m_deprecated` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `uim_pagelink` (`m_resource_page`,`m_resource_type`,`m_resource_id`),
  KEY `uim_moniker` (`m_moniker`)
) ENGINE=MyISAM CHARACTER SET=latin1;


DROP TABLE IF EXISTS `ocp_url_title_cache`;

CREATE TABLE `ocp_url_title_cache` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `t_url` varchar(255) NOT NULL,
  `t_title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM CHARACTER SET=latin1;


DROP TABLE IF EXISTS `ocp_usersonline_track`;

CREATE TABLE `ocp_usersonline_track` (
  `date_and_time` int(10) unsigned NOT NULL,
  `peak` int(11) NOT NULL,
  PRIMARY KEY (`date_and_time`),
  KEY `peak_track` (`peak`)
) ENGINE=MyISAM CHARACTER SET=latin1;


DROP TABLE IF EXISTS `ocp_usersubmitban_ip`;

CREATE TABLE `ocp_usersubmitban_ip` (
  `ip` varchar(40) NOT NULL,
  `i_descrip` longtext NOT NULL,
  PRIMARY KEY (`ip`)
) ENGINE=MyISAM CHARACTER SET=latin1;


DROP TABLE IF EXISTS `ocp_usersubmitban_member`;

CREATE TABLE `ocp_usersubmitban_member` (
  `the_member` int(11) NOT NULL,
  PRIMARY KEY (`the_member`)
) ENGINE=MyISAM CHARACTER SET=latin1;


DROP TABLE IF EXISTS `ocp_validated_once`;

CREATE TABLE `ocp_validated_once` (
  `hash` varchar(33) NOT NULL,
  PRIMARY KEY (`hash`)
) ENGINE=MyISAM CHARACTER SET=latin1;


DROP TABLE IF EXISTS `ocp_values`;

CREATE TABLE `ocp_values` (
  `the_name` varchar(80) NOT NULL,
  `the_value` varchar(80) NOT NULL,
  `date_and_time` int(10) unsigned NOT NULL,
  PRIMARY KEY (`the_name`),
  KEY `date_and_time` (`date_and_time`)
) ENGINE=MyISAM CHARACTER SET=latin1;

insert into `ocp_values` values('version','8.1','1332090660'),
 ('ocf_version','8.1','1332090660');

DROP TABLE IF EXISTS `ocp_video_transcoding`;

CREATE TABLE `ocp_video_transcoding` (
  `t_id` varchar(80) NOT NULL,
  `t_error` longtext NOT NULL,
  `t_url` varchar(255) NOT NULL,
  `t_table` varchar(80) NOT NULL,
  `t_url_field` varchar(80) NOT NULL,
  `t_orig_filename_field` varchar(80) NOT NULL,
  `t_width_field` varchar(80) NOT NULL,
  `t_height_field` varchar(80) NOT NULL,
  `t_output_filename` varchar(80) NOT NULL,
  PRIMARY KEY (`t_id`)
) ENGINE=MyISAM CHARACTER SET=latin1;


DROP TABLE IF EXISTS `ocp_videos`;

CREATE TABLE `ocp_videos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cat` varchar(80) NOT NULL,
  `url` varchar(255) NOT NULL,
  `thumb_url` varchar(255) NOT NULL,
  `comments` int(10) unsigned NOT NULL,
  `allow_rating` tinyint(1) NOT NULL,
  `allow_comments` tinyint(4) NOT NULL,
  `allow_trackbacks` tinyint(1) NOT NULL,
  `notes` longtext NOT NULL,
  `submitter` int(11) NOT NULL,
  `validated` tinyint(1) NOT NULL,
  `add_date` int(10) unsigned NOT NULL,
  `edit_date` int(10) unsigned DEFAULT NULL,
  `video_views` int(11) NOT NULL,
  `video_width` int(11) NOT NULL,
  `video_height` int(11) NOT NULL,
  `video_length` int(11) NOT NULL,
  `title` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `video_views` (`video_views`),
  KEY `vs` (`submitter`),
  KEY `v_validated` (`validated`),
  KEY `category_list` (`cat`),
  KEY `vadd_date` (`add_date`),
  KEY `ftjoin_vcomments` (`comments`)
) ENGINE=MyISAM CHARACTER SET=latin1;


DROP TABLE IF EXISTS `ocp_wordfilter`;

CREATE TABLE `ocp_wordfilter` (
  `word` varchar(255) NOT NULL,
  `w_replacement` varchar(255) NOT NULL,
  `w_substr` tinyint(1) NOT NULL,
  PRIMARY KEY (`word`,`w_substr`)
) ENGINE=MyISAM CHARACTER SET=latin1;

insert into `ocp_wordfilter` values('arsehole','','0'),
 ('asshole','','0'),
 ('arse','','0'),
 ('cock','','0'),
 ('cocked','','0'),
 ('cocksucker','','0'),
 ('crap','','0'),
 ('cunt','','0'),
 ('cum','','0'),
 ('bastard','','0'),
 ('bitch','','0'),
 ('blowjob','','0'),
 ('bollocks','','0'),
 ('bondage','','0'),
 ('bugger','','0'),
 ('buggery','','0'),
 ('dickhead','','0'),
 ('fuck','','0'),
 ('fucked','','0'),
 ('fucking','','0'),
 ('fucker','','0'),
 ('gayboy','','0'),
 ('motherfucker','','0'),
 ('nigger','','0'),
 ('piss','','0'),
 ('pissed','','0'),
 ('puffter','','0'),
 ('pussy','','0'),
 ('shag','','0'),
 ('shagged','','0'),
 ('shat','','0'),
 ('shit','','0'),
 ('slut','','0'),
 ('twat','','0'),
 ('wank','','0'),
 ('wanker','','0'),
 ('whore','','0');

DROP TABLE IF EXISTS `ocp_zones`;

CREATE TABLE `ocp_zones` (
  `zone_name` varchar(80) NOT NULL,
  `zone_title` int(10) unsigned NOT NULL,
  `zone_default_page` varchar(80) NOT NULL,
  `zone_header_text` int(10) unsigned NOT NULL,
  `zone_theme` varchar(80) NOT NULL,
  `zone_wide` tinyint(1) DEFAULT NULL,
  `zone_require_session` tinyint(1) NOT NULL,
  `zone_displayed_in_menu` tinyint(1) NOT NULL,
  PRIMARY KEY (`zone_name`)
) ENGINE=MyISAM CHARACTER SET=latin1;

insert into `ocp_zones` values('','7','start','1','-1','0','0','0'),
 ('adminzone','8','start','2','default','0','1','1'),
 ('site','9','start','4','-1','0','0','1'),
 ('collaboration','10','start','3','-1','0','0','1'),
 ('cms','11','cms','5','default','0','1','1'),
 ('forum','13','forumview','12','-1',null,'0','1');

DROP TABLE IF EXISTS `ocp_failedlogins`;

CREATE TABLE `ocp_failedlogins` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `failed_account` varchar(80) NOT NULL,
  `date_and_time` int(10) unsigned NOT NULL,
  `ip` varchar(40) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM CHARACTER SET=latin1;
