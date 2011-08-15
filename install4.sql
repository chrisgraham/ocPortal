DROP TABLE IF EXISTS `ocp7_menu_items`;

CREATE TABLE `ocp7_menu_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `i_menu` varchar(80) COLLATE latin1_bin NOT NULL,
  `i_order` int(11) NOT NULL,
  `i_parent` int(11) DEFAULT NULL,
  `i_caption` int(10) unsigned NOT NULL,
  `i_caption_long` int(10) unsigned NOT NULL,
  `i_url` varchar(255) COLLATE latin1_bin NOT NULL,
  `i_check_permissions` tinyint(1) NOT NULL,
  `i_expanded` tinyint(1) NOT NULL,
  `i_new_window` tinyint(1) NOT NULL,
  `i_page_only` varchar(80) COLLATE latin1_bin NOT NULL,
  `i_theme_img_code` varchar(80) COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`id`),
  KEY `menu_extraction` (`i_menu`)
) ENGINE=MyISAM AUTO_INCREMENT=84;

insert into `ocp7_menu_items` values('1','root_website','0',null,'89','90',':','0','0','0','',''),
 ('2','root_website','1',null,'91','92','_SEARCH:rules','0','0','0','',''),
 ('3','main_features','2',null,'93','94','_SELF:','0','0','0','',''),
 ('4','main_features','3',null,'95','96','_SEARCH:help','0','0','0','',''),
 ('5','main_features','4',null,'97','98','_SEARCH:rules','0','0','0','',''),
 ('6','main_community','5',null,'99','100','_SEARCH:members:type=misc','0','0','0','',''),
 ('7','main_community','6',null,'101','102','_SEARCH:groups:type=misc','0','0','0','',''),
 ('8','member_features','7',null,'103','104','_SEARCH:join:type=misc','1','0','0','',''),
 ('9','member_features','8',null,'105','106','_SEARCH:lostpassword:type=misc','0','0','0','',''),
 ('10','collab_website','9',null,'107','108','collaboration:','0','0','0','',''),
 ('11','collab_website','10',null,'109','110','collaboration:about','0','0','0','',''),
 ('12','pc_features','11',null,'111','112','_SEARCH:myhome:id={$USER_OVERIDE}','0','0','0','',''),
 ('13','pc_features','12',null,'113','114','_SEARCH:members:type=view:id={$USER_OVERIDE}','0','0','0','',''),
 ('14','pc_edit','13',null,'115','116','_SEARCH:editprofile:type=misc:id={$USER_OVERIDE}','0','0','0','',''),
 ('15','pc_edit','14',null,'117','118','_SEARCH:editavatar:type=misc:id={$USER_OVERIDE}','0','0','0','',''),
 ('16','pc_edit','15',null,'119','120','_SEARCH:editphoto:type=misc:id={$USER_OVERIDE}','0','0','0','',''),
 ('17','pc_edit','16',null,'121','122','_SEARCH:editsignature:type=misc:id={$USER_OVERIDE}','0','0','0','',''),
 ('18','pc_edit','17',null,'123','124','_SEARCH:edittitle:type=misc:id={$USER_OVERIDE}','0','0','0','',''),
 ('19','pc_edit','18',null,'125','126','_SEARCH:delete:type=misc:id={$USER_OVERIDE}','0','0','0','',''),
 ('20','forum_features','19',null,'127','128','_SEARCH:rules','0','0','0','',''),
 ('21','forum_features','20',null,'129','130','_SEARCH:members:type=misc','0','0','0','',''),
 ('22','forum_personal','21',null,'131','132','_SEARCH:members:type=view','0','0','0','',''),
 ('23','forum_personal','22',null,'133','134','_SEARCH:editprofile:type=misc','0','0','0','',''),
 ('24','forum_personal','23',null,'135','136','_SEARCH:editavatar:type=misc','0','0','0','',''),
 ('25','forum_personal','24',null,'137','138','_SEARCH:editphoto:type=misc','0','0','0','',''),
 ('26','forum_personal','25',null,'139','140','_SEARCH:editsignature:type=misc','0','0','0','',''),
 ('27','forum_personal','26',null,'141','142','_SEARCH:edittitle:type=misc','0','0','0','',''),
 ('28','zone_menu','27',null,'143','144','site:','1','0','0','',''),
 ('29','zone_menu','28',null,'145','146','forum:forumview','1','0','0','',''),
 ('30','zone_menu','29',null,'147','148','personalzone:myhome','1','0','0','',''),
 ('31','zone_menu','30',null,'149','150','collaboration:','1','0','0','',''),
 ('32','zone_menu','31',null,'151','152','cms:cms','1','0','0','',''),
 ('33','zone_menu','32',null,'153','154','adminzone:','1','0','0','',''),
 ('34','collab_features','0',null,'157','158','_SELF:authors:type=misc','0','0','0','',''),
 ('35','collab_features','1',null,'159','160','_SEARCH:cms_authors:type=_ad','0','0','1','',''),
 ('36','collab_website','2',null,'164','165','_SELF:hosting-submit','0','0','0','',''),
 ('37','pc_features','3',null,'174','175','_SEARCH:calendar:type=misc:member_id={$USER_OVERIDE}','0','0','0','',''),
 ('38','main_content','4',null,'188','189','_SEARCH:catalogues:type=index:id=projects','0','0','0','',''),
 ('39','main_content','5',null,'204','205','_SEARCH:catalogues:type=index:id=modifications','0','0','0','',''),
 ('40','main_content','6',null,'216','217','_SEARCH:catalogues:type=index:id=hosted','0','0','0','',''),
 ('41','main_content','7',null,'228','229','_SEARCH:catalogues:type=index:id=links','0','0','0','',''),
 ('42','main_content','8',null,'240','241','_SEARCH:catalogues:type=index:id=contacts','0','0','0','',''),
 ('43','collab_features','9',null,'270','271','','0','0','0','',''),
 ('44','collab_features','10','43','272','273','_SEARCH:catalogues:id=projects:type=index','0','0','1','',''),
 ('45','collab_features','11','43','274','275','_SEARCH:cms_catalogues:catalogue_name=projects:type=add_entry','0','0','1','',''),
 ('68','ecommerce_features','34',null,'383','384','_SEARCH:shopping:type=my_orders','0','0','0','',''),
 ('47','main_content','13',null,'306','307','_SEARCH:cedi:type=misc','0','0','0','',''),
 ('48','cedi_features','14',null,'308','309','_SEARCH:cedi:type=misc','0','0','0','',''),
 ('49','cedi_features','15',null,'310','311','_SEARCH:cedi:type=random','0','0','0','',''),
 ('50','cedi_features','16',null,'312','313','_SEARCH:cedi:type=changes','0','0','0','',''),
 ('51','cedi_features','17',null,'314','315','_SEARCH:cedi:type=tree','0','0','0','',''),
 ('52','main_community','18',null,'319','320','_SEARCH:chat:type=misc','0','0','0','',''),
 ('53','pc_features','19',null,'321','322','_SEARCH:chat:type=misc:member_id={$USER_OVERIDE}','0','0','0','',''),
 ('54','main_content','20',null,'325','326','_SEARCH:downloads:type=misc','0','0','0','',''),
 ('55','main_content','21',null,'327','328','_SEARCH:galleries:type=misc','0','0','0','',''),
 ('56','pc_features','22',null,'341','342','_SEARCH:cms_news:type=ad','0','0','0','',''),
 ('57','pc_edit','23',null,'343','344','_SEARCH:newsletter:type=misc','0','0','0','',''),
 ('58','pc_features','24',null,'347','348','_SEARCH:points:type=member:id={$USER_OVERIDE}','0','0','0','',''),
 ('59','forum_personal','25',null,'349','350','_SEARCH:points:type=member','0','0','0','',''),
 ('60','main_community','26',null,'351','352','_SEARCH:pointstore:type=misc','0','0','0','',''),
 ('61','pc_features','27',null,'369','370','_SELF:invoices:type=misc','0','0','0','',''),
 ('62','pc_features','28',null,'371','372','_SELF:subscriptions:type=misc','0','0','0','',''),
 ('63','ecommerce_features','29',null,'373','374','_SEARCH:purchase:type=misc','0','0','0','',''),
 ('64','ecommerce_features','30',null,'375','376','_SEARCH:invoices:type=misc','0','0','0','',''),
 ('65','ecommerce_features','31',null,'377','378','_SEARCH:subscriptions:type=misc','0','0','0','',''),
 ('66','main_website','32',null,'379','380','_SEARCH:quiz:type=misc','0','0','0','',''),
 ('67','forum_features','33',null,'381','382','_SEARCH:search:type=misc:id=ocf_posts','0','0','0','',''),
 ('69','main_website','35',null,'399','400','_SEARCH:staff:type=misc','0','0','0','',''),
 ('70','main_website','36',null,'403','404','_SEARCH:tickets:type=misc','0','0','0','',''),
 ('71','pc_features','37',null,'405','406','_SEARCH:tickets:type=misc','0','0','0','',''),
 ('72','member_features','0',null,'407','408','_SEARCH:forumview:type=misc','0','0','0','',''),
 ('73','pc_features','1',null,'409','410','_SEARCH:forumview:type=pt:id={$USER_OVERIDE}','0','0','0','',''),
 ('74','forum_features','2',null,'411','412','_SEARCH:forumview:type=misc','0','0','0','',''),
 ('75','forum_features','3',null,'413','414','_SEARCH:forumview:type=pt','0','0','0','',''),
 ('76','forum_features','4',null,'415','416','_SEARCH:vforums:type=misc','0','0','0','',''),
 ('77','forum_features','5',null,'417','418','_SEARCH:vforums:type=unread','0','0','0','',''),
 ('78','forum_features','6',null,'419','420','_SEARCH:vforums:type=recently_read','0','0','0','',''),
 ('79','pc_edit','7',null,'421','422','personalzone:privacy:type=misc:id={$USER_OVERIDE}','0','0','0','',''),
 ('80','main_features','8',null,'423','424','_SEARCH:guestbook','0','0','0','',''),
 ('81','root_website','100',null,'425','426','_SEARCH:recommend:from={$REPLACE&,:,%3A,{$SELF_URL}}','0','0','0','',''),
 ('82','collab_features','101',null,'427','428','_SEARCH:filedump:type=misc','0','0','0','',''),
 ('83','collab_website','102',null,'429','430','_SEARCH:supermembers','0','0','0','','');

DROP TABLE IF EXISTS `ocp7_messages_to_render`;

CREATE TABLE `ocp7_messages_to_render` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `r_session_id` int(11) NOT NULL,
  `r_message` longtext COLLATE latin1_bin NOT NULL,
  `r_type` varchar(80) COLLATE latin1_bin NOT NULL,
  `r_time` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `forsession` (`r_session_id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_msp`;

CREATE TABLE `ocp7_msp` (
  `active_until` int(10) unsigned NOT NULL,
  `member_id` int(11) NOT NULL,
  `specific_permission` varchar(80) COLLATE latin1_bin NOT NULL,
  `the_page` varchar(80) COLLATE latin1_bin NOT NULL,
  `module_the_name` varchar(80) COLLATE latin1_bin NOT NULL,
  `category_name` varchar(80) COLLATE latin1_bin NOT NULL,
  `the_value` tinyint(1) NOT NULL,
  PRIMARY KEY (`active_until`,`member_id`,`specific_permission`,`the_page`,`module_the_name`,`category_name`),
  KEY `mspname` (`specific_permission`,`the_page`,`module_the_name`,`category_name`),
  KEY `mspmember_id` (`member_id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_occlechat`;

CREATE TABLE `ocp7_occlechat` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `c_message` longtext COLLATE latin1_bin NOT NULL,
  `c_url` varchar(255) COLLATE latin1_bin NOT NULL,
  `c_incoming` tinyint(1) NOT NULL,
  `c_timestamp` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_rating`;

