DROP TABLE IF EXISTS `ocp7_values`;

CREATE TABLE `ocp7_values` (
  `the_name` varchar(80) COLLATE latin1_bin NOT NULL,
  `the_value` varchar(80) COLLATE latin1_bin NOT NULL,
  `date_and_time` int(10) unsigned NOT NULL,
  PRIMARY KEY (`the_name`),
  KEY `date_and_time` (`date_and_time`)
) ENGINE=MyISAM;

insert into `ocp7_values` values('version','6','1295956121'),
 ('ocf_version','6','1295956121');

DROP TABLE IF EXISTS `ocp7_zones`;

CREATE TABLE `ocp7_zones` (
  `zone_name` varchar(80) COLLATE latin1_bin NOT NULL,
  `zone_title` int(10) unsigned NOT NULL,
  `zone_default_page` varchar(80) COLLATE latin1_bin NOT NULL,
  `zone_header_text` int(10) unsigned NOT NULL,
  `zone_theme` varchar(80) COLLATE latin1_bin NOT NULL,
  `zone_wide` tinyint(1) DEFAULT NULL,
  `zone_require_session` tinyint(1) NOT NULL,
  `zone_displayed_in_menu` tinyint(1) NOT NULL,
  PRIMARY KEY (`zone_name`)
) ENGINE=MyISAM;

insert into `ocp7_zones` values('','7','start','1','-1','0','0','0'),
 ('adminzone','8','start','2','default','0','1','1'),
 ('site','9','start','4','-1','0','0','1'),
 ('collaboration','10','start','3','-1','0','0','1'),
 ('cms','11','cms','5','default','0','1','1'),
 ('forum','14','forumview','12','-1',null,'0','1');

DROP TABLE IF EXISTS `ocp7_addons`;