CREATE TABLE `ocp7_rating` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `rating_for_type` varchar(80) COLLATE latin1_bin NOT NULL,
  `rating_for_id` varchar(80) COLLATE latin1_bin NOT NULL,
  `rating_member` int(11) NOT NULL,
  `rating_ip` varchar(40) COLLATE latin1_bin NOT NULL,
  `rating_time` int(10) unsigned NOT NULL,
  `rating` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `alt_key` (`rating_for_type`,`rating_for_id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_redirects`;

CREATE TABLE `ocp7_redirects` (
  `r_from_page` varchar(80) COLLATE latin1_bin NOT NULL,
  `r_from_zone` varchar(80) COLLATE latin1_bin NOT NULL,
  `r_to_page` varchar(80) COLLATE latin1_bin NOT NULL,
  `r_to_zone` varchar(80) COLLATE latin1_bin NOT NULL,
  `r_is_transparent` tinyint(1) NOT NULL,
  PRIMARY KEY (`r_from_page`,`r_from_zone`)
) ENGINE=MyISAM;

insert into `ocp7_redirects` values('rules','site','rules','','1'),
 ('rules','forum','rules','','1'),
 ('hosting-submit','collaboration','hosting-submit','site','1'),
 ('authors','collaboration','authors','site','1'),
 ('panel_top','collaboration','panel_top','','1'),
 ('panel_top','forum','panel_top','','1'),
 ('panel_top','personalzone','panel_top','','1'),
 ('invoices','personalzone','invoices','site','1'),
 ('newsletter','personalzone','newsletter','site','1'),
 ('subscriptions','personalzone','subscriptions','site','1');

DROP TABLE IF EXISTS `ocp7_review_supplement`;

CREATE TABLE `ocp7_review_supplement` (
  `r_post_id` int(11) NOT NULL,
  `r_rating_type` varchar(80) COLLATE latin1_bin NOT NULL,
  `r_rating` tinyint(4) NOT NULL,
  `r_topic_id` int(11) NOT NULL,
  `r_rating_for_id` varchar(80) COLLATE latin1_bin NOT NULL,
  `r_rating_for_type` varchar(80) COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`r_post_id`,`r_rating_type`),
  KEY `rating_for_id` (`r_rating_for_id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_security_images`;

CREATE TABLE `ocp7_security_images` (
  `si_session_id` int(11) NOT NULL,
  `si_time` int(10) unsigned NOT NULL,
  `si_code` int(11) NOT NULL,
  PRIMARY KEY (`si_session_id`),
  KEY `si_time` (`si_time`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_sms_log`;

CREATE TABLE `ocp7_sms_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `s_member_id` int(11) NOT NULL,
  `s_time` int(10) unsigned NOT NULL,
  `s_trigger_ip` varchar(40) COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sms_log_for` (`s_member_id`,`s_time`),
  KEY `sms_trigger_ip` (`s_trigger_ip`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_stats`;

CREATE TABLE `ocp7_stats` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `the_page` varchar(255) COLLATE latin1_bin NOT NULL,
  `ip` varchar(40) COLLATE latin1_bin NOT NULL,
  `the_user` int(11) NOT NULL,
  `date_and_time` int(10) unsigned NOT NULL,
  `referer` varchar(255) COLLATE latin1_bin NOT NULL,
  `get` varchar(255) COLLATE latin1_bin NOT NULL,
  `post` longtext COLLATE latin1_bin NOT NULL,
  `browser` varchar(255) COLLATE latin1_bin NOT NULL,
  `milliseconds` int(11) NOT NULL,
  `operating_system` varchar(255) COLLATE latin1_bin NOT NULL,
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
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_text`;

CREATE TABLE `ocp7_text` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `the_message` int(10) unsigned NOT NULL,
  `days` int(11) NOT NULL,
  `order_time` int(10) unsigned NOT NULL,
  `activation_time` int(10) unsigned DEFAULT NULL,
  `active_now` tinyint(1) NOT NULL,
  `notes` longtext COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`id`),
  KEY `findflagrant` (`active_now`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_theme_images`;

CREATE TABLE `ocp7_theme_images` (
  `id` varchar(255) COLLATE latin1_bin NOT NULL,
  `theme` varchar(40) COLLATE latin1_bin NOT NULL,
  `path` varchar(255) COLLATE latin1_bin NOT NULL,
  `lang` varchar(5) COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`id`,`theme`,`lang`),
  KEY `theme` (`theme`,`lang`)
) ENGINE=MyISAM;

insert into `ocp7_theme_images` values('favicon','default','favicon.ico','EN'),
 ('appleicon','default','appleicon.png','EN');

DROP TABLE IF EXISTS `ocp7_trackbacks`;

CREATE TABLE `ocp7_trackbacks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `trackback_for_type` varchar(80) COLLATE latin1_bin NOT NULL,
  `trackback_for_id` varchar(80) COLLATE latin1_bin NOT NULL,
  `trackback_ip` varchar(40) COLLATE latin1_bin NOT NULL,
  `trackback_time` int(10) unsigned NOT NULL,
  `trackback_url` varchar(255) COLLATE latin1_bin NOT NULL,
  `trackback_title` varchar(255) COLLATE latin1_bin NOT NULL,
  `trackback_excerpt` longtext COLLATE latin1_bin NOT NULL,
  `trackback_name` varchar(255) COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`id`),
  KEY `trackback_for_type` (`trackback_for_type`),
  KEY `trackback_for_id` (`trackback_for_id`),
  KEY `trackback_time` (`trackback_time`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_tracking`;

CREATE TABLE `ocp7_tracking` (
  `r_resource_type` varchar(80) COLLATE latin1_bin NOT NULL,
  `r_resource_id` varchar(80) COLLATE latin1_bin NOT NULL,
  `r_member_id` int(11) NOT NULL,
  `r_notify_sms` tinyint(1) NOT NULL,
  `r_notify_email` tinyint(1) NOT NULL,
  `r_filter` longtext COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`r_resource_type`,`r_resource_id`,`r_member_id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_translate_history`;

CREATE TABLE `ocp7_translate_history` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `lang_id` int(11) NOT NULL,
  `language` varchar(5) COLLATE latin1_bin NOT NULL,
  `text_original` longtext COLLATE latin1_bin NOT NULL,
  `broken` tinyint(1) NOT NULL,
  `action_member` int(11) NOT NULL,
  `action_time` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`,`language`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_tutorial_links`;

CREATE TABLE `ocp7_tutorial_links` (
  `the_name` varchar(80) COLLATE latin1_bin NOT NULL,
  `the_value` longtext COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`the_name`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_url_id_monikers`;

CREATE TABLE `ocp7_url_id_monikers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `m_resource_page` varchar(80) COLLATE latin1_bin NOT NULL,
  `m_resource_type` varchar(80) COLLATE latin1_bin NOT NULL,
  `m_resource_id` varchar(80) COLLATE latin1_bin NOT NULL,
  `m_moniker` varchar(255) COLLATE latin1_bin NOT NULL,
  `m_deprecated` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `uim_pagelink` (`m_resource_page`,`m_resource_type`,`m_resource_id`),
  KEY `uim_moniker` (`m_moniker`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_url_title_cache`;

CREATE TABLE `ocp7_url_title_cache` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `t_url` varchar(255) COLLATE latin1_bin NOT NULL,
  `t_title` varchar(255) COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_usersonline_track`;

CREATE TABLE `ocp7_usersonline_track` (
  `date_and_time` int(10) unsigned NOT NULL,
  `peak` int(11) NOT NULL,
  PRIMARY KEY (`date_and_time`),
  KEY `peak_track` (`peak`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_usersubmitban_ip`;

CREATE TABLE `ocp7_usersubmitban_ip` (
  `ip` varchar(40) COLLATE latin1_bin NOT NULL,
  `i_descrip` longtext COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`ip`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_usersubmitban_member`;

CREATE TABLE `ocp7_usersubmitban_member` (
  `the_member` int(11) NOT NULL,
  PRIMARY KEY (`the_member`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_validated_once`;

CREATE TABLE `ocp7_validated_once` (
  `hash` varchar(33) COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`hash`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_wordfilter`;

CREATE TABLE `ocp7_wordfilter` (
  `word` varchar(255) COLLATE latin1_bin NOT NULL,
  `w_replacement` varchar(255) COLLATE latin1_bin NOT NULL,
  `w_substr` tinyint(1) NOT NULL,
  PRIMARY KEY (`word`,`w_substr`)
) ENGINE=MyISAM;

insert into `ocp7_wordfilter` values('arsehole','','0'),
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

DROP TABLE IF EXISTS `ocp7_adminlogs`;

CREATE TABLE `ocp7_adminlogs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `the_type` varchar(80) COLLATE latin1_bin NOT NULL,
  `param_a` varchar(80) COLLATE latin1_bin NOT NULL,
  `param_b` varchar(255) COLLATE latin1_bin NOT NULL,
  `the_user` int(11) NOT NULL,
  `ip` varchar(40) COLLATE latin1_bin NOT NULL,
  `date_and_time` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `xas` (`the_user`),
  KEY `ts` (`date_and_time`),
  KEY `aip` (`ip`),
  KEY `athe_type` (`the_type`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_cached_comcode_pages`;

CREATE TABLE `ocp7_cached_comcode_pages` (
  `the_zone` varchar(80) COLLATE latin1_bin NOT NULL,
  `the_page` varchar(80) COLLATE latin1_bin NOT NULL,
  `string_index` int(10) unsigned NOT NULL,
  `the_theme` varchar(80) COLLATE latin1_bin NOT NULL,
  `cc_page_title` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`the_zone`,`the_page`,`the_theme`),
  KEY `ftjoin_ccpt` (`cc_page_title`),
  KEY `ftjoin_ccsi` (`string_index`),
  KEY `ccp_join` (`the_page`,`the_zone`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_chargelog`;

CREATE TABLE `ocp7_chargelog` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `amount` int(11) NOT NULL,
  `reason` int(10) unsigned NOT NULL,
  `date_and_time` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_chat_active`;

CREATE TABLE `ocp7_chat_active` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `member_id` int(11) NOT NULL,
  `room_id` int(11) DEFAULT NULL,
  `date_and_time` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `active_ordering` (`date_and_time`),
  KEY `member_select` (`member_id`),
  KEY `room_select` (`room_id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_chat_blocking`;

CREATE TABLE `ocp7_chat_blocking` (
  `member_blocker` int(11) NOT NULL,
  `member_blocked` int(11) NOT NULL,
  `date_and_time` int(10) unsigned NOT NULL,
  PRIMARY KEY (`member_blocker`,`member_blocked`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_chat_buddies`;

CREATE TABLE `ocp7_chat_buddies` (
  `member_likes` int(11) NOT NULL,
  `member_liked` int(11) NOT NULL,
  `date_and_time` int(10) unsigned NOT NULL,
  PRIMARY KEY (`member_likes`,`member_liked`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_chat_events`;

CREATE TABLE `ocp7_chat_events` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `e_type_code` varchar(80) COLLATE latin1_bin NOT NULL,
  `e_member_id` int(11) NOT NULL,
  `e_room_id` int(11) DEFAULT NULL,
  `e_date_and_time` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `event_ordering` (`e_date_and_time`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_chat_messages`;

CREATE TABLE `ocp7_chat_messages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `system_message` tinyint(1) NOT NULL,
  `ip_address` varchar(40) COLLATE latin1_bin NOT NULL,
  `room_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `date_and_time` int(10) unsigned NOT NULL,
  `the_message` int(10) unsigned NOT NULL,
  `text_colour` varchar(255) COLLATE latin1_bin NOT NULL,
  `font_name` varchar(255) COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ordering` (`date_and_time`),
  KEY `room_id` (`room_id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_chat_rooms`;

CREATE TABLE `ocp7_chat_rooms` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `room_name` varchar(255) COLLATE latin1_bin NOT NULL,
  `room_owner` int(11) DEFAULT NULL,
  `allow_list` longtext COLLATE latin1_bin NOT NULL,
  `allow_list_groups` longtext COLLATE latin1_bin NOT NULL,
  `disallow_list` longtext COLLATE latin1_bin NOT NULL,
  `disallow_list_groups` longtext COLLATE latin1_bin NOT NULL,
  `room_language` varchar(5) COLLATE latin1_bin NOT NULL,
  `c_welcome` int(10) unsigned NOT NULL,
  `is_im` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `room_name` (`room_name`),
  KEY `is_im` (`is_im`,`room_name`),
  KEY `first_public` (`is_im`,`id`),
  KEY `allow_list` (`allow_list`(30))
) ENGINE=MyISAM AUTO_INCREMENT=2;

insert into `ocp7_chat_rooms` values('1','General chat',null,'','','','','EN','316','0');

DROP TABLE IF EXISTS `ocp7_chat_sound_effects`;

CREATE TABLE `ocp7_chat_sound_effects` (
  `s_member` int(11) NOT NULL,
  `s_effect_id` varchar(80) COLLATE latin1_bin NOT NULL,
  `s_url` varchar(255) COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`s_member`,`s_effect_id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_comcode_pages`;

CREATE TABLE `ocp7_comcode_pages` (
  `the_zone` varchar(80) COLLATE latin1_bin NOT NULL,
  `the_page` varchar(80) COLLATE latin1_bin NOT NULL,
  `p_parent_page` varchar(80) COLLATE latin1_bin NOT NULL,
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


DROP TABLE IF EXISTS `ocp7_customtasks`;

CREATE TABLE `ocp7_customtasks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tasktitle` varchar(255) COLLATE latin1_bin NOT NULL,
  `datetimeadded` int(10) unsigned NOT NULL,
  `recurinterval` int(11) NOT NULL,
  `recurevery` varchar(80) COLLATE latin1_bin NOT NULL,
  `taskisdone` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=12;

insert into `ocp7_customtasks` values('1','Set up website configuration and structure','1295956169','0','',null),
 ('2','Make \'favicon\' theme image','1295956169','0','',null),
 ('3','Make \'appleicon\' (webclip) theme image','1295956169','0','',null),
 ('4','Make/install custom theme','1295956169','0','',null),
 ('5','Add your content','1295956169','0','',null),
 ('6','[page=\"adminzone:admin_themes:_edit_templates:theme=default:f0file=MAIL.tpl\"]Customise your \'MAIL\' template[/page]','1295956169','0','',null),
 ('7','[url=\"P3P Wizard (set up privacy policy)\"]http://www.p3pwiz.com/[/url]','1295956169','0','',null),
 ('8','[url=\"Submit to Google\"]http://www.google.com/addurl/[/url]','1295956169','0','',null),
 ('9','[url=\"Submit to OpenDMOZ\"]http://www.dmoz.org/add.html[/url]','1295956169','0','',null),
 ('10','[url=\"Submit to Bing\"]http://www.bing.com/webmaster/SubmitSitePage.aspx[/url]','1295956169','0','',null),
 ('11','[url=\"Submit Blog to MyYahoo\"]http://publisher.yahoo.com/rss_guide/submit.php[/url]','1295956169','0','',null);

DROP TABLE IF EXISTS `ocp7_download_categories`;

CREATE TABLE `ocp7_download_categories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category` int(10) unsigned NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `add_date` int(10) unsigned NOT NULL,
  `notes` longtext COLLATE latin1_bin NOT NULL,
  `description` int(10) unsigned NOT NULL,
  `rep_image` varchar(255) COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`id`),
  KEY `child_find` (`parent_id`),
  KEY `ftjoin_dccat` (`category`),
  KEY `ftjoin_dcdescrip` (`description`)
) ENGINE=MyISAM AUTO_INCREMENT=2;

insert into `ocp7_download_categories` values('1','323',null,'1295956144','','324','');

DROP TABLE IF EXISTS `ocp7_download_downloads`;

CREATE TABLE `ocp7_download_downloads` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int(11) NOT NULL,
  `name` int(10) unsigned NOT NULL,
  `url` varchar(255) COLLATE latin1_bin NOT NULL,
  `description` int(10) unsigned NOT NULL,
  `author` varchar(80) COLLATE latin1_bin NOT NULL,
  `comments` int(10) unsigned NOT NULL,
  `num_downloads` int(11) NOT NULL,
  `out_mode_id` int(11) DEFAULT NULL,
  `add_date` int(10) unsigned NOT NULL,
  `edit_date` int(10) unsigned DEFAULT NULL,
  `validated` tinyint(1) NOT NULL,
  `default_pic` int(11) NOT NULL,
  `file_size` int(11) DEFAULT NULL,
  `allow_rating` tinyint(1) NOT NULL,
  `allow_comments` tinyint(4) NOT NULL,
  `allow_trackbacks` tinyint(1) NOT NULL,
  `notes` longtext COLLATE latin1_bin NOT NULL,
  `download_views` int(11) NOT NULL,
  `download_cost` int(11) NOT NULL,
  `download_submitter_gets_points` tinyint(1) NOT NULL,
  `submitter` int(11) NOT NULL,
  `original_filename` varchar(255) COLLATE latin1_bin NOT NULL,
  `rep_image` varchar(255) COLLATE latin1_bin NOT NULL,
  `download_licence` int(11) DEFAULT NULL,
  `download_data_mash` longtext COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`id`),
  KEY `download_views` (`download_views`),
  KEY `category_list` (`category_id`),
  KEY `recent_downloads` (`add_date`),
  KEY `top_downloads` (`num_downloads`),
  KEY `downloadauthor` (`author`),
  KEY `dds` (`submitter`),
  KEY `ddl` (`download_licence`),
  KEY `dvalidated` (`validated`),
  KEY `ftjoin_dname` (`name`),
  KEY `ftjoin_ddescrip` (`description`),
  KEY `ftjoin_dcomments` (`comments`),
  FULLTEXT KEY `download_data_mash` (`download_data_mash`),
  FULLTEXT KEY `original_filename` (`original_filename`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_download_licences`;

CREATE TABLE `ocp7_download_licences` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `l_title` varchar(255) COLLATE latin1_bin NOT NULL,
  `l_text` longtext COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_download_logging`;

CREATE TABLE `ocp7_download_logging` (
  `id` int(11) NOT NULL,
  `the_user` int(11) NOT NULL,
  `ip` varchar(40) COLLATE latin1_bin NOT NULL,
  `date_and_time` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`,`the_user`),
  KEY `calculate_bandwidth` (`date_and_time`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_f_usergroup_subs`;

CREATE TABLE `ocp7_f_usergroup_subs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `s_title` int(10) unsigned NOT NULL,
  `s_description` int(10) unsigned NOT NULL,
  `s_cost` varchar(255) COLLATE latin1_bin NOT NULL,
  `s_length` int(11) NOT NULL,
  `s_length_units` varchar(255) COLLATE latin1_bin NOT NULL,
  `s_group_id` int(11) NOT NULL,
  `s_enabled` tinyint(1) NOT NULL,
  `s_mail_start` int(10) unsigned NOT NULL,
  `s_mail_end` int(10) unsigned NOT NULL,
  `s_mail_uhoh` int(10) unsigned NOT NULL,
  `s_uses_primary` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_failedlogins`;

CREATE TABLE `ocp7_failedlogins` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `failed_account` varchar(80) COLLATE latin1_bin NOT NULL,
  `date_and_time` int(10) unsigned NOT NULL,
  `ip` varchar(40) COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_feature_lifetime_monitor`;

CREATE TABLE `ocp7_feature_lifetime_monitor` (
  `content_id` varchar(80) COLLATE latin1_bin NOT NULL,
  `block_cache_id` varchar(80) COLLATE latin1_bin NOT NULL,
  `run_period` int(11) NOT NULL,
  `running_now` tinyint(1) NOT NULL,
  `last_update` int(10) unsigned NOT NULL,
  PRIMARY KEY (`content_id`,`block_cache_id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_filedump`;

CREATE TABLE `ocp7_filedump` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(80) COLLATE latin1_bin NOT NULL,
  `path` varchar(255) COLLATE latin1_bin NOT NULL,
  `description` int(10) unsigned NOT NULL,
  `the_member` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_galleries`;

CREATE TABLE `ocp7_galleries` (
  `name` varchar(80) COLLATE latin1_bin NOT NULL,
  `description` int(10) unsigned NOT NULL,
  `teaser` int(10) unsigned NOT NULL,
  `fullname` int(10) unsigned NOT NULL,
  `add_date` int(10) unsigned NOT NULL,
  `rep_image` varchar(255) COLLATE latin1_bin NOT NULL,
  `parent_id` varchar(80) COLLATE latin1_bin NOT NULL,
  `watermark_top_left` varchar(255) COLLATE latin1_bin NOT NULL,
  `watermark_top_right` varchar(255) COLLATE latin1_bin NOT NULL,
  `watermark_bottom_left` varchar(255) COLLATE latin1_bin NOT NULL,
  `watermark_bottom_right` varchar(255) COLLATE latin1_bin NOT NULL,
  `accept_images` tinyint(1) NOT NULL,
  `accept_videos` tinyint(1) NOT NULL,
  `allow_rating` tinyint(1) NOT NULL,
  `allow_comments` tinyint(4) NOT NULL,
  `notes` longtext COLLATE latin1_bin NOT NULL,
  `is_member_synched` tinyint(1) NOT NULL,
  `flow_mode_interface` tinyint(1) NOT NULL,
  PRIMARY KEY (`name`),
  KEY `watermark_top_left` (`watermark_top_left`),
  KEY `watermark_top_right` (`watermark_top_right`),
  KEY `watermark_bottom_left` (`watermark_bottom_left`),
  KEY `watermark_bottom_right` (`watermark_bottom_right`),
  KEY `gadd_date` (`add_date`),
  KEY `parent_id` (`parent_id`),
  KEY `ftjoin_gfullname` (`fullname`),
  KEY `ftjoin_gdescrip` (`description`)
) ENGINE=MyISAM;

insert into `ocp7_galleries` values('root','329','330','331','1295956149','','','','','','','1','1','1','1','','0','1');

DROP TABLE IF EXISTS `ocp7_gifts`;

CREATE TABLE `ocp7_gifts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_and_time` int(10) unsigned NOT NULL,
  `amount` int(11) NOT NULL,
  `gift_from` int(11) NOT NULL,
  `gift_to` int(11) NOT NULL,
  `reason` int(10) unsigned NOT NULL,
  `anonymous` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `giftsgiven` (`gift_from`),
  KEY `giftsreceived` (`gift_to`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_images`;

CREATE TABLE `ocp7_images` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cat` varchar(80) COLLATE latin1_bin NOT NULL,
  `url` varchar(255) COLLATE latin1_bin NOT NULL,
  `thumb_url` varchar(255) COLLATE latin1_bin NOT NULL,
  `comments` int(10) unsigned NOT NULL,
  `allow_rating` tinyint(1) NOT NULL,
  `allow_comments` tinyint(4) NOT NULL,
  `allow_trackbacks` tinyint(1) NOT NULL,
  `notes` longtext COLLATE latin1_bin NOT NULL,
  `submitter` int(11) NOT NULL,
  `validated` tinyint(1) NOT NULL,
  `add_date` int(10) unsigned NOT NULL,
  `edit_date` int(10) unsigned DEFAULT NULL,
  `image_views` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `image_views` (`image_views`),
  KEY `category_list` (`cat`),
  KEY `i_validated` (`validated`),
  KEY `xis` (`submitter`),
  KEY `iadd_date` (`add_date`),
  KEY `ftjoin_icomments` (`comments`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_invoices`;

CREATE TABLE `ocp7_invoices` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `i_type_code` varchar(80) COLLATE latin1_bin NOT NULL,
  `i_member_id` int(11) NOT NULL,
  `i_state` varchar(80) COLLATE latin1_bin NOT NULL,
  `i_amount` varchar(255) COLLATE latin1_bin NOT NULL,
  `i_special` varchar(255) COLLATE latin1_bin NOT NULL,
  `i_time` int(10) unsigned NOT NULL,
  `i_note` longtext COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_iotd`;

CREATE TABLE `ocp7_iotd` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `url` varchar(255) COLLATE latin1_bin NOT NULL,
  `i_title` int(10) unsigned NOT NULL,
  `caption` int(10) unsigned NOT NULL,
  `thumb_url` varchar(255) COLLATE latin1_bin NOT NULL,
  `is_current` tinyint(1) NOT NULL,
  `allow_rating` tinyint(1) NOT NULL,
  `allow_comments` tinyint(4) NOT NULL,
  `allow_trackbacks` tinyint(1) NOT NULL,
  `notes` longtext COLLATE latin1_bin NOT NULL,
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
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_leader_board`;

CREATE TABLE `ocp7_leader_board` (
  `lb_member` int(11) NOT NULL,
  `lb_points` int(11) NOT NULL,
  `date_and_time` int(10) unsigned NOT NULL,
  PRIMARY KEY (`lb_member`,`date_and_time`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_news`;

CREATE TABLE `ocp7_news` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_and_time` int(10) unsigned NOT NULL,
  `title` int(10) unsigned NOT NULL,
  `news` int(10) unsigned NOT NULL,
  `news_article` int(10) unsigned NOT NULL,
  `allow_rating` tinyint(1) NOT NULL,
  `allow_comments` tinyint(4) NOT NULL,
  `allow_trackbacks` tinyint(1) NOT NULL,
  `notes` longtext COLLATE latin1_bin NOT NULL,
  `author` varchar(80) COLLATE latin1_bin NOT NULL,
  `submitter` int(11) NOT NULL,
  `validated` tinyint(1) NOT NULL,
  `edit_date` int(10) unsigned DEFAULT NULL,
  `news_category` int(11) NOT NULL,
  `news_views` int(11) NOT NULL,
  `news_image` varchar(255) COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`id`),
  KEY `news_views` (`news_views`),
  KEY `findnewscat` (`news_category`),
  KEY `newsauthor` (`author`),
  KEY `nes` (`submitter`),
  KEY `headlines` (`date_and_time`),
  KEY `nvalidated` (`validated`),
  KEY `ftjoin_ititle` (`title`),
  KEY `ftjoin_nnews` (`news`),
  KEY `ftjoin_nnewsa` (`news_article`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_news_categories`;

CREATE TABLE `ocp7_news_categories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nc_title` int(10) unsigned NOT NULL,
  `nc_owner` int(11) DEFAULT NULL,
  `nc_img` varchar(80) COLLATE latin1_bin NOT NULL,
  `notes` longtext COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ncs` (`nc_owner`)
) ENGINE=MyISAM AUTO_INCREMENT=8;

insert into `ocp7_news_categories` values('1','334',null,'newscats/general',''),
 ('2','335',null,'newscats/technology',''),
 ('3','336',null,'newscats/difficulties',''),
 ('4','337',null,'newscats/community',''),
 ('5','338',null,'newscats/entertainment',''),
 ('6','339',null,'newscats/business',''),
 ('7','340',null,'newscats/art','');

DROP TABLE IF EXISTS `ocp7_news_category_entries`;

CREATE TABLE `ocp7_news_category_entries` (
  `news_entry` int(11) NOT NULL,
  `news_entry_category` int(11) NOT NULL,
  PRIMARY KEY (`news_entry`,`news_entry_category`),
  KEY `news_entry_category` (`news_entry_category`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_news_rss_cloud`;

CREATE TABLE `ocp7_news_rss_cloud` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `rem_procedure` varchar(80) COLLATE latin1_bin NOT NULL,
  `rem_port` tinyint(4) NOT NULL,
  `rem_path` varchar(255) COLLATE latin1_bin NOT NULL,
  `rem_protocol` varchar(80) COLLATE latin1_bin NOT NULL,
  `rem_ip` varchar(40) COLLATE latin1_bin NOT NULL,
  `watching_channel` varchar(255) COLLATE latin1_bin NOT NULL,
  `register_time` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_newsletter`;

CREATE TABLE `ocp7_newsletter` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE latin1_bin NOT NULL,
  `join_time` int(10) unsigned NOT NULL,
  `code_confirm` int(11) NOT NULL,
  `the_password` varchar(33) COLLATE latin1_bin NOT NULL,
  `pass_salt` varchar(80) COLLATE latin1_bin NOT NULL,
  `language` varchar(80) COLLATE latin1_bin NOT NULL,
  `n_forename` varchar(255) COLLATE latin1_bin NOT NULL,
  `n_surname` varchar(255) COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`id`),
  KEY `welcomemails` (`join_time`),
  KEY `code_confirm` (`code_confirm`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_newsletter_archive`;

CREATE TABLE `ocp7_newsletter_archive` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_and_time` int(11) NOT NULL,
  `subject` varchar(255) COLLATE latin1_bin NOT NULL,
  `newsletter` longtext COLLATE latin1_bin NOT NULL,
  `language` varchar(80) COLLATE latin1_bin NOT NULL,
  `importance_level` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_newsletter_drip_send`;

CREATE TABLE `ocp7_newsletter_drip_send` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `d_inject_time` int(10) unsigned NOT NULL,
  `d_subject` varchar(255) COLLATE latin1_bin NOT NULL,
  `d_message` longtext COLLATE latin1_bin NOT NULL,
  `d_html_only` tinyint(1) NOT NULL,
  `d_to_email` varchar(255) COLLATE latin1_bin NOT NULL,
  `d_to_name` varchar(255) COLLATE latin1_bin NOT NULL,
  `d_from_email` varchar(255) COLLATE latin1_bin NOT NULL,
  `d_from_name` varchar(255) COLLATE latin1_bin NOT NULL,
  `d_priority` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `d_inject_time` (`d_inject_time`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_newsletter_subscribe`;

CREATE TABLE `ocp7_newsletter_subscribe` (
  `newsletter_id` int(11) NOT NULL,
  `the_level` tinyint(4) NOT NULL,
  `email` varchar(255) COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`newsletter_id`,`email`),
  KEY `peopletosendto` (`the_level`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_newsletters`;

CREATE TABLE `ocp7_newsletters` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` int(10) unsigned NOT NULL,
  `description` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2;

insert into `ocp7_newsletters` values('1','345','346');

DROP TABLE IF EXISTS `ocp7_poll`;

CREATE TABLE `ocp7_poll` (
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
  `notes` longtext COLLATE latin1_bin NOT NULL,
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
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_poll_votes`;

CREATE TABLE `ocp7_poll_votes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `v_poll_id` int(11) NOT NULL,
  `v_voter_id` int(11) DEFAULT NULL,
  `v_voter_ip` varchar(40) COLLATE latin1_bin NOT NULL,
  `v_vote_for` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `v_voter_id` (`v_voter_id`),
  KEY `v_voter_ip` (`v_voter_ip`),
  KEY `v_vote_for` (`v_vote_for`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_prices`;

CREATE TABLE `ocp7_prices` (
  `name` varchar(80) COLLATE latin1_bin NOT NULL,
  `price` int(11) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_pstore_customs`;

CREATE TABLE `ocp7_pstore_customs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `c_title` int(10) unsigned NOT NULL,
  `c_description` int(10) unsigned NOT NULL,
  `c_enabled` tinyint(1) NOT NULL,
  `c_cost` int(11) NOT NULL,
  `c_one_per_member` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_pstore_permissions`;

CREATE TABLE `ocp7_pstore_permissions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `p_title` int(10) unsigned NOT NULL,
  `p_description` int(10) unsigned NOT NULL,
  `p_enabled` tinyint(1) NOT NULL,
  `p_cost` int(11) NOT NULL,
  `p_hours` int(11) NOT NULL,
  `p_type` varchar(80) COLLATE latin1_bin NOT NULL,
  `p_specific_permission` varchar(80) COLLATE latin1_bin NOT NULL,
  `p_zone` varchar(80) COLLATE latin1_bin NOT NULL,
  `p_page` varchar(80) COLLATE latin1_bin NOT NULL,
  `p_module` varchar(80) COLLATE latin1_bin NOT NULL,
  `p_category` varchar(80) COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_quiz_entries`;

CREATE TABLE `ocp7_quiz_entries` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `q_time` int(10) unsigned NOT NULL,
  `q_member` int(11) NOT NULL,
  `q_quiz` int(11) NOT NULL,
  `q_results` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_quiz_entry_answer`;

CREATE TABLE `ocp7_quiz_entry_answer` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `q_entry` int(11) NOT NULL,
  `q_question` int(11) NOT NULL,
  `q_answer` longtext COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_quiz_member_last_visit`;

CREATE TABLE `ocp7_quiz_member_last_visit` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `v_time` int(10) unsigned NOT NULL,
  `v_member_id` int(11) NOT NULL,
  `v_quiz_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_quiz_question_answers`;

CREATE TABLE `ocp7_quiz_question_answers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `q_question` int(11) NOT NULL,
  `q_answer_text` int(10) unsigned NOT NULL,
  `q_is_correct` tinyint(1) NOT NULL,
  `q_order` int(11) NOT NULL,
  `q_explanation` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_quiz_questions`;

CREATE TABLE `ocp7_quiz_questions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `q_long_input_field` tinyint(1) NOT NULL,
  `q_num_choosable_answers` int(11) NOT NULL,
  `q_quiz` int(11) NOT NULL,
  `q_question_text` int(10) unsigned NOT NULL,
  `q_order` int(11) NOT NULL,
  `q_required` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_quiz_winner`;

CREATE TABLE `ocp7_quiz_winner` (
  `q_quiz` int(11) NOT NULL,
  `q_entry` int(11) NOT NULL,
  `q_winner_level` int(11) NOT NULL,
  PRIMARY KEY (`q_quiz`,`q_entry`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_quizzes`;

CREATE TABLE `ocp7_quizzes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `q_timeout` int(11) DEFAULT NULL,
  `q_name` int(10) unsigned NOT NULL,
  `q_start_text` int(10) unsigned NOT NULL,
  `q_end_text` int(10) unsigned NOT NULL,
  `q_notes` longtext COLLATE latin1_bin NOT NULL,
  `q_percentage` int(11) NOT NULL,
  `q_open_time` int(10) unsigned NOT NULL,
  `q_close_time` int(10) unsigned DEFAULT NULL,
  `q_num_winners` int(11) NOT NULL,
  `q_redo_time` int(11) DEFAULT NULL,
  `q_type` varchar(80) COLLATE latin1_bin NOT NULL,
  `q_add_date` int(10) unsigned NOT NULL,
  `q_validated` tinyint(1) NOT NULL,
  `q_submitter` int(11) NOT NULL,
  `q_points_for_passing` int(11) NOT NULL,
  `q_tied_newsletter` int(11) DEFAULT NULL,
  `q_end_text_fail` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `q_validated` (`q_validated`),
  KEY `ftjoin_qstarttext` (`q_start_text`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_sales`;

CREATE TABLE `ocp7_sales` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date_and_time` int(10) unsigned NOT NULL,
  `memberid` int(11) NOT NULL,
  `purchasetype` varchar(80) COLLATE latin1_bin NOT NULL,
  `details` varchar(255) COLLATE latin1_bin NOT NULL,
  `details2` varchar(255) COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_searches_logged`;

CREATE TABLE `ocp7_searches_logged` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `s_member_id` int(11) NOT NULL,
  `s_time` int(10) unsigned NOT NULL,
  `s_primary` varchar(255) COLLATE latin1_bin NOT NULL,
  `s_auxillary` longtext COLLATE latin1_bin NOT NULL,
  `s_num_results` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `past_search` (`s_primary`),
  FULLTEXT KEY `past_search_ft` (`s_primary`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_searches_saved`;

CREATE TABLE `ocp7_searches_saved` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `s_title` varchar(255) COLLATE latin1_bin NOT NULL,
  `s_member_id` int(11) NOT NULL,
  `s_time` int(10) unsigned NOT NULL,
  `s_primary` varchar(255) COLLATE latin1_bin NOT NULL,
  `s_auxillary` longtext COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_seedy_changes`;

CREATE TABLE `ocp7_seedy_changes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `the_action` varchar(80) COLLATE latin1_bin NOT NULL,
  `the_page` int(11) NOT NULL,
  `date_and_time` int(10) unsigned NOT NULL,
  `ip` varchar(40) COLLATE latin1_bin NOT NULL,
  `the_user` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_seedy_children`;

CREATE TABLE `ocp7_seedy_children` (
  `parent_id` int(11) NOT NULL,
  `child_id` int(11) NOT NULL,
  `the_order` int(11) NOT NULL,
  `title` varchar(255) COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`parent_id`,`child_id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_seedy_pages`;

CREATE TABLE `ocp7_seedy_pages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` int(10) unsigned NOT NULL,
  `notes` longtext COLLATE latin1_bin NOT NULL,
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
) ENGINE=MyISAM AUTO_INCREMENT=2;

insert into `ocp7_seedy_pages` values('1','302','','303','1295956140','0','0','1');

DROP TABLE IF EXISTS `ocp7_seedy_posts`;

CREATE TABLE `ocp7_seedy_posts` (
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
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_shopping_cart`;

CREATE TABLE `ocp7_shopping_cart` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `session_id` int(11) NOT NULL,
  `ordered_by` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_name` varchar(255) COLLATE latin1_bin NOT NULL,
  `product_code` varchar(255) COLLATE latin1_bin NOT NULL,
  `quantity` int(11) NOT NULL,
  `price_pre_tax` double NOT NULL,
  `price` double NOT NULL,
  `product_description` longtext COLLATE latin1_bin NOT NULL,
  `product_type` varchar(255) COLLATE latin1_bin NOT NULL,
  `product_weight` double NOT NULL,
  `is_deleted` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`,`ordered_by`,`product_id`),
  KEY `ordered_by` (`ordered_by`),
  KEY `session_id` (`session_id`),
  KEY `product_id` (`product_id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_shopping_logging`;

CREATE TABLE `ocp7_shopping_logging` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `e_member_id` int(11) NOT NULL,
  `session_id` int(11) NOT NULL,
  `ip` varchar(40) COLLATE latin1_bin NOT NULL,
  `last_action` varchar(255) COLLATE latin1_bin NOT NULL,
  `date_and_time` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`,`e_member_id`),
  KEY `calculate_bandwidth` (`date_and_time`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_shopping_order`;

CREATE TABLE `ocp7_shopping_order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `c_member` int(11) NOT NULL,
  `session_id` int(11) NOT NULL,
  `add_date` int(10) unsigned NOT NULL,
  `tot_price` double NOT NULL,
  `order_status` varchar(80) COLLATE latin1_bin NOT NULL,
  `notes` longtext COLLATE latin1_bin NOT NULL,
  `transaction_id` varchar(255) COLLATE latin1_bin NOT NULL,
  `purchase_through` varchar(255) COLLATE latin1_bin NOT NULL,
  `tax_opted_out` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `finddispatchable` (`order_status`),
  KEY `soc_member` (`c_member`),
  KEY `sosession_id` (`session_id`),
  KEY `soadd_date` (`add_date`),
  KEY `recent_shopped` (`add_date`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_shopping_order_addresses`;

CREATE TABLE `ocp7_shopping_order_addresses` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(11) DEFAULT NULL,
  `address_name` varchar(255) COLLATE latin1_bin NOT NULL,
  `address_street` longtext COLLATE latin1_bin NOT NULL,
  `address_city` varchar(255) COLLATE latin1_bin NOT NULL,
  `address_zip` varchar(255) COLLATE latin1_bin NOT NULL,
  `address_country` varchar(255) COLLATE latin1_bin NOT NULL,
  `receiver_email` varchar(255) COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_shopping_order_details`;

CREATE TABLE `ocp7_shopping_order_details` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(11) DEFAULT NULL,
  `p_id` int(11) DEFAULT NULL,
  `p_name` varchar(255) COLLATE latin1_bin NOT NULL,
  `p_code` varchar(255) COLLATE latin1_bin NOT NULL,
  `p_type` varchar(255) COLLATE latin1_bin NOT NULL,
  `p_quantity` int(11) NOT NULL,
  `p_price` double NOT NULL,
  `included_tax` double NOT NULL,
  `dispatch_status` varchar(255) COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`id`),
  KEY `p_id` (`p_id`),
  KEY `order_id` (`order_id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_sitewatchlist`;

CREATE TABLE `ocp7_sitewatchlist` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `siteurl` varchar(255) COLLATE latin1_bin NOT NULL,
  `site_name` varchar(255) COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2;

insert into `ocp7_sitewatchlist` values('1','http://localhost/svn/code/4.2.x','');

DROP TABLE IF EXISTS `ocp7_staff_tips_dismissed`;

CREATE TABLE `ocp7_staff_tips_dismissed` (
  `t_member` int(11) NOT NULL,
  `t_tip` varchar(80) COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`t_member`,`t_tip`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_stafflinks`;

CREATE TABLE `ocp7_stafflinks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `link` varchar(255) COLLATE latin1_bin NOT NULL,
  `link_title` varchar(255) COLLATE latin1_bin NOT NULL,
  `link_desc` longtext COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=28;

insert into `ocp7_stafflinks` values('1','http://ocportal.com/','ocPortal.com',0x6f63506f7274616c2e636f6d),
 ('2','http://ocportal.com/forum/vforums/unread.htm','ocPortal.com (topics with unread posts)',0x6f63506f7274616c2e636f6d2028746f70696373207769746820756e7265616420706f73747329),
 ('3','http://ocproducts.com/','ocProducts (web development services)',0x6f6350726f6475637473202877656220646576656c6f706d656e7420736572766963657329),
 ('4','https://translations.launchpad.net/ocportal/+translations','Launchpad (ocPortal language translations)',0x4c61756e636870616420286f63506f7274616c206c616e6775616765207472616e736c6174696f6e7329),
 ('5','http://www.google.com/analytics/','Google Analytics',0x476f6f676c6520416e616c7974696373),
 ('6','https://www.google.com/webmasters/tools','Google Webmaster Tools',0x476f6f676c65205765626d617374657220546f6f6c73),
 ('7','http://www.google.com/apps/intl/en/group/index.html','Google Apps (free gmail for domains, etc)',0x476f6f676c65204170707320286672656520676d61696c20666f7220646f6d61696e732c2065746329),
 ('8','http://www.google.com/chrome','Google Chrome (web browser)',0x476f6f676c65204368726f6d6520287765622062726f7773657229),
 ('9','https://chrome.google.com/extensions/featured/web_dev','Google Chrome addons',0x476f6f676c65204368726f6d65206164646f6e73),
 ('10','http://www.getfirefox.com/','Firefox (web browser)',0x46697265666f7820287765622062726f7773657229),
 ('11','http://www.instantshift.com/2009/01/25/26-essential-firefox-add-ons-for-web-designers/','FireFox addons',0x46697265466f78206164646f6e73),
 ('12','http://www.opera.com/','Opera (web browser)',0x4f7065726120287765622062726f7773657229),
 ('13','http://finalbuilds.edskes.net/iecollection.htm','Internet Explorer Collection (for testing)',0x496e7465726e6574204578706c6f72657220436f6c6c656374696f6e2028666f722074657374696e6729),
 ('14','http://www.getpaint.net/','Paint.net (free graphics tool)',0x5061696e742e6e657420286672656520677261706869637320746f6f6c29),
 ('15','http://benhollis.net/software/pnggauntlet/','PNGGauntlet (compress PNG files, Windows)',0x504e474761756e746c65742028636f6d707265737320504e472066696c65732c2057696e646f777329),
 ('16','http://www.leveltendesign.com/blog/nickc/pngthing-v11-previously-pngoptimizer','pngThing (compress PNG files, Mac)',0x706e675468696e672028636f6d707265737320504e472066696c65732c204d616329),
 ('17','http://www.iconlet.com/','Iconlet (free icons)',0x49636f6e6c65742028667265652069636f6e7329),
 ('18','http://sxc.hu/','stock.xchng (free stock art)',0x73746f636b2e7863686e672028667265652073746f636b2061727429),
 ('19','http://www.kompozer.net/','Kompozer (Web design tool)',0x4b6f6d706f7a657220285765622064657369676e20746f6f6c29),
 ('20','http://www.sourcegear.com/diffmerge/','DiffMerge',0x446966664d65726765),
 ('21','http://www.jingproject.com/','Jing (record screencasts)',0x4a696e6720287265636f72642073637265656e636173747329),
 ('22','http://www.elief.com/billing/aff.php?aff=035','Elief hosting (quality shared hosting)',0x456c69656620686f7374696e6720287175616c6974792073686172656420686f7374696e6729),
 ('23','http://www.rackspacecloud.com/1043-0-3-13.html','Rackspace Cloud hosting',0x5261636b737061636520436c6f756420686f7374696e67),
 ('24','http://www.jdoqocy.com/click-3972552-10378406','GoDaddy (Domains and SSL certificates)',0x476f44616464792028446f6d61696e7320616e642053534c2063657274696669636174657329),
 ('25','http://www.silktide.com/siteray','SiteRay (site quality auditing)',0x53697465526179202873697465207175616c697479206175646974696e6729),
 ('26','http://www.smashingmagazine.com/','Smashing Magazine (web design articles)',0x536d617368696e67204d6167617a696e6520287765622064657369676e2061727469636c657329),
 ('27','http://www.w3schools.com/','w3schools (learn web technologies)',0x77337363686f6f6c7320286c6561726e2077656220746563686e6f6c6f6769657329);

DROP TABLE IF EXISTS `ocp7_subscriptions`;

CREATE TABLE `ocp7_subscriptions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `s_type_code` varchar(80) COLLATE latin1_bin NOT NULL,
  `s_member_id` int(11) NOT NULL,
  `s_state` varchar(80) COLLATE latin1_bin NOT NULL,
  `s_amount` varchar(255) COLLATE latin1_bin NOT NULL,
  `s_special` varchar(255) COLLATE latin1_bin NOT NULL,
  `s_time` int(10) unsigned NOT NULL,
  `s_auto_fund_source` varchar(80) COLLATE latin1_bin NOT NULL,
  `s_auto_fund_key` varchar(255) COLLATE latin1_bin NOT NULL,
  `s_via` varchar(80) COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_test_sections`;

CREATE TABLE `ocp7_test_sections` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `s_section` varchar(255) COLLATE latin1_bin NOT NULL,
  `s_notes` longtext COLLATE latin1_bin NOT NULL,
  `s_inheritable` tinyint(1) NOT NULL,
  `s_assigned_to` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_tests`;

CREATE TABLE `ocp7_tests` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `t_section` int(11) NOT NULL,
  `t_test` longtext COLLATE latin1_bin NOT NULL,
  `t_assigned_to` int(11) DEFAULT NULL,
  `t_enabled` tinyint(1) NOT NULL,
  `t_status` int(11) NOT NULL,
  `t_inherit_section` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_ticket_types`;

CREATE TABLE `ocp7_ticket_types` (
  `ticket_type` int(10) unsigned NOT NULL,
  `guest_emails_mandatory` tinyint(1) NOT NULL,
  `search_faq` tinyint(1) NOT NULL,
  `send_sms_to` varchar(255) COLLATE latin1_bin NOT NULL,
  `cache_lead_time` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`ticket_type`)
) ENGINE=MyISAM;

insert into `ocp7_ticket_types` values('401','0','0','',null),
 ('402','0','0','',null);

DROP TABLE IF EXISTS `ocp7_tickets`;

CREATE TABLE `ocp7_tickets` (
  `ticket_id` varchar(255) COLLATE latin1_bin NOT NULL,
  `topic_id` int(11) NOT NULL,
  `forum_id` int(11) NOT NULL,
  `ticket_type` int(10) unsigned NOT NULL,
  PRIMARY KEY (`ticket_id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_trans_expecting`;

CREATE TABLE `ocp7_trans_expecting` (
  `id` varchar(80) COLLATE latin1_bin NOT NULL,
  `e_purchase_id` varchar(80) COLLATE latin1_bin NOT NULL,
  `e_item_name` varchar(255) COLLATE latin1_bin NOT NULL,
  `e_member_id` int(11) NOT NULL,
  `e_amount` varchar(255) COLLATE latin1_bin NOT NULL,
  `e_ip_address` varchar(40) COLLATE latin1_bin NOT NULL,
  `e_session_id` int(11) NOT NULL,
  `e_time` int(10) unsigned NOT NULL,
  `e_length` int(11) DEFAULT NULL,
  `e_length_units` varchar(80) COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_transactions`;

CREATE TABLE `ocp7_transactions` (
  `id` varchar(80) COLLATE latin1_bin NOT NULL,
  `purchase_id` varchar(80) COLLATE latin1_bin NOT NULL,
  `status` varchar(255) COLLATE latin1_bin NOT NULL,
  `reason` varchar(255) COLLATE latin1_bin NOT NULL,
  `amount` varchar(255) COLLATE latin1_bin NOT NULL,
  `t_currency` varchar(80) COLLATE latin1_bin NOT NULL,
  `linked` varchar(80) COLLATE latin1_bin NOT NULL,
  `t_time` int(10) unsigned NOT NULL,
  `item` varchar(255) COLLATE latin1_bin NOT NULL,
  `pending_reason` varchar(255) COLLATE latin1_bin NOT NULL,
  `t_memo` longtext COLLATE latin1_bin NOT NULL,
  `t_via` varchar(80) COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`id`,`t_time`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_videos`;

CREATE TABLE `ocp7_videos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cat` varchar(80) COLLATE latin1_bin NOT NULL,
  `url` varchar(255) COLLATE latin1_bin NOT NULL,
  `thumb_url` varchar(255) COLLATE latin1_bin NOT NULL,
  `comments` int(10) unsigned NOT NULL,
  `allow_rating` tinyint(1) NOT NULL,
  `allow_comments` tinyint(4) NOT NULL,
  `allow_trackbacks` tinyint(1) NOT NULL,
  `notes` longtext COLLATE latin1_bin NOT NULL,
  `submitter` int(11) NOT NULL,
  `validated` tinyint(1) NOT NULL,
  `add_date` int(10) unsigned NOT NULL,
  `edit_date` int(10) unsigned DEFAULT NULL,
  `video_views` int(11) NOT NULL,
  `video_width` int(11) NOT NULL,
  `video_height` int(11) NOT NULL,
  `video_length` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `video_views` (`video_views`),
  KEY `vs` (`submitter`),
  KEY `v_validated` (`validated`),
  KEY `category_list` (`cat`),
  KEY `vadd_date` (`add_date`),
  KEY `ftjoin_vcomments` (`comments`)
) ENGINE=MyISAM;