CREATE TABLE `ocp7_addons` (
  `addon_name` varchar(255) COLLATE latin1_bin NOT NULL,
  `addon_author` varchar(255) COLLATE latin1_bin NOT NULL,
  `addon_organisation` varchar(255) COLLATE latin1_bin NOT NULL,
  `addon_version` varchar(255) COLLATE latin1_bin NOT NULL,
  `addon_description` longtext COLLATE latin1_bin NOT NULL,
  `addon_install_time` int(10) unsigned NOT NULL,
  PRIMARY KEY (`addon_name`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_addons_dependencies`;

CREATE TABLE `ocp7_addons_dependencies` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `addon_name` varchar(255) COLLATE latin1_bin NOT NULL,
  `addon_name_dependant_upon` varchar(255) COLLATE latin1_bin NOT NULL,
  `addon_name_incompatibility` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_addons_files`;

CREATE TABLE `ocp7_addons_files` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `addon_name` varchar(255) COLLATE latin1_bin NOT NULL,
  `filename` varchar(255) COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_authors`;

CREATE TABLE `ocp7_authors` (
  `author` varchar(80) COLLATE latin1_bin NOT NULL,
  `url` varchar(255) COLLATE latin1_bin NOT NULL,
  `forum_handle` int(11) DEFAULT NULL,
  `description` int(10) unsigned NOT NULL,
  `skills` int(10) unsigned NOT NULL,
  PRIMARY KEY (`author`),
  KEY `findmemberlink` (`forum_handle`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_autosave`;

CREATE TABLE `ocp7_autosave` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `a_member_id` int(11) NOT NULL,
  `a_key` longtext COLLATE latin1_bin NOT NULL,
  `a_value` longtext COLLATE latin1_bin NOT NULL,
  `a_time` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `myautosaves` (`a_member_id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_award_archive`;

CREATE TABLE `ocp7_award_archive` (
  `a_type_id` int(11) NOT NULL,
  `date_and_time` int(10) unsigned NOT NULL,
  `content_id` varchar(80) COLLATE latin1_bin NOT NULL,
  `member_id` int(11) NOT NULL,
  PRIMARY KEY (`a_type_id`,`date_and_time`),
  KEY `awardquicksearch` (`content_id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_award_types`;

CREATE TABLE `ocp7_award_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `a_title` int(10) unsigned NOT NULL,
  `a_description` int(10) unsigned NOT NULL,
  `a_points` int(11) NOT NULL,
  `a_content_type` varchar(80) COLLATE latin1_bin NOT NULL,
  `a_hide_awardee` tinyint(1) NOT NULL,
  `a_update_time_hours` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2;

insert into `ocp7_award_types` values('1','85','86','0','download','1','168');

DROP TABLE IF EXISTS `ocp7_banner_clicks`;

CREATE TABLE `ocp7_banner_clicks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `c_date_and_time` int(10) unsigned NOT NULL,
  `c_member_id` int(11) NOT NULL,
  `c_ip_address` varchar(40) COLLATE latin1_bin NOT NULL,
  `c_source` varchar(80) COLLATE latin1_bin NOT NULL,
  `c_banner_id` varchar(80) COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`id`),
  KEY `clicker_ip` (`c_ip_address`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_banner_types`;

CREATE TABLE `ocp7_banner_types` (
  `id` varchar(80) COLLATE latin1_bin NOT NULL,
  `t_is_textual` tinyint(1) NOT NULL,
  `t_image_width` int(11) NOT NULL,
  `t_image_height` int(11) NOT NULL,
  `t_max_file_size` int(11) NOT NULL,
  `t_comcode_inline` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `hottext` (`t_comcode_inline`)
) ENGINE=MyISAM;

insert into `ocp7_banner_types` values('','0','468','60','80','0');

DROP TABLE IF EXISTS `ocp7_banners`;

CREATE TABLE `ocp7_banners` (
  `name` varchar(80) COLLATE latin1_bin NOT NULL,
  `expiry_date` int(10) unsigned DEFAULT NULL,
  `submitter` int(11) NOT NULL,
  `img_url` varchar(255) COLLATE latin1_bin NOT NULL,
  `b_title_text` varchar(255) COLLATE latin1_bin NOT NULL,
  `the_type` tinyint(4) NOT NULL,
  `caption` int(10) unsigned NOT NULL,
  `campaign_remaining` int(11) NOT NULL,
  `site_url` varchar(255) COLLATE latin1_bin NOT NULL,
  `hits_from` int(11) NOT NULL,
  `views_from` int(11) NOT NULL,
  `hits_to` int(11) NOT NULL,
  `views_to` int(11) NOT NULL,
  `importance_modulus` int(11) NOT NULL,
  `notes` longtext COLLATE latin1_bin NOT NULL,
  `validated` tinyint(1) NOT NULL,
  `add_date` int(10) unsigned NOT NULL,
  `edit_date` int(10) unsigned DEFAULT NULL,
  `b_type` varchar(80) COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`name`),
  KEY `banner_child_find` (`b_type`),
  KEY `the_type` (`the_type`),
  KEY `expiry_date` (`expiry_date`),
  KEY `badd_date` (`add_date`),
  KEY `topsites` (`hits_from`,`hits_to`),
  KEY `campaign_remaining` (`campaign_remaining`),
  KEY `bvalidated` (`validated`)
) ENGINE=MyISAM;

insert into `ocp7_banners` values('advertise_here',null,'1','data/images/advertise_here.png','','2','161','0','http://localhost/svn/code/4.2.x/site/index.php?page=advertise','0','0','0','0','10',0x50726f76696465642061732064656661756c742e205468697320697320612064656661756c742062616e6e6572202869742073686f7773207768656e206f746865727320617265206e6f7420617661696c61626c65292e,'1','1295956132',null,''),
 ('hosting',null,'1','data/images/hosting.png','','0','162','0','http://localhost/svn/code/4.2.x/site/index.php?page=hosting-submit','0','0','0','0','32',0x50726f76696465642061732064656661756c742e,'1','1295956132',null,''),
 ('donate',null,'1','data/images/donate.png','','0','163','0','http://localhost/svn/code/4.2.x/site/index.php?page=donate','0','0','0','0','30',0x50726f76696465642061732064656661756c742e,'1','1295956132',null,'');

DROP TABLE IF EXISTS `ocp7_bookmarks`;

CREATE TABLE `ocp7_bookmarks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `b_owner` int(11) NOT NULL,
  `b_folder` varchar(255) COLLATE latin1_bin NOT NULL,
  `b_title` varchar(255) COLLATE latin1_bin NOT NULL,
  `b_page_link` varchar(255) COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_cache`;

CREATE TABLE `ocp7_cache` (
  `cached_for` varchar(80) COLLATE latin1_bin NOT NULL,
  `identifier` varchar(40) COLLATE latin1_bin NOT NULL,
  `the_value` longtext COLLATE latin1_bin NOT NULL,
  `date_and_time` int(10) unsigned NOT NULL,
  `the_theme` varchar(80) COLLATE latin1_bin NOT NULL,
  `lang` varchar(5) COLLATE latin1_bin NOT NULL,
  `langs_required` longtext COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`cached_for`,`identifier`,`the_theme`,`lang`),
  KEY `cached_ford` (`date_and_time`),
  KEY `cached_fore` (`cached_for`),
  KEY `cached_forf` (`lang`),
  KEY `cached_forg` (`identifier`),
  KEY `cached_forh` (`the_theme`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_cache_on`;

CREATE TABLE `ocp7_cache_on` (
  `cached_for` varchar(80) COLLATE latin1_bin NOT NULL,
  `cache_on` longtext COLLATE latin1_bin NOT NULL,
  `cache_ttl` int(11) NOT NULL,
  PRIMARY KEY (`cached_for`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_calendar_events`;

CREATE TABLE `ocp7_calendar_events` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `e_submitter` int(11) NOT NULL,
  `e_views` int(11) NOT NULL,
  `e_title` int(10) unsigned NOT NULL,
  `e_content` int(10) unsigned NOT NULL,
  `e_add_date` int(10) unsigned NOT NULL,
  `e_edit_date` int(10) unsigned DEFAULT NULL,
  `e_geo_position` varchar(255) COLLATE latin1_bin NOT NULL,
  `e_recurrence` varchar(80) COLLATE latin1_bin NOT NULL,
  `e_recurrences` int(11) DEFAULT NULL,
  `e_seg_recurrences` tinyint(1) NOT NULL,
  `e_start_year` int(11) NOT NULL,
  `e_start_month` int(11) NOT NULL,
  `e_start_day` int(11) NOT NULL,
  `e_start_hour` int(11) NOT NULL,
  `e_start_minute` int(11) NOT NULL,
  `e_end_year` int(11) DEFAULT NULL,
  `e_end_month` int(11) DEFAULT NULL,
  `e_end_day` int(11) DEFAULT NULL,
  `e_end_hour` int(11) DEFAULT NULL,
  `e_end_minute` int(11) DEFAULT NULL,
  `e_is_public` tinyint(1) NOT NULL,
  `e_groups_access` varchar(255) COLLATE latin1_bin NOT NULL,
  `e_groups_modify` varchar(255) COLLATE latin1_bin NOT NULL,
  `e_priority` int(11) NOT NULL,
  `allow_rating` tinyint(1) NOT NULL,
  `allow_comments` tinyint(4) NOT NULL,
  `allow_trackbacks` tinyint(1) NOT NULL,
  `notes` longtext COLLATE latin1_bin NOT NULL,
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


DROP TABLE IF EXISTS `ocp7_calendar_interests`;

CREATE TABLE `ocp7_calendar_interests` (
  `i_member_id` int(11) NOT NULL,
  `t_type` int(11) NOT NULL,
  PRIMARY KEY (`i_member_id`,`t_type`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_calendar_jobs`;

CREATE TABLE `ocp7_calendar_jobs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `j_time` int(10) unsigned NOT NULL,
  `j_reminder_id` int(11) DEFAULT NULL,
  `j_member_id` int(11) DEFAULT NULL,
  `j_event_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `applicablejobs` (`j_time`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_calendar_reminders`;

CREATE TABLE `ocp7_calendar_reminders` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `e_id` int(11) NOT NULL,
  `n_member_id` int(11) NOT NULL,
  `n_seconds_before` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_calendar_types`;

CREATE TABLE `ocp7_calendar_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `t_title` int(10) unsigned NOT NULL,
  `t_logo` varchar(255) COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=9;

insert into `ocp7_calendar_types` values('1','166','calendar/system_command'),
 ('2','167','calendar/general'),
 ('3','168','calendar/birthday'),
 ('4','169','calendar/public_holiday'),
 ('5','170','calendar/vacation'),
 ('6','171','calendar/appointment'),
 ('7','172','calendar/commitment'),
 ('8','173','calendar/anniversary');

DROP TABLE IF EXISTS `ocp7_catalogue_categories`;

CREATE TABLE `ocp7_catalogue_categories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `c_name` varchar(80) COLLATE latin1_bin NOT NULL,
  `cc_title` int(10) unsigned NOT NULL,
  `cc_description` int(10) unsigned NOT NULL,
  `rep_image` varchar(255) COLLATE latin1_bin NOT NULL,
  `cc_notes` longtext COLLATE latin1_bin NOT NULL,
  `cc_add_date` int(10) unsigned NOT NULL,
  `cc_parent_id` int(11) DEFAULT NULL,
  `cc_move_target` int(11) DEFAULT NULL,
  `cc_move_days_lower` int(11) NOT NULL,
  `cc_move_days_higher` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `catstoclean` (`cc_move_target`),
  KEY `cataloguefind` (`c_name`),
  KEY `ftjoin_cctitle` (`cc_title`),
  KEY `ftjoin_ccdescrip` (`cc_description`)
) ENGINE=MyISAM AUTO_INCREMENT=7;

insert into `ocp7_catalogue_categories` values('1','projects','186','187','','','1295956137',null,null,'30','60'),
 ('2','hosted','214','215','','','1295956137',null,null,'30','60'),
 ('3','links','220','221','','','1295956137',null,null,'30','60'),
 ('4','faqs','238','239','','','1295956137',null,null,'30','60'),
 ('5','contacts','268','269','','','1295956137',null,null,'30','60'),
 ('6','products','278','279','','','1295956137',null,null,'30','60');

DROP TABLE IF EXISTS `ocp7_catalogue_efv_long`;

CREATE TABLE `ocp7_catalogue_efv_long` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cf_id` int(11) NOT NULL,
  `ce_id` int(11) NOT NULL,
  `cv_value` longtext COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`id`),
  KEY `lcf_id` (`cf_id`),
  KEY `lce_id` (`ce_id`),
  FULLTEXT KEY `lcv_value` (`cv_value`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_catalogue_efv_long_trans`;

CREATE TABLE `ocp7_catalogue_efv_long_trans` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cf_id` int(11) NOT NULL,
  `ce_id` int(11) NOT NULL,
  `cv_value` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ltcf_id` (`cf_id`),
  KEY `ltce_id` (`ce_id`),
  KEY `ltcv_value` (`cv_value`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_catalogue_efv_short`;

CREATE TABLE `ocp7_catalogue_efv_short` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cf_id` int(11) NOT NULL,
  `ce_id` int(11) NOT NULL,
  `cv_value` varchar(255) COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`id`),
  KEY `iscv_value` (`cv_value`),
  KEY `scf_id` (`cf_id`),
  KEY `sce_id` (`ce_id`),
  FULLTEXT KEY `scv_value` (`cv_value`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_catalogue_efv_short_trans`;

CREATE TABLE `ocp7_catalogue_efv_short_trans` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cf_id` int(11) NOT NULL,
  `ce_id` int(11) NOT NULL,
  `cv_value` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `stcf_id` (`cf_id`),
  KEY `stce_id` (`ce_id`),
  KEY `stcv_value` (`cv_value`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_catalogue_entries`;

CREATE TABLE `ocp7_catalogue_entries` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `c_name` varchar(80) COLLATE latin1_bin NOT NULL,
  `cc_id` int(11) NOT NULL,
  `ce_submitter` int(11) NOT NULL,
  `ce_add_date` int(10) unsigned NOT NULL,
  `ce_edit_date` int(10) unsigned DEFAULT NULL,
  `ce_views` int(11) NOT NULL,
  `ce_views_prior` int(11) NOT NULL,
  `ce_validated` tinyint(1) NOT NULL,
  `notes` longtext COLLATE latin1_bin NOT NULL,
  `allow_rating` tinyint(1) NOT NULL,
  `allow_comments` tinyint(4) NOT NULL,
  `allow_trackbacks` tinyint(1) NOT NULL,
  `ce_last_moved` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ce_views` (`ce_views`),
  KEY `ces` (`ce_submitter`),
  KEY `ce_validated` (`ce_validated`),
  KEY `ce_cc_id` (`cc_id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_catalogue_fields`;

CREATE TABLE `ocp7_catalogue_fields` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `c_name` varchar(80) COLLATE latin1_bin NOT NULL,
  `cf_name` int(10) unsigned NOT NULL,
  `cf_description` int(10) unsigned NOT NULL,
  `cf_type` varchar(80) COLLATE latin1_bin NOT NULL,
  `cf_order` int(11) NOT NULL,
  `cf_defines_order` tinyint(4) NOT NULL,
  `cf_visible` tinyint(1) NOT NULL,
  `cf_searchable` tinyint(1) NOT NULL,
  `cf_default` longtext COLLATE latin1_bin NOT NULL,
  `cf_required` tinyint(1) NOT NULL,
  `cf_put_in_category` tinyint(1) NOT NULL,
  `cf_put_in_search` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=42;

insert into `ocp7_catalogue_fields` values('1','projects','178','179','short_trans','0','1','1','1','','1','1','1'),
 ('2','projects','180','181','user','1','0','1','1','','1','1','1'),
 ('3','projects','182','183','long_trans','2','0','1','1','','1','1','1'),
 ('4','projects','184','185','integer','3','0','1','1','','1','1','1'),
 ('5','modifications','192','193','short_trans','0','1','1','1','','1','1','1'),
 ('6','modifications','194','195','picture','1','0','1','1','','0','1','1'),
 ('7','modifications','196','197','short_trans','2','0','1','1','','1','1','1'),
 ('8','modifications','198','199','url','3','0','1','1','','0','1','1'),
 ('9','modifications','200','201','long_trans','4','0','1','1','','1','1','1'),
 ('10','modifications','202','203','short_text','5','0','1','1','','1','1','1'),
 ('11','hosted','208','209','short_trans','0','1','1','1','','1','1','1'),
 ('12','hosted','210','211','url','1','0','1','1','','0','1','1'),
 ('13','hosted','212','213','long_trans','2','0','1','1','','0','1','1'),
 ('14','links','222','223','short_trans','0','1','1','1','','1','1','1'),
 ('15','links','224','225','url','1','0','1','1','','1','0','1'),
 ('16','links','226','227','long_trans','2','0','1','1','','0','1','1'),
 ('17','faqs','232','233','short_trans','0','0','1','1','','1','1','1'),
 ('18','faqs','234','235','long_trans','1','0','1','1','','1','1','1'),
 ('19','faqs','236','237','integer','2','1','0','1','','1','1','1'),
 ('20','contacts','244','245','short_text','0','0','1','1','','1','1','1'),
 ('21','contacts','246','247','short_text','1','1','1','1','','1','1','1'),
 ('22','contacts','248','249','short_text','2','0','1','1','','1','1','1'),
 ('23','contacts','250','251','short_text','3','0','1','1','','1','1','1'),
 ('24','contacts','252','253','short_text','4','0','1','1','','1','1','1'),
 ('25','contacts','254','255','short_text','5','0','1','1','','1','1','1'),
 ('26','contacts','256','257','short_text','6','0','1','1','','1','1','1'),
 ('27','contacts','258','259','short_text','7','0','1','1','','1','1','1'),
 ('28','contacts','260','261','short_text','8','0','1','1','','1','1','1'),
 ('29','contacts','262','263','short_text','9','0','1','1','','1','1','1'),
 ('30','contacts','264','265','long_text','10','0','1','1','','1','1','1'),
 ('31','contacts','266','267','long_text','11','0','1','1','','1','1','1'),
 ('32','products','280','281','short_trans','0','1','1','1','','1','1','1'),
 ('33','products','282','283','random','1','0','1','1','','1','1','1'),
 ('34','products','284','285','float','2','0','1','1','','1','1','1'),
 ('35','products','286','287','integer','3','0','1','0','','0','1','1'),
 ('36','products','288','289','integer','4','0','0','0','','0','0','0'),
 ('37','products','290','291','list','5','0','0','0',0x4e6f7c596573,'1','0','0'),
 ('38','products','292','293','list','6','0','0','0',0x30257c35257c31372e3525,'1','0','0'),
 ('39','products','294','295','picture','7','0','1','1','','0','1','1'),
 ('40','products','296','297','float','8','0','0','0','','1','0','0'),
 ('41','products','298','299','long_trans','9','0','1','1','','1','1','1');

DROP TABLE IF EXISTS `ocp7_catalogues`;

CREATE TABLE `ocp7_catalogues` (
  `c_name` varchar(80) COLLATE latin1_bin NOT NULL,
  `c_title` int(10) unsigned NOT NULL,
  `c_description` int(10) unsigned NOT NULL,
  `c_display_type` tinyint(4) NOT NULL,
  `c_is_tree` tinyint(1) NOT NULL,
  `c_notes` longtext COLLATE latin1_bin NOT NULL,
  `c_add_date` int(10) unsigned NOT NULL,
  `c_submit_points` int(11) NOT NULL,
  `c_ecommerce` tinyint(1) NOT NULL,
  `c_send_view_reports` varchar(80) COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`c_name`)
) ENGINE=MyISAM;

insert into `ocp7_catalogues` values('projects','176','177','0','0','','1295956136','30','0','never'),
 ('modifications','190','191','1','0','','1295956137','60','0','never'),
 ('hosted','206','207','0','0','','1295956137','0','0','never'),
 ('links','218','219','2','1','','1295956137','0','0','never'),
 ('faqs','230','231','0','0','','1295956137','0','0','never'),
 ('contacts','242','243','0','0','','1295956137','30','0','never'),
 ('products','276','277','1','1','','1295956137','0','1','never');

DROP TABLE IF EXISTS `ocp7_custom_comcode`;

CREATE TABLE `ocp7_custom_comcode` (
  `tag_tag` varchar(80) COLLATE latin1_bin NOT NULL,
  `tag_title` int(10) unsigned NOT NULL,
  `tag_description` int(10) unsigned NOT NULL,
  `tag_replace` longtext COLLATE latin1_bin NOT NULL,
  `tag_example` longtext COLLATE latin1_bin NOT NULL,
  `tag_parameters` varchar(255) COLLATE latin1_bin NOT NULL,
  `tag_enabled` tinyint(1) NOT NULL,
  `tag_dangerous_tag` tinyint(1) NOT NULL,
  `tag_block_tag` tinyint(1) NOT NULL,
  `tag_textual_tag` tinyint(1) NOT NULL,
  PRIMARY KEY (`tag_tag`)
) ENGINE=MyISAM;

insert into `ocp7_custom_comcode` values('youtube','87','88',0x7b245345542c564944454f2c7b24505245475f5245504c4143452c28687474703a2f2f2e2a5c3f763d293f285c772b29282e2a293f2c245c7b325c7d2c7b636f6e74656e747d7d7d3c6f626a6563742077696474683d2234383022206865696768743d22333835223e3c706172616d206e616d653d226d6f766965222076616c75653d22687474703a2f2f7777772e796f75747562652e636f6d2f762f7b244745542a2c564944454f7d3f66733d3126616d703b686c3d656e5f5553223e3c2f706172616d3e3c706172616d206e616d653d22616c6c6f7746756c6c53637265656e222076616c75653d2274727565223e3c2f706172616d3e3c706172616d206e616d653d22616c6c6f77736372697074616363657373222076616c75653d22616c77617973223e3c2f706172616d3e3c656d626564207372633d22687474703a2f2f7777772e796f75747562652e636f6d2f762f7b244745542a2c564944454f7d3f66733d3126616d703b686c3d656e5f55532220747970653d226170706c69636174696f6e2f782d73686f636b776176652d666c6173682220616c6c6f777363726970746163636573733d22616c776179732220616c6c6f7766756c6c73637265656e3d2274727565222077696474683d2234383022206865696768743d22333835223e3c2f656d6265643e3c2f6f626a6563743e,0x5b796f75747562655d687474703a2f2f7777772e796f75747562652e636f6d2f77617463683f763d5a44464648617a394773595b2f796f75747562655d,'','1','0','1','0');

DROP TABLE IF EXISTS `ocp7_edit_pings`;

CREATE TABLE `ocp7_edit_pings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `the_page` varchar(80) COLLATE latin1_bin NOT NULL,
  `the_type` varchar(80) COLLATE latin1_bin NOT NULL,
  `the_id` varchar(80) COLLATE latin1_bin NOT NULL,
  `the_time` int(10) unsigned NOT NULL,
  `the_member` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_f_categories`;

CREATE TABLE `ocp7_f_categories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `c_title` varchar(255) COLLATE latin1_bin NOT NULL,
  `c_description` longtext COLLATE latin1_bin NOT NULL,
  `c_expanded_by_default` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3;

insert into `ocp7_f_categories` values('1','General','','1'),
 ('2','Staff','','1');

DROP TABLE IF EXISTS `ocp7_f_custom_fields`;

CREATE TABLE `ocp7_f_custom_fields` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cf_locked` tinyint(1) NOT NULL,
  `cf_name` int(10) unsigned NOT NULL,
  `cf_description` int(10) unsigned NOT NULL,
  `cf_default` longtext COLLATE latin1_bin NOT NULL,
  `cf_public_view` tinyint(1) NOT NULL,
  `cf_owner_view` tinyint(1) NOT NULL,
  `cf_owner_set` tinyint(1) NOT NULL,
  `cf_type` varchar(80) COLLATE latin1_bin NOT NULL,
  `cf_required` tinyint(1) NOT NULL,
  `cf_show_in_posts` tinyint(1) NOT NULL,
  `cf_show_in_post_previews` tinyint(1) NOT NULL,
  `cf_order` int(11) NOT NULL,
  `cf_only_group` longtext COLLATE latin1_bin NOT NULL,
  `cf_encrypted` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=34;

insert into `ocp7_f_custom_fields` values('1','0','16','17','','1','1','1','long_trans','0','0','0','0','','0'),
 ('2','0','18','19','','1','1','1','short_text','0','0','0','1','','0'),
 ('3','0','20','21','','1','1','1','short_text','0','0','0','2','','0'),
 ('4','0','22','23','','1','1','1','long_trans','0','0','0','3','','0'),
 ('5','0','24','25','','1','1','1','short_text','0','0','0','4','','0'),
 ('6','0','26','27','','1','1','1','short_text','0','0','0','5','','0'),
 ('7','0','28','29','','0','0','0','long_trans','0','0','0','6','','0'),
 ('8','1','83','84','','0','0','1','short_text','0','0','0','7','','0'),
 ('9','1','304','305',0x30,'0','0','0','integer','0','0','0','8','','0'),
 ('10','1','317','318',0x30,'0','0','0','integer','0','0','0','9','','0'),
 ('11','1','353','354',0x4145447c4146417c414c4c7c414d447c414e477c414f4b7c414f4e7c4152417c4152507c4152537c4155447c4157477c415a4d7c42414d7c4242447c4244547c42474c7c4248447c4249467c424d447c424e447c424f427c424f507c4252437c42524c7c4252527c4253447c42544e7c4257507c4259527c425a447c4341447c43445a7c4348467c434c467c434c507c434e597c434f507c4352437c4353447c4355507c4356457c4359507c435a4b7c444a467c444b4b7c444f507c445a447c45454b7c4547507c45524e7c4554427c4555527c464a447c464b507c4742507c47454c7c4748437c4749507c474d447c474e537c4751457c4754517c4757507c4759447c484b447c484e4c7c4852447c48524b7c4854477c4855467c4944527c494c537c494e527c4951447c4952527c49534b7c4a4d447c4a4f447c4a50597c4b45537c4b47537c4b48527c4b4d467c4b50577c4b52577c4b57447c4b59447c4b5a547c4c414b7c4c42507c4c4b527c4c52447c4c534c7c4c534d7c4c544c7c4c564c7c4c59447c4d41447c4d444c7c4d47467c4d4b447c4d4c467c4d4d4b7c4d4e547c4d4f507c4d524f7c4d544c7c4d55527c4d56527c4d574b7c4d584e7c4d59527c4d5a4d7c4e41447c4e474e7c4e49437c4e4f4b7c4e50527c4e5a447c4f4d527c5041427c5045497c50454e7c50474b7c5048507c504b527c504c4e7c5059477c5141527c524f4c7c5255427c5257467c5341527c5342447c5343527c5344447c5344507c53454b7c5347447c5348507c5349547c534b4b7c534c4c7c534f537c5352477c5354447c5355527c5356437c5359507c535a4c7c5448427c544a527c544d4d7c544e447c544f507c5450457c54524c7c5454447c5457447c545a537c5541487c55414b7c5547537c5553447c5559557c555a537c5645427c564e447c5655567c5753547c5841467c5843447c584f467c5850467c5944447c5945527c5a414c7c5a41527c5a4d4b7c5a5744,'0','0','1','list','0','0','0','10','','0'),
 ('12','1','355','356','','0','0','1','short_text','0','0','0','11','','1'),
 ('13','1','357','358',0x416d65726963616e20457870726573737c44656c74617c44696e65727320436172647c4a43427c4d617374657220436172647c536f6c6f7c5377697463687c56697361,'0','0','1','list','0','0','0','12','','1'),
 ('14','1','359','360','','0','0','1','integer','0','0','0','13','','1'),
 ('15','1','361','362',0x6d6d2f7979,'0','0','1','short_text','0','0','0','14','','1'),
 ('16','1','363','364',0x6d6d2f7979,'0','0','1','short_text','0','0','0','15','','1'),
 ('17','1','365','366','','0','0','1','short_text','0','0','0','16','','1'),
 ('18','1','367','368','','0','0','1','short_text','0','0','0','17','','1'),
 ('19','1','385','386','','0','0','0','short_text','0','0','0','18','','0'),
 ('20','1','387','388','','0','0','0','short_text','0','0','0','19','','0'),
 ('21','1','389','390','','0','0','0','long_text','0','0','0','20','','0'),
 ('22','1','391','392','','0','0','0','short_text','0','0','0','21','','0'),
 ('23','1','393','394','','0','0','0','short_text','0','0','0','22','','0'),
 ('24','1','395','396','','0','0','0','short_text','0','0','0','23','','0'),
 ('25','1','397','398',0x7c41447c41457c41467c41477c41497c414c7c414d7c414e7c414f7c41517c41527c41537c41547c41557c41577c415a7c42417c42427c42447c42457c42467c42477c42487c42497c424a7c424d7c424e7c424f7c42527c42537c42547c42557c42567c42577c42597c425a7c43417c43437c43447c43467c43477c43487c43497c434b7c434c7c434d7c434e7c434f7c43527c43537c43557c43567c43587c43597c435a7c44457c444a7c444b7c444d7c444f7c445a7c45437c45457c45477c45487c45527c45537c45547c46497c464a7c464b7c464d7c464f7c46527c47417c47427c47447c47457c47487c47497c474c7c474d7c474e7c47517c47527c47537c47547c47557c47577c47597c484b7c484d7c484e7c48527c48547c48557c49447c49457c494c7c494e7c494f7c49517c49527c49537c49547c4a4d7c4a4f7c4a507c4b457c4b477c4b487c4b497c4b4d7c4b4e7c4b507c4b527c4b577c4b597c4b5a7c4c417c4c427c4c437c4c497c4c4b7c4c527c4c537c4c547c4c557c4c597c4d417c4d437c4d447c4d477c4d487c4d4b7c4d4c7c4d4d7c4d4e7c4d4f7c4d507c4d527c4d537c4d547c4d557c4d567c4d577c4d587c4d597c4d5a7c4e417c4e437c4e457c4e467c4e477c4e497c4e4c7c4e4f7c4e507c4e527c4e557c4e5a7c4f4d7c50417c50457c50467c50477c50487c504b7c504c7c504e7c50527c50547c50577c50597c51417c524f7c52557c52577c53417c53427c53437c53447c53457c53477c53487c53497c534a7c534b7c534c7c534d7c534e7c534f7c53527c53547c53557c53567c53597c535a7c54437c54447c54477c54487c544a7c544b7c544d7c544e7c544f7c54507c54527c54547c54567c54577c545a7c55417c55477c554d7c55537c55597c555a7c56417c56437c56457c56477c56497c564e7c56557c57467c57537c59447c59457c5a417c5a4d7c5a527c5a57,'0','0','0','list','0','0','0','24','','0'),
 ('26','1','431','432',0x30,'0','0','0','integer','0','0','0','25','','0'),
 ('27','1','433','434',0x30,'0','0','0','integer','0','0','0','26','','0'),
 ('28','1','435','436',0x30,'0','0','0','integer','0','0','0','27','','0'),
 ('29','1','437','438',0x30,'0','0','0','integer','0','0','0','28','','0'),
 ('30','1','439','440',0x30,'0','0','0','integer','0','0','0','29','','0'),
 ('31','1','441','442','','0','0','0','short_text','0','0','0','30','','0'),
 ('32','1','443','444','','0','0','1','short_text','0','0','0','31','','0'),
 ('33','1','445','446','','0','0','1','short_text','0','0','0','32','','0');

DROP TABLE IF EXISTS `ocp7_f_emoticons`;

CREATE TABLE `ocp7_f_emoticons` (
  `e_code` varchar(80) COLLATE latin1_bin NOT NULL,
  `e_theme_img_code` varchar(255) COLLATE latin1_bin NOT NULL,
  `e_relevance_level` int(11) NOT NULL,
  `e_use_topics` tinyint(1) NOT NULL,
  `e_is_special` tinyint(1) NOT NULL,
  PRIMARY KEY (`e_code`),
  KEY `relevantemoticons` (`e_relevance_level`),
  KEY `topicemos` (`e_use_topics`)
) ENGINE=MyISAM;

insert into `ocp7_f_emoticons` values(':P','ocf_emoticons/cheeky','0','1','0'),
 (':\'(','ocf_emoticons/cry','0','1','0'),
 (':dry:','ocf_emoticons/dry','0','1','0'),
 (':$','ocf_emoticons/blush','0','1','0'),
 (';)','ocf_emoticons/wink','0','0','0'),
 ('O_o','ocf_emoticons/blink','0','1','0'),
 (':wub:','ocf_emoticons/wub','0','1','0'),
 (':cool:','ocf_emoticons/cool','0','1','0'),
 (':lol:','ocf_emoticons/lol','0','1','0'),
 (':(','ocf_emoticons/sad','0','1','0'),
 (':)','ocf_emoticons/smile','0','0','0'),
 (':thumbs:','ocf_emoticons/thumbs','0','1','0'),
 (':offtopic:','ocf_emoticons/offtopic','0','0','0'),
 (':|','ocf_emoticons/mellow','0','0','0'),
 (':ninja:','ocf_emoticons/ph34r','0','1','0'),
 (':o','ocf_emoticons/shocked','0','1','0'),
 (':rolleyes:','ocf_emoticons/rolleyes','1','1','0'),
 (':D','ocf_emoticons/grin','1','1','0'),
 ('^_^','ocf_emoticons/glee','1','1','0'),
 ('(K)','ocf_emoticons/kiss','1','0','0'),
 (':S','ocf_emoticons/confused','1','1','0'),
 (':@','ocf_emoticons/angry','1','1','0'),
 (':shake:','ocf_emoticons/shake','1','1','0'),
 (':hand:','ocf_emoticons/hand','1','1','0'),
 (':drool:','ocf_emoticons/drool','1','1','0'),
 (':devil:','ocf_emoticons/devil','1','1','0'),
 (':party:','ocf_emoticons/party','1','0','0'),
 (':constipated:','ocf_emoticons/constipated','1','1','0'),
 (':depressed:','ocf_emoticons/depressed','1','1','0'),
 (':zzz:','ocf_emoticons/zzz','1','1','0'),
 (':whistle:','ocf_emoticons/whistle','1','0','0'),
 (':upsidedown:','ocf_emoticons/upsidedown','1','1','0'),
 (':sick:','ocf_emoticons/sick','1','1','0'),
 (':shutup:','ocf_emoticons/shutup','1','0','0'),
 (':sarcy:','ocf_emoticons/sarcy','1','1','0'),
 (':puppyeyes:','ocf_emoticons/puppyeyes','1','1','0'),
 (':nod:','ocf_emoticons/nod','1','0','0'),
 (':nerd:','ocf_emoticons/nerd','1','1','0'),
 (':king:','ocf_emoticons/king','1','1','0'),
 (':birthday:','ocf_emoticons/birthday','1','1','0'),
 (':cyborg:','ocf_emoticons/cyborg','1','0','0'),
 (':hippie:','ocf_emoticons/hippie','1','1','0'),
 (':ninja2:','ocf_emoticons/ninja2','1','1','0'),
 (':rockon:','ocf_emoticons/rockon','1','0','0'),
 (':sinner:','ocf_emoticons/sinner','1','0','0'),
 (':guitar:','ocf_emoticons/guitar','1','0','0'),
 (':christmas:','ocf_emoticons/christmas','1','0','0');

DROP TABLE IF EXISTS `ocp7_f_forum_intro_ip`;

CREATE TABLE `ocp7_f_forum_intro_ip` (
  `i_forum_id` int(11) NOT NULL,
  `i_ip` varchar(40) COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`i_forum_id`,`i_ip`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_f_forum_intro_member`;

CREATE TABLE `ocp7_f_forum_intro_member` (
  `i_forum_id` int(11) NOT NULL,
  `i_member_id` int(11) NOT NULL,
  PRIMARY KEY (`i_forum_id`,`i_member_id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_f_forum_tracking`;

CREATE TABLE `ocp7_f_forum_tracking` (
  `r_forum_id` int(11) NOT NULL,
  `r_member_id` int(11) NOT NULL,
  PRIMARY KEY (`r_forum_id`,`r_member_id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_f_forums`;

CREATE TABLE `ocp7_f_forums` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `f_name` varchar(255) COLLATE latin1_bin NOT NULL,
  `f_description` int(10) unsigned NOT NULL,
  `f_category_id` int(11) DEFAULT NULL,
  `f_parent_forum` int(11) DEFAULT NULL,
  `f_position` int(11) NOT NULL,
  `f_order_sub_alpha` tinyint(1) NOT NULL,
  `f_post_count_increment` tinyint(1) NOT NULL,
  `f_intro_question` int(10) unsigned NOT NULL,
  `f_intro_answer` varchar(255) COLLATE latin1_bin NOT NULL,
  `f_cache_num_topics` int(11) NOT NULL,
  `f_cache_num_posts` int(11) NOT NULL,
  `f_cache_last_topic_id` int(11) DEFAULT NULL,
  `f_cache_last_title` varchar(255) COLLATE latin1_bin NOT NULL,
  `f_cache_last_time` int(10) unsigned DEFAULT NULL,
  `f_cache_last_username` varchar(255) COLLATE latin1_bin NOT NULL,
  `f_cache_last_member_id` int(11) DEFAULT NULL,
  `f_cache_last_forum_id` int(11) DEFAULT NULL,
  `f_redirection` varchar(255) COLLATE latin1_bin NOT NULL,
  `f_order` varchar(80) COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cache_num_posts` (`f_cache_num_posts`),
  KEY `subforum_parenting` (`f_parent_forum`),
  KEY `findnamedforum` (`f_name`),
  KEY `f_position` (`f_position`)
) ENGINE=MyISAM AUTO_INCREMENT=10;

insert into `ocp7_f_forums` values('1','Forum home','50',null,null,'1','0','1','51','','0','0',null,'',null,'',null,null,'','last_post'),
 ('2','News','52','1','1','1','0','1','53','','0','0',null,'',null,'',null,null,'','last_post'),
 ('3','General chat','54','1','1','1','0','1','55','','0','0',null,'',null,'',null,null,'','last_post'),
 ('4','Reported posts forum','56','2','1','1','0','1','57','','0','0',null,'',null,'',null,null,'','last_post'),
 ('5','Trash','58','2','1','1','0','1','59','','0','0',null,'',null,'',null,null,'','last_post'),
 ('6','Website comment topics','60','1','1','1','0','1','61','','0','0',null,'',null,'',null,null,'','last_post'),
 ('7','Website support tickets','62','2','1','1','0','1','63','','0','0',null,'',null,'',null,null,'','last_post'),
 ('8','Staff','64','2','1','1','0','1','65','','1','1','1','Welcome to the forums','1295956104','System','1','8','','last_post'),
 ('9','Website \"Contact Us\" messages','155','2','1','1','0','1','156','','0','0',null,'',null,'',null,null,'','last_post');

DROP TABLE IF EXISTS `ocp7_f_group_member_timeouts`;

CREATE TABLE `ocp7_f_group_member_timeouts` (
  `member_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `timeout` int(10) unsigned NOT NULL,
  PRIMARY KEY (`member_id`,`group_id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_f_group_members`;

CREATE TABLE `ocp7_f_group_members` (
  `gm_group_id` int(11) NOT NULL,
  `gm_member_id` int(11) NOT NULL,
  `gm_validated` tinyint(1) NOT NULL,
  PRIMARY KEY (`gm_group_id`,`gm_member_id`),
  KEY `gm_validated` (`gm_validated`),
  KEY `gm_member_id` (`gm_member_id`),
  KEY `gm_group_id` (`gm_group_id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_f_groups`;

CREATE TABLE `ocp7_f_groups` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `g_name` int(10) unsigned NOT NULL,
  `g_is_default` tinyint(1) NOT NULL,
  `g_is_presented_at_install` tinyint(1) NOT NULL,
  `g_is_super_admin` tinyint(1) NOT NULL,
  `g_is_super_moderator` tinyint(1) NOT NULL,
  `g_group_leader` int(11) DEFAULT NULL,
  `g_title` int(10) unsigned NOT NULL,
  `g_promotion_target` int(11) DEFAULT NULL,
  `g_promotion_threshold` int(11) DEFAULT NULL,
  `g_flood_control_submit_secs` int(11) NOT NULL,
  `g_flood_control_access_secs` int(11) NOT NULL,
  `g_gift_points_base` int(11) NOT NULL,
  `g_gift_points_per_day` int(11) NOT NULL,
  `g_max_daily_upload_mb` int(11) NOT NULL,
  `g_max_attachments_per_post` int(11) NOT NULL,
  `g_max_avatar_width` int(11) NOT NULL,
  `g_max_avatar_height` int(11) NOT NULL,
  `g_max_post_length_comcode` int(11) NOT NULL,
  `g_max_sig_length_comcode` int(11) NOT NULL,
  `g_enquire_on_new_ips` tinyint(1) NOT NULL,
  `g_rank_image` varchar(80) COLLATE latin1_bin NOT NULL,
  `g_hidden` tinyint(1) NOT NULL,
  `g_order` int(11) NOT NULL,
  `g_rank_image_pri_only` tinyint(1) NOT NULL,
  `g_open_membership` tinyint(1) NOT NULL,
  `g_is_private_club` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ftjoin_gname` (`g_name`),
  KEY `ftjoin_gtitle` (`g_title`),
  KEY `is_private_club` (`g_is_private_club`),
  KEY `is_super_admin` (`g_is_super_admin`),
  KEY `is_super_moderator` (`g_is_super_moderator`),
  KEY `is_default` (`g_is_default`),
  KEY `is_presented_at_install` (`g_is_presented_at_install`),
  KEY `gorder` (`g_order`,`id`)
) ENGINE=MyISAM AUTO_INCREMENT=11;

insert into `ocp7_f_groups` values('1','30','0','0','0','0',null,'31',null,null,'5','0','25','1','70','50','100','100','30000','700','0','','0','0','1','0','0'),
 ('2','32','0','0','1','0',null,'33',null,null,'0','0','25','1','70','50','100','100','30000','700','0','ocf_rank_images/admin','0','1','1','0','0'),
 ('3','34','0','0','0','1',null,'35',null,null,'0','0','25','1','70','50','100','100','30000','700','0','ocf_rank_images/mod','0','2','1','0','0'),
 ('4','36','0','0','0','0',null,'37',null,null,'0','0','25','1','70','50','100','100','30000','700','0','','0','3','1','0','0'),
 ('5','38','0','0','0','0',null,'39',null,null,'5','0','25','1','70','50','100','100','30000','700','0','ocf_rank_images/4','0','4','1','0','0'),
 ('6','40','0','0','0','0',null,'41','5','10000','5','0','25','1','70','50','100','100','30000','700','0','ocf_rank_images/3','0','5','1','0','0'),
 ('7','42','0','0','0','0',null,'43','6','2500','5','0','25','1','70','50','100','100','30000','700','0','ocf_rank_images/2','0','6','1','0','0'),
 ('8','44','0','0','0','0',null,'45','7','400','5','0','25','1','70','50','100','100','30000','700','0','ocf_rank_images/1','0','7','1','0','0'),
 ('9','46','0','0','0','0',null,'47','8','100','5','0','25','1','70','50','100','100','30000','700','0','ocf_rank_images/0','0','8','1','0','0'),
 ('10','48','0','0','0','0',null,'49',null,null,'0','0','25','1','70','50','100','100','30000','700','0','','0','9','1','0','0');

DROP TABLE IF EXISTS `ocp7_f_invites`;

CREATE TABLE `ocp7_f_invites` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `i_inviter` int(11) NOT NULL,
  `i_email_address` varchar(255) COLLATE latin1_bin NOT NULL,
  `i_time` int(10) unsigned NOT NULL,
  `i_taken` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_f_member_cpf_perms`;

CREATE TABLE `ocp7_f_member_cpf_perms` (
  `member_id` int(11) NOT NULL,
  `field_id` int(11) NOT NULL,
  `guest_view` tinyint(1) NOT NULL,
  `member_view` tinyint(1) NOT NULL,
  `friend_view` tinyint(1) NOT NULL,
  `group_view` varchar(255) COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`member_id`,`field_id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_f_member_custom_fields`;

CREATE TABLE `ocp7_f_member_custom_fields` (
  `mf_member_id` int(11) NOT NULL,
  `field_1` int(10) unsigned DEFAULT NULL,
  `field_2` varchar(255) COLLATE latin1_bin NOT NULL DEFAULT '',
  `field_3` varchar(255) COLLATE latin1_bin NOT NULL DEFAULT '',
  `field_4` int(10) unsigned DEFAULT NULL,
  `field_5` varchar(255) COLLATE latin1_bin NOT NULL DEFAULT '',
  `field_6` varchar(255) COLLATE latin1_bin NOT NULL DEFAULT '',
  `field_7` int(10) unsigned DEFAULT NULL,
  `field_8` varchar(255) COLLATE latin1_bin NOT NULL DEFAULT '',
  `field_9` int(11) DEFAULT NULL,
  `field_10` int(11) DEFAULT NULL,
  `field_11` varchar(255) COLLATE latin1_bin NOT NULL DEFAULT '',
  `field_12` longtext COLLATE latin1_bin NOT NULL,
  `field_13` longtext COLLATE latin1_bin NOT NULL,
  `field_14` int(11) DEFAULT NULL,
  `field_15` longtext COLLATE latin1_bin NOT NULL,
  `field_16` longtext COLLATE latin1_bin NOT NULL,
  `field_17` longtext COLLATE latin1_bin NOT NULL,
  `field_18` longtext COLLATE latin1_bin NOT NULL,
  `field_19` varchar(255) COLLATE latin1_bin NOT NULL DEFAULT '',
  `field_20` varchar(255) COLLATE latin1_bin NOT NULL DEFAULT '',
  `field_21` longtext COLLATE latin1_bin NOT NULL,
  `field_22` varchar(255) COLLATE latin1_bin NOT NULL DEFAULT '',
  `field_23` varchar(255) COLLATE latin1_bin NOT NULL DEFAULT '',
  `field_24` varchar(255) COLLATE latin1_bin NOT NULL DEFAULT '',
  `field_25` varchar(255) COLLATE latin1_bin NOT NULL DEFAULT '',
  `field_26` int(11) DEFAULT NULL,
  `field_27` int(11) DEFAULT NULL,
  `field_28` int(11) DEFAULT NULL,
  `field_29` int(11) DEFAULT NULL,
  `field_30` int(11) DEFAULT NULL,
  `field_31` varchar(255) COLLATE latin1_bin NOT NULL DEFAULT '',
  `field_32` varchar(255) COLLATE latin1_bin NOT NULL DEFAULT '',
  `field_33` varchar(255) COLLATE latin1_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`mf_member_id`),
  FULLTEXT KEY `mcf2` (`field_2`),
  FULLTEXT KEY `mcf3` (`field_3`),
  FULLTEXT KEY `mcf5` (`field_5`),
  FULLTEXT KEY `mcf6` (`field_6`),
  FULLTEXT KEY `mcf8` (`field_8`),
  FULLTEXT KEY `mcf11` (`field_11`),
  FULLTEXT KEY `mcf12` (`field_12`),
  FULLTEXT KEY `mcf13` (`field_13`),
  FULLTEXT KEY `mcf15` (`field_15`),
  FULLTEXT KEY `mcf16` (`field_16`),
  FULLTEXT KEY `mcf17` (`field_17`),
  FULLTEXT KEY `mcf18` (`field_18`),
  FULLTEXT KEY `mcf19` (`field_19`),
  FULLTEXT KEY `mcf20` (`field_20`),
  FULLTEXT KEY `mcf21` (`field_21`),
  FULLTEXT KEY `mcf22` (`field_22`),
  FULLTEXT KEY `mcf23` (`field_23`),
  FULLTEXT KEY `mcf24` (`field_24`),
  FULLTEXT KEY `mcf25` (`field_25`),
  FULLTEXT KEY `mcf31` (`field_31`),
  FULLTEXT KEY `mcf32` (`field_32`),
  FULLTEXT KEY `mcf33` (`field_33`)
) ENGINE=MyISAM;

insert into `ocp7_f_member_custom_fields` values('1','69','','','70','','','71','',null,null,'','','',null,'','','','','','','','','','','',null,null,null,null,null,'','',''),
 ('2','74','','','75','','','76','',null,null,'','','',null,'','','','','','','','','','','',null,null,null,null,null,'','',''),
 ('3','79','','','80','','','81','',null,null,'','','',null,'','','','','','','','','','','',null,null,null,null,null,'','','');

DROP TABLE IF EXISTS `ocp7_f_member_known_login_ips`;

CREATE TABLE `ocp7_f_member_known_login_ips` (
  `i_member_id` int(11) NOT NULL,
  `i_ip` varchar(40) COLLATE latin1_bin NOT NULL,
  `i_val_code` varchar(255) COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`i_member_id`,`i_ip`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_f_members`;

CREATE TABLE `ocp7_f_members` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `m_username` varchar(80) COLLATE latin1_bin NOT NULL,
  `m_pass_hash_salted` varchar(255) COLLATE latin1_bin NOT NULL,
  `m_pass_salt` varchar(255) COLLATE latin1_bin NOT NULL,
  `m_theme` varchar(80) COLLATE latin1_bin NOT NULL,
  `m_avatar_url` varchar(255) COLLATE latin1_bin NOT NULL,
  `m_validated` tinyint(1) NOT NULL,
  `m_validated_email_confirm_code` varchar(255) COLLATE latin1_bin NOT NULL,
  `m_cache_num_posts` int(11) NOT NULL,
  `m_cache_warnings` int(11) NOT NULL,
  `m_join_time` int(10) unsigned NOT NULL,
  `m_timezone_offset` varchar(255) COLLATE latin1_bin NOT NULL,
  `m_primary_group` int(11) NOT NULL,
  `m_last_visit_time` int(10) unsigned NOT NULL,
  `m_last_submit_time` int(10) unsigned NOT NULL,
  `m_signature` int(10) unsigned NOT NULL,
  `m_is_perm_banned` tinyint(1) NOT NULL,
  `m_preview_posts` tinyint(1) NOT NULL,
  `m_dob_day` int(11) DEFAULT NULL,
  `m_dob_month` int(11) DEFAULT NULL,
  `m_dob_year` int(11) DEFAULT NULL,
  `m_reveal_age` tinyint(1) NOT NULL,
  `m_email_address` varchar(255) COLLATE latin1_bin NOT NULL,
  `m_title` varchar(255) COLLATE latin1_bin NOT NULL,
  `m_photo_url` varchar(255) COLLATE latin1_bin NOT NULL,
  `m_photo_thumb_url` varchar(255) COLLATE latin1_bin NOT NULL,
  `m_views_signatures` tinyint(1) NOT NULL,
  `m_auto_alert_contrib_content` tinyint(1) NOT NULL,
  `m_language` varchar(80) COLLATE latin1_bin NOT NULL,
  `m_ip_address` varchar(40) COLLATE latin1_bin NOT NULL,
  `m_allow_emails` tinyint(1) NOT NULL,
  `m_notes` longtext COLLATE latin1_bin NOT NULL,
  `m_zone_wide` tinyint(1) NOT NULL,
  `m_highlighted_name` tinyint(1) NOT NULL,
  `m_pt_allow` varchar(255) COLLATE latin1_bin NOT NULL,
  `m_pt_rules_text` int(10) unsigned NOT NULL,
  `m_max_email_attach_size_mb` int(11) NOT NULL,
  `m_password_change_code` varchar(255) COLLATE latin1_bin NOT NULL,
  `m_password_compat_scheme` varchar(80) COLLATE latin1_bin NOT NULL,
  `m_on_probation_until` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_list` (`m_username`),
  KEY `menail` (`m_email_address`),
  KEY `external_auth_lookup` (`m_pass_hash_salted`),
  KEY `sort_post_count` (`m_cache_num_posts`),
  KEY `m_join_time` (`m_join_time`),
  KEY `whos_validated` (`m_validated`),
  KEY `birthdays` (`m_dob_day`,`m_dob_month`),
  KEY `ftjoin_msig` (`m_signature`),
  KEY `primary_group` (`m_primary_group`),
  KEY `avatar_url` (`m_avatar_url`),
  FULLTEXT KEY `search_user` (`m_username`)
) ENGINE=MyISAM AUTO_INCREMENT=4;

insert into `ocp7_f_members` values('1','Guest','310ab58805cda9e06fd9d88fbe4a1d70','4d3eb8887ad2b','','','1','','0','0','1295956104','0','1','1295956104','1295956104','67','0','1',null,null,null,'1','','','','','1','0','','0000:0000:0000:0000:0000:0000:0000:0001','1','','1','0','*','68','5','','','1295956104'),
 ('2','admin','f8be1ff42716b049c8b9619e4ecda3df','4d3eb8887d23a','','themes/default/images/ocf_default_avatars/default_set/cool_flare.png','1','','0','0','1295956104','0','2','1295956104','1295956104','72','0','0',null,null,null,'1','','','','','1','0','','0000:0000:0000:0000:0000:0000:0000:0001','1','','1','0','*','73','5','','','1295956104'),
 ('3','test','efc7a793ac76dc40a23e5416f57a38e0','4d3eb8887de92','','','1','','0','0','1295956104','0','9','1295956104','1295956104','77','0','0',null,null,null,'1','','','','','1','0','','0000:0000:0000:0000:0000:0000:0000:0001','1','','1','0','*','78','5','','','1295956104');

DROP TABLE IF EXISTS `ocp7_f_moderator_logs`;

CREATE TABLE `ocp7_f_moderator_logs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `l_the_type` varchar(80) COLLATE latin1_bin NOT NULL,
  `l_param_a` varchar(255) COLLATE latin1_bin NOT NULL,
  `l_param_b` varchar(255) COLLATE latin1_bin NOT NULL,
  `l_date_and_time` int(10) unsigned NOT NULL,
  `l_reason` longtext COLLATE latin1_bin NOT NULL,
  `l_by` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_f_multi_moderations`;

CREATE TABLE `ocp7_f_multi_moderations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `mm_name` int(10) unsigned NOT NULL,
  `mm_post_text` longtext COLLATE latin1_bin NOT NULL,
  `mm_move_to` int(11) DEFAULT NULL,
  `mm_pin_state` tinyint(1) DEFAULT NULL,
  `mm_sink_state` tinyint(1) DEFAULT NULL,
  `mm_open_state` tinyint(1) DEFAULT NULL,
  `mm_forum_multi_code` varchar(255) COLLATE latin1_bin NOT NULL,
  `mm_title_suffix` varchar(255) COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`id`,`mm_name`)
) ENGINE=MyISAM AUTO_INCREMENT=2;

insert into `ocp7_f_multi_moderations` values('1','66','','5','0','0','0','*','');

DROP TABLE IF EXISTS `ocp7_f_poll_answers`;

CREATE TABLE `ocp7_f_poll_answers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pa_poll_id` int(11) NOT NULL,
  `pa_answer` varchar(255) COLLATE latin1_bin NOT NULL,
  `pa_cache_num_votes` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_f_poll_votes`;

CREATE TABLE `ocp7_f_poll_votes` (
  `pv_poll_id` int(11) NOT NULL,
  `pv_member_id` int(11) NOT NULL,
  `pv_answer_id` int(11) NOT NULL,
  PRIMARY KEY (`pv_poll_id`,`pv_member_id`,`pv_answer_id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_f_polls`;

CREATE TABLE `ocp7_f_polls` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `po_question` varchar(255) COLLATE latin1_bin NOT NULL,
  `po_cache_total_votes` int(11) NOT NULL,
  `po_is_private` tinyint(1) NOT NULL,
  `po_is_open` tinyint(1) NOT NULL,
  `po_minimum_selections` int(11) NOT NULL,
  `po_maximum_selections` int(11) NOT NULL,
  `po_requires_reply` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_f_post_history`;

CREATE TABLE `ocp7_f_post_history` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `h_create_date_and_time` int(10) unsigned NOT NULL,
  `h_action_date_and_time` int(10) unsigned NOT NULL,
  `h_owner_member_id` int(11) NOT NULL,
  `h_alterer_member_id` int(11) NOT NULL,
  `h_post_id` int(11) NOT NULL,
  `h_topic_id` int(11) NOT NULL,
  `h_before` longtext COLLATE latin1_bin NOT NULL,
  `h_action` varchar(80) COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`id`),
  KEY `phistorylookup` (`h_post_id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_f_post_templates`;

CREATE TABLE `ocp7_f_post_templates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `t_title` varchar(255) COLLATE latin1_bin NOT NULL,
  `t_text` longtext COLLATE latin1_bin NOT NULL,
  `t_forum_multi_code` varchar(255) COLLATE latin1_bin NOT NULL,
  `t_use_default_forums` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4;

insert into `ocp7_f_post_templates` values('1','Bug report',0x56657273696f6e3a203f0a537570706f727420736f66747761726520656e7669726f6e6d656e7420286f7065726174696e672073797374656d2c206574632e293a0a3f0a0a41737369676e656420746f3a203f0a53657665726974793a203f0a4578616d706c652055524c3a203f0a4465736372697074696f6e3a0a3f0a0a537465707320666f7220726570726f64756374696f6e3a0a3f0a0a,'','0'),
 ('2','Task',0x41737369676e656420746f3a203f0a5072696f726974792f54696d657363616c653a203f0a4465736372697074696f6e3a0a3f0a0a,'','0'),
 ('3','Fault',0x56657273696f6e3a203f0a41737369676e656420746f3a203f0a53657665726974792f54696d657363616c653a203f0a4465736372697074696f6e3a0a3f0a0a537465707320666f7220726570726f64756374696f6e3a0a3f0a0a,'','0');

DROP TABLE IF EXISTS `ocp7_f_posts`;

CREATE TABLE `ocp7_f_posts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `p_title` varchar(255) COLLATE latin1_bin NOT NULL,
  `p_post` int(10) unsigned NOT NULL,
  `p_ip_address` varchar(40) COLLATE latin1_bin NOT NULL,
  `p_time` int(10) unsigned NOT NULL,
  `p_poster` int(11) NOT NULL,
  `p_intended_solely_for` int(11) DEFAULT NULL,
  `p_poster_name_if_guest` varchar(80) COLLATE latin1_bin NOT NULL,
  `p_validated` tinyint(1) NOT NULL,
  `p_topic_id` int(11) NOT NULL,
  `p_cache_forum_id` int(11) DEFAULT NULL,
  `p_last_edit_time` int(10) unsigned DEFAULT NULL,
  `p_last_edit_by` int(11) DEFAULT NULL,
  `p_is_emphasised` tinyint(1) NOT NULL,
  `p_skip_sig` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `p_validated` (`p_validated`),
  KEY `in_topic` (`p_topic_id`,`p_time`,`id`),
  KEY `post_order_time` (`p_time`,`id`),
  KEY `p_last_edit_time` (`p_last_edit_time`),
  KEY `posts_by` (`p_poster`),
  KEY `find_pp` (`p_intended_solely_for`),
  KEY `search_join` (`p_post`),
  KEY `postsinforum` (`p_cache_forum_id`),
  KEY `deletebyip` (`p_ip_address`),
  FULLTEXT KEY `p_title` (`p_title`)
) ENGINE=MyISAM AUTO_INCREMENT=2;

insert into `ocp7_f_posts` values('1','Welcome to the forums','82','127.0.0.1','1295956104','1',null,'System','1','1','8',null,null,'0','0');

DROP TABLE IF EXISTS `ocp7_f_read_logs`;

CREATE TABLE `ocp7_f_read_logs` (
  `l_member_id` int(11) NOT NULL,
  `l_topic_id` int(11) NOT NULL,
  `l_time` int(10) unsigned NOT NULL,
  PRIMARY KEY (`l_member_id`,`l_topic_id`),
  KEY `erase_old_read_logs` (`l_time`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_f_saved_warnings`;

CREATE TABLE `ocp7_f_saved_warnings` (
  `s_title` varchar(255) COLLATE latin1_bin NOT NULL,
  `s_explanation` longtext COLLATE latin1_bin NOT NULL,
  `s_message` longtext COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`s_title`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_f_special_pt_access`;

CREATE TABLE `ocp7_f_special_pt_access` (
  `s_member_id` int(11) NOT NULL,
  `s_topic_id` int(11) NOT NULL,
  PRIMARY KEY (`s_member_id`,`s_topic_id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_f_topic_tracking`;

CREATE TABLE `ocp7_f_topic_tracking` (
  `r_topic_id` int(11) NOT NULL,
  `r_member_id` int(11) NOT NULL,
  `r_last_message_time` int(10) unsigned NOT NULL,
  PRIMARY KEY (`r_topic_id`,`r_member_id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_f_topics`;

CREATE TABLE `ocp7_f_topics` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `t_pinned` tinyint(1) NOT NULL,
  `t_sunk` tinyint(1) NOT NULL,
  `t_cascading` tinyint(1) NOT NULL,
  `t_forum_id` int(11) DEFAULT NULL,
  `t_pt_from` int(11) DEFAULT NULL,
  `t_pt_to` int(11) DEFAULT NULL,
  `t_pt_from_category` varchar(255) COLLATE latin1_bin NOT NULL,
  `t_pt_to_category` varchar(255) COLLATE latin1_bin NOT NULL,
  `t_description` varchar(255) COLLATE latin1_bin NOT NULL,
  `t_description_link` varchar(255) COLLATE latin1_bin NOT NULL,
  `t_emoticon` varchar(255) COLLATE latin1_bin NOT NULL,
  `t_num_views` int(11) NOT NULL,
  `t_validated` tinyint(1) NOT NULL,
  `t_is_open` tinyint(1) NOT NULL,
  `t_poll_id` int(11) DEFAULT NULL,
  `t_cache_first_post_id` int(11) DEFAULT NULL,
  `t_cache_first_time` int(10) unsigned DEFAULT NULL,
  `t_cache_first_title` varchar(255) COLLATE latin1_bin NOT NULL,
  `t_cache_first_post` int(10) unsigned DEFAULT NULL,
  `t_cache_first_username` varchar(80) COLLATE latin1_bin NOT NULL,
  `t_cache_first_member_id` int(11) DEFAULT NULL,
  `t_cache_last_post_id` int(11) DEFAULT NULL,
  `t_cache_last_time` int(10) unsigned DEFAULT NULL,
  `t_cache_last_title` varchar(255) COLLATE latin1_bin NOT NULL,
  `t_cache_last_username` varchar(80) COLLATE latin1_bin NOT NULL,
  `t_cache_last_member_id` int(11) DEFAULT NULL,
  `t_cache_num_posts` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `t_num_views` (`t_num_views`),
  KEY `t_pt_to` (`t_pt_to`),
  KEY `t_pt_from` (`t_pt_from`),
  KEY `t_validated` (`t_validated`),
  KEY `in_forum` (`t_forum_id`),
  KEY `topic_order_time` (`t_cache_last_time`),
  KEY `topic_order_time_2` (`t_cache_first_time`),
  KEY `descriptionsearch` (`t_description`),
  KEY `forumlayer` (`t_cache_first_title`),
  KEY `t_cascading` (`t_cascading`),
  KEY `t_cascading_or_forum` (`t_cascading`,`t_forum_id`),
  KEY `topic_order` (`t_cascading`,`t_pinned`,`t_cache_last_time`),
  KEY `topic_order_2` (`t_forum_id`,`t_cascading`,`t_pinned`,`t_sunk`,`t_cache_last_time`),
  KEY `topic_order_3` (`t_forum_id`,`t_cascading`,`t_pinned`,`t_cache_last_time`),
  KEY `ownedtopics` (`t_cache_first_member_id`),
  FULLTEXT KEY `t_description` (`t_description`)
) ENGINE=MyISAM AUTO_INCREMENT=2;

insert into `ocp7_f_topics` values('1','0','0','0','8',null,null,'','','','','','0','1','1',null,'1','1295956104','Welcome to the forums','82','System','1','1','1295956104','Welcome to the forums','System','1','1');

DROP TABLE IF EXISTS `ocp7_f_warnings`;

CREATE TABLE `ocp7_f_warnings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `w_member_id` int(11) NOT NULL,
  `w_time` int(10) unsigned NOT NULL,
  `w_explanation` longtext COLLATE latin1_bin NOT NULL,
  `w_by` int(11) NOT NULL,
  `w_is_warning` tinyint(1) NOT NULL,
  `p_silence_from_topic` int(11) DEFAULT NULL,
  `p_silence_from_forum` int(11) DEFAULT NULL,
  `p_probation` int(11) NOT NULL,
  `p_banned_ip` varchar(40) COLLATE latin1_bin NOT NULL,
  `p_charged_points` int(11) NOT NULL,
  `p_banned_member` tinyint(1) NOT NULL,
  `p_changed_usergroup_from` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `warningsmemberid` (`w_member_id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_f_welcome_emails`;

CREATE TABLE `ocp7_f_welcome_emails` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `w_name` varchar(255) COLLATE latin1_bin NOT NULL,
  `w_subject` int(10) unsigned NOT NULL,
  `w_text` int(10) unsigned NOT NULL,
  `w_send_time` int(11) NOT NULL,
  `w_newsletter` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_group_page_access`;

CREATE TABLE `ocp7_group_page_access` (
  `page_name` varchar(80) COLLATE latin1_bin NOT NULL,
  `zone_name` varchar(80) COLLATE latin1_bin NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`page_name`,`zone_name`,`group_id`)
) ENGINE=MyISAM;

insert into `ocp7_group_page_access` values('admin_addons','adminzone','1'),
 ('admin_addons','adminzone','2'),
 ('admin_addons','adminzone','3'),
 ('admin_addons','adminzone','4'),
 ('admin_addons','adminzone','5'),
 ('admin_addons','adminzone','6'),
 ('admin_addons','adminzone','7'),
 ('admin_addons','adminzone','8'),
 ('admin_addons','adminzone','9'),
 ('admin_addons','adminzone','10'),
 ('admin_import','adminzone','1'),
 ('admin_import','adminzone','2'),
 ('admin_import','adminzone','3'),
 ('admin_import','adminzone','4'),
 ('admin_import','adminzone','5'),
 ('admin_import','adminzone','6'),
 ('admin_import','adminzone','7'),
 ('admin_import','adminzone','8'),
 ('admin_import','adminzone','9'),
 ('admin_import','adminzone','10'),
 ('admin_occle','adminzone','1'),
 ('admin_occle','adminzone','2'),
 ('admin_occle','adminzone','3'),
 ('admin_occle','adminzone','4'),
 ('admin_occle','adminzone','5'),
 ('admin_occle','adminzone','6'),
 ('admin_occle','adminzone','7'),
 ('admin_occle','adminzone','8'),
 ('admin_occle','adminzone','9'),
 ('admin_occle','adminzone','10'),
 ('admin_redirects','adminzone','1'),
 ('admin_redirects','adminzone','2'),
 ('admin_redirects','adminzone','3'),
 ('admin_redirects','adminzone','4'),
 ('admin_redirects','adminzone','5'),
 ('admin_redirects','adminzone','6'),
 ('admin_redirects','adminzone','7'),
 ('admin_redirects','adminzone','8'),
 ('admin_redirects','adminzone','9'),
 ('admin_redirects','adminzone','10'),
 ('admin_staff','adminzone','1'),
 ('admin_staff','adminzone','2'),
 ('admin_staff','adminzone','3'),
 ('admin_staff','adminzone','4'),
 ('admin_staff','adminzone','5'),
 ('admin_staff','adminzone','6'),
 ('admin_staff','adminzone','7'),
 ('admin_staff','adminzone','8'),
 ('admin_staff','adminzone','9'),
 ('admin_staff','adminzone','10'),
 ('cms_chat','cms','1'),
 ('cms_chat','cms','2'),
 ('cms_chat','cms','3'),
 ('cms_chat','cms','4'),
 ('cms_chat','cms','5'),
 ('cms_chat','cms','6'),
 ('cms_chat','cms','7'),
 ('cms_chat','cms','8'),
 ('cms_chat','cms','9'),
 ('cms_chat','cms','10');

DROP TABLE IF EXISTS `ocp7_group_zone_access`;

CREATE TABLE `ocp7_group_zone_access` (
  `zone_name` varchar(80) COLLATE latin1_bin NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`zone_name`,`group_id`),
  KEY `group_id` (`group_id`)
) ENGINE=MyISAM;

insert into `ocp7_group_zone_access` values('','1'),
 ('','2'),
 ('','3'),
 ('','4'),
 ('','5'),
 ('','6'),
 ('','7'),
 ('','8'),
 ('','9'),
 ('','10'),
 ('adminzone','2'),
 ('adminzone','3'),
 ('cms','2'),
 ('cms','3'),
 ('cms','4'),
 ('cms','5'),
 ('cms','6'),
 ('cms','7'),
 ('cms','8'),
 ('cms','9'),
 ('cms','10'),
 ('collaboration','2'),
 ('collaboration','3'),
 ('collaboration','4'),
 ('forum','1'),
 ('forum','2'),
 ('forum','3'),
 ('forum','4'),
 ('forum','5'),
 ('forum','6'),
 ('forum','7'),
 ('forum','8'),
 ('forum','9'),
 ('forum','10'),
 ('site','2'),
 ('site','3'),
 ('site','4'),
 ('site','5'),
 ('site','6'),
 ('site','7'),
 ('site','8'),
 ('site','9'),
 ('site','10');

DROP TABLE IF EXISTS `ocp7_hackattack`;

CREATE TABLE `ocp7_hackattack` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `url` varchar(255) COLLATE latin1_bin NOT NULL,
  `data_post` longtext COLLATE latin1_bin NOT NULL,
  `user_agent` varchar(255) COLLATE latin1_bin NOT NULL,
  `referer` varchar(255) COLLATE latin1_bin NOT NULL,
  `user_os` varchar(255) COLLATE latin1_bin NOT NULL,
  `the_user` int(11) NOT NULL,
  `date_and_time` int(10) unsigned NOT NULL,
  `ip` varchar(40) COLLATE latin1_bin NOT NULL,
  `reason` varchar(80) COLLATE latin1_bin NOT NULL,
  `reason_param_a` varchar(255) COLLATE latin1_bin NOT NULL,
  `reason_param_b` varchar(255) COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`id`),
  KEY `otherhacksby` (`ip`),
  KEY `h_date_and_time` (`date_and_time`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_import_id_remap`;

CREATE TABLE `ocp7_import_id_remap` (
  `id_old` varchar(80) COLLATE latin1_bin NOT NULL,
  `id_new` int(11) NOT NULL,
  `id_type` varchar(80) COLLATE latin1_bin NOT NULL,
  `id_session` int(11) NOT NULL,
  PRIMARY KEY (`id_old`,`id_type`,`id_session`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_import_parts_done`;

CREATE TABLE `ocp7_import_parts_done` (
  `imp_id` varchar(255) COLLATE latin1_bin NOT NULL,
  `imp_session` int(11) NOT NULL,
  PRIMARY KEY (`imp_id`,`imp_session`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_import_session`;

CREATE TABLE `ocp7_import_session` (
  `imp_old_base_dir` varchar(255) COLLATE latin1_bin NOT NULL,
  `imp_db_name` varchar(80) COLLATE latin1_bin NOT NULL,
  `imp_db_user` varchar(80) COLLATE latin1_bin NOT NULL,
  `imp_hook` varchar(80) COLLATE latin1_bin NOT NULL,
  `imp_db_table_prefix` varchar(80) COLLATE latin1_bin NOT NULL,
  `imp_refresh_time` int(11) NOT NULL,
  `imp_session` int(11) NOT NULL,
  PRIMARY KEY (`imp_session`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_incoming_uploads`;

CREATE TABLE `ocp7_incoming_uploads` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `i_submitter` int(11) NOT NULL,
  `i_date_and_time` int(10) unsigned NOT NULL,
  `i_orig_filename` varchar(255) COLLATE latin1_bin NOT NULL,
  `i_save_url` varchar(255) COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_ip_country`;

CREATE TABLE `ocp7_ip_country` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `begin_num` int(10) unsigned NOT NULL,
  `end_num` int(10) unsigned NOT NULL,
  `country` varchar(255) COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_link_tracker`;

CREATE TABLE `ocp7_link_tracker` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `c_date_and_time` int(10) unsigned NOT NULL,
  `c_member_id` int(11) NOT NULL,
  `c_ip_address` varchar(40) COLLATE latin1_bin NOT NULL,
  `c_url` varchar(255) COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_logged_mail_messages`;

CREATE TABLE `ocp7_logged_mail_messages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `m_subject` varchar(255) COLLATE latin1_bin NOT NULL,
  `m_message` longtext COLLATE latin1_bin NOT NULL,
  `m_to_email` longtext COLLATE latin1_bin NOT NULL,
  `m_to_name` longtext COLLATE latin1_bin NOT NULL,
  `m_from_email` varchar(255) COLLATE latin1_bin NOT NULL,
  `m_from_name` varchar(255) COLLATE latin1_bin NOT NULL,
  `m_priority` tinyint(4) NOT NULL,
  `m_attachments` longtext COLLATE latin1_bin NOT NULL,
  `m_no_cc` tinyint(1) NOT NULL,
  `m_as` int(11) NOT NULL,
  `m_as_admin` tinyint(1) NOT NULL,
  `m_in_html` tinyint(1) NOT NULL,
  `m_date_and_time` int(10) unsigned NOT NULL,
  `m_member_id` int(11) NOT NULL,
  `m_url` longtext COLLATE latin1_bin NOT NULL,
  `m_queued` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `recentmessages` (`m_date_and_time`),
  KEY `queued` (`m_queued`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_long_values`;

CREATE TABLE `ocp7_long_values` (
  `the_name` varchar(80) COLLATE latin1_bin NOT NULL,
  `the_value` longtext COLLATE latin1_bin NOT NULL,
  `date_and_time` int(10) unsigned NOT NULL,
  PRIMARY KEY (`the_name`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_match_key_messages`;

CREATE TABLE `ocp7_match_key_messages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `k_message` int(10) unsigned NOT NULL,
  `k_match_key` varchar(255) COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_member_category_access`;

CREATE TABLE `ocp7_member_category_access` (
  `active_until` int(10) unsigned NOT NULL,
  `module_the_name` varchar(80) COLLATE latin1_bin NOT NULL,
  `category_name` varchar(80) COLLATE latin1_bin NOT NULL,
  `member_id` int(11) NOT NULL,
  PRIMARY KEY (`active_until`,`module_the_name`,`category_name`,`member_id`),
  KEY `mcaname` (`module_the_name`,`category_name`),
  KEY `mcamember_id` (`member_id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_member_page_access`;

CREATE TABLE `ocp7_member_page_access` (
  `active_until` int(10) unsigned NOT NULL,
  `page_name` varchar(80) COLLATE latin1_bin NOT NULL,
  `zone_name` varchar(80) COLLATE latin1_bin NOT NULL,
  `member_id` int(11) NOT NULL,
  PRIMARY KEY (`active_until`,`page_name`,`zone_name`,`member_id`),
  KEY `mzaname` (`page_name`,`zone_name`),
  KEY `mzamember_id` (`member_id`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_member_tracking`;

CREATE TABLE `ocp7_member_tracking` (
  `mt_member_id` int(11) NOT NULL,
  `mt_cache_username` varchar(80) COLLATE latin1_bin NOT NULL,
  `mt_time` int(10) unsigned NOT NULL,
  `mt_page` varchar(80) COLLATE latin1_bin NOT NULL,
  `mt_type` varchar(80) COLLATE latin1_bin NOT NULL,
  `mt_id` varchar(80) COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`mt_member_id`,`mt_time`,`mt_page`,`mt_type`,`mt_id`),
  KEY `mt_page` (`mt_page`),
  KEY `mt_id` (`mt_page`,`mt_id`,`mt_type`)
) ENGINE=MyISAM;


DROP TABLE IF EXISTS `ocp7_member_zone_access`;

CREATE TABLE `ocp7_member_zone_access` (
  `active_until` int(10) unsigned NOT NULL,
  `zone_name` varchar(80) COLLATE latin1_bin NOT NULL,
  `member_id` int(11) NOT NULL,
  PRIMARY KEY (`active_until`,`zone_name`,`member_id`),
  KEY `mzazone_name` (`zone_name`),
  KEY `mzamember_id` (`member_id`)
) ENGINE=MyISAM;


