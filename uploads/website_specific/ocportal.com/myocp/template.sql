-- phpMyAdmin SQL Dump
-- version 3.2.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Feb 06, 2010 at 08:54 PM
-- Server version: 5.1.37
-- PHP Version: 5.2.4


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `us_demo`
--

-- --------------------------------------------------------

--
-- Table structure for table `ocp_addons`
--

DROP TABLE IF EXISTS `ocp_addons`;
CREATE TABLE IF NOT EXISTS `ocp_addons` (
  `addon_author` varchar(255) NOT NULL,
  `addon_description` longtext NOT NULL,
  `addon_install_time` int(10) unsigned NOT NULL,
  `addon_name` varchar(255) NOT NULL,
  `addon_organisation` varchar(255) NOT NULL,
  `addon_version` varchar(255) NOT NULL,
  PRIMARY KEY (`addon_name`)
) ENGINE=MyISAM;

--
-- Dumping data for table `ocp_addons`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_addons_dependencies`
--

DROP TABLE IF EXISTS `ocp_addons_dependencies`;
CREATE TABLE IF NOT EXISTS `ocp_addons_dependencies` (
  `addon_name` varchar(255) NOT NULL,
  `addon_name_dependant_upon` varchar(255) NOT NULL,
  `addon_name_incompatibility` tinyint(1) NOT NULL,
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 ;

--
-- Dumping data for table `ocp_addons_dependencies`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_addons_files`
--

DROP TABLE IF EXISTS `ocp_addons_files`;
CREATE TABLE IF NOT EXISTS `ocp_addons_files` (
  `addon_name` varchar(255) NOT NULL,
  `filename` varchar(255) NOT NULL,
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 ;

--
-- Dumping data for table `ocp_addons_files`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_adminlogs`
--

DROP TABLE IF EXISTS `ocp_adminlogs`;
CREATE TABLE IF NOT EXISTS `ocp_adminlogs` (
  `date_and_time` int(10) unsigned NOT NULL,
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ip` varchar(40) NOT NULL,
  `param_a` varchar(80) NOT NULL,
  `param_b` varchar(255) NOT NULL,
  `the_type` varchar(80) NOT NULL,
  `the_user` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 ;

--
-- Dumping data for table `ocp_adminlogs`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_attachments`
--

DROP TABLE IF EXISTS `ocp_attachments`;
CREATE TABLE IF NOT EXISTS `ocp_attachments` (
  `a_add_time` int(11) NOT NULL,
  `a_description` varchar(255) NOT NULL,
  `a_file_size` int(11) DEFAULT NULL,
  `a_last_downloaded_time` int(11) DEFAULT NULL,
  `a_member_id` int(11) NOT NULL,
  `a_num_downloads` int(11) NOT NULL,
  `a_original_filename` varchar(255) NOT NULL,
  `a_thumb_url` varchar(255) NOT NULL,
  `a_url` varchar(255) NOT NULL,
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  AUTO_INCREMENT=6 ;

--
-- Dumping data for table `ocp_attachments`
--

INSERT INTO `ocp_attachments` (`a_add_time`, `a_description`, `a_file_size`, `a_last_downloaded_time`, `a_member_id`, `a_num_downloads`, `a_original_filename`, `a_thumb_url`, `a_url`, `id`) VALUES(1264682350, '', 361097, NULL, 2, 0, 'Romeo_and_juliet_brown.jpg', 'uploads/attachments_thumbs/4b61856e782ae.jpg', 'uploads/attachments/4b61856e782ae.jpg', 1);
INSERT INTO `ocp_attachments` (`a_add_time`, `a_description`, `a_file_size`, `a_last_downloaded_time`, `a_member_id`, `a_num_downloads`, `a_original_filename`, `a_thumb_url`, `a_url`, `id`) VALUES(1264682523, '', 152244, NULL, 2, 0, 'Edwin_Booth_Hamlet_1870.jpg', 'uploads/attachments_thumbs/4b61861b3e467.jpg', 'uploads/attachments/4b61861b3e467.jpg', 2);
INSERT INTO `ocp_attachments` (`a_add_time`, `a_description`, `a_file_size`, `a_last_downloaded_time`, `a_member_id`, `a_num_downloads`, `a_original_filename`, `a_thumb_url`, `a_url`, `id`) VALUES(1264687209, '', 82395, 1265480681, 2, 17, 'Sample.mov', '', 'uploads/attachments/4b6198699c2a6.dat', 3);
INSERT INTO `ocp_attachments` (`a_add_time`, `a_description`, `a_file_size`, `a_last_downloaded_time`, `a_member_id`, `a_num_downloads`, `a_original_filename`, `a_thumb_url`, `a_url`, `id`) VALUES(1265480596, '', 539716, NULL, 2, 0, 'Shakespeare-1.jpg', 'uploads/attachments_thumbs/4b6db39467550.jpg', 'uploads/attachments/4b6db39467550.jpg', 4);
INSERT INTO `ocp_attachments` (`a_add_time`, `a_description`, `a_file_size`, `a_last_downloaded_time`, `a_member_id`, `a_num_downloads`, `a_original_filename`, `a_thumb_url`, `a_url`, `id`) VALUES(1265480597, '', 539716, NULL, 2, 0, 'Shakespeare-1.jpg', 'uploads/attachments_thumbs/4b6db394dd559.jpg', 'uploads/attachments/4b6db394dd559.jpg', 5);

-- --------------------------------------------------------

--
-- Table structure for table `ocp_attachment_refs`
--

DROP TABLE IF EXISTS `ocp_attachment_refs`;
CREATE TABLE IF NOT EXISTS `ocp_attachment_refs` (
  `a_id` int(11) NOT NULL,
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `r_referer_id` varchar(80) NOT NULL,
  `r_referer_type` varchar(80) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  AUTO_INCREMENT=17 ;

--
-- Dumping data for table `ocp_attachment_refs`
--

INSERT INTO `ocp_attachment_refs` (`a_id`, `id`, `r_referer_id`, `r_referer_type`) VALUES(1, 1, '1', 'cedi_post');
INSERT INTO `ocp_attachment_refs` (`a_id`, `id`, `r_referer_id`, `r_referer_type`) VALUES(2, 2, '2', 'cedi_post');
INSERT INTO `ocp_attachment_refs` (`a_id`, `id`, `r_referer_id`, `r_referer_type`) VALUES(3, 16, ':rich', 'comcode_page');
INSERT INTO `ocp_attachment_refs` (`a_id`, `id`, `r_referer_id`, `r_referer_type`) VALUES(3, 8, ':rich', 'comcode_page');
INSERT INTO `ocp_attachment_refs` (`a_id`, `id`, `r_referer_id`, `r_referer_type`) VALUES(4, 14, ':rich', 'comcode_page');
INSERT INTO `ocp_attachment_refs` (`a_id`, `id`, `r_referer_id`, `r_referer_type`) VALUES(5, 15, ':rich', 'comcode_page');

-- --------------------------------------------------------

--
-- Table structure for table `ocp_authors`
--

DROP TABLE IF EXISTS `ocp_authors`;
CREATE TABLE IF NOT EXISTS `ocp_authors` (
  `author` varchar(80) NOT NULL,
  `description` int(10) unsigned NOT NULL,
  `forum_handle` int(11) DEFAULT NULL,
  `skills` int(10) unsigned NOT NULL,
  `url` varchar(255) NOT NULL,
  PRIMARY KEY (`author`)
) ENGINE=MyISAM;

--
-- Dumping data for table `ocp_authors`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_autosave`
--

DROP TABLE IF EXISTS `ocp_autosave`;
CREATE TABLE IF NOT EXISTS `ocp_autosave` (
  `a_key` longtext NOT NULL,
  `a_member_id` int(11) NOT NULL,
  `a_time` int(10) unsigned NOT NULL,
  `a_value` longtext NOT NULL,
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 ;

--
-- Dumping data for table `ocp_autosave`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_award_archive`
--

DROP TABLE IF EXISTS `ocp_award_archive`;
CREATE TABLE IF NOT EXISTS `ocp_award_archive` (
  `a_type_id` int(11) NOT NULL,
  `content_id` varchar(80) NOT NULL,
  `date_and_time` int(10) unsigned NOT NULL,
  `member_id` int(11) NOT NULL,
  PRIMARY KEY (`a_type_id`,`date_and_time`)
) ENGINE=MyISAM;

--
-- Dumping data for table `ocp_award_archive`
--

INSERT INTO `ocp_award_archive` (`a_type_id`, `content_id`, `date_and_time`, `member_id`) VALUES(1, '1', 1264686219, 2);

-- --------------------------------------------------------

--
-- Table structure for table `ocp_award_types`
--

DROP TABLE IF EXISTS `ocp_award_types`;
CREATE TABLE IF NOT EXISTS `ocp_award_types` (
  `a_content_type` varchar(80) NOT NULL,
  `a_description` int(10) unsigned NOT NULL,
  `a_hide_awardee` tinyint(1) NOT NULL,
  `a_points` int(11) NOT NULL,
  `a_title` int(10) unsigned NOT NULL,
  `a_update_time_hours` int(11) NOT NULL,
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  AUTO_INCREMENT=2 ;

--
-- Dumping data for table `ocp_award_types`
--

INSERT INTO `ocp_award_types` (`a_content_type`, `a_description`, `a_hide_awardee`, `a_points`, `a_title`, `a_update_time_hours`, `id`) VALUES('download', 92, 1, 0, 91, 168, 1);

-- --------------------------------------------------------

--
-- Table structure for table `ocp_banners`
--

DROP TABLE IF EXISTS `ocp_banners`;
CREATE TABLE IF NOT EXISTS `ocp_banners` (
  `add_date` int(10) unsigned NOT NULL,
  `b_title_text` varchar(255) NOT NULL,
  `b_type` varchar(80) NOT NULL,
  `campaign_remaining` int(11) NOT NULL,
  `caption` int(10) unsigned NOT NULL,
  `edit_date` int(10) unsigned DEFAULT NULL,
  `expiry_date` int(10) unsigned DEFAULT NULL,
  `hits_from` int(11) NOT NULL,
  `hits_to` int(11) NOT NULL,
  `img_url` varchar(255) NOT NULL,
  `importance_modulus` int(11) NOT NULL,
  `name` varchar(80) NOT NULL,
  `notes` longtext NOT NULL,
  `site_url` varchar(255) NOT NULL,
  `submitter` int(11) NOT NULL,
  `the_type` tinyint(4) NOT NULL,
  `validated` tinyint(1) NOT NULL,
  `views_from` int(11) NOT NULL,
  `views_to` int(11) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=MyISAM;

--
-- Dumping data for table `ocp_banners`
--

INSERT INTO `ocp_banners` (`add_date`, `b_title_text`, `b_type`, `campaign_remaining`, `caption`, `edit_date`, `expiry_date`, `hits_from`, `hits_to`, `img_url`, `importance_modulus`, `name`, `notes`, `site_url`, `submitter`, `the_type`, `validated`, `views_from`, `views_to`) VALUES(1264608453, '', '', -1, 525, 1264608660, NULL, 0, 1, 'uploads/banners/banner1.png', 30, 'banner1', '', '/site/index.php?page=banner', 2, 0, 1, 0, 168);

-- --------------------------------------------------------

--
-- Table structure for table `ocp_banner_clicks`
--

DROP TABLE IF EXISTS `ocp_banner_clicks`;
CREATE TABLE IF NOT EXISTS `ocp_banner_clicks` (
  `c_banner_id` varchar(80) NOT NULL,
  `c_date_and_time` int(10) unsigned NOT NULL,
  `c_ip_address` varchar(40) NOT NULL,
  `c_member_id` int(11) NOT NULL,
  `c_source` varchar(80) NOT NULL,
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `clicker_ip` (`c_ip_address`)
) ENGINE=MyISAM  AUTO_INCREMENT=6 ;

--
-- Dumping data for table `ocp_banner_clicks`
--

INSERT INTO `ocp_banner_clicks` (`c_banner_id`, `c_date_and_time`, `c_ip_address`, `c_member_id`, `c_source`, `id`) VALUES('donate', 1264608541, '90.152.0.114', 1, '', 1);
INSERT INTO `ocp_banner_clicks` (`c_banner_id`, `c_date_and_time`, `c_ip_address`, `c_member_id`, `c_source`, `id`) VALUES('banner1', 1264608676, '90.152.0.114', 1, '', 2);
INSERT INTO `ocp_banner_clicks` (`c_banner_id`, `c_date_and_time`, `c_ip_address`, `c_member_id`, `c_source`, `id`) VALUES('banner1', 1264624362, '90.152.0.114', 1, '', 3);
INSERT INTO `ocp_banner_clicks` (`c_banner_id`, `c_date_and_time`, `c_ip_address`, `c_member_id`, `c_source`, `id`) VALUES('banner1', 1264669383, '90.152.0.114', 1, '', 4);
INSERT INTO `ocp_banner_clicks` (`c_banner_id`, `c_date_and_time`, `c_ip_address`, `c_member_id`, `c_source`, `id`) VALUES('banner1', 1264670437, '90.152.0.114', 1, '', 5);

-- --------------------------------------------------------

--
-- Table structure for table `ocp_banner_types`
--

DROP TABLE IF EXISTS `ocp_banner_types`;
CREATE TABLE IF NOT EXISTS `ocp_banner_types` (
  `id` varchar(80) NOT NULL,
  `t_comcode_inline` tinyint(1) NOT NULL,
  `t_image_height` int(11) NOT NULL,
  `t_image_width` int(11) NOT NULL,
  `t_is_textual` tinyint(1) NOT NULL,
  `t_max_file_size` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM;

--
-- Dumping data for table `ocp_banner_types`
--

INSERT INTO `ocp_banner_types` (`id`, `t_comcode_inline`, `t_image_height`, `t_image_width`, `t_is_textual`, `t_max_file_size`) VALUES('', 0, 60, 468, 0, 80);

-- --------------------------------------------------------

--
-- Table structure for table `ocp_blocks`
--

DROP TABLE IF EXISTS `ocp_blocks`;
CREATE TABLE IF NOT EXISTS `ocp_blocks` (
  `block_author` varchar(80) NOT NULL,
  `block_hacked_by` varchar(80) NOT NULL,
  `block_hack_version` int(11) DEFAULT NULL,
  `block_name` varchar(80) NOT NULL,
  `block_organisation` varchar(80) NOT NULL,
  `block_version` int(11) NOT NULL,
  PRIMARY KEY (`block_name`)
) ENGINE=MyISAM;

--
-- Dumping data for table `ocp_blocks`
--

INSERT INTO `ocp_blocks` (`block_author`, `block_hacked_by`, `block_hack_version`, `block_name`, `block_organisation`, `block_version`) VALUES('Chris Graham', '', NULL, 'bottom_forum_news', 'ocProducts', 2);
INSERT INTO `ocp_blocks` (`block_author`, `block_hacked_by`, `block_hack_version`, `block_name`, `block_organisation`, `block_version`) VALUES('Chris Graham', '', NULL, 'bottom_news', 'ocProducts', 2);
INSERT INTO `ocp_blocks` (`block_author`, `block_hacked_by`, `block_hack_version`, `block_name`, `block_organisation`, `block_version`) VALUES('Chris Graham', '', NULL, 'bottom_rss', 'ocProducts', 2);
INSERT INTO `ocp_blocks` (`block_author`, `block_hacked_by`, `block_hack_version`, `block_name`, `block_organisation`, `block_version`) VALUES('Chris Graham', '', NULL, 'main_as_zone_access', 'ocProducts', 2);
INSERT INTO `ocp_blocks` (`block_author`, `block_hacked_by`, `block_hack_version`, `block_name`, `block_organisation`, `block_version`) VALUES('Chris Graham', '', NULL, 'main_awards', 'ocProducts', 2);
INSERT INTO `ocp_blocks` (`block_author`, `block_hacked_by`, `block_hack_version`, `block_name`, `block_organisation`, `block_version`) VALUES('Chris Graham', '', NULL, 'main_banner_wave', 'ocProducts', 2);
INSERT INTO `ocp_blocks` (`block_author`, `block_hacked_by`, `block_hack_version`, `block_name`, `block_organisation`, `block_version`) VALUES('Chris Graham', '', NULL, 'main_block_help', 'ocProducts', 2);
INSERT INTO `ocp_blocks` (`block_author`, `block_hacked_by`, `block_hack_version`, `block_name`, `block_organisation`, `block_version`) VALUES('Chris Graham', '', NULL, 'main_cc_embed', 'ocProducts', 2);
INSERT INTO `ocp_blocks` (`block_author`, `block_hacked_by`, `block_hack_version`, `block_name`, `block_organisation`, `block_version`) VALUES('Chris Graham', '', NULL, 'main_code_documentor', 'ocProducts', 2);
INSERT INTO `ocp_blocks` (`block_author`, `block_hacked_by`, `block_hack_version`, `block_name`, `block_organisation`, `block_version`) VALUES('Chris Graham', '', NULL, 'main_comcode_page_children', 'ocProducts', 2);
INSERT INTO `ocp_blocks` (`block_author`, `block_hacked_by`, `block_hack_version`, `block_name`, `block_organisation`, `block_version`) VALUES('Chris Graham', '', NULL, 'main_comments', 'ocProducts', 2);
INSERT INTO `ocp_blocks` (`block_author`, `block_hacked_by`, `block_hack_version`, `block_name`, `block_organisation`, `block_version`) VALUES('Chris Graham', '', NULL, 'main_contact_simple', 'ocProducts', 2);
INSERT INTO `ocp_blocks` (`block_author`, `block_hacked_by`, `block_hack_version`, `block_name`, `block_organisation`, `block_version`) VALUES('Chris Graham', '', NULL, 'main_contact_us', 'ocProducts', 2);
INSERT INTO `ocp_blocks` (`block_author`, `block_hacked_by`, `block_hack_version`, `block_name`, `block_organisation`, `block_version`) VALUES('Chris Graham', '', NULL, 'main_content', 'ocProducts', 2);
INSERT INTO `ocp_blocks` (`block_author`, `block_hacked_by`, `block_hack_version`, `block_name`, `block_organisation`, `block_version`) VALUES('Chris Graham', '', NULL, 'main_count', 'ocProducts', 2);
INSERT INTO `ocp_blocks` (`block_author`, `block_hacked_by`, `block_hack_version`, `block_name`, `block_organisation`, `block_version`) VALUES('Chris Graham', '', NULL, 'main_countdown', 'ocProducts', 2);
INSERT INTO `ocp_blocks` (`block_author`, `block_hacked_by`, `block_hack_version`, `block_name`, `block_organisation`, `block_version`) VALUES('Chris Graham', '', NULL, 'main_custom_comcode_tags', 'ocProducts', 2);
INSERT INTO `ocp_blocks` (`block_author`, `block_hacked_by`, `block_hack_version`, `block_name`, `block_organisation`, `block_version`) VALUES('Chris Graham', '', NULL, 'main_custom_gfx', 'ocProducts', 1);
INSERT INTO `ocp_blocks` (`block_author`, `block_hacked_by`, `block_hack_version`, `block_name`, `block_organisation`, `block_version`) VALUES('Chris Graham', '', NULL, 'main_db_notes', 'ocProducts', 2);
INSERT INTO `ocp_blocks` (`block_author`, `block_hacked_by`, `block_hack_version`, `block_name`, `block_organisation`, `block_version`) VALUES('Chris Graham', '', NULL, 'main_download_category', 'ocProducts', 2);
INSERT INTO `ocp_blocks` (`block_author`, `block_hacked_by`, `block_hack_version`, `block_name`, `block_organisation`, `block_version`) VALUES('Chris Graham', '', NULL, 'main_download_tease', 'ocProducts', 2);
INSERT INTO `ocp_blocks` (`block_author`, `block_hacked_by`, `block_hack_version`, `block_name`, `block_organisation`, `block_version`) VALUES('Chris Graham', '', NULL, 'main_emoticon_codes', 'ocProducts', 2);
INSERT INTO `ocp_blocks` (`block_author`, `block_hacked_by`, `block_hack_version`, `block_name`, `block_organisation`, `block_version`) VALUES('Chris Graham', '', NULL, 'main_feedback', 'ocProducts', 1);
INSERT INTO `ocp_blocks` (`block_author`, `block_hacked_by`, `block_hack_version`, `block_name`, `block_organisation`, `block_version`) VALUES('Chris Graham', '', NULL, 'main_forum_news', 'ocProducts', 2);
INSERT INTO `ocp_blocks` (`block_author`, `block_hacked_by`, `block_hack_version`, `block_name`, `block_organisation`, `block_version`) VALUES('Chris Graham', '', NULL, 'main_forum_topics', 'ocProducts', 2);
INSERT INTO `ocp_blocks` (`block_author`, `block_hacked_by`, `block_hack_version`, `block_name`, `block_organisation`, `block_version`) VALUES('Chris Graham', '', NULL, 'main_gallery_embed', 'ocProducts', 2);
INSERT INTO `ocp_blocks` (`block_author`, `block_hacked_by`, `block_hack_version`, `block_name`, `block_organisation`, `block_version`) VALUES('Chris Graham', '', NULL, 'main_gallery_tease', 'ocProducts', 2);
INSERT INTO `ocp_blocks` (`block_author`, `block_hacked_by`, `block_hack_version`, `block_name`, `block_organisation`, `block_version`) VALUES('Chris Graham', '', NULL, 'main_greeting', 'ocProducts', 2);
INSERT INTO `ocp_blocks` (`block_author`, `block_hacked_by`, `block_hack_version`, `block_name`, `block_organisation`, `block_version`) VALUES('Chris Graham', '', NULL, 'main_include_module', 'ocProducts', 1);
INSERT INTO `ocp_blocks` (`block_author`, `block_hacked_by`, `block_hack_version`, `block_name`, `block_organisation`, `block_version`) VALUES('Chris Graham', '', NULL, 'main_iotd', 'ocProducts', 2);
INSERT INTO `ocp_blocks` (`block_author`, `block_hacked_by`, `block_hack_version`, `block_name`, `block_organisation`, `block_version`) VALUES('Chris Graham', '', NULL, 'main_leader_board', 'ocProducts', 3);
INSERT INTO `ocp_blocks` (`block_author`, `block_hacked_by`, `block_hack_version`, `block_name`, `block_organisation`, `block_version`) VALUES('Chris Graham', '', NULL, 'main_news', 'ocProducts', 2);
INSERT INTO `ocp_blocks` (`block_author`, `block_hacked_by`, `block_hack_version`, `block_name`, `block_organisation`, `block_version`) VALUES('Chris Graham', '', NULL, 'main_newsletter_signup', 'ocProducts', 2);
INSERT INTO `ocp_blocks` (`block_author`, `block_hacked_by`, `block_hack_version`, `block_name`, `block_organisation`, `block_version`) VALUES('Chris Graham', '', NULL, 'main_notes', 'ocProducts', 2);
INSERT INTO `ocp_blocks` (`block_author`, `block_hacked_by`, `block_hack_version`, `block_name`, `block_organisation`, `block_version`) VALUES('Chris Graham', '', NULL, 'main_only_if_match', 'ocProducts', 2);
INSERT INTO `ocp_blocks` (`block_author`, `block_hacked_by`, `block_hack_version`, `block_name`, `block_organisation`, `block_version`) VALUES('Chris Graham', '', NULL, 'main_poll', 'ocProducts', 2);
INSERT INTO `ocp_blocks` (`block_author`, `block_hacked_by`, `block_hack_version`, `block_name`, `block_organisation`, `block_version`) VALUES('Chris Graham', '', NULL, 'main_quotes', 'ocProducts', 2);
INSERT INTO `ocp_blocks` (`block_author`, `block_hacked_by`, `block_hack_version`, `block_name`, `block_organisation`, `block_version`) VALUES('Chris Graham', '', NULL, 'main_rating', 'ocProducts', 2);
INSERT INTO `ocp_blocks` (`block_author`, `block_hacked_by`, `block_hack_version`, `block_name`, `block_organisation`, `block_version`) VALUES('Chris Graham', '', NULL, 'main_recent_cc_entries', 'ocProducts', 2);
INSERT INTO `ocp_blocks` (`block_author`, `block_hacked_by`, `block_hack_version`, `block_name`, `block_organisation`, `block_version`) VALUES('Chris Graham', '', NULL, 'main_recent_downloads', 'ocProducts', 2);
INSERT INTO `ocp_blocks` (`block_author`, `block_hacked_by`, `block_hack_version`, `block_name`, `block_organisation`, `block_version`) VALUES('Chris Graham', '', NULL, 'main_recent_galleries', 'ocProducts', 2);
INSERT INTO `ocp_blocks` (`block_author`, `block_hacked_by`, `block_hack_version`, `block_name`, `block_organisation`, `block_version`) VALUES('Chris Graham', '', NULL, 'main_rss', 'ocProducts', 3);
INSERT INTO `ocp_blocks` (`block_author`, `block_hacked_by`, `block_hack_version`, `block_name`, `block_organisation`, `block_version`) VALUES('Chris Graham', '', NULL, 'main_screen_actions', 'ocProducts', 2);
INSERT INTO `ocp_blocks` (`block_author`, `block_hacked_by`, `block_hack_version`, `block_name`, `block_organisation`, `block_version`) VALUES('Chris Graham', '', NULL, 'main_search', 'ocProducts', 2);
INSERT INTO `ocp_blocks` (`block_author`, `block_hacked_by`, `block_hack_version`, `block_name`, `block_organisation`, `block_version`) VALUES('Chris Graham', '', NULL, 'main_sitemap', 'ocProducts', 2);
INSERT INTO `ocp_blocks` (`block_author`, `block_hacked_by`, `block_hack_version`, `block_name`, `block_organisation`, `block_version`) VALUES('Chris Graham', '', NULL, 'main_staff_actions', 'ocProducts', 2);
INSERT INTO `ocp_blocks` (`block_author`, `block_hacked_by`, `block_hack_version`, `block_name`, `block_organisation`, `block_version`) VALUES('Chris Graham', '', NULL, 'main_staff_checklist', 'ocProducts', 3);
INSERT INTO `ocp_blocks` (`block_author`, `block_hacked_by`, `block_hack_version`, `block_name`, `block_organisation`, `block_version`) VALUES('Chris Graham', '', NULL, 'main_staff_new_version', 'ocProducts', 2);
INSERT INTO `ocp_blocks` (`block_author`, `block_hacked_by`, `block_hack_version`, `block_name`, `block_organisation`, `block_version`) VALUES('Chris Graham', '', NULL, 'main_staff_tips', 'ocProducts', 2);
INSERT INTO `ocp_blocks` (`block_author`, `block_hacked_by`, `block_hack_version`, `block_name`, `block_organisation`, `block_version`) VALUES('Chris Graham', '', NULL, 'main_top_downloads', 'ocProducts', 2);
INSERT INTO `ocp_blocks` (`block_author`, `block_hacked_by`, `block_hack_version`, `block_name`, `block_organisation`, `block_version`) VALUES('Chris Graham', '', NULL, 'main_top_galleries', 'ocProducts', 2);
INSERT INTO `ocp_blocks` (`block_author`, `block_hacked_by`, `block_hack_version`, `block_name`, `block_organisation`, `block_version`) VALUES('Chris Graham', '', NULL, 'main_topsites', 'ocProducts', 2);
INSERT INTO `ocp_blocks` (`block_author`, `block_hacked_by`, `block_hack_version`, `block_name`, `block_organisation`, `block_version`) VALUES('Philip Withnall', '', NULL, 'main_trackback', 'ocProducts', 1);
INSERT INTO `ocp_blocks` (`block_author`, `block_hacked_by`, `block_hack_version`, `block_name`, `block_organisation`, `block_version`) VALUES('Chris Graham', '', NULL, 'side_calendar', 'ocProducts', 2);
INSERT INTO `ocp_blocks` (`block_author`, `block_hacked_by`, `block_hack_version`, `block_name`, `block_organisation`, `block_version`) VALUES('Chris Graham', '', NULL, 'side_forum_news', 'ocProducts', 2);
INSERT INTO `ocp_blocks` (`block_author`, `block_hacked_by`, `block_hack_version`, `block_name`, `block_organisation`, `block_version`) VALUES('Chris Graham', '', NULL, 'side_language', 'ocProducts', 2);
INSERT INTO `ocp_blocks` (`block_author`, `block_hacked_by`, `block_hack_version`, `block_name`, `block_organisation`, `block_version`) VALUES('Chris Graham', '', NULL, 'side_network', 'ocProducts', 2);
INSERT INTO `ocp_blocks` (`block_author`, `block_hacked_by`, `block_hack_version`, `block_name`, `block_organisation`, `block_version`) VALUES('Chris Graham', '', NULL, 'side_news', 'ocProducts', 2);
INSERT INTO `ocp_blocks` (`block_author`, `block_hacked_by`, `block_hack_version`, `block_name`, `block_organisation`, `block_version`) VALUES('Chris Graham', '', NULL, 'side_news_categories', 'ocProducts', 2);
INSERT INTO `ocp_blocks` (`block_author`, `block_hacked_by`, `block_hack_version`, `block_name`, `block_organisation`, `block_version`) VALUES('Chris Graham', '', NULL, 'side_ocf_personal_topics', 'ocProducts', 2);
INSERT INTO `ocp_blocks` (`block_author`, `block_hacked_by`, `block_hack_version`, `block_name`, `block_organisation`, `block_version`) VALUES('Chris Graham', '', NULL, 'side_personal_stats', 'ocProducts', 2);
INSERT INTO `ocp_blocks` (`block_author`, `block_hacked_by`, `block_hack_version`, `block_name`, `block_organisation`, `block_version`) VALUES('Chris Graham', '', NULL, 'side_printer_friendly', 'ocProducts', 2);
INSERT INTO `ocp_blocks` (`block_author`, `block_hacked_by`, `block_hack_version`, `block_name`, `block_organisation`, `block_version`) VALUES('Chris Graham', '', NULL, 'side_root_galleries', 'ocProducts', 2);
INSERT INTO `ocp_blocks` (`block_author`, `block_hacked_by`, `block_hack_version`, `block_name`, `block_organisation`, `block_version`) VALUES('Chris Graham', '', NULL, 'side_rss', 'ocProducts', 2);
INSERT INTO `ocp_blocks` (`block_author`, `block_hacked_by`, `block_hack_version`, `block_name`, `block_organisation`, `block_version`) VALUES('Philip Withnall', '', NULL, 'side_shoutbox', 'ocProducts', 3);
INSERT INTO `ocp_blocks` (`block_author`, `block_hacked_by`, `block_hack_version`, `block_name`, `block_organisation`, `block_version`) VALUES('Chris Graham', '', NULL, 'side_stats', 'ocProducts', 3);
INSERT INTO `ocp_blocks` (`block_author`, `block_hacked_by`, `block_hack_version`, `block_name`, `block_organisation`, `block_version`) VALUES('Chris Graham', '', NULL, 'side_stored_menu', 'ocProducts', 2);
INSERT INTO `ocp_blocks` (`block_author`, `block_hacked_by`, `block_hack_version`, `block_name`, `block_organisation`, `block_version`) VALUES('Chris Graham', '', NULL, 'side_tag_cloud', 'ocProducts', 3);
INSERT INTO `ocp_blocks` (`block_author`, `block_hacked_by`, `block_hack_version`, `block_name`, `block_organisation`, `block_version`) VALUES('Chris Graham', '', NULL, 'side_users_online', 'ocProducts', 3);
INSERT INTO `ocp_blocks` (`block_author`, `block_hacked_by`, `block_hack_version`, `block_name`, `block_organisation`, `block_version`) VALUES('Manuprathap', '', NULL, 'side_weather', 'ocProducts', 5);
INSERT INTO `ocp_blocks` (`block_author`, `block_hacked_by`, `block_hack_version`, `block_name`, `block_organisation`, `block_version`) VALUES('Chris Graham', '', NULL, 'side_zone_jump', 'ocProducts', 2);

-- --------------------------------------------------------

--
-- Table structure for table `ocp_bookmarks`
--

DROP TABLE IF EXISTS `ocp_bookmarks`;
CREATE TABLE IF NOT EXISTS `ocp_bookmarks` (
  `b_folder` varchar(255) NOT NULL,
  `b_owner` int(11) NOT NULL,
  `b_page_link` varchar(255) NOT NULL,
  `b_title` varchar(255) NOT NULL,
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 ;

--
-- Dumping data for table `ocp_bookmarks`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_cache`
--

DROP TABLE IF EXISTS `ocp_cache`;
CREATE TABLE IF NOT EXISTS `ocp_cache` (
  `cached_for` varchar(80) NOT NULL,
  `date_and_time` int(10) unsigned NOT NULL,
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) NOT NULL,
  `lang` varchar(5) NOT NULL,
  `langs_required` longtext NOT NULL,
  `the_theme` varchar(80) NOT NULL,
  `the_value` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cached_for` (`cached_for`),
  KEY `cached_ford` (`date_and_time`),
  KEY `cached_fori` (`identifier`),
  KEY `cached_forl` (`lang`),
  KEY `cached_fort` (`the_theme`)
) ENGINE=MyISAM AUTO_INCREMENT=1 ;

--
-- Dumping data for table `ocp_cache`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_cached_comcode_pages`
--

DROP TABLE IF EXISTS `ocp_cached_comcode_pages`;
CREATE TABLE IF NOT EXISTS `ocp_cached_comcode_pages` (
  `cc_page_title` int(10) unsigned DEFAULT NULL,
  `string_index` int(10) unsigned NOT NULL,
  `the_page` varchar(80) NOT NULL,
  `the_theme` varchar(80) NOT NULL,
  `the_zone` varchar(80) NOT NULL,
  PRIMARY KEY (`the_page`,`the_theme`,`the_zone`)
) ENGINE=MyISAM;

--
-- Dumping data for table `ocp_cached_comcode_pages`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_cache_on`
--

DROP TABLE IF EXISTS `ocp_cache_on`;
CREATE TABLE IF NOT EXISTS `ocp_cache_on` (
  `cached_for` varchar(80) NOT NULL,
  `cache_on` longtext NOT NULL,
  `cache_ttl` int(11) NOT NULL,
  PRIMARY KEY (`cached_for`)
) ENGINE=MyISAM;

--
-- Dumping data for table `ocp_cache_on`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_calendar_events`
--

DROP TABLE IF EXISTS `ocp_calendar_events`;
CREATE TABLE IF NOT EXISTS `ocp_calendar_events` (
  `allow_comments` tinyint(4) NOT NULL,
  `allow_rating` tinyint(1) NOT NULL,
  `allow_trackbacks` tinyint(1) NOT NULL,
  `e_add_date` int(10) unsigned NOT NULL,
  `e_content` int(10) unsigned NOT NULL,
  `e_edit_date` int(10) unsigned DEFAULT NULL,
  `e_end_day` int(11) DEFAULT NULL,
  `e_end_hour` int(11) DEFAULT NULL,
  `e_end_minute` int(11) DEFAULT NULL,
  `e_end_month` int(11) DEFAULT NULL,
  `e_end_year` int(11) DEFAULT NULL,
  `e_geo_position` varchar(255) NOT NULL,
  `e_groups_access` varchar(255) NOT NULL,
  `e_groups_modify` varchar(255) NOT NULL,
  `e_is_public` tinyint(1) NOT NULL,
  `e_priority` int(11) NOT NULL,
  `e_recurrence` varchar(80) NOT NULL,
  `e_recurrences` int(11) DEFAULT NULL,
  `e_seg_recurrences` tinyint(1) NOT NULL,
  `e_start_day` int(11) NOT NULL,
  `e_start_hour` int(11) NOT NULL,
  `e_start_minute` int(11) NOT NULL,
  `e_start_month` int(11) NOT NULL,
  `e_start_year` int(11) NOT NULL,
  `e_submitter` int(11) NOT NULL,
  `e_title` int(10) unsigned NOT NULL,
  `e_type` int(11) NOT NULL,
  `e_views` int(11) NOT NULL,
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `notes` longtext NOT NULL,
  `validated` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  AUTO_INCREMENT=2 ;

--
-- Dumping data for table `ocp_calendar_events`
--

INSERT INTO `ocp_calendar_events` (`allow_comments`, `allow_rating`, `allow_trackbacks`, `e_add_date`, `e_content`, `e_edit_date`, `e_end_day`, `e_end_hour`, `e_end_minute`, `e_end_month`, `e_end_year`, `e_geo_position`, `e_groups_access`, `e_groups_modify`, `e_is_public`, `e_priority`, `e_recurrence`, `e_recurrences`, `e_seg_recurrences`, `e_start_day`, `e_start_hour`, `e_start_minute`, `e_start_month`, `e_start_year`, `e_submitter`, `e_title`, `e_type`, `e_views`, `id`, `notes`, `validated`) VALUES(1, 1, 1, 1264682830, 711, NULL, 1, 15, 0, 1, 2010, '', '', '', 1, 3, 'daily', NULL, 1, 1, 12, 0, 1, 2010, 2, 710, 2, 2, 1, '', 1);

-- --------------------------------------------------------

--
-- Table structure for table `ocp_calendar_interests`
--

DROP TABLE IF EXISTS `ocp_calendar_interests`;
CREATE TABLE IF NOT EXISTS `ocp_calendar_interests` (
  `i_member_id` int(11) NOT NULL,
  `t_type` int(11) NOT NULL,
  PRIMARY KEY (`i_member_id`,`t_type`)
) ENGINE=MyISAM;

--
-- Dumping data for table `ocp_calendar_interests`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_calendar_jobs`
--

DROP TABLE IF EXISTS `ocp_calendar_jobs`;
CREATE TABLE IF NOT EXISTS `ocp_calendar_jobs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `j_event_id` int(11) NOT NULL,
  `j_member_id` int(11) DEFAULT NULL,
  `j_reminder_id` int(11) DEFAULT NULL,
  `j_time` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 ;

--
-- Dumping data for table `ocp_calendar_jobs`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_calendar_reminders`
--

DROP TABLE IF EXISTS `ocp_calendar_reminders`;
CREATE TABLE IF NOT EXISTS `ocp_calendar_reminders` (
  `e_id` int(11) NOT NULL,
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `n_member_id` int(11) NOT NULL,
  `n_seconds_before` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 ;

--
-- Dumping data for table `ocp_calendar_reminders`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_calendar_types`
--

DROP TABLE IF EXISTS `ocp_calendar_types`;
CREATE TABLE IF NOT EXISTS `ocp_calendar_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `t_logo` varchar(255) NOT NULL,
  `t_title` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  AUTO_INCREMENT=9 ;

--
-- Dumping data for table `ocp_calendar_types`
--

INSERT INTO `ocp_calendar_types` (`id`, `t_logo`, `t_title`) VALUES(1, 'calendar/system_command', 174);
INSERT INTO `ocp_calendar_types` (`id`, `t_logo`, `t_title`) VALUES(2, 'calendar/general', 175);
INSERT INTO `ocp_calendar_types` (`id`, `t_logo`, `t_title`) VALUES(3, 'calendar/birthday', 176);
INSERT INTO `ocp_calendar_types` (`id`, `t_logo`, `t_title`) VALUES(4, 'calendar/public_holiday', 177);
INSERT INTO `ocp_calendar_types` (`id`, `t_logo`, `t_title`) VALUES(5, 'calendar/vacation', 178);
INSERT INTO `ocp_calendar_types` (`id`, `t_logo`, `t_title`) VALUES(6, 'calendar/appointment', 179);
INSERT INTO `ocp_calendar_types` (`id`, `t_logo`, `t_title`) VALUES(7, 'calendar/commitment', 180);
INSERT INTO `ocp_calendar_types` (`id`, `t_logo`, `t_title`) VALUES(8, 'calendar/anniversary', 181);

-- --------------------------------------------------------

--
-- Table structure for table `ocp_catalogues`
--

DROP TABLE IF EXISTS `ocp_catalogues`;
CREATE TABLE IF NOT EXISTS `ocp_catalogues` (
  `c_add_date` int(10) unsigned NOT NULL,
  `c_description` int(10) unsigned NOT NULL,
  `c_display_type` tinyint(4) NOT NULL,
  `c_ecommerce` tinyint(1) NOT NULL,
  `c_is_tree` tinyint(1) NOT NULL,
  `c_name` varchar(80) NOT NULL,
  `c_notes` longtext NOT NULL,
  `c_send_view_reports` varchar(80) NOT NULL,
  `c_submit_points` int(11) NOT NULL,
  `c_title` int(10) unsigned NOT NULL,
  PRIMARY KEY (`c_name`)
) ENGINE=MyISAM;

--
-- Dumping data for table `ocp_catalogues`
--

INSERT INTO `ocp_catalogues` (`c_add_date`, `c_description`, `c_display_type`, `c_ecommerce`, `c_is_tree`, `c_name`, `c_notes`, `c_send_view_reports`, `c_submit_points`, `c_title`) VALUES(1264606826, 221, 2, 0, 1, 'links', '', 'never', 0, 220);
INSERT INTO `ocp_catalogues` (`c_add_date`, `c_description`, `c_display_type`, `c_ecommerce`, `c_is_tree`, `c_name`, `c_notes`, `c_send_view_reports`, `c_submit_points`, `c_title`) VALUES(1264606826, 241, 0, 0, 0, 'contacts', '', 'never', 30, 240);
INSERT INTO `ocp_catalogues` (`c_add_date`, `c_description`, `c_display_type`, `c_ecommerce`, `c_is_tree`, `c_name`, `c_notes`, `c_send_view_reports`, `c_submit_points`, `c_title`) VALUES(1264606826, 277, 1, 1, 1, 'products', '', 'never', 0, 276);

-- --------------------------------------------------------

--
-- Table structure for table `ocp_catalogue_categories`
--

DROP TABLE IF EXISTS `ocp_catalogue_categories`;
CREATE TABLE IF NOT EXISTS `ocp_catalogue_categories` (
  `cc_add_date` int(10) unsigned NOT NULL,
  `cc_description` int(10) unsigned NOT NULL,
  `cc_move_days_higher` int(11) NOT NULL,
  `cc_move_days_lower` int(11) NOT NULL,
  `cc_move_target` int(11) DEFAULT NULL,
  `cc_notes` longtext NOT NULL,
  `cc_parent_id` int(11) DEFAULT NULL,
  `cc_title` int(10) unsigned NOT NULL,
  `c_name` varchar(80) NOT NULL,
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `rep_image` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  AUTO_INCREMENT=9 ;

--
-- Dumping data for table `ocp_catalogue_categories`
--

INSERT INTO `ocp_catalogue_categories` (`cc_add_date`, `cc_description`, `cc_move_days_higher`, `cc_move_days_lower`, `cc_move_target`, `cc_notes`, `cc_parent_id`, `cc_title`, `c_name`, `id`, `rep_image`) VALUES(1264606826, 223, 60, 30, NULL, '', NULL, 222, 'links', 3, '');
INSERT INTO `ocp_catalogue_categories` (`cc_add_date`, `cc_description`, `cc_move_days_higher`, `cc_move_days_lower`, `cc_move_target`, `cc_notes`, `cc_parent_id`, `cc_title`, `c_name`, `id`, `rep_image`) VALUES(1264606826, 267, 60, 30, NULL, '', NULL, 266, 'contacts', 5, '');
INSERT INTO `ocp_catalogue_categories` (`cc_add_date`, `cc_description`, `cc_move_days_higher`, `cc_move_days_lower`, `cc_move_target`, `cc_notes`, `cc_parent_id`, `cc_title`, `c_name`, `id`, `rep_image`) VALUES(1264606826, 279, 60, 30, NULL, '', NULL, 278, 'products', 6, '');
INSERT INTO `ocp_catalogue_categories` (`cc_add_date`, `cc_description`, `cc_move_days_higher`, `cc_move_days_lower`, `cc_move_target`, `cc_notes`, `cc_parent_id`, `cc_title`, `c_name`, `id`, `rep_image`) VALUES(1264676385, 652, 60, 30, NULL, '', NULL, 653, 'products', 7, '');
INSERT INTO `ocp_catalogue_categories` (`cc_add_date`, `cc_description`, `cc_move_days_higher`, `cc_move_days_lower`, `cc_move_target`, `cc_notes`, `cc_parent_id`, `cc_title`, `c_name`, `id`, `rep_image`) VALUES(1264679163, 654, 60, 30, NULL, '', 6, 655, 'products', 8, '');

-- --------------------------------------------------------

--
-- Table structure for table `ocp_catalogue_efv_long`
--

DROP TABLE IF EXISTS `ocp_catalogue_efv_long`;
CREATE TABLE IF NOT EXISTS `ocp_catalogue_efv_long` (
  `ce_id` int(11) NOT NULL,
  `cf_id` int(11) NOT NULL,
  `cv_value` longtext NOT NULL,
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `lcf_id` (`cf_id`),
  KEY `lce_id` (`ce_id`),
  FULLTEXT KEY `lcv_value` (`cv_value`)
) ENGINE=MyISAM  AUTO_INCREMENT=9 ;

--
-- Dumping data for table `ocp_catalogue_efv_long`
--

INSERT INTO `ocp_catalogue_efv_long` (`ce_id`, `cf_id`, `cv_value`, `id`) VALUES(1, 37, 'No', 1);
INSERT INTO `ocp_catalogue_efv_long` (`ce_id`, `cf_id`, `cv_value`, `id`) VALUES(1, 38, '10%', 2);
INSERT INTO `ocp_catalogue_efv_long` (`ce_id`, `cf_id`, `cv_value`, `id`) VALUES(2, 37, 'No', 3);
INSERT INTO `ocp_catalogue_efv_long` (`ce_id`, `cf_id`, `cv_value`, `id`) VALUES(2, 38, '10%', 4);
INSERT INTO `ocp_catalogue_efv_long` (`ce_id`, `cf_id`, `cv_value`, `id`) VALUES(3, 30, 'State of the Union\nInauguration', 5);
INSERT INTO `ocp_catalogue_efv_long` (`ce_id`, `cf_id`, `cv_value`, `id`) VALUES(3, 31, 'President of the United States: 2008-', 6);
INSERT INTO `ocp_catalogue_efv_long` (`ce_id`, `cf_id`, `cv_value`, `id`) VALUES(4, 30, 'Queen''s Speech\n', 7);
INSERT INTO `ocp_catalogue_efv_long` (`ce_id`, `cf_id`, `cv_value`, `id`) VALUES(4, 31, 'Prime Minister of the United Kingdom of Great Britain and Northern Ireland: 2007-', 8);

-- --------------------------------------------------------

--
-- Table structure for table `ocp_catalogue_efv_long_trans`
--

DROP TABLE IF EXISTS `ocp_catalogue_efv_long_trans`;
CREATE TABLE IF NOT EXISTS `ocp_catalogue_efv_long_trans` (
  `ce_id` int(11) NOT NULL,
  `cf_id` int(11) NOT NULL,
  `cv_value` int(10) unsigned NOT NULL,
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `ltcf_id` (`cf_id`),
  KEY `ltce_id` (`ce_id`)
) ENGINE=MyISAM  AUTO_INCREMENT=6 ;

--
-- Dumping data for table `ocp_catalogue_efv_long_trans`
--

INSERT INTO `ocp_catalogue_efv_long_trans` (`ce_id`, `cf_id`, `cv_value`, `id`) VALUES(1, 41, 657, 1);
INSERT INTO `ocp_catalogue_efv_long_trans` (`ce_id`, `cf_id`, `cv_value`, `id`) VALUES(2, 41, 663, 2);
INSERT INTO `ocp_catalogue_efv_long_trans` (`ce_id`, `cf_id`, `cv_value`, `id`) VALUES(5, 16, 675, 3);
INSERT INTO `ocp_catalogue_efv_long_trans` (`ce_id`, `cf_id`, `cv_value`, `id`) VALUES(6, 16, 679, 4);
INSERT INTO `ocp_catalogue_efv_long_trans` (`ce_id`, `cf_id`, `cv_value`, `id`) VALUES(7, 16, 683, 5);

-- --------------------------------------------------------

--
-- Table structure for table `ocp_catalogue_efv_short`
--

DROP TABLE IF EXISTS `ocp_catalogue_efv_short`;
CREATE TABLE IF NOT EXISTS `ocp_catalogue_efv_short` (
  `ce_id` int(11) NOT NULL,
  `cf_id` int(11) NOT NULL,
  `cv_value` varchar(255) NOT NULL,
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `iscv_value` (`cv_value`),
  KEY `scf_id` (`cf_id`),
  KEY `sce_id` (`ce_id`),
  FULLTEXT KEY `scv_value` (`cv_value`)
) ENGINE=MyISAM  AUTO_INCREMENT=36 ;

--
-- Dumping data for table `ocp_catalogue_efv_short`
--

INSERT INTO `ocp_catalogue_efv_short` (`ce_id`, `cf_id`, `cv_value`, `id`) VALUES(1, 33, '0', 1);
INSERT INTO `ocp_catalogue_efv_short` (`ce_id`, `cf_id`, `cv_value`, `id`) VALUES(1, 34, '15', 2);
INSERT INTO `ocp_catalogue_efv_short` (`ce_id`, `cf_id`, `cv_value`, `id`) VALUES(1, 35, '300', 3);
INSERT INTO `ocp_catalogue_efv_short` (`ce_id`, `cf_id`, `cv_value`, `id`) VALUES(1, 36, '50', 4);
INSERT INTO `ocp_catalogue_efv_short` (`ce_id`, `cf_id`, `cv_value`, `id`) VALUES(1, 39, 'uploads/catalogues/Romeo_and_juliet_brown.jpg', 5);
INSERT INTO `ocp_catalogue_efv_short` (`ce_id`, `cf_id`, `cv_value`, `id`) VALUES(1, 40, '2', 6);
INSERT INTO `ocp_catalogue_efv_short` (`ce_id`, `cf_id`, `cv_value`, `id`) VALUES(2, 33, '1', 7);
INSERT INTO `ocp_catalogue_efv_short` (`ce_id`, `cf_id`, `cv_value`, `id`) VALUES(2, 34, '20', 8);
INSERT INTO `ocp_catalogue_efv_short` (`ce_id`, `cf_id`, `cv_value`, `id`) VALUES(2, 35, '300', 9);
INSERT INTO `ocp_catalogue_efv_short` (`ce_id`, `cf_id`, `cv_value`, `id`) VALUES(2, 36, '50', 10);
INSERT INTO `ocp_catalogue_efv_short` (`ce_id`, `cf_id`, `cv_value`, `id`) VALUES(2, 39, 'uploads/catalogues/Edwin_Booth_Hamlet_1870.jpg', 11);
INSERT INTO `ocp_catalogue_efv_short` (`ce_id`, `cf_id`, `cv_value`, `id`) VALUES(2, 40, '0', 12);
INSERT INTO `ocp_catalogue_efv_short` (`ce_id`, `cf_id`, `cv_value`, `id`) VALUES(3, 20, 'Barack', 13);
INSERT INTO `ocp_catalogue_efv_short` (`ce_id`, `cf_id`, `cv_value`, `id`) VALUES(3, 21, 'Obama', 14);
INSERT INTO `ocp_catalogue_efv_short` (`ce_id`, `cf_id`, `cv_value`, `id`) VALUES(3, 22, 'potus@whitehouse.gov', 15);
INSERT INTO `ocp_catalogue_efv_short` (`ce_id`, `cf_id`, `cv_value`, `id`) VALUES(3, 23, 'The Executive Office of the President of the United States of America', 16);
INSERT INTO `ocp_catalogue_efv_short` (`ce_id`, `cf_id`, `cv_value`, `id`) VALUES(3, 24, 'The White House, 1600 Pennsylvania Avenue NW', 17);
INSERT INTO `ocp_catalogue_efv_short` (`ce_id`, `cf_id`, `cv_value`, `id`) VALUES(3, 25, 'Washington D.C.', 18);
INSERT INTO `ocp_catalogue_efv_short` (`ce_id`, `cf_id`, `cv_value`, `id`) VALUES(3, 26, '202-456-1414', 19);
INSERT INTO `ocp_catalogue_efv_short` (`ce_id`, `cf_id`, `cv_value`, `id`) VALUES(3, 27, '202-456-1414', 20);
INSERT INTO `ocp_catalogue_efv_short` (`ce_id`, `cf_id`, `cv_value`, `id`) VALUES(3, 28, 'http://whitehouse.gov', 21);
INSERT INTO `ocp_catalogue_efv_short` (`ce_id`, `cf_id`, `cv_value`, `id`) VALUES(3, 29, 'barryo@msn.com', 22);
INSERT INTO `ocp_catalogue_efv_short` (`ce_id`, `cf_id`, `cv_value`, `id`) VALUES(4, 20, 'Gordon', 23);
INSERT INTO `ocp_catalogue_efv_short` (`ce_id`, `cf_id`, `cv_value`, `id`) VALUES(4, 21, 'Brown', 24);
INSERT INTO `ocp_catalogue_efv_short` (`ce_id`, `cf_id`, `cv_value`, `id`) VALUES(4, 22, 'pm@number10.gov.uk', 25);
INSERT INTO `ocp_catalogue_efv_short` (`ce_id`, `cf_id`, `cv_value`, `id`) VALUES(4, 23, 'Her Majesty''s Government', 26);
INSERT INTO `ocp_catalogue_efv_short` (`ce_id`, `cf_id`, `cv_value`, `id`) VALUES(4, 24, '10 Downing Street', 27);
INSERT INTO `ocp_catalogue_efv_short` (`ce_id`, `cf_id`, `cv_value`, `id`) VALUES(4, 25, 'London', 28);
INSERT INTO `ocp_catalogue_efv_short` (`ce_id`, `cf_id`, `cv_value`, `id`) VALUES(4, 26, '020 7925 0918', 29);
INSERT INTO `ocp_catalogue_efv_short` (`ce_id`, `cf_id`, `cv_value`, `id`) VALUES(4, 27, '020 7925 0918', 30);
INSERT INTO `ocp_catalogue_efv_short` (`ce_id`, `cf_id`, `cv_value`, `id`) VALUES(4, 28, 'http://www.number10.gov.uk/', 31);
INSERT INTO `ocp_catalogue_efv_short` (`ce_id`, `cf_id`, `cv_value`, `id`) VALUES(4, 29, 'gordon@aol.com', 32);
INSERT INTO `ocp_catalogue_efv_short` (`ce_id`, `cf_id`, `cv_value`, `id`) VALUES(5, 15, 'http://ocportal.com', 33);
INSERT INTO `ocp_catalogue_efv_short` (`ce_id`, `cf_id`, `cv_value`, `id`) VALUES(6, 15, 'http://ocproducts.com', 34);
INSERT INTO `ocp_catalogue_efv_short` (`ce_id`, `cf_id`, `cv_value`, `id`) VALUES(7, 15, 'http://www.opensource.org/', 35);

-- --------------------------------------------------------

--
-- Table structure for table `ocp_catalogue_efv_short_trans`
--

DROP TABLE IF EXISTS `ocp_catalogue_efv_short_trans`;
CREATE TABLE IF NOT EXISTS `ocp_catalogue_efv_short_trans` (
  `ce_id` int(11) NOT NULL,
  `cf_id` int(11) NOT NULL,
  `cv_value` int(10) unsigned NOT NULL,
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `stcf_id` (`cf_id`),
  KEY `stce_id` (`ce_id`)
) ENGINE=MyISAM  AUTO_INCREMENT=6 ;

--
-- Dumping data for table `ocp_catalogue_efv_short_trans`
--

INSERT INTO `ocp_catalogue_efv_short_trans` (`ce_id`, `cf_id`, `cv_value`, `id`) VALUES(1, 32, 656, 1);
INSERT INTO `ocp_catalogue_efv_short_trans` (`ce_id`, `cf_id`, `cv_value`, `id`) VALUES(2, 32, 662, 2);
INSERT INTO `ocp_catalogue_efv_short_trans` (`ce_id`, `cf_id`, `cv_value`, `id`) VALUES(5, 14, 674, 3);
INSERT INTO `ocp_catalogue_efv_short_trans` (`ce_id`, `cf_id`, `cv_value`, `id`) VALUES(6, 14, 678, 4);
INSERT INTO `ocp_catalogue_efv_short_trans` (`ce_id`, `cf_id`, `cv_value`, `id`) VALUES(7, 14, 682, 5);

-- --------------------------------------------------------

--
-- Table structure for table `ocp_catalogue_entries`
--

DROP TABLE IF EXISTS `ocp_catalogue_entries`;
CREATE TABLE IF NOT EXISTS `ocp_catalogue_entries` (
  `allow_comments` tinyint(4) NOT NULL,
  `allow_rating` tinyint(1) NOT NULL,
  `allow_trackbacks` tinyint(1) NOT NULL,
  `cc_id` int(11) NOT NULL,
  `ce_add_date` int(10) unsigned NOT NULL,
  `ce_edit_date` int(10) unsigned DEFAULT NULL,
  `ce_last_moved` int(11) NOT NULL,
  `ce_submitter` int(11) NOT NULL,
  `ce_validated` tinyint(1) NOT NULL,
  `ce_views` int(11) NOT NULL,
  `ce_views_prior` int(11) NOT NULL,
  `c_name` varchar(80) NOT NULL,
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `notes` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ce_cc_id` (`cc_id`)
) ENGINE=MyISAM  AUTO_INCREMENT=8 ;

--
-- Dumping data for table `ocp_catalogue_entries`
--

INSERT INTO `ocp_catalogue_entries` (`allow_comments`, `allow_rating`, `allow_trackbacks`, `cc_id`, `ce_add_date`, `ce_edit_date`, `ce_last_moved`, `ce_submitter`, `ce_validated`, `ce_views`, `ce_views_prior`, `c_name`, `id`, `notes`) VALUES(1, 1, 1, 8, 1264679306, 1264679415, 1264679306, 2, 1, 2, 0, 'products', 1, '');
INSERT INTO `ocp_catalogue_entries` (`allow_comments`, `allow_rating`, `allow_trackbacks`, `cc_id`, `ce_add_date`, `ce_edit_date`, `ce_last_moved`, `ce_submitter`, `ce_validated`, `ce_views`, `ce_views_prior`, `c_name`, `id`, `notes`) VALUES(1, 1, 1, 8, 1264680079, NULL, 1264680079, 2, 1, 1, 0, 'products', 2, '');
INSERT INTO `ocp_catalogue_entries` (`allow_comments`, `allow_rating`, `allow_trackbacks`, `cc_id`, `ce_add_date`, `ce_edit_date`, `ce_last_moved`, `ce_submitter`, `ce_validated`, `ce_views`, `ce_views_prior`, `c_name`, `id`, `notes`) VALUES(1, 1, 1, 5, 1264680508, 1264681218, 1264680508, 2, 1, 4, 0, 'contacts', 3, '');
INSERT INTO `ocp_catalogue_entries` (`allow_comments`, `allow_rating`, `allow_trackbacks`, `cc_id`, `ce_add_date`, `ce_edit_date`, `ce_last_moved`, `ce_submitter`, `ce_validated`, `ce_views`, `ce_views_prior`, `c_name`, `id`, `notes`) VALUES(1, 1, 1, 5, 1264681168, NULL, 1264681168, 2, 1, 1, 0, 'contacts', 4, '');
INSERT INTO `ocp_catalogue_entries` (`allow_comments`, `allow_rating`, `allow_trackbacks`, `cc_id`, `ce_add_date`, `ce_edit_date`, `ce_last_moved`, `ce_submitter`, `ce_validated`, `ce_views`, `ce_views_prior`, `c_name`, `id`, `notes`) VALUES(1, 1, 1, 3, 1264681490, 1264681633, 1264681490, 2, 1, 1, 0, 'links', 5, '');
INSERT INTO `ocp_catalogue_entries` (`allow_comments`, `allow_rating`, `allow_trackbacks`, `cc_id`, `ce_add_date`, `ce_edit_date`, `ce_last_moved`, `ce_submitter`, `ce_validated`, `ce_views`, `ce_views_prior`, `c_name`, `id`, `notes`) VALUES(1, 1, 1, 3, 1264681510, 1264681673, 1264681510, 2, 1, 1, 0, 'links', 6, '');
INSERT INTO `ocp_catalogue_entries` (`allow_comments`, `allow_rating`, `allow_trackbacks`, `cc_id`, `ce_add_date`, `ce_edit_date`, `ce_last_moved`, `ce_submitter`, `ce_validated`, `ce_views`, `ce_views_prior`, `c_name`, `id`, `notes`) VALUES(1, 1, 1, 3, 1264681572, 1264681714, 1264681572, 2, 1, 1, 0, 'links', 7, '');

-- --------------------------------------------------------

--
-- Table structure for table `ocp_catalogue_fields`
--

DROP TABLE IF EXISTS `ocp_catalogue_fields`;
CREATE TABLE IF NOT EXISTS `ocp_catalogue_fields` (
  `cf_default` longtext NOT NULL,
  `cf_defines_order` tinyint(1) NOT NULL,
  `cf_description` int(10) unsigned NOT NULL,
  `cf_name` int(10) unsigned NOT NULL,
  `cf_order` tinyint(4) NOT NULL,
  `cf_put_in_category` tinyint(1) NOT NULL,
  `cf_put_in_search` tinyint(1) NOT NULL,
  `cf_required` tinyint(1) NOT NULL,
  `cf_searchable` tinyint(1) NOT NULL,
  `cf_type` varchar(80) NOT NULL,
  `cf_visible` tinyint(1) NOT NULL,
  `c_name` varchar(80) NOT NULL,
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  AUTO_INCREMENT=42 ;

--
-- Dumping data for table `ocp_catalogue_fields`
--

INSERT INTO `ocp_catalogue_fields` (`cf_default`, `cf_defines_order`, `cf_description`, `cf_name`, `cf_order`, `cf_put_in_category`, `cf_put_in_search`, `cf_required`, `cf_searchable`, `cf_type`, `cf_visible`, `c_name`, `id`) VALUES('', 1, 225, 224, 0, 1, 1, 1, 1, 'short_trans', 1, 'links', 14);
INSERT INTO `ocp_catalogue_fields` (`cf_default`, `cf_defines_order`, `cf_description`, `cf_name`, `cf_order`, `cf_put_in_category`, `cf_put_in_search`, `cf_required`, `cf_searchable`, `cf_type`, `cf_visible`, `c_name`, `id`) VALUES('', 0, 227, 226, 1, 0, 1, 1, 1, 'url', 1, 'links', 15);
INSERT INTO `ocp_catalogue_fields` (`cf_default`, `cf_defines_order`, `cf_description`, `cf_name`, `cf_order`, `cf_put_in_category`, `cf_put_in_search`, `cf_required`, `cf_searchable`, `cf_type`, `cf_visible`, `c_name`, `id`) VALUES('', 0, 229, 228, 2, 1, 1, 0, 1, 'long_trans', 1, 'links', 16);
INSERT INTO `ocp_catalogue_fields` (`cf_default`, `cf_defines_order`, `cf_description`, `cf_name`, `cf_order`, `cf_put_in_category`, `cf_put_in_search`, `cf_required`, `cf_searchable`, `cf_type`, `cf_visible`, `c_name`, `id`) VALUES('', 0, 243, 242, 0, 1, 1, 1, 1, 'short_text', 1, 'contacts', 20);
INSERT INTO `ocp_catalogue_fields` (`cf_default`, `cf_defines_order`, `cf_description`, `cf_name`, `cf_order`, `cf_put_in_category`, `cf_put_in_search`, `cf_required`, `cf_searchable`, `cf_type`, `cf_visible`, `c_name`, `id`) VALUES('', 1, 245, 244, 1, 1, 1, 1, 1, 'short_text', 1, 'contacts', 21);
INSERT INTO `ocp_catalogue_fields` (`cf_default`, `cf_defines_order`, `cf_description`, `cf_name`, `cf_order`, `cf_put_in_category`, `cf_put_in_search`, `cf_required`, `cf_searchable`, `cf_type`, `cf_visible`, `c_name`, `id`) VALUES('', 0, 247, 246, 2, 1, 1, 1, 1, 'short_text', 1, 'contacts', 22);
INSERT INTO `ocp_catalogue_fields` (`cf_default`, `cf_defines_order`, `cf_description`, `cf_name`, `cf_order`, `cf_put_in_category`, `cf_put_in_search`, `cf_required`, `cf_searchable`, `cf_type`, `cf_visible`, `c_name`, `id`) VALUES('', 0, 249, 248, 3, 1, 1, 1, 1, 'short_text', 1, 'contacts', 23);
INSERT INTO `ocp_catalogue_fields` (`cf_default`, `cf_defines_order`, `cf_description`, `cf_name`, `cf_order`, `cf_put_in_category`, `cf_put_in_search`, `cf_required`, `cf_searchable`, `cf_type`, `cf_visible`, `c_name`, `id`) VALUES('', 0, 251, 250, 4, 1, 1, 1, 1, 'short_text', 1, 'contacts', 24);
INSERT INTO `ocp_catalogue_fields` (`cf_default`, `cf_defines_order`, `cf_description`, `cf_name`, `cf_order`, `cf_put_in_category`, `cf_put_in_search`, `cf_required`, `cf_searchable`, `cf_type`, `cf_visible`, `c_name`, `id`) VALUES('', 0, 253, 252, 5, 1, 1, 1, 1, 'short_text', 1, 'contacts', 25);
INSERT INTO `ocp_catalogue_fields` (`cf_default`, `cf_defines_order`, `cf_description`, `cf_name`, `cf_order`, `cf_put_in_category`, `cf_put_in_search`, `cf_required`, `cf_searchable`, `cf_type`, `cf_visible`, `c_name`, `id`) VALUES('', 0, 255, 254, 6, 1, 1, 1, 1, 'short_text', 1, 'contacts', 26);
INSERT INTO `ocp_catalogue_fields` (`cf_default`, `cf_defines_order`, `cf_description`, `cf_name`, `cf_order`, `cf_put_in_category`, `cf_put_in_search`, `cf_required`, `cf_searchable`, `cf_type`, `cf_visible`, `c_name`, `id`) VALUES('', 0, 257, 256, 7, 1, 1, 1, 1, 'short_text', 1, 'contacts', 27);
INSERT INTO `ocp_catalogue_fields` (`cf_default`, `cf_defines_order`, `cf_description`, `cf_name`, `cf_order`, `cf_put_in_category`, `cf_put_in_search`, `cf_required`, `cf_searchable`, `cf_type`, `cf_visible`, `c_name`, `id`) VALUES('', 0, 259, 258, 8, 1, 1, 1, 1, 'short_text', 1, 'contacts', 28);
INSERT INTO `ocp_catalogue_fields` (`cf_default`, `cf_defines_order`, `cf_description`, `cf_name`, `cf_order`, `cf_put_in_category`, `cf_put_in_search`, `cf_required`, `cf_searchable`, `cf_type`, `cf_visible`, `c_name`, `id`) VALUES('', 0, 261, 260, 9, 1, 1, 1, 1, 'short_text', 1, 'contacts', 29);
INSERT INTO `ocp_catalogue_fields` (`cf_default`, `cf_defines_order`, `cf_description`, `cf_name`, `cf_order`, `cf_put_in_category`, `cf_put_in_search`, `cf_required`, `cf_searchable`, `cf_type`, `cf_visible`, `c_name`, `id`) VALUES('', 0, 263, 262, 10, 1, 1, 1, 1, 'long_text', 1, 'contacts', 30);
INSERT INTO `ocp_catalogue_fields` (`cf_default`, `cf_defines_order`, `cf_description`, `cf_name`, `cf_order`, `cf_put_in_category`, `cf_put_in_search`, `cf_required`, `cf_searchable`, `cf_type`, `cf_visible`, `c_name`, `id`) VALUES('', 0, 265, 264, 11, 1, 1, 1, 1, 'long_text', 1, 'contacts', 31);
INSERT INTO `ocp_catalogue_fields` (`cf_default`, `cf_defines_order`, `cf_description`, `cf_name`, `cf_order`, `cf_put_in_category`, `cf_put_in_search`, `cf_required`, `cf_searchable`, `cf_type`, `cf_visible`, `c_name`, `id`) VALUES('', 1, 281, 280, 0, 1, 1, 1, 1, 'short_trans', 1, 'products', 32);
INSERT INTO `ocp_catalogue_fields` (`cf_default`, `cf_defines_order`, `cf_description`, `cf_name`, `cf_order`, `cf_put_in_category`, `cf_put_in_search`, `cf_required`, `cf_searchable`, `cf_type`, `cf_visible`, `c_name`, `id`) VALUES('', 0, 283, 282, 1, 1, 1, 1, 1, 'random', 1, 'products', 33);
INSERT INTO `ocp_catalogue_fields` (`cf_default`, `cf_defines_order`, `cf_description`, `cf_name`, `cf_order`, `cf_put_in_category`, `cf_put_in_search`, `cf_required`, `cf_searchable`, `cf_type`, `cf_visible`, `c_name`, `id`) VALUES('', 0, 285, 284, 2, 1, 1, 1, 1, 'float', 1, 'products', 34);
INSERT INTO `ocp_catalogue_fields` (`cf_default`, `cf_defines_order`, `cf_description`, `cf_name`, `cf_order`, `cf_put_in_category`, `cf_put_in_search`, `cf_required`, `cf_searchable`, `cf_type`, `cf_visible`, `c_name`, `id`) VALUES('', 0, 287, 286, 3, 1, 1, 0, 0, 'integer', 1, 'products', 35);
INSERT INTO `ocp_catalogue_fields` (`cf_default`, `cf_defines_order`, `cf_description`, `cf_name`, `cf_order`, `cf_put_in_category`, `cf_put_in_search`, `cf_required`, `cf_searchable`, `cf_type`, `cf_visible`, `c_name`, `id`) VALUES('', 0, 289, 288, 4, 0, 0, 0, 0, 'integer', 0, 'products', 36);
INSERT INTO `ocp_catalogue_fields` (`cf_default`, `cf_defines_order`, `cf_description`, `cf_name`, `cf_order`, `cf_put_in_category`, `cf_put_in_search`, `cf_required`, `cf_searchable`, `cf_type`, `cf_visible`, `c_name`, `id`) VALUES('No|Yes', 0, 291, 290, 5, 0, 0, 1, 0, 'list', 0, 'products', 37);
INSERT INTO `ocp_catalogue_fields` (`cf_default`, `cf_defines_order`, `cf_description`, `cf_name`, `cf_order`, `cf_put_in_category`, `cf_put_in_search`, `cf_required`, `cf_searchable`, `cf_type`, `cf_visible`, `c_name`, `id`) VALUES('10%|20%|30%', 0, 293, 292, 6, 0, 0, 1, 0, 'list', 0, 'products', 38);
INSERT INTO `ocp_catalogue_fields` (`cf_default`, `cf_defines_order`, `cf_description`, `cf_name`, `cf_order`, `cf_put_in_category`, `cf_put_in_search`, `cf_required`, `cf_searchable`, `cf_type`, `cf_visible`, `c_name`, `id`) VALUES('', 0, 295, 294, 7, 1, 1, 0, 1, 'picture', 1, 'products', 39);
INSERT INTO `ocp_catalogue_fields` (`cf_default`, `cf_defines_order`, `cf_description`, `cf_name`, `cf_order`, `cf_put_in_category`, `cf_put_in_search`, `cf_required`, `cf_searchable`, `cf_type`, `cf_visible`, `c_name`, `id`) VALUES('', 0, 297, 296, 8, 0, 0, 1, 0, 'float', 0, 'products', 40);
INSERT INTO `ocp_catalogue_fields` (`cf_default`, `cf_defines_order`, `cf_description`, `cf_name`, `cf_order`, `cf_put_in_category`, `cf_put_in_search`, `cf_required`, `cf_searchable`, `cf_type`, `cf_visible`, `c_name`, `id`) VALUES('', 0, 299, 298, 9, 1, 1, 1, 1, 'long_trans', 1, 'products', 41);

-- --------------------------------------------------------

--
-- Table structure for table `ocp_chargelog`
--

DROP TABLE IF EXISTS `ocp_chargelog`;
CREATE TABLE IF NOT EXISTS `ocp_chargelog` (
  `amount` int(11) NOT NULL,
  `date_and_time` int(10) unsigned NOT NULL,
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `reason` int(10) unsigned NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  AUTO_INCREMENT=2 ;

--
-- Dumping data for table `ocp_chargelog`
--

INSERT INTO `ocp_chargelog` (`amount`, `date_and_time`, `id`, `reason`, `user_id`) VALUES(6, 1264685916, 1, 785, 2);

-- --------------------------------------------------------

--
-- Table structure for table `ocp_chat_active`
--

DROP TABLE IF EXISTS `ocp_chat_active`;
CREATE TABLE IF NOT EXISTS `ocp_chat_active` (
  `date_and_time` int(10) unsigned NOT NULL,
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `member_id` int(11) NOT NULL,
  `room_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `active_ordering` (`date_and_time`),
  KEY `member_select` (`member_id`),
  KEY `room_select` (`room_id`)
) ENGINE=MyISAM  AUTO_INCREMENT=13 ;

--
-- Dumping data for table `ocp_chat_active`
--

INSERT INTO `ocp_chat_active` (`date_and_time`, `id`, `member_id`, `room_id`) VALUES(1264686116, 12, 2, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `ocp_chat_blocking`
--

DROP TABLE IF EXISTS `ocp_chat_blocking`;
CREATE TABLE IF NOT EXISTS `ocp_chat_blocking` (
  `date_and_time` int(10) unsigned NOT NULL,
  `member_blocked` int(11) NOT NULL,
  `member_blocker` int(11) NOT NULL,
  PRIMARY KEY (`member_blocked`,`member_blocker`)
) ENGINE=MyISAM;

--
-- Dumping data for table `ocp_chat_blocking`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_chat_buddies`
--

DROP TABLE IF EXISTS `ocp_chat_buddies`;
CREATE TABLE IF NOT EXISTS `ocp_chat_buddies` (
  `date_and_time` int(10) unsigned NOT NULL,
  `member_liked` int(11) NOT NULL,
  `member_likes` int(11) NOT NULL,
  PRIMARY KEY (`member_liked`,`member_likes`)
) ENGINE=MyISAM;

--
-- Dumping data for table `ocp_chat_buddies`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_chat_events`
--

DROP TABLE IF EXISTS `ocp_chat_events`;
CREATE TABLE IF NOT EXISTS `ocp_chat_events` (
  `e_date_and_time` int(10) unsigned NOT NULL,
  `e_member_id` int(11) NOT NULL,
  `e_room_id` int(11) DEFAULT NULL,
  `e_type_code` varchar(80) NOT NULL,
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `event_ordering` (`e_date_and_time`)
) ENGINE=MyISAM  AUTO_INCREMENT=2 ;

--
-- Dumping data for table `ocp_chat_events`
--

INSERT INTO `ocp_chat_events` (`e_date_and_time`, `e_member_id`, `e_room_id`, `e_type_code`, `id`) VALUES(1264686000, 2, NULL, 'BECOME_ACTIVE', 1);

-- --------------------------------------------------------

--
-- Table structure for table `ocp_chat_messages`
--

DROP TABLE IF EXISTS `ocp_chat_messages`;
CREATE TABLE IF NOT EXISTS `ocp_chat_messages` (
  `date_and_time` int(10) unsigned NOT NULL,
  `font_name` varchar(255) NOT NULL,
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ip_address` varchar(40) NOT NULL,
  `room_id` int(11) NOT NULL,
  `system_message` tinyint(1) NOT NULL,
  `text_colour` varchar(255) NOT NULL,
  `the_message` int(10) unsigned NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Ordering` (`date_and_time`)
) ENGINE=MyISAM AUTO_INCREMENT=1 ;

--
-- Dumping data for table `ocp_chat_messages`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_chat_rooms`
--

DROP TABLE IF EXISTS `ocp_chat_rooms`;
CREATE TABLE IF NOT EXISTS `ocp_chat_rooms` (
  `allow_list` longtext NOT NULL,
  `allow_list_groups` longtext NOT NULL,
  `c_welcome` int(10) unsigned NOT NULL,
  `disallow_list` longtext NOT NULL,
  `disallow_list_groups` longtext NOT NULL,
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `is_im` tinyint(1) NOT NULL,
  `room_language` varchar(5) NOT NULL,
  `room_name` varchar(255) NOT NULL,
  `room_owner` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  AUTO_INCREMENT=2 ;

--
-- Dumping data for table `ocp_chat_rooms`
--

INSERT INTO `ocp_chat_rooms` (`allow_list`, `allow_list_groups`, `c_welcome`, `disallow_list`, `disallow_list_groups`, `id`, `is_im`, `room_language`, `room_name`, `room_owner`) VALUES('', '', 312, '', '', 1, 0, 'EN', 'General chat', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `ocp_chat_sound_effects`
--

DROP TABLE IF EXISTS `ocp_chat_sound_effects`;
CREATE TABLE IF NOT EXISTS `ocp_chat_sound_effects` (
  `s_effect_id` varchar(80) NOT NULL,
  `s_member` int(11) NOT NULL,
  `s_url` varchar(255) NOT NULL,
  PRIMARY KEY (`s_effect_id`,`s_member`)
) ENGINE=MyISAM;

--
-- Dumping data for table `ocp_chat_sound_effects`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_comcode_pages`
--

DROP TABLE IF EXISTS `ocp_comcode_pages`;
CREATE TABLE IF NOT EXISTS `ocp_comcode_pages` (
  `p_add_date` int(10) unsigned NOT NULL,
  `p_edit_date` int(10) unsigned DEFAULT NULL,
  `p_parent_page` varchar(80) NOT NULL,
  `p_show_as_edit` tinyint(1) NOT NULL,
  `p_submitter` int(11) NOT NULL,
  `p_validated` tinyint(1) NOT NULL,
  `the_page` varchar(80) NOT NULL,
  `the_zone` varchar(80) NOT NULL,
  PRIMARY KEY (`the_page`,`the_zone`)
) ENGINE=MyISAM;

--
-- Dumping data for table `ocp_comcode_pages`
--

INSERT INTO `ocp_comcode_pages` (`p_add_date`, `p_edit_date`, `p_parent_page`, `p_show_as_edit`, `p_submitter`, `p_validated`, `the_page`, `the_zone`) VALUES(1264606251, NULL, '', 0, 2, 1, 'panel_top', '');
INSERT INTO `ocp_comcode_pages` (`p_add_date`, `p_edit_date`, `p_parent_page`, `p_show_as_edit`, `p_submitter`, `p_validated`, `the_page`, `the_zone`) VALUES(1264606251, 1264607445, '', 0, 2, 1, 'panel_left', '');
INSERT INTO `ocp_comcode_pages` (`p_add_date`, `p_edit_date`, `p_parent_page`, `p_show_as_edit`, `p_submitter`, `p_validated`, `the_page`, `the_zone`) VALUES(1264606251, 1265397664, '', 0, 2, 1, 'start', '');
INSERT INTO `ocp_comcode_pages` (`p_add_date`, `p_edit_date`, `p_parent_page`, `p_show_as_edit`, `p_submitter`, `p_validated`, `the_page`, `the_zone`) VALUES(1264606209, NULL, '', 0, 2, 1, 'start', 'adminzone');
INSERT INTO `ocp_comcode_pages` (`p_add_date`, `p_edit_date`, `p_parent_page`, `p_show_as_edit`, `p_submitter`, `p_validated`, `the_page`, `the_zone`) VALUES(1264606209, NULL, '', 0, 2, 1, 'panel_top', 'adminzone');
INSERT INTO `ocp_comcode_pages` (`p_add_date`, `p_edit_date`, `p_parent_page`, `p_show_as_edit`, `p_submitter`, `p_validated`, `the_page`, `the_zone`) VALUES(1264607445, NULL, '', 0, 2, 1, 'panel_right', '');
INSERT INTO `ocp_comcode_pages` (`p_add_date`, `p_edit_date`, `p_parent_page`, `p_show_as_edit`, `p_submitter`, `p_validated`, `the_page`, `the_zone`) VALUES(1264606215, NULL, '', 0, 2, 1, 'panel_top', 'cms');
INSERT INTO `ocp_comcode_pages` (`p_add_date`, `p_edit_date`, `p_parent_page`, `p_show_as_edit`, `p_submitter`, `p_validated`, `the_page`, `the_zone`) VALUES(1264606256, NULL, '', 0, 2, 1, 'help', 'site');
INSERT INTO `ocp_comcode_pages` (`p_add_date`, `p_edit_date`, `p_parent_page`, `p_show_as_edit`, `p_submitter`, `p_validated`, `the_page`, `the_zone`) VALUES(1264607445, NULL, '', 0, 2, 1, 'rules', '');
INSERT INTO `ocp_comcode_pages` (`p_add_date`, `p_edit_date`, `p_parent_page`, `p_show_as_edit`, `p_submitter`, `p_validated`, `the_page`, `the_zone`) VALUES(1264606256, NULL, '', 0, 2, 1, 'guestbook', 'site');
INSERT INTO `ocp_comcode_pages` (`p_add_date`, `p_edit_date`, `p_parent_page`, `p_show_as_edit`, `p_submitter`, `p_validated`, `the_page`, `the_zone`) VALUES(1264606251, NULL, '', 0, 2, 1, '404', '');
INSERT INTO `ocp_comcode_pages` (`p_add_date`, `p_edit_date`, `p_parent_page`, `p_show_as_edit`, `p_submitter`, `p_validated`, `the_page`, `the_zone`) VALUES(1264606256, NULL, '', 0, 2, 1, 'donate', 'site');
INSERT INTO `ocp_comcode_pages` (`p_add_date`, `p_edit_date`, `p_parent_page`, `p_show_as_edit`, `p_submitter`, `p_validated`, `the_page`, `the_zone`) VALUES(1264608734, 1264670326, '', 0, 2, 1, 'banner', 'site');
INSERT INTO `ocp_comcode_pages` (`p_add_date`, `p_edit_date`, `p_parent_page`, `p_show_as_edit`, `p_submitter`, `p_validated`, `the_page`, `the_zone`) VALUES(1264606251, NULL, '', 0, 2, 1, 'sitemap', '');
INSERT INTO `ocp_comcode_pages` (`p_add_date`, `p_edit_date`, `p_parent_page`, `p_show_as_edit`, `p_submitter`, `p_validated`, `the_page`, `the_zone`) VALUES(1264606209, NULL, '', 0, 2, 1, 'quotes', 'adminzone');
INSERT INTO `ocp_comcode_pages` (`p_add_date`, `p_edit_date`, `p_parent_page`, `p_show_as_edit`, `p_submitter`, `p_validated`, `the_page`, `the_zone`) VALUES(1264671563, 1265477476, '', 0, 2, 1, 'featured_content', 'site');
INSERT INTO `ocp_comcode_pages` (`p_add_date`, `p_edit_date`, `p_parent_page`, `p_show_as_edit`, `p_submitter`, `p_validated`, `the_page`, `the_zone`) VALUES(1264685778, NULL, '', 0, 2, 1, 'comcode_page', 'site');
INSERT INTO `ocp_comcode_pages` (`p_add_date`, `p_edit_date`, `p_parent_page`, `p_show_as_edit`, `p_submitter`, `p_validated`, `the_page`, `the_zone`) VALUES(1264685832, 1264685833, 'comcode_page', 0, 2, 1, 'comcode_page_child', 'site');
INSERT INTO `ocp_comcode_pages` (`p_add_date`, `p_edit_date`, `p_parent_page`, `p_show_as_edit`, `p_submitter`, `p_validated`, `the_page`, `the_zone`) VALUES(1264606253, NULL, '', 0, 2, 1, 'panel_left', 'personalzone');
INSERT INTO `ocp_comcode_pages` (`p_add_date`, `p_edit_date`, `p_parent_page`, `p_show_as_edit`, `p_submitter`, `p_validated`, `the_page`, `the_zone`) VALUES(1264687209, 1265480673, '', 0, 2, 1, 'rich', '');
INSERT INTO `ocp_comcode_pages` (`p_add_date`, `p_edit_date`, `p_parent_page`, `p_show_as_edit`, `p_submitter`, `p_validated`, `the_page`, `the_zone`) VALUES(1264606256, NULL, '', 0, 2, 1, 'panel_left', 'site');
INSERT INTO `ocp_comcode_pages` (`p_add_date`, `p_edit_date`, `p_parent_page`, `p_show_as_edit`, `p_submitter`, `p_validated`, `the_page`, `the_zone`) VALUES(1264606256, NULL, '', 0, 2, 1, 'panel_right', 'site');
INSERT INTO `ocp_comcode_pages` (`p_add_date`, `p_edit_date`, `p_parent_page`, `p_show_as_edit`, `p_submitter`, `p_validated`, `the_page`, `the_zone`) VALUES(1264606256, NULL, '', 0, 2, 1, 'start', 'site');
INSERT INTO `ocp_comcode_pages` (`p_add_date`, `p_edit_date`, `p_parent_page`, `p_show_as_edit`, `p_submitter`, `p_validated`, `the_page`, `the_zone`) VALUES(1265479394, 1265480314, '', 0, 2, 1, 'menus', '');

-- --------------------------------------------------------

--
-- Table structure for table `ocp_config`
--

DROP TABLE IF EXISTS `ocp_config`;
CREATE TABLE IF NOT EXISTS `ocp_config` (
  `config_value` longtext NOT NULL,
  `c_data` varchar(255) NOT NULL,
  `c_set` tinyint(1) NOT NULL,
  `eval` varchar(255) NOT NULL,
  `explanation` varchar(80) NOT NULL,
  `human_name` varchar(80) NOT NULL,
  `section` varchar(80) NOT NULL,
  `shared_hosting_restricted` tinyint(1) NOT NULL,
  `the_name` varchar(80) NOT NULL,
  `the_page` varchar(80) NOT NULL,
  `the_type` varchar(80) NOT NULL,
  PRIMARY KEY (`the_name`)
) ENGINE=MyISAM;

--
-- Dumping data for table `ocp_config`
--

INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'require_code(''encryption'');return is_encryption_available()?'''':NULL;', 'CONFIG_OPTION_encryption_key', 'ENCRYPTION_KEY', 'ADVANCED', 0, 'encryption_key', 'PRIVACY', 'line');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'require_code(''encryption'');return is_encryption_available()?'''':NULL;', 'CONFIG_OPTION_decryption_key', 'DECRYPTION_KEY', 'ADVANCED', 0, 'decryption_key', 'PRIVACY', 'line');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('0', '', 1, 'return is_null($old=get_value(''no_post_titles''))?''0'':invert_value($old);', 'CONFIG_OPTION_is_on_post_titles', 'IS_ON_POST_TITLES', 'GENERAL', 0, 'is_on_post_titles', 'SECTION_FORUMS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('0', '', 1, 'return is_null($old=get_value(''ocf_no_anonymous_post''))?''0'':invert_value($old);', 'CONFIG_OPTION_is_on_anonymous_posts', 'IS_ON_ANONYMOUS_POSTS', 'GENERAL', 0, 'is_on_anonymous_posts', 'SECTION_FORUMS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('1', '', 1, 'return is_null($old=get_value(''no_js_timezone_detect''))?''1'':invert_value($old);', 'CONFIG_OPTION_is_on_timezone_detection', 'IS_ON_TIMEZONE_DETECTION', 'GENERAL', 0, 'is_on_timezone_detection', 'SECTION_FORUMS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('1', '', 1, 'return is_null($old=get_value(''no_topic_descriptions''))?''1'':invert_value($old);', 'CONFIG_OPTION_is_on_topic_descriptions', 'IS_ON_TOPIC_DESCRIPTIONS', 'GENERAL', 0, 'is_on_topic_descriptions', 'SECTION_FORUMS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('1', '', 1, 'return is_null($old=get_value(''ocf_no_topic_emoticons''))?''1'':invert_value($old);', 'CONFIG_OPTION_is_on_topic_emoticons', 'IS_ON_TOPIC_EMOTICONS', 'GENERAL', 0, 'is_on_topic_emoticons', 'SECTION_FORUMS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('0', '', 1, 'return is_null($old=get_value(''no_default_preview_guests''))?''0'':invert_value($old);', 'CONFIG_OPTION_default_preview_guests', 'DEFAULT_PREVIEW_GUESTS', 'GENERAL', 0, 'default_preview_guests', 'SECTION_FORUMS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('0', '', 1, 'return is_null($old=get_value(''no_forced_preview_option''))?''0'':invert_value($old);', 'CONFIG_OPTION_forced_preview_option', 'FORCED_PREVIEW_OPTION', 'GENERAL', 0, 'forced_preview_option', 'SECTION_FORUMS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('1', '', 1, 'return is_null($old=get_value(''disable_overt_whispering''))?''1'':invert_value($old);', 'CONFIG_OPTION_overt_whisper_suggestion', 'OVERT_WHISPER_SUGGESTION', 'GENERAL', 0, 'overt_whisper_suggestion', 'SECTION_FORUMS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('0', '', 1, 'return is_null($old=get_value(''no_invisible_option''))?''0'':invert_value($old);', 'CONFIG_OPTION_is_on_invisibility', 'IS_ON_INVISIBILITY', 'GENERAL', 0, 'is_on_invisibility', 'SECTION_FORUMS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('0', '', 1, 'return is_null($old=get_value(''allow_alpha_search''))?''0'':$old;', 'CONFIG_OPTION_allow_alpha_search', 'ALLOW_ALPHA_SEARCH', 'GENERAL', 0, 'allow_alpha_search', 'SECTION_FORUMS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('1', '', 1, 'return is_null($old=get_value(''disable_allow_emails_field''))?''1'':invert_value($old);', 'CONFIG_OPTION_allow_email_disable', 'ALLOW_EMAIL_DISABLE', 'GENERAL', 0, 'allow_email_disable', 'SECTION_FORUMS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('20', '', 1, 'return ''20'';', 'CONFIG_OPTION_max_member_title_length', 'MAX_MEMBER_TITLE_LENGTH', 'GENERAL', 0, 'max_member_title_length', 'SECTION_FORUMS', 'integer');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('0', '', 1, 'return ''0'';', 'CONFIG_OPTION_httpauth_is_enabled', 'HTTPAUTH_IS_ENABLED', 'ADVANCED', 1, 'httpauth_is_enabled', 'SECTION_FORUMS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('21', '', 1, 'return ''21'';', 'CONFIG_OPTION_post_history_days', 'POST_HISTORY_DAYS', 'GENERAL', 1, 'post_history_days', 'SECTION_FORUMS', 'integer');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('20', '', 1, 'return has_no_forum()?NULL:''20'';', 'CONFIG_OPTION_forum_posts_per_page', 'FORUM_POSTS_PER_PAGE', 'GENERAL', 0, 'forum_posts_per_page', 'SECTION_FORUMS', 'integer');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('30', '', 1, 'return has_no_forum()?NULL:''30'';', 'CONFIG_OPTION_forum_topics_per_page', 'FORUM_TOPICS_PER_PAGE', 'GENERAL', 0, 'forum_topics_per_page', 'SECTION_FORUMS', 'integer');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('1', '', 1, 'return has_no_forum()?NULL:''1'';', 'CONFIG_OPTION_prevent_shouting', 'PREVENT_SHOUTING', 'GENERAL', 0, 'prevent_shouting', 'SECTION_FORUMS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('Guest, Staff, Administrator, Moderator, googlebot', '', 1, 'return do_lang(''GUEST'').'', ''.do_lang(''STAFF'').'', ''.do_lang(''ADMIN'').'', ''.do_lang(''MODERATOR'').'', googlebot'';', 'CONFIG_OPTION_restricted_usernames', 'RESTRICTED_USERNAMES', 'GENERAL', 0, 'restricted_usernames', 'SECTION_FORUMS', 'line');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('0', '', 1, 'return ''0'';', 'CONFIG_OPTION_require_new_member_validation', 'REQUIRE_NEW_MEMBER_VALIDATION', 'USERNAMES_AND_PASSWORDS', 0, 'require_new_member_validation', 'SECTION_FORUMS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('Reported posts forum', '', 1, 'return has_no_forum()?NULL:do_lang(''REPORTED_POSTS_FORUM'');', 'CONFIG_OPTION_reported_posts_forum', 'REPORTED_POSTS_FORUM', 'GENERAL', 0, 'reported_posts_forum', 'SECTION_FORUMS', 'forum');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('1', '', 1, 'return ''1'';', 'CONFIG_OPTION_one_per_email_address', 'ONE_PER_EMAIL_ADDRESS', 'GENERAL', 0, 'one_per_email_address', 'SECTION_FORUMS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('20', '', 1, 'return has_no_forum()?NULL:''20'';', 'CONFIG_OPTION_hot_topic_definition', 'HOT_TOPIC_DEFINITION', 'GENERAL', 0, 'hot_topic_definition', 'SECTION_FORUMS', 'integer');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('1', '', 1, 'return ''1'';', 'CONFIG_OPTION_send_staff_message_post_validation', 'SEND_STAFF_MESSAGE_POST_VALIDATION', 'GENERAL', 0, 'send_staff_message_post_validation', 'SECTION_FORUMS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('4', '', 1, 'return ''4'';', 'CONFIG_OPTION_minimum_password_length', 'MINIMUM_PASSWORD_LENGTH', 'USERNAMES_AND_PASSWORDS', 0, 'minimum_password_length', 'SECTION_FORUMS', 'integer');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('20', '', 1, 'return ''20'';', 'CONFIG_OPTION_maximum_password_length', 'MAXIMUM_PASSWORD_LENGTH', 'USERNAMES_AND_PASSWORDS', 0, 'maximum_password_length', 'SECTION_FORUMS', 'integer');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('1', '', 1, 'return ''1'';', 'CONFIG_OPTION_minimum_username_length', 'MINIMUM_USERNAME_LENGTH', 'USERNAMES_AND_PASSWORDS', 0, 'minimum_username_length', 'SECTION_FORUMS', 'integer');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('20', '', 1, 'return ''20'';', 'CONFIG_OPTION_maximum_username_length', 'MAXIMUM_USERNAME_LENGTH', 'USERNAMES_AND_PASSWORDS', 0, 'maximum_username_length', 'SECTION_FORUMS', 'integer');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('1', '', 1, 'return ''1'';', 'CONFIG_OPTION_prohibit_password_whitespace', 'PROHIBIT_PASSWORD_WHITESPACE', 'USERNAMES_AND_PASSWORDS', 0, 'prohibit_password_whitespace', 'SECTION_FORUMS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('0', '', 1, 'return ''0'';', 'CONFIG_OPTION_prohibit_username_whitespace', 'PROHIBIT_USERNAME_WHITESPACE', 'USERNAMES_AND_PASSWORDS', 0, 'prohibit_username_whitespace', 'SECTION_FORUMS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('1', '', 1, 'return ''1'';', 'CONFIG_OPTION_random_avatars', 'ASSIGN_RANDOM_AVATARS', 'GENERAL', 0, 'random_avatars', 'SECTION_FORUMS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('Forum home', '', 1, 'return has_no_forum()?NULL:strval(db_get_first_id());', 'CONFIG_OPTION_club_forum_parent_forum', 'CLUB_FORUM_PARENT_FORUM', 'GENERAL', 0, 'club_forum_parent_forum', 'SECTION_FORUMS', 'forum');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('General', '', 1, 'return has_no_forum()?NULL:strval(db_get_first_id());', 'CONFIG_OPTION_club_forum_parent_category', 'CLUB_FORUM_PARENT_CATEGORY', 'GENERAL', 0, 'club_forum_parent_category', 'SECTION_FORUMS', 'category');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('0', '', 1, 'return has_no_forum()?NULL:''0'';', 'CONFIG_OPTION_delete_trashed_pts', 'DELETE_TRASHED_PTS', 'GENERAL', 0, 'delete_trashed_pts', 'SECTION_FORUMS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('Probation', '', 1, 'return do_lang(''PROBATION'');', 'CONFIG_OPTION_probation_usergroup', 'PROBATION_USERGROUP', 'USERNAMES_AND_PASSWORDS', 0, 'probation_usergroup', 'SECTION_FORUMS', 'usergroup');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('1', '', 1, 'return ''1'';', 'CONFIG_OPTION_show_first_join_page', 'SHOW_FIRST_JOIN_PAGE', 'USERNAMES_AND_PASSWORDS', 0, 'show_first_join_page', 'SECTION_FORUMS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('1', '', 1, 'return ''1'';', 'CONFIG_OPTION_skip_email_confirm_join', 'SKIP_EMAIL_CONFIRM_JOIN', 'USERNAMES_AND_PASSWORDS', 0, 'skip_email_confirm_join', 'SECTION_FORUMS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('0', '', 1, 'return ''0'';', 'CONFIG_OPTION_no_dob_ask', 'NO_DOB_ASK', 'USERNAMES_AND_PASSWORDS', 0, 'no_dob_ask', 'SECTION_FORUMS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('1', '', 1, 'return ''1'';', 'CONFIG_OPTION_allow_international', 'ALLOW_INTERNATIONAL', 'USERNAMES_AND_PASSWORDS', 0, 'allow_international', 'SECTION_FORUMS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''0'';', 'CONFIG_OPTION_is_on_coppa', 'COPPA_ENABLED', 'GENERAL', 0, 'is_on_coppa', 'PRIVACY', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return '''';', 'CONFIG_OPTION_privacy_fax', 'FAX_NUMBER', 'GENERAL', 0, 'privacy_fax', 'PRIVACY', 'line');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return '''';', 'CONFIG_OPTION_privacy_postal_address', 'ADDRESS', 'GENERAL', 0, 'privacy_postal_address', 'PRIVACY', 'text');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('0', '', 1, 'return ''0'';', 'CONFIG_OPTION_is_on_invites', 'INVITES_ENABLED', 'GENERAL', 0, 'is_on_invites', 'SECTION_FORUMS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('1', '', 1, 'return ''1'';', 'CONFIG_OPTION_invites_per_day', 'INVITES_PER_DAY', 'GENERAL', 0, 'invites_per_day', 'SECTION_FORUMS', 'float');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''paypal'';', 'CONFIG_OPTION_payment_gateway', 'PAYMENT_GATEWAY', 'ECOMMERCE', 0, 'payment_gateway', 'ECOMMERCE', 'line');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return 0; /*function_exists(''apache_get_modules'')?''1'':''0'';*/', 'CONFIG_OPTION_mod_rewrite', 'MOD_REWRITE', 'ADVANCED', 0, 'mod_rewrite', 'SITE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''5'';', 'CONFIG_OPTION_session_expiry_time', 'SESSION_EXPIRY_TIME', 'GENERAL', 0, 'session_expiry_time', 'SECURITY', 'integer');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''1'';', 'CONFIG_OPTION_url_monikers_enabled', 'URL_MONIKERS_ENABLED', 'ADVANCED', 0, 'url_monikers_enabled', 'SITE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return $GLOBALS[''SEMI_DEBUG_MODE'']?''0'':''1'';', 'CONFIG_OPTION_is_on_block_cache', 'BLOCK_CACHE', 'CACHES', 1, 'is_on_block_cache', 'SITE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''1'';', 'CONFIG_OPTION_is_on_template_cache', 'TEMPLATE_CACHE', 'CACHES', 1, 'is_on_template_cache', 'SITE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''1'';', 'CONFIG_OPTION_is_on_comcode_page_cache', 'COMCODE_PAGE_CACHE', 'CACHES', 1, 'is_on_comcode_page_cache', 'SITE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''1'';', 'CONFIG_OPTION_is_on_lang_cache', 'LANGUAGE_CACHE', 'CACHES', 1, 'is_on_lang_cache', 'SITE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('1', '', 1, 'return ''1'';', 'CONFIG_OPTION_is_on_trackbacks', 'TRACKBACKS', 'USER_INTERACTION', 0, 'is_on_trackbacks', 'FEATURE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return (DIRECTORY_SEPARATOR==''/'')?''/tmp/'':ocp_srv(''TMP'');', 'CONFIG_OPTION_unzip_dir', 'UNZIP_DIR', 'ARCHIVES', 1, 'unzip_dir', 'SITE', 'line');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''/usr/bin/unzip -o @_SRC_@ -x -d @_DST_@'';', 'CONFIG_OPTION_unzip_cmd', 'UNZIP_CMD', 'ARCHIVES', 1, 'unzip_cmd', 'SITE', 'line');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''0'';', 'CONFIG_OPTION_smtp_sockets_use', 'ENABLED', 'SMTP', 1, 'smtp_sockets_use', 'SITE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''mail.yourispwhateveritis.net'';', 'CONFIG_OPTION_smtp_sockets_host', 'HOST', 'SMTP', 1, 'smtp_sockets_host', 'SITE', 'line');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''25'';', 'CONFIG_OPTION_smtp_sockets_port', 'PORT', 'SMTP', 1, 'smtp_sockets_port', 'SITE', 'line');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return '''';', 'CONFIG_OPTION_smtp_sockets_username', 'USERNAME', 'SMTP', 1, 'smtp_sockets_username', 'SITE', 'line');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return '''';', 'CONFIG_OPTION_smtp_sockets_password', 'PASSWORD', 'SMTP', 1, 'smtp_sockets_password', 'SITE', 'line');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return '''';', 'CONFIG_OPTION_smtp_from_address', 'EMAIL_ADDRESS', 'SMTP', 1, 'smtp_from_address', 'SITE', 'line');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''1'';', 'CONFIG_OPTION_use_security_images', 'USE_SECURITY_IMAGES', 'GENERAL', 0, 'use_security_images', 'SECURITY', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''0'';', 'CONFIG_OPTION_enable_https', 'HTTPS_SUPPORT', 'GENERAL', 1, 'enable_https', 'SECURITY', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''0'';', 'CONFIG_OPTION_send_error_emails', 'SEND_ERROR_EMAILS', 'ADVANCED', 0, 'send_error_emails', 'SITE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return 1;', 'CONFIG_OPTION_send_error_emails_ocproducts', 'SEND_ERROR_EMAILS_OCPRODUCTS', 'ADVANCED', 1, 'send_error_emails_ocproducts', 'SITE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return (get_forum_type()==''ocf'')?NULL:''1'';', 'CONFIG_OPTION_detect_lang_forum', 'DETECT_LANG_FORUM', 'ADVANCED', 0, 'detect_lang_forum', 'SITE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''0'';', 'CONFIG_OPTION_detect_lang_browser', 'DETECT_LANG_BROWSER', 'ADVANCED', 0, 'detect_lang_browser', 'SITE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''20'';', 'CONFIG_OPTION_low_space_check', 'LOW_DISK_SPACE_SUBJECT', 'GENERAL', 0, 'low_space_check', 'SITE', 'integer');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''1'';', 'CONFIG_OPTION_allow_audio_videos', 'ALLOW_AUDIO_VIDEOS', 'ADVANCED', 0, 'allow_audio_videos', 'SITE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''0'';', 'CONFIG_OPTION_validation', 'VALIDATION', 'VALIDATION', 1, 'validation', 'SITE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''1'';', 'CONFIG_OPTION_validation_xhtml', 'VALIDATION_XHTML', 'VALIDATION', 1, 'validation_xhtml', 'SITE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''1'';', 'CONFIG_OPTION_validation_wcag', 'VALIDATION_WCAG', 'VALIDATION', 1, 'validation_wcag', 'SITE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''0'';', 'CONFIG_OPTION_validation_css', 'VALIDATION_CSS', 'VALIDATION', 1, 'validation_css', 'SITE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''0'';', 'CONFIG_OPTION_validation_javascript', 'VALIDATION_JAVASCRIPT', 'VALIDATION', 1, 'validation_javascript', 'SITE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''0'';', 'CONFIG_OPTION_validation_compat', 'VALIDATION_COMPAT', 'VALIDATION', 1, 'validation_compat', 'SITE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''0'';', 'CONFIG_OPTION_validation_ext_files', 'VALIDATION_EXT_FILES', 'VALIDATION', 1, 'validation_ext_files', 'SITE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''20000'';', 'CONFIG_OPTION_max_download_size', 'MAX_SIZE', 'UPLOAD', 0, 'max_download_size', 'SITE', 'integer');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return '''';', 'CONFIG_OPTION_allowed_post_submitters', 'ALLOWED_POST_SUBMITTERS', 'ADVANCED', 1, 'allowed_post_submitters', 'SECURITY', 'text');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('0', '', 1, 'return ''0'';', 'CONFIG_OPTION_is_on_strong_forum_tie', 'STRONG_FORUM_TIE', 'USER_INTERACTION', 1, 'is_on_strong_forum_tie', 'FEATURE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''1'';', 'CONFIG_OPTION_is_on_preview_validation', 'VALIDATION_ON_PREVIEW', 'VALIDATION', 1, 'is_on_preview_validation', 'SITE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''1'';', 'CONFIG_OPTION_show_inline_stats', 'SHOW_INLINE_STATS', 'GENERAL', 0, 'show_inline_stats', 'SITE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''0'';', 'CONFIG_OPTION_simplified_donext', 'SIMPLIFIED_DONEXT', 'ADVANCED', 0, 'simplified_donext', 'SITE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''0'';', 'CONFIG_OPTION_anti_leech', 'ANTI_LEECH', 'GENERAL', 0, 'anti_leech', 'SECURITY', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''0'';', 'CONFIG_OPTION_ssw', 'SSW', 'GENERAL', 0, 'ssw', 'SITE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('1', '', 1, 'return ''1'';', 'CONFIG_OPTION_bottom_show_admin_menu', 'ADMIN_MENU', 'BOTTOM_LINKS', 0, 'bottom_show_admin_menu', 'FEATURE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('1', '', 1, 'return ''1'';', 'CONFIG_OPTION_bottom_show_top_button', 'TOP_LINK', 'BOTTOM_LINKS', 0, 'bottom_show_top_button', 'FEATURE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('1', '', 1, 'return ''1'';', 'CONFIG_OPTION_bottom_show_feedback_link', 'FEEDBACK_LINK', 'BOTTOM_LINKS', 0, 'bottom_show_feedback_link', 'FEATURE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('1', '', 1, 'return ''1'';', 'CONFIG_OPTION_bottom_show_privacy_link', 'PRIVACY_LINK', 'BOTTOM_LINKS', 0, 'bottom_show_privacy_link', 'FEATURE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('1', '', 1, 'return ''1'';', 'CONFIG_OPTION_bottom_show_sitemap_button', 'SITEMAP_LINK', 'BOTTOM_LINKS', 0, 'bottom_show_sitemap_button', 'FEATURE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return has_no_forum()?NULL:''0'';', 'CONFIG_OPTION_forum_show_personal_stats_posts', 'COUNT_POSTSCOUNT', 'PERSONAL_BLOCK', 0, 'forum_show_personal_stats_posts', 'BLOCKS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ((has_no_forum()) || (get_forum_type()!=''ocf''))?NULL:''0'';', 'CONFIG_OPTION_forum_show_personal_stats_topics', 'COUNT_TOPICSCOUNT', 'PERSONAL_BLOCK', 0, 'forum_show_personal_stats_topics', 'BLOCKS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ((has_no_forum()) || (get_forum_type()!=''ocf''))?NULL:''1'';', 'CONFIG_OPTION_ocf_show_personal_myhome_link', 'MY_HOME_LINK', 'PERSONAL_BLOCK', 0, 'ocf_show_personal_myhome_link', 'BLOCKS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''1'';', 'CONFIG_OPTION_ocp_show_personal_adminzone_link', 'ADMIN_ZONE_LINK', 'PERSONAL_BLOCK', 0, 'ocp_show_personal_adminzone_link', 'BLOCKS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''0'';', 'CONFIG_OPTION_ocp_show_conceded_mode_link', 'CONCEDED_MODE_LINK', 'PERSONAL_BLOCK', 0, 'ocp_show_conceded_mode_link', 'BLOCKS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return has_no_forum()?NULL:''1'';', 'CONFIG_OPTION_ocp_show_su', 'SU', 'PERSONAL_BLOCK', 0, 'ocp_show_su', 'BLOCKS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''1'';', 'CONFIG_OPTION_ocp_show_staff_page_actions', 'PAGE_ACTIONS', 'PERSONAL_BLOCK', 0, 'ocp_show_staff_page_actions', 'BLOCKS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return has_no_forum()?NULL:''1'';', 'CONFIG_OPTION_ocf_show_profile_link', 'MY_PROFILE_LINK', 'PERSONAL_BLOCK', 0, 'ocf_show_profile_link', 'BLOCKS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return has_no_forum()?NULL:''0'';', 'CONFIG_OPTION_ocp_show_personal_usergroup', '_USERGROUP', 'PERSONAL_BLOCK', 0, 'ocp_show_personal_usergroup', 'BLOCKS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return has_no_forum()?NULL:''0'';', 'CONFIG_OPTION_ocp_show_personal_last_visit', 'LAST_HERE', 'PERSONAL_BLOCK', 0, 'ocp_show_personal_last_visit', 'BLOCKS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return has_no_forum()?NULL:''0'';', 'CONFIG_OPTION_ocp_show_avatar', 'AVATAR', 'PERSONAL_BLOCK', 0, 'ocp_show_avatar', 'BLOCKS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''13.3em'';', 'CONFIG_OPTION_panel_width', 'PANEL_WIDTH', 'GENERAL', 0, 'panel_width', 'THEME', 'line');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''14.3em'';', 'CONFIG_OPTION_panel_width_spaced', 'PANEL_WIDTH_SPACED', 'GENERAL', 0, 'panel_width_spaced', 'THEME', 'line');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''0'';', 'CONFIG_OPTION_root_zone_login_theme', 'ROOT_ZONE_LOGIN_THEME', 'GENERAL', 0, 'root_zone_login_theme', 'THEME', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''0'';', 'CONFIG_OPTION_use_custom_zone_menu', 'USE_CUSTOM_ZONE_MENU', 'GENERAL', 0, 'use_custom_zone_menu', 'THEME', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''0'';', 'CONFIG_OPTION_tray_support', 'TRAY_SUPPORT', 'GENERAL', 0, 'tray_support', 'THEME', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''1'';', 'CONFIG_OPTION_show_docs', 'SHOW_DOCS', 'ADVANCED', 0, 'show_docs', 'SITE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''1'';', 'CONFIG_OPTION_captcha_noise', 'CAPTCHA_NOISE', 'ADVANCED', 0, 'captcha_noise', 'SITE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''0'';', 'CONFIG_OPTION_captcha_on_feedback', 'CAPTCHA_ON_FEEDBACK', 'ADVANCED', 0, 'captcha_on_feedback', 'SITE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''1'';', 'CONFIG_OPTION_show_post_validation', 'SHOW_POST_VALIDATION', 'ADVANCED', 0, 'show_post_validation', 'SITE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''0'';', 'CONFIG_OPTION_ip_forwarding', 'IP_FORWARDING', 'ENVIRONMENT', 0, 'ip_forwarding', 'SITE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''0'';', 'CONFIG_OPTION_force_meta_refresh', 'FORCE_META_REFRESH', 'ENVIRONMENT', 0, 'force_meta_refresh', 'SITE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''1'';', 'CONFIG_OPTION_use_contextual_dates', 'USE_CONTEXTUAL_DATES', 'ADVANCED', 0, 'use_contextual_dates', 'SITE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''1'';', 'CONFIG_OPTION_eager_wysiwyg', 'EAGER_WYSIWYG', 'ADVANCED', 0, 'eager_wysiwyg', 'SITE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, '$staff_address=get_option(''staff_address''); $website_email=''website@''.get_domain(); if (substr($staff_address,-strlen(get_domain())-1)==''@''.get_domain()) $website_email=$staff_address; return $website_email;', 'CONFIG_OPTION_website_email', 'WEBSITE_EMAIL', 'EMAIL', 0, 'website_email', 'SITE', 'line');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''0'';', 'CONFIG_OPTION_enveloper_override', 'ENVELOPER_OVERRIDE', 'EMAIL', 0, 'enveloper_override', 'SITE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''1'';', 'CONFIG_OPTION_bcc', 'BCC', 'EMAIL', 0, 'bcc', 'SITE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''0'';', 'CONFIG_OPTION_allow_ext_images', 'ALLOW_EXT_IMAGES', 'EMAIL', 0, 'allow_ext_images', 'SITE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return 0;', 'CONFIG_OPTION_htm_short_urls', 'HTM_SHORT_URLS', 'ADVANCED', 0, 'htm_short_urls', 'SITE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''1'';', 'CONFIG_OPTION_ip_strict_for_sessions', 'IP_STRICT_FOR_SESSIONS', 'GENERAL', 0, 'ip_strict_for_sessions', 'SECURITY', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''1'';', 'CONFIG_OPTION_enable_previews', 'ENABLE_PREVIEWS', 'PREVIEW', 0, 'enable_previews', 'SITE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''0'';', 'CONFIG_OPTION_enable_keyword_density_check', 'ENABLE_KEYWORD_DENSITY_CHECK', 'PREVIEW', 0, 'enable_keyword_density_check', 'SITE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return function_exists(''pspell_check'')?''0'':NULL;', 'CONFIG_OPTION_enable_spell_check', 'ENABLE_SPELL_CHECK', 'PREVIEW', 0, 'enable_spell_check', 'SITE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''0'';', 'CONFIG_OPTION_enable_markup_validation', 'ENABLE_MARKUP_VALIDATION', 'PREVIEW', 0, 'enable_markup_validation', 'SITE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''1'';', 'CONFIG_OPTION_enable_image_fading', 'ENABLE_IMAGE_FADING', 'GENERAL', 0, 'enable_image_fading', 'THEME', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''0'';', 'CONFIG_OPTION_auto_submit_sitemap', 'AUTO_SUBMIT_SITEMAP', 'GENERAL', 0, 'auto_submit_sitemap', 'SITE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return is_null($old=get_value(''no_user_postsize_errors''))?''1'':invert_value($old);', 'CONFIG_OPTION_user_postsize_errors', 'USER_POSTSIZE_ERRORS', 'UPLOAD', 0, 'user_postsize_errors', 'SITE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return is_null($old=get_value(''no_auto_meta''))?''1'':invert_value($old);', 'CONFIG_OPTION_automatic_meta_extraction', 'AUTOMATIC_META_EXTRACTION', 'GENERAL', 0, 'automatic_meta_extraction', 'SITE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return is_null($old=get_value(''no_emoticon_choosers''))?''1'':invert_value($old);', 'CONFIG_OPTION_is_on_emoticon_choosers', 'IS_ON_EMOTICON_CHOOSERS', 'GENERAL', 0, 'is_on_emoticon_choosers', 'THEME', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return is_null($old=get_value(''no_admin_menu_assumption''))?''1'':invert_value($old);', 'CONFIG_OPTION_deeper_admin_breadcrumbs', 'DEEPER_ADMIN_BREADCRUMBS', 'ADVANCED', 0, 'deeper_admin_breadcrumbs', 'SITE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return is_null($old=get_value(''has_low_memory_limit''))?((ini_get(''memory_limit'')==''-1'')?''0'':NULL):$old;', 'CONFIG_OPTION_has_low_memory_limit', 'HAS_LOW_MEMORY_LIMIT', 'ADVANCED', 0, 'has_low_memory_limit', 'SITE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return is_null($old=get_value(''disable_comcode_page_children''))?''1'':invert_value($old);', 'CONFIG_OPTION_is_on_comcode_page_children', 'IS_ON_COMCODE_PAGE_CHILDREN', 'ADVANCED', 0, 'is_on_comcode_page_children', 'SITE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return is_null($old=get_value(''disable_donext_global''))?''1'':invert_value($old);', 'CONFIG_OPTION_global_donext_icons', 'GLOBAL_DONEXT_ICONS', 'ADVANCED', 0, 'global_donext_icons', 'SITE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''1'';', 'CONFIG_OPTION_no_stats_when_closed', 'NO_STATS_WHEN_CLOSED', 'CLOSED_SITE', 0, 'no_stats_when_closed', 'SITE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''0'';', 'CONFIG_OPTION_no_bot_stats', 'NO_BOT_STATS', 'GENERAL', 0, 'no_bot_stats', 'SITE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''0'';', 'CONFIG_OPTION_java_upload', 'ENABLE_JAVA_UPLOAD', 'JAVA_UPLOAD', 0, 'java_upload', 'SITE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ocp_srv(''HTTP_HOST'');', 'CONFIG_OPTION_java_ftp_host', 'JAVA_FTP_HOST', 'JAVA_UPLOAD', 0, 'java_ftp_host', 'SITE', 'line');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''anonymous'';', 'CONFIG_OPTION_java_username', 'JAVA_FTP_USERNAME', 'JAVA_UPLOAD', 0, 'java_username', 'SITE', 'line');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''someone@example.com'';', 'CONFIG_OPTION_java_password', 'JAVA_FTP_PASSWORD', 'JAVA_UPLOAD', 0, 'java_password', 'SITE', 'line');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''/public_html/uploads/incoming/'';', 'CONFIG_OPTION_java_ftp_path', 'JAVA_FTP_PATH', 'JAVA_UPLOAD', 0, 'java_ftp_path', 'SITE', 'line');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('ocPortal demo', '', 1, 'return do_lang(''UNNAMED'');', 'CONFIG_OPTION_site_name', 'SITE_NAME', 'GENERAL', 0, 'site_name', 'SITE', 'line');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('467', '', 1, 'return ''???'';', 'CONFIG_OPTION_site_scope', 'SITE_SCOPE', 'GENERAL', 0, 'site_scope', 'SITE', 'transline');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('466', '', 1, 'return ''???'';', 'CONFIG_OPTION_description', 'DESCRIPTION', 'GENERAL', 0, 'description', 'SITE', 'transline');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('468', '', 1, 'return ''Copyright &copy; ''.get_site_name().'' ''.date(''Y'').'''';', 'CONFIG_OPTION_copyright', 'COPYRIGHT', 'GENERAL', 0, 'copyright', 'SITE', 'transline');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return '''';', 'CONFIG_OPTION_welcome_message', 'WELCOME_MESSAGE', 'GENERAL', 0, 'welcome_message', 'SITE', 'transtext');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('General chat', '', 1, 'return has_no_forum()?NULL:do_lang(''DEFAULT_FORUM_TITLE'','''','''','''',get_lang());', 'CONFIG_OPTION_main_forum_name', 'MAIN_FORUM_NAME', 'USER_INTERACTION', 0, 'main_forum_name', 'FEATURE', 'forum');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('default, defaultness, celebration, community', '', 1, 'return '''';', 'CONFIG_OPTION_keywords', 'KEYWORDS', 'GENERAL', 0, 'keywords', 'SITE', 'line');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 1, 'return '''';', 'CONFIG_OPTION_twitter_login', 'TWITTER_LOGIN', 'SOCIAL_NETWORKING_INTEGRATION', 0, 'twitter_login', 'FEATURE', 'line');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 1, 'return '''';', 'CONFIG_OPTION_twitter_password', 'TWITTER_PASSWORD', 'SOCIAL_NETWORKING_INTEGRATION', 0, 'twitter_password', 'FEATURE', 'line');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 1, 'return '''';', 'CONFIG_OPTION_facebook_api', 'FACEBOOK_API', 'SOCIAL_NETWORKING_INTEGRATION', 0, 'facebook_api', 'FEATURE', 'line');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 1, 'return '''';', 'CONFIG_OPTION_facebook_secret_code', 'FACEBOOK_SECRET', 'SOCIAL_NETWORKING_INTEGRATION', 0, 'facebook_secret_code', 'FEATURE', 'line');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 1, 'return '''';', 'CONFIG_OPTION_facebook_uid', 'FACEBOOK_UID', 'SOCIAL_NETWORKING_INTEGRATION', 0, 'facebook_uid', 'FEATURE', 'line');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 1, 'return '''';', 'CONFIG_OPTION_facebook_target_ids', 'FACEBOOK_TARGET_IDS', 'SOCIAL_NETWORKING_INTEGRATION', 0, 'facebook_target_ids', 'FEATURE', 'line');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''0'';', 'CONFIG_OPTION_gzip_output', 'GZIP_OUTPUT', 'ADVANCED', 1, 'gzip_output', 'SITE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return has_no_forum()?NULL:''0'';', 'CONFIG_OPTION_forum_in_portal', 'FORUM_IN_PORTAL', 'ENVIRONMENT', 1, 'forum_in_portal', 'SITE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('demo_staff@ocproducts.com', '', 1, 'return ''staff@''.get_domain();', 'CONFIG_OPTION_staff_address', 'EMAIL', 'EMAIL', 0, 'staff_address', 'SITE', 'line');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return function_exists(''imagetypes'')?''1'':''0'';', 'CONFIG_OPTION_is_on_gd', 'GD', 'ENVIRONMENT', 1, 'is_on_gd', 'SITE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''1'';', 'CONFIG_OPTION_is_on_folder_create', 'FOLDER_CREATE', 'ENVIRONMENT', 1, 'is_on_folder_create', 'SITE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('1', '', 1, 'return ''1'';', 'CONFIG_OPTION_site_closed', 'CLOSED_SITE', 'CLOSED_SITE', 0, 'site_closed', 'SITE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('469', '', 1, 'return do_lang(''BEING_INSTALLED'');', 'CONFIG_OPTION_closed', 'MESSAGE', 'CLOSED_SITE', 0, 'closed', 'SITE', 'transtext');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''100'';', 'CONFIG_OPTION_maximum_users', 'MAXIMUM_USERS', 'CLOSED_SITE', 1, 'maximum_users', 'SITE', 'integer');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return '''';', 'CONFIG_OPTION_cc_address', 'CC_ADDRESS', 'EMAIL', 0, 'cc_address', 'SITE', 'line');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''1'';', 'CONFIG_OPTION_log_php_errors', 'LOG_PHP_ERRORS', 'LOGGING', 0, 'log_php_errors', 'SITE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''0'';', 'CONFIG_OPTION_display_php_errors', 'DISPLAY_PHP_ERRORS', 'LOGGING', 0, 'display_php_errors', 'SITE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''swf,sql,odg,odp,odt,ods,ps,pdf,doc,ppt,csv,xls,docx,pptx,xlsx,pub,txt,psd,tga,tif,gif,png,bmp,jpg,jpeg,flv,avi,mov,mpg,mpeg,mp4,asf,wmv,ram,ra,rm,qt,mov,zip,tar,rar,gz,wav,mp3,ogg,torrent,php,css,tpl,ini,eml'';', 'CONFIG_OPTION_valid_types', 'FILE_TYPES', 'UPLOADED_FILES', 0, 'valid_types', 'SECURITY', 'line');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''jpg,jpeg,gif,png'';', 'CONFIG_OPTION_valid_images', 'IMAGE_TYPES', 'UPLOADED_FILES', 0, 'valid_images', 'SECURITY', 'line');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('1', '', 1, 'return ''1'';', 'CONFIG_OPTION_is_on_rating', 'RATING', 'USER_INTERACTION', 0, 'is_on_rating', 'FEATURE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('1', '', 1, 'return has_no_forum()?NULL:''1'';', 'CONFIG_OPTION_is_on_comments', 'COMMENTS', 'USER_INTERACTION', 0, 'is_on_comments', 'FEATURE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('Website comment topics', '', 1, 'return has_no_forum()?NULL:do_lang(''COMMENT_FORUM_NAME'','''','''','''',get_lang());', 'CONFIG_OPTION_comments_forum_name', 'COMMENTS_FORUM_NAME', 'USER_INTERACTION', 0, 'comments_forum_name', 'FEATURE', 'forum');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('507', '', 1, 'return has_no_forum()?NULL:do_template(''COMMENTS_DEFAULT_TEXT'');', 'CONFIG_OPTION_comment_text', 'COMMENT_FORM_TEXT', 'USER_INTERACTION', 0, 'comment_text', 'FEATURE', 'transtext');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('200', '', 1, 'return ''200'';', 'CONFIG_OPTION_thumb_width', 'THUMB_WIDTH', 'IMAGES', 0, 'thumb_width', 'FEATURE', 'integer');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''700'';', 'CONFIG_OPTION_max_image_size', 'IMAGES', 'UPLOAD', 0, 'max_image_size', 'SITE', 'integer');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''5'';', 'CONFIG_OPTION_users_online_time', 'USERS_ONLINE_TIME', 'LOGGING', 0, 'users_online_time', 'SITE', 'integer');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, '$donate_tpl=do_template(''FLAGRANT_DEFAULT_TEXT''); return $donate_tpl->evaluate();', 'CONFIG_OPTION_system_flagrant', 'SYSTEM_FLAGRANT', 'GENERAL', 0, 'system_flagrant', 'SITE', 'transline');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('Website "Contact Us" messages', '', 1, 'return do_lang(''MESSAGING_FORUM_NAME'','''','''','''',get_lang());', 'CONFIG_OPTION_messaging_forum_name', '_MESSAGING_FORUM_NAME', 'CONTACT_US_MESSAGING', 0, 'messaging_forum_name', 'FEATURE', 'forum');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''0'';', 'CONFIG_OPTION_occle_chat_announce', 'OCCLE_CHAT_ANNOUNCE', 'ADVANCED', 0, 'occle_chat_announce', 'SITE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('1', '', 1, 'return ''1'';', 'CONFIG_OPTION_bottom_show_occle_button', 'OCCLE_BUTTON', 'BOTTOM_LINKS', 0, 'bottom_show_occle_button', 'FEATURE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('0', '', 1, 'return ''0'';', 'CONFIG_OPTION_ldap_is_enabled', 'LDAP_IS_ENABLED', 'LDAP', 1, 'ldap_is_enabled', 'SECTION_FORUMS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('0', '', 1, 'return (DIRECTORY_SEPARATOR==''/'')?''0'':''1'';', 'CONFIG_OPTION_ldap_is_windows', 'LDAP_IS_WINDOWS', 'LDAP', 1, 'ldap_is_windows', 'SECTION_FORUMS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('0', '', 1, 'return ''0'';', 'CONFIG_OPTION_ldap_allow_joining', 'LDAP_ALLOW_JOINING', 'LDAP', 1, 'ldap_allow_joining', 'SECTION_FORUMS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('localhost', '', 1, 'return ''localhost'';', 'CONFIG_OPTION_ldap_hostname', 'LDAP_HOSTNAME', 'LDAP', 1, 'ldap_hostname', 'SECTION_FORUMS', 'line');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('dc=example,dc=com', '', 1, 'return ''dc=example,dc=com'';', 'CONFIG_OPTION_ldap_base_dn', 'LDAP_BASE_DN', 'LDAP', 1, 'ldap_base_dn', 'SECTION_FORUMS', 'line');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('NotManager', '', 1, 'return (DIRECTORY_SEPARATOR==''/'')?''NotManager'':''NotAdministrator'';', 'CONFIG_OPTION_ldap_bind_rdn', 'USERNAME', 'LDAP', 1, 'ldap_bind_rdn', 'SECTION_FORUMS', 'line');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 1, 'return '''';', 'CONFIG_OPTION_ldap_bind_password', 'PASSWORD', 'LDAP', 1, 'ldap_bind_password', 'SECTION_FORUMS', 'line');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('0', '', 1, 'return ''0'';', 'CONFIG_OPTION_windows_auth_is_enabled', 'WINDOWS_AUTHENTICATION', 'LDAP', 0, 'windows_auth_is_enabled', 'SECTION_FORUMS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 1, 'return is_null($old=get_value(''ldap_login_qualifier''))?'''':$old;', 'CONFIG_OPTION_ldap_login_qualifier', 'LDAP_LOGIN_QUALIFIER', 'LDAP', 0, 'ldap_login_qualifier', 'SECTION_FORUMS', 'line');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('ou=Group', '', 1, 'return ''ou=Group'';', 'CONFIG_OPTION_ldap_group_search_qualifier', 'LDAP_GROUP_SEARCH_QUALIFIER', 'LDAP', 0, 'ldap_group_search_qualifier', 'SECTION_FORUMS', 'line');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('cn=Users', '', 1, 'return (get_option(''ldap_is_windows'')==''0'')?''cn=Users'':''ou=People'';', 'CONFIG_OPTION_ldap_member_search_qualifier', 'LDAP_MEMBER_SEARCH_QUALIFIER', 'LDAP', 0, 'ldap_member_search_qualifier', 'SECTION_FORUMS', 'line');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('uid', '', 1, 'return (get_option(''ldap_is_windows'')==''0'')?''uid'':''sAMAccountName'';', 'CONFIG_OPTION_ldap_member_property', 'LDAP_MEMBER_PROPERTY', 'LDAP', 0, 'ldap_member_property', 'SECTION_FORUMS', 'line');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('1', '', 1, 'return ''1'';', 'CONFIG_OPTION_ldap_none_bind_logins', 'LDAP_NONE_BIND_LOGINS', 'LDAP', 0, 'ldap_none_bind_logins', 'SECTION_FORUMS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('3', '', 1, 'return ''3'';', 'CONFIG_OPTION_ldap_version', 'LDAP_VERSION', 'LDAP', 0, 'ldap_version', 'SECTION_FORUMS', 'integer');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('posixGroup', '', 1, 'return ''posixGroup'';', 'CONFIG_OPTION_ldap_group_class', 'LDAP_GROUP_CLASS', 'LDAP', 0, 'ldap_group_class', 'SECTION_FORUMS', 'line');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('posixAccount', '', 1, 'return ''posixAccount'';', 'CONFIG_OPTION_ldap_member_class', 'LDAP_MEMBER_CLASS', 'LDAP', 0, 'ldap_member_class', 'SECTION_FORUMS', 'line');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return addon_installed(''points'')?''10'':NULL;', 'CONFIG_OPTION_points_COMCODE_PAGE_ADD', 'COMCODE_PAGE_ADD', 'COUNT_POINTS_GIVEN', 0, 'points_COMCODE_PAGE_ADD', 'POINTS', 'integer');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''1'';', 'CONFIG_OPTION_store_revisions', 'STORE_REVISIONS', 'COMCODE_PAGE_MANAGEMENT', 0, 'store_revisions', 'ADMIN', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''5'';', 'CONFIG_OPTION_number_revisions_show', 'SHOW_REVISIONS', 'COMCODE_PAGE_MANAGEMENT', 0, 'number_revisions_show', 'ADMIN', 'integer');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return do_lang(''POST_STAFF'');', 'CONFIG_OPTION_staff_text', 'PAGE_TEXT', 'STAFF', 0, 'staff_text', 'SECURITY', 'transtext');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''0'';', 'CONFIG_OPTION_is_on_staff_filter', 'MEMBER_FILTER', 'STAFF', 1, 'is_on_staff_filter', 'SECURITY', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''1'';', 'CONFIG_OPTION_is_on_sync_staff', 'SYNCHRONISATION', 'STAFF', 1, 'is_on_sync_staff', 'SECURITY', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''1'';', 'CONFIG_OPTION_super_logging', 'SUPER_LOGGING', 'LOGGING', 1, 'super_logging', 'SITE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''124'';', 'CONFIG_OPTION_stats_store_time', 'STORE_TIME', 'LOGGING', 1, 'stats_store_time', 'SITE', 'integer');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''1'';', 'CONFIG_OPTION_templates_store_revisions', 'STORE_REVISIONS', 'EDIT_TEMPLATES', 0, 'templates_store_revisions', 'ADMIN', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''5'';', 'CONFIG_OPTION_templates_number_revisions_show', 'SHOW_REVISIONS', 'EDIT_TEMPLATES', 0, 'templates_number_revisions_show', 'ADMIN', 'integer');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('1', '', 1, 'return ''1'';', 'CONFIG_OPTION_is_on_banners', 'ENABLE_BANNERS', 'BANNERS', 0, 'is_on_banners', 'FEATURE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 1, 'return '''';', 'CONFIG_OPTION_money_ad_code', 'MONEY_AD_CODE', 'BANNERS', 1, 'money_ad_code', 'FEATURE', 'text');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('5', '', 1, 'return ''5'';', 'CONFIG_OPTION_advert_chance', 'ADVERT_CHANCE', 'BANNERS', 1, 'advert_chance', 'FEATURE', 'float');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return addon_installed(''points'')?''0'':NULL;', 'CONFIG_OPTION_points_ADD_BANNER', 'ADD_BANNER', 'COUNT_POINTS_GIVEN', 0, 'points_ADD_BANNER', 'POINTS', 'integer');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('0', '', 1, 'return ''0'';', 'CONFIG_OPTION_use_banner_permissions', 'PERMISSIONS', 'BANNERS', 0, 'use_banner_permissions', 'FEATURE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('0', '', 1, 'return is_null($old=get_value(''banner_autosize''))?''0'':$old;', 'CONFIG_OPTION_banner_autosize', 'BANNER_AUTOSIZE', 'BANNERS', 0, 'banner_autosize', 'FEATURE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('1', '', 1, 'return is_null($old=get_value(''always_banners''))?''0'':$old;', 'CONFIG_OPTION_admin_banners', 'ADMIN_BANNERS', 'BANNERS', 0, 'admin_banners', 'FEATURE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return addon_installed(''stats_block'')?''0'':NULL;', 'CONFIG_OPTION_calendar_show_stats_count_events', 'EVENTS', 'STATISTICS', 0, 'calendar_show_stats_count_events', 'BLOCKS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return addon_installed(''stats_block'')?''0'':NULL;', 'CONFIG_OPTION_calendar_show_stats_count_events_this_week', '_EVENTS_THIS_WEEK', 'STATISTICS', 0, 'calendar_show_stats_count_events_this_week', 'BLOCKS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return addon_installed(''stats_block'')?''0'':NULL;', 'CONFIG_OPTION_calendar_show_stats_count_events_this_month', '_EVENTS_THIS_MONTH', 'STATISTICS', 0, 'calendar_show_stats_count_events_this_month', 'BLOCKS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return addon_installed(''stats_block'')?''0'':NULL;', 'CONFIG_OPTION_calendar_show_stats_count_events_this_year', '_EVENTS_THIS_YEAR', 'STATISTICS', 0, 'calendar_show_stats_count_events_this_year', 'BLOCKS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return addon_installed(''points'')?''10'':NULL;', 'CONFIG_OPTION_points_cedi', 'CEDI_MAKE_POST', 'COUNT_POINTS_GIVEN', 0, 'points_cedi', 'POINTS', 'integer');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return addon_installed(''stats_block'')?''0'':NULL;', 'CONFIG_OPTION_cedi_show_stats_count_pages', 'CEDI_PAGES', 'STATISTICS', 0, 'cedi_show_stats_count_pages', 'BLOCKS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return addon_installed(''stats_block'')?''0'':NULL;', 'CONFIG_OPTION_cedi_show_stats_count_posts', 'CEDI_POSTS', 'STATISTICS', 0, 'cedi_show_stats_count_posts', 'BLOCKS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('5', '', 1, 'return ''5'';', 'CONFIG_OPTION_chat_flood_timelimit', 'FLOOD_TIMELIMIT', 'SECTION_CHAT', 0, 'chat_flood_timelimit', 'FEATURE', 'integer');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('#000000', '', 1, 'return ''#000000'';', 'CONFIG_OPTION_chat_default_post_colour', 'CHAT_OPTIONS_COLOUR_NAME', 'SECTION_CHAT', 0, 'chat_default_post_colour', 'FEATURE', 'line');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('Verdana', '', 1, 'return ''Verdana'';', 'CONFIG_OPTION_chat_default_post_font', 'CHAT_OPTIONS_TEXT_NAME', 'SECTION_CHAT', 0, 'chat_default_post_font', 'FEATURE', 'line');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('1440', '', 1, 'return ''1440'';', 'CONFIG_OPTION_chat_private_room_deletion_time', 'PRIVATE_ROOM_DELETION_TIME', 'SECTION_CHAT', 0, 'chat_private_room_deletion_time', 'FEATURE', 'integer');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('0', '', 1, 'return ''0'';', 'CONFIG_OPTION_username_click_im', 'USERNAME_CLICK_IM', 'SECTION_CHAT', 0, 'username_click_im', 'FEATURE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return addon_installed(''points'')?''1'':NULL;', 'CONFIG_OPTION_points_chat', 'CHATTING', 'COUNT_POINTS_GIVEN', 0, 'points_chat', 'POINTS', 'integer');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return addon_installed(''stats_block'')?''0'':NULL;', 'CONFIG_OPTION_chat_show_stats_count_users', 'COUNT_CHATTERS', 'STATISTICS', 0, 'chat_show_stats_count_users', 'BLOCKS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return addon_installed(''stats_block'')?''0'':NULL;', 'CONFIG_OPTION_chat_show_stats_count_rooms', 'ROOMS', 'STATISTICS', 0, 'chat_show_stats_count_rooms', 'BLOCKS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return addon_installed(''stats_block'')?''0'':NULL;', 'CONFIG_OPTION_chat_show_stats_count_messages', 'COUNT_CHATPOSTS', 'STATISTICS', 0, 'chat_show_stats_count_messages', 'BLOCKS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('0', '', 1, 'return ''0'';', 'CONFIG_OPTION_sitewide_im', 'SITEWIDE_IM', 'SECTION_CHAT', 0, 'sitewide_im', 'FEATURE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('1', '', 1, 'return is_null($old=get_value(''no_group_private_chatrooms''))?''1'':invert_value($old);', 'CONFIG_OPTION_group_private_chatrooms', 'GROUP_PRIVATE_CHATROOMS', 'SECTION_CHAT', 0, 'group_private_chatrooms', 'FEATURE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''15'';', 'CONFIG_OPTION_maximum_download', 'MAXIMUM_DOWNLOAD', 'CLOSED_SITE', 0, 'maximum_download', 'SITE', 'integer');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('0', '', 1, 'return ''0'';', 'CONFIG_OPTION_show_dload_trees', 'SHOW_DLOAD_TREES', 'SECTION_DOWNLOADS', 1, 'show_dload_trees', 'FEATURE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return addon_installed(''points'')?''150'':NULL;', 'CONFIG_OPTION_points_ADD_DOWNLOAD', 'ADD_DOWNLOAD', 'COUNT_POINTS_GIVEN', 0, 'points_ADD_DOWNLOAD', 'POINTS', 'integer');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return addon_installed(''stats_block'')?''0'':NULL;', 'CONFIG_OPTION_downloads_show_stats_count_total', '_SECTION_DOWNLOADS', 'STATISTICS', 0, 'downloads_show_stats_count_total', 'BLOCKS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return addon_installed(''stats_block'')?''0'':NULL;', 'CONFIG_OPTION_downloads_show_stats_count_archive', 'TOTAL_DOWNLOADS_IN_ARCHIVE', 'STATISTICS', 0, 'downloads_show_stats_count_archive', 'BLOCKS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return addon_installed(''stats_block'')?''0'':NULL;', 'CONFIG_OPTION_downloads_show_stats_count_downloads', '_COUNT_DOWNLOADS', 'STATISTICS', 0, 'downloads_show_stats_count_downloads', 'BLOCKS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return addon_installed(''stats_block'')?''0'':NULL;', 'CONFIG_OPTION_downloads_show_stats_count_bandwidth', '_COUNT_BANDWIDTH', 'STATISTICS', 0, 'downloads_show_stats_count_bandwidth', 'BLOCKS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('0', '', 1, 'return ''0'';', 'CONFIG_OPTION_immediate_downloads', 'IMMEDIATE_DOWNLOADS', 'SECTION_DOWNLOADS', 0, 'immediate_downloads', 'FEATURE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('root', '', 1, 'return is_null($old=get_value(''download_gallery_root''))?(addon_installed(''galleries'')?''root'':NULL):$old;', 'CONFIG_OPTION_download_gallery_root', 'DOWNLOAD_GALLERY_ROOT', 'SECTION_DOWNLOADS', 0, 'download_gallery_root', 'FEATURE', 'line');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return addon_installed(''points'')?''100'':NULL;', 'CONFIG_OPTION_points_ADD_IMAGE', 'ADD_IMAGE', 'COUNT_POINTS_GIVEN', 0, 'points_ADD_IMAGE', 'POINTS', 'integer');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('320', '', 1, 'return ''320'';', 'CONFIG_OPTION_default_video_width', 'DEFAULT_VIDEO_WIDTH', 'GALLERIES', 0, 'default_video_width', 'FEATURE', 'integer');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('240', '', 1, 'return ''240'';', 'CONFIG_OPTION_default_video_height', 'DEFAULT_VIDEO_HEIGHT', 'GALLERIES', 0, 'default_video_height', 'FEATURE', 'integer');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('1024', '', 1, 'return ''1024'';', 'CONFIG_OPTION_maximum_image_size', 'MAXIMUM_IMAGE_SIZE', 'GALLERIES', 0, 'maximum_image_size', 'FEATURE', 'integer');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('5', '', 1, 'return ''5'';', 'CONFIG_OPTION_max_personal_gallery_images_low', 'GALLERY_IMAGE_LIMIT_LOW', 'GALLERIES', 0, 'max_personal_gallery_images_low', 'FEATURE', 'integer');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('10', '', 1, 'return ''10'';', 'CONFIG_OPTION_max_personal_gallery_images_high', 'GALLERY_IMAGE_LIMIT_HIGH', 'GALLERIES', 0, 'max_personal_gallery_images_high', 'FEATURE', 'integer');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('2', '', 1, 'return ''2'';', 'CONFIG_OPTION_max_personal_gallery_videos_low', 'GALLERY_VIDEO_LIMIT_LOW', 'GALLERIES', 0, 'max_personal_gallery_videos_low', 'FEATURE', 'integer');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('5', '', 1, 'return ''5'';', 'CONFIG_OPTION_max_personal_gallery_videos_high', 'GALLERY_VIDEO_LIMIT_HIGH', 'GALLERIES', 0, 'max_personal_gallery_videos_high', 'FEATURE', 'integer');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return addon_installed(''stats_block'')?''0'':NULL;', 'CONFIG_OPTION_galleries_show_stats_count_galleries', 'GALLERIES', 'STATISTICS', 0, 'galleries_show_stats_count_galleries', 'BLOCKS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return addon_installed(''stats_block'')?''0'':NULL;', 'CONFIG_OPTION_galleries_show_stats_count_images', 'IMAGES', 'STATISTICS', 0, 'galleries_show_stats_count_images', 'BLOCKS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return addon_installed(''stats_block'')?''0'':NULL;', 'CONFIG_OPTION_galleries_show_stats_count_videos', 'VIDEOS', 'STATISTICS', 0, 'galleries_show_stats_count_videos', 'BLOCKS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('0', '', 1, 'return ''0'';', 'CONFIG_OPTION_show_empty_galleries', 'SHOW_EMPTY_GALLERIES', 'GALLERIES', 0, 'show_empty_galleries', 'FEATURE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('0', '', 1, 'return ''0'';', 'CONFIG_OPTION_gallery_name_order', 'GALLERY_NAME_ORDER', 'GALLERIES', 0, 'gallery_name_order', 'FEATURE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('6,9,18,36', '', 1, 'return is_null($old=get_value(''gallery_selectors''))?''6,9,18,36'':$old;', 'CONFIG_OPTION_gallery_selectors', 'GALLERY_SELECTORS', 'GALLERIES', 0, 'gallery_selectors', 'FEATURE', 'line');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('0', '', 1, 'return is_null($old=get_value(''reverse_thumb_order''))?''0'':$old;', 'CONFIG_OPTION_reverse_thumb_order', 'REVERSE_THUMB_ORDER', 'GALLERIES', 0, 'reverse_thumb_order', 'FEATURE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('0', '', 1, 'return is_null($old=get_value(''show_gallery_counts''))?((get_forum_type()==''ocf'')?''0'':NULL):$old;', 'CONFIG_OPTION_show_gallery_counts', 'SHOW_GALLERY_COUNTS', 'GALLERIES', 0, 'show_gallery_counts', 'FEATURE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return addon_installed(''points'')?''35'':NULL;', 'CONFIG_OPTION_points_CHOOSE_IOTD', 'CHOOSE_IOTD', 'COUNT_POINTS_GIVEN', 0, 'points_CHOOSE_IOTD', 'POINTS', 'integer');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return addon_installed(''points'')?''150'':NULL;', 'CONFIG_OPTION_points_ADD_IOTD', 'ADD_IOTD', 'COUNT_POINTS_GIVEN', 0, 'points_ADD_IOTD', 'POINTS', 'integer');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''24'';', 'CONFIG_OPTION_iotd_update_time', 'IOTD_REGULARITY', 'CHECK_LIST', 0, 'iotd_update_time', 'ADMIN', 'integer');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return addon_installed(''points'')?''225'':NULL;', 'CONFIG_OPTION_points_ADD_NEWS', 'ADD_NEWS', 'COUNT_POINTS_GIVEN', 0, 'points_ADD_NEWS', 'POINTS', 'integer');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''168'';', 'CONFIG_OPTION_news_update_time', 'NEWS_REGULARITY', 'CHECK_LIST', 0, 'news_update_time', 'ADMIN', 'integer');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''168'';', 'CONFIG_OPTION_blog_update_time', 'BLOG_REGULARITY', 'CHECK_LIST', 0, 'blog_update_time', 'ADMIN', 'integer');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('http://pingomatic.com/ping/?title={title}&blogurl={url}&rssurl={rss}', '', 1, 'return ''http://pingomatic.com/ping/?title={title}&blogurl={url}&rssurl={rss}'';', 'CONFIG_OPTION_ping_url', 'PING_URL', 'NEWS_AND_RSS', 0, 'ping_url', 'FEATURE', 'text');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return addon_installed(''stats_block'')?''0'':NULL;', 'CONFIG_OPTION_news_show_stats_count_total_posts', 'TOTAL_NEWS_ENTRIES', 'STATISTICS', 0, 'news_show_stats_count_total_posts', 'BLOCKS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return addon_installed(''stats_block'')?''0'':NULL;', 'CONFIG_OPTION_news_show_stats_count_blogs', 'BLOGS', 'STATISTICS', 0, 'news_show_stats_count_blogs', 'BLOCKS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('508', '', 1, 'return '''';', 'CONFIG_OPTION_newsletter_text', 'PAGE_TEXT', 'NEWSLETTER', 0, 'newsletter_text', 'FEATURE', 'transtext');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('(unnamed) Newsletter', '', 1, 'return get_option(''site_name'').'' ''.do_lang(''NEWSLETTER'');', 'CONFIG_OPTION_newsletter_title', 'TITLE', 'NEWSLETTER', 0, 'newsletter_title', 'FEATURE', 'line');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('0', '', 1, 'return ''0'';', 'CONFIG_OPTION_interest_levels', 'USE_INTEREST_LEVELS', 'NEWSLETTER', 0, 'interest_levels', 'FEATURE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''40'';', 'CONFIG_OPTION_points_joining', 'JOINING', 'COUNT_POINTS_GIVEN', 0, 'points_joining', 'POINTS', 'integer');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''5'';', 'CONFIG_OPTION_points_posting', 'MAKE_POST', 'COUNT_POINTS_GIVEN', 0, 'points_posting', 'POINTS', 'integer');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''5'';', 'CONFIG_OPTION_points_rating', 'RATING', 'COUNT_POINTS_GIVEN', 0, 'points_rating', 'POINTS', 'integer');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''5'';', 'CONFIG_OPTION_points_voting', 'VOTING', 'COUNT_POINTS_GIVEN', 0, 'points_voting', 'POINTS', 'integer');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''1'';', 'CONFIG_OPTION_points_show_personal_profile_link', 'MY_POINTS_LINK', 'PERSONAL_BLOCK', 0, 'points_show_personal_profile_link', 'BLOCKS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''0'';', 'CONFIG_OPTION_points_show_personal_stats_points_left', 'COUNT_POINTS_LEFT', 'PERSONAL_BLOCK', 0, 'points_show_personal_stats_points_left', 'BLOCKS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''0'';', 'CONFIG_OPTION_points_show_personal_stats_points_used', 'COUNT_POINTS_USED', 'PERSONAL_BLOCK', 0, 'points_show_personal_stats_points_used', 'BLOCKS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''0'';', 'CONFIG_OPTION_points_show_personal_stats_gift_points_left', 'COUNT_GIFT_POINTS_LEFT', 'PERSONAL_BLOCK', 0, 'points_show_personal_stats_gift_points_left', 'BLOCKS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''0'';', 'CONFIG_OPTION_points_show_personal_stats_gift_points_used', 'COUNT_GIFT_POINTS_USED', 'PERSONAL_BLOCK', 0, 'points_show_personal_stats_gift_points_used', 'BLOCKS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''0'';', 'CONFIG_OPTION_points_show_personal_stats_total_points', 'COUNT_POINTS_EVER', 'PERSONAL_BLOCK', 0, 'points_show_personal_stats_total_points', 'BLOCKS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''0'';', 'CONFIG_OPTION_points_per_day', 'POINTS_PER_DAY', 'COUNT_POINTS_GIVEN', 0, 'points_per_day', 'POINTS', 'integer');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''0'';', 'CONFIG_OPTION_points_per_daily_visit', 'POINTS_PER_DAILY_VISIT', 'COUNT_POINTS_GIVEN', 0, 'points_per_daily_visit', 'POINTS', 'integer');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return (get_forum_type()!=''ocf'')?false:''1'';', 'CONFIG_OPTION_is_on_highlight_name_buy', 'ENABLE_PURCHASE', 'NAME_HIGHLIGHTING', 0, 'is_on_highlight_name_buy', 'POINTSTORE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return (get_forum_type()!=''ocf'')?false:''2000'';', 'CONFIG_OPTION_highlight_name', 'COST_highlight_name', 'NAME_HIGHLIGHTING', 0, 'highlight_name', 'POINTSTORE', 'integer');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return (!addon_installed(''ocf_forum''))?false:''1'';', 'CONFIG_OPTION_is_on_topic_pin_buy', 'ENABLE_PURCHASE', 'TOPIC_PINNING', 0, 'is_on_topic_pin_buy', 'POINTSTORE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return (!addon_installed(''ocf_forum''))?false:''180'';', 'CONFIG_OPTION_topic_pin', 'COST_topic_pin', 'TOPIC_PINNING', 0, 'topic_pin', 'POINTSTORE', 'integer');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''1'';', 'CONFIG_OPTION_is_on_gambling_buy', 'ENABLE_PURCHASE', 'GAMBLING', 0, 'is_on_gambling_buy', 'POINTSTORE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''6'';', 'CONFIG_OPTION_minimum_gamble_amount', 'MINIMUM_GAMBLE_AMOUNT', 'GAMBLING', 0, 'minimum_gamble_amount', 'POINTSTORE', 'integer');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''200'';', 'CONFIG_OPTION_maximum_gamble_amount', 'MAXIMUM_GAMBLE_AMOUNT', 'GAMBLING', 0, 'maximum_gamble_amount', 'POINTSTORE', 'integer');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''200'';', 'CONFIG_OPTION_maximum_gamble_multiplier', 'MAXIMUM_GAMBLE_MULTIPLIER', 'GAMBLING', 0, 'maximum_gamble_multiplier', 'POINTSTORE', 'integer');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''85'';', 'CONFIG_OPTION_average_gamble_multiplier', 'AVERAGE_GAMBLE_MULTIPLIER', 'GAMBLING', 0, 'average_gamble_multiplier', 'POINTSTORE', 'integer');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return (!addon_installed(''banners''))?false:''750'';', 'CONFIG_OPTION_banner_setup', 'COST_banner_setup', 'BANNERS', 0, 'banner_setup', 'POINTSTORE', 'integer');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return (!addon_installed(''banners''))?false:''700'';', 'CONFIG_OPTION_banner_imp', 'COST_banner_imp', 'BANNERS', 0, 'banner_imp', 'POINTSTORE', 'integer');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return (!addon_installed(''banners''))?false:''20'';', 'CONFIG_OPTION_banner_hit', 'COST_banner_hit', 'BANNERS', 0, 'banner_hit', 'POINTSTORE', 'integer');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''2'';', 'CONFIG_OPTION_quota', 'COST_quota', 'POP3', 0, 'quota', 'POINTSTORE', 'integer');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return (!addon_installed(''flagrant''))?false:''700'';', 'CONFIG_OPTION_text', 'COST_text', 'FLAGRANT_MESSAGE', 0, 'text', 'POINTSTORE', 'integer');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return (!addon_installed(''banners''))?false:''1'';', 'CONFIG_OPTION_is_on_banner_buy', 'ENABLE_PURCHASE', 'BANNERS', 0, 'is_on_banner_buy', 'POINTSTORE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return (!addon_installed(''banners''))?false:''100'';', 'CONFIG_OPTION_initial_banner_hits', 'HITS_ALLOCATED', 'BANNERS', 0, 'initial_banner_hits', 'POINTSTORE', 'integer');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''0'';', 'CONFIG_OPTION_is_on_pop3_buy', 'ENABLE_PURCHASE', 'POP3', 1, 'is_on_pop3_buy', 'POINTSTORE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''200'';', 'CONFIG_OPTION_initial_quota', 'QUOTA', 'POP3', 1, 'initial_quota', 'POINTSTORE', 'integer');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''10000'';', 'CONFIG_OPTION_max_quota', 'MAX_QUOTA', 'POP3', 1, 'max_quota', 'POINTSTORE', 'integer');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''mail.''.get_domain();', 'CONFIG_OPTION_mail_server', 'MAIL_SERVER', 'POP3', 1, 'mail_server', 'POINTSTORE', 'line');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''http://''.get_domain().'':2082/frontend/x/mail/addpop2.html'';', 'CONFIG_OPTION_pop_url', 'POP3_MAINTAIN_URL', 'POP3', 1, 'pop_url', 'POINTSTORE', 'line');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''http://''.get_domain().'':2082/frontend/x/mail/pops.html'';', 'CONFIG_OPTION_quota_url', 'QUOTA_MAINTAIN_URL', 'POP3', 1, 'quota_url', 'POINTSTORE', 'line');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''0'';', 'CONFIG_OPTION_is_on_forw_buy', 'ENABLE_PURCHASE', 'FORWARDING', 1, 'is_on_forw_buy', 'POINTSTORE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''http://''.get_domain().'':2082/frontend/x/mail/addfwd.html'';', 'CONFIG_OPTION_forw_url', 'FORW_MAINTAIN_URL', 'FORWARDING', 1, 'forw_url', 'POINTSTORE', 'line');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return (!addon_installed(''flagrant''))?false:''1'';', 'CONFIG_OPTION_is_on_flagrant_buy', 'ENABLE_PURCHASE', 'FLAGRANT_MESSAGE', 0, 'is_on_flagrant_buy', 'POINTSTORE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return addon_installed(''points'')?''150'':NULL;', 'CONFIG_OPTION_points_ADD_POLL', 'ADD_POLL', 'COUNT_POINTS_GIVEN', 0, 'points_ADD_POLL', 'POINTS', 'integer');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return addon_installed(''points'')?''35'':NULL;', 'CONFIG_OPTION_points_CHOOSE_POLL', 'CHOOSE_POLL', 'COUNT_POINTS_GIVEN', 0, 'points_CHOOSE_POLL', 'POINTS', 'integer');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''168'';', 'CONFIG_OPTION_poll_update_time', 'POLL_REGULARITY', 'CHECK_LIST', 0, 'poll_update_time', 'ADMIN', 'integer');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''0'';', 'CONFIG_OPTION_use_local_payment', 'USE_LOCAL_PAYMENT', 'ECOMMERCE', 0, 'use_local_payment', 'ECOMMERCE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return '''';', 'CONFIG_OPTION_ipn_password', 'IPN_PASSWORD', 'ECOMMERCE', 0, 'ipn_password', 'ECOMMERCE', 'line');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return '''';', 'CONFIG_OPTION_ipn_digest', 'IPN_DIGEST', 'ECOMMERCE', 0, 'ipn_digest', 'ECOMMERCE', 'line');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return '''';', 'CONFIG_OPTION_vpn_username', 'VPN_USERNAME', 'ECOMMERCE', 0, 'vpn_username', 'ECOMMERCE', 'line');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return '''';', 'CONFIG_OPTION_vpn_password', 'VPN_PASSWORD', 'ECOMMERCE', 0, 'vpn_password', 'ECOMMERCE', 'line');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return '''';', 'CONFIG_OPTION_callback_password', 'CALLBACK_PASSWORD', 'ECOMMERCE', 0, 'callback_password', 'ECOMMERCE', 'line');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return '''';', 'CONFIG_OPTION_pd_address', 'POSTAL_ADDRESS', 'ECOMMERCE', 0, 'pd_address', 'ECOMMERCE', 'text');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return get_option(''staff_address'');', 'CONFIG_OPTION_pd_email', 'EMAIL_ADDRESS', 'ECOMMERCE', 0, 'pd_email', 'ECOMMERCE', 'line');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return '''';', 'CONFIG_OPTION_pd_number', 'PHONE_NUMBER', 'ECOMMERCE', 0, 'pd_number', 'ECOMMERCE', 'line');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''GBP'';', 'CONFIG_OPTION_currency', 'CURRENCY', 'ECOMMERCE', 0, 'currency', 'ECOMMERCE', 'line');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''0'';', 'CONFIG_OPTION_ecommerce_test_mode', 'ECOMMERCE_TEST_MODE', 'ECOMMERCE', 0, 'ecommerce_test_mode', 'ECOMMERCE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return get_option(''staff_address'');', 'CONFIG_OPTION_ipn_test', 'IPN_ADDRESS_TEST', 'ECOMMERCE', 0, 'ipn_test', 'ECOMMERCE', 'line');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return get_option(''staff_address'');', 'CONFIG_OPTION_ipn', 'IPN_ADDRESS', 'ECOMMERCE', 0, 'ipn', 'ECOMMERCE', 'line');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return addon_installed(''stats_block'')?''0'':NULL;', 'CONFIG_OPTION_quiz_show_stats_count_total_open', 'QUIZZES', 'STATISTICS', 0, 'quiz_show_stats_count_total_open', 'BLOCKS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return addon_installed(''points'')?''0'':NULL;', 'CONFIG_OPTION_points_ADD_QUIZ', 'ADD_QUIZ', 'COUNT_POINTS_GIVEN', 0, 'points_ADD_QUIZ', 'POINTS', 'integer');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''0'';', 'CONFIG_OPTION_shipping_cost_factor', 'SHIPPING_COST_FACTOR', 'ECOMMERCE', 1, 'shipping_cost_factor', 'ECOMMERCE', 'float');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ''1'';', 'CONFIG_OPTION_allow_opting_out_of_tax', 'ALLOW_OPTING_OUT_OF_TAX', 'ECOMMERCE', 0, 'allow_opting_out_of_tax', 'ECOMMERCE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('Forum home', '', 1, 'return do_lang(''DEFAULT_TESTER_FORUM'');', 'CONFIG_OPTION_tester_forum_name', 'TESTER_FORUM_NAME', 'TESTER', 0, 'tester_forum_name', 'FEATURE', 'forum');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('[b]This is a bug report for the following test[/b]:\n{1}\n\n[b]Bug[/b]:\n', '', 1, 'return do_lang(''DEFAULT_BUG_REPORT_TEMPLATE'');', 'CONFIG_OPTION_bug_report_text', 'BUG_REPORT_TEXT', 'TESTER', 0, 'bug_report_text', 'FEATURE', 'text');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('0', '', 1, 'return ''0'';', 'CONFIG_OPTION_ticket_member_forums', 'TICKET_MEMBER_FORUMS', 'SUPPORT_TICKETS', 0, 'ticket_member_forums', 'FEATURE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('0', '', 1, 'return ''0'';', 'CONFIG_OPTION_ticket_type_forums', 'TICKET_TYPE_FORUMS', 'SUPPORT_TICKETS', 0, 'ticket_type_forums', 'FEATURE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('509', '', 1, 'return do_lang(''NEW_TICKET_WELCOME'');', 'CONFIG_OPTION_ticket_text', 'PAGE_TEXT', 'SUPPORT_TICKETS', 0, 'ticket_text', 'FEATURE', 'transtext');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('Website support tickets', '', 1, 'require_lang(''tickets''); return do_lang(''TICKET_FORUM_NAME'','''','''','''',get_lang());', 'CONFIG_OPTION_ticket_forum_name', 'TICKET_FORUM_NAME', 'SUPPORT_TICKETS', 0, 'ticket_forum_name', 'FEATURE', 'forum');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return strval(filemtime(get_file_base().''/index.php''));', 'CONFIG_OPTION_leaderboard_start_date', 'LEADERBOARD_START_DATE', 'POINT_LEADERBOARD', 0, 'leaderboard_start_date', 'POINTS', 'date');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('1', '', 1, 'return ''1'';', 'CONFIG_OPTION_is_on_rss', 'ENABLE_RSS', 'NEWS_AND_RSS', 0, 'is_on_rss', 'FEATURE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('60', '', 1, 'return ''60'';', 'CONFIG_OPTION_rss_update_time', 'UPDATE_TIME', 'NEWS_AND_RSS', 0, 'rss_update_time', 'FEATURE', 'integer');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('0', '', 1, 'return ''0'';', 'CONFIG_OPTION_is_rss_advertised', 'ENABLE_RSS_ADVERTISING', 'NEWS_AND_RSS', 0, 'is_rss_advertised', 'FEATURE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return get_base_url().''/netlink.php'';', 'CONFIG_OPTION_network_links', 'NETWORK_LINKS', 'ENVIRONMENT', 1, 'network_links', 'SITE', 'line');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return addon_installed(''stats_block'')?''1'':NULL;', 'CONFIG_OPTION_forum_show_stats_count_members', 'COUNT_MEMBERS', 'STATISTICS', 0, 'forum_show_stats_count_members', 'BLOCKS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return addon_installed(''stats_block'')?''1'':NULL;', 'CONFIG_OPTION_forum_show_stats_count_topics', 'COUNT_TOPICS', 'STATISTICS', 0, 'forum_show_stats_count_topics', 'BLOCKS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return addon_installed(''stats_block'')?''1'':NULL;', 'CONFIG_OPTION_forum_show_stats_count_posts', 'COUNT_POSTS', 'STATISTICS', 0, 'forum_show_stats_count_posts', 'BLOCKS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return addon_installed(''stats_block'')?''0'':NULL;', 'CONFIG_OPTION_forum_show_stats_count_posts_today', 'COUNT_POSTSTODAY', 'STATISTICS', 0, 'forum_show_stats_count_posts_today', 'BLOCKS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return addon_installed(''stats_block'')?''0'':NULL;', 'CONFIG_OPTION_activity_show_stats_count_users_online', 'COUNT_ONSITE', 'STATISTICS', 0, 'activity_show_stats_count_users_online', 'BLOCKS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return addon_installed(''stats_block'')?''0'':NULL;', 'CONFIG_OPTION_activity_show_stats_count_users_online_record', 'COUNT_ONSITE_RECORD', 'STATISTICS', 0, 'activity_show_stats_count_users_online_record', 'BLOCKS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ((get_forum_type()!=''ocf'') && (addon_installed(''stats_block'')))?''0'':NULL;', 'CONFIG_OPTION_activity_show_stats_count_users_online_forum', 'COUNT_ONFORUMS', 'STATISTICS', 0, 'activity_show_stats_count_users_online_forum', 'BLOCKS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return addon_installed(''stats_block'')?''0'':NULL;', 'CONFIG_OPTION_activity_show_stats_count_page_views_today', 'PAGE_VIEWS_TODAY', 'STATISTICS', 0, 'activity_show_stats_count_page_views_today', 'BLOCKS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return addon_installed(''stats_block'')?''0'':NULL;', 'CONFIG_OPTION_activity_show_stats_count_page_views_this_week', 'PAGE_VIEWS_THIS_WEEK', 'STATISTICS', 0, 'activity_show_stats_count_page_views_this_week', 'BLOCKS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return addon_installed(''stats_block'')?''0'':NULL;', 'CONFIG_OPTION_activity_show_stats_count_page_views_this_month', 'PAGE_VIEWS_THIS_MONTH', 'STATISTICS', 0, 'activity_show_stats_count_page_views_this_month', 'BLOCKS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ((get_forum_type()==''ocf'') && (!has_no_forum()) && (addon_installed(''stats_block'')))?''0'':NULL;', 'CONFIG_OPTION_forum_show_stats_count_members_active_today', 'MEMBERS_ACTIVE_TODAY', 'STATISTICS', 0, 'forum_show_stats_count_members_active_today', 'BLOCKS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ((get_forum_type()==''ocf'') && (!has_no_forum()) && (addon_installed(''stats_block'')))?''0'':NULL;', 'CONFIG_OPTION_forum_show_stats_count_members_active_this_week', 'MEMBERS_ACTIVE_THIS_WEEK', 'STATISTICS', 0, 'forum_show_stats_count_members_active_this_week', 'BLOCKS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ((get_forum_type()==''ocf'') && (!has_no_forum()) && (addon_installed(''stats_block'')))?''0'':NULL;', 'CONFIG_OPTION_forum_show_stats_count_members_active_this_month', 'MEMBERS_ACTIVE_THIS_MONTH', 'STATISTICS', 0, 'forum_show_stats_count_members_active_this_month', 'BLOCKS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ((get_forum_type()==''ocf'') && (!has_no_forum()) && (addon_installed(''stats_block'')))?''0'':NULL;', 'CONFIG_OPTION_forum_show_stats_count_members_new_today', 'MEMBERS_NEW_TODAY', 'STATISTICS', 0, 'forum_show_stats_count_members_new_today', 'BLOCKS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ((get_forum_type()==''ocf'') && (!has_no_forum()) && (addon_installed(''stats_block'')))?''0'':NULL;', 'CONFIG_OPTION_forum_show_stats_count_members_new_this_week', 'MEMBERS_NEW_THIS_WEEK', 'STATISTICS', 0, 'forum_show_stats_count_members_new_this_week', 'BLOCKS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ((get_forum_type()==''ocf'') && (!has_no_forum()) && (addon_installed(''stats_block'')))?''0'':NULL;', 'CONFIG_OPTION_forum_show_stats_count_members_new_this_month', 'MEMBERS_NEW_THIS_MONTH', 'STATISTICS', 0, 'forum_show_stats_count_members_new_this_month', 'BLOCKS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ((has_no_forum()) || (get_forum_type()!=''ocf''))?NULL:''0'';', 'CONFIG_OPTION_usersonline_show_newest_member', 'SHOW_NEWEST_MEMBER', 'USERS_ONLINE_BLOCK', 0, 'usersonline_show_newest_member', 'BLOCKS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return ((has_no_forum()) || (get_forum_type()!=''ocf''))?NULL:''0'';', 'CONFIG_OPTION_usersonline_show_birthdays', 'BIRTHDAYS', 'USERS_ONLINE_BLOCK', 0, 'usersonline_show_birthdays', 'BLOCKS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return addon_installed(''points'')?''350'':NULL;', 'CONFIG_OPTION_points_RECOMMEND_SITE', 'RECOMMEND_SITE', 'COUNT_POINTS_GIVEN', 0, 'points_RECOMMEND_SITE', 'POINTS', 'integer');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return addon_installed(''stats_block'')?''0'':NULL;', 'CONFIG_OPTION_filedump_show_stats_count_total_files', 'FILEDUMP_COUNT_FILES', 'STATISTICS', 0, 'filedump_show_stats_count_total_files', 'BLOCKS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return addon_installed(''stats_block'')?''0'':NULL;', 'CONFIG_OPTION_filedump_show_stats_count_total_space', 'FILEDUMP_DISK_USAGE', 'STATISTICS', 0, 'filedump_show_stats_count_total_space', 'BLOCKS', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return do_lang(''SUPERMEMBERS_TEXT'');', 'CONFIG_OPTION_supermembers_text', 'PAGE_TEXT', 'SUPER_MEMBERS', 0, 'supermembers_text', 'SECURITY', 'transtext');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('0', '', 1, 'return ''0'';', 'CONFIG_OPTION_is_on_sms', 'ENABLED', 'SMS', 0, 'is_on_sms', 'FEATURE', 'tick');
INSERT INTO `ocp_config` (`config_value`, `c_data`, `c_set`, `eval`, `explanation`, `human_name`, `section`, `shared_hosting_restricted`, `the_name`, `the_page`, `the_type`) VALUES('', '', 0, 'return '''';', 'CONFIG_OPTION_backup_server_hostname', 'BACKUP_SERVER_HOSTNAME', 'BACKUP', 0, 'backup_server_hostname', 'FEATURE', 'line');

-- --------------------------------------------------------

--
-- Table structure for table `ocp_custom_comcode`
--

DROP TABLE IF EXISTS `ocp_custom_comcode`;
CREATE TABLE IF NOT EXISTS `ocp_custom_comcode` (
  `tag_block_tag` tinyint(1) NOT NULL,
  `tag_dangerous_tag` tinyint(1) NOT NULL,
  `tag_description` int(10) unsigned NOT NULL,
  `tag_enabled` tinyint(1) NOT NULL,
  `tag_example` longtext NOT NULL,
  `tag_parameters` varchar(255) NOT NULL,
  `tag_replace` longtext NOT NULL,
  `tag_tag` varchar(80) NOT NULL,
  `tag_textual_tag` tinyint(1) NOT NULL,
  `tag_title` int(10) unsigned NOT NULL,
  PRIMARY KEY (`tag_tag`)
) ENGINE=MyISAM;

--
-- Dumping data for table `ocp_custom_comcode`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_db_meta`
--

DROP TABLE IF EXISTS `ocp_db_meta`;
CREATE TABLE IF NOT EXISTS `ocp_db_meta` (
  `m_table` varchar(80) NOT NULL,
  `m_name` varchar(80) NOT NULL,
  `m_type` varchar(80) NOT NULL,
  PRIMARY KEY (`m_table`,`m_name`)
) ENGINE=MyISAM;

--
-- Dumping data for table `ocp_db_meta`
--

INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('addons', 'addon_author', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('addons', 'addon_description', 'LONG_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('addons', 'addon_install_time', 'TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('addons', 'addon_name', '*SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('addons', 'addon_organisation', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('addons', 'addon_version', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('addons_dependencies', 'addon_name', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('addons_dependencies', 'addon_name_dependant_upon', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('addons_dependencies', 'addon_name_incompatibility', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('addons_dependencies', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('addons_files', 'addon_name', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('addons_files', 'filename', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('addons_files', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('adminlogs', 'date_and_time', 'TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('adminlogs', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('adminlogs', 'ip', 'IP');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('adminlogs', 'param_a', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('adminlogs', 'param_b', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('adminlogs', 'the_type', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('adminlogs', 'the_user', 'USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('attachments', 'a_add_time', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('attachments', 'a_description', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('attachments', 'a_file_size', '?INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('attachments', 'a_last_downloaded_time', '?INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('attachments', 'a_member_id', 'USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('attachments', 'a_num_downloads', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('attachments', 'a_original_filename', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('attachments', 'a_thumb_url', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('attachments', 'a_url', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('attachments', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('attachment_refs', 'a_id', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('attachment_refs', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('attachment_refs', 'r_referer_id', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('attachment_refs', 'r_referer_type', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('authors', 'author', '*ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('authors', 'description', 'LONG_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('authors', 'forum_handle', '?USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('authors', 'skills', 'LONG_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('authors', 'url', 'URLPATH');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('autosave', 'a_key', 'LONG_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('autosave', 'a_member_id', 'USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('autosave', 'a_time', 'TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('autosave', 'a_value', 'LONG_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('autosave', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('award_archive', 'a_type_id', '*AUTO_LINK');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('award_archive', 'content_id', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('award_archive', 'date_and_time', '*TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('award_archive', 'member_id', 'USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('award_types', 'a_content_type', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('award_types', 'a_description', 'LONG_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('award_types', 'a_hide_awardee', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('award_types', 'a_points', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('award_types', 'a_title', 'SHORT_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('award_types', 'a_update_time_hours', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('award_types', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('banners', 'add_date', 'TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('banners', 'b_title_text', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('banners', 'b_type', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('banners', 'campaign_remaining', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('banners', 'caption', 'SHORT_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('banners', 'edit_date', '?TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('banners', 'expiry_date', '?TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('banners', 'hits_from', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('banners', 'hits_to', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('banners', 'img_url', 'URLPATH');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('banners', 'importance_modulus', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('banners', 'name', '*ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('banners', 'notes', 'LONG_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('banners', 'site_url', 'URLPATH');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('banners', 'submitter', 'USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('banners', 'the_type', 'SHORT_INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('banners', 'validated', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('banners', 'views_from', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('banners', 'views_to', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('banner_clicks', 'c_banner_id', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('banner_clicks', 'c_date_and_time', 'TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('banner_clicks', 'c_ip_address', 'IP');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('banner_clicks', 'c_member_id', 'USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('banner_clicks', 'c_source', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('banner_clicks', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('banner_types', 'id', '*ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('banner_types', 't_comcode_inline', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('banner_types', 't_image_height', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('banner_types', 't_image_width', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('banner_types', 't_is_textual', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('banner_types', 't_max_file_size', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('blocks', 'block_author', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('blocks', 'block_hacked_by', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('blocks', 'block_hack_version', '?INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('blocks', 'block_name', '*ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('blocks', 'block_organisation', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('blocks', 'block_version', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('bookmarks', 'b_folder', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('bookmarks', 'b_owner', 'USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('bookmarks', 'b_page_link', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('bookmarks', 'b_title', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('bookmarks', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('cache', 'cached_for', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('cache', 'date_and_time', 'TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('cache', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('cache', 'identifier', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('cache', 'lang', 'LANGUAGE_NAME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('cache', 'langs_required', 'LONG_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('cache', 'the_theme', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('cache', 'the_value', 'LONG_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('cached_comcode_pages', 'cc_page_title', '?SHORT_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('cached_comcode_pages', 'string_index', 'LONG_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('cached_comcode_pages', 'the_page', '*ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('cached_comcode_pages', 'the_theme', '*ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('cached_comcode_pages', 'the_zone', '*ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('cache_on', 'cached_for', '*ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('cache_on', 'cache_on', 'LONG_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('cache_on', 'cache_ttl', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('calendar_events', 'allow_comments', 'SHORT_INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('calendar_events', 'allow_rating', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('calendar_events', 'allow_trackbacks', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('calendar_events', 'e_add_date', 'TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('calendar_events', 'e_content', 'LONG_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('calendar_events', 'e_edit_date', '?TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('calendar_events', 'e_end_day', '?INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('calendar_events', 'e_end_hour', '?INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('calendar_events', 'e_end_minute', '?INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('calendar_events', 'e_end_month', '?INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('calendar_events', 'e_end_year', '?INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('calendar_events', 'e_geo_position', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('calendar_events', 'e_groups_access', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('calendar_events', 'e_groups_modify', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('calendar_events', 'e_is_public', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('calendar_events', 'e_priority', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('calendar_events', 'e_recurrence', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('calendar_events', 'e_recurrences', '?INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('calendar_events', 'e_seg_recurrences', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('calendar_events', 'e_start_day', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('calendar_events', 'e_start_hour', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('calendar_events', 'e_start_minute', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('calendar_events', 'e_start_month', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('calendar_events', 'e_start_year', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('calendar_events', 'e_submitter', 'USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('calendar_events', 'e_title', 'SHORT_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('calendar_events', 'e_type', 'AUTO_LINK');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('calendar_events', 'e_views', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('calendar_events', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('calendar_events', 'notes', 'LONG_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('calendar_events', 'validated', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('calendar_interests', 'i_member_id', '*USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('calendar_interests', 't_type', '*AUTO_LINK');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('calendar_jobs', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('calendar_jobs', 'j_event_id', 'AUTO_LINK');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('calendar_jobs', 'j_member_id', '?USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('calendar_jobs', 'j_reminder_id', '?AUTO_LINK');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('calendar_jobs', 'j_time', 'TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('calendar_reminders', 'e_id', 'AUTO_LINK');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('calendar_reminders', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('calendar_reminders', 'n_member_id', 'USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('calendar_reminders', 'n_seconds_before', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('calendar_types', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('calendar_types', 't_logo', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('calendar_types', 't_title', 'SHORT_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('catalogues', 'c_add_date', 'TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('catalogues', 'c_description', 'LONG_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('catalogues', 'c_display_type', 'SHORT_INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('catalogues', 'c_ecommerce', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('catalogues', 'c_is_tree', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('catalogues', 'c_name', '*ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('catalogues', 'c_notes', 'LONG_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('catalogues', 'c_send_view_reports', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('catalogues', 'c_submit_points', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('catalogues', 'c_title', 'SHORT_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('catalogue_categories', 'cc_add_date', 'TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('catalogue_categories', 'cc_description', 'LONG_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('catalogue_categories', 'cc_move_days_higher', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('catalogue_categories', 'cc_move_days_lower', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('catalogue_categories', 'cc_move_target', '?AUTO_LINK');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('catalogue_categories', 'cc_notes', 'LONG_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('catalogue_categories', 'cc_parent_id', '?AUTO_LINK');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('catalogue_categories', 'cc_title', 'SHORT_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('catalogue_categories', 'c_name', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('catalogue_categories', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('catalogue_categories', 'rep_image', 'URLPATH');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('catalogue_efv_long', 'ce_id', 'AUTO_LINK');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('catalogue_efv_long', 'cf_id', 'AUTO_LINK');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('catalogue_efv_long', 'cv_value', 'LONG_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('catalogue_efv_long', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('catalogue_efv_long_trans', 'ce_id', 'AUTO_LINK');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('catalogue_efv_long_trans', 'cf_id', 'AUTO_LINK');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('catalogue_efv_long_trans', 'cv_value', 'LONG_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('catalogue_efv_long_trans', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('catalogue_efv_short', 'ce_id', 'AUTO_LINK');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('catalogue_efv_short', 'cf_id', 'AUTO_LINK');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('catalogue_efv_short', 'cv_value', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('catalogue_efv_short', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('catalogue_efv_short_trans', 'ce_id', 'AUTO_LINK');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('catalogue_efv_short_trans', 'cf_id', 'AUTO_LINK');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('catalogue_efv_short_trans', 'cv_value', 'SHORT_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('catalogue_efv_short_trans', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('catalogue_entries', 'allow_comments', 'SHORT_INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('catalogue_entries', 'allow_rating', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('catalogue_entries', 'allow_trackbacks', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('catalogue_entries', 'cc_id', 'AUTO_LINK');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('catalogue_entries', 'ce_add_date', 'TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('catalogue_entries', 'ce_edit_date', '?TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('catalogue_entries', 'ce_last_moved', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('catalogue_entries', 'ce_submitter', 'USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('catalogue_entries', 'ce_validated', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('catalogue_entries', 'ce_views', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('catalogue_entries', 'ce_views_prior', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('catalogue_entries', 'c_name', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('catalogue_entries', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('catalogue_entries', 'notes', 'LONG_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('catalogue_fields', 'cf_default', 'LONG_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('catalogue_fields', 'cf_defines_order', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('catalogue_fields', 'cf_description', 'LONG_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('catalogue_fields', 'cf_name', 'SHORT_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('catalogue_fields', 'cf_order', 'SHORT_INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('catalogue_fields', 'cf_put_in_category', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('catalogue_fields', 'cf_put_in_search', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('catalogue_fields', 'cf_required', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('catalogue_fields', 'cf_searchable', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('catalogue_fields', 'cf_type', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('catalogue_fields', 'cf_visible', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('catalogue_fields', 'c_name', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('catalogue_fields', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('chargelog', 'amount', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('chargelog', 'date_and_time', 'TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('chargelog', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('chargelog', 'reason', 'SHORT_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('chargelog', 'user_id', 'USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('chat_active', 'date_and_time', 'TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('chat_active', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('chat_active', 'member_id', 'USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('chat_active', 'room_id', '?AUTO_LINK');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('chat_blocking', 'date_and_time', 'TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('chat_blocking', 'member_blocked', '*USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('chat_blocking', 'member_blocker', '*USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('chat_buddies', 'date_and_time', 'TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('chat_buddies', 'member_liked', '*USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('chat_buddies', 'member_likes', '*USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('chat_events', 'e_date_and_time', 'TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('chat_events', 'e_member_id', 'USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('chat_events', 'e_room_id', '?AUTO_LINK');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('chat_events', 'e_type_code', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('chat_events', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('chat_messages', 'date_and_time', 'TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('chat_messages', 'font_name', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('chat_messages', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('chat_messages', 'ip_address', 'IP');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('chat_messages', 'room_id', 'AUTO_LINK');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('chat_messages', 'system_message', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('chat_messages', 'text_colour', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('chat_messages', 'the_message', 'LONG_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('chat_messages', 'user_id', 'USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('chat_rooms', 'allow_list', 'LONG_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('chat_rooms', 'allow_list_groups', 'LONG_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('chat_rooms', 'c_welcome', 'LONG_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('chat_rooms', 'disallow_list', 'LONG_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('chat_rooms', 'disallow_list_groups', 'LONG_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('chat_rooms', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('chat_rooms', 'is_im', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('chat_rooms', 'room_language', 'LANGUAGE_NAME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('chat_rooms', 'room_name', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('chat_rooms', 'room_owner', '?INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('chat_sound_effects', 's_effect_id', '*ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('chat_sound_effects', 's_member', '*USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('chat_sound_effects', 's_url', 'URLPATH');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('comcode_pages', 'p_add_date', 'TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('comcode_pages', 'p_edit_date', '?TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('comcode_pages', 'p_parent_page', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('comcode_pages', 'p_show_as_edit', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('comcode_pages', 'p_submitter', 'USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('comcode_pages', 'p_validated', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('comcode_pages', 'the_page', '*ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('comcode_pages', 'the_zone', '*ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('config', 'config_value', 'LONG_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('config', 'c_data', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('config', 'c_set', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('config', 'eval', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('config', 'explanation', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('config', 'human_name', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('config', 'section', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('config', 'shared_hosting_restricted', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('config', 'the_name', '*ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('config', 'the_page', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('config', 'the_type', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('custom_comcode', 'tag_block_tag', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('custom_comcode', 'tag_dangerous_tag', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('custom_comcode', 'tag_description', 'SHORT_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('custom_comcode', 'tag_enabled', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('custom_comcode', 'tag_example', 'LONG_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('custom_comcode', 'tag_parameters', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('custom_comcode', 'tag_replace', 'LONG_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('custom_comcode', 'tag_tag', '*ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('custom_comcode', 'tag_textual_tag', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('custom_comcode', 'tag_title', 'SHORT_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('download_categories', 'add_date', 'TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('download_categories', 'category', 'SHORT_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('download_categories', 'description', 'LONG_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('download_categories', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('download_categories', 'notes', 'LONG_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('download_categories', 'parent_id', '?AUTO_LINK');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('download_categories', 'rep_image', 'URLPATH');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('download_downloads', 'add_date', 'TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('download_downloads', 'allow_comments', 'SHORT_INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('download_downloads', 'allow_rating', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('download_downloads', 'allow_trackbacks', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('download_downloads', 'author', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('download_downloads', 'category_id', 'AUTO_LINK');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('download_downloads', 'comments', 'LONG_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('download_downloads', 'default_pic', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('download_downloads', 'description', 'LONG_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('download_downloads', 'download_cost', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('download_downloads', 'download_data_mash', 'LONG_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('download_downloads', 'download_licence', '?AUTO_LINK');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('download_downloads', 'download_submitter_gets_points', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('download_downloads', 'download_views', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('download_downloads', 'edit_date', '?TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('download_downloads', 'file_size', '?INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('download_downloads', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('download_downloads', 'name', 'SHORT_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('download_downloads', 'notes', 'LONG_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('download_downloads', 'num_downloads', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('download_downloads', 'original_filename', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('download_downloads', 'out_mode_id', '?AUTO_LINK');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('download_downloads', 'rep_image', 'URLPATH');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('download_downloads', 'submitter', 'USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('download_downloads', 'url', 'URLPATH');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('download_downloads', 'validated', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('download_licences', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('download_licences', 'l_text', 'LONG_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('download_licences', 'l_title', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('download_logging', 'date_and_time', 'TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('download_logging', 'id', '*AUTO_LINK');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('download_logging', 'ip', 'IP');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('download_logging', 'the_user', '*USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('edit_pings', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('edit_pings', 'the_id', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('edit_pings', 'the_member', 'USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('edit_pings', 'the_page', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('edit_pings', 'the_time', 'TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('edit_pings', 'the_type', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('failedlogins', 'date_and_time', 'TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('failedlogins', 'failed_account', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('failedlogins', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('failedlogins', 'ip', 'IP');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('filedump', 'description', 'SHORT_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('filedump', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('filedump', 'name', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('filedump', 'path', 'URLPATH');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('filedump', 'the_member', 'USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_categories', 'c_description', 'LONG_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_categories', 'c_expanded_by_default', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_categories', 'c_title', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_categories', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_custom_fields', 'cf_default', 'LONG_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_custom_fields', 'cf_description', 'SHORT_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_custom_fields', 'cf_encrypted', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_custom_fields', 'cf_locked', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_custom_fields', 'cf_name', 'SHORT_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_custom_fields', 'cf_only_group', 'LONG_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_custom_fields', 'cf_order', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_custom_fields', 'cf_owner_set', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_custom_fields', 'cf_owner_view', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_custom_fields', 'cf_public_view', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_custom_fields', 'cf_required', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_custom_fields', 'cf_show_in_posts', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_custom_fields', 'cf_show_in_post_previews', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_custom_fields', 'cf_type', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_custom_fields', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_emoticons', 'e_code', '*SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_emoticons', 'e_is_special', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_emoticons', 'e_relevance_level', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_emoticons', 'e_theme_img_code', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_emoticons', 'e_use_topics', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_forums', 'f_cache_last_forum_id', '?AUTO_LINK');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_forums', 'f_cache_last_member_id', '?USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_forums', 'f_cache_last_time', '?TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_forums', 'f_cache_last_title', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_forums', 'f_cache_last_topic_id', '?AUTO_LINK');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_forums', 'f_cache_last_username', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_forums', 'f_cache_num_posts', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_forums', 'f_cache_num_topics', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_forums', 'f_category_id', '?AUTO_LINK');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_forums', 'f_description', 'LONG_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_forums', 'f_intro_answer', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_forums', 'f_intro_question', 'LONG_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_forums', 'f_name', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_forums', 'f_order', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_forums', 'f_order_sub_alpha', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_forums', 'f_parent_forum', '?AUTO_LINK');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_forums', 'f_position', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_forums', 'f_post_count_increment', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_forums', 'f_redirection', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_forums', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_forum_intro_ip', 'i_forum_id', '*AUTO_LINK');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_forum_intro_ip', 'i_ip', '*IP');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_forum_intro_member', 'i_forum_id', '*AUTO_LINK');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_forum_intro_member', 'i_member_id', '*USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_forum_tracking', 'r_forum_id', '*AUTO_LINK');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_forum_tracking', 'r_member_id', '*USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_groups', 'g_enquire_on_new_ips', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_groups', 'g_flood_control_access_secs', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_groups', 'g_flood_control_submit_secs', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_groups', 'g_gift_points_base', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_groups', 'g_gift_points_per_day', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_groups', 'g_group_leader', '?USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_groups', 'g_hidden', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_groups', 'g_is_default', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_groups', 'g_is_presented_at_install', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_groups', 'g_is_private_club', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_groups', 'g_is_super_admin', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_groups', 'g_is_super_moderator', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_groups', 'g_max_attachments_per_post', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_groups', 'g_max_avatar_height', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_groups', 'g_max_avatar_width', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_groups', 'g_max_daily_upload_mb', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_groups', 'g_max_post_length_comcode', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_groups', 'g_max_sig_length_comcode', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_groups', 'g_name', 'SHORT_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_groups', 'g_open_membership', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_groups', 'g_order', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_groups', 'g_promotion_target', '?GROUP');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_groups', 'g_promotion_threshold', '?INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_groups', 'g_rank_image', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_groups', 'g_rank_image_pri_only', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_groups', 'g_title', 'SHORT_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_groups', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_group_members', 'gm_group_id', '*GROUP');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_group_members', 'gm_member_id', '*USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_group_members', 'gm_validated', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_invites', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_invites', 'i_email_address', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_invites', 'i_inviter', 'USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_invites', 'i_taken', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_invites', 'i_time', 'TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_members', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_members', 'm_allow_emails', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_members', 'm_avatar_url', 'URLPATH');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_members', 'm_cache_num_posts', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_members', 'm_cache_warnings', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_members', 'm_dob_day', '?INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_members', 'm_dob_month', '?INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_members', 'm_dob_year', '?INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_members', 'm_email_address', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_members', 'm_highlighted_name', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_members', 'm_ip_address', 'IP');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_members', 'm_is_perm_banned', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_members', 'm_join_time', 'TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_members', 'm_language', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_members', 'm_last_submit_time', 'TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_members', 'm_last_visit_time', 'TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_members', 'm_max_email_attach_size_mb', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_members', 'm_notes', 'LONG_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_members', 'm_on_probation_until', '?TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_members', 'm_password_change_code', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_members', 'm_password_compat_scheme', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_members', 'm_pass_hash_salted', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_members', 'm_pass_salt', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_members', 'm_photo_thumb_url', 'URLPATH');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_members', 'm_photo_url', 'URLPATH');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_members', 'm_preview_posts', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_members', 'm_primary_group', 'GROUP');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_members', 'm_pt_allow', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_members', 'm_pt_rules_text', 'LONG_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_members', 'm_reveal_age', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_members', 'm_signature', 'LONG_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_members', 'm_theme', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_members', 'm_timezone_offset', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_members', 'm_title', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_members', 'm_track_contributed_topics', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_members', 'm_username', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_members', 'm_validated', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_members', 'm_validated_email_confirm_code', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_members', 'm_views_signatures', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_members', 'm_zone_wide', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_member_cpf_perms', 'field_id', '*AUTO_LINK');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_member_cpf_perms', 'friend_view', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_member_cpf_perms', 'group_view', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_member_cpf_perms', 'guest_view', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_member_cpf_perms', 'member_id', '*USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_member_cpf_perms', 'member_view', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_member_custom_fields', 'field_1', '?LONG_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_member_custom_fields', 'field_10', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_member_custom_fields', 'field_11', '?INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_member_custom_fields', 'field_12', '?INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_member_custom_fields', 'field_13', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_member_custom_fields', 'field_14', 'LONG_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_member_custom_fields', 'field_15', 'LONG_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_member_custom_fields', 'field_16', '?INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_member_custom_fields', 'field_17', 'LONG_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_member_custom_fields', 'field_18', 'LONG_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_member_custom_fields', 'field_19', 'LONG_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_member_custom_fields', 'field_2', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_member_custom_fields', 'field_20', 'LONG_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_member_custom_fields', 'field_21', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_member_custom_fields', 'field_22', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_member_custom_fields', 'field_23', 'LONG_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_member_custom_fields', 'field_24', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_member_custom_fields', 'field_25', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_member_custom_fields', 'field_26', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_member_custom_fields', 'field_27', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_member_custom_fields', 'field_28', '?INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_member_custom_fields', 'field_29', '?INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_member_custom_fields', 'field_3', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_member_custom_fields', 'field_30', '?INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_member_custom_fields', 'field_31', '?INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_member_custom_fields', 'field_32', '?INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_member_custom_fields', 'field_33', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_member_custom_fields', 'field_34', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_member_custom_fields', 'field_35', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_member_custom_fields', 'field_4', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_member_custom_fields', 'field_5', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_member_custom_fields', 'field_6', '?LONG_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_member_custom_fields', 'field_7', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_member_custom_fields', 'field_8', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_member_custom_fields', 'field_9', '?LONG_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_member_custom_fields', 'mf_member_id', '*USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_member_known_login_ips', 'i_ip', '*IP');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_member_known_login_ips', 'i_member_id', '*USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_member_known_login_ips', 'i_val_code', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_moderator_logs', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_moderator_logs', 'l_by', 'USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_moderator_logs', 'l_date_and_time', 'TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_moderator_logs', 'l_param_a', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_moderator_logs', 'l_param_b', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_moderator_logs', 'l_reason', 'LONG_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_moderator_logs', 'l_the_type', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_multi_moderations', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_multi_moderations', 'mm_forum_multi_code', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_multi_moderations', 'mm_move_to', '?INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_multi_moderations', 'mm_name', '*SHORT_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_multi_moderations', 'mm_open_state', '?BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_multi_moderations', 'mm_pin_state', '?BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_multi_moderations', 'mm_post_text', 'LONG_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_multi_moderations', 'mm_sink_state', '?BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_multi_moderations', 'mm_title_suffix', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_polls', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_polls', 'po_cache_total_votes', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_polls', 'po_is_open', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_polls', 'po_is_private', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_polls', 'po_maximum_selections', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_polls', 'po_minimum_selections', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_polls', 'po_question', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_polls', 'po_requires_reply', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_poll_answers', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_poll_answers', 'pa_answer', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_poll_answers', 'pa_cache_num_votes', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_poll_answers', 'pa_poll_id', 'AUTO_LINK');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_poll_votes', 'pv_answer_id', '*AUTO_LINK');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_poll_votes', 'pv_member_id', '*USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_poll_votes', 'pv_poll_id', '*AUTO_LINK');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_posts', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_posts', 'p_cache_forum_id', '?AUTO_LINK');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_posts', 'p_intended_solely_for', '?USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_posts', 'p_ip_address', 'IP');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_posts', 'p_is_emphasised', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_posts', 'p_last_edit_by', '?USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_posts', 'p_last_edit_time', '?TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_posts', 'p_post', 'LONG_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_posts', 'p_poster', 'USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_posts', 'p_poster_name_if_guest', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_posts', 'p_skip_sig', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_posts', 'p_time', 'TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_posts', 'p_title', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_posts', 'p_topic_id', 'AUTO_LINK');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_posts', 'p_validated', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_post_history', 'h_action', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_post_history', 'h_action_date_and_time', 'TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_post_history', 'h_alterer_member_id', 'USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_post_history', 'h_before', 'LONG_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_post_history', 'h_create_date_and_time', 'TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_post_history', 'h_owner_member_id', 'USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_post_history', 'h_post_id', 'AUTO_LINK');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_post_history', 'h_topic_id', 'AUTO_LINK');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_post_history', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_post_templates', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_post_templates', 't_forum_multi_code', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_post_templates', 't_text', 'LONG_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_post_templates', 't_title', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_post_templates', 't_use_default_forums', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_read_logs', 'l_member_id', '*USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_read_logs', 'l_time', 'TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_read_logs', 'l_topic_id', '*AUTO_LINK');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_saved_warnings', 's_explanation', 'LONG_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_saved_warnings', 's_message', 'LONG_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_saved_warnings', 's_title', '*SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_special_pt_access', 's_member_id', '*USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_special_pt_access', 's_topic_id', '*AUTO_LINK');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_topics', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_topics', 't_cache_first_member_id', '?USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_topics', 't_cache_first_post', '?LONG_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_topics', 't_cache_first_post_id', '?AUTO_LINK');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_topics', 't_cache_first_time', '?TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_topics', 't_cache_first_title', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_topics', 't_cache_first_username', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_topics', 't_cache_last_member_id', '?USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_topics', 't_cache_last_post_id', '?AUTO_LINK');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_topics', 't_cache_last_time', '?TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_topics', 't_cache_last_title', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_topics', 't_cache_last_username', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_topics', 't_cache_num_posts', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_topics', 't_cascading', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_topics', 't_description', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_topics', 't_description_link', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_topics', 't_emoticon', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_topics', 't_forum_id', '?AUTO_LINK');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_topics', 't_is_open', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_topics', 't_num_views', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_topics', 't_pinned', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_topics', 't_poll_id', '?AUTO_LINK');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_topics', 't_pt_from', '?USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_topics', 't_pt_from_category', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_topics', 't_pt_to', '?USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_topics', 't_pt_to_category', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_topics', 't_sunk', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_topics', 't_validated', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_topic_tracking', 'r_last_message_time', 'TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_topic_tracking', 'r_member_id', '*USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_topic_tracking', 'r_topic_id', '*AUTO_LINK');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_usergroup_subs', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_usergroup_subs', 's_cost', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_usergroup_subs', 's_description', 'LONG_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_usergroup_subs', 's_enabled', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_usergroup_subs', 's_group_id', 'GROUP');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_usergroup_subs', 's_length', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_usergroup_subs', 's_length_units', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_usergroup_subs', 's_mail_end', 'LONG_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_usergroup_subs', 's_mail_start', 'LONG_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_usergroup_subs', 's_mail_uhoh', 'LONG_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_usergroup_subs', 's_title', 'SHORT_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_usergroup_subs', 's_uses_primary', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_warnings', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_warnings', 'p_banned_ip', 'IP');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_warnings', 'p_banned_member', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_warnings', 'p_changed_usergroup_from', '?GROUP');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_warnings', 'p_charged_points', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_warnings', 'p_probation', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_warnings', 'p_silence_from_forum', '?AUTO_LINK');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_warnings', 'p_silence_from_topic', '?AUTO_LINK');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_warnings', 'w_by', 'USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_warnings', 'w_explanation', 'LONG_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_warnings', 'w_is_warning', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_warnings', 'w_member_id', 'USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_warnings', 'w_time', 'TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_welcome_emails', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_welcome_emails', 'w_name', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_welcome_emails', 'w_newsletter', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_welcome_emails', 'w_send_time', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_welcome_emails', 'w_subject', 'SHORT_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('f_welcome_emails', 'w_text', 'LONG_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('galleries', 'accept_images', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('galleries', 'accept_videos', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('galleries', 'add_date', 'TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('galleries', 'allow_comments', 'SHORT_INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('galleries', 'allow_rating', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('galleries', 'description', 'LONG_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('galleries', 'flow_mode_interface', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('galleries', 'fullname', 'SHORT_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('galleries', 'is_member_synched', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('galleries', 'name', '*ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('galleries', 'notes', 'LONG_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('galleries', 'parent_id', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('galleries', 'rep_image', 'URLPATH');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('galleries', 'teaser', 'SHORT_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('galleries', 'watermark_bottom_left', 'URLPATH');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('galleries', 'watermark_bottom_right', 'URLPATH');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('galleries', 'watermark_top_left', 'URLPATH');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('galleries', 'watermark_top_right', 'URLPATH');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('gifts', 'amount', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('gifts', 'anonymous', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('gifts', 'date_and_time', 'TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('gifts', 'gift_from', 'USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('gifts', 'gift_to', 'USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('gifts', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('gifts', 'reason', 'SHORT_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('group_category_access', 'category_name', '*ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('group_category_access', 'group_id', '*GROUP');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('group_category_access', 'module_the_name', '*ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('group_page_access', 'group_id', '*GROUP');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('group_page_access', 'page_name', '*ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('group_page_access', 'zone_name', '*ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('group_zone_access', 'group_id', '*GROUP');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('group_zone_access', 'zone_name', '*ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('gsp', 'category_name', '*ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('gsp', 'group_id', '*INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('gsp', 'module_the_name', '*ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('gsp', 'specific_permission', '*ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('gsp', 'the_page', '*ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('gsp', 'the_value', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('hackattack', 'data_post', 'LONG_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('hackattack', 'date_and_time', 'TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('hackattack', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('hackattack', 'ip', 'IP');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('hackattack', 'reason', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('hackattack', 'reason_param_a', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('hackattack', 'reason_param_b', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('hackattack', 'referer', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('hackattack', 'the_user', 'USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('hackattack', 'url', 'URLPATH');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('hackattack', 'user_agent', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('hackattack', 'user_os', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('https_pages', 'https_page_name', '*ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('images', 'add_date', 'TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('images', 'allow_comments', 'SHORT_INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('images', 'allow_rating', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('images', 'allow_trackbacks', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('images', 'cat', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('images', 'comments', 'LONG_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('images', 'edit_date', '?TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('images', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('images', 'image_views', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('images', 'notes', 'LONG_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('images', 'submitter', 'USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('images', 'thumb_url', 'URLPATH');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('images', 'url', 'URLPATH');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('images', 'validated', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('import_id_remap', 'id_new', 'AUTO_LINK');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('import_id_remap', 'id_old', '*ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('import_id_remap', 'id_session', '*INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('import_id_remap', 'id_type', '*ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('import_parts_done', 'imp_id', '*SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('import_parts_done', 'imp_session', '*INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('import_session', 'imp_db_name', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('import_session', 'imp_db_table_prefix', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('import_session', 'imp_db_user', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('import_session', 'imp_hook', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('import_session', 'imp_old_base_dir', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('import_session', 'imp_refresh_time', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('import_session', 'imp_session', '*INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('incoming_uploads', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('incoming_uploads', 'i_date_and_time', 'TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('incoming_uploads', 'i_orig_filename', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('incoming_uploads', 'i_save_url', 'URLPATH');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('incoming_uploads', 'i_submitter', 'USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('invoices', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('invoices', 'i_amount', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('invoices', 'i_member_id', 'USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('invoices', 'i_note', 'LONG_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('invoices', 'i_special', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('invoices', 'i_state', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('invoices', 'i_time', 'TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('invoices', 'i_type_code', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('iotd', 'add_date', 'TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('iotd', 'allow_comments', 'SHORT_INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('iotd', 'allow_rating', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('iotd', 'allow_trackbacks', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('iotd', 'caption', 'LONG_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('iotd', 'date_and_time', '?TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('iotd', 'edit_date', '?TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('iotd', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('iotd', 'iotd_views', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('iotd', 'is_current', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('iotd', 'i_title', 'SHORT_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('iotd', 'notes', 'LONG_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('iotd', 'submitter', 'USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('iotd', 'thumb_url', 'URLPATH');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('iotd', 'url', 'URLPATH');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('iotd', 'used', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('ip_country', 'begin_num', 'UINTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('ip_country', 'country', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('ip_country', 'end_num', 'UINTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('ip_country', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('leader_board', 'date_and_time', '*TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('leader_board', 'lb_member', '*USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('leader_board', 'lb_points', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('link_tracker', 'c_date_and_time', 'TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('link_tracker', 'c_ip_address', 'IP');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('link_tracker', 'c_member_id', 'USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('link_tracker', 'c_url', 'URLPATH');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('link_tracker', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('logged_mail_messages', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('logged_mail_messages', 'm_as', 'USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('logged_mail_messages', 'm_as_admin', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('logged_mail_messages', 'm_attachments', 'LONG_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('logged_mail_messages', 'm_date_and_time', 'TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('logged_mail_messages', 'm_from_email', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('logged_mail_messages', 'm_from_name', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('logged_mail_messages', 'm_in_html', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('logged_mail_messages', 'm_member_id', 'USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('logged_mail_messages', 'm_message', 'LONG_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('logged_mail_messages', 'm_no_cc', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('logged_mail_messages', 'm_priority', 'SHORT_INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('logged_mail_messages', 'm_queued', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('logged_mail_messages', 'm_subject', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('logged_mail_messages', 'm_to_email', 'LONG_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('logged_mail_messages', 'm_to_name', 'LONG_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('logged_mail_messages', 'm_url', 'LONG_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('long_values', 'date_and_time', 'TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('long_values', 'the_name', '*ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('long_values', 'the_value', 'LONG_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('match_key_messages', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('match_key_messages', 'k_match_key', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('match_key_messages', 'k_message', 'LONG_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('member_category_access', 'active_until', '*TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('member_category_access', 'category_name', '*ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('member_category_access', 'member_id', '*USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('member_category_access', 'module_the_name', '*ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('member_page_access', 'active_until', '*TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('member_page_access', 'member_id', '*USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('member_page_access', 'page_name', '*ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('member_page_access', 'zone_name', '*ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('member_tracking', 'mt_cache_username', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('member_tracking', 'mt_id', '*ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('member_tracking', 'mt_member_id', '*USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('member_tracking', 'mt_page', '*ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('member_tracking', 'mt_time', '*TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('member_tracking', 'mt_type', '*ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('member_zone_access', 'active_until', '*TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('member_zone_access', 'member_id', '*USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('member_zone_access', 'zone_name', '*ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('menu_items', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('menu_items', 'i_caption', 'SHORT_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('menu_items', 'i_caption_long', 'SHORT_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('menu_items', 'i_check_permissions', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('menu_items', 'i_expanded', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('menu_items', 'i_menu', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('menu_items', 'i_new_window', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('menu_items', 'i_order', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('menu_items', 'i_page_only', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('menu_items', 'i_parent', '?AUTO_LINK');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('menu_items', 'i_theme_img_code', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('menu_items', 'i_url', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('messages_to_render', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('messages_to_render', 'r_message', 'LONG_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('messages_to_render', 'r_session_id', 'AUTO_LINK');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('messages_to_render', 'r_time', 'TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('messages_to_render', 'r_type', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('modules', 'module_author', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('modules', 'module_hacked_by', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('modules', 'module_hack_version', '?INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('modules', 'module_organisation', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('modules', 'module_the_name', '*ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('modules', 'module_version', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('msp', 'active_until', '*TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('msp', 'category_name', '*ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('msp', 'member_id', '*INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('msp', 'module_the_name', '*ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('msp', 'specific_permission', '*ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('msp', 'the_page', '*ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('msp', 'the_value', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('news', 'allow_comments', 'SHORT_INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('news', 'allow_rating', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('news', 'allow_trackbacks', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('news', 'author', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('news', 'date_and_time', 'TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('news', 'edit_date', '?TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('news', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('news', 'news', 'LONG_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('news', 'news_article', 'LONG_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('news', 'news_category', 'AUTO_LINK');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('news', 'news_image', 'URLPATH');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('news', 'news_views', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('news', 'notes', 'LONG_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('news', 'submitter', 'USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('news', 'title', 'SHORT_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('news', 'validated', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('newsletter', 'code_confirm', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('newsletter', 'email', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('newsletter', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('newsletter', 'join_time', 'TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('newsletter', 'language', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('newsletter', 'n_forename', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('newsletter', 'n_surname', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('newsletter', 'pass_salt', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('newsletter', 'the_password', 'MD5');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('newsletters', 'description', 'LONG_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('newsletters', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('newsletters', 'title', 'SHORT_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('newsletter_archive', 'date_and_time', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('newsletter_archive', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('newsletter_archive', 'importance_level', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('newsletter_archive', 'language', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('newsletter_archive', 'newsletter', 'LONG_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('newsletter_archive', 'subject', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('newsletter_drip_send', 'd_from_email', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('newsletter_drip_send', 'd_from_name', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('newsletter_drip_send', 'd_html_only', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('newsletter_drip_send', 'd_inject_time', 'TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('newsletter_drip_send', 'd_message', 'LONG_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('newsletter_drip_send', 'd_priority', 'SHORT_INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('newsletter_drip_send', 'd_subject', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('newsletter_drip_send', 'd_to_email', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('newsletter_drip_send', 'd_to_name', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('newsletter_drip_send', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('newsletter_subscribe', 'email', '*SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('newsletter_subscribe', 'newsletter_id', '*AUTO_LINK');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('newsletter_subscribe', 'the_level', 'SHORT_INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('news_categories', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('news_categories', 'nc_img', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('news_categories', 'nc_owner', '?USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('news_categories', 'nc_title', 'SHORT_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('news_categories', 'notes', 'LONG_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('news_category_entries', 'news_entry', '*AUTO_LINK');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('news_category_entries', 'news_entry_category', '*AUTO_LINK');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('news_rss_cloud', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('news_rss_cloud', 'register_time', 'TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('news_rss_cloud', 'rem_ip', 'IP');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('news_rss_cloud', 'rem_path', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('news_rss_cloud', 'rem_port', 'SHORT_INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('news_rss_cloud', 'rem_procedure', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('news_rss_cloud', 'rem_protocol', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('news_rss_cloud', 'watching_channel', 'URLPATH');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('occlechat', 'c_incoming', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('occlechat', 'c_message', 'LONG_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('occlechat', 'c_timestamp', 'TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('occlechat', 'c_url', 'URLPATH');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('occlechat', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('poll', 'add_time', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('poll', 'allow_comments', 'SHORT_INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('poll', 'allow_rating', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('poll', 'allow_trackbacks', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('poll', 'date_and_time', '?TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('poll', 'edit_date', '?TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('poll', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('poll', 'ip', 'LONG_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('poll', 'is_current', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('poll', 'notes', 'LONG_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('poll', 'num_options', 'SHORT_INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('poll', 'option1', 'SHORT_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('poll', 'option10', '?SHORT_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('poll', 'option2', 'SHORT_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('poll', 'option3', '?SHORT_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('poll', 'option4', '?SHORT_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('poll', 'option5', '?SHORT_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('poll', 'option6', 'SHORT_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('poll', 'option7', 'SHORT_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('poll', 'option8', '?SHORT_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('poll', 'option9', '?SHORT_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('poll', 'poll_views', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('poll', 'question', 'SHORT_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('poll', 'submitter', 'USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('poll', 'votes1', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('poll', 'votes10', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('poll', 'votes2', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('poll', 'votes3', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('poll', 'votes4', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('poll', 'votes5', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('poll', 'votes6', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('poll', 'votes7', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('poll', 'votes8', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('poll', 'votes9', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('prices', 'name', '*ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('prices', 'price', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('pstore_customs', 'c_cost', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('pstore_customs', 'c_description', 'LONG_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('pstore_customs', 'c_enabled', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('pstore_customs', 'c_one_per_member', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('pstore_customs', 'c_title', 'SHORT_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('pstore_customs', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('pstore_permissions', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('pstore_permissions', 'p_category', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('pstore_permissions', 'p_cost', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('pstore_permissions', 'p_description', 'LONG_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('pstore_permissions', 'p_enabled', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('pstore_permissions', 'p_hours', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('pstore_permissions', 'p_module', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('pstore_permissions', 'p_page', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('pstore_permissions', 'p_specific_permission', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('pstore_permissions', 'p_title', 'SHORT_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('pstore_permissions', 'p_type', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('pstore_permissions', 'p_zone', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('quizzes', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('quizzes', 'q_add_date', 'TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('quizzes', 'q_close_time', '?TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('quizzes', 'q_end_text', 'LONG_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('quizzes', 'q_name', 'SHORT_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('quizzes', 'q_notes', 'LONG_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('quizzes', 'q_num_winners', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('quizzes', 'q_open_time', 'TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('quizzes', 'q_percentage', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('quizzes', 'q_points_for_passing', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('quizzes', 'q_redo_time', '?INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('quizzes', 'q_start_text', 'LONG_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('quizzes', 'q_submitter', 'USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('quizzes', 'q_tied_newsletter', '?AUTO_LINK');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('quizzes', 'q_timeout', '?INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('quizzes', 'q_type', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('quizzes', 'q_validated', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('quiz_entries', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('quiz_entries', 'q_member', 'USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('quiz_entries', 'q_quiz', 'AUTO_LINK');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('quiz_entries', 'q_results', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('quiz_entries', 'q_time', 'TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('quiz_entry_answer', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('quiz_entry_answer', 'q_answer', 'LONG_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('quiz_entry_answer', 'q_entry', 'AUTO_LINK');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('quiz_entry_answer', 'q_question', 'AUTO_LINK');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('quiz_member_last_visit', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('quiz_member_last_visit', 'v_member_id', 'USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('quiz_member_last_visit', 'v_time', 'TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('quiz_questions', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('quiz_questions', 'q_long_input_field', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('quiz_questions', 'q_num_choosable_answers', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('quiz_questions', 'q_question_text', 'LONG_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('quiz_questions', 'q_quiz', 'AUTO_LINK');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('quiz_question_answers', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('quiz_question_answers', 'q_answer_text', 'SHORT_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('quiz_question_answers', 'q_is_correct', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('quiz_question_answers', 'q_question', 'AUTO_LINK');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('quiz_winner', 'q_entry', '*AUTO_LINK');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('quiz_winner', 'q_quiz', '*AUTO_LINK');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('quiz_winner', 'q_winner_level', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('rating', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('rating', 'rating', 'SHORT_INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('rating', 'rating_for_id', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('rating', 'rating_for_type', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('rating', 'rating_ip', 'IP');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('rating', 'rating_member', 'USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('rating', 'rating_time', 'TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('redirects', 'r_from_page', '*ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('redirects', 'r_from_zone', '*ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('redirects', 'r_is_transparent', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('redirects', 'r_to_page', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('redirects', 'r_to_zone', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('review_supplement', 'r_post_id', '*AUTO_LINK');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('review_supplement', 'r_rating', 'SHORT_INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('review_supplement', 'r_rating_for_id', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('review_supplement', 'r_rating_for_type', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('review_supplement', 'r_rating_type', '*ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('review_supplement', 'r_topic_id', 'AUTO_LINK');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('sales', 'date_and_time', 'TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('sales', 'details', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('sales', 'details2', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('sales', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('sales', 'memberid', 'USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('sales', 'purchasetype', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('searches_logged', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('searches_logged', 's_auxillary', 'LONG_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('searches_logged', 's_member_id', 'USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('searches_logged', 's_num_results', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('searches_logged', 's_primary', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('searches_logged', 's_time', 'TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('searches_saved', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('searches_saved', 's_auxillary', 'LONG_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('searches_saved', 's_member_id', 'USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('searches_saved', 's_primary', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('searches_saved', 's_time', 'TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('searches_saved', 's_title', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('security_images', 'si_code', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('security_images', 'si_session_id', '*INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('security_images', 'si_time', 'TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('seedy_changes', 'date_and_time', 'TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('seedy_changes', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('seedy_changes', 'ip', 'IP');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('seedy_changes', 'the_action', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('seedy_changes', 'the_page', 'AUTO_LINK');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('seedy_changes', 'the_user', 'USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('seedy_children', 'child_id', '*AUTO_LINK');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('seedy_children', 'parent_id', '*AUTO_LINK');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('seedy_children', 'the_order', 'SHORT_INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('seedy_children', 'title', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('seedy_pages', 'add_date', 'TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('seedy_pages', 'description', 'LONG_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('seedy_pages', 'hide_posts', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('seedy_pages', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('seedy_pages', 'notes', 'LONG_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('seedy_pages', 'seedy_views', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('seedy_pages', 'submitter', 'USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('seedy_pages', 'title', 'SHORT_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('seedy_posts', 'date_and_time', 'TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('seedy_posts', 'edit_date', '?TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('seedy_posts', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('seedy_posts', 'page_id', 'AUTO_LINK');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('seedy_posts', 'seedy_views', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('seedy_posts', 'the_message', 'LONG_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('seedy_posts', 'the_user', 'USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('seedy_posts', 'validated', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('seo_meta', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('seo_meta', 'meta_description', 'LONG_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('seo_meta', 'meta_for_id', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('seo_meta', 'meta_for_type', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('seo_meta', 'meta_keywords', 'LONG_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('sessions', 'cache_username', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('sessions', 'ip', 'IP');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('sessions', 'last_activity', 'TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('sessions', 'session_confirmed', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('sessions', 'session_invisible', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('sessions', 'the_id', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('sessions', 'the_page', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('sessions', 'the_session', '*INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('sessions', 'the_title', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('sessions', 'the_type', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('sessions', 'the_user', 'USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('sessions', 'the_zone', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('shopping_cart', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('shopping_cart', 'is_deleted', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('shopping_cart', 'ordered_by', '*AUTO_LINK');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('shopping_cart', 'price', 'REAL');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('shopping_cart', 'price_pre_tax', 'REAL');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('shopping_cart', 'product_code', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('shopping_cart', 'product_description', 'LONG_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('shopping_cart', 'product_id', '*AUTO_LINK');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('shopping_cart', 'product_name', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('shopping_cart', 'product_type', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('shopping_cart', 'product_weight', 'REAL');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('shopping_cart', 'quantity', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('shopping_cart', 'session_id', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('shopping_logging', 'date_and_time', 'TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('shopping_logging', 'e_member_id', '*USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('shopping_logging', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('shopping_logging', 'ip', 'IP');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('shopping_logging', 'last_action', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('shopping_logging', 'session_id', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('shopping_order', 'add_date', 'TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('shopping_order', 'c_member', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('shopping_order', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('shopping_order', 'notes', 'LONG_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('shopping_order', 'order_status', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('shopping_order', 'purchase_through', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('shopping_order', 'session_id', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('shopping_order', 'tax_opted_out', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('shopping_order', 'tot_price', 'REAL');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('shopping_order', 'transaction_id', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('shopping_order_addresses', 'address_city', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('shopping_order_addresses', 'address_country', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('shopping_order_addresses', 'address_name', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('shopping_order_addresses', 'address_street', 'LONG_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('shopping_order_addresses', 'address_zip', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('shopping_order_addresses', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('shopping_order_addresses', 'order_id', '?AUTO_LINK');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('shopping_order_addresses', 'receiver_email', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('shopping_order_details', 'dispatch_status', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('shopping_order_details', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('shopping_order_details', 'included_tax', 'REAL');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('shopping_order_details', 'order_id', '?AUTO_LINK');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('shopping_order_details', 'p_code', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('shopping_order_details', 'p_id', '?AUTO_LINK');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('shopping_order_details', 'p_name', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('shopping_order_details', 'p_price', 'REAL');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('shopping_order_details', 'p_quantity', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('shopping_order_details', 'p_type', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('sms_log', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('sms_log', 's_member_id', 'USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('sms_log', 's_time', 'TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('sms_log', 's_trigger_ip', 'IP');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('sp_list', 'p_section', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('sp_list', 'the_default', '*BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('sp_list', 'the_name', '*ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('staff_tips_dismissed', 't_member', '*USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('staff_tips_dismissed', 't_tip', '*ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('stats', 'access_denied_counter', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('stats', 'browser', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('stats', 'date_and_time', 'TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('stats', 'get', 'URLPATH');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('stats', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('stats', 'ip', 'IP');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('stats', 'milliseconds', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('stats', 'operating_system', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('stats', 'post', 'LONG_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('stats', 'referer', 'URLPATH');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('stats', 'the_page', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('stats', 'the_user', 'USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('subscriptions', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('subscriptions', 's_amount', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('subscriptions', 's_auto_fund_key', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('subscriptions', 's_auto_fund_source', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('subscriptions', 's_member_id', 'USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('subscriptions', 's_special', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('subscriptions', 's_state', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('subscriptions', 's_time', 'TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('subscriptions', 's_type_code', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('subscriptions', 's_via', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('tests', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('tests', 't_assigned_to', '?USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('tests', 't_enabled', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('tests', 't_inherit_section', '?AUTO_LINK');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('tests', 't_section', 'AUTO_LINK');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('tests', 't_status', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('tests', 't_test', 'LONG_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('test_sections', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('test_sections', 's_assigned_to', '?USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('test_sections', 's_inheritable', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('test_sections', 's_notes', 'LONG_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('test_sections', 's_section', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('text', 'activation_time', '?TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('text', 'active_now', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('text', 'days', 'SHORT_INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('text', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('text', 'notes', 'LONG_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('text', 'order_time', 'TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('text', 'the_message', 'SHORT_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('text', 'user_id', 'USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('theme_images', 'id', '*SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('theme_images', 'lang', '*LANGUAGE_NAME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('theme_images', 'path', 'URLPATH');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('theme_images', 'theme', '*MINIID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('tickets', 'forum_id', 'AUTO_LINK');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('tickets', 'ticket_id', '*SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('tickets', 'ticket_type', 'SHORT_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('tickets', 'topic_id', 'AUTO_LINK');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('ticket_types', 'cache_lead_time', '?TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('ticket_types', 'guest_emails_mandatory', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('ticket_types', 'search_faq', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('ticket_types', 'send_sms_to', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('ticket_types', 'ticket_type', '*SHORT_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('trackbacks', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('trackbacks', 'trackback_excerpt', 'LONG_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('trackbacks', 'trackback_for_id', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('trackbacks', 'trackback_for_type', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('trackbacks', 'trackback_ip', 'IP');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('trackbacks', 'trackback_name', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('trackbacks', 'trackback_time', 'TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('trackbacks', 'trackback_title', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('trackbacks', 'trackback_url', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('tracking', 'r_filter', 'LONG_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('tracking', 'r_member_id', '*USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('tracking', 'r_notify_email', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('tracking', 'r_notify_sms', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('tracking', 'r_resource_id', '*ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('tracking', 'r_resource_type', '*ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('transactions', 'amount', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('transactions', 'id', '*ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('transactions', 'item', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('transactions', 'linked', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('transactions', 'pending_reason', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('transactions', 'purchase_id', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('transactions', 'reason', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('transactions', 'status', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('transactions', 't_currency', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('transactions', 't_memo', 'LONG_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('transactions', 't_time', '*TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('transactions', 't_via', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('translate', 'broken', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('translate', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('translate', 'importance_level', 'SHORT_INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('translate', 'language', '*LANGUAGE_NAME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('translate', 'source_user', 'USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('translate', 'text_original', 'LONG_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('translate', 'text_parsed', 'LONG_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('translate_history', 'action_member', 'USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('translate_history', 'action_time', 'TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('translate_history', 'broken', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('translate_history', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('translate_history', 'language', '*LANGUAGE_NAME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('translate_history', 'lang_id', 'AUTO_LINK');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('translate_history', 'text_original', 'LONG_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('trans_expecting', 'e_amount', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('trans_expecting', 'e_ip_address', 'IP');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('trans_expecting', 'e_item_name', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('trans_expecting', 'e_length', '?INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('trans_expecting', 'e_length_units', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('trans_expecting', 'e_member_id', 'USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('trans_expecting', 'e_purchase_id', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('trans_expecting', 'e_session_id', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('trans_expecting', 'e_time', 'TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('trans_expecting', 'id', '*ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('tutorial_links', 'the_name', '*ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('tutorial_links', 'the_value', 'LONG_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('url_id_monikers', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('url_id_monikers', 'm_deprecated', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('url_id_monikers', 'm_moniker', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('url_id_monikers', 'm_resource_id', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('url_id_monikers', 'm_resource_page', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('url_id_monikers', 'm_resource_type', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('url_title_cache', 't_title', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('url_title_cache', 't_url', '*URLPATH');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('usersonline_track', 'date_and_time', '*TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('usersonline_track', 'peak', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('usersubmitban_ip', 'ip', '*IP');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('usersubmitban_ip', 'i_descrip', 'LONG_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('usersubmitban_member', 'the_member', '*USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('validated_once', 'hash', '*MD5');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('values', 'date_and_time', 'TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('values', 'the_name', '*ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('values', 'the_value', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('videos', 'add_date', 'TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('videos', 'allow_comments', 'SHORT_INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('videos', 'allow_rating', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('videos', 'allow_trackbacks', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('videos', 'cat', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('videos', 'comments', 'LONG_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('videos', 'edit_date', '?TIME');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('videos', 'id', '*AUTO');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('videos', 'notes', 'LONG_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('videos', 'submitter', 'USER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('videos', 'thumb_url', 'URLPATH');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('videos', 'url', 'URLPATH');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('videos', 'validated', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('videos', 'video_height', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('videos', 'video_length', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('videos', 'video_views', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('videos', 'video_width', 'INTEGER');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('wordfilter', 'word', '*SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('wordfilter', 'w_replacement', 'SHORT_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('wordfilter', 'w_substr', '*BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('zones', 'zone_default_page', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('zones', 'zone_displayed_in_menu', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('zones', 'zone_header_text', 'SHORT_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('zones', 'zone_name', '*ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('zones', 'zone_require_session', 'BINARY');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('zones', 'zone_theme', 'ID_TEXT');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('zones', 'zone_title', 'SHORT_TRANS');
INSERT INTO `ocp_db_meta` (`m_table`, `m_name`, `m_type`) VALUES('zones', 'zone_wide', '?BINARY');

-- --------------------------------------------------------

--
-- Table structure for table `ocp_db_meta_indices`
--

DROP TABLE IF EXISTS `ocp_db_meta_indices`;
CREATE TABLE IF NOT EXISTS `ocp_db_meta_indices` (
  `i_table` varchar(80) NOT NULL,
  `i_name` varchar(80) NOT NULL,
  `i_fields` varchar(80) NOT NULL,
  PRIMARY KEY (`i_table`,`i_name`,`i_fields`)
) ENGINE=MyISAM;

--
-- Dumping data for table `ocp_db_meta_indices`
--

INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('banner_clicks', 'clicker_ip', 'c_ip_address');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('cache', 'cached_for', 'cached_for');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('cache', 'cached_ford', 'date_and_time');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('cache', 'cached_fori', 'identifier');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('cache', 'cached_forl', 'lang');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('cache', 'cached_fort', 'the_theme');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('catalogue_efv_long', '#lcv_value', 'cv_value');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('catalogue_efv_long', 'lce_id', 'ce_id');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('catalogue_efv_long', 'lcf_id', 'cf_id');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('catalogue_efv_long_trans', 'ltce_id', 'ce_id');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('catalogue_efv_long_trans', 'ltcf_id', 'cf_id');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('catalogue_efv_short', '#scv_value', 'cv_value');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('catalogue_efv_short', 'iscv_value', 'cv_value');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('catalogue_efv_short', 'sce_id', 'ce_id');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('catalogue_efv_short', 'scf_id', 'cf_id');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('catalogue_efv_short_trans', 'stce_id', 'ce_id');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('catalogue_efv_short_trans', 'stcf_id', 'cf_id');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('catalogue_entries', 'ce_cc_id', 'cc_id');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('chat_active', 'active_ordering', 'date_and_time');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('chat_active', 'member_select', 'member_id');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('chat_active', 'room_select', 'room_id');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('chat_events', 'event_ordering', 'e_date_and_time');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('chat_messages', 'Ordering', 'date_and_time');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('download_categories', 'child_find', 'parent_id');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('download_downloads', '#download_data_mash', 'download_data_mash');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('download_downloads', '#original_filename', 'original_filename');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('download_downloads', 'category_list', 'category_id');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('download_downloads', 'recent_downloads', 'add_date');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('download_downloads', 'top_downloads', 'num_downloads');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('download_logging', 'calculate_bandwidth', 'date_and_time');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('f_forums', 'subforum_parenting', 'f_parent_forum');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('f_group_members', 'gm_validated', 'gm_validated');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('f_members', '#search_user', 'm_username');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('f_members', 'birthdays', 'm_dob_day,m_dob_month');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('f_members', 'sort_post_count', 'm_cache_num_posts');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('f_members', 'user_list', 'm_username');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('f_members', 'whos_validated', 'm_validated');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('f_member_custom_fields', '#mcf10', 'field_10');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('f_member_custom_fields', '#mcf13', 'field_13');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('f_member_custom_fields', '#mcf14', 'field_14');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('f_member_custom_fields', '#mcf15', 'field_15');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('f_member_custom_fields', '#mcf17', 'field_17');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('f_member_custom_fields', '#mcf18', 'field_18');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('f_member_custom_fields', '#mcf19', 'field_19');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('f_member_custom_fields', '#mcf2', 'field_2');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('f_member_custom_fields', '#mcf20', 'field_20');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('f_member_custom_fields', '#mcf21', 'field_21');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('f_member_custom_fields', '#mcf22', 'field_22');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('f_member_custom_fields', '#mcf23', 'field_23');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('f_member_custom_fields', '#mcf24', 'field_24');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('f_member_custom_fields', '#mcf25', 'field_25');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('f_member_custom_fields', '#mcf26', 'field_26');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('f_member_custom_fields', '#mcf27', 'field_27');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('f_member_custom_fields', '#mcf3', 'field_3');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('f_member_custom_fields', '#mcf33', 'field_33');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('f_member_custom_fields', '#mcf34', 'field_34');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('f_member_custom_fields', '#mcf35', 'field_35');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('f_member_custom_fields', '#mcf4', 'field_4');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('f_member_custom_fields', '#mcf5', 'field_5');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('f_member_custom_fields', '#mcf7', 'field_7');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('f_member_custom_fields', '#mcf8', 'field_8');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('f_posts', '#p_title', 'p_title');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('f_posts', 'find_pp', 'p_intended_solely_for');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('f_posts', 'in_topic', 'p_topic_id');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('f_posts', 'posts_by', 'p_poster');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('f_posts', 'post_order_time', 'p_time');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('f_post_history', 'phistorylookup', 'h_post_id');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('f_read_logs', 'erase_old_read_logs', 'l_time');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('f_topics', '#t_description', 't_description');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('f_topics', 'in_forum', 't_forum_id');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('f_topics', 'topic_order_time', 't_cache_last_time');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('f_warnings', 'warningsmemberid', 'w_member_id');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('images', 'category_list', 'cat');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('images', 'i_validated', 'validated');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('iotd', 'get_current', 'is_current');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('news', 'headlines', 'date_and_time');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('newsletter_drip_send', 'd_inject_time', 'd_inject_time');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('poll', 'get_current', 'is_current');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('rating', 'alt_key', 'rating_for_type,rating_for_id');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('review_supplement', 'rating_for_id', 'r_rating_for_id');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('searches_logged', 'past_search', 's_primary');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('seedy_posts', 'posts_on_page', 'page_id');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('seo_meta', 'alt_key', 'meta_for_type,meta_for_id');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('sessions', 'delete_old', 'last_activity');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('shopping_logging', 'calculate_bandwidth', 'date_and_time');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('shopping_order', 'recent_shopped', 'add_date');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('sms_log', 'sms_log_for', 's_member_id,s_time');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('sms_log', 'sms_trigger_ip', 's_trigger_ip');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('stats', 'member_track', 'ip,the_user');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('stats', 'pages', 'the_page');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('translate', '#search', 'text_original');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('url_id_monikers', 'uim_moniker', 'm_moniker');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('url_id_monikers', 'uim_pagelink', 'm_resource_page,m_resource_type,m_resource_id');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('usersonline_track', 'peak_track', 'peak');
INSERT INTO `ocp_db_meta_indices` (`i_table`, `i_name`, `i_fields`) VALUES('videos', 'category_list', 'cat');

-- --------------------------------------------------------

--
-- Table structure for table `ocp_download_categories`
--

DROP TABLE IF EXISTS `ocp_download_categories`;
CREATE TABLE IF NOT EXISTS `ocp_download_categories` (
  `add_date` int(10) unsigned NOT NULL,
  `category` int(10) unsigned NOT NULL,
  `description` int(10) unsigned NOT NULL,
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `notes` longtext NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `rep_image` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `child_find` (`parent_id`)
) ENGINE=MyISAM  AUTO_INCREMENT=4 ;

--
-- Dumping data for table `ocp_download_categories`
--

INSERT INTO `ocp_download_categories` (`add_date`, `category`, `description`, `id`, `notes`, `parent_id`, `rep_image`) VALUES(1264606828, 319, 320, 1, '', NULL, '');
INSERT INTO `ocp_download_categories` (`add_date`, `category`, `description`, `id`, `notes`, `parent_id`, `rep_image`) VALUES(1264672260, 602, 603, 2, '', 1, '');
INSERT INTO `ocp_download_categories` (`add_date`, `category`, `description`, `id`, `notes`, `parent_id`, `rep_image`) VALUES(1264672321, 606, 607, 3, '', 2, '');

-- --------------------------------------------------------

--
-- Table structure for table `ocp_download_downloads`
--

DROP TABLE IF EXISTS `ocp_download_downloads`;
CREATE TABLE IF NOT EXISTS `ocp_download_downloads` (
  `add_date` int(10) unsigned NOT NULL,
  `allow_comments` tinyint(4) NOT NULL,
  `allow_rating` tinyint(1) NOT NULL,
  `allow_trackbacks` tinyint(1) NOT NULL,
  `author` varchar(80) NOT NULL,
  `category_id` int(11) NOT NULL,
  `comments` int(10) unsigned NOT NULL,
  `default_pic` int(11) NOT NULL,
  `description` int(10) unsigned NOT NULL,
  `download_cost` int(11) NOT NULL,
  `download_data_mash` longtext NOT NULL,
  `download_licence` int(11) DEFAULT NULL,
  `download_submitter_gets_points` tinyint(1) NOT NULL,
  `download_views` int(11) NOT NULL,
  `edit_date` int(10) unsigned DEFAULT NULL,
  `file_size` int(11) DEFAULT NULL,
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` int(10) unsigned NOT NULL,
  `notes` longtext NOT NULL,
  `num_downloads` int(11) NOT NULL,
  `original_filename` varchar(255) NOT NULL,
  `out_mode_id` int(11) DEFAULT NULL,
  `rep_image` varchar(255) NOT NULL,
  `submitter` int(11) NOT NULL,
  `url` varchar(255) NOT NULL,
  `validated` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `category_list` (`category_id`),
  KEY `recent_downloads` (`add_date`),
  KEY `top_downloads` (`num_downloads`),
  FULLTEXT KEY `download_data_mash` (`download_data_mash`),
  FULLTEXT KEY `original_filename` (`original_filename`)
) ENGINE=MyISAM  AUTO_INCREMENT=3 ;

--
-- Dumping data for table `ocp_download_downloads`
--

INSERT INTO `ocp_download_downloads` (`add_date`, `allow_comments`, `allow_rating`, `allow_trackbacks`, `author`, `category_id`, `comments`, `default_pic`, `description`, `download_cost`, `download_data_mash`, `download_licence`, `download_submitter_gets_points`, `download_views`, `edit_date`, `file_size`, `id`, `name`, `notes`, `num_downloads`, `original_filename`, `out_mode_id`, `rep_image`, `submitter`, `url`, `validated`) VALUES(1264673478, 1, 1, 1, 'William Shakespeare', 3, 616, 1, 615, 0, '', NULL, 0, 1, 1264686219, 63123, 1, 614, '', 1, '2ws1610.txt.zip', NULL, '', 2, 'uploads/downloads/4b6162c681095.dat', 1);
INSERT INTO `ocp_download_downloads` (`add_date`, `allow_comments`, `allow_rating`, `allow_trackbacks`, `author`, `category_id`, `comments`, `default_pic`, `description`, `download_cost`, `download_data_mash`, `download_licence`, `download_submitter_gets_points`, `download_views`, `edit_date`, `file_size`, `id`, `name`, `notes`, `num_downloads`, `original_filename`, `out_mode_id`, `rep_image`, `submitter`, `url`, `validated`) VALUES(1264685674, 1, 1, 1, 'William Shakespeare', 3, 766, 1, 765, 0, '', NULL, 0, 1, NULL, 77715, 2, 764, '', 0, '2ws2610.txt.zip', NULL, '', 2, 'uploads/downloads/4b61926a8df19.dat', 1);

-- --------------------------------------------------------

--
-- Table structure for table `ocp_download_licences`
--

DROP TABLE IF EXISTS `ocp_download_licences`;
CREATE TABLE IF NOT EXISTS `ocp_download_licences` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `l_text` longtext NOT NULL,
  `l_title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 ;

--
-- Dumping data for table `ocp_download_licences`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_download_logging`
--

DROP TABLE IF EXISTS `ocp_download_logging`;
CREATE TABLE IF NOT EXISTS `ocp_download_logging` (
  `date_and_time` int(10) unsigned NOT NULL,
  `id` int(11) NOT NULL,
  `ip` varchar(40) NOT NULL,
  `the_user` int(11) NOT NULL,
  PRIMARY KEY (`id`,`the_user`),
  KEY `calculate_bandwidth` (`date_and_time`)
) ENGINE=MyISAM;

--
-- Dumping data for table `ocp_download_logging`
--

INSERT INTO `ocp_download_logging` (`date_and_time`, `id`, `ip`, `the_user`) VALUES(1264674283, 1, '90.152.0.114', 2);

-- --------------------------------------------------------

--
-- Table structure for table `ocp_edit_pings`
--

DROP TABLE IF EXISTS `ocp_edit_pings`;
CREATE TABLE IF NOT EXISTS `ocp_edit_pings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `the_id` varchar(80) NOT NULL,
  `the_member` int(11) NOT NULL,
  `the_page` varchar(80) NOT NULL,
  `the_time` int(10) unsigned NOT NULL,
  `the_type` varchar(80) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 ;

--
-- Dumping data for table `ocp_edit_pings`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_failedlogins`
--

DROP TABLE IF EXISTS `ocp_failedlogins`;
CREATE TABLE IF NOT EXISTS `ocp_failedlogins` (
  `date_and_time` int(10) unsigned NOT NULL,
  `failed_account` varchar(80) NOT NULL,
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ip` varchar(40) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  AUTO_INCREMENT=5 ;

--
-- Dumping data for table `ocp_failedlogins`
--

INSERT INTO `ocp_failedlogins` (`date_and_time`, `failed_account`, `id`, `ip`) VALUES(1264674447, 'admin', 1, '90.152.0.114');
INSERT INTO `ocp_failedlogins` (`date_and_time`, `failed_account`, `id`, `ip`) VALUES(1264674456, 'admin', 2, '90.152.0.114');
INSERT INTO `ocp_failedlogins` (`date_and_time`, `failed_account`, `id`, `ip`) VALUES(1264674465, 'admin', 3, '90.152.0.114');
INSERT INTO `ocp_failedlogins` (`date_and_time`, `failed_account`, `id`, `ip`) VALUES(1265488464, 'admin', 4, '0000:0000:0000:0000:0000:0000:0000:0001');

-- --------------------------------------------------------

--
-- Table structure for table `ocp_filedump`
--

DROP TABLE IF EXISTS `ocp_filedump`;
CREATE TABLE IF NOT EXISTS `ocp_filedump` (
  `description` int(10) unsigned NOT NULL,
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  `path` varchar(255) NOT NULL,
  `the_member` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 ;

--
-- Dumping data for table `ocp_filedump`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_f_categories`
--

DROP TABLE IF EXISTS `ocp_f_categories`;
CREATE TABLE IF NOT EXISTS `ocp_f_categories` (
  `c_description` longtext NOT NULL,
  `c_expanded_by_default` tinyint(1) NOT NULL,
  `c_title` varchar(255) NOT NULL,
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  AUTO_INCREMENT=3 ;

--
-- Dumping data for table `ocp_f_categories`
--

INSERT INTO `ocp_f_categories` (`c_description`, `c_expanded_by_default`, `c_title`, `id`) VALUES('', 1, 'General', 1);
INSERT INTO `ocp_f_categories` (`c_description`, `c_expanded_by_default`, `c_title`, `id`) VALUES('', 1, 'Staff', 2);

-- --------------------------------------------------------

--
-- Table structure for table `ocp_f_custom_fields`
--

DROP TABLE IF EXISTS `ocp_f_custom_fields`;
CREATE TABLE IF NOT EXISTS `ocp_f_custom_fields` (
  `cf_default` longtext NOT NULL,
  `cf_description` int(10) unsigned NOT NULL,
  `cf_encrypted` tinyint(1) NOT NULL,
  `cf_locked` tinyint(1) NOT NULL,
  `cf_name` int(10) unsigned NOT NULL,
  `cf_only_group` longtext NOT NULL,
  `cf_order` int(11) NOT NULL,
  `cf_owner_set` tinyint(1) NOT NULL,
  `cf_owner_view` tinyint(1) NOT NULL,
  `cf_public_view` tinyint(1) NOT NULL,
  `cf_required` tinyint(1) NOT NULL,
  `cf_show_in_posts` tinyint(1) NOT NULL,
  `cf_show_in_post_previews` tinyint(1) NOT NULL,
  `cf_type` varchar(80) NOT NULL,
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  AUTO_INCREMENT=36 ;

--
-- Dumping data for table `ocp_f_custom_fields`
--

INSERT INTO `ocp_f_custom_fields` (`cf_default`, `cf_description`, `cf_encrypted`, `cf_locked`, `cf_name`, `cf_only_group`, `cf_order`, `cf_owner_set`, `cf_owner_view`, `cf_public_view`, `cf_required`, `cf_show_in_posts`, `cf_show_in_post_previews`, `cf_type`, `id`) VALUES('', 17, 0, 0, 16, '', 0, 1, 1, 1, 0, 0, 0, 'long_trans', 1);
INSERT INTO `ocp_f_custom_fields` (`cf_default`, `cf_description`, `cf_encrypted`, `cf_locked`, `cf_name`, `cf_only_group`, `cf_order`, `cf_owner_set`, `cf_owner_view`, `cf_public_view`, `cf_required`, `cf_show_in_posts`, `cf_show_in_post_previews`, `cf_type`, `id`) VALUES('', 19, 0, 0, 18, '', 1, 1, 1, 1, 0, 0, 0, 'short_text', 2);
INSERT INTO `ocp_f_custom_fields` (`cf_default`, `cf_description`, `cf_encrypted`, `cf_locked`, `cf_name`, `cf_only_group`, `cf_order`, `cf_owner_set`, `cf_owner_view`, `cf_public_view`, `cf_required`, `cf_show_in_posts`, `cf_show_in_post_previews`, `cf_type`, `id`) VALUES('', 21, 0, 0, 20, '', 2, 1, 1, 1, 0, 0, 0, 'short_text', 3);
INSERT INTO `ocp_f_custom_fields` (`cf_default`, `cf_description`, `cf_encrypted`, `cf_locked`, `cf_name`, `cf_only_group`, `cf_order`, `cf_owner_set`, `cf_owner_view`, `cf_public_view`, `cf_required`, `cf_show_in_posts`, `cf_show_in_post_previews`, `cf_type`, `id`) VALUES('', 23, 0, 0, 22, '', 3, 1, 1, 1, 0, 0, 0, 'short_text', 4);
INSERT INTO `ocp_f_custom_fields` (`cf_default`, `cf_description`, `cf_encrypted`, `cf_locked`, `cf_name`, `cf_only_group`, `cf_order`, `cf_owner_set`, `cf_owner_view`, `cf_public_view`, `cf_required`, `cf_show_in_posts`, `cf_show_in_post_previews`, `cf_type`, `id`) VALUES('', 25, 0, 0, 24, '', 4, 1, 1, 1, 0, 0, 0, 'short_text', 5);
INSERT INTO `ocp_f_custom_fields` (`cf_default`, `cf_description`, `cf_encrypted`, `cf_locked`, `cf_name`, `cf_only_group`, `cf_order`, `cf_owner_set`, `cf_owner_view`, `cf_public_view`, `cf_required`, `cf_show_in_posts`, `cf_show_in_post_previews`, `cf_type`, `id`) VALUES('', 27, 0, 0, 26, '', 5, 1, 1, 1, 0, 0, 0, 'long_trans', 6);
INSERT INTO `ocp_f_custom_fields` (`cf_default`, `cf_description`, `cf_encrypted`, `cf_locked`, `cf_name`, `cf_only_group`, `cf_order`, `cf_owner_set`, `cf_owner_view`, `cf_public_view`, `cf_required`, `cf_show_in_posts`, `cf_show_in_post_previews`, `cf_type`, `id`) VALUES('', 29, 0, 0, 28, '', 6, 1, 1, 1, 0, 0, 0, 'short_text', 7);
INSERT INTO `ocp_f_custom_fields` (`cf_default`, `cf_description`, `cf_encrypted`, `cf_locked`, `cf_name`, `cf_only_group`, `cf_order`, `cf_owner_set`, `cf_owner_view`, `cf_public_view`, `cf_required`, `cf_show_in_posts`, `cf_show_in_post_previews`, `cf_type`, `id`) VALUES('', 31, 0, 0, 30, '', 7, 1, 1, 1, 0, 0, 0, 'short_text', 8);
INSERT INTO `ocp_f_custom_fields` (`cf_default`, `cf_description`, `cf_encrypted`, `cf_locked`, `cf_name`, `cf_only_group`, `cf_order`, `cf_owner_set`, `cf_owner_view`, `cf_public_view`, `cf_required`, `cf_show_in_posts`, `cf_show_in_post_previews`, `cf_type`, `id`) VALUES('', 33, 0, 0, 32, '', 8, 0, 0, 0, 0, 0, 0, 'long_trans', 9);
INSERT INTO `ocp_f_custom_fields` (`cf_default`, `cf_description`, `cf_encrypted`, `cf_locked`, `cf_name`, `cf_only_group`, `cf_order`, `cf_owner_set`, `cf_owner_view`, `cf_public_view`, `cf_required`, `cf_show_in_posts`, `cf_show_in_post_previews`, `cf_type`, `id`) VALUES('', 90, 0, 1, 89, '', 9, 1, 0, 0, 0, 0, 0, 'short_text', 10);
INSERT INTO `ocp_f_custom_fields` (`cf_default`, `cf_description`, `cf_encrypted`, `cf_locked`, `cf_name`, `cf_only_group`, `cf_order`, `cf_owner_set`, `cf_owner_view`, `cf_public_view`, `cf_required`, `cf_show_in_posts`, `cf_show_in_post_previews`, `cf_type`, `id`) VALUES('0', 303, 0, 1, 302, '', 10, 0, 0, 0, 0, 0, 0, 'integer', 11);
INSERT INTO `ocp_f_custom_fields` (`cf_default`, `cf_description`, `cf_encrypted`, `cf_locked`, `cf_name`, `cf_only_group`, `cf_order`, `cf_owner_set`, `cf_owner_view`, `cf_public_view`, `cf_required`, `cf_show_in_posts`, `cf_show_in_post_previews`, `cf_type`, `id`) VALUES('0', 314, 0, 1, 313, '', 11, 0, 0, 0, 0, 0, 0, 'integer', 12);
INSERT INTO `ocp_f_custom_fields` (`cf_default`, `cf_description`, `cf_encrypted`, `cf_locked`, `cf_name`, `cf_only_group`, `cf_order`, `cf_owner_set`, `cf_owner_view`, `cf_public_view`, `cf_required`, `cf_show_in_posts`, `cf_show_in_post_previews`, `cf_type`, `id`) VALUES('AED|AFA|ALL|AMD|ANG|AOK|AON|ARA|ARP|ARS|AUD|AWG|AZM|BAM|BBD|BDT|BGL|BHD|BIF|BMD|BND|BOB|BOP|BRC|BRL|BRR|BSD|BTN|BWP|BYR|BZD|CAD|CDZ|CHF|CLF|CLP|CNY|COP|CRC|CSD|CUP|CVE|CYP|CZK|DJF|DKK|DOP|DZD|EEK|EGP|ERN|ETB|EUR|FJD|FKP|GBP|GEL|GHC|GIP|GMD|GNS|GQE|GTQ|GWP|GYD|HKD|HNL|HRD|HRK|HTG|HUF|IDR|ILS|INR|IQD|IRR|ISK|JMD|JOD|JPY|KES|KGS|KHR|KMF|KPW|KRW|KWD|KYD|KZT|LAK|LBP|LKR|LRD|LSL|LSM|LTL|LVL|LYD|MAD|MDL|MGF|MKD|MLF|MMK|MNT|MOP|MRO|MTL|MUR|MVR|MWK|MXN|MYR|MZM|NAD|NGN|NIC|NOK|NPR|NZD|OMR|PAB|PEI|PEN|PGK|PHP|PKR|PLN|PYG|QAR|ROL|RUB|RWF|SAR|SBD|SCR|SDD|SDP|SEK|SGD|SHP|SIT|SKK|SLL|SOS|SRG|STD|SUR|SVC|SYP|SZL|THB|TJR|TMM|TND|TOP|TPE|TRL|TTD|TWD|TZS|UAH|UAK|UGS|USD|UYU|UZS|VEB|VND|VUV|WST|XAF|XCD|XOF|XPF|YDD|YER|ZAL|ZAR|ZMK|ZWD', 352, 0, 1, 351, '', 12, 1, 0, 0, 0, 0, 0, 'list', 13);
INSERT INTO `ocp_f_custom_fields` (`cf_default`, `cf_description`, `cf_encrypted`, `cf_locked`, `cf_name`, `cf_only_group`, `cf_order`, `cf_owner_set`, `cf_owner_view`, `cf_public_view`, `cf_required`, `cf_show_in_posts`, `cf_show_in_post_previews`, `cf_type`, `id`) VALUES('', 354, 1, 1, 353, '', 13, 1, 0, 0, 0, 0, 0, 'short_text', 14);
INSERT INTO `ocp_f_custom_fields` (`cf_default`, `cf_description`, `cf_encrypted`, `cf_locked`, `cf_name`, `cf_only_group`, `cf_order`, `cf_owner_set`, `cf_owner_view`, `cf_public_view`, `cf_required`, `cf_show_in_posts`, `cf_show_in_post_previews`, `cf_type`, `id`) VALUES('American Express|Delta|Diners Card|JCB|Master Card|Solo|Switch|Visa', 356, 1, 1, 355, '', 14, 1, 0, 0, 0, 0, 0, 'list', 15);
INSERT INTO `ocp_f_custom_fields` (`cf_default`, `cf_description`, `cf_encrypted`, `cf_locked`, `cf_name`, `cf_only_group`, `cf_order`, `cf_owner_set`, `cf_owner_view`, `cf_public_view`, `cf_required`, `cf_show_in_posts`, `cf_show_in_post_previews`, `cf_type`, `id`) VALUES('', 358, 1, 1, 357, '', 15, 1, 0, 0, 0, 0, 0, 'integer', 16);
INSERT INTO `ocp_f_custom_fields` (`cf_default`, `cf_description`, `cf_encrypted`, `cf_locked`, `cf_name`, `cf_only_group`, `cf_order`, `cf_owner_set`, `cf_owner_view`, `cf_public_view`, `cf_required`, `cf_show_in_posts`, `cf_show_in_post_previews`, `cf_type`, `id`) VALUES('mm/yy', 360, 1, 1, 359, '', 16, 1, 0, 0, 0, 0, 0, 'short_text', 17);
INSERT INTO `ocp_f_custom_fields` (`cf_default`, `cf_description`, `cf_encrypted`, `cf_locked`, `cf_name`, `cf_only_group`, `cf_order`, `cf_owner_set`, `cf_owner_view`, `cf_public_view`, `cf_required`, `cf_show_in_posts`, `cf_show_in_post_previews`, `cf_type`, `id`) VALUES('mm/yy', 362, 1, 1, 361, '', 17, 1, 0, 0, 0, 0, 0, 'short_text', 18);
INSERT INTO `ocp_f_custom_fields` (`cf_default`, `cf_description`, `cf_encrypted`, `cf_locked`, `cf_name`, `cf_only_group`, `cf_order`, `cf_owner_set`, `cf_owner_view`, `cf_public_view`, `cf_required`, `cf_show_in_posts`, `cf_show_in_post_previews`, `cf_type`, `id`) VALUES('', 364, 1, 1, 363, '', 18, 1, 0, 0, 0, 0, 0, 'short_text', 19);
INSERT INTO `ocp_f_custom_fields` (`cf_default`, `cf_description`, `cf_encrypted`, `cf_locked`, `cf_name`, `cf_only_group`, `cf_order`, `cf_owner_set`, `cf_owner_view`, `cf_public_view`, `cf_required`, `cf_show_in_posts`, `cf_show_in_post_previews`, `cf_type`, `id`) VALUES('', 366, 1, 1, 365, '', 19, 1, 0, 0, 0, 0, 0, 'short_text', 20);
INSERT INTO `ocp_f_custom_fields` (`cf_default`, `cf_description`, `cf_encrypted`, `cf_locked`, `cf_name`, `cf_only_group`, `cf_order`, `cf_owner_set`, `cf_owner_view`, `cf_public_view`, `cf_required`, `cf_show_in_posts`, `cf_show_in_post_previews`, `cf_type`, `id`) VALUES('', 380, 0, 1, 379, '', 20, 0, 0, 0, 0, 0, 0, 'short_text', 21);
INSERT INTO `ocp_f_custom_fields` (`cf_default`, `cf_description`, `cf_encrypted`, `cf_locked`, `cf_name`, `cf_only_group`, `cf_order`, `cf_owner_set`, `cf_owner_view`, `cf_public_view`, `cf_required`, `cf_show_in_posts`, `cf_show_in_post_previews`, `cf_type`, `id`) VALUES('', 382, 0, 1, 381, '', 21, 0, 0, 0, 0, 0, 0, 'short_text', 22);
INSERT INTO `ocp_f_custom_fields` (`cf_default`, `cf_description`, `cf_encrypted`, `cf_locked`, `cf_name`, `cf_only_group`, `cf_order`, `cf_owner_set`, `cf_owner_view`, `cf_public_view`, `cf_required`, `cf_show_in_posts`, `cf_show_in_post_previews`, `cf_type`, `id`) VALUES('', 384, 0, 1, 383, '', 22, 0, 0, 0, 0, 0, 0, 'long_text', 23);
INSERT INTO `ocp_f_custom_fields` (`cf_default`, `cf_description`, `cf_encrypted`, `cf_locked`, `cf_name`, `cf_only_group`, `cf_order`, `cf_owner_set`, `cf_owner_view`, `cf_public_view`, `cf_required`, `cf_show_in_posts`, `cf_show_in_post_previews`, `cf_type`, `id`) VALUES('', 386, 0, 1, 385, '', 23, 0, 0, 0, 0, 0, 0, 'short_text', 24);
INSERT INTO `ocp_f_custom_fields` (`cf_default`, `cf_description`, `cf_encrypted`, `cf_locked`, `cf_name`, `cf_only_group`, `cf_order`, `cf_owner_set`, `cf_owner_view`, `cf_public_view`, `cf_required`, `cf_show_in_posts`, `cf_show_in_post_previews`, `cf_type`, `id`) VALUES('', 388, 0, 1, 387, '', 24, 0, 0, 0, 0, 0, 0, 'short_text', 25);
INSERT INTO `ocp_f_custom_fields` (`cf_default`, `cf_description`, `cf_encrypted`, `cf_locked`, `cf_name`, `cf_only_group`, `cf_order`, `cf_owner_set`, `cf_owner_view`, `cf_public_view`, `cf_required`, `cf_show_in_posts`, `cf_show_in_post_previews`, `cf_type`, `id`) VALUES('', 390, 0, 1, 389, '', 25, 0, 0, 0, 0, 0, 0, 'short_text', 26);
INSERT INTO `ocp_f_custom_fields` (`cf_default`, `cf_description`, `cf_encrypted`, `cf_locked`, `cf_name`, `cf_only_group`, `cf_order`, `cf_owner_set`, `cf_owner_view`, `cf_public_view`, `cf_required`, `cf_show_in_posts`, `cf_show_in_post_previews`, `cf_type`, `id`) VALUES('AD|AE|AF|AG|AI|AL|AM|AN|AO|AQ|AR|AS|AT|AU|AW|AZ|BA|BB|BD|BE|BF|BG|BH|BI|BJ|BM|BN|BO|BR|BS|BT|BU|BV|BW|BY|BZ|CA|CC|CD|CF|CG|CH|CI|CK|CL|CM|CN|CO|CR|CS|CU|CV|CX|CY|CZ|DE|DJ|DK|DM|DO|DZ|EC|EE|EG|EH|ER|ES|ET|FI|FJ|FK|FM|FO|FR|GA|GB|GD|GE|GH|GI|GL|GM|GN|GQ|GR|GS|GT|GU|GW|GY|HK|HM|HN|HR|HT|HU|ID|IE|IL|IN|IO|IQ|IR|IS|IT|JM|JO|JP|KE|KG|KH|KI|KM|KN|KP|KR|KW|KY|KZ|LA|LB|LC|LI|LK|LR|LS|LT|LU|LY|MA|MC|MD|MG|MH|MK|ML|MM|MN|MO|MP|MR|MS|MT|MU|MV|MW|MX|MY|MZ|NA|NC|NE|NF|NG|NI|NL|NO|NP|NR|NU|NZ|OM|PA|PE|PF|PG|PH|PK|PL|PN|PR|PT|PW|PY|QA|RO|RU|RW|SA|SB|SC|SD|SE|SG|SH|SI|SJ|SK|SL|SM|SN|SO|SR|ST|SU|SV|SY|SZ|TC|TD|TG|TH|TJ|TK|TM|TN|TO|TP|TR|TT|TV|TW|TZ|UA|UG|UM|US|UY|UZ|VA|VC|VE|VG|VI|VN|VU|WF|WS|YD|YE|ZA|ZM|ZR|ZW', 392, 0, 1, 391, '', 26, 0, 0, 0, 0, 0, 0, 'list', 27);
INSERT INTO `ocp_f_custom_fields` (`cf_default`, `cf_description`, `cf_encrypted`, `cf_locked`, `cf_name`, `cf_only_group`, `cf_order`, `cf_owner_set`, `cf_owner_view`, `cf_public_view`, `cf_required`, `cf_show_in_posts`, `cf_show_in_post_previews`, `cf_type`, `id`) VALUES('0', 426, 0, 1, 425, '', 27, 0, 0, 0, 0, 0, 0, 'integer', 28);
INSERT INTO `ocp_f_custom_fields` (`cf_default`, `cf_description`, `cf_encrypted`, `cf_locked`, `cf_name`, `cf_only_group`, `cf_order`, `cf_owner_set`, `cf_owner_view`, `cf_public_view`, `cf_required`, `cf_show_in_posts`, `cf_show_in_post_previews`, `cf_type`, `id`) VALUES('0', 428, 0, 1, 427, '', 28, 0, 0, 0, 0, 0, 0, 'integer', 29);
INSERT INTO `ocp_f_custom_fields` (`cf_default`, `cf_description`, `cf_encrypted`, `cf_locked`, `cf_name`, `cf_only_group`, `cf_order`, `cf_owner_set`, `cf_owner_view`, `cf_public_view`, `cf_required`, `cf_show_in_posts`, `cf_show_in_post_previews`, `cf_type`, `id`) VALUES('0', 430, 0, 1, 429, '', 29, 0, 0, 0, 0, 0, 0, 'integer', 30);
INSERT INTO `ocp_f_custom_fields` (`cf_default`, `cf_description`, `cf_encrypted`, `cf_locked`, `cf_name`, `cf_only_group`, `cf_order`, `cf_owner_set`, `cf_owner_view`, `cf_public_view`, `cf_required`, `cf_show_in_posts`, `cf_show_in_post_previews`, `cf_type`, `id`) VALUES('0', 432, 0, 1, 431, '', 30, 0, 0, 0, 0, 0, 0, 'integer', 31);
INSERT INTO `ocp_f_custom_fields` (`cf_default`, `cf_description`, `cf_encrypted`, `cf_locked`, `cf_name`, `cf_only_group`, `cf_order`, `cf_owner_set`, `cf_owner_view`, `cf_public_view`, `cf_required`, `cf_show_in_posts`, `cf_show_in_post_previews`, `cf_type`, `id`) VALUES('0', 434, 0, 1, 433, '', 31, 0, 0, 0, 0, 0, 0, 'integer', 32);
INSERT INTO `ocp_f_custom_fields` (`cf_default`, `cf_description`, `cf_encrypted`, `cf_locked`, `cf_name`, `cf_only_group`, `cf_order`, `cf_owner_set`, `cf_owner_view`, `cf_public_view`, `cf_required`, `cf_show_in_posts`, `cf_show_in_post_previews`, `cf_type`, `id`) VALUES('', 436, 0, 1, 435, '', 32, 0, 0, 0, 0, 0, 0, 'short_text', 33);
INSERT INTO `ocp_f_custom_fields` (`cf_default`, `cf_description`, `cf_encrypted`, `cf_locked`, `cf_name`, `cf_only_group`, `cf_order`, `cf_owner_set`, `cf_owner_view`, `cf_public_view`, `cf_required`, `cf_show_in_posts`, `cf_show_in_post_previews`, `cf_type`, `id`) VALUES('', 438, 0, 1, 437, '', 33, 1, 0, 0, 0, 0, 0, 'short_text', 34);
INSERT INTO `ocp_f_custom_fields` (`cf_default`, `cf_description`, `cf_encrypted`, `cf_locked`, `cf_name`, `cf_only_group`, `cf_order`, `cf_owner_set`, `cf_owner_view`, `cf_public_view`, `cf_required`, `cf_show_in_posts`, `cf_show_in_post_previews`, `cf_type`, `id`) VALUES('', 440, 0, 1, 439, '', 34, 1, 0, 0, 0, 0, 0, 'short_text', 35);

-- --------------------------------------------------------

--
-- Table structure for table `ocp_f_emoticons`
--

DROP TABLE IF EXISTS `ocp_f_emoticons`;
CREATE TABLE IF NOT EXISTS `ocp_f_emoticons` (
  `e_code` varchar(255) NOT NULL,
  `e_is_special` tinyint(1) NOT NULL,
  `e_relevance_level` int(11) NOT NULL,
  `e_theme_img_code` varchar(255) NOT NULL,
  `e_use_topics` tinyint(1) NOT NULL,
  PRIMARY KEY (`e_code`)
) ENGINE=MyISAM;

--
-- Dumping data for table `ocp_f_emoticons`
--

INSERT INTO `ocp_f_emoticons` (`e_code`, `e_is_special`, `e_relevance_level`, `e_theme_img_code`, `e_use_topics`) VALUES(':P', 0, 0, 'ocf_emoticons/cheeky', 1);
INSERT INTO `ocp_f_emoticons` (`e_code`, `e_is_special`, `e_relevance_level`, `e_theme_img_code`, `e_use_topics`) VALUES(':''(', 0, 0, 'ocf_emoticons/cry', 1);
INSERT INTO `ocp_f_emoticons` (`e_code`, `e_is_special`, `e_relevance_level`, `e_theme_img_code`, `e_use_topics`) VALUES(':dry:', 0, 0, 'ocf_emoticons/dry', 1);
INSERT INTO `ocp_f_emoticons` (`e_code`, `e_is_special`, `e_relevance_level`, `e_theme_img_code`, `e_use_topics`) VALUES(':$', 0, 0, 'ocf_emoticons/blush', 1);
INSERT INTO `ocp_f_emoticons` (`e_code`, `e_is_special`, `e_relevance_level`, `e_theme_img_code`, `e_use_topics`) VALUES(';)', 0, 0, 'ocf_emoticons/wink', 0);
INSERT INTO `ocp_f_emoticons` (`e_code`, `e_is_special`, `e_relevance_level`, `e_theme_img_code`, `e_use_topics`) VALUES('O_o', 0, 0, 'ocf_emoticons/blink', 1);
INSERT INTO `ocp_f_emoticons` (`e_code`, `e_is_special`, `e_relevance_level`, `e_theme_img_code`, `e_use_topics`) VALUES(':wub:', 0, 0, 'ocf_emoticons/wub', 1);
INSERT INTO `ocp_f_emoticons` (`e_code`, `e_is_special`, `e_relevance_level`, `e_theme_img_code`, `e_use_topics`) VALUES(':cool:', 0, 0, 'ocf_emoticons/cool', 1);
INSERT INTO `ocp_f_emoticons` (`e_code`, `e_is_special`, `e_relevance_level`, `e_theme_img_code`, `e_use_topics`) VALUES(':lol:', 0, 0, 'ocf_emoticons/lol', 1);
INSERT INTO `ocp_f_emoticons` (`e_code`, `e_is_special`, `e_relevance_level`, `e_theme_img_code`, `e_use_topics`) VALUES(':(', 0, 0, 'ocf_emoticons/sad', 1);
INSERT INTO `ocp_f_emoticons` (`e_code`, `e_is_special`, `e_relevance_level`, `e_theme_img_code`, `e_use_topics`) VALUES(':)', 0, 0, 'ocf_emoticons/smile', 0);
INSERT INTO `ocp_f_emoticons` (`e_code`, `e_is_special`, `e_relevance_level`, `e_theme_img_code`, `e_use_topics`) VALUES(':thumbs:', 0, 0, 'ocf_emoticons/thumbs', 1);
INSERT INTO `ocp_f_emoticons` (`e_code`, `e_is_special`, `e_relevance_level`, `e_theme_img_code`, `e_use_topics`) VALUES(':offtopic:', 0, 0, 'ocf_emoticons/offtopic', 0);
INSERT INTO `ocp_f_emoticons` (`e_code`, `e_is_special`, `e_relevance_level`, `e_theme_img_code`, `e_use_topics`) VALUES(':|', 0, 0, 'ocf_emoticons/mellow', 0);
INSERT INTO `ocp_f_emoticons` (`e_code`, `e_is_special`, `e_relevance_level`, `e_theme_img_code`, `e_use_topics`) VALUES(':ninja:', 0, 0, 'ocf_emoticons/ph34r', 1);
INSERT INTO `ocp_f_emoticons` (`e_code`, `e_is_special`, `e_relevance_level`, `e_theme_img_code`, `e_use_topics`) VALUES(':o', 0, 0, 'ocf_emoticons/shocked', 1);
INSERT INTO `ocp_f_emoticons` (`e_code`, `e_is_special`, `e_relevance_level`, `e_theme_img_code`, `e_use_topics`) VALUES(':rolleyes:', 0, 1, 'ocf_emoticons/rolleyes', 1);
INSERT INTO `ocp_f_emoticons` (`e_code`, `e_is_special`, `e_relevance_level`, `e_theme_img_code`, `e_use_topics`) VALUES(':D', 0, 1, 'ocf_emoticons/grin', 1);
INSERT INTO `ocp_f_emoticons` (`e_code`, `e_is_special`, `e_relevance_level`, `e_theme_img_code`, `e_use_topics`) VALUES('^_^', 0, 1, 'ocf_emoticons/glee', 1);
INSERT INTO `ocp_f_emoticons` (`e_code`, `e_is_special`, `e_relevance_level`, `e_theme_img_code`, `e_use_topics`) VALUES('(K)', 0, 1, 'ocf_emoticons/kiss', 0);
INSERT INTO `ocp_f_emoticons` (`e_code`, `e_is_special`, `e_relevance_level`, `e_theme_img_code`, `e_use_topics`) VALUES(':S', 0, 1, 'ocf_emoticons/confused', 1);
INSERT INTO `ocp_f_emoticons` (`e_code`, `e_is_special`, `e_relevance_level`, `e_theme_img_code`, `e_use_topics`) VALUES(':@', 0, 1, 'ocf_emoticons/angry', 1);
INSERT INTO `ocp_f_emoticons` (`e_code`, `e_is_special`, `e_relevance_level`, `e_theme_img_code`, `e_use_topics`) VALUES(':shake:', 0, 1, 'ocf_emoticons/shake', 1);
INSERT INTO `ocp_f_emoticons` (`e_code`, `e_is_special`, `e_relevance_level`, `e_theme_img_code`, `e_use_topics`) VALUES(':hand:', 0, 1, 'ocf_emoticons/hand', 1);
INSERT INTO `ocp_f_emoticons` (`e_code`, `e_is_special`, `e_relevance_level`, `e_theme_img_code`, `e_use_topics`) VALUES(':drool:', 0, 1, 'ocf_emoticons/drool', 1);
INSERT INTO `ocp_f_emoticons` (`e_code`, `e_is_special`, `e_relevance_level`, `e_theme_img_code`, `e_use_topics`) VALUES(':devil:', 0, 1, 'ocf_emoticons/devil', 1);
INSERT INTO `ocp_f_emoticons` (`e_code`, `e_is_special`, `e_relevance_level`, `e_theme_img_code`, `e_use_topics`) VALUES(':party:', 0, 1, 'ocf_emoticons/party', 0);
INSERT INTO `ocp_f_emoticons` (`e_code`, `e_is_special`, `e_relevance_level`, `e_theme_img_code`, `e_use_topics`) VALUES(':constipated:', 0, 1, 'ocf_emoticons/constipated', 1);
INSERT INTO `ocp_f_emoticons` (`e_code`, `e_is_special`, `e_relevance_level`, `e_theme_img_code`, `e_use_topics`) VALUES(':depressed:', 0, 1, 'ocf_emoticons/depressed', 1);
INSERT INTO `ocp_f_emoticons` (`e_code`, `e_is_special`, `e_relevance_level`, `e_theme_img_code`, `e_use_topics`) VALUES(':zzz:', 0, 1, 'ocf_emoticons/zzz', 1);
INSERT INTO `ocp_f_emoticons` (`e_code`, `e_is_special`, `e_relevance_level`, `e_theme_img_code`, `e_use_topics`) VALUES(':whistle:', 0, 1, 'ocf_emoticons/whistle', 0);
INSERT INTO `ocp_f_emoticons` (`e_code`, `e_is_special`, `e_relevance_level`, `e_theme_img_code`, `e_use_topics`) VALUES(':upsidedown:', 0, 1, 'ocf_emoticons/upsidedown', 1);
INSERT INTO `ocp_f_emoticons` (`e_code`, `e_is_special`, `e_relevance_level`, `e_theme_img_code`, `e_use_topics`) VALUES(':sick:', 0, 1, 'ocf_emoticons/sick', 1);
INSERT INTO `ocp_f_emoticons` (`e_code`, `e_is_special`, `e_relevance_level`, `e_theme_img_code`, `e_use_topics`) VALUES(':shutup:', 0, 1, 'ocf_emoticons/shutup', 0);
INSERT INTO `ocp_f_emoticons` (`e_code`, `e_is_special`, `e_relevance_level`, `e_theme_img_code`, `e_use_topics`) VALUES(':sarcy:', 0, 1, 'ocf_emoticons/sarcy', 1);
INSERT INTO `ocp_f_emoticons` (`e_code`, `e_is_special`, `e_relevance_level`, `e_theme_img_code`, `e_use_topics`) VALUES(':puppyeyes:', 0, 1, 'ocf_emoticons/puppyeyes', 1);
INSERT INTO `ocp_f_emoticons` (`e_code`, `e_is_special`, `e_relevance_level`, `e_theme_img_code`, `e_use_topics`) VALUES(':nod:', 0, 1, 'ocf_emoticons/nod', 0);
INSERT INTO `ocp_f_emoticons` (`e_code`, `e_is_special`, `e_relevance_level`, `e_theme_img_code`, `e_use_topics`) VALUES(':nerd:', 0, 1, 'ocf_emoticons/nerd', 1);
INSERT INTO `ocp_f_emoticons` (`e_code`, `e_is_special`, `e_relevance_level`, `e_theme_img_code`, `e_use_topics`) VALUES(':king:', 0, 1, 'ocf_emoticons/king', 1);
INSERT INTO `ocp_f_emoticons` (`e_code`, `e_is_special`, `e_relevance_level`, `e_theme_img_code`, `e_use_topics`) VALUES(':birthday:', 0, 1, 'ocf_emoticons/birthday', 1);
INSERT INTO `ocp_f_emoticons` (`e_code`, `e_is_special`, `e_relevance_level`, `e_theme_img_code`, `e_use_topics`) VALUES(':cyborg:', 0, 1, 'ocf_emoticons/cyborg', 0);
INSERT INTO `ocp_f_emoticons` (`e_code`, `e_is_special`, `e_relevance_level`, `e_theme_img_code`, `e_use_topics`) VALUES(':hippie:', 0, 1, 'ocf_emoticons/hippie', 1);
INSERT INTO `ocp_f_emoticons` (`e_code`, `e_is_special`, `e_relevance_level`, `e_theme_img_code`, `e_use_topics`) VALUES(':ninja2:', 0, 1, 'ocf_emoticons/ninja2', 1);
INSERT INTO `ocp_f_emoticons` (`e_code`, `e_is_special`, `e_relevance_level`, `e_theme_img_code`, `e_use_topics`) VALUES(':rockon:', 0, 1, 'ocf_emoticons/rockon', 0);
INSERT INTO `ocp_f_emoticons` (`e_code`, `e_is_special`, `e_relevance_level`, `e_theme_img_code`, `e_use_topics`) VALUES(':sinner:', 0, 1, 'ocf_emoticons/sinner', 0);
INSERT INTO `ocp_f_emoticons` (`e_code`, `e_is_special`, `e_relevance_level`, `e_theme_img_code`, `e_use_topics`) VALUES(':guitar:', 0, 1, 'ocf_emoticons/guitar', 0);
INSERT INTO `ocp_f_emoticons` (`e_code`, `e_is_special`, `e_relevance_level`, `e_theme_img_code`, `e_use_topics`) VALUES(':christmas:', 0, 1, 'ocf_emoticons/christmas', 0);

-- --------------------------------------------------------

--
-- Table structure for table `ocp_f_forums`
--

DROP TABLE IF EXISTS `ocp_f_forums`;
CREATE TABLE IF NOT EXISTS `ocp_f_forums` (
  `f_cache_last_forum_id` int(11) DEFAULT NULL,
  `f_cache_last_member_id` int(11) DEFAULT NULL,
  `f_cache_last_time` int(10) unsigned DEFAULT NULL,
  `f_cache_last_title` varchar(255) NOT NULL,
  `f_cache_last_topic_id` int(11) DEFAULT NULL,
  `f_cache_last_username` varchar(255) NOT NULL,
  `f_cache_num_posts` int(11) NOT NULL,
  `f_cache_num_topics` int(11) NOT NULL,
  `f_category_id` int(11) DEFAULT NULL,
  `f_description` int(10) unsigned NOT NULL,
  `f_intro_answer` varchar(255) NOT NULL,
  `f_intro_question` int(10) unsigned NOT NULL,
  `f_name` varchar(255) NOT NULL,
  `f_order` varchar(80) NOT NULL,
  `f_order_sub_alpha` tinyint(1) NOT NULL,
  `f_parent_forum` int(11) DEFAULT NULL,
  `f_position` int(11) NOT NULL,
  `f_post_count_increment` tinyint(1) NOT NULL,
  `f_redirection` varchar(255) NOT NULL,
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `subforum_parenting` (`f_parent_forum`)
) ENGINE=MyISAM  AUTO_INCREMENT=11 ;

--
-- Dumping data for table `ocp_f_forums`
--

INSERT INTO `ocp_f_forums` (`f_cache_last_forum_id`, `f_cache_last_member_id`, `f_cache_last_time`, `f_cache_last_title`, `f_cache_last_topic_id`, `f_cache_last_username`, `f_cache_num_posts`, `f_cache_num_topics`, `f_category_id`, `f_description`, `f_intro_answer`, `f_intro_question`, `f_name`, `f_order`, `f_order_sub_alpha`, `f_parent_forum`, `f_position`, `f_post_count_increment`, `f_redirection`, `id`) VALUES(1, 2, 1264693140, 'This topic acts as an announcement.', 5, 'admin', 1, 1, NULL, 54, '', 55, 'Forum home', 'last_post', 0, NULL, 1, 1, '', 1);
INSERT INTO `ocp_f_forums` (`f_cache_last_forum_id`, `f_cache_last_member_id`, `f_cache_last_time`, `f_cache_last_title`, `f_cache_last_topic_id`, `f_cache_last_username`, `f_cache_num_posts`, `f_cache_num_topics`, `f_category_id`, `f_description`, `f_intro_answer`, `f_intro_question`, `f_name`, `f_order`, `f_order_sub_alpha`, `f_parent_forum`, `f_position`, `f_post_count_increment`, `f_redirection`, `id`) VALUES(3, 2, 1265476759, 'This topic is pinned.', 8, 'admin', 7, 4, 1, 58, '', 59, 'General chat', 'last_post', 0, 1, 1, 1, '', 3);
INSERT INTO `ocp_f_forums` (`f_cache_last_forum_id`, `f_cache_last_member_id`, `f_cache_last_time`, `f_cache_last_title`, `f_cache_last_topic_id`, `f_cache_last_username`, `f_cache_num_posts`, `f_cache_num_topics`, `f_category_id`, `f_description`, `f_intro_answer`, `f_intro_question`, `f_name`, `f_order`, `f_order_sub_alpha`, `f_parent_forum`, `f_position`, `f_post_count_increment`, `f_redirection`, `id`) VALUES(NULL, NULL, NULL, '', NULL, '', 0, 0, 1, 60, 'ocPortal', 61, 'Feedback', 'last_post', 0, 1, 1, 1, '', 4);
INSERT INTO `ocp_f_forums` (`f_cache_last_forum_id`, `f_cache_last_member_id`, `f_cache_last_time`, `f_cache_last_title`, `f_cache_last_topic_id`, `f_cache_last_username`, `f_cache_num_posts`, `f_cache_num_topics`, `f_category_id`, `f_description`, `f_intro_answer`, `f_intro_question`, `f_name`, `f_order`, `f_order_sub_alpha`, `f_parent_forum`, `f_position`, `f_post_count_increment`, `f_redirection`, `id`) VALUES(5, 2, 1264694090, 'Reported post in ''Here is a topic with a poll.''', 7, 'admin', 1, 1, 2, 62, '', 63, 'Reported posts forum', 'last_post', 0, 1, 1, 1, '', 5);
INSERT INTO `ocp_f_forums` (`f_cache_last_forum_id`, `f_cache_last_member_id`, `f_cache_last_time`, `f_cache_last_title`, `f_cache_last_topic_id`, `f_cache_last_username`, `f_cache_num_posts`, `f_cache_num_topics`, `f_category_id`, `f_description`, `f_intro_answer`, `f_intro_question`, `f_name`, `f_order`, `f_order_sub_alpha`, `f_parent_forum`, `f_position`, `f_post_count_increment`, `f_redirection`, `id`) VALUES(NULL, NULL, NULL, '', NULL, '', 0, 0, 2, 64, '', 65, 'Trash', 'last_post', 0, 1, 1, 1, '', 6);
INSERT INTO `ocp_f_forums` (`f_cache_last_forum_id`, `f_cache_last_member_id`, `f_cache_last_time`, `f_cache_last_title`, `f_cache_last_topic_id`, `f_cache_last_username`, `f_cache_num_posts`, `f_cache_num_topics`, `f_category_id`, `f_description`, `f_intro_answer`, `f_intro_question`, `f_name`, `f_order`, `f_order_sub_alpha`, `f_parent_forum`, `f_position`, `f_post_count_increment`, `f_redirection`, `id`) VALUES(NULL, NULL, NULL, '', NULL, '', 0, 0, 1, 66, '', 67, 'Website comment topics', 'last_post', 0, 1, 1, 1, '', 7);
INSERT INTO `ocp_f_forums` (`f_cache_last_forum_id`, `f_cache_last_member_id`, `f_cache_last_time`, `f_cache_last_title`, `f_cache_last_topic_id`, `f_cache_last_username`, `f_cache_num_posts`, `f_cache_num_topics`, `f_category_id`, `f_description`, `f_intro_answer`, `f_intro_question`, `f_name`, `f_order`, `f_order_sub_alpha`, `f_parent_forum`, `f_position`, `f_post_count_increment`, `f_redirection`, `id`) VALUES(NULL, NULL, NULL, '', NULL, '', 0, 0, 2, 68, '', 69, 'Website support tickets', 'last_post', 0, 1, 1, 1, '', 8);
INSERT INTO `ocp_f_forums` (`f_cache_last_forum_id`, `f_cache_last_member_id`, `f_cache_last_time`, `f_cache_last_title`, `f_cache_last_topic_id`, `f_cache_last_username`, `f_cache_num_posts`, `f_cache_num_topics`, `f_category_id`, `f_description`, `f_intro_answer`, `f_intro_question`, `f_name`, `f_order`, `f_order_sub_alpha`, `f_parent_forum`, `f_position`, `f_post_count_increment`, `f_redirection`, `id`) VALUES(9, 1, 1264606808, 'Welcome to the forums', 1, 'System', 2, 2, 2, 70, '', 71, 'Staff', 'last_post', 0, 1, 1, 1, '', 9);
INSERT INTO `ocp_f_forums` (`f_cache_last_forum_id`, `f_cache_last_member_id`, `f_cache_last_time`, `f_cache_last_title`, `f_cache_last_topic_id`, `f_cache_last_username`, `f_cache_num_posts`, `f_cache_num_topics`, `f_category_id`, `f_description`, `f_intro_answer`, `f_intro_question`, `f_name`, `f_order`, `f_order_sub_alpha`, `f_parent_forum`, `f_position`, `f_post_count_increment`, `f_redirection`, `id`) VALUES(NULL, NULL, NULL, '', NULL, '', 0, 0, 2, 169, '', 170, 'Website "Contact Us" messages', 'last_post', 0, 1, 1, 1, '', 10);

-- --------------------------------------------------------

--
-- Table structure for table `ocp_f_forum_intro_ip`
--

DROP TABLE IF EXISTS `ocp_f_forum_intro_ip`;
CREATE TABLE IF NOT EXISTS `ocp_f_forum_intro_ip` (
  `i_forum_id` int(11) NOT NULL,
  `i_ip` varchar(40) NOT NULL,
  PRIMARY KEY (`i_forum_id`,`i_ip`)
) ENGINE=MyISAM;

--
-- Dumping data for table `ocp_f_forum_intro_ip`
--

INSERT INTO `ocp_f_forum_intro_ip` (`i_forum_id`, `i_ip`) VALUES(4, '90.152.0.*');

-- --------------------------------------------------------

--
-- Table structure for table `ocp_f_forum_intro_member`
--

DROP TABLE IF EXISTS `ocp_f_forum_intro_member`;
CREATE TABLE IF NOT EXISTS `ocp_f_forum_intro_member` (
  `i_forum_id` int(11) NOT NULL,
  `i_member_id` int(11) NOT NULL,
  PRIMARY KEY (`i_forum_id`,`i_member_id`)
) ENGINE=MyISAM;

--
-- Dumping data for table `ocp_f_forum_intro_member`
--

INSERT INTO `ocp_f_forum_intro_member` (`i_forum_id`, `i_member_id`) VALUES(4, 2);

-- --------------------------------------------------------

--
-- Table structure for table `ocp_f_forum_tracking`
--

DROP TABLE IF EXISTS `ocp_f_forum_tracking`;
CREATE TABLE IF NOT EXISTS `ocp_f_forum_tracking` (
  `r_forum_id` int(11) NOT NULL,
  `r_member_id` int(11) NOT NULL,
  PRIMARY KEY (`r_forum_id`,`r_member_id`)
) ENGINE=MyISAM;

--
-- Dumping data for table `ocp_f_forum_tracking`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_f_groups`
--

DROP TABLE IF EXISTS `ocp_f_groups`;
CREATE TABLE IF NOT EXISTS `ocp_f_groups` (
  `g_enquire_on_new_ips` tinyint(1) NOT NULL,
  `g_flood_control_access_secs` int(11) NOT NULL,
  `g_flood_control_submit_secs` int(11) NOT NULL,
  `g_gift_points_base` int(11) NOT NULL,
  `g_gift_points_per_day` int(11) NOT NULL,
  `g_group_leader` int(11) DEFAULT NULL,
  `g_hidden` tinyint(1) NOT NULL,
  `g_is_default` tinyint(1) NOT NULL,
  `g_is_presented_at_install` tinyint(1) NOT NULL,
  `g_is_private_club` tinyint(1) NOT NULL,
  `g_is_super_admin` tinyint(1) NOT NULL,
  `g_is_super_moderator` tinyint(1) NOT NULL,
  `g_max_attachments_per_post` int(11) NOT NULL,
  `g_max_avatar_height` int(11) NOT NULL,
  `g_max_avatar_width` int(11) NOT NULL,
  `g_max_daily_upload_mb` int(11) NOT NULL,
  `g_max_post_length_comcode` int(11) NOT NULL,
  `g_max_sig_length_comcode` int(11) NOT NULL,
  `g_name` int(10) unsigned NOT NULL,
  `g_open_membership` tinyint(1) NOT NULL,
  `g_order` int(11) NOT NULL,
  `g_promotion_target` int(11) DEFAULT NULL,
  `g_promotion_threshold` int(11) DEFAULT NULL,
  `g_rank_image` varchar(80) NOT NULL,
  `g_rank_image_pri_only` tinyint(1) NOT NULL,
  `g_title` int(10) unsigned NOT NULL,
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  AUTO_INCREMENT=11 ;

--
-- Dumping data for table `ocp_f_groups`
--

INSERT INTO `ocp_f_groups` (`g_enquire_on_new_ips`, `g_flood_control_access_secs`, `g_flood_control_submit_secs`, `g_gift_points_base`, `g_gift_points_per_day`, `g_group_leader`, `g_hidden`, `g_is_default`, `g_is_presented_at_install`, `g_is_private_club`, `g_is_super_admin`, `g_is_super_moderator`, `g_max_attachments_per_post`, `g_max_avatar_height`, `g_max_avatar_width`, `g_max_daily_upload_mb`, `g_max_post_length_comcode`, `g_max_sig_length_comcode`, `g_name`, `g_open_membership`, `g_order`, `g_promotion_target`, `g_promotion_threshold`, `g_rank_image`, `g_rank_image_pri_only`, `g_title`, `id`) VALUES(0, 0, 5, 25, 1, NULL, 0, 0, 0, 0, 0, 0, 5, 100, 100, 5, 30000, 700, 34, 0, 0, NULL, NULL, '', 1, 35, 1);
INSERT INTO `ocp_f_groups` (`g_enquire_on_new_ips`, `g_flood_control_access_secs`, `g_flood_control_submit_secs`, `g_gift_points_base`, `g_gift_points_per_day`, `g_group_leader`, `g_hidden`, `g_is_default`, `g_is_presented_at_install`, `g_is_private_club`, `g_is_super_admin`, `g_is_super_moderator`, `g_max_attachments_per_post`, `g_max_avatar_height`, `g_max_avatar_width`, `g_max_daily_upload_mb`, `g_max_post_length_comcode`, `g_max_sig_length_comcode`, `g_name`, `g_open_membership`, `g_order`, `g_promotion_target`, `g_promotion_threshold`, `g_rank_image`, `g_rank_image_pri_only`, `g_title`, `id`) VALUES(0, 0, 0, 25, 1, NULL, 0, 0, 0, 0, 1, 0, 5, 100, 100, 5, 30000, 700, 36, 0, 1, NULL, NULL, 'ocf_rank_images/admin', 1, 37, 2);
INSERT INTO `ocp_f_groups` (`g_enquire_on_new_ips`, `g_flood_control_access_secs`, `g_flood_control_submit_secs`, `g_gift_points_base`, `g_gift_points_per_day`, `g_group_leader`, `g_hidden`, `g_is_default`, `g_is_presented_at_install`, `g_is_private_club`, `g_is_super_admin`, `g_is_super_moderator`, `g_max_attachments_per_post`, `g_max_avatar_height`, `g_max_avatar_width`, `g_max_daily_upload_mb`, `g_max_post_length_comcode`, `g_max_sig_length_comcode`, `g_name`, `g_open_membership`, `g_order`, `g_promotion_target`, `g_promotion_threshold`, `g_rank_image`, `g_rank_image_pri_only`, `g_title`, `id`) VALUES(0, 0, 0, 25, 1, NULL, 0, 0, 0, 0, 0, 1, 5, 100, 100, 5, 30000, 700, 38, 0, 2, NULL, NULL, 'ocf_rank_images/mod', 1, 39, 3);
INSERT INTO `ocp_f_groups` (`g_enquire_on_new_ips`, `g_flood_control_access_secs`, `g_flood_control_submit_secs`, `g_gift_points_base`, `g_gift_points_per_day`, `g_group_leader`, `g_hidden`, `g_is_default`, `g_is_presented_at_install`, `g_is_private_club`, `g_is_super_admin`, `g_is_super_moderator`, `g_max_attachments_per_post`, `g_max_avatar_height`, `g_max_avatar_width`, `g_max_daily_upload_mb`, `g_max_post_length_comcode`, `g_max_sig_length_comcode`, `g_name`, `g_open_membership`, `g_order`, `g_promotion_target`, `g_promotion_threshold`, `g_rank_image`, `g_rank_image_pri_only`, `g_title`, `id`) VALUES(0, 0, 0, 25, 1, NULL, 0, 0, 0, 0, 0, 0, 5, 100, 100, 5, 30000, 700, 40, 0, 3, NULL, NULL, '', 1, 41, 4);
INSERT INTO `ocp_f_groups` (`g_enquire_on_new_ips`, `g_flood_control_access_secs`, `g_flood_control_submit_secs`, `g_gift_points_base`, `g_gift_points_per_day`, `g_group_leader`, `g_hidden`, `g_is_default`, `g_is_presented_at_install`, `g_is_private_club`, `g_is_super_admin`, `g_is_super_moderator`, `g_max_attachments_per_post`, `g_max_avatar_height`, `g_max_avatar_width`, `g_max_daily_upload_mb`, `g_max_post_length_comcode`, `g_max_sig_length_comcode`, `g_name`, `g_open_membership`, `g_order`, `g_promotion_target`, `g_promotion_threshold`, `g_rank_image`, `g_rank_image_pri_only`, `g_title`, `id`) VALUES(0, 0, 5, 25, 1, NULL, 0, 0, 0, 0, 0, 0, 5, 100, 100, 5, 30000, 700, 42, 0, 4, NULL, NULL, 'ocf_rank_images/4', 1, 43, 5);
INSERT INTO `ocp_f_groups` (`g_enquire_on_new_ips`, `g_flood_control_access_secs`, `g_flood_control_submit_secs`, `g_gift_points_base`, `g_gift_points_per_day`, `g_group_leader`, `g_hidden`, `g_is_default`, `g_is_presented_at_install`, `g_is_private_club`, `g_is_super_admin`, `g_is_super_moderator`, `g_max_attachments_per_post`, `g_max_avatar_height`, `g_max_avatar_width`, `g_max_daily_upload_mb`, `g_max_post_length_comcode`, `g_max_sig_length_comcode`, `g_name`, `g_open_membership`, `g_order`, `g_promotion_target`, `g_promotion_threshold`, `g_rank_image`, `g_rank_image_pri_only`, `g_title`, `id`) VALUES(0, 0, 5, 25, 1, NULL, 0, 0, 0, 0, 0, 0, 5, 100, 100, 5, 30000, 700, 44, 0, 5, 5, 10000, 'ocf_rank_images/3', 1, 45, 6);
INSERT INTO `ocp_f_groups` (`g_enquire_on_new_ips`, `g_flood_control_access_secs`, `g_flood_control_submit_secs`, `g_gift_points_base`, `g_gift_points_per_day`, `g_group_leader`, `g_hidden`, `g_is_default`, `g_is_presented_at_install`, `g_is_private_club`, `g_is_super_admin`, `g_is_super_moderator`, `g_max_attachments_per_post`, `g_max_avatar_height`, `g_max_avatar_width`, `g_max_daily_upload_mb`, `g_max_post_length_comcode`, `g_max_sig_length_comcode`, `g_name`, `g_open_membership`, `g_order`, `g_promotion_target`, `g_promotion_threshold`, `g_rank_image`, `g_rank_image_pri_only`, `g_title`, `id`) VALUES(0, 0, 5, 25, 1, NULL, 0, 0, 0, 0, 0, 0, 5, 100, 100, 5, 30000, 700, 46, 0, 6, 6, 2500, 'ocf_rank_images/2', 1, 47, 7);
INSERT INTO `ocp_f_groups` (`g_enquire_on_new_ips`, `g_flood_control_access_secs`, `g_flood_control_submit_secs`, `g_gift_points_base`, `g_gift_points_per_day`, `g_group_leader`, `g_hidden`, `g_is_default`, `g_is_presented_at_install`, `g_is_private_club`, `g_is_super_admin`, `g_is_super_moderator`, `g_max_attachments_per_post`, `g_max_avatar_height`, `g_max_avatar_width`, `g_max_daily_upload_mb`, `g_max_post_length_comcode`, `g_max_sig_length_comcode`, `g_name`, `g_open_membership`, `g_order`, `g_promotion_target`, `g_promotion_threshold`, `g_rank_image`, `g_rank_image_pri_only`, `g_title`, `id`) VALUES(0, 0, 5, 25, 1, NULL, 0, 0, 0, 0, 0, 0, 5, 100, 100, 5, 30000, 700, 48, 0, 7, 7, 400, 'ocf_rank_images/1', 1, 49, 8);
INSERT INTO `ocp_f_groups` (`g_enquire_on_new_ips`, `g_flood_control_access_secs`, `g_flood_control_submit_secs`, `g_gift_points_base`, `g_gift_points_per_day`, `g_group_leader`, `g_hidden`, `g_is_default`, `g_is_presented_at_install`, `g_is_private_club`, `g_is_super_admin`, `g_is_super_moderator`, `g_max_attachments_per_post`, `g_max_avatar_height`, `g_max_avatar_width`, `g_max_daily_upload_mb`, `g_max_post_length_comcode`, `g_max_sig_length_comcode`, `g_name`, `g_open_membership`, `g_order`, `g_promotion_target`, `g_promotion_threshold`, `g_rank_image`, `g_rank_image_pri_only`, `g_title`, `id`) VALUES(0, 0, 5, 25, 1, NULL, 0, 0, 0, 0, 0, 0, 5, 100, 100, 5, 30000, 700, 50, 0, 8, 8, 100, 'ocf_rank_images/0', 1, 51, 9);
INSERT INTO `ocp_f_groups` (`g_enquire_on_new_ips`, `g_flood_control_access_secs`, `g_flood_control_submit_secs`, `g_gift_points_base`, `g_gift_points_per_day`, `g_group_leader`, `g_hidden`, `g_is_default`, `g_is_presented_at_install`, `g_is_private_club`, `g_is_super_admin`, `g_is_super_moderator`, `g_max_attachments_per_post`, `g_max_avatar_height`, `g_max_avatar_width`, `g_max_daily_upload_mb`, `g_max_post_length_comcode`, `g_max_sig_length_comcode`, `g_name`, `g_open_membership`, `g_order`, `g_promotion_target`, `g_promotion_threshold`, `g_rank_image`, `g_rank_image_pri_only`, `g_title`, `id`) VALUES(0, 0, 0, 25, 1, NULL, 0, 0, 0, 0, 0, 0, 5, 100, 100, 5, 30000, 700, 52, 0, 9, NULL, NULL, '', 1, 53, 10);

-- --------------------------------------------------------

--
-- Table structure for table `ocp_f_group_members`
--

DROP TABLE IF EXISTS `ocp_f_group_members`;
CREATE TABLE IF NOT EXISTS `ocp_f_group_members` (
  `gm_group_id` int(11) NOT NULL,
  `gm_member_id` int(11) NOT NULL,
  `gm_validated` tinyint(1) NOT NULL,
  PRIMARY KEY (`gm_group_id`,`gm_member_id`),
  KEY `gm_validated` (`gm_validated`)
) ENGINE=MyISAM;

--
-- Dumping data for table `ocp_f_group_members`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_f_invites`
--

DROP TABLE IF EXISTS `ocp_f_invites`;
CREATE TABLE IF NOT EXISTS `ocp_f_invites` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `i_email_address` varchar(255) NOT NULL,
  `i_inviter` int(11) NOT NULL,
  `i_taken` tinyint(1) NOT NULL,
  `i_time` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 ;

--
-- Dumping data for table `ocp_f_invites`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_f_members`
--

DROP TABLE IF EXISTS `ocp_f_members`;
CREATE TABLE IF NOT EXISTS `ocp_f_members` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `m_allow_emails` tinyint(1) NOT NULL,
  `m_avatar_url` varchar(255) NOT NULL,
  `m_cache_num_posts` int(11) NOT NULL,
  `m_cache_warnings` int(11) NOT NULL,
  `m_dob_day` int(11) DEFAULT NULL,
  `m_dob_month` int(11) DEFAULT NULL,
  `m_dob_year` int(11) DEFAULT NULL,
  `m_email_address` varchar(255) NOT NULL,
  `m_highlighted_name` tinyint(1) NOT NULL,
  `m_ip_address` varchar(40) NOT NULL,
  `m_is_perm_banned` tinyint(1) NOT NULL,
  `m_join_time` int(10) unsigned NOT NULL,
  `m_language` varchar(80) NOT NULL,
  `m_last_submit_time` int(10) unsigned NOT NULL,
  `m_last_visit_time` int(10) unsigned NOT NULL,
  `m_max_email_attach_size_mb` int(11) NOT NULL,
  `m_notes` longtext NOT NULL,
  `m_on_probation_until` int(10) unsigned DEFAULT NULL,
  `m_password_change_code` varchar(255) NOT NULL,
  `m_password_compat_scheme` varchar(80) NOT NULL,
  `m_pass_hash_salted` varchar(255) NOT NULL,
  `m_pass_salt` varchar(255) NOT NULL,
  `m_photo_thumb_url` varchar(255) NOT NULL,
  `m_photo_url` varchar(255) NOT NULL,
  `m_preview_posts` tinyint(1) NOT NULL,
  `m_primary_group` int(11) NOT NULL,
  `m_pt_allow` varchar(255) NOT NULL,
  `m_pt_rules_text` int(10) unsigned NOT NULL,
  `m_reveal_age` tinyint(1) NOT NULL,
  `m_signature` int(10) unsigned NOT NULL,
  `m_theme` varchar(80) NOT NULL,
  `m_timezone_offset` int(11) NOT NULL,
  `m_title` varchar(255) NOT NULL,
  `m_track_contributed_topics` tinyint(1) NOT NULL,
  `m_username` varchar(80) NOT NULL,
  `m_validated` tinyint(1) NOT NULL,
  `m_validated_email_confirm_code` varchar(255) NOT NULL,
  `m_views_signatures` tinyint(1) NOT NULL,
  `m_zone_wide` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `birthdays` (`m_dob_day`,`m_dob_month`),
  KEY `sort_post_count` (`m_cache_num_posts`),
  KEY `user_list` (`m_username`),
  KEY `whos_validated` (`m_validated`),
  FULLTEXT KEY `search_user` (`m_username`)
) ENGINE=MyISAM  AUTO_INCREMENT=4 ;

--
-- Dumping data for table `ocp_f_members`
--

INSERT INTO `ocp_f_members` (`id`, `m_allow_emails`, `m_avatar_url`, `m_cache_num_posts`, `m_cache_warnings`, `m_dob_day`, `m_dob_month`, `m_dob_year`, `m_email_address`, `m_highlighted_name`, `m_ip_address`, `m_is_perm_banned`, `m_join_time`, `m_language`, `m_last_submit_time`, `m_last_visit_time`, `m_max_email_attach_size_mb`, `m_notes`, `m_on_probation_until`, `m_password_change_code`, `m_password_compat_scheme`, `m_pass_hash_salted`, `m_pass_salt`, `m_photo_thumb_url`, `m_photo_url`, `m_preview_posts`, `m_primary_group`, `m_pt_allow`, `m_pt_rules_text`, `m_reveal_age`, `m_signature`, `m_theme`, `m_timezone_offset`, `m_title`, `m_track_contributed_topics`, `m_username`, `m_validated`, `m_validated_email_confirm_code`, `m_views_signatures`, `m_zone_wide`) VALUES(1, 1, '', 1, 0, NULL, NULL, NULL, '', 0, '0000:0000:0000:0000:0000:0000:0000:0001', 0, 1264606805, '', 1265488502, 1265488502, 5, '', 1264606807, '', '', '7679a5bcb05e2076d658d3af9374fab5', '4b605e55dd1b6', '', '', 1, 1, '*', 74, 1, 73, '', 0, '', 0, 'Guest', 1, '', 1, 1);
INSERT INTO `ocp_f_members` (`id`, `m_allow_emails`, `m_avatar_url`, `m_cache_num_posts`, `m_cache_warnings`, `m_dob_day`, `m_dob_month`, `m_dob_year`, `m_email_address`, `m_highlighted_name`, `m_ip_address`, `m_is_perm_banned`, `m_join_time`, `m_language`, `m_last_submit_time`, `m_last_visit_time`, `m_max_email_attach_size_mb`, `m_notes`, `m_on_probation_until`, `m_password_change_code`, `m_password_compat_scheme`, `m_pass_hash_salted`, `m_pass_salt`, `m_photo_thumb_url`, `m_photo_url`, `m_preview_posts`, `m_primary_group`, `m_pt_allow`, `m_pt_rules_text`, `m_reveal_age`, `m_signature`, `m_theme`, `m_timezone_offset`, `m_title`, `m_track_contributed_topics`, `m_username`, `m_validated`, `m_validated_email_confirm_code`, `m_views_signatures`, `m_zone_wide`) VALUES(2, 1, 'themes/default/images/ocf_default_avatars/default_set/cool_flare.png', 11, 0, NULL, NULL, NULL, '', 0, '0000:0000:0000:0000:0000:0000:0000:0001', 0, 1264606808, '', 1265480596, 1265488566, 5, '', 1264606808, '', 'plain', 'demo123', '', '', '', 0, 2, '*', 79, 1, 78, '', 0, '', 0, 'admin', 1, '', 1, 1);
INSERT INTO `ocp_f_members` (`id`, `m_allow_emails`, `m_avatar_url`, `m_cache_num_posts`, `m_cache_warnings`, `m_dob_day`, `m_dob_month`, `m_dob_year`, `m_email_address`, `m_highlighted_name`, `m_ip_address`, `m_is_perm_banned`, `m_join_time`, `m_language`, `m_last_submit_time`, `m_last_visit_time`, `m_max_email_attach_size_mb`, `m_notes`, `m_on_probation_until`, `m_password_change_code`, `m_password_compat_scheme`, `m_pass_hash_salted`, `m_pass_salt`, `m_photo_thumb_url`, `m_photo_url`, `m_preview_posts`, `m_primary_group`, `m_pt_allow`, `m_pt_rules_text`, `m_reveal_age`, `m_signature`, `m_theme`, `m_timezone_offset`, `m_title`, `m_track_contributed_topics`, `m_username`, `m_validated`, `m_validated_email_confirm_code`, `m_views_signatures`, `m_zone_wide`) VALUES(3, 1, '', 0, 0, NULL, NULL, NULL, '', 0, '90.152.0.114', 0, 1264606808, '', 1264606808, 1264606808, 5, '', 1264606808, '', '', '04a1fbca2beb7af7afa3326467b7d22f', '4b605e5804484', '', '', 0, 9, '*', 84, 1, 83, '', 0, '', 0, 'test', 1, '', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `ocp_f_member_cpf_perms`
--

DROP TABLE IF EXISTS `ocp_f_member_cpf_perms`;
CREATE TABLE IF NOT EXISTS `ocp_f_member_cpf_perms` (
  `field_id` int(11) NOT NULL,
  `friend_view` tinyint(1) NOT NULL,
  `group_view` varchar(255) NOT NULL,
  `guest_view` tinyint(1) NOT NULL,
  `member_id` int(11) NOT NULL,
  `member_view` tinyint(1) NOT NULL,
  PRIMARY KEY (`field_id`,`member_id`)
) ENGINE=MyISAM;

--
-- Dumping data for table `ocp_f_member_cpf_perms`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_f_member_custom_fields`
--

DROP TABLE IF EXISTS `ocp_f_member_custom_fields`;
CREATE TABLE IF NOT EXISTS `ocp_f_member_custom_fields` (
  `field_1` int(10) unsigned DEFAULT NULL,
  `field_10` varchar(255) NOT NULL,
  `field_11` int(11) DEFAULT NULL,
  `field_12` int(11) DEFAULT NULL,
  `field_13` varchar(255) NOT NULL,
  `field_14` longtext NOT NULL,
  `field_15` longtext NOT NULL,
  `field_16` int(11) DEFAULT NULL,
  `field_17` longtext NOT NULL,
  `field_18` longtext NOT NULL,
  `field_19` longtext NOT NULL,
  `field_2` varchar(255) NOT NULL,
  `field_20` longtext NOT NULL,
  `field_21` varchar(255) NOT NULL,
  `field_22` varchar(255) NOT NULL,
  `field_23` longtext NOT NULL,
  `field_24` varchar(255) NOT NULL,
  `field_25` varchar(255) NOT NULL,
  `field_26` varchar(255) NOT NULL,
  `field_27` varchar(255) NOT NULL,
  `field_28` int(11) DEFAULT NULL,
  `field_29` int(11) DEFAULT NULL,
  `field_3` varchar(255) NOT NULL,
  `field_30` int(11) DEFAULT NULL,
  `field_31` int(11) DEFAULT NULL,
  `field_32` int(11) DEFAULT NULL,
  `field_33` varchar(255) NOT NULL,
  `field_34` varchar(255) NOT NULL,
  `field_35` varchar(255) NOT NULL,
  `field_4` varchar(255) NOT NULL,
  `field_5` varchar(255) NOT NULL,
  `field_6` int(10) unsigned DEFAULT NULL,
  `field_7` varchar(255) NOT NULL,
  `field_8` varchar(255) NOT NULL,
  `field_9` int(10) unsigned DEFAULT NULL,
  `mf_member_id` int(11) NOT NULL,
  PRIMARY KEY (`mf_member_id`),
  FULLTEXT KEY `mcf10` (`field_10`),
  FULLTEXT KEY `mcf13` (`field_13`),
  FULLTEXT KEY `mcf14` (`field_14`),
  FULLTEXT KEY `mcf15` (`field_15`),
  FULLTEXT KEY `mcf17` (`field_17`),
  FULLTEXT KEY `mcf18` (`field_18`),
  FULLTEXT KEY `mcf19` (`field_19`),
  FULLTEXT KEY `mcf2` (`field_2`),
  FULLTEXT KEY `mcf20` (`field_20`),
  FULLTEXT KEY `mcf21` (`field_21`),
  FULLTEXT KEY `mcf22` (`field_22`),
  FULLTEXT KEY `mcf23` (`field_23`),
  FULLTEXT KEY `mcf24` (`field_24`),
  FULLTEXT KEY `mcf25` (`field_25`),
  FULLTEXT KEY `mcf26` (`field_26`),
  FULLTEXT KEY `mcf27` (`field_27`),
  FULLTEXT KEY `mcf3` (`field_3`),
  FULLTEXT KEY `mcf33` (`field_33`),
  FULLTEXT KEY `mcf34` (`field_34`),
  FULLTEXT KEY `mcf35` (`field_35`),
  FULLTEXT KEY `mcf4` (`field_4`),
  FULLTEXT KEY `mcf5` (`field_5`),
  FULLTEXT KEY `mcf7` (`field_7`),
  FULLTEXT KEY `mcf8` (`field_8`)
) ENGINE=MyISAM;

--
-- Dumping data for table `ocp_f_member_custom_fields`
--

INSERT INTO `ocp_f_member_custom_fields` (`field_1`, `field_10`, `field_11`, `field_12`, `field_13`, `field_14`, `field_15`, `field_16`, `field_17`, `field_18`, `field_19`, `field_2`, `field_20`, `field_21`, `field_22`, `field_23`, `field_24`, `field_25`, `field_26`, `field_27`, `field_28`, `field_29`, `field_3`, `field_30`, `field_31`, `field_32`, `field_33`, `field_34`, `field_35`, `field_4`, `field_5`, `field_6`, `field_7`, `field_8`, `field_9`, `mf_member_id`) VALUES(75, '', NULL, NULL, '', '', '', NULL, '', '', '', '', '', '', '', '', '', '', '', '', NULL, NULL, '', NULL, NULL, NULL, '', '', '', '', '', 76, '', '', 77, 1);
INSERT INTO `ocp_f_member_custom_fields` (`field_1`, `field_10`, `field_11`, `field_12`, `field_13`, `field_14`, `field_15`, `field_16`, `field_17`, `field_18`, `field_19`, `field_2`, `field_20`, `field_21`, `field_22`, `field_23`, `field_24`, `field_25`, `field_26`, `field_27`, `field_28`, `field_29`, `field_3`, `field_30`, `field_31`, `field_32`, `field_33`, `field_34`, `field_35`, `field_4`, `field_5`, `field_6`, `field_7`, `field_8`, `field_9`, `mf_member_id`) VALUES(80, '', 2, NULL, '', '', '', NULL, '', '', '', '', '', '', '', '', '', '', '', '', 6, NULL, '', 1370, NULL, NULL, '', '', '', '', '', 81, '', '', 82, 2);
INSERT INTO `ocp_f_member_custom_fields` (`field_1`, `field_10`, `field_11`, `field_12`, `field_13`, `field_14`, `field_15`, `field_16`, `field_17`, `field_18`, `field_19`, `field_2`, `field_20`, `field_21`, `field_22`, `field_23`, `field_24`, `field_25`, `field_26`, `field_27`, `field_28`, `field_29`, `field_3`, `field_30`, `field_31`, `field_32`, `field_33`, `field_34`, `field_35`, `field_4`, `field_5`, `field_6`, `field_7`, `field_8`, `field_9`, `mf_member_id`) VALUES(85, '', NULL, NULL, '', '', '', NULL, '', '', '', '', '', '', '', '', '', '', '', '', NULL, NULL, '', NULL, NULL, NULL, '', '', '', '', '', 86, '', '', 87, 3);

-- --------------------------------------------------------

--
-- Table structure for table `ocp_f_member_known_login_ips`
--

DROP TABLE IF EXISTS `ocp_f_member_known_login_ips`;
CREATE TABLE IF NOT EXISTS `ocp_f_member_known_login_ips` (
  `i_ip` varchar(40) NOT NULL,
  `i_member_id` int(11) NOT NULL,
  `i_val_code` varchar(255) NOT NULL,
  PRIMARY KEY (`i_ip`,`i_member_id`)
) ENGINE=MyISAM;

--
-- Dumping data for table `ocp_f_member_known_login_ips`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_f_moderator_logs`
--

DROP TABLE IF EXISTS `ocp_f_moderator_logs`;
CREATE TABLE IF NOT EXISTS `ocp_f_moderator_logs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `l_by` int(11) NOT NULL,
  `l_date_and_time` int(10) unsigned NOT NULL,
  `l_param_a` varchar(255) NOT NULL,
  `l_param_b` varchar(255) NOT NULL,
  `l_reason` longtext NOT NULL,
  `l_the_type` varchar(80) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  AUTO_INCREMENT=3 ;

--
-- Dumping data for table `ocp_f_moderator_logs`
--

INSERT INTO `ocp_f_moderator_logs` (`id`, `l_by`, `l_date_and_time`, `l_param_a`, `l_param_b`, `l_reason`, `l_the_type`) VALUES(1, 2, 1264692888, '4', 'This topic contains a whisper.', '', 'EDIT_TOPIC');
INSERT INTO `ocp_f_moderator_logs` (`id`, `l_by`, `l_date_and_time`, `l_param_a`, `l_param_b`, `l_reason`, `l_the_type`) VALUES(2, 2, 1265476759, '8', 'This topic is pinned.', '', 'EDIT_TOPIC');

-- --------------------------------------------------------

--
-- Table structure for table `ocp_f_multi_moderations`
--

DROP TABLE IF EXISTS `ocp_f_multi_moderations`;
CREATE TABLE IF NOT EXISTS `ocp_f_multi_moderations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `mm_forum_multi_code` varchar(255) NOT NULL,
  `mm_move_to` int(11) DEFAULT NULL,
  `mm_name` int(10) unsigned NOT NULL,
  `mm_open_state` tinyint(1) DEFAULT NULL,
  `mm_pin_state` tinyint(1) DEFAULT NULL,
  `mm_post_text` longtext NOT NULL,
  `mm_sink_state` tinyint(1) DEFAULT NULL,
  `mm_title_suffix` varchar(255) NOT NULL,
  PRIMARY KEY (`id`,`mm_name`)
) ENGINE=MyISAM  AUTO_INCREMENT=2 ;

--
-- Dumping data for table `ocp_f_multi_moderations`
--

INSERT INTO `ocp_f_multi_moderations` (`id`, `mm_forum_multi_code`, `mm_move_to`, `mm_name`, `mm_open_state`, `mm_pin_state`, `mm_post_text`, `mm_sink_state`, `mm_title_suffix`) VALUES(1, '*', 6, 72, 0, 0, '', 0, '');

-- --------------------------------------------------------

--
-- Table structure for table `ocp_f_polls`
--

DROP TABLE IF EXISTS `ocp_f_polls`;
CREATE TABLE IF NOT EXISTS `ocp_f_polls` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `po_cache_total_votes` int(11) NOT NULL,
  `po_is_open` tinyint(1) NOT NULL,
  `po_is_private` tinyint(1) NOT NULL,
  `po_maximum_selections` int(11) NOT NULL,
  `po_minimum_selections` int(11) NOT NULL,
  `po_question` varchar(255) NOT NULL,
  `po_requires_reply` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  AUTO_INCREMENT=2 ;

--
-- Dumping data for table `ocp_f_polls`
--

INSERT INTO `ocp_f_polls` (`id`, `po_cache_total_votes`, `po_is_open`, `po_is_private`, `po_maximum_selections`, `po_minimum_selections`, `po_question`, `po_requires_reply`) VALUES(1, 1, 1, 0, 1, 1, 'Do you like my poll?', 0);

-- --------------------------------------------------------

--
-- Table structure for table `ocp_f_poll_answers`
--

DROP TABLE IF EXISTS `ocp_f_poll_answers`;
CREATE TABLE IF NOT EXISTS `ocp_f_poll_answers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pa_answer` varchar(255) NOT NULL,
  `pa_cache_num_votes` int(11) NOT NULL,
  `pa_poll_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  AUTO_INCREMENT=3 ;

--
-- Dumping data for table `ocp_f_poll_answers`
--

INSERT INTO `ocp_f_poll_answers` (`id`, `pa_answer`, `pa_cache_num_votes`, `pa_poll_id`) VALUES(1, 'Yes', 1, 1);
INSERT INTO `ocp_f_poll_answers` (`id`, `pa_answer`, `pa_cache_num_votes`, `pa_poll_id`) VALUES(2, 'No', 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `ocp_f_poll_votes`
--

DROP TABLE IF EXISTS `ocp_f_poll_votes`;
CREATE TABLE IF NOT EXISTS `ocp_f_poll_votes` (
  `pv_answer_id` int(11) NOT NULL,
  `pv_member_id` int(11) NOT NULL,
  `pv_poll_id` int(11) NOT NULL,
  PRIMARY KEY (`pv_answer_id`,`pv_member_id`,`pv_poll_id`)
) ENGINE=MyISAM;

--
-- Dumping data for table `ocp_f_poll_votes`
--

INSERT INTO `ocp_f_poll_votes` (`pv_answer_id`, `pv_member_id`, `pv_poll_id`) VALUES(1, 2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `ocp_f_posts`
--

DROP TABLE IF EXISTS `ocp_f_posts`;
CREATE TABLE IF NOT EXISTS `ocp_f_posts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `p_cache_forum_id` int(11) DEFAULT NULL,
  `p_intended_solely_for` int(11) DEFAULT NULL,
  `p_ip_address` varchar(40) NOT NULL,
  `p_is_emphasised` tinyint(1) NOT NULL,
  `p_last_edit_by` int(11) DEFAULT NULL,
  `p_last_edit_time` int(10) unsigned DEFAULT NULL,
  `p_post` int(10) unsigned NOT NULL,
  `p_poster` int(11) NOT NULL,
  `p_poster_name_if_guest` varchar(80) NOT NULL,
  `p_skip_sig` tinyint(1) NOT NULL,
  `p_time` int(10) unsigned NOT NULL,
  `p_title` varchar(255) NOT NULL,
  `p_topic_id` int(11) NOT NULL,
  `p_validated` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `find_pp` (`p_intended_solely_for`),
  KEY `in_topic` (`p_topic_id`),
  KEY `posts_by` (`p_poster`),
  KEY `post_order_time` (`p_time`),
  FULLTEXT KEY `p_title` (`p_title`)
) ENGINE=MyISAM  AUTO_INCREMENT=14 ;

--
-- Dumping data for table `ocp_f_posts`
--

INSERT INTO `ocp_f_posts` (`id`, `p_cache_forum_id`, `p_intended_solely_for`, `p_ip_address`, `p_is_emphasised`, `p_last_edit_by`, `p_last_edit_time`, `p_post`, `p_poster`, `p_poster_name_if_guest`, `p_skip_sig`, `p_time`, `p_title`, `p_topic_id`, `p_validated`) VALUES(1, 9, NULL, '127.0.0.1', 0, NULL, NULL, 88, 1, 'System', 0, 1264606808, 'Welcome to the forums', 1, 1);
INSERT INTO `ocp_f_posts` (`id`, `p_cache_forum_id`, `p_intended_solely_for`, `p_ip_address`, `p_is_emphasised`, `p_last_edit_by`, `p_last_edit_time`, `p_post`, `p_poster`, `p_poster_name_if_guest`, `p_skip_sig`, `p_time`, `p_title`, `p_topic_id`, `p_validated`) VALUES(2, 3, NULL, '90.152.0.114', 0, NULL, NULL, 853, 2, 'admin', 0, 1264692478, 'This is a topic title.', 2, 1);
INSERT INTO `ocp_f_posts` (`id`, `p_cache_forum_id`, `p_intended_solely_for`, `p_ip_address`, `p_is_emphasised`, `p_last_edit_by`, `p_last_edit_time`, `p_post`, `p_poster`, `p_poster_name_if_guest`, `p_skip_sig`, `p_time`, `p_title`, `p_topic_id`, `p_validated`) VALUES(3, 3, NULL, '90.152.0.114', 0, NULL, NULL, 854, 2, 'admin', 0, 1264692527, '', 2, 1);
INSERT INTO `ocp_f_posts` (`id`, `p_cache_forum_id`, `p_intended_solely_for`, `p_ip_address`, `p_is_emphasised`, `p_last_edit_by`, `p_last_edit_time`, `p_post`, `p_poster`, `p_poster_name_if_guest`, `p_skip_sig`, `p_time`, `p_title`, `p_topic_id`, `p_validated`) VALUES(4, 3, NULL, '90.152.0.114', 0, NULL, NULL, 855, 2, 'admin', 0, 1264692658, 'Here is a topic with a poll.', 3, 1);
INSERT INTO `ocp_f_posts` (`id`, `p_cache_forum_id`, `p_intended_solely_for`, `p_ip_address`, `p_is_emphasised`, `p_last_edit_by`, `p_last_edit_time`, `p_post`, `p_poster`, `p_poster_name_if_guest`, `p_skip_sig`, `p_time`, `p_title`, `p_topic_id`, `p_validated`) VALUES(5, 3, NULL, '90.152.0.114', 0, NULL, NULL, 856, 2, 'admin', 0, 1264692806, 'This topic contains a whisper.', 4, 1);
INSERT INTO `ocp_f_posts` (`id`, `p_cache_forum_id`, `p_intended_solely_for`, `p_ip_address`, `p_is_emphasised`, `p_last_edit_by`, `p_last_edit_time`, `p_post`, `p_poster`, `p_poster_name_if_guest`, `p_skip_sig`, `p_time`, `p_title`, `p_topic_id`, `p_validated`) VALUES(6, 3, 1, '90.152.0.114', 0, NULL, NULL, 857, 2, 'admin', 0, 1264692888, '', 4, 1);
INSERT INTO `ocp_f_posts` (`id`, `p_cache_forum_id`, `p_intended_solely_for`, `p_ip_address`, `p_is_emphasised`, `p_last_edit_by`, `p_last_edit_time`, `p_post`, `p_poster`, `p_poster_name_if_guest`, `p_skip_sig`, `p_time`, `p_title`, `p_topic_id`, `p_validated`) VALUES(7, 3, NULL, '90.152.0.114', 0, NULL, NULL, 858, 2, 'admin', 0, 1264692970, '', 4, 1);
INSERT INTO `ocp_f_posts` (`id`, `p_cache_forum_id`, `p_intended_solely_for`, `p_ip_address`, `p_is_emphasised`, `p_last_edit_by`, `p_last_edit_time`, `p_post`, `p_poster`, `p_poster_name_if_guest`, `p_skip_sig`, `p_time`, `p_title`, `p_topic_id`, `p_validated`) VALUES(8, 1, NULL, '90.152.0.114', 0, NULL, NULL, 859, 2, 'admin', 0, 1264693140, 'This topic acts as an announcement.', 5, 1);
INSERT INTO `ocp_f_posts` (`id`, `p_cache_forum_id`, `p_intended_solely_for`, `p_ip_address`, `p_is_emphasised`, `p_last_edit_by`, `p_last_edit_time`, `p_post`, `p_poster`, `p_poster_name_if_guest`, `p_skip_sig`, `p_time`, `p_title`, `p_topic_id`, `p_validated`) VALUES(9, NULL, NULL, '90.152.0.114', 0, NULL, NULL, 860, 2, 'admin', 0, 1264693706, 'Personal topic example.', 6, 1);
INSERT INTO `ocp_f_posts` (`id`, `p_cache_forum_id`, `p_intended_solely_for`, `p_ip_address`, `p_is_emphasised`, `p_last_edit_by`, `p_last_edit_time`, `p_post`, `p_poster`, `p_poster_name_if_guest`, `p_skip_sig`, `p_time`, `p_title`, `p_topic_id`, `p_validated`) VALUES(10, 5, NULL, '90.152.0.114', 0, NULL, NULL, 865, 2, 'admin', 0, 1264694090, 'Reported post in ''Here is a topic with a poll.''', 7, 1);
INSERT INTO `ocp_f_posts` (`id`, `p_cache_forum_id`, `p_intended_solely_for`, `p_ip_address`, `p_is_emphasised`, `p_last_edit_by`, `p_last_edit_time`, `p_post`, `p_poster`, `p_poster_name_if_guest`, `p_skip_sig`, `p_time`, `p_title`, `p_topic_id`, `p_validated`) VALUES(11, 3, NULL, '90.152.0.114', 0, NULL, NULL, 866, 2, 'admin', 0, 1264694559, 'This topic is pinned.', 8, 1);
INSERT INTO `ocp_f_posts` (`id`, `p_cache_forum_id`, `p_intended_solely_for`, `p_ip_address`, `p_is_emphasised`, `p_last_edit_by`, `p_last_edit_time`, `p_post`, `p_poster`, `p_poster_name_if_guest`, `p_skip_sig`, `p_time`, `p_title`, `p_topic_id`, `p_validated`) VALUES(12, 3, NULL, '90.152.0.114', 0, NULL, NULL, 867, 2, 'admin', 0, 1264694612, 'This topic is sunk.', 9, 1);
INSERT INTO `ocp_f_posts` (`id`, `p_cache_forum_id`, `p_intended_solely_for`, `p_ip_address`, `p_is_emphasised`, `p_last_edit_by`, `p_last_edit_time`, `p_post`, `p_poster`, `p_poster_name_if_guest`, `p_skip_sig`, `p_time`, `p_title`, `p_topic_id`, `p_validated`) VALUES(13, 3, NULL, '94.195.145.20', 1, NULL, NULL, 949, 2, 'admin', 0, 1265476759, '', 8, 1);

-- --------------------------------------------------------

--
-- Table structure for table `ocp_f_post_history`
--

DROP TABLE IF EXISTS `ocp_f_post_history`;
CREATE TABLE IF NOT EXISTS `ocp_f_post_history` (
  `h_action` varchar(80) NOT NULL,
  `h_action_date_and_time` int(10) unsigned NOT NULL,
  `h_alterer_member_id` int(11) NOT NULL,
  `h_before` longtext NOT NULL,
  `h_create_date_and_time` int(10) unsigned NOT NULL,
  `h_owner_member_id` int(11) NOT NULL,
  `h_post_id` int(11) NOT NULL,
  `h_topic_id` int(11) NOT NULL,
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `phistorylookup` (`h_post_id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 ;

--
-- Dumping data for table `ocp_f_post_history`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_f_post_templates`
--

DROP TABLE IF EXISTS `ocp_f_post_templates`;
CREATE TABLE IF NOT EXISTS `ocp_f_post_templates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `t_forum_multi_code` varchar(255) NOT NULL,
  `t_text` longtext NOT NULL,
  `t_title` varchar(255) NOT NULL,
  `t_use_default_forums` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  AUTO_INCREMENT=4 ;

--
-- Dumping data for table `ocp_f_post_templates`
--

INSERT INTO `ocp_f_post_templates` (`id`, `t_forum_multi_code`, `t_text`, `t_title`, `t_use_default_forums`) VALUES(1, '', 'Version: ?\nSupport software environment (operating system, etc.):\n?\n\nAssigned to: ?\nSeverity: ?\nExample URL: ?\nDescription:\n?\n\nSteps for reproduction:\n?\n\n', 'Bug report', 0);
INSERT INTO `ocp_f_post_templates` (`id`, `t_forum_multi_code`, `t_text`, `t_title`, `t_use_default_forums`) VALUES(2, '', 'Assigned to: ?\nPriority/Timescale: ?\nDescription:\n?\n\n', 'Task', 0);
INSERT INTO `ocp_f_post_templates` (`id`, `t_forum_multi_code`, `t_text`, `t_title`, `t_use_default_forums`) VALUES(3, '', 'Version: ?\nAssigned to: ?\nSeverity/Timescale: ?\nDescription:\n?\n\nSteps for reproduction:\n?\n\n', 'Fault', 0);

-- --------------------------------------------------------

--
-- Table structure for table `ocp_f_read_logs`
--

DROP TABLE IF EXISTS `ocp_f_read_logs`;
CREATE TABLE IF NOT EXISTS `ocp_f_read_logs` (
  `l_member_id` int(11) NOT NULL,
  `l_time` int(10) unsigned NOT NULL,
  `l_topic_id` int(11) NOT NULL,
  PRIMARY KEY (`l_member_id`,`l_topic_id`),
  KEY `erase_old_read_logs` (`l_time`)
) ENGINE=MyISAM;

--
-- Dumping data for table `ocp_f_read_logs`
--

INSERT INTO `ocp_f_read_logs` (`l_member_id`, `l_time`, `l_topic_id`) VALUES(2, 1264693013, 2);
INSERT INTO `ocp_f_read_logs` (`l_member_id`, `l_time`, `l_topic_id`) VALUES(2, 1264694095, 3);
INSERT INTO `ocp_f_read_logs` (`l_member_id`, `l_time`, `l_topic_id`) VALUES(2, 1265476973, 4);
INSERT INTO `ocp_f_read_logs` (`l_member_id`, `l_time`, `l_topic_id`) VALUES(2, 1264693143, 5);
INSERT INTO `ocp_f_read_logs` (`l_member_id`, `l_time`, `l_topic_id`) VALUES(2, 1265477648, 6);
INSERT INTO `ocp_f_read_logs` (`l_member_id`, `l_time`, `l_topic_id`) VALUES(2, 1265476898, 7);
INSERT INTO `ocp_f_read_logs` (`l_member_id`, `l_time`, `l_topic_id`) VALUES(2, 1265476886, 8);
INSERT INTO `ocp_f_read_logs` (`l_member_id`, `l_time`, `l_topic_id`) VALUES(2, 1264694615, 9);

-- --------------------------------------------------------

--
-- Table structure for table `ocp_f_saved_warnings`
--

DROP TABLE IF EXISTS `ocp_f_saved_warnings`;
CREATE TABLE IF NOT EXISTS `ocp_f_saved_warnings` (
  `s_explanation` longtext NOT NULL,
  `s_message` longtext NOT NULL,
  `s_title` varchar(255) NOT NULL,
  PRIMARY KEY (`s_title`)
) ENGINE=MyISAM;

--
-- Dumping data for table `ocp_f_saved_warnings`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_f_special_pt_access`
--

DROP TABLE IF EXISTS `ocp_f_special_pt_access`;
CREATE TABLE IF NOT EXISTS `ocp_f_special_pt_access` (
  `s_member_id` int(11) NOT NULL,
  `s_topic_id` int(11) NOT NULL,
  PRIMARY KEY (`s_member_id`,`s_topic_id`)
) ENGINE=MyISAM;

--
-- Dumping data for table `ocp_f_special_pt_access`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_f_topics`
--

DROP TABLE IF EXISTS `ocp_f_topics`;
CREATE TABLE IF NOT EXISTS `ocp_f_topics` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `t_cache_first_member_id` int(11) DEFAULT NULL,
  `t_cache_first_post` int(10) unsigned DEFAULT NULL,
  `t_cache_first_post_id` int(11) DEFAULT NULL,
  `t_cache_first_time` int(10) unsigned DEFAULT NULL,
  `t_cache_first_title` varchar(255) NOT NULL,
  `t_cache_first_username` varchar(80) NOT NULL,
  `t_cache_last_member_id` int(11) DEFAULT NULL,
  `t_cache_last_post_id` int(11) DEFAULT NULL,
  `t_cache_last_time` int(10) unsigned DEFAULT NULL,
  `t_cache_last_title` varchar(255) NOT NULL,
  `t_cache_last_username` varchar(80) NOT NULL,
  `t_cache_num_posts` int(11) NOT NULL,
  `t_cascading` tinyint(1) NOT NULL,
  `t_description` varchar(255) NOT NULL,
  `t_description_link` varchar(255) NOT NULL,
  `t_emoticon` varchar(255) NOT NULL,
  `t_forum_id` int(11) DEFAULT NULL,
  `t_is_open` tinyint(1) NOT NULL,
  `t_num_views` int(11) NOT NULL,
  `t_pinned` tinyint(1) NOT NULL,
  `t_poll_id` int(11) DEFAULT NULL,
  `t_pt_from` int(11) DEFAULT NULL,
  `t_pt_from_category` varchar(255) NOT NULL,
  `t_pt_to` int(11) DEFAULT NULL,
  `t_pt_to_category` varchar(255) NOT NULL,
  `t_sunk` tinyint(1) NOT NULL,
  `t_validated` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `in_forum` (`t_forum_id`),
  KEY `topic_order_time` (`t_cache_last_time`),
  FULLTEXT KEY `t_description` (`t_description`)
) ENGINE=MyISAM  AUTO_INCREMENT=10 ;

--
-- Dumping data for table `ocp_f_topics`
--

INSERT INTO `ocp_f_topics` (`id`, `t_cache_first_member_id`, `t_cache_first_post`, `t_cache_first_post_id`, `t_cache_first_time`, `t_cache_first_title`, `t_cache_first_username`, `t_cache_last_member_id`, `t_cache_last_post_id`, `t_cache_last_time`, `t_cache_last_title`, `t_cache_last_username`, `t_cache_num_posts`, `t_cascading`, `t_description`, `t_description_link`, `t_emoticon`, `t_forum_id`, `t_is_open`, `t_num_views`, `t_pinned`, `t_poll_id`, `t_pt_from`, `t_pt_from_category`, `t_pt_to`, `t_pt_to_category`, `t_sunk`, `t_validated`) VALUES(1, 1, 88, 1, 1264606808, 'Welcome to the forums', 'System', 1, 1, 1264606808, 'Welcome to the forums', 'System', 1, 0, '', '', '', 9, 1, 0, 0, NULL, NULL, '', NULL, '', 0, 1);
INSERT INTO `ocp_f_topics` (`id`, `t_cache_first_member_id`, `t_cache_first_post`, `t_cache_first_post_id`, `t_cache_first_time`, `t_cache_first_title`, `t_cache_first_username`, `t_cache_last_member_id`, `t_cache_last_post_id`, `t_cache_last_time`, `t_cache_last_title`, `t_cache_last_username`, `t_cache_num_posts`, `t_cascading`, `t_description`, `t_description_link`, `t_emoticon`, `t_forum_id`, `t_is_open`, `t_num_views`, `t_pinned`, `t_poll_id`, `t_pt_from`, `t_pt_from_category`, `t_pt_to`, `t_pt_to_category`, `t_sunk`, `t_validated`) VALUES(2, 2, 853, 2, 1264692478, 'This is a topic title.', 'admin', 2, 3, 1264692527, '', 'admin', 2, 0, 'This is a topic description.', '', 'ocf_emoticons/cool', 3, 1, 3, 0, NULL, NULL, '', NULL, '', 0, 1);
INSERT INTO `ocp_f_topics` (`id`, `t_cache_first_member_id`, `t_cache_first_post`, `t_cache_first_post_id`, `t_cache_first_time`, `t_cache_first_title`, `t_cache_first_username`, `t_cache_last_member_id`, `t_cache_last_post_id`, `t_cache_last_time`, `t_cache_last_title`, `t_cache_last_username`, `t_cache_num_posts`, `t_cascading`, `t_description`, `t_description_link`, `t_emoticon`, `t_forum_id`, `t_is_open`, `t_num_views`, `t_pinned`, `t_poll_id`, `t_pt_from`, `t_pt_from_category`, `t_pt_to`, `t_pt_to_category`, `t_sunk`, `t_validated`) VALUES(3, 2, 855, 4, 1264692658, 'Here is a topic with a poll.', 'admin', 2, 4, 1264692658, 'Here is a topic with a poll.', 'admin', 1, 0, '', '', '', 3, 1, 5, 0, 1, NULL, '', NULL, '', 0, 1);
INSERT INTO `ocp_f_topics` (`id`, `t_cache_first_member_id`, `t_cache_first_post`, `t_cache_first_post_id`, `t_cache_first_time`, `t_cache_first_title`, `t_cache_first_username`, `t_cache_last_member_id`, `t_cache_last_post_id`, `t_cache_last_time`, `t_cache_last_title`, `t_cache_last_username`, `t_cache_num_posts`, `t_cascading`, `t_description`, `t_description_link`, `t_emoticon`, `t_forum_id`, `t_is_open`, `t_num_views`, `t_pinned`, `t_poll_id`, `t_pt_from`, `t_pt_from_category`, `t_pt_to`, `t_pt_to_category`, `t_sunk`, `t_validated`) VALUES(4, 2, 856, 5, 1264692806, 'This topic contains a whisper.', 'admin', 2, 7, 1264692970, '', 'admin', 2, 0, '', '', '', 3, 1, 5, 0, NULL, NULL, '', NULL, '', 0, 1);
INSERT INTO `ocp_f_topics` (`id`, `t_cache_first_member_id`, `t_cache_first_post`, `t_cache_first_post_id`, `t_cache_first_time`, `t_cache_first_title`, `t_cache_first_username`, `t_cache_last_member_id`, `t_cache_last_post_id`, `t_cache_last_time`, `t_cache_last_title`, `t_cache_last_username`, `t_cache_num_posts`, `t_cascading`, `t_description`, `t_description_link`, `t_emoticon`, `t_forum_id`, `t_is_open`, `t_num_views`, `t_pinned`, `t_poll_id`, `t_pt_from`, `t_pt_from_category`, `t_pt_to`, `t_pt_to_category`, `t_sunk`, `t_validated`) VALUES(5, 2, 859, 8, 1264693140, 'This topic acts as an announcement.', 'admin', 2, 8, 1264693140, 'This topic acts as an announcement.', 'admin', 1, 1, '', '', '', 1, 1, 1, 0, NULL, NULL, '', NULL, '', 0, 1);
INSERT INTO `ocp_f_topics` (`id`, `t_cache_first_member_id`, `t_cache_first_post`, `t_cache_first_post_id`, `t_cache_first_time`, `t_cache_first_title`, `t_cache_first_username`, `t_cache_last_member_id`, `t_cache_last_post_id`, `t_cache_last_time`, `t_cache_last_title`, `t_cache_last_username`, `t_cache_num_posts`, `t_cascading`, `t_description`, `t_description_link`, `t_emoticon`, `t_forum_id`, `t_is_open`, `t_num_views`, `t_pinned`, `t_poll_id`, `t_pt_from`, `t_pt_from_category`, `t_pt_to`, `t_pt_to_category`, `t_sunk`, `t_validated`) VALUES(6, 2, 860, 9, 1264693706, 'Personal topic example.', 'admin', 2, 9, 1264693706, 'Personal topic example.', 'admin', 1, 0, '', '', '', NULL, 1, 2, 0, NULL, 2, '', 1, '', 0, 1);
INSERT INTO `ocp_f_topics` (`id`, `t_cache_first_member_id`, `t_cache_first_post`, `t_cache_first_post_id`, `t_cache_first_time`, `t_cache_first_title`, `t_cache_first_username`, `t_cache_last_member_id`, `t_cache_last_post_id`, `t_cache_last_time`, `t_cache_last_title`, `t_cache_last_username`, `t_cache_num_posts`, `t_cascading`, `t_description`, `t_description_link`, `t_emoticon`, `t_forum_id`, `t_is_open`, `t_num_views`, `t_pinned`, `t_poll_id`, `t_pt_from`, `t_pt_from_category`, `t_pt_to`, `t_pt_to_category`, `t_sunk`, `t_validated`) VALUES(7, 2, 865, 10, 1264694090, 'Reported post in ''Here is a topic with a poll.''', 'admin', 2, 10, 1264694090, 'Reported post in ''Here is a topic with a poll.''', 'admin', 1, 0, '', '', '', 5, 1, 1, 0, NULL, NULL, '', NULL, '', 0, 1);
INSERT INTO `ocp_f_topics` (`id`, `t_cache_first_member_id`, `t_cache_first_post`, `t_cache_first_post_id`, `t_cache_first_time`, `t_cache_first_title`, `t_cache_first_username`, `t_cache_last_member_id`, `t_cache_last_post_id`, `t_cache_last_time`, `t_cache_last_title`, `t_cache_last_username`, `t_cache_num_posts`, `t_cascading`, `t_description`, `t_description_link`, `t_emoticon`, `t_forum_id`, `t_is_open`, `t_num_views`, `t_pinned`, `t_poll_id`, `t_pt_from`, `t_pt_from_category`, `t_pt_to`, `t_pt_to_category`, `t_sunk`, `t_validated`) VALUES(8, 2, 866, 11, 1264694559, 'This topic is pinned.', 'admin', 2, 13, 1265476759, '', 'admin', 2, 0, '', '', '', 3, 1, 5, 1, NULL, NULL, '', NULL, '', 0, 1);
INSERT INTO `ocp_f_topics` (`id`, `t_cache_first_member_id`, `t_cache_first_post`, `t_cache_first_post_id`, `t_cache_first_time`, `t_cache_first_title`, `t_cache_first_username`, `t_cache_last_member_id`, `t_cache_last_post_id`, `t_cache_last_time`, `t_cache_last_title`, `t_cache_last_username`, `t_cache_num_posts`, `t_cascading`, `t_description`, `t_description_link`, `t_emoticon`, `t_forum_id`, `t_is_open`, `t_num_views`, `t_pinned`, `t_poll_id`, `t_pt_from`, `t_pt_from_category`, `t_pt_to`, `t_pt_to_category`, `t_sunk`, `t_validated`) VALUES(9, 2, 867, 12, 1264694612, 'This topic is sunk.', 'admin', 2, 12, 1264694612, 'This topic is sunk.', 'admin', 1, 0, '', '', '', 3, 1, 1, 0, NULL, NULL, '', NULL, '', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `ocp_f_topic_tracking`
--

DROP TABLE IF EXISTS `ocp_f_topic_tracking`;
CREATE TABLE IF NOT EXISTS `ocp_f_topic_tracking` (
  `r_last_message_time` int(10) unsigned NOT NULL,
  `r_member_id` int(11) NOT NULL,
  `r_topic_id` int(11) NOT NULL,
  PRIMARY KEY (`r_member_id`,`r_topic_id`)
) ENGINE=MyISAM;

--
-- Dumping data for table `ocp_f_topic_tracking`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_f_usergroup_subs`
--

DROP TABLE IF EXISTS `ocp_f_usergroup_subs`;
CREATE TABLE IF NOT EXISTS `ocp_f_usergroup_subs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `s_cost` varchar(255) NOT NULL,
  `s_description` int(10) unsigned NOT NULL,
  `s_enabled` tinyint(1) NOT NULL,
  `s_group_id` int(11) NOT NULL,
  `s_length` int(11) NOT NULL,
  `s_length_units` varchar(255) NOT NULL,
  `s_mail_end` int(10) unsigned NOT NULL,
  `s_mail_start` int(10) unsigned NOT NULL,
  `s_mail_uhoh` int(10) unsigned NOT NULL,
  `s_title` int(10) unsigned NOT NULL,
  `s_uses_primary` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 ;

--
-- Dumping data for table `ocp_f_usergroup_subs`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_f_warnings`
--

DROP TABLE IF EXISTS `ocp_f_warnings`;
CREATE TABLE IF NOT EXISTS `ocp_f_warnings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `p_banned_ip` varchar(40) NOT NULL,
  `p_banned_member` tinyint(1) NOT NULL,
  `p_changed_usergroup_from` int(11) DEFAULT NULL,
  `p_charged_points` int(11) NOT NULL,
  `p_probation` int(11) NOT NULL,
  `p_silence_from_forum` int(11) DEFAULT NULL,
  `p_silence_from_topic` int(11) DEFAULT NULL,
  `w_by` int(11) NOT NULL,
  `w_explanation` longtext NOT NULL,
  `w_is_warning` tinyint(1) NOT NULL,
  `w_member_id` int(11) NOT NULL,
  `w_time` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `warningsmemberid` (`w_member_id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 ;

--
-- Dumping data for table `ocp_f_warnings`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_f_welcome_emails`
--

DROP TABLE IF EXISTS `ocp_f_welcome_emails`;
CREATE TABLE IF NOT EXISTS `ocp_f_welcome_emails` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `w_name` varchar(255) NOT NULL,
  `w_newsletter` tinyint(1) NOT NULL,
  `w_send_time` int(11) NOT NULL,
  `w_subject` int(10) unsigned NOT NULL,
  `w_text` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 ;

--
-- Dumping data for table `ocp_f_welcome_emails`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_galleries`
--

DROP TABLE IF EXISTS `ocp_galleries`;
CREATE TABLE IF NOT EXISTS `ocp_galleries` (
  `accept_images` tinyint(1) NOT NULL,
  `accept_videos` tinyint(1) NOT NULL,
  `add_date` int(10) unsigned NOT NULL,
  `allow_comments` tinyint(4) NOT NULL,
  `allow_rating` tinyint(1) NOT NULL,
  `description` int(10) unsigned NOT NULL,
  `flow_mode_interface` tinyint(1) NOT NULL,
  `fullname` int(10) unsigned NOT NULL,
  `is_member_synched` tinyint(1) NOT NULL,
  `name` varchar(80) NOT NULL,
  `notes` longtext NOT NULL,
  `parent_id` varchar(80) NOT NULL,
  `rep_image` varchar(255) NOT NULL,
  `teaser` int(10) unsigned NOT NULL,
  `watermark_bottom_left` varchar(255) NOT NULL,
  `watermark_bottom_right` varchar(255) NOT NULL,
  `watermark_top_left` varchar(255) NOT NULL,
  `watermark_top_right` varchar(255) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=MyISAM;

--
-- Dumping data for table `ocp_galleries`
--

INSERT INTO `ocp_galleries` (`accept_images`, `accept_videos`, `add_date`, `allow_comments`, `allow_rating`, `description`, `flow_mode_interface`, `fullname`, `is_member_synched`, `name`, `notes`, `parent_id`, `rep_image`, `teaser`, `watermark_bottom_left`, `watermark_bottom_right`, `watermark_top_left`, `watermark_top_right`) VALUES(1, 1, 1264606828, 1, 1, 325, 1, 327, 0, 'root', '', '', '', 326, '', '', '', '');
INSERT INTO `ocp_galleries` (`accept_images`, `accept_videos`, `add_date`, `allow_comments`, `allow_rating`, `description`, `flow_mode_interface`, `fullname`, `is_member_synched`, `name`, `notes`, `parent_id`, `rep_image`, `teaser`, `watermark_bottom_left`, `watermark_bottom_right`, `watermark_top_left`, `watermark_top_right`) VALUES(1, 1, 1264673478, 1, 1, 619, 0, 621, 0, 'download_1', '', 'root', '', 620, '', '', '', '');
INSERT INTO `ocp_galleries` (`accept_images`, `accept_videos`, `add_date`, `allow_comments`, `allow_rating`, `description`, `flow_mode_interface`, `fullname`, `is_member_synched`, `name`, `notes`, `parent_id`, `rep_image`, `teaser`, `watermark_bottom_left`, `watermark_bottom_right`, `watermark_top_left`, `watermark_top_right`) VALUES(1, 1, 1264684918, 0, 0, 751, 1, 753, 0, 'randj', '', 'root', 'uploads/galleries_thumbs/Romeo_and_juliet_brown.jpg', 752, '', '', '', '');
INSERT INTO `ocp_galleries` (`accept_images`, `accept_videos`, `add_date`, `allow_comments`, `allow_rating`, `description`, `flow_mode_interface`, `fullname`, `is_member_synched`, `name`, `notes`, `parent_id`, `rep_image`, `teaser`, `watermark_bottom_left`, `watermark_bottom_right`, `watermark_top_left`, `watermark_top_right`) VALUES(1, 1, 1264685674, 1, 1, 769, 0, 771, 0, 'download_2', '', 'root', '', 770, '', '', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `ocp_gifts`
--

DROP TABLE IF EXISTS `ocp_gifts`;
CREATE TABLE IF NOT EXISTS `ocp_gifts` (
  `amount` int(11) NOT NULL,
  `anonymous` tinyint(1) NOT NULL,
  `date_and_time` int(10) unsigned NOT NULL,
  `gift_from` int(11) NOT NULL,
  `gift_to` int(11) NOT NULL,
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `reason` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  AUTO_INCREMENT=19 ;

--
-- Dumping data for table `ocp_gifts`
--

INSERT INTO `ocp_gifts` (`amount`, `anonymous`, `date_and_time`, `gift_from`, `gift_to`, `id`, `reason`) VALUES(35, 1, 1264607625, 1, 2, 1, 495);
INSERT INTO `ocp_gifts` (`amount`, `anonymous`, `date_and_time`, `gift_from`, `gift_to`, `id`, `reason`) VALUES(150, 1, 1264607625, 1, 2, 2, 496);
INSERT INTO `ocp_gifts` (`amount`, `anonymous`, `date_and_time`, `gift_from`, `gift_to`, `id`, `reason`) VALUES(10, 1, 1264608734, 1, 2, 3, 533);
INSERT INTO `ocp_gifts` (`amount`, `anonymous`, `date_and_time`, `gift_from`, `gift_to`, `id`, `reason`) VALUES(10, 1, 1264671563, 1, 2, 4, 593);
INSERT INTO `ocp_gifts` (`amount`, `anonymous`, `date_and_time`, `gift_from`, `gift_to`, `id`, `reason`) VALUES(150, 1, 1264673478, 1, 2, 5, 624);
INSERT INTO `ocp_gifts` (`amount`, `anonymous`, `date_and_time`, `gift_from`, `gift_to`, `id`, `reason`) VALUES(35, 1, 1264673745, 1, 2, 6, 631);
INSERT INTO `ocp_gifts` (`amount`, `anonymous`, `date_and_time`, `gift_from`, `gift_to`, `id`, `reason`) VALUES(150, 1, 1264673745, 1, 2, 7, 632);
INSERT INTO `ocp_gifts` (`amount`, `anonymous`, `date_and_time`, `gift_from`, `gift_to`, `id`, `reason`) VALUES(30, 1, 1264680508, 1, 2, 8, 666);
INSERT INTO `ocp_gifts` (`amount`, `anonymous`, `date_and_time`, `gift_from`, `gift_to`, `id`, `reason`) VALUES(30, 1, 1264681168, 1, 2, 9, 669);
INSERT INTO `ocp_gifts` (`amount`, `anonymous`, `date_and_time`, `gift_from`, `gift_to`, `id`, `reason`) VALUES(225, 1, 1264683675, 1, 2, 10, 719);
INSERT INTO `ocp_gifts` (`amount`, `anonymous`, `date_and_time`, `gift_from`, `gift_to`, `id`, `reason`) VALUES(225, 1, 1264683761, 1, 2, 11, 725);
INSERT INTO `ocp_gifts` (`amount`, `anonymous`, `date_and_time`, `gift_from`, `gift_to`, `id`, `reason`) VALUES(100, 1, 1264684972, 1, 2, 12, 759);
INSERT INTO `ocp_gifts` (`amount`, `anonymous`, `date_and_time`, `gift_from`, `gift_to`, `id`, `reason`) VALUES(100, 1, 1264685117, 1, 2, 13, 763);
INSERT INTO `ocp_gifts` (`amount`, `anonymous`, `date_and_time`, `gift_from`, `gift_to`, `id`, `reason`) VALUES(150, 1, 1264685674, 1, 2, 14, 774);
INSERT INTO `ocp_gifts` (`amount`, `anonymous`, `date_and_time`, `gift_from`, `gift_to`, `id`, `reason`) VALUES(10, 1, 1264685778, 1, 2, 15, 775);
INSERT INTO `ocp_gifts` (`amount`, `anonymous`, `date_and_time`, `gift_from`, `gift_to`, `id`, `reason`) VALUES(10, 1, 1264685832, 1, 2, 16, 780);
INSERT INTO `ocp_gifts` (`amount`, `anonymous`, `date_and_time`, `gift_from`, `gift_to`, `id`, `reason`) VALUES(10, 1, 1264687209, 1, 2, 17, 795);
INSERT INTO `ocp_gifts` (`amount`, `anonymous`, `date_and_time`, `gift_from`, `gift_to`, `id`, `reason`) VALUES(10, 1, 1265479394, 1, 2, 18, 956);

-- --------------------------------------------------------

--
-- Table structure for table `ocp_group_category_access`
--

DROP TABLE IF EXISTS `ocp_group_category_access`;
CREATE TABLE IF NOT EXISTS `ocp_group_category_access` (
  `category_name` varchar(80) NOT NULL,
  `group_id` int(11) NOT NULL,
  `module_the_name` varchar(80) NOT NULL,
  PRIMARY KEY (`category_name`,`group_id`,`module_the_name`)
) ENGINE=MyISAM;

--
-- Dumping data for table `ocp_group_category_access`
--

INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('0', 1, 'news');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('0', 2, 'news');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('0', 3, 'news');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('0', 4, 'news');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('0', 5, 'news');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('0', 6, 'news');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('0', 7, 'news');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('0', 8, 'news');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('0', 9, 'news');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('0', 10, 'news');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('1', 1, 'chat');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('1', 1, 'downloads');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('1', 1, 'forums');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('1', 1, 'news');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('1', 1, 'seedy_page');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('1', 2, 'downloads');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('1', 2, 'forums');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('1', 2, 'news');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('1', 2, 'seedy_page');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('1', 3, 'chat');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('1', 3, 'downloads');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('1', 3, 'forums');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('1', 3, 'news');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('1', 3, 'seedy_page');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('1', 4, 'chat');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('1', 4, 'downloads');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('1', 4, 'forums');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('1', 4, 'news');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('1', 4, 'seedy_page');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('1', 5, 'chat');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('1', 5, 'downloads');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('1', 5, 'forums');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('1', 5, 'news');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('1', 5, 'seedy_page');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('1', 6, 'chat');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('1', 6, 'downloads');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('1', 6, 'forums');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('1', 6, 'news');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('1', 6, 'seedy_page');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('1', 7, 'chat');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('1', 7, 'downloads');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('1', 7, 'forums');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('1', 7, 'news');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('1', 7, 'seedy_page');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('1', 8, 'chat');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('1', 8, 'downloads');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('1', 8, 'forums');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('1', 8, 'news');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('1', 8, 'seedy_page');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('1', 9, 'chat');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('1', 9, 'downloads');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('1', 9, 'forums');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('1', 9, 'news');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('1', 9, 'seedy_page');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('1', 10, 'chat');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('1', 10, 'downloads');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('1', 10, 'forums');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('1', 10, 'news');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('1', 10, 'seedy_page');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('10', 3, 'forums');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('2', 1, 'downloads');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('2', 1, 'news');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('2', 1, 'seedy_page');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('2', 2, 'news');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('2', 3, 'downloads');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('2', 3, 'news');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('2', 3, 'seedy_page');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('2', 4, 'downloads');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('2', 4, 'news');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('2', 4, 'seedy_page');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('2', 5, 'downloads');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('2', 5, 'news');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('2', 5, 'seedy_page');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('2', 6, 'downloads');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('2', 6, 'news');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('2', 6, 'seedy_page');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('2', 7, 'downloads');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('2', 7, 'news');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('2', 7, 'seedy_page');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('2', 8, 'downloads');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('2', 8, 'news');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('2', 8, 'seedy_page');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('2', 9, 'downloads');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('2', 9, 'news');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('2', 9, 'seedy_page');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('2', 10, 'downloads');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('2', 10, 'news');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('2', 10, 'seedy_page');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('3', 1, 'catalogues_category');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('3', 1, 'downloads');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('3', 1, 'forums');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('3', 1, 'news');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('3', 1, 'seedy_page');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('3', 2, 'catalogues_category');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('3', 2, 'forums');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('3', 2, 'news');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('3', 3, 'catalogues_category');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('3', 3, 'downloads');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('3', 3, 'forums');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('3', 3, 'news');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('3', 3, 'seedy_page');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('3', 4, 'catalogues_category');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('3', 4, 'downloads');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('3', 4, 'forums');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('3', 4, 'news');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('3', 4, 'seedy_page');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('3', 5, 'catalogues_category');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('3', 5, 'downloads');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('3', 5, 'forums');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('3', 5, 'news');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('3', 5, 'seedy_page');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('3', 6, 'catalogues_category');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('3', 6, 'downloads');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('3', 6, 'forums');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('3', 6, 'news');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('3', 6, 'seedy_page');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('3', 7, 'catalogues_category');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('3', 7, 'downloads');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('3', 7, 'forums');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('3', 7, 'news');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('3', 7, 'seedy_page');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('3', 8, 'catalogues_category');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('3', 8, 'downloads');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('3', 8, 'forums');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('3', 8, 'news');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('3', 8, 'seedy_page');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('3', 9, 'catalogues_category');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('3', 9, 'downloads');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('3', 9, 'forums');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('3', 9, 'news');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('3', 9, 'seedy_page');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('3', 10, 'catalogues_category');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('3', 10, 'downloads');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('3', 10, 'forums');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('3', 10, 'news');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('3', 10, 'seedy_page');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('4', 1, 'forums');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('4', 1, 'news');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('4', 1, 'seedy_page');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('4', 2, 'news');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('4', 3, 'forums');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('4', 3, 'news');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('4', 3, 'seedy_page');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('4', 4, 'forums');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('4', 4, 'news');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('4', 4, 'seedy_page');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('4', 5, 'forums');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('4', 5, 'news');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('4', 5, 'seedy_page');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('4', 6, 'forums');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('4', 6, 'news');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('4', 6, 'seedy_page');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('4', 7, 'forums');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('4', 7, 'news');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('4', 7, 'seedy_page');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('4', 8, 'forums');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('4', 8, 'news');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('4', 8, 'seedy_page');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('4', 9, 'forums');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('4', 9, 'news');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('4', 9, 'seedy_page');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('4', 10, 'forums');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('4', 10, 'news');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('4', 10, 'seedy_page');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('5', 1, 'news');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('5', 2, 'forums');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('5', 2, 'news');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('5', 3, 'forums');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('5', 3, 'news');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('5', 4, 'news');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('5', 5, 'news');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('5', 6, 'news');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('5', 7, 'news');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('5', 8, 'news');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('5', 9, 'news');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('5', 10, 'news');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('6', 1, 'news');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('6', 2, 'forums');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('6', 2, 'news');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('6', 3, 'forums');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('6', 3, 'news');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('6', 4, 'news');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('6', 5, 'news');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('6', 6, 'news');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('6', 7, 'news');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('6', 8, 'news');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('6', 9, 'news');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('6', 10, 'news');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('7', 1, 'catalogues_category');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('7', 1, 'forums');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('7', 2, 'forums');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('7', 3, 'catalogues_category');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('7', 3, 'forums');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('7', 4, 'catalogues_category');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('7', 4, 'forums');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('7', 5, 'catalogues_category');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('7', 5, 'forums');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('7', 6, 'catalogues_category');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('7', 6, 'forums');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('7', 7, 'catalogues_category');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('7', 7, 'forums');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('7', 8, 'catalogues_category');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('7', 8, 'forums');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('7', 9, 'catalogues_category');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('7', 9, 'forums');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('7', 10, 'catalogues_category');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('7', 10, 'forums');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('8', 1, 'catalogues_category');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('8', 2, 'forums');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('8', 3, 'catalogues_category');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('8', 3, 'forums');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('8', 4, 'catalogues_category');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('8', 5, 'catalogues_category');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('8', 6, 'catalogues_category');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('8', 7, 'catalogues_category');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('8', 8, 'catalogues_category');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('8', 9, 'catalogues_category');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('8', 10, 'catalogues_category');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('9', 2, 'forums');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('9', 3, 'forums');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('advertise_here', 1, 'banners');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('advertise_here', 2, 'banners');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('advertise_here', 3, 'banners');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('advertise_here', 4, 'banners');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('advertise_here', 5, 'banners');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('advertise_here', 6, 'banners');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('advertise_here', 7, 'banners');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('advertise_here', 8, 'banners');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('advertise_here', 9, 'banners');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('advertise_here', 10, 'banners');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('Complaint', 1, 'tickets');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('Complaint', 2, 'tickets');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('Complaint', 3, 'tickets');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('Complaint', 4, 'tickets');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('Complaint', 5, 'tickets');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('Complaint', 6, 'tickets');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('Complaint', 7, 'tickets');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('Complaint', 8, 'tickets');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('Complaint', 9, 'tickets');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('Complaint', 10, 'tickets');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('donate', 1, 'banners');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('donate', 2, 'banners');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('donate', 3, 'banners');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('donate', 4, 'banners');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('donate', 5, 'banners');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('donate', 6, 'banners');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('donate', 7, 'banners');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('donate', 8, 'banners');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('donate', 9, 'banners');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('donate', 10, 'banners');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('hosting', 1, 'banners');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('hosting', 2, 'banners');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('hosting', 3, 'banners');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('hosting', 4, 'banners');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('hosting', 5, 'banners');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('hosting', 6, 'banners');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('hosting', 7, 'banners');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('hosting', 8, 'banners');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('hosting', 9, 'banners');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('hosting', 10, 'banners');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('links', 1, 'catalogues_catalogue');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('links', 2, 'catalogues_catalogue');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('links', 3, 'catalogues_catalogue');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('links', 4, 'catalogues_catalogue');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('links', 5, 'catalogues_catalogue');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('links', 6, 'catalogues_catalogue');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('links', 7, 'catalogues_catalogue');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('links', 8, 'catalogues_catalogue');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('links', 9, 'catalogues_catalogue');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('links', 10, 'catalogues_catalogue');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('Other', 1, 'tickets');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('Other', 2, 'tickets');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('Other', 3, 'tickets');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('Other', 4, 'tickets');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('Other', 5, 'tickets');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('Other', 6, 'tickets');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('Other', 7, 'tickets');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('Other', 8, 'tickets');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('Other', 9, 'tickets');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('Other', 10, 'tickets');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('products', 1, 'catalogues_catalogue');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('products', 2, 'catalogues_catalogue');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('products', 3, 'catalogues_catalogue');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('products', 4, 'catalogues_catalogue');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('products', 5, 'catalogues_catalogue');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('products', 6, 'catalogues_catalogue');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('products', 7, 'catalogues_catalogue');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('products', 8, 'catalogues_catalogue');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('products', 9, 'catalogues_catalogue');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('products', 10, 'catalogues_catalogue');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('randj', 1, 'galleries');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('randj', 3, 'galleries');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('randj', 4, 'galleries');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('randj', 5, 'galleries');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('randj', 6, 'galleries');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('randj', 7, 'galleries');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('randj', 8, 'galleries');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('randj', 9, 'galleries');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('randj', 10, 'galleries');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('root', 1, 'galleries');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('root', 2, 'galleries');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('root', 3, 'galleries');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('root', 4, 'galleries');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('root', 5, 'galleries');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('root', 6, 'galleries');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('root', 7, 'galleries');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('root', 8, 'galleries');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('root', 9, 'galleries');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('root', 10, 'galleries');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('_unnamed_', 1, 'theme');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('_unnamed_', 3, 'theme');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('_unnamed_', 4, 'theme');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('_unnamed_', 5, 'theme');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('_unnamed_', 6, 'theme');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('_unnamed_', 7, 'theme');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('_unnamed_', 8, 'theme');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('_unnamed_', 9, 'theme');
INSERT INTO `ocp_group_category_access` (`category_name`, `group_id`, `module_the_name`) VALUES('_unnamed_', 10, 'theme');

-- --------------------------------------------------------

--
-- Table structure for table `ocp_group_page_access`
--

DROP TABLE IF EXISTS `ocp_group_page_access`;
CREATE TABLE IF NOT EXISTS `ocp_group_page_access` (
  `group_id` int(11) NOT NULL,
  `page_name` varchar(80) NOT NULL,
  `zone_name` varchar(80) NOT NULL,
  PRIMARY KEY (`group_id`,`page_name`,`zone_name`)
) ENGINE=MyISAM;

--
-- Dumping data for table `ocp_group_page_access`
--

INSERT INTO `ocp_group_page_access` (`group_id`, `page_name`, `zone_name`) VALUES(1, 'admin_addons', 'adminzone');
INSERT INTO `ocp_group_page_access` (`group_id`, `page_name`, `zone_name`) VALUES(1, 'admin_import', 'adminzone');
INSERT INTO `ocp_group_page_access` (`group_id`, `page_name`, `zone_name`) VALUES(1, 'admin_occle', 'adminzone');
INSERT INTO `ocp_group_page_access` (`group_id`, `page_name`, `zone_name`) VALUES(1, 'admin_redirects', 'adminzone');
INSERT INTO `ocp_group_page_access` (`group_id`, `page_name`, `zone_name`) VALUES(1, 'admin_staff', 'adminzone');
INSERT INTO `ocp_group_page_access` (`group_id`, `page_name`, `zone_name`) VALUES(1, 'cms_chat', 'cms');
INSERT INTO `ocp_group_page_access` (`group_id`, `page_name`, `zone_name`) VALUES(2, 'admin_addons', 'adminzone');
INSERT INTO `ocp_group_page_access` (`group_id`, `page_name`, `zone_name`) VALUES(2, 'admin_import', 'adminzone');
INSERT INTO `ocp_group_page_access` (`group_id`, `page_name`, `zone_name`) VALUES(2, 'admin_occle', 'adminzone');
INSERT INTO `ocp_group_page_access` (`group_id`, `page_name`, `zone_name`) VALUES(2, 'admin_redirects', 'adminzone');
INSERT INTO `ocp_group_page_access` (`group_id`, `page_name`, `zone_name`) VALUES(2, 'admin_staff', 'adminzone');
INSERT INTO `ocp_group_page_access` (`group_id`, `page_name`, `zone_name`) VALUES(2, 'cms_chat', 'cms');
INSERT INTO `ocp_group_page_access` (`group_id`, `page_name`, `zone_name`) VALUES(2, 'join', '');
INSERT INTO `ocp_group_page_access` (`group_id`, `page_name`, `zone_name`) VALUES(3, 'admin_addons', 'adminzone');
INSERT INTO `ocp_group_page_access` (`group_id`, `page_name`, `zone_name`) VALUES(3, 'admin_import', 'adminzone');
INSERT INTO `ocp_group_page_access` (`group_id`, `page_name`, `zone_name`) VALUES(3, 'admin_occle', 'adminzone');
INSERT INTO `ocp_group_page_access` (`group_id`, `page_name`, `zone_name`) VALUES(3, 'admin_redirects', 'adminzone');
INSERT INTO `ocp_group_page_access` (`group_id`, `page_name`, `zone_name`) VALUES(3, 'admin_staff', 'adminzone');
INSERT INTO `ocp_group_page_access` (`group_id`, `page_name`, `zone_name`) VALUES(3, 'cms_chat', 'cms');
INSERT INTO `ocp_group_page_access` (`group_id`, `page_name`, `zone_name`) VALUES(3, 'join', '');
INSERT INTO `ocp_group_page_access` (`group_id`, `page_name`, `zone_name`) VALUES(4, 'admin_addons', 'adminzone');
INSERT INTO `ocp_group_page_access` (`group_id`, `page_name`, `zone_name`) VALUES(4, 'admin_import', 'adminzone');
INSERT INTO `ocp_group_page_access` (`group_id`, `page_name`, `zone_name`) VALUES(4, 'admin_occle', 'adminzone');
INSERT INTO `ocp_group_page_access` (`group_id`, `page_name`, `zone_name`) VALUES(4, 'admin_redirects', 'adminzone');
INSERT INTO `ocp_group_page_access` (`group_id`, `page_name`, `zone_name`) VALUES(4, 'admin_staff', 'adminzone');
INSERT INTO `ocp_group_page_access` (`group_id`, `page_name`, `zone_name`) VALUES(4, 'cms_chat', 'cms');
INSERT INTO `ocp_group_page_access` (`group_id`, `page_name`, `zone_name`) VALUES(4, 'join', '');
INSERT INTO `ocp_group_page_access` (`group_id`, `page_name`, `zone_name`) VALUES(5, 'admin_addons', 'adminzone');
INSERT INTO `ocp_group_page_access` (`group_id`, `page_name`, `zone_name`) VALUES(5, 'admin_import', 'adminzone');
INSERT INTO `ocp_group_page_access` (`group_id`, `page_name`, `zone_name`) VALUES(5, 'admin_occle', 'adminzone');
INSERT INTO `ocp_group_page_access` (`group_id`, `page_name`, `zone_name`) VALUES(5, 'admin_redirects', 'adminzone');
INSERT INTO `ocp_group_page_access` (`group_id`, `page_name`, `zone_name`) VALUES(5, 'admin_staff', 'adminzone');
INSERT INTO `ocp_group_page_access` (`group_id`, `page_name`, `zone_name`) VALUES(5, 'cms_chat', 'cms');
INSERT INTO `ocp_group_page_access` (`group_id`, `page_name`, `zone_name`) VALUES(5, 'join', '');
INSERT INTO `ocp_group_page_access` (`group_id`, `page_name`, `zone_name`) VALUES(6, 'admin_addons', 'adminzone');
INSERT INTO `ocp_group_page_access` (`group_id`, `page_name`, `zone_name`) VALUES(6, 'admin_import', 'adminzone');
INSERT INTO `ocp_group_page_access` (`group_id`, `page_name`, `zone_name`) VALUES(6, 'admin_occle', 'adminzone');
INSERT INTO `ocp_group_page_access` (`group_id`, `page_name`, `zone_name`) VALUES(6, 'admin_redirects', 'adminzone');
INSERT INTO `ocp_group_page_access` (`group_id`, `page_name`, `zone_name`) VALUES(6, 'admin_staff', 'adminzone');
INSERT INTO `ocp_group_page_access` (`group_id`, `page_name`, `zone_name`) VALUES(6, 'cms_chat', 'cms');
INSERT INTO `ocp_group_page_access` (`group_id`, `page_name`, `zone_name`) VALUES(6, 'join', '');
INSERT INTO `ocp_group_page_access` (`group_id`, `page_name`, `zone_name`) VALUES(7, 'admin_addons', 'adminzone');
INSERT INTO `ocp_group_page_access` (`group_id`, `page_name`, `zone_name`) VALUES(7, 'admin_import', 'adminzone');
INSERT INTO `ocp_group_page_access` (`group_id`, `page_name`, `zone_name`) VALUES(7, 'admin_occle', 'adminzone');
INSERT INTO `ocp_group_page_access` (`group_id`, `page_name`, `zone_name`) VALUES(7, 'admin_redirects', 'adminzone');
INSERT INTO `ocp_group_page_access` (`group_id`, `page_name`, `zone_name`) VALUES(7, 'admin_staff', 'adminzone');
INSERT INTO `ocp_group_page_access` (`group_id`, `page_name`, `zone_name`) VALUES(7, 'cms_chat', 'cms');
INSERT INTO `ocp_group_page_access` (`group_id`, `page_name`, `zone_name`) VALUES(7, 'join', '');
INSERT INTO `ocp_group_page_access` (`group_id`, `page_name`, `zone_name`) VALUES(8, 'admin_addons', 'adminzone');
INSERT INTO `ocp_group_page_access` (`group_id`, `page_name`, `zone_name`) VALUES(8, 'admin_import', 'adminzone');
INSERT INTO `ocp_group_page_access` (`group_id`, `page_name`, `zone_name`) VALUES(8, 'admin_occle', 'adminzone');
INSERT INTO `ocp_group_page_access` (`group_id`, `page_name`, `zone_name`) VALUES(8, 'admin_redirects', 'adminzone');
INSERT INTO `ocp_group_page_access` (`group_id`, `page_name`, `zone_name`) VALUES(8, 'admin_staff', 'adminzone');
INSERT INTO `ocp_group_page_access` (`group_id`, `page_name`, `zone_name`) VALUES(8, 'cms_chat', 'cms');
INSERT INTO `ocp_group_page_access` (`group_id`, `page_name`, `zone_name`) VALUES(8, 'join', '');
INSERT INTO `ocp_group_page_access` (`group_id`, `page_name`, `zone_name`) VALUES(9, 'admin_addons', 'adminzone');
INSERT INTO `ocp_group_page_access` (`group_id`, `page_name`, `zone_name`) VALUES(9, 'admin_import', 'adminzone');
INSERT INTO `ocp_group_page_access` (`group_id`, `page_name`, `zone_name`) VALUES(9, 'admin_occle', 'adminzone');
INSERT INTO `ocp_group_page_access` (`group_id`, `page_name`, `zone_name`) VALUES(9, 'admin_redirects', 'adminzone');
INSERT INTO `ocp_group_page_access` (`group_id`, `page_name`, `zone_name`) VALUES(9, 'admin_staff', 'adminzone');
INSERT INTO `ocp_group_page_access` (`group_id`, `page_name`, `zone_name`) VALUES(9, 'cms_chat', 'cms');
INSERT INTO `ocp_group_page_access` (`group_id`, `page_name`, `zone_name`) VALUES(9, 'join', '');
INSERT INTO `ocp_group_page_access` (`group_id`, `page_name`, `zone_name`) VALUES(10, 'admin_addons', 'adminzone');
INSERT INTO `ocp_group_page_access` (`group_id`, `page_name`, `zone_name`) VALUES(10, 'admin_import', 'adminzone');
INSERT INTO `ocp_group_page_access` (`group_id`, `page_name`, `zone_name`) VALUES(10, 'admin_occle', 'adminzone');
INSERT INTO `ocp_group_page_access` (`group_id`, `page_name`, `zone_name`) VALUES(10, 'admin_redirects', 'adminzone');
INSERT INTO `ocp_group_page_access` (`group_id`, `page_name`, `zone_name`) VALUES(10, 'admin_staff', 'adminzone');
INSERT INTO `ocp_group_page_access` (`group_id`, `page_name`, `zone_name`) VALUES(10, 'cms_chat', 'cms');
INSERT INTO `ocp_group_page_access` (`group_id`, `page_name`, `zone_name`) VALUES(10, 'join', '');

-- --------------------------------------------------------

--
-- Table structure for table `ocp_group_zone_access`
--

DROP TABLE IF EXISTS `ocp_group_zone_access`;
CREATE TABLE IF NOT EXISTS `ocp_group_zone_access` (
  `group_id` int(11) NOT NULL,
  `zone_name` varchar(80) NOT NULL,
  PRIMARY KEY (`group_id`,`zone_name`)
) ENGINE=MyISAM;

--
-- Dumping data for table `ocp_group_zone_access`
--

INSERT INTO `ocp_group_zone_access` (`group_id`, `zone_name`) VALUES(1, '');
INSERT INTO `ocp_group_zone_access` (`group_id`, `zone_name`) VALUES(1, 'forum');
INSERT INTO `ocp_group_zone_access` (`group_id`, `zone_name`) VALUES(1, 'site');
INSERT INTO `ocp_group_zone_access` (`group_id`, `zone_name`) VALUES(2, '');
INSERT INTO `ocp_group_zone_access` (`group_id`, `zone_name`) VALUES(2, 'adminzone');
INSERT INTO `ocp_group_zone_access` (`group_id`, `zone_name`) VALUES(2, 'cms');
INSERT INTO `ocp_group_zone_access` (`group_id`, `zone_name`) VALUES(2, 'collaboration');
INSERT INTO `ocp_group_zone_access` (`group_id`, `zone_name`) VALUES(2, 'forum');
INSERT INTO `ocp_group_zone_access` (`group_id`, `zone_name`) VALUES(2, 'personalzone');
INSERT INTO `ocp_group_zone_access` (`group_id`, `zone_name`) VALUES(2, 'site');
INSERT INTO `ocp_group_zone_access` (`group_id`, `zone_name`) VALUES(3, '');
INSERT INTO `ocp_group_zone_access` (`group_id`, `zone_name`) VALUES(3, 'adminzone');
INSERT INTO `ocp_group_zone_access` (`group_id`, `zone_name`) VALUES(3, 'cms');
INSERT INTO `ocp_group_zone_access` (`group_id`, `zone_name`) VALUES(3, 'collaboration');
INSERT INTO `ocp_group_zone_access` (`group_id`, `zone_name`) VALUES(3, 'forum');
INSERT INTO `ocp_group_zone_access` (`group_id`, `zone_name`) VALUES(3, 'personalzone');
INSERT INTO `ocp_group_zone_access` (`group_id`, `zone_name`) VALUES(3, 'site');
INSERT INTO `ocp_group_zone_access` (`group_id`, `zone_name`) VALUES(4, '');
INSERT INTO `ocp_group_zone_access` (`group_id`, `zone_name`) VALUES(4, 'cms');
INSERT INTO `ocp_group_zone_access` (`group_id`, `zone_name`) VALUES(4, 'collaboration');
INSERT INTO `ocp_group_zone_access` (`group_id`, `zone_name`) VALUES(4, 'forum');
INSERT INTO `ocp_group_zone_access` (`group_id`, `zone_name`) VALUES(4, 'personalzone');
INSERT INTO `ocp_group_zone_access` (`group_id`, `zone_name`) VALUES(4, 'site');
INSERT INTO `ocp_group_zone_access` (`group_id`, `zone_name`) VALUES(5, '');
INSERT INTO `ocp_group_zone_access` (`group_id`, `zone_name`) VALUES(5, 'cms');
INSERT INTO `ocp_group_zone_access` (`group_id`, `zone_name`) VALUES(5, 'forum');
INSERT INTO `ocp_group_zone_access` (`group_id`, `zone_name`) VALUES(5, 'personalzone');
INSERT INTO `ocp_group_zone_access` (`group_id`, `zone_name`) VALUES(5, 'site');
INSERT INTO `ocp_group_zone_access` (`group_id`, `zone_name`) VALUES(6, '');
INSERT INTO `ocp_group_zone_access` (`group_id`, `zone_name`) VALUES(6, 'cms');
INSERT INTO `ocp_group_zone_access` (`group_id`, `zone_name`) VALUES(6, 'forum');
INSERT INTO `ocp_group_zone_access` (`group_id`, `zone_name`) VALUES(6, 'personalzone');
INSERT INTO `ocp_group_zone_access` (`group_id`, `zone_name`) VALUES(6, 'site');
INSERT INTO `ocp_group_zone_access` (`group_id`, `zone_name`) VALUES(7, '');
INSERT INTO `ocp_group_zone_access` (`group_id`, `zone_name`) VALUES(7, 'cms');
INSERT INTO `ocp_group_zone_access` (`group_id`, `zone_name`) VALUES(7, 'forum');
INSERT INTO `ocp_group_zone_access` (`group_id`, `zone_name`) VALUES(7, 'personalzone');
INSERT INTO `ocp_group_zone_access` (`group_id`, `zone_name`) VALUES(7, 'site');
INSERT INTO `ocp_group_zone_access` (`group_id`, `zone_name`) VALUES(8, '');
INSERT INTO `ocp_group_zone_access` (`group_id`, `zone_name`) VALUES(8, 'cms');
INSERT INTO `ocp_group_zone_access` (`group_id`, `zone_name`) VALUES(8, 'forum');
INSERT INTO `ocp_group_zone_access` (`group_id`, `zone_name`) VALUES(8, 'personalzone');
INSERT INTO `ocp_group_zone_access` (`group_id`, `zone_name`) VALUES(8, 'site');
INSERT INTO `ocp_group_zone_access` (`group_id`, `zone_name`) VALUES(9, '');
INSERT INTO `ocp_group_zone_access` (`group_id`, `zone_name`) VALUES(9, 'cms');
INSERT INTO `ocp_group_zone_access` (`group_id`, `zone_name`) VALUES(9, 'forum');
INSERT INTO `ocp_group_zone_access` (`group_id`, `zone_name`) VALUES(9, 'personalzone');
INSERT INTO `ocp_group_zone_access` (`group_id`, `zone_name`) VALUES(9, 'site');
INSERT INTO `ocp_group_zone_access` (`group_id`, `zone_name`) VALUES(10, '');
INSERT INTO `ocp_group_zone_access` (`group_id`, `zone_name`) VALUES(10, 'cms');
INSERT INTO `ocp_group_zone_access` (`group_id`, `zone_name`) VALUES(10, 'forum');
INSERT INTO `ocp_group_zone_access` (`group_id`, `zone_name`) VALUES(10, 'personalzone');
INSERT INTO `ocp_group_zone_access` (`group_id`, `zone_name`) VALUES(10, 'site');

-- --------------------------------------------------------

--
-- Table structure for table `ocp_gsp`
--

DROP TABLE IF EXISTS `ocp_gsp`;
CREATE TABLE IF NOT EXISTS `ocp_gsp` (
  `category_name` varchar(80) NOT NULL,
  `group_id` int(11) NOT NULL,
  `module_the_name` varchar(80) NOT NULL,
  `specific_permission` varchar(80) NOT NULL,
  `the_page` varchar(80) NOT NULL,
  `the_value` tinyint(1) NOT NULL,
  PRIMARY KEY (`category_name`,`group_id`,`module_the_name`,`specific_permission`,`the_page`)
) ENGINE=MyISAM;

--
-- Dumping data for table `ocp_gsp`
--

INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('1', 1, 'forums', 'submit_lowrange_content', '', 0);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('1', 1, 'forums', 'submit_midrange_content', '', 0);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('1', 2, 'forums', 'bypass_validation_lowrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('1', 2, 'forums', 'bypass_validation_midrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('1', 3, 'forums', 'bypass_validation_lowrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('1', 3, 'forums', 'bypass_validation_midrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('1', 5, 'forums', 'submit_lowrange_content', '', 0);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('1', 5, 'forums', 'submit_midrange_content', '', 0);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('1', 6, 'forums', 'submit_lowrange_content', '', 0);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('1', 6, 'forums', 'submit_midrange_content', '', 0);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('1', 7, 'forums', 'submit_lowrange_content', '', 0);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('1', 7, 'forums', 'submit_midrange_content', '', 0);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('1', 8, 'forums', 'submit_lowrange_content', '', 0);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('1', 8, 'forums', 'submit_midrange_content', '', 0);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('1', 9, 'forums', 'submit_lowrange_content', '', 0);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('1', 9, 'forums', 'submit_midrange_content', '', 0);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('1', 10, 'forums', 'submit_lowrange_content', '', 0);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('1', 10, 'forums', 'submit_midrange_content', '', 0);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('3', 1, 'forums', 'bypass_validation_lowrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('3', 1, 'forums', 'bypass_validation_midrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('3', 2, 'forums', 'bypass_validation_lowrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('3', 2, 'forums', 'bypass_validation_midrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('3', 3, 'forums', 'bypass_validation_lowrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('3', 3, 'forums', 'bypass_validation_midrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('3', 4, 'forums', 'bypass_validation_lowrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('3', 4, 'forums', 'bypass_validation_midrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('3', 5, 'forums', 'bypass_validation_lowrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('3', 5, 'forums', 'bypass_validation_midrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('3', 6, 'forums', 'bypass_validation_lowrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('3', 6, 'forums', 'bypass_validation_midrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('3', 7, 'forums', 'bypass_validation_lowrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('3', 7, 'forums', 'bypass_validation_midrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('3', 8, 'forums', 'bypass_validation_lowrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('3', 8, 'forums', 'bypass_validation_midrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('3', 9, 'forums', 'bypass_validation_lowrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('3', 9, 'forums', 'bypass_validation_midrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('4', 8, 'forums', 'bypass_validation_midrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('4', 8, 'forums', 'bypass_validation_lowrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('4', 7, 'forums', 'bypass_validation_lowrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('4', 7, 'forums', 'bypass_validation_midrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('4', 6, 'forums', 'bypass_validation_midrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('4', 5, 'forums', 'bypass_validation_midrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('4', 6, 'forums', 'bypass_validation_lowrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('4', 5, 'forums', 'bypass_validation_lowrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('4', 4, 'forums', 'bypass_validation_lowrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('4', 4, 'forums', 'bypass_validation_midrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('4', 3, 'forums', 'bypass_validation_midrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('4', 1, 'forums', 'bypass_validation_midrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('4', 3, 'forums', 'bypass_validation_lowrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('4', 1, 'forums', 'bypass_validation_lowrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('5', 2, 'forums', 'bypass_validation_lowrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('5', 2, 'forums', 'bypass_validation_midrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('5', 3, 'forums', 'bypass_validation_lowrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('5', 3, 'forums', 'bypass_validation_midrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('6', 2, 'forums', 'bypass_validation_lowrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('6', 2, 'forums', 'bypass_validation_midrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('6', 3, 'forums', 'bypass_validation_lowrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('6', 3, 'forums', 'bypass_validation_midrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('7', 1, 'forums', 'bypass_validation_lowrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('7', 1, 'forums', 'bypass_validation_midrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('7', 2, 'forums', 'bypass_validation_lowrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('7', 2, 'forums', 'bypass_validation_midrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('7', 3, 'forums', 'bypass_validation_lowrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('7', 3, 'forums', 'bypass_validation_midrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('7', 4, 'forums', 'bypass_validation_lowrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('7', 4, 'forums', 'bypass_validation_midrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('7', 5, 'forums', 'bypass_validation_lowrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('7', 5, 'forums', 'bypass_validation_midrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('7', 6, 'forums', 'bypass_validation_lowrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('7', 6, 'forums', 'bypass_validation_midrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('7', 7, 'forums', 'bypass_validation_lowrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('7', 7, 'forums', 'bypass_validation_midrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('7', 8, 'forums', 'bypass_validation_lowrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('7', 8, 'forums', 'bypass_validation_midrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('7', 9, 'forums', 'bypass_validation_lowrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('7', 9, 'forums', 'bypass_validation_midrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('8', 2, 'forums', 'bypass_validation_lowrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('8', 2, 'forums', 'bypass_validation_midrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('8', 3, 'forums', 'bypass_validation_lowrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('8', 3, 'forums', 'bypass_validation_midrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('9', 2, 'forums', 'bypass_validation_lowrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('9', 2, 'forums', 'bypass_validation_midrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('9', 3, 'forums', 'bypass_validation_lowrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('9', 3, 'forums', 'bypass_validation_midrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 1, '', 'run_multi_moderations', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'run_multi_moderations', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'run_multi_moderations', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 4, '', 'run_multi_moderations', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 5, '', 'run_multi_moderations', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 6, '', 'run_multi_moderations', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 7, '', 'run_multi_moderations', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 8, '', 'run_multi_moderations', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 9, '', 'run_multi_moderations', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 10, '', 'run_multi_moderations', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 1, '', 'may_track_forums', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'may_track_forums', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'may_track_forums', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 4, '', 'may_track_forums', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 5, '', 'may_track_forums', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 6, '', 'may_track_forums', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 7, '', 'may_track_forums', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 8, '', 'may_track_forums', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 9, '', 'may_track_forums', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 10, '', 'may_track_forums', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 1, '', 'use_pt', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'use_pt', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'use_pt', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 4, '', 'use_pt', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 5, '', 'use_pt', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 6, '', 'use_pt', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 7, '', 'use_pt', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 8, '', 'use_pt', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 9, '', 'use_pt', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 10, '', 'use_pt', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 1, '', 'edit_personal_topic_posts', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'edit_personal_topic_posts', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'edit_personal_topic_posts', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 4, '', 'edit_personal_topic_posts', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 5, '', 'edit_personal_topic_posts', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 6, '', 'edit_personal_topic_posts', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 7, '', 'edit_personal_topic_posts', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 8, '', 'edit_personal_topic_posts', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 9, '', 'edit_personal_topic_posts', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 10, '', 'edit_personal_topic_posts', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 1, '', 'may_unblind_own_poll', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'may_unblind_own_poll', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'may_unblind_own_poll', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 4, '', 'may_unblind_own_poll', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 5, '', 'may_unblind_own_poll', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 6, '', 'may_unblind_own_poll', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 7, '', 'may_unblind_own_poll', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 8, '', 'may_unblind_own_poll', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 9, '', 'may_unblind_own_poll', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 10, '', 'may_unblind_own_poll', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 1, '', 'may_report_post', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'may_report_post', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'may_report_post', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 4, '', 'may_report_post', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 5, '', 'may_report_post', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 6, '', 'may_report_post', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 7, '', 'may_report_post', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 8, '', 'may_report_post', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 9, '', 'may_report_post', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 10, '', 'may_report_post', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 1, '', 'view_member_photos', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'view_member_photos', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'view_member_photos', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 4, '', 'view_member_photos', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 5, '', 'view_member_photos', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 6, '', 'view_member_photos', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 7, '', 'view_member_photos', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 8, '', 'view_member_photos', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 9, '', 'view_member_photos', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 10, '', 'view_member_photos', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 1, '', 'use_quick_reply', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'use_quick_reply', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'use_quick_reply', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 4, '', 'use_quick_reply', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 5, '', 'use_quick_reply', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 6, '', 'use_quick_reply', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 7, '', 'use_quick_reply', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 8, '', 'use_quick_reply', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 9, '', 'use_quick_reply', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 10, '', 'use_quick_reply', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 1, '', 'view_profiles', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'view_profiles', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'view_profiles', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 4, '', 'view_profiles', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 5, '', 'view_profiles', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 6, '', 'view_profiles', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 7, '', 'view_profiles', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 8, '', 'view_profiles', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 9, '', 'view_profiles', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 10, '', 'view_profiles', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 1, '', 'own_avatars', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'own_avatars', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'own_avatars', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 4, '', 'own_avatars', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 5, '', 'own_avatars', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 6, '', 'own_avatars', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 7, '', 'own_avatars', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 8, '', 'own_avatars', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 9, '', 'own_avatars', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 10, '', 'own_avatars', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'rename_self', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'use_special_emoticons', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'view_any_profile_field', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'disable_lost_passwords', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'close_own_topics', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'edit_own_polls', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'double_post', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'see_warnings', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'see_ip', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'may_choose_custom_title', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'delete_account', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'view_poll_results_before_voting', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'moderate_personal_topic', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'member_maintenance', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'probate_members', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'warn_members', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'control_usergroups', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'multi_delete_topics', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'show_user_browsing', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'see_hidden_groups', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'pt_anyone', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'reuse_others_attachments', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'reuse_others_attachments', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'use_sms', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'use_sms', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'sms_higher_limit', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'sms_higher_limit', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'sms_higher_trigger_limit', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'sms_higher_trigger_limit', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'draw_to_server', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'draw_to_server', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'see_unvalidated', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'see_unvalidated', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 1, '', 'jump_to_unvalidated', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'jump_to_unvalidated', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'jump_to_unvalidated', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 4, '', 'jump_to_unvalidated', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 5, '', 'jump_to_unvalidated', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 6, '', 'jump_to_unvalidated', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 7, '', 'jump_to_unvalidated', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 8, '', 'jump_to_unvalidated', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 9, '', 'jump_to_unvalidated', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 10, '', 'jump_to_unvalidated', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 1, '', 'edit_own_lowrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'edit_own_lowrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'edit_own_lowrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 4, '', 'edit_own_lowrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 5, '', 'edit_own_lowrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 6, '', 'edit_own_lowrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 7, '', 'edit_own_lowrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 8, '', 'edit_own_lowrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 9, '', 'edit_own_lowrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 10, '', 'edit_own_lowrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 1, '', 'submit_highrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'submit_highrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'submit_highrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 4, '', 'submit_highrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 5, '', 'submit_highrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 6, '', 'submit_highrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 7, '', 'submit_highrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 8, '', 'submit_highrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 9, '', 'submit_highrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 10, '', 'submit_highrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 1, '', 'submit_midrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'submit_midrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'submit_midrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 4, '', 'submit_midrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 5, '', 'submit_midrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 6, '', 'submit_midrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 7, '', 'submit_midrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 8, '', 'submit_midrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 9, '', 'submit_midrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 10, '', 'submit_midrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 1, '', 'submit_lowrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'submit_lowrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'submit_lowrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 4, '', 'submit_lowrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 5, '', 'submit_lowrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 6, '', 'submit_lowrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 7, '', 'submit_lowrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 8, '', 'submit_lowrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 9, '', 'submit_lowrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 10, '', 'submit_lowrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 1, '', 'bypass_validation_lowrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'bypass_validation_lowrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'bypass_validation_lowrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 4, '', 'bypass_validation_lowrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 5, '', 'bypass_validation_lowrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 6, '', 'bypass_validation_lowrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 7, '', 'bypass_validation_lowrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 8, '', 'bypass_validation_lowrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 9, '', 'bypass_validation_lowrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 10, '', 'bypass_validation_lowrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 1, '', 'set_own_author_profile', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'set_own_author_profile', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'set_own_author_profile', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 4, '', 'set_own_author_profile', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 5, '', 'set_own_author_profile', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 6, '', 'set_own_author_profile', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 7, '', 'set_own_author_profile', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 8, '', 'set_own_author_profile', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 9, '', 'set_own_author_profile', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 10, '', 'set_own_author_profile', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 1, '', 'rate', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'rate', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'rate', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 4, '', 'rate', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 5, '', 'rate', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 6, '', 'rate', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 7, '', 'rate', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 8, '', 'rate', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 9, '', 'rate', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 10, '', 'rate', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 1, '', 'comment', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'comment', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'comment', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 4, '', 'comment', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 5, '', 'comment', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 6, '', 'comment', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 7, '', 'comment', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 8, '', 'comment', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 9, '', 'comment', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 10, '', 'comment', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 1, '', 'have_personal_category', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'have_personal_category', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'have_personal_category', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 4, '', 'have_personal_category', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 5, '', 'have_personal_category', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 6, '', 'have_personal_category', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 7, '', 'have_personal_category', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 8, '', 'have_personal_category', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 9, '', 'have_personal_category', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 10, '', 'have_personal_category', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 1, '', 'vote_in_polls', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'vote_in_polls', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'vote_in_polls', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 4, '', 'vote_in_polls', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 5, '', 'vote_in_polls', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 6, '', 'vote_in_polls', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 7, '', 'vote_in_polls', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 8, '', 'vote_in_polls', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 9, '', 'vote_in_polls', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 10, '', 'vote_in_polls', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'use_very_dangerous_comcode', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'use_very_dangerous_comcode', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'open_virtual_roots', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'open_virtual_roots', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'scheduled_publication_times', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'scheduled_publication_times', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'mass_delete_from_ip', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'mass_delete_from_ip', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'exceed_filesize_limit', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'exceed_filesize_limit', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'view_revision_history', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'view_revision_history', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'sees_javascript_error_alerts', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'sees_javascript_error_alerts', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'see_software_docs', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'see_software_docs', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'bypass_flood_control', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'bypass_flood_control', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'allow_html', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'allow_html', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'remove_page_split', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'remove_page_split', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'access_closed_site', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'access_closed_site', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'bypass_bandwidth_restriction', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'bypass_bandwidth_restriction', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'comcode_dangerous', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'comcode_dangerous', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'comcode_nuisance', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'comcode_nuisance', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'see_php_errors', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'see_php_errors', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'see_stack_dump', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'see_stack_dump', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'bypass_word_filter', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'bypass_word_filter', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'view_profiling_modes', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'view_profiling_modes', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'access_overrun_site', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'access_overrun_site', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'bypass_validation_highrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'bypass_validation_highrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'bypass_validation_midrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'bypass_validation_midrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'edit_highrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'edit_highrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'edit_midrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'edit_midrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'edit_lowrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'edit_lowrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'edit_own_highrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'edit_own_highrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'edit_own_midrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'edit_own_midrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'delete_highrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'delete_highrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'delete_midrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'delete_midrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'delete_lowrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'delete_lowrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'delete_own_highrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'delete_own_highrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'delete_own_midrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'delete_own_midrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'delete_own_lowrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'delete_own_lowrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'can_submit_to_others_categories', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'can_submit_to_others_categories', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'search_engine_links', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'search_engine_links', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'view_content_history', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'view_content_history', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'restore_content_history', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'restore_content_history', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'delete_content_history', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'delete_content_history', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'submit_cat_highrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'submit_cat_highrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'submit_cat_midrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'submit_cat_midrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'submit_cat_lowrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'submit_cat_lowrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'edit_cat_highrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'edit_cat_highrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'edit_cat_midrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'edit_cat_midrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'edit_cat_lowrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'edit_cat_lowrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'delete_cat_highrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'delete_cat_highrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'delete_cat_midrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'delete_cat_midrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'delete_cat_lowrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'delete_cat_lowrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'edit_own_cat_highrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'edit_own_cat_highrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'edit_own_cat_midrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'edit_own_cat_midrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'edit_own_cat_lowrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'edit_own_cat_lowrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'delete_own_cat_highrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'delete_own_cat_highrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'delete_own_cat_midrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'delete_own_cat_midrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'delete_own_cat_lowrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'delete_own_cat_lowrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'mass_import', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'mass_import', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('10', 3, 'forums', 'bypass_validation_lowrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('10', 3, 'forums', 'bypass_validation_midrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'full_banner_setup', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'full_banner_setup', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'view_anyones_banner_stats', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'view_anyones_banner_stats', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'banner_free', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'banner_free', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 1, '', 'view_calendar', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'view_calendar', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'view_calendar', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 4, '', 'view_calendar', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 5, '', 'view_calendar', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 6, '', 'view_calendar', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 7, '', 'view_calendar', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 8, '', 'view_calendar', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 9, '', 'view_calendar', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 10, '', 'view_calendar', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 1, '', 'add_public_events', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'add_public_events', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'add_public_events', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 4, '', 'add_public_events', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 5, '', 'add_public_events', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 6, '', 'add_public_events', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 7, '', 'add_public_events', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 8, '', 'add_public_events', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 9, '', 'add_public_events', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 10, '', 'add_public_events', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'sense_personal_conflicts', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'sense_personal_conflicts', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'view_event_subscriptions', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'view_event_subscriptions', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'high_catalogue_entry_timeout', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'high_catalogue_entry_timeout', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'seedy_manage_tree', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'seedy_manage_tree', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 1, '', 'create_private_room', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'create_private_room', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'create_private_room', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 4, '', 'create_private_room', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 5, '', 'create_private_room', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 6, '', 'create_private_room', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 7, '', 'create_private_room', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 8, '', 'create_private_room', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 9, '', 'create_private_room', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 10, '', 'create_private_room', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 1, '', 'start_im', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'start_im', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'start_im', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 4, '', 'start_im', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 5, '', 'start_im', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 6, '', 'start_im', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 7, '', 'start_im', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 8, '', 'start_im', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 9, '', 'start_im', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 10, '', 'start_im', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 1, '', 'moderate_my_private_rooms', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'moderate_my_private_rooms', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'moderate_my_private_rooms', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 4, '', 'moderate_my_private_rooms', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 5, '', 'moderate_my_private_rooms', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 6, '', 'moderate_my_private_rooms', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 7, '', 'moderate_my_private_rooms', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 8, '', 'moderate_my_private_rooms', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 9, '', 'moderate_my_private_rooms', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 10, '', 'moderate_my_private_rooms', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'ban_chatters_from_rooms', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'ban_chatters_from_rooms', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'may_download_gallery', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'may_download_gallery', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'high_personal_gallery_limit', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'high_personal_gallery_limit', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'no_personal_gallery_limit', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'no_personal_gallery_limit', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'choose_iotd', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'choose_iotd', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'change_newsletter_subscriptions', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'change_newsletter_subscriptions', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 1, '', 'use_points', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'use_points', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'use_points', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 4, '', 'use_points', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 5, '', 'use_points', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 6, '', 'use_points', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 7, '', 'use_points', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 8, '', 'use_points', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 9, '', 'use_points', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 10, '', 'use_points', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'give_points_self', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'give_points_self', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'have_negative_gift_points', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'have_negative_gift_points', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'give_negative_points', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'give_negative_points', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'view_charge_log', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'view_charge_log', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'trace_anonymous_gifts', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'trace_anonymous_gifts', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'choose_poll', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'choose_poll', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'access_ecommerce_in_test_mode', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'access_ecommerce_in_test_mode', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'bypass_quiz_repeat_time_restriction', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'bypass_quiz_repeat_time_restriction', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'perform_tests', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'perform_tests', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 1, '', 'add_tests', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'add_tests', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'add_tests', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 4, '', 'add_tests', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 5, '', 'add_tests', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 6, '', 'add_tests', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 7, '', 'add_tests', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 8, '', 'add_tests', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 9, '', 'add_tests', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 10, '', 'add_tests', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 1, '', 'edit_own_tests', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'edit_own_tests', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'edit_own_tests', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 4, '', 'edit_own_tests', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 5, '', 'edit_own_tests', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 6, '', 'edit_own_tests', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 7, '', 'edit_own_tests', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 8, '', 'edit_own_tests', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 9, '', 'edit_own_tests', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 10, '', 'edit_own_tests', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'support_operator', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'support_operator', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'view_others_tickets', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'view_others_tickets', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'upload_anything_filedump', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'upload_anything_filedump', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 1, '', 'upload_filedump', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'upload_filedump', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'upload_filedump', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 4, '', 'upload_filedump', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 5, '', 'upload_filedump', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 6, '', 'upload_filedump', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 7, '', 'upload_filedump', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 8, '', 'upload_filedump', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 9, '', 'upload_filedump', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 10, '', 'upload_filedump', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 2, '', 'delete_anything_filedump', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'delete_anything_filedump', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 10, '', 'have_personal_category', 'cms_galleries', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 9, '', 'have_personal_category', 'cms_galleries', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 8, '', 'have_personal_category', 'cms_galleries', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 7, '', 'have_personal_category', 'cms_galleries', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 6, '', 'have_personal_category', 'cms_galleries', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 5, '', 'have_personal_category', 'cms_galleries', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 4, '', 'have_personal_category', 'cms_galleries', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'have_personal_category', 'cms_galleries', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 1, '', 'have_personal_category', 'cms_galleries', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 10, '', 'have_personal_category', 'cms_news', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 9, '', 'have_personal_category', 'cms_news', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 8, '', 'have_personal_category', 'cms_news', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 7, '', 'have_personal_category', 'cms_news', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 6, '', 'have_personal_category', 'cms_news', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 5, '', 'have_personal_category', 'cms_news', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 4, '', 'have_personal_category', 'cms_news', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 3, '', 'have_personal_category', 'cms_news', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('', 1, '', 'have_personal_category', 'cms_news', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('4', 9, 'forums', 'bypass_validation_lowrange_content', '', 1);
INSERT INTO `ocp_gsp` (`category_name`, `group_id`, `module_the_name`, `specific_permission`, `the_page`, `the_value`) VALUES('4', 9, 'forums', 'bypass_validation_midrange_content', '', 1);

-- --------------------------------------------------------

--
-- Table structure for table `ocp_hackattack`
--

DROP TABLE IF EXISTS `ocp_hackattack`;
CREATE TABLE IF NOT EXISTS `ocp_hackattack` (
  `data_post` longtext NOT NULL,
  `date_and_time` int(10) unsigned NOT NULL,
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ip` varchar(40) NOT NULL,
  `reason` varchar(80) NOT NULL,
  `reason_param_a` varchar(255) NOT NULL,
  `reason_param_b` varchar(255) NOT NULL,
  `referer` varchar(255) NOT NULL,
  `the_user` int(11) NOT NULL,
  `url` varchar(255) NOT NULL,
  `user_agent` varchar(255) NOT NULL,
  `user_os` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 ;

--
-- Dumping data for table `ocp_hackattack`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_https_pages`
--

DROP TABLE IF EXISTS `ocp_https_pages`;
CREATE TABLE IF NOT EXISTS `ocp_https_pages` (
  `https_page_name` varchar(80) NOT NULL,
  PRIMARY KEY (`https_page_name`)
) ENGINE=MyISAM;

--
-- Dumping data for table `ocp_https_pages`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_images`
--

DROP TABLE IF EXISTS `ocp_images`;
CREATE TABLE IF NOT EXISTS `ocp_images` (
  `add_date` int(10) unsigned NOT NULL,
  `allow_comments` tinyint(4) NOT NULL,
  `allow_rating` tinyint(1) NOT NULL,
  `allow_trackbacks` tinyint(1) NOT NULL,
  `cat` varchar(80) NOT NULL,
  `comments` int(10) unsigned NOT NULL,
  `edit_date` int(10) unsigned DEFAULT NULL,
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `image_views` int(11) NOT NULL,
  `notes` longtext NOT NULL,
  `submitter` int(11) NOT NULL,
  `thumb_url` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  `validated` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `category_list` (`cat`),
  KEY `i_validated` (`validated`)
) ENGINE=MyISAM  AUTO_INCREMENT=3 ;

--
-- Dumping data for table `ocp_images`
--

INSERT INTO `ocp_images` (`add_date`, `allow_comments`, `allow_rating`, `allow_trackbacks`, `cat`, `comments`, `edit_date`, `id`, `image_views`, `notes`, `submitter`, `thumb_url`, `url`, `validated`) VALUES(1264684972, 1, 1, 1, 'randj', 756, NULL, 1, 2, '', 2, 'uploads/galleries_thumbs/Romeo_and_juliet_brown.jpg', 'uploads/galleries/Romeo_and_juliet_brown.jpg', 1);
INSERT INTO `ocp_images` (`add_date`, `allow_comments`, `allow_rating`, `allow_trackbacks`, `cat`, `comments`, `edit_date`, `id`, `image_views`, `notes`, `submitter`, `thumb_url`, `url`, `validated`) VALUES(1264685116, 1, 1, 1, 'randj', 760, NULL, 2, 1, '', 2, 'uploads/galleries_thumbs/romeo_and_juliet_.jpg', 'uploads/galleries/romeo_and_juliet_.jpg', 1);

-- --------------------------------------------------------

--
-- Table structure for table `ocp_import_id_remap`
--

DROP TABLE IF EXISTS `ocp_import_id_remap`;
CREATE TABLE IF NOT EXISTS `ocp_import_id_remap` (
  `id_new` int(11) NOT NULL,
  `id_old` varchar(80) NOT NULL,
  `id_session` int(11) NOT NULL,
  `id_type` varchar(80) NOT NULL,
  PRIMARY KEY (`id_old`,`id_session`,`id_type`)
) ENGINE=MyISAM;

--
-- Dumping data for table `ocp_import_id_remap`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_import_parts_done`
--

DROP TABLE IF EXISTS `ocp_import_parts_done`;
CREATE TABLE IF NOT EXISTS `ocp_import_parts_done` (
  `imp_id` varchar(255) NOT NULL,
  `imp_session` int(11) NOT NULL,
  PRIMARY KEY (`imp_id`,`imp_session`)
) ENGINE=MyISAM;

--
-- Dumping data for table `ocp_import_parts_done`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_import_session`
--

DROP TABLE IF EXISTS `ocp_import_session`;
CREATE TABLE IF NOT EXISTS `ocp_import_session` (
  `imp_db_name` varchar(80) NOT NULL,
  `imp_db_table_prefix` varchar(80) NOT NULL,
  `imp_db_user` varchar(80) NOT NULL,
  `imp_hook` varchar(80) NOT NULL,
  `imp_old_base_dir` varchar(255) NOT NULL,
  `imp_refresh_time` int(11) NOT NULL,
  `imp_session` int(11) NOT NULL,
  PRIMARY KEY (`imp_session`)
) ENGINE=MyISAM;

--
-- Dumping data for table `ocp_import_session`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_incoming_uploads`
--

DROP TABLE IF EXISTS `ocp_incoming_uploads`;
CREATE TABLE IF NOT EXISTS `ocp_incoming_uploads` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `i_date_and_time` int(10) unsigned NOT NULL,
  `i_orig_filename` varchar(80) NOT NULL,
  `i_save_url` varchar(255) NOT NULL,
  `i_submitter` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  AUTO_INCREMENT=14 ;

--
-- Dumping data for table `ocp_incoming_uploads`
--

INSERT INTO `ocp_incoming_uploads` (`id`, `i_date_and_time`, `i_orig_filename`, `i_save_url`, `i_submitter`) VALUES(13, 1265480593, 'Shakespeare-1.jpg', 'uploads/incoming/4b6db391be243.dat', 2);
INSERT INTO `ocp_incoming_uploads` (`id`, `i_date_and_time`, `i_orig_filename`, `i_save_url`, `i_submitter`) VALUES(12, 1265480588, 'Shakespeare-1.jpg', 'uploads/incoming/4b6db38c644c9.dat', 2);

-- --------------------------------------------------------

--
-- Table structure for table `ocp_invoices`
--

DROP TABLE IF EXISTS `ocp_invoices`;
CREATE TABLE IF NOT EXISTS `ocp_invoices` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `i_amount` varchar(255) NOT NULL,
  `i_member_id` int(11) NOT NULL,
  `i_note` longtext NOT NULL,
  `i_special` varchar(255) NOT NULL,
  `i_state` varchar(80) NOT NULL,
  `i_time` int(10) unsigned NOT NULL,
  `i_type_code` varchar(80) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 ;

--
-- Dumping data for table `ocp_invoices`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_iotd`
--

DROP TABLE IF EXISTS `ocp_iotd`;
CREATE TABLE IF NOT EXISTS `ocp_iotd` (
  `add_date` int(10) unsigned NOT NULL,
  `allow_comments` tinyint(4) NOT NULL,
  `allow_rating` tinyint(1) NOT NULL,
  `allow_trackbacks` tinyint(1) NOT NULL,
  `caption` int(10) unsigned NOT NULL,
  `date_and_time` int(10) unsigned DEFAULT NULL,
  `edit_date` int(10) unsigned DEFAULT NULL,
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `iotd_views` int(11) NOT NULL,
  `is_current` tinyint(1) NOT NULL,
  `i_title` int(10) unsigned NOT NULL,
  `notes` longtext NOT NULL,
  `submitter` int(11) NOT NULL,
  `thumb_url` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  `used` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `get_current` (`is_current`)
) ENGINE=MyISAM  AUTO_INCREMENT=2 ;

--
-- Dumping data for table `ocp_iotd`
--

INSERT INTO `ocp_iotd` (`add_date`, `allow_comments`, `allow_rating`, `allow_trackbacks`, `caption`, `date_and_time`, `edit_date`, `id`, `iotd_views`, `is_current`, `i_title`, `notes`, `submitter`, `thumb_url`, `url`, `used`) VALUES(1264673745, 1, 1, 1, 630, 1264673745, NULL, 1, 1, 1, 629, '', 2, 'uploads/iotds_thumbs/Shakespeare.jpg', 'uploads/iotds/Shakespeare.jpg', 1);

-- --------------------------------------------------------

--
-- Table structure for table `ocp_ip_country`
--

DROP TABLE IF EXISTS `ocp_ip_country`;
CREATE TABLE IF NOT EXISTS `ocp_ip_country` (
  `begin_num` int(10) unsigned NOT NULL,
  `country` varchar(255) NOT NULL,
  `end_num` int(10) unsigned NOT NULL,
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 ;

--
-- Dumping data for table `ocp_ip_country`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_leader_board`
--

DROP TABLE IF EXISTS `ocp_leader_board`;
CREATE TABLE IF NOT EXISTS `ocp_leader_board` (
  `date_and_time` int(10) unsigned NOT NULL,
  `lb_member` int(11) NOT NULL,
  `lb_points` int(11) NOT NULL,
  PRIMARY KEY (`date_and_time`,`lb_member`)
) ENGINE=MyISAM;

--
-- Dumping data for table `ocp_leader_board`
--

INSERT INTO `ocp_leader_board` (`date_and_time`, `lb_member`, `lb_points`) VALUES(1264607454, 3, 40);
INSERT INTO `ocp_leader_board` (`date_and_time`, `lb_member`, `lb_points`) VALUES(1264607454, 2, 40);
INSERT INTO `ocp_leader_board` (`date_and_time`, `lb_member`, `lb_points`) VALUES(1265397261, 2, 1470);
INSERT INTO `ocp_leader_board` (`date_and_time`, `lb_member`, `lb_points`) VALUES(1265397261, 3, 40);

-- --------------------------------------------------------

--
-- Table structure for table `ocp_link_tracker`
--

DROP TABLE IF EXISTS `ocp_link_tracker`;
CREATE TABLE IF NOT EXISTS `ocp_link_tracker` (
  `c_date_and_time` int(10) unsigned NOT NULL,
  `c_ip_address` varchar(40) NOT NULL,
  `c_member_id` int(11) NOT NULL,
  `c_url` varchar(255) NOT NULL,
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 ;

--
-- Dumping data for table `ocp_link_tracker`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_logged_mail_messages`
--

DROP TABLE IF EXISTS `ocp_logged_mail_messages`;
CREATE TABLE IF NOT EXISTS `ocp_logged_mail_messages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `m_as` int(11) NOT NULL,
  `m_as_admin` tinyint(1) NOT NULL,
  `m_attachments` longtext NOT NULL,
  `m_date_and_time` int(10) unsigned NOT NULL,
  `m_from_email` varchar(255) NOT NULL,
  `m_from_name` varchar(255) NOT NULL,
  `m_in_html` tinyint(1) NOT NULL,
  `m_member_id` int(11) NOT NULL,
  `m_message` longtext NOT NULL,
  `m_no_cc` tinyint(1) NOT NULL,
  `m_priority` tinyint(4) NOT NULL,
  `m_queued` tinyint(1) NOT NULL,
  `m_subject` varchar(255) NOT NULL,
  `m_to_email` longtext NOT NULL,
  `m_to_name` longtext NOT NULL,
  `m_url` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  AUTO_INCREMENT=12 ;

--
-- Dumping data for table `ocp_logged_mail_messages`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_long_values`
--

DROP TABLE IF EXISTS `ocp_long_values`;
CREATE TABLE IF NOT EXISTS `ocp_long_values` (
  `date_and_time` int(10) unsigned NOT NULL,
  `the_name` varchar(80) NOT NULL,
  `the_value` longtext NOT NULL,
  PRIMARY KEY (`the_name`)
) ENGINE=MyISAM;

--
-- Dumping data for table `ocp_long_values`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_match_key_messages`
--

DROP TABLE IF EXISTS `ocp_match_key_messages`;
CREATE TABLE IF NOT EXISTS `ocp_match_key_messages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `k_match_key` varchar(255) NOT NULL,
  `k_message` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 ;

--
-- Dumping data for table `ocp_match_key_messages`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_member_category_access`
--

DROP TABLE IF EXISTS `ocp_member_category_access`;
CREATE TABLE IF NOT EXISTS `ocp_member_category_access` (
  `active_until` int(10) unsigned NOT NULL,
  `category_name` varchar(80) NOT NULL,
  `member_id` int(11) NOT NULL,
  `module_the_name` varchar(80) NOT NULL,
  PRIMARY KEY (`active_until`,`category_name`,`member_id`,`module_the_name`)
) ENGINE=MyISAM;

--
-- Dumping data for table `ocp_member_category_access`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_member_page_access`
--

DROP TABLE IF EXISTS `ocp_member_page_access`;
CREATE TABLE IF NOT EXISTS `ocp_member_page_access` (
  `active_until` int(10) unsigned NOT NULL,
  `member_id` int(11) NOT NULL,
  `page_name` varchar(80) NOT NULL,
  `zone_name` varchar(80) NOT NULL,
  PRIMARY KEY (`active_until`,`member_id`,`page_name`,`zone_name`)
) ENGINE=MyISAM;

--
-- Dumping data for table `ocp_member_page_access`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_member_tracking`
--

DROP TABLE IF EXISTS `ocp_member_tracking`;
CREATE TABLE IF NOT EXISTS `ocp_member_tracking` (
  `mt_cache_username` varchar(80) NOT NULL,
  `mt_id` varchar(80) NOT NULL,
  `mt_member_id` int(11) NOT NULL,
  `mt_page` varchar(80) NOT NULL,
  `mt_time` int(10) unsigned NOT NULL,
  `mt_type` varchar(80) NOT NULL,
  PRIMARY KEY (`mt_id`,`mt_member_id`,`mt_page`,`mt_time`,`mt_type`)
) ENGINE=MyISAM;

--
-- Dumping data for table `ocp_member_tracking`
--

INSERT INTO `ocp_member_tracking` (`mt_cache_username`, `mt_id`, `mt_member_id`, `mt_page`, `mt_time`, `mt_type`) VALUES('admin', '6', 2, 'topicview', 1265477649, '');

-- --------------------------------------------------------

--
-- Table structure for table `ocp_member_zone_access`
--

DROP TABLE IF EXISTS `ocp_member_zone_access`;
CREATE TABLE IF NOT EXISTS `ocp_member_zone_access` (
  `active_until` int(10) unsigned NOT NULL,
  `member_id` int(11) NOT NULL,
  `zone_name` varchar(80) NOT NULL,
  PRIMARY KEY (`active_until`,`member_id`,`zone_name`)
) ENGINE=MyISAM;

--
-- Dumping data for table `ocp_member_zone_access`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_menu_items`
--

DROP TABLE IF EXISTS `ocp_menu_items`;
CREATE TABLE IF NOT EXISTS `ocp_menu_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `i_caption` int(10) unsigned NOT NULL,
  `i_caption_long` int(10) unsigned NOT NULL,
  `i_check_permissions` tinyint(1) NOT NULL,
  `i_expanded` tinyint(1) NOT NULL,
  `i_menu` varchar(80) NOT NULL,
  `i_new_window` tinyint(1) NOT NULL,
  `i_order` int(11) NOT NULL,
  `i_page_only` varchar(80) NOT NULL,
  `i_parent` int(11) DEFAULT NULL,
  `i_theme_img_code` varchar(80) NOT NULL,
  `i_url` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  AUTO_INCREMENT=99 ;

--
-- Dumping data for table `ocp_menu_items`
--

INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(1, 93, 94, 0, 0, 'root_website', 0, 0, '', NULL, '', ':');
INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(2, 95, 96, 0, 0, 'root_website', 0, 1, '', NULL, '', '_SELF:rules');
INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(97, 1011, 1012, 0, 0, 'main_features', 0, 8, '', NULL, '', 'site:galleries');
INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(96, 1009, 1010, 0, 0, 'main_features', 0, 7, '', NULL, '', 'site:cedi');
INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(6, 103, 104, 0, 0, 'main_community', 0, 5, '', NULL, '', '_SEARCH:members:type=misc');
INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(7, 105, 106, 0, 0, 'main_community', 0, 6, '', NULL, '', '_SEARCH:groups:type=misc');
INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(8, 107, 108, 0, 0, 'main_website', 0, 7, '', NULL, '', '_SEARCH:donate');
INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(9, 109, 110, 1, 0, 'member_features', 0, 8, '', NULL, '', '_SEARCH:join:type=misc');
INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(10, 111, 112, 0, 0, 'member_features', 0, 9, '', NULL, '', '_SEARCH:lostpassword:type=misc');
INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(11, 113, 114, 0, 0, 'collab_website', 0, 10, '', NULL, '', 'collaboration:');
INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(12, 115, 116, 0, 0, 'collab_website', 0, 11, '', NULL, '', 'collaboration:about');
INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(13, 117, 118, 0, 0, 'collab_website', 0, 12, '', NULL, '', '_SELF:hosting-submit');
INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(14, 119, 120, 0, 0, 'collab_features', 0, 13, '', NULL, '', '_SELF:authors:type=misc');
INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(15, 121, 122, 0, 0, 'collab_features', 0, 14, '', NULL, '', '_SEARCH:cms_authors:type=_ad');
INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(16, 123, 124, 0, 0, 'pc_features', 0, 15, '', NULL, '', '_SEARCH:myhome:id={$USER_OVERIDE}');
INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(17, 125, 126, 0, 0, 'pc_features', 0, 16, '', NULL, '', '_SEARCH:members:type=view:id={$USER_OVERIDE}');
INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(18, 127, 128, 0, 0, 'pc_edit', 0, 17, '', NULL, '', '_SEARCH:editprofile:type=misc:id={$USER_OVERIDE}');
INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(19, 129, 130, 0, 0, 'pc_edit', 0, 18, '', NULL, '', '_SEARCH:editavatar:type=misc:id={$USER_OVERIDE}');
INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(20, 131, 132, 0, 0, 'pc_edit', 0, 19, '', NULL, '', '_SEARCH:editphoto:type=misc:id={$USER_OVERIDE}');
INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(21, 133, 134, 0, 0, 'pc_edit', 0, 20, '', NULL, '', '_SEARCH:editsignature:type=misc:id={$USER_OVERIDE}');
INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(22, 135, 136, 0, 0, 'pc_edit', 0, 21, '', NULL, '', '_SEARCH:edittitle:type=misc:id={$USER_OVERIDE}');
INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(23, 137, 138, 0, 0, 'pc_edit', 0, 22, '', NULL, '', 'personalzone:privacy:type=misc:id={$USER_OVERIDE}');
INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(24, 139, 140, 0, 0, 'pc_edit', 0, 23, '', NULL, '', '_SEARCH:delete:type=misc:id={$USER_OVERIDE}');
INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(25, 141, 142, 0, 0, 'forum_features', 0, 24, '', NULL, '', '_SELF:rules');
INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(26, 143, 144, 0, 0, 'forum_features', 0, 25, '', NULL, '', '_SEARCH:members:type=misc');
INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(27, 145, 146, 0, 0, 'forum_personal', 0, 26, '', NULL, '', '_SEARCH:members:type=view');
INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(28, 147, 148, 0, 0, 'forum_personal', 0, 27, '', NULL, '', '_SEARCH:editprofile:type=misc');
INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(29, 149, 150, 0, 0, 'forum_personal', 0, 28, '', NULL, '', '_SEARCH:editavatar:type=misc');
INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(30, 151, 152, 0, 0, 'forum_personal', 0, 29, '', NULL, '', '_SEARCH:editphoto:type=misc');
INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(31, 153, 154, 0, 0, 'forum_personal', 0, 30, '', NULL, '', '_SEARCH:editsignature:type=misc');
INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(32, 155, 156, 0, 0, 'forum_personal', 0, 31, '', NULL, '', '_SEARCH:edittitle:type=misc');
INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(33, 157, 158, 1, 0, 'zone_menu', 0, 32, '', NULL, '', 'site:');
INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(34, 159, 160, 1, 0, 'zone_menu', 0, 33, '', NULL, '', 'forum:forumview');
INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(35, 161, 162, 1, 0, 'zone_menu', 0, 34, '', NULL, '', 'personalzone:myhome');
INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(36, 163, 164, 1, 0, 'zone_menu', 0, 35, '', NULL, '', 'collaboration:');
INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(37, 165, 166, 1, 0, 'zone_menu', 0, 36, '', NULL, '', 'cms:cms');
INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(38, 167, 168, 1, 0, 'zone_menu', 0, 37, '', NULL, '', 'adminzone:');
INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(39, 182, 183, 0, 0, 'pc_features', 0, 0, '', NULL, '', '_SEARCH:calendar:type=misc:member_id={$USER_OVERIDE}');
INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(40, 268, 269, 0, 0, 'main_content', 0, 1, '', NULL, '', '_SEARCH:catalogues:type=misc');
INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(41, 270, 271, 0, 0, 'collab_features', 0, 2, '', NULL, '', '');
INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(42, 272, 273, 0, 0, 'collab_features', 0, 3, '', 41, '', '_SEARCH:catalogues:id=projects:type=index');
INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(43, 274, 275, 0, 0, 'collab_features', 0, 4, '', 41, '', '_SEARCH:cms_catalogues:catalogue_name=projects:type=add_entry');
INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(44, 304, 305, 0, 0, 'cedi_features', 0, 5, '', NULL, '', '_SEARCH:cedi:type=misc');
INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(45, 306, 307, 0, 0, 'cedi_features', 0, 6, '', NULL, '', '_SEARCH:cedi:type=random');
INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(46, 308, 309, 0, 0, 'cedi_features', 0, 7, '', NULL, '', '_SEARCH:cedi:type=changes');
INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(47, 310, 311, 0, 0, 'cedi_features', 0, 8, '', NULL, '', '_SEARCH:cedi:type=tree');
INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(48, 315, 316, 0, 0, 'main_community', 0, 9, '', NULL, '', '_SEARCH:chat:type=misc');
INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(49, 317, 318, 0, 0, 'pc_features', 0, 10, '', NULL, '', '_SEARCH:chat:type=misc:member_id={$USER_OVERIDE}');
INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(50, 321, 322, 0, 0, 'main_content', 0, 11, '', NULL, '', '_SEARCH:downloads:type=misc');
INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(51, 323, 324, 0, 0, 'main_content', 0, 12, '', NULL, '', '_SEARCH:galleries:type=misc');
INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(52, 337, 338, 0, 0, 'pc_features', 0, 13, '', NULL, '', '_SEARCH:cms_news:type=ad');
INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(53, 339, 340, 0, 0, 'main_website', 0, 14, '', NULL, '', '_SEARCH:newsletter:type=misc');
INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(54, 341, 342, 0, 0, 'pc_edit', 0, 15, '', NULL, '', '_SEARCH:newsletter:type=misc');
INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(55, 345, 346, 0, 0, 'pc_features', 0, 16, '', NULL, '', '_SEARCH:points:type=member:id={$USER_OVERIDE}');
INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(56, 347, 348, 0, 0, 'forum_personal', 0, 17, '', NULL, '', '_SEARCH:points:type=member');
INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(57, 349, 350, 0, 0, 'main_community', 0, 18, '', NULL, '', '_SEARCH:pointstore:type=misc');
INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(58, 367, 368, 0, 0, 'pc_features', 0, 19, '', NULL, '', '_SELF:invoices:type=misc');
INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(59, 369, 370, 0, 0, 'pc_features', 0, 20, '', NULL, '', '_SELF:subscriptions:type=misc');
INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(60, 371, 372, 0, 0, 'ecommerce_features', 0, 21, '', NULL, '', '_SEARCH:purchase:type=misc');
INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(61, 373, 374, 0, 0, 'ecommerce_features', 0, 22, '', NULL, '', '_SEARCH:invoices:type=misc');
INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(62, 375, 376, 0, 0, 'ecommerce_features', 0, 23, '', NULL, '', '_SEARCH:subscriptions:type=misc');
INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(63, 377, 378, 0, 0, 'ecommerce_features', 0, 24, '', NULL, '', '_SEARCH:shopping:type=my_orders');
INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(64, 393, 394, 0, 0, 'main_website', 0, 25, '', NULL, '', '_SEARCH:staff:type=misc');
INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(65, 397, 398, 0, 0, 'main_website', 0, 26, '', NULL, '', '_SEARCH:tickets:type=misc');
INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(66, 399, 400, 0, 0, 'pc_features', 0, 27, '', NULL, '', '_SEARCH:tickets:type=misc');
INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(67, 401, 402, 0, 0, 'member_features', 0, 0, '', NULL, '', '_SEARCH:forumview:type=misc');
INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(68, 403, 404, 0, 0, 'pc_features', 0, 1, '', NULL, '', '_SEARCH:forumview:type=pt:id={$USER_OVERIDE}');
INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(69, 405, 406, 0, 0, 'forum_features', 0, 2, '', NULL, '', '_SEARCH:forumview:type=misc');
INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(70, 407, 408, 0, 0, 'forum_features', 0, 3, '', NULL, '', '_SEARCH:forumview:type=pt');
INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(71, 409, 410, 0, 0, 'forum_features', 0, 4, '', NULL, '', '_SEARCH:vforums:type=misc');
INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(72, 411, 412, 0, 0, 'forum_features', 0, 5, '', NULL, '', '_SEARCH:vforums:type=unread');
INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(73, 413, 414, 0, 0, 'forum_features', 0, 6, '', NULL, '', '_SEARCH:vforums:type=recently_read');
INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(74, 415, 416, 0, 0, 'forum_features', 0, 7, '', NULL, '', '_SEARCH:search:type=misc:id=ocf_posts');
INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(95, 1007, 1008, 0, 0, 'main_features', 0, 6, '', NULL, '', 'site:downloads');
INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(76, 419, 420, 0, 0, 'root_website', 0, 100, '', NULL, '', '_SEARCH:recommend:from={$SELF_URL}');
INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(77, 421, 422, 0, 0, 'collab_features', 0, 101, '', NULL, '', '_SEARCH:filedump:type=misc');
INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(78, 423, 424, 0, 0, 'collab_website', 0, 102, '', NULL, '', '_SEARCH:supermembers');
INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(98, 1013, 1014, 0, 0, 'main_features', 0, 9, '', NULL, '', 'forum:');
INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(94, 1005, 1006, 0, 0, 'main_features', 0, 4, '', 89, '', ':feedback');
INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(93, 1003, 1004, 0, 0, 'main_features', 0, 3, '', 89, '', ':sitemap');
INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(92, 1001, 1002, 0, 0, 'main_features', 0, 2, '', 89, '', ':rules');
INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(91, 999, 1000, 0, 0, 'main_features', 0, 1, '', 89, '', ':rich');
INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(90, 997, 998, 0, 0, 'main_features', 0, 0, '', 89, '', ':menus');
INSERT INTO `ocp_menu_items` (`id`, `i_caption`, `i_caption_long`, `i_check_permissions`, `i_expanded`, `i_menu`, `i_new_window`, `i_order`, `i_page_only`, `i_parent`, `i_theme_img_code`, `i_url`) VALUES(89, 995, 996, 0, 0, 'main_features', 0, 0, '', NULL, '', '');

-- --------------------------------------------------------

--
-- Table structure for table `ocp_messages_to_render`
--

DROP TABLE IF EXISTS `ocp_messages_to_render`;
CREATE TABLE IF NOT EXISTS `ocp_messages_to_render` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `r_message` longtext NOT NULL,
  `r_session_id` int(11) NOT NULL,
  `r_time` int(10) unsigned NOT NULL,
  `r_type` varchar(80) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  AUTO_INCREMENT=48 ;

--
-- Dumping data for table `ocp_messages_to_render`
--

INSERT INTO `ocp_messages_to_render` (`id`, `r_message`, `r_session_id`, `r_time`, `r_type`) VALUES(47, 'Your backup is currently being generated in the <tt>exports/backups</tt> directory as <tt>Backup_full_2010-02-06__4b6dbded42275</tt>. You will receive an e-mail once it has been completed, and you will be able to track progress by viewing the log file. Please test your backups are properly generated at least once for any server you host this software on; some servers cause problems that can result in corrupt backup files.', 1234, 1265483245, 'inform');

-- --------------------------------------------------------

--
-- Table structure for table `ocp_modules`
--

DROP TABLE IF EXISTS `ocp_modules`;
CREATE TABLE IF NOT EXISTS `ocp_modules` (
  `module_author` varchar(80) NOT NULL,
  `module_hacked_by` varchar(80) NOT NULL,
  `module_hack_version` int(11) DEFAULT NULL,
  `module_organisation` varchar(80) NOT NULL,
  `module_the_name` varchar(80) NOT NULL,
  `module_version` int(11) NOT NULL,
  PRIMARY KEY (`module_the_name`)
) ENGINE=MyISAM;

--
-- Dumping data for table `ocp_modules`
--

INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'admin_permissions', 6);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'admin_version', 11);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'admin', 2);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'admin_actionlog', 2);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'admin_addons', 3);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'admin_awards', 3);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'admin_backup', 3);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'admin_banners', 2);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'admin_bulkupload', 2);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'admin_chat', 2);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'admin_cleanup', 3);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'admin_config', 9);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'admin_custom_comcode', 2);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'admin_debrand', 2);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'admin_ecommerce', 2);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'admin_errorlog', 2);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'admin_flagrant', 2);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'admin_import', 5);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'admin_invoices', 2);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'admin_ipban', 4);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'admin_lang', 2);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'admin_lookup', 2);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'admin_menus', 2);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'admin_messaging', 2);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'admin_newsletter', 2);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Philip Withnall', '', NULL, 'ocProducts', 'admin_occle', 2);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'admin_ocf_categories', 2);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'admin_ocf_customprofilefields', 2);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'admin_ocf_emoticons', 2);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'admin_ocf_forums', 2);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'admin_ocf_groups', 2);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'admin_ocf_history', 2);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'admin_ocf_join', 2);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'admin_ocf_ldap', 4);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'admin_ocf_merge_members', 2);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'admin_ocf_multimoderations', 2);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'admin_ocf_post_templates', 2);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'admin_ocf_welcome_emails', 3);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Manuprathap', '', NULL, 'ocProducts', 'admin_orders', 2);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'admin_phpinfo', 2);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'admin_points', 2);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'admin_pointstore', 2);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'admin_quiz', 2);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'admin_redirects', 3);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'admin_security', 3);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'admin_setupwizard', 2);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'admin_sitetree', 4);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'admin_ssl', 2);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'admin_staff', 3);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Philip Withnall', '', NULL, 'ocProducts', 'admin_stats', 7);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'admin_themes', 3);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Allen Ellis', '', NULL, 'ocProducts', 'admin_themewizard', 2);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'admin_tickets', 2);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'admin_trackbacks', 2);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'admin_unvalidated', 2);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'admin_wordfilter', 3);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'admin_xml_storage', 2);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'admin_zones', 2);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'authors', 3);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'awards', 2);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'banners', 5);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'bookmarks', 2);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'calendar', 5);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'catalogues', 5);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'cedi', 8);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Philip Withnall', '', NULL, 'ocProducts', 'chat', 11);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'contactmember', 2);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'downloads', 6);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'galleries', 5);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'groups', 2);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'invoices', 2);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'iotds', 4);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'leader_board', 2);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'members', 2);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'news', 5);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'newsletter', 8);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'onlinemembers', 2);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'points', 5);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Allen Ellis', '', NULL, 'ocProducts', 'pointstore', 4);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'polls', 4);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'purchase', 4);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'quiz', 3);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'search', 3);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Manuprathap', '', NULL, 'ocProducts', 'shopping', 5);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'staff', 2);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'subscriptions', 4);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'tester', 2);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'tickets', 4);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'warnings', 2);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'forumview', 2);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'topics', 2);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'topicview', 2);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'vforums', 2);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'delete', 2);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'editavatar', 2);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'editphoto', 2);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'editprofile', 2);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'editsignature', 2);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'edittitle', 2);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'myhome', 2);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Kamen', '', NULL, 'ocProducts', 'privacy', 1);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'cms', 2);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'cms_authors', 3);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'cms_banners', 2);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'cms_blogs', 2);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'cms_calendar', 2);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'cms_catalogues', 2);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'cms_cedi', 4);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Philip Withnall', '', NULL, 'ocProducts', 'cms_chat', 3);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'cms_comcode_pages', 2);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'cms_downloads', 2);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'cms_galleries', 2);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'cms_iotds', 2);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'cms_news', 2);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'cms_ocf_groups', 2);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'cms_polls', 2);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'cms_quiz', 2);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'forums', 2);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'join', 2);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'login', 2);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'lostpassword', 2);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'recommend', 2);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'filedump', 3);
INSERT INTO `ocp_modules` (`module_author`, `module_hacked_by`, `module_hack_version`, `module_organisation`, `module_the_name`, `module_version`) VALUES('Chris Graham', '', NULL, 'ocProducts', 'supermembers', 2);

-- --------------------------------------------------------

--
-- Table structure for table `ocp_msp`
--

DROP TABLE IF EXISTS `ocp_msp`;
CREATE TABLE IF NOT EXISTS `ocp_msp` (
  `active_until` int(10) unsigned NOT NULL,
  `category_name` varchar(80) NOT NULL,
  `member_id` int(11) NOT NULL,
  `module_the_name` varchar(80) NOT NULL,
  `specific_permission` varchar(80) NOT NULL,
  `the_page` varchar(80) NOT NULL,
  `the_value` tinyint(1) NOT NULL,
  PRIMARY KEY (`active_until`,`category_name`,`member_id`,`module_the_name`,`specific_permission`,`the_page`)
) ENGINE=MyISAM;

--
-- Dumping data for table `ocp_msp`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_news`
--

DROP TABLE IF EXISTS `ocp_news`;
CREATE TABLE IF NOT EXISTS `ocp_news` (
  `allow_comments` tinyint(4) NOT NULL,
  `allow_rating` tinyint(1) NOT NULL,
  `allow_trackbacks` tinyint(1) NOT NULL,
  `author` varchar(80) NOT NULL,
  `date_and_time` int(10) unsigned NOT NULL,
  `edit_date` int(10) unsigned DEFAULT NULL,
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `news` int(10) unsigned NOT NULL,
  `news_article` int(10) unsigned NOT NULL,
  `news_category` int(11) NOT NULL,
  `news_image` varchar(255) NOT NULL,
  `news_views` int(11) NOT NULL,
  `notes` longtext NOT NULL,
  `submitter` int(11) NOT NULL,
  `title` int(10) unsigned NOT NULL,
  `validated` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `headlines` (`date_and_time`)
) ENGINE=MyISAM  AUTO_INCREMENT=3 ;

--
-- Dumping data for table `ocp_news`
--

INSERT INTO `ocp_news` (`allow_comments`, `allow_rating`, `allow_trackbacks`, `author`, `date_and_time`, `edit_date`, `id`, `news`, `news_article`, `news_category`, `news_image`, `news_views`, `notes`, `submitter`, `title`, `validated`) VALUES(1, 1, 1, 'admin', 1264683674, NULL, 1, 715, 716, 1, '', 3, '', 2, 714, 1);
INSERT INTO `ocp_news` (`allow_comments`, `allow_rating`, `allow_trackbacks`, `author`, `date_and_time`, `edit_date`, `id`, `news`, `news_article`, `news_category`, `news_image`, `news_views`, `notes`, `submitter`, `title`, `validated`) VALUES(1, 1, 1, 'admin', 1264683761, NULL, 2, 721, 722, 1, '', 0, '', 2, 720, 1);

-- --------------------------------------------------------

--
-- Table structure for table `ocp_newsletter`
--

DROP TABLE IF EXISTS `ocp_newsletter`;
CREATE TABLE IF NOT EXISTS `ocp_newsletter` (
  `code_confirm` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `join_time` int(10) unsigned NOT NULL,
  `language` varchar(80) NOT NULL,
  `n_forename` varchar(255) NOT NULL,
  `n_surname` varchar(255) NOT NULL,
  `pass_salt` varchar(80) NOT NULL,
  `the_password` varchar(33) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 ;

--
-- Dumping data for table `ocp_newsletter`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_newsletters`
--

DROP TABLE IF EXISTS `ocp_newsletters`;
CREATE TABLE IF NOT EXISTS `ocp_newsletters` (
  `description` int(10) unsigned NOT NULL,
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  AUTO_INCREMENT=2 ;

--
-- Dumping data for table `ocp_newsletters`
--

INSERT INTO `ocp_newsletters` (`description`, `id`, `title`) VALUES(344, 1, 343);

-- --------------------------------------------------------

--
-- Table structure for table `ocp_newsletter_archive`
--

DROP TABLE IF EXISTS `ocp_newsletter_archive`;
CREATE TABLE IF NOT EXISTS `ocp_newsletter_archive` (
  `date_and_time` int(11) NOT NULL,
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `importance_level` int(11) NOT NULL,
  `language` varchar(80) NOT NULL,
  `newsletter` longtext NOT NULL,
  `subject` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 ;

--
-- Dumping data for table `ocp_newsletter_archive`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_newsletter_drip_send`
--

DROP TABLE IF EXISTS `ocp_newsletter_drip_send`;
CREATE TABLE IF NOT EXISTS `ocp_newsletter_drip_send` (
  `d_from_email` varchar(255) NOT NULL,
  `d_from_name` varchar(255) NOT NULL,
  `d_html_only` tinyint(1) NOT NULL,
  `d_inject_time` int(10) unsigned NOT NULL,
  `d_message` longtext NOT NULL,
  `d_priority` tinyint(4) NOT NULL,
  `d_subject` varchar(255) NOT NULL,
  `d_to_email` varchar(255) NOT NULL,
  `d_to_name` varchar(255) NOT NULL,
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `d_inject_time` (`d_inject_time`)
) ENGINE=MyISAM AUTO_INCREMENT=1 ;

--
-- Dumping data for table `ocp_newsletter_drip_send`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_newsletter_subscribe`
--

DROP TABLE IF EXISTS `ocp_newsletter_subscribe`;
CREATE TABLE IF NOT EXISTS `ocp_newsletter_subscribe` (
  `email` varchar(255) NOT NULL,
  `newsletter_id` int(11) NOT NULL,
  `the_level` tinyint(4) NOT NULL,
  PRIMARY KEY (`email`,`newsletter_id`)
) ENGINE=MyISAM;

--
-- Dumping data for table `ocp_newsletter_subscribe`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_news_categories`
--

DROP TABLE IF EXISTS `ocp_news_categories`;
CREATE TABLE IF NOT EXISTS `ocp_news_categories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nc_img` varchar(80) NOT NULL,
  `nc_owner` int(11) DEFAULT NULL,
  `nc_title` int(10) unsigned NOT NULL,
  `notes` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  AUTO_INCREMENT=8 ;

--
-- Dumping data for table `ocp_news_categories`
--

INSERT INTO `ocp_news_categories` (`id`, `nc_img`, `nc_owner`, `nc_title`, `notes`) VALUES(1, 'newscats/general', NULL, 330, '');
INSERT INTO `ocp_news_categories` (`id`, `nc_img`, `nc_owner`, `nc_title`, `notes`) VALUES(2, 'newscats/technology', NULL, 331, '');
INSERT INTO `ocp_news_categories` (`id`, `nc_img`, `nc_owner`, `nc_title`, `notes`) VALUES(3, 'newscats/difficulties', NULL, 332, '');
INSERT INTO `ocp_news_categories` (`id`, `nc_img`, `nc_owner`, `nc_title`, `notes`) VALUES(4, 'newscats/community', NULL, 333, '');
INSERT INTO `ocp_news_categories` (`id`, `nc_img`, `nc_owner`, `nc_title`, `notes`) VALUES(5, 'newscats/entertainment', NULL, 334, '');
INSERT INTO `ocp_news_categories` (`id`, `nc_img`, `nc_owner`, `nc_title`, `notes`) VALUES(6, 'newscats/business', NULL, 335, '');
INSERT INTO `ocp_news_categories` (`id`, `nc_img`, `nc_owner`, `nc_title`, `notes`) VALUES(7, 'newscats/art', NULL, 336, '');

-- --------------------------------------------------------

--
-- Table structure for table `ocp_news_category_entries`
--

DROP TABLE IF EXISTS `ocp_news_category_entries`;
CREATE TABLE IF NOT EXISTS `ocp_news_category_entries` (
  `news_entry` int(11) NOT NULL,
  `news_entry_category` int(11) NOT NULL,
  PRIMARY KEY (`news_entry`,`news_entry_category`)
) ENGINE=MyISAM;

--
-- Dumping data for table `ocp_news_category_entries`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_news_rss_cloud`
--

DROP TABLE IF EXISTS `ocp_news_rss_cloud`;
CREATE TABLE IF NOT EXISTS `ocp_news_rss_cloud` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `register_time` int(10) unsigned NOT NULL,
  `rem_ip` varchar(40) NOT NULL,
  `rem_path` varchar(255) NOT NULL,
  `rem_port` tinyint(4) NOT NULL,
  `rem_procedure` varchar(80) NOT NULL,
  `rem_protocol` varchar(80) NOT NULL,
  `watching_channel` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 ;

--
-- Dumping data for table `ocp_news_rss_cloud`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_occlechat`
--

DROP TABLE IF EXISTS `ocp_occlechat`;
CREATE TABLE IF NOT EXISTS `ocp_occlechat` (
  `c_incoming` tinyint(1) NOT NULL,
  `c_message` longtext NOT NULL,
  `c_timestamp` int(10) unsigned NOT NULL,
  `c_url` varchar(255) NOT NULL,
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 ;

--
-- Dumping data for table `ocp_occlechat`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_poll`
--

DROP TABLE IF EXISTS `ocp_poll`;
CREATE TABLE IF NOT EXISTS `ocp_poll` (
  `add_time` int(11) NOT NULL,
  `allow_comments` tinyint(4) NOT NULL,
  `allow_rating` tinyint(1) NOT NULL,
  `allow_trackbacks` tinyint(1) NOT NULL,
  `date_and_time` int(10) unsigned DEFAULT NULL,
  `edit_date` int(10) unsigned DEFAULT NULL,
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ip` longtext NOT NULL,
  `is_current` tinyint(1) NOT NULL,
  `notes` longtext NOT NULL,
  `num_options` tinyint(4) NOT NULL,
  `option1` int(10) unsigned NOT NULL,
  `option10` int(10) unsigned DEFAULT NULL,
  `option2` int(10) unsigned NOT NULL,
  `option3` int(10) unsigned DEFAULT NULL,
  `option4` int(10) unsigned DEFAULT NULL,
  `option5` int(10) unsigned DEFAULT NULL,
  `option6` int(10) unsigned NOT NULL,
  `option7` int(10) unsigned NOT NULL,
  `option8` int(10) unsigned DEFAULT NULL,
  `option9` int(10) unsigned DEFAULT NULL,
  `poll_views` int(11) NOT NULL,
  `question` int(10) unsigned NOT NULL,
  `submitter` int(11) NOT NULL,
  `votes1` int(11) NOT NULL,
  `votes10` int(11) NOT NULL,
  `votes2` int(11) NOT NULL,
  `votes3` int(11) NOT NULL,
  `votes4` int(11) NOT NULL,
  `votes5` int(11) NOT NULL,
  `votes6` int(11) NOT NULL,
  `votes7` int(11) NOT NULL,
  `votes8` int(11) NOT NULL,
  `votes9` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `get_current` (`is_current`)
) ENGINE=MyISAM  AUTO_INCREMENT=2 ;

--
-- Dumping data for table `ocp_poll`
--

INSERT INTO `ocp_poll` (`add_time`, `allow_comments`, `allow_rating`, `allow_trackbacks`, `date_and_time`, `edit_date`, `id`, `ip`, `is_current`, `notes`, `num_options`, `option1`, `option10`, `option2`, `option3`, `option4`, `option5`, `option6`, `option7`, `option8`, `option9`, `poll_views`, `question`, `submitter`, `votes1`, `votes10`, `votes2`, `votes3`, `votes4`, `votes5`, `votes6`, `votes7`, `votes8`, `votes9`) VALUES(1264607625, 1, 1, 1, 1264607625, 1264607713, 1, '', 1, '', 4, 485, 494, 486, 487, 488, 489, 490, 491, 492, 493, 7, 484, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `ocp_prices`
--

DROP TABLE IF EXISTS `ocp_prices`;
CREATE TABLE IF NOT EXISTS `ocp_prices` (
  `name` varchar(80) NOT NULL,
  `price` int(11) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=MyISAM;

--
-- Dumping data for table `ocp_prices`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_pstore_customs`
--

DROP TABLE IF EXISTS `ocp_pstore_customs`;
CREATE TABLE IF NOT EXISTS `ocp_pstore_customs` (
  `c_cost` int(11) NOT NULL,
  `c_description` int(10) unsigned NOT NULL,
  `c_enabled` tinyint(1) NOT NULL,
  `c_one_per_member` tinyint(1) NOT NULL,
  `c_title` int(10) unsigned NOT NULL,
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 ;

--
-- Dumping data for table `ocp_pstore_customs`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_pstore_permissions`
--

DROP TABLE IF EXISTS `ocp_pstore_permissions`;
CREATE TABLE IF NOT EXISTS `ocp_pstore_permissions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `p_category` varchar(80) NOT NULL,
  `p_cost` int(11) NOT NULL,
  `p_description` int(10) unsigned NOT NULL,
  `p_enabled` tinyint(1) NOT NULL,
  `p_hours` int(11) NOT NULL,
  `p_module` varchar(80) NOT NULL,
  `p_page` varchar(80) NOT NULL,
  `p_specific_permission` varchar(80) NOT NULL,
  `p_title` int(10) unsigned NOT NULL,
  `p_type` varchar(80) NOT NULL,
  `p_zone` varchar(80) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 ;

--
-- Dumping data for table `ocp_pstore_permissions`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_quizzes`
--

DROP TABLE IF EXISTS `ocp_quizzes`;
CREATE TABLE IF NOT EXISTS `ocp_quizzes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `q_add_date` int(10) unsigned NOT NULL,
  `q_close_time` int(10) unsigned DEFAULT NULL,
  `q_end_text` int(10) unsigned NOT NULL,
  `q_name` int(10) unsigned NOT NULL,
  `q_notes` longtext NOT NULL,
  `q_num_winners` int(11) NOT NULL,
  `q_open_time` int(10) unsigned NOT NULL,
  `q_percentage` int(11) NOT NULL,
  `q_points_for_passing` int(11) NOT NULL,
  `q_redo_time` int(11) DEFAULT NULL,
  `q_start_text` int(10) unsigned NOT NULL,
  `q_submitter` int(11) NOT NULL,
  `q_tied_newsletter` int(11) DEFAULT NULL,
  `q_timeout` int(11) DEFAULT NULL,
  `q_type` varchar(80) NOT NULL,
  `q_validated` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  AUTO_INCREMENT=2 ;

--
-- Dumping data for table `ocp_quizzes`
--

INSERT INTO `ocp_quizzes` (`id`, `q_add_date`, `q_close_time`, `q_end_text`, `q_name`, `q_notes`, `q_num_winners`, `q_open_time`, `q_percentage`, `q_points_for_passing`, `q_redo_time`, `q_start_text`, `q_submitter`, `q_tied_newsletter`, `q_timeout`, `q_type`, `q_validated`) VALUES(1, 1264684716, NULL, 728, 726, '', 0, 1264683780, 70, 500, 96, 727, 2, NULL, NULL, 'TEST', 1);

-- --------------------------------------------------------

--
-- Table structure for table `ocp_quiz_entries`
--

DROP TABLE IF EXISTS `ocp_quiz_entries`;
CREATE TABLE IF NOT EXISTS `ocp_quiz_entries` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `q_member` int(11) NOT NULL,
  `q_quiz` int(11) NOT NULL,
  `q_results` int(11) NOT NULL,
  `q_time` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 ;

--
-- Dumping data for table `ocp_quiz_entries`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_quiz_entry_answer`
--

DROP TABLE IF EXISTS `ocp_quiz_entry_answer`;
CREATE TABLE IF NOT EXISTS `ocp_quiz_entry_answer` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `q_answer` longtext NOT NULL,
  `q_entry` int(11) NOT NULL,
  `q_question` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 ;

--
-- Dumping data for table `ocp_quiz_entry_answer`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_quiz_member_last_visit`
--

DROP TABLE IF EXISTS `ocp_quiz_member_last_visit`;
CREATE TABLE IF NOT EXISTS `ocp_quiz_member_last_visit` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `v_member_id` int(11) NOT NULL,
  `v_time` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  AUTO_INCREMENT=2 ;

--
-- Dumping data for table `ocp_quiz_member_last_visit`
--

INSERT INTO `ocp_quiz_member_last_visit` (`id`, `v_member_id`, `v_time`) VALUES(1, 2, 1264684721);

-- --------------------------------------------------------

--
-- Table structure for table `ocp_quiz_questions`
--

DROP TABLE IF EXISTS `ocp_quiz_questions`;
CREATE TABLE IF NOT EXISTS `ocp_quiz_questions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `q_long_input_field` tinyint(1) NOT NULL,
  `q_num_choosable_answers` int(11) NOT NULL,
  `q_question_text` int(10) unsigned NOT NULL,
  `q_quiz` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  AUTO_INCREMENT=6 ;

--
-- Dumping data for table `ocp_quiz_questions`
--

INSERT INTO `ocp_quiz_questions` (`id`, `q_long_input_field`, `q_num_choosable_answers`, `q_question_text`, `q_quiz`) VALUES(1, 0, 1, 729, 1);
INSERT INTO `ocp_quiz_questions` (`id`, `q_long_input_field`, `q_num_choosable_answers`, `q_question_text`, `q_quiz`) VALUES(2, 0, 1, 732, 1);
INSERT INTO `ocp_quiz_questions` (`id`, `q_long_input_field`, `q_num_choosable_answers`, `q_question_text`, `q_quiz`) VALUES(3, 0, 1, 736, 1);
INSERT INTO `ocp_quiz_questions` (`id`, `q_long_input_field`, `q_num_choosable_answers`, `q_question_text`, `q_quiz`) VALUES(4, 0, 1, 740, 1);
INSERT INTO `ocp_quiz_questions` (`id`, `q_long_input_field`, `q_num_choosable_answers`, `q_question_text`, `q_quiz`) VALUES(5, 0, 1, 744, 1);

-- --------------------------------------------------------

--
-- Table structure for table `ocp_quiz_question_answers`
--

DROP TABLE IF EXISTS `ocp_quiz_question_answers`;
CREATE TABLE IF NOT EXISTS `ocp_quiz_question_answers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `q_answer_text` int(10) unsigned NOT NULL,
  `q_is_correct` tinyint(1) NOT NULL,
  `q_question` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  AUTO_INCREMENT=15 ;

--
-- Dumping data for table `ocp_quiz_question_answers`
--

INSERT INTO `ocp_quiz_question_answers` (`id`, `q_answer_text`, `q_is_correct`, `q_question`) VALUES(1, 730, 0, 1);
INSERT INTO `ocp_quiz_question_answers` (`id`, `q_answer_text`, `q_is_correct`, `q_question`) VALUES(2, 731, 1, 1);
INSERT INTO `ocp_quiz_question_answers` (`id`, `q_answer_text`, `q_is_correct`, `q_question`) VALUES(3, 733, 0, 2);
INSERT INTO `ocp_quiz_question_answers` (`id`, `q_answer_text`, `q_is_correct`, `q_question`) VALUES(4, 734, 1, 2);
INSERT INTO `ocp_quiz_question_answers` (`id`, `q_answer_text`, `q_is_correct`, `q_question`) VALUES(5, 735, 0, 2);
INSERT INTO `ocp_quiz_question_answers` (`id`, `q_answer_text`, `q_is_correct`, `q_question`) VALUES(6, 737, 1, 3);
INSERT INTO `ocp_quiz_question_answers` (`id`, `q_answer_text`, `q_is_correct`, `q_question`) VALUES(7, 738, 0, 3);
INSERT INTO `ocp_quiz_question_answers` (`id`, `q_answer_text`, `q_is_correct`, `q_question`) VALUES(8, 739, 0, 3);
INSERT INTO `ocp_quiz_question_answers` (`id`, `q_answer_text`, `q_is_correct`, `q_question`) VALUES(9, 741, 0, 4);
INSERT INTO `ocp_quiz_question_answers` (`id`, `q_answer_text`, `q_is_correct`, `q_question`) VALUES(10, 742, 1, 4);
INSERT INTO `ocp_quiz_question_answers` (`id`, `q_answer_text`, `q_is_correct`, `q_question`) VALUES(11, 743, 0, 4);
INSERT INTO `ocp_quiz_question_answers` (`id`, `q_answer_text`, `q_is_correct`, `q_question`) VALUES(12, 745, 0, 5);
INSERT INTO `ocp_quiz_question_answers` (`id`, `q_answer_text`, `q_is_correct`, `q_question`) VALUES(13, 746, 1, 5);
INSERT INTO `ocp_quiz_question_answers` (`id`, `q_answer_text`, `q_is_correct`, `q_question`) VALUES(14, 747, 0, 5);

-- --------------------------------------------------------

--
-- Table structure for table `ocp_quiz_winner`
--

DROP TABLE IF EXISTS `ocp_quiz_winner`;
CREATE TABLE IF NOT EXISTS `ocp_quiz_winner` (
  `q_entry` int(11) NOT NULL,
  `q_quiz` int(11) NOT NULL,
  `q_winner_level` int(11) NOT NULL,
  PRIMARY KEY (`q_entry`,`q_quiz`)
) ENGINE=MyISAM;

--
-- Dumping data for table `ocp_quiz_winner`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_rating`
--

DROP TABLE IF EXISTS `ocp_rating`;
CREATE TABLE IF NOT EXISTS `ocp_rating` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `rating` tinyint(4) NOT NULL,
  `rating_for_id` varchar(80) NOT NULL,
  `rating_for_type` varchar(80) NOT NULL,
  `rating_ip` varchar(40) NOT NULL,
  `rating_member` int(11) NOT NULL,
  `rating_time` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `alt_key` (`rating_for_type`,`rating_for_id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 ;

--
-- Dumping data for table `ocp_rating`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_redirects`
--

DROP TABLE IF EXISTS `ocp_redirects`;
CREATE TABLE IF NOT EXISTS `ocp_redirects` (
  `r_from_page` varchar(80) NOT NULL,
  `r_from_zone` varchar(80) NOT NULL,
  `r_is_transparent` tinyint(1) NOT NULL,
  `r_to_page` varchar(80) NOT NULL,
  `r_to_zone` varchar(80) NOT NULL,
  PRIMARY KEY (`r_from_page`,`r_from_zone`)
) ENGINE=MyISAM;

--
-- Dumping data for table `ocp_redirects`
--

INSERT INTO `ocp_redirects` (`r_from_page`, `r_from_zone`, `r_is_transparent`, `r_to_page`, `r_to_zone`) VALUES('rules', 'site', 1, 'rules', '');
INSERT INTO `ocp_redirects` (`r_from_page`, `r_from_zone`, `r_is_transparent`, `r_to_page`, `r_to_zone`) VALUES('rules', 'forum', 1, 'rules', '');
INSERT INTO `ocp_redirects` (`r_from_page`, `r_from_zone`, `r_is_transparent`, `r_to_page`, `r_to_zone`) VALUES('hosting-submit', 'collaboration', 1, 'hosting-submit', 'site');
INSERT INTO `ocp_redirects` (`r_from_page`, `r_from_zone`, `r_is_transparent`, `r_to_page`, `r_to_zone`) VALUES('authors', 'collaboration', 1, 'authors', 'site');
INSERT INTO `ocp_redirects` (`r_from_page`, `r_from_zone`, `r_is_transparent`, `r_to_page`, `r_to_zone`) VALUES('panel_top', 'collaboration', 1, 'panel_top', '');
INSERT INTO `ocp_redirects` (`r_from_page`, `r_from_zone`, `r_is_transparent`, `r_to_page`, `r_to_zone`) VALUES('panel_top', 'forum', 1, 'panel_top', '');
INSERT INTO `ocp_redirects` (`r_from_page`, `r_from_zone`, `r_is_transparent`, `r_to_page`, `r_to_zone`) VALUES('panel_top', 'personalzone', 1, 'panel_top', '');
INSERT INTO `ocp_redirects` (`r_from_page`, `r_from_zone`, `r_is_transparent`, `r_to_page`, `r_to_zone`) VALUES('panel_top', 'site', 1, 'panel_top', '');
INSERT INTO `ocp_redirects` (`r_from_page`, `r_from_zone`, `r_is_transparent`, `r_to_page`, `r_to_zone`) VALUES('invoices', 'personalzone', 1, 'invoices', 'site');
INSERT INTO `ocp_redirects` (`r_from_page`, `r_from_zone`, `r_is_transparent`, `r_to_page`, `r_to_zone`) VALUES('newsletter', 'personalzone', 1, 'newsletter', 'site');
INSERT INTO `ocp_redirects` (`r_from_page`, `r_from_zone`, `r_is_transparent`, `r_to_page`, `r_to_zone`) VALUES('subscriptions', 'personalzone', 1, 'subscriptions', 'site');

-- --------------------------------------------------------

--
-- Table structure for table `ocp_review_supplement`
--

DROP TABLE IF EXISTS `ocp_review_supplement`;
CREATE TABLE IF NOT EXISTS `ocp_review_supplement` (
  `r_post_id` int(11) NOT NULL,
  `r_rating` tinyint(4) NOT NULL,
  `r_rating_for_id` varchar(80) NOT NULL,
  `r_rating_for_type` varchar(80) NOT NULL,
  `r_rating_type` varchar(80) NOT NULL,
  `r_topic_id` int(11) NOT NULL,
  PRIMARY KEY (`r_post_id`,`r_rating_type`),
  KEY `rating_for_id` (`r_rating_for_id`)
) ENGINE=MyISAM;

--
-- Dumping data for table `ocp_review_supplement`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_sales`
--

DROP TABLE IF EXISTS `ocp_sales`;
CREATE TABLE IF NOT EXISTS `ocp_sales` (
  `date_and_time` int(10) unsigned NOT NULL,
  `details` varchar(255) NOT NULL,
  `details2` varchar(255) NOT NULL,
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `memberid` int(11) NOT NULL,
  `purchasetype` varchar(80) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  AUTO_INCREMENT=2 ;

--
-- Dumping data for table `ocp_sales`
--

INSERT INTO `ocp_sales` (`date_and_time`, `details`, `details2`, `id`, `memberid`, `purchasetype`) VALUES(1264685916, '6', '', 1, 2, 'GAMBLING');

-- --------------------------------------------------------

--
-- Table structure for table `ocp_searches_logged`
--

DROP TABLE IF EXISTS `ocp_searches_logged`;
CREATE TABLE IF NOT EXISTS `ocp_searches_logged` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `s_auxillary` longtext NOT NULL,
  `s_member_id` int(11) NOT NULL,
  `s_num_results` int(11) NOT NULL,
  `s_primary` varchar(255) NOT NULL,
  `s_time` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `past_search` (`s_primary`)
) ENGINE=MyISAM AUTO_INCREMENT=1 ;

--
-- Dumping data for table `ocp_searches_logged`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_searches_saved`
--

DROP TABLE IF EXISTS `ocp_searches_saved`;
CREATE TABLE IF NOT EXISTS `ocp_searches_saved` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `s_auxillary` longtext NOT NULL,
  `s_member_id` int(11) NOT NULL,
  `s_primary` varchar(255) NOT NULL,
  `s_time` int(10) unsigned NOT NULL,
  `s_title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 ;

--
-- Dumping data for table `ocp_searches_saved`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_security_images`
--

DROP TABLE IF EXISTS `ocp_security_images`;
CREATE TABLE IF NOT EXISTS `ocp_security_images` (
  `si_code` int(11) NOT NULL,
  `si_session_id` int(11) NOT NULL,
  `si_time` int(10) unsigned NOT NULL,
  PRIMARY KEY (`si_session_id`)
) ENGINE=MyISAM;

--
-- Dumping data for table `ocp_security_images`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_seedy_changes`
--

DROP TABLE IF EXISTS `ocp_seedy_changes`;
CREATE TABLE IF NOT EXISTS `ocp_seedy_changes` (
  `date_and_time` int(10) unsigned NOT NULL,
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ip` varchar(40) NOT NULL,
  `the_action` varchar(80) NOT NULL,
  `the_page` int(11) NOT NULL,
  `the_user` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  AUTO_INCREMENT=10 ;

--
-- Dumping data for table `ocp_seedy_changes`
--

INSERT INTO `ocp_seedy_changes` (`date_and_time`, `id`, `ip`, `the_action`, `the_page`, `the_user`) VALUES(1264681761, 1, '90.152.0.114', 'CEDI_ADD_PAGE', 2, 2);
INSERT INTO `ocp_seedy_changes` (`date_and_time`, `id`, `ip`, `the_action`, `the_page`, `the_user`) VALUES(1264681761, 2, '90.152.0.114', 'CEDI_EDIT_TREE', 1, 2);
INSERT INTO `ocp_seedy_changes` (`date_and_time`, `id`, `ip`, `the_action`, `the_page`, `the_user`) VALUES(1264681798, 3, '90.152.0.114', 'CEDI_ADD_PAGE', 3, 2);
INSERT INTO `ocp_seedy_changes` (`date_and_time`, `id`, `ip`, `the_action`, `the_page`, `the_user`) VALUES(1264681798, 4, '90.152.0.114', 'CEDI_ADD_PAGE', 4, 2);
INSERT INTO `ocp_seedy_changes` (`date_and_time`, `id`, `ip`, `the_action`, `the_page`, `the_user`) VALUES(1264681798, 5, '90.152.0.114', 'CEDI_EDIT_TREE', 2, 2);
INSERT INTO `ocp_seedy_changes` (`date_and_time`, `id`, `ip`, `the_action`, `the_page`, `the_user`) VALUES(1264682251, 6, '90.152.0.114', 'CEDI_EDIT_PAGE', 4, 2);
INSERT INTO `ocp_seedy_changes` (`date_and_time`, `id`, `ip`, `the_action`, `the_page`, `the_user`) VALUES(1264682350, 7, '90.152.0.114', 'CEDI_MAKE_POST', 4, 2);
INSERT INTO `ocp_seedy_changes` (`date_and_time`, `id`, `ip`, `the_action`, `the_page`, `the_user`) VALUES(1264682414, 8, '90.152.0.114', 'CEDI_EDIT_PAGE', 3, 2);
INSERT INTO `ocp_seedy_changes` (`date_and_time`, `id`, `ip`, `the_action`, `the_page`, `the_user`) VALUES(1264682523, 9, '90.152.0.114', 'CEDI_MAKE_POST', 3, 2);

-- --------------------------------------------------------

--
-- Table structure for table `ocp_seedy_children`
--

DROP TABLE IF EXISTS `ocp_seedy_children`;
CREATE TABLE IF NOT EXISTS `ocp_seedy_children` (
  `child_id` int(11) NOT NULL,
  `parent_id` int(11) NOT NULL,
  `the_order` tinyint(4) NOT NULL,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`child_id`,`parent_id`)
) ENGINE=MyISAM;

--
-- Dumping data for table `ocp_seedy_children`
--

INSERT INTO `ocp_seedy_children` (`child_id`, `parent_id`, `the_order`, `title`) VALUES(2, 1, 0, 'Works by Shakespeare');
INSERT INTO `ocp_seedy_children` (`child_id`, `parent_id`, `the_order`, `title`) VALUES(3, 2, 0, 'Hamlet');
INSERT INTO `ocp_seedy_children` (`child_id`, `parent_id`, `the_order`, `title`) VALUES(4, 2, 1, 'Romeo and Juliet');

-- --------------------------------------------------------

--
-- Table structure for table `ocp_seedy_pages`
--

DROP TABLE IF EXISTS `ocp_seedy_pages`;
CREATE TABLE IF NOT EXISTS `ocp_seedy_pages` (
  `add_date` int(10) unsigned NOT NULL,
  `description` int(10) unsigned NOT NULL,
  `hide_posts` tinyint(1) NOT NULL,
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `notes` longtext NOT NULL,
  `seedy_views` int(11) NOT NULL,
  `submitter` int(11) NOT NULL,
  `title` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  AUTO_INCREMENT=5 ;

--
-- Dumping data for table `ocp_seedy_pages`
--

INSERT INTO `ocp_seedy_pages` (`add_date`, `description`, `hide_posts`, `id`, `notes`, `seedy_views`, `submitter`, `title`) VALUES(1264606827, 301, 0, 1, '', 2, 1, 300);
INSERT INTO `ocp_seedy_pages` (`add_date`, `description`, `hide_posts`, `id`, `notes`, `seedy_views`, `submitter`, `title`) VALUES(1264681761, 693, 0, 2, '', 3, 2, 692);
INSERT INTO `ocp_seedy_pages` (`add_date`, `description`, `hide_posts`, `id`, `notes`, `seedy_views`, `submitter`, `title`) VALUES(1264681798, 697, 0, 3, '', 3, 2, 696);
INSERT INTO `ocp_seedy_pages` (`add_date`, `description`, `hide_posts`, `id`, `notes`, `seedy_views`, `submitter`, `title`) VALUES(1264681798, 701, 0, 4, '', 3, 2, 700);

-- --------------------------------------------------------

--
-- Table structure for table `ocp_seedy_posts`
--

DROP TABLE IF EXISTS `ocp_seedy_posts`;
CREATE TABLE IF NOT EXISTS `ocp_seedy_posts` (
  `date_and_time` int(10) unsigned NOT NULL,
  `edit_date` int(10) unsigned DEFAULT NULL,
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `page_id` int(11) NOT NULL,
  `seedy_views` int(11) NOT NULL,
  `the_message` int(10) unsigned NOT NULL,
  `the_user` int(11) NOT NULL,
  `validated` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `posts_on_page` (`page_id`)
) ENGINE=MyISAM  AUTO_INCREMENT=3 ;

--
-- Dumping data for table `ocp_seedy_posts`
--

INSERT INTO `ocp_seedy_posts` (`date_and_time`, `edit_date`, `id`, `page_id`, `seedy_views`, `the_message`, `the_user`, `validated`) VALUES(1264682350, NULL, 1, 4, 0, 706, 2, 1);
INSERT INTO `ocp_seedy_posts` (`date_and_time`, `edit_date`, `id`, `page_id`, `seedy_views`, `the_message`, `the_user`, `validated`) VALUES(1264682523, NULL, 2, 3, 0, 709, 2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `ocp_seo_meta`
--

DROP TABLE IF EXISTS `ocp_seo_meta`;
CREATE TABLE IF NOT EXISTS `ocp_seo_meta` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `meta_description` int(10) unsigned NOT NULL,
  `meta_for_id` varchar(80) NOT NULL,
  `meta_for_type` varchar(80) NOT NULL,
  `meta_keywords` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `alt_key` (`meta_for_type`,`meta_for_id`)
) ENGINE=MyISAM  AUTO_INCREMENT=55 ;

--
-- Dumping data for table `ocp_seo_meta`
--

INSERT INTO `ocp_seo_meta` (`id`, `meta_description`, `meta_for_id`, `meta_for_type`, `meta_keywords`) VALUES(1, 329, 'root', 'gallery', 328);
INSERT INTO `ocp_seo_meta` (`id`, `meta_description`, `meta_for_id`, `meta_for_type`, `meta_keywords`) VALUES(3, 586, 'site:banner', 'comcode_page', 585);
INSERT INTO `ocp_seo_meta` (`id`, `meta_description`, `meta_for_id`, `meta_for_type`, `meta_keywords`) VALUES(48, 917, ':start', 'comcode_page', 916);
INSERT INTO `ocp_seo_meta` (`id`, `meta_description`, `meta_for_id`, `meta_for_type`, `meta_keywords`) VALUES(49, 953, 'site:featured_content', 'comcode_page', 952);
INSERT INTO `ocp_seo_meta` (`id`, `meta_description`, `meta_for_id`, `meta_for_type`, `meta_keywords`) VALUES(10, 613, '2', 'downloads_category', 612);
INSERT INTO `ocp_seo_meta` (`id`, `meta_description`, `meta_for_id`, `meta_for_type`, `meta_keywords`) VALUES(8, 609, '3', 'downloads_category', 608);
INSERT INTO `ocp_seo_meta` (`id`, `meta_description`, `meta_for_id`, `meta_for_type`, `meta_keywords`) VALUES(44, 787, '1', 'downloads_download', 786);
INSERT INTO `ocp_seo_meta` (`id`, `meta_description`, `meta_for_id`, `meta_for_type`, `meta_keywords`) VALUES(12, 623, 'download_1', 'gallery', 622);
INSERT INTO `ocp_seo_meta` (`id`, `meta_description`, `meta_for_id`, `meta_for_type`, `meta_keywords`) VALUES(17, 661, '1', 'catalogue_entry', 660);
INSERT INTO `ocp_seo_meta` (`id`, `meta_description`, `meta_for_id`, `meta_for_type`, `meta_keywords`) VALUES(18, 665, '2', 'catalogue_entry', 664);
INSERT INTO `ocp_seo_meta` (`id`, `meta_description`, `meta_for_id`, `meta_for_type`, `meta_keywords`) VALUES(21, 673, '3', 'catalogue_entry', 672);
INSERT INTO `ocp_seo_meta` (`id`, `meta_description`, `meta_for_id`, `meta_for_type`, `meta_keywords`) VALUES(20, 671, '4', 'catalogue_entry', 670);
INSERT INTO `ocp_seo_meta` (`id`, `meta_description`, `meta_for_id`, `meta_for_type`, `meta_keywords`) VALUES(25, 687, '5', 'catalogue_entry', 686);
INSERT INTO `ocp_seo_meta` (`id`, `meta_description`, `meta_for_id`, `meta_for_type`, `meta_keywords`) VALUES(26, 689, '6', 'catalogue_entry', 688);
INSERT INTO `ocp_seo_meta` (`id`, `meta_description`, `meta_for_id`, `meta_for_type`, `meta_keywords`) VALUES(27, 691, '7', 'catalogue_entry', 690);
INSERT INTO `ocp_seo_meta` (`id`, `meta_description`, `meta_for_id`, `meta_for_type`, `meta_keywords`) VALUES(28, 695, '2', 'seedy_page', 694);
INSERT INTO `ocp_seo_meta` (`id`, `meta_description`, `meta_for_id`, `meta_for_type`, `meta_keywords`) VALUES(32, 708, '3', 'seedy_page', 707);
INSERT INTO `ocp_seo_meta` (`id`, `meta_description`, `meta_for_id`, `meta_for_type`, `meta_keywords`) VALUES(31, 705, '4', 'seedy_page', 704);
INSERT INTO `ocp_seo_meta` (`id`, `meta_description`, `meta_for_id`, `meta_for_type`, `meta_keywords`) VALUES(33, 713, '1', 'event', 712);
INSERT INTO `ocp_seo_meta` (`id`, `meta_description`, `meta_for_id`, `meta_for_type`, `meta_keywords`) VALUES(34, 718, '1', 'news', 717);
INSERT INTO `ocp_seo_meta` (`id`, `meta_description`, `meta_for_id`, `meta_for_type`, `meta_keywords`) VALUES(35, 724, '2', 'news', 723);
INSERT INTO `ocp_seo_meta` (`id`, `meta_description`, `meta_for_id`, `meta_for_type`, `meta_keywords`) VALUES(36, 749, '1', 'quiz', 748);
INSERT INTO `ocp_seo_meta` (`id`, `meta_description`, `meta_for_id`, `meta_for_type`, `meta_keywords`) VALUES(37, 755, 'randj', 'gallery', 754);
INSERT INTO `ocp_seo_meta` (`id`, `meta_description`, `meta_for_id`, `meta_for_type`, `meta_keywords`) VALUES(38, 758, '1', 'image', 757);
INSERT INTO `ocp_seo_meta` (`id`, `meta_description`, `meta_for_id`, `meta_for_type`, `meta_keywords`) VALUES(39, 762, '2', 'image', 761);
INSERT INTO `ocp_seo_meta` (`id`, `meta_description`, `meta_for_id`, `meta_for_type`, `meta_keywords`) VALUES(40, 768, '2', 'downloads_download', 767);
INSERT INTO `ocp_seo_meta` (`id`, `meta_description`, `meta_for_id`, `meta_for_type`, `meta_keywords`) VALUES(41, 773, 'download_2', 'gallery', 772);
INSERT INTO `ocp_seo_meta` (`id`, `meta_description`, `meta_for_id`, `meta_for_type`, `meta_keywords`) VALUES(42, 777, 'site:comcode_page', 'comcode_page', 776);
INSERT INTO `ocp_seo_meta` (`id`, `meta_description`, `meta_for_id`, `meta_for_type`, `meta_keywords`) VALUES(43, 782, 'site:comcode_page_child', 'comcode_page', 781);
INSERT INTO `ocp_seo_meta` (`id`, `meta_description`, `meta_for_id`, `meta_for_type`, `meta_keywords`) VALUES(54, 1020, ':rich', 'comcode_page', 1019);
INSERT INTO `ocp_seo_meta` (`id`, `meta_description`, `meta_for_id`, `meta_for_type`, `meta_keywords`) VALUES(52, 992, ':menus', 'comcode_page', 991);

-- --------------------------------------------------------

--
-- Table structure for table `ocp_sessions`
--

DROP TABLE IF EXISTS `ocp_sessions`;
CREATE TABLE IF NOT EXISTS `ocp_sessions` (
  `cache_username` varchar(255) NOT NULL,
  `ip` varchar(40) NOT NULL,
  `last_activity` int(10) unsigned NOT NULL,
  `session_confirmed` tinyint(1) NOT NULL,
  `session_invisible` tinyint(1) NOT NULL,
  `the_id` varchar(80) NOT NULL,
  `the_page` varchar(80) NOT NULL,
  `the_session` int(11) NOT NULL,
  `the_title` varchar(255) NOT NULL,
  `the_type` varchar(80) NOT NULL,
  `the_user` int(11) NOT NULL,
  `the_zone` varchar(80) NOT NULL,
  PRIMARY KEY (`the_session`),
  KEY `delete_old` (`last_activity`)
) ENGINE=MyISAM;

--
-- Dumping data for table `ocp_sessions`
--

INSERT INTO `ocp_sessions` (`cache_username`, `ip`, `last_activity`, `session_confirmed`, `session_invisible`, `the_id`, `the_page`, `the_session`, `the_title`, `the_type`, `the_user`, `the_zone`) VALUES('Guest', '174.143.11.*', 1265477342, 0, 0, '', 'login', 1808861890, 'Login', 'misc', 1, 'cms');
INSERT INTO `ocp_sessions` (`cache_username`, `ip`, `last_activity`, `session_confirmed`, `session_invisible`, `the_id`, `the_page`, `the_session`, `the_title`, `the_type`, `the_user`, `the_zone`) VALUES('admin', '0000:0000:0000:0000:0000:0000:*:*', 1265488566, 1, 0, '', 'menus', 1474568641, 'ocPortal&#039;s different menu-types', '', 2, '');

-- --------------------------------------------------------

--
-- Table structure for table `ocp_shopping_cart`
--

DROP TABLE IF EXISTS `ocp_shopping_cart`;
CREATE TABLE IF NOT EXISTS `ocp_shopping_cart` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `is_deleted` tinyint(1) NOT NULL,
  `ordered_by` int(11) NOT NULL,
  `price` double NOT NULL,
  `price_pre_tax` double NOT NULL,
  `product_code` varchar(255) NOT NULL,
  `product_description` longtext NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `product_type` varchar(255) NOT NULL,
  `product_weight` double NOT NULL,
  `quantity` int(11) NOT NULL,
  `session_id` int(11) NOT NULL,
  PRIMARY KEY (`id`,`ordered_by`,`product_id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 ;

--
-- Dumping data for table `ocp_shopping_cart`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_shopping_logging`
--

DROP TABLE IF EXISTS `ocp_shopping_logging`;
CREATE TABLE IF NOT EXISTS `ocp_shopping_logging` (
  `date_and_time` int(10) unsigned NOT NULL,
  `e_member_id` int(11) NOT NULL,
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ip` varchar(40) NOT NULL,
  `last_action` varchar(255) NOT NULL,
  `session_id` int(11) NOT NULL,
  PRIMARY KEY (`e_member_id`,`id`),
  KEY `calculate_bandwidth` (`date_and_time`)
) ENGINE=MyISAM AUTO_INCREMENT=1 ;

--
-- Dumping data for table `ocp_shopping_logging`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_shopping_order`
--

DROP TABLE IF EXISTS `ocp_shopping_order`;
CREATE TABLE IF NOT EXISTS `ocp_shopping_order` (
  `add_date` int(10) unsigned NOT NULL,
  `c_member` int(11) NOT NULL,
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `notes` longtext NOT NULL,
  `order_status` varchar(80) NOT NULL,
  `purchase_through` varchar(255) NOT NULL,
  `session_id` int(11) NOT NULL,
  `tax_opted_out` tinyint(1) NOT NULL,
  `tot_price` double NOT NULL,
  `transaction_id` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `recent_shopped` (`add_date`)
) ENGINE=MyISAM AUTO_INCREMENT=1 ;

--
-- Dumping data for table `ocp_shopping_order`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_shopping_order_addresses`
--

DROP TABLE IF EXISTS `ocp_shopping_order_addresses`;
CREATE TABLE IF NOT EXISTS `ocp_shopping_order_addresses` (
  `address_city` varchar(255) NOT NULL,
  `address_country` varchar(255) NOT NULL,
  `address_name` varchar(255) NOT NULL,
  `address_street` longtext NOT NULL,
  `address_zip` varchar(255) NOT NULL,
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(11) DEFAULT NULL,
  `receiver_email` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 ;

--
-- Dumping data for table `ocp_shopping_order_addresses`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_shopping_order_details`
--

DROP TABLE IF EXISTS `ocp_shopping_order_details`;
CREATE TABLE IF NOT EXISTS `ocp_shopping_order_details` (
  `dispatch_status` varchar(255) NOT NULL,
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `included_tax` double NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  `p_code` varchar(255) NOT NULL,
  `p_id` int(11) DEFAULT NULL,
  `p_name` varchar(255) NOT NULL,
  `p_price` double NOT NULL,
  `p_quantity` int(11) NOT NULL,
  `p_type` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 ;

--
-- Dumping data for table `ocp_shopping_order_details`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_sms_log`
--

DROP TABLE IF EXISTS `ocp_sms_log`;
CREATE TABLE IF NOT EXISTS `ocp_sms_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `s_member_id` int(11) NOT NULL,
  `s_time` int(10) unsigned NOT NULL,
  `s_trigger_ip` varchar(40) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sms_log_for` (`s_member_id`,`s_time`),
  KEY `sms_trigger_ip` (`s_trigger_ip`)
) ENGINE=MyISAM AUTO_INCREMENT=1 ;

--
-- Dumping data for table `ocp_sms_log`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_sp_list`
--

DROP TABLE IF EXISTS `ocp_sp_list`;
CREATE TABLE IF NOT EXISTS `ocp_sp_list` (
  `p_section` varchar(80) NOT NULL,
  `the_default` tinyint(1) NOT NULL,
  `the_name` varchar(80) NOT NULL,
  PRIMARY KEY (`the_default`,`the_name`)
) ENGINE=MyISAM;

--
-- Dumping data for table `ocp_sp_list`
--

INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('SUBMISSION', 0, 'delete_own_lowrange_content');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('SUBMISSION', 0, 'delete_own_midrange_content');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('STAFF_ACTIONS', 0, 'restore_content_history');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('STAFF_ACTIONS', 0, 'view_content_history');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('SUBMISSION', 0, 'edit_highrange_content');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('SUBMISSION', 0, 'edit_midrange_content');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('SUBMISSION', 0, 'search_engine_links');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('SUBMISSION', 0, 'can_submit_to_others_categories');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('SUBMISSION', 0, 'delete_own_highrange_content');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('SUBMISSION', 0, 'delete_lowrange_content');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('SUBMISSION', 0, 'delete_midrange_content');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('SUBMISSION', 0, 'delete_highrange_content');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('SUBMISSION', 0, 'edit_own_midrange_content');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('SUBMISSION', 0, 'edit_own_highrange_content');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('SUBMISSION', 0, 'edit_lowrange_content');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('SUBMISSION', 0, 'bypass_validation_midrange_content');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('SUBMISSION', 0, 'bypass_validation_highrange_content');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('STAFF_ACTIONS', 0, 'access_overrun_site');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('STAFF_ACTIONS', 0, 'view_profiling_modes');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('GENERAL_SETTINGS', 0, 'bypass_word_filter');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('STAFF_ACTIONS', 0, 'see_stack_dump');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('STAFF_ACTIONS', 0, 'see_php_errors');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('_COMCODE', 0, 'comcode_nuisance');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('_COMCODE', 0, 'comcode_dangerous');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('STAFF_ACTIONS', 0, 'bypass_bandwidth_restriction');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('STAFF_ACTIONS', 0, 'access_closed_site');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('GENERAL_SETTINGS', 0, 'remove_page_split');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('_COMCODE', 0, 'allow_html');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('GENERAL_SETTINGS', 0, 'bypass_flood_control');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('GENERAL_SETTINGS', 0, 'see_software_docs');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('GENERAL_SETTINGS', 0, 'avoid_simplified_adminzone_look');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('GENERAL_SETTINGS', 0, 'sees_javascript_error_alerts');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('GENERAL_SETTINGS', 0, 'view_revision_history');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('SUBMISSION', 0, 'exceed_filesize_limit');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('SUBMISSION', 0, 'mass_delete_from_ip');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('SUBMISSION', 0, 'scheduled_publication_times');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('GENERAL_SETTINGS', 0, 'open_virtual_roots');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('_COMCODE', 0, 'use_very_dangerous_comcode');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('POLLS', 1, 'vote_in_polls');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('SUBMISSION', 1, 'have_personal_category');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('_FEEDBACK', 1, 'comment');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('_FEEDBACK', 1, 'rate');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('SUBMISSION', 1, 'set_own_author_profile');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('SUBMISSION', 1, 'bypass_validation_lowrange_content');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('SUBMISSION', 1, 'submit_lowrange_content');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('SUBMISSION', 1, 'submit_midrange_content');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('SUBMISSION', 1, 'submit_highrange_content');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('SUBMISSION', 1, 'edit_own_lowrange_content');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('GENERAL_SETTINGS', 1, 'jump_to_unvalidated');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('GENERAL_SETTINGS', 0, 'see_unvalidated');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('SUBMISSION', 0, 'draw_to_server');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('SECTION_FORUMS', 1, 'run_multi_moderations');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('SECTION_FORUMS', 1, 'may_track_forums');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('SECTION_FORUMS', 1, 'use_pt');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('SECTION_FORUMS', 1, 'edit_personal_topic_posts');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('SECTION_FORUMS', 1, 'may_unblind_own_poll');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('SECTION_FORUMS', 1, 'may_report_post');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('SECTION_FORUMS', 1, 'view_member_photos');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('SECTION_FORUMS', 1, 'use_quick_reply');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('SECTION_FORUMS', 1, 'view_profiles');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('SECTION_FORUMS', 1, 'own_avatars');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('SECTION_FORUMS', 0, 'rename_self');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('SECTION_FORUMS', 0, 'use_special_emoticons');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('SECTION_FORUMS', 0, 'view_any_profile_field');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('SECTION_FORUMS', 0, 'disable_lost_passwords');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('SECTION_FORUMS', 0, 'close_own_topics');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('SECTION_FORUMS', 0, 'edit_own_polls');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('SECTION_FORUMS', 0, 'double_post');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('SECTION_FORUMS', 0, 'see_warnings');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('SECTION_FORUMS', 0, 'see_ip');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('SECTION_FORUMS', 0, 'may_choose_custom_title');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('SECTION_FORUMS', 0, 'delete_account');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('SECTION_FORUMS', 0, 'view_other_pt');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('SECTION_FORUMS', 0, 'view_poll_results_before_voting');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('SECTION_FORUMS', 0, 'moderate_personal_topic');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('SECTION_FORUMS', 0, 'member_maintenance');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('SECTION_FORUMS', 0, 'probate_members');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('SECTION_FORUMS', 0, 'warn_members');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('SECTION_FORUMS', 0, 'control_usergroups');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('SECTION_FORUMS', 0, 'multi_delete_topics');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('SECTION_FORUMS', 0, 'show_user_browsing');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('SECTION_FORUMS', 0, 'see_hidden_groups');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('SECTION_FORUMS', 0, 'pt_anyone');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('_COMCODE', 0, 'reuse_others_attachments');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('STAFF_ACTIONS', 0, 'assume_any_member');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('GENERAL_SETTINGS', 0, 'use_sms');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('GENERAL_SETTINGS', 0, 'sms_higher_limit');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('GENERAL_SETTINGS', 0, 'sms_higher_trigger_limit');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('STAFF_ACTIONS', 0, 'delete_content_history');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('SUBMISSION', 0, 'submit_cat_highrange_content');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('SUBMISSION', 0, 'submit_cat_midrange_content');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('SUBMISSION', 0, 'submit_cat_lowrange_content');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('SUBMISSION', 0, 'edit_cat_highrange_content');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('SUBMISSION', 0, 'edit_cat_midrange_content');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('SUBMISSION', 0, 'edit_cat_lowrange_content');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('SUBMISSION', 0, 'delete_cat_highrange_content');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('SUBMISSION', 0, 'delete_cat_midrange_content');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('SUBMISSION', 0, 'delete_cat_lowrange_content');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('SUBMISSION', 0, 'edit_own_cat_highrange_content');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('SUBMISSION', 0, 'edit_own_cat_midrange_content');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('SUBMISSION', 0, 'edit_own_cat_lowrange_content');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('SUBMISSION', 0, 'delete_own_cat_highrange_content');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('SUBMISSION', 0, 'delete_own_cat_midrange_content');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('SUBMISSION', 0, 'delete_own_cat_lowrange_content');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('SUBMISSION', 0, 'mass_import');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('BANNERS', 0, 'full_banner_setup');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('BANNERS', 0, 'view_anyones_banner_stats');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('BANNERS', 0, 'banner_free');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('CALENDAR', 1, 'view_calendar');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('CALENDAR', 1, 'add_public_events');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('CALENDAR', 0, 'view_personal_events');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('CALENDAR', 0, 'sense_personal_conflicts');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('CALENDAR', 0, 'view_event_subscriptions');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('CATALOGUES', 0, 'high_catalogue_entry_timeout');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('SEEDY', 0, 'seedy_manage_tree');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('SECTION_CHAT', 1, 'create_private_room');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('SECTION_CHAT', 1, 'start_im');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('SECTION_CHAT', 1, 'moderate_my_private_rooms');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('SECTION_CHAT', 0, 'ban_chatters_from_rooms');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('GALLERIES', 0, 'may_download_gallery');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('GALLERIES', 0, 'high_personal_gallery_limit');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('GALLERIES', 0, 'no_personal_gallery_limit');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('IOTDS', 0, 'choose_iotd');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('NEWSLETTER', 0, 'change_newsletter_subscriptions');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('POINTS', 1, 'use_points');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('POINTS', 0, 'give_points_self');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('POINTS', 0, 'have_negative_gift_points');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('POINTS', 0, 'give_negative_points');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('POINTS', 0, 'view_charge_log');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('POINTS', 0, 'trace_anonymous_gifts');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('POLLS', 0, 'choose_poll');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('ECOMMERCE', 0, 'access_ecommerce_in_test_mode');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('QUIZZES', 0, 'bypass_quiz_repeat_time_restriction');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('TESTER', 0, 'perform_tests');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('TESTER', 1, 'add_tests');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('TESTER', 1, 'edit_own_tests');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('SUPPORT_TICKETS', 0, 'support_operator');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('SUPPORT_TICKETS', 0, 'view_others_tickets');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('FILE_DUMP', 0, 'upload_anything_filedump');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('FILE_DUMP', 1, 'upload_filedump');
INSERT INTO `ocp_sp_list` (`p_section`, `the_default`, `the_name`) VALUES('FILE_DUMP', 0, 'delete_anything_filedump');

-- --------------------------------------------------------

--
-- Table structure for table `ocp_staff_tips_dismissed`
--

DROP TABLE IF EXISTS `ocp_staff_tips_dismissed`;
CREATE TABLE IF NOT EXISTS `ocp_staff_tips_dismissed` (
  `t_member` int(11) NOT NULL,
  `t_tip` varchar(80) NOT NULL,
  PRIMARY KEY (`t_member`,`t_tip`)
) ENGINE=MyISAM;

--
-- Dumping data for table `ocp_staff_tips_dismissed`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_stats`
--

DROP TABLE IF EXISTS `ocp_stats`;
CREATE TABLE IF NOT EXISTS `ocp_stats` (
  `access_denied_counter` int(11) NOT NULL,
  `browser` varchar(255) NOT NULL,
  `date_and_time` int(10) unsigned NOT NULL,
  `get` varchar(255) NOT NULL,
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ip` varchar(40) NOT NULL,
  `milliseconds` int(11) NOT NULL,
  `operating_system` varchar(255) NOT NULL,
  `post` longtext NOT NULL,
  `referer` varchar(255) NOT NULL,
  `the_page` varchar(255) NOT NULL,
  `the_user` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `member_track` (`ip`,`the_user`),
  KEY `pages` (`the_page`)
) ENGINE=MyISAM AUTO_INCREMENT=1 ;

--
-- Dumping data for table `ocp_stats`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_subscriptions`
--

DROP TABLE IF EXISTS `ocp_subscriptions`;
CREATE TABLE IF NOT EXISTS `ocp_subscriptions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `s_amount` varchar(255) NOT NULL,
  `s_auto_fund_key` varchar(255) NOT NULL,
  `s_auto_fund_source` varchar(80) NOT NULL,
  `s_member_id` int(11) NOT NULL,
  `s_special` varchar(255) NOT NULL,
  `s_state` varchar(80) NOT NULL,
  `s_time` int(10) unsigned NOT NULL,
  `s_type_code` varchar(80) NOT NULL,
  `s_via` varchar(80) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 ;

--
-- Dumping data for table `ocp_subscriptions`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_tests`
--

DROP TABLE IF EXISTS `ocp_tests`;
CREATE TABLE IF NOT EXISTS `ocp_tests` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `t_assigned_to` int(11) DEFAULT NULL,
  `t_enabled` tinyint(1) NOT NULL,
  `t_inherit_section` int(11) DEFAULT NULL,
  `t_section` int(11) NOT NULL,
  `t_status` int(11) NOT NULL,
  `t_test` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 ;

--
-- Dumping data for table `ocp_tests`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_test_sections`
--

DROP TABLE IF EXISTS `ocp_test_sections`;
CREATE TABLE IF NOT EXISTS `ocp_test_sections` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `s_assigned_to` int(11) DEFAULT NULL,
  `s_inheritable` tinyint(1) NOT NULL,
  `s_notes` longtext NOT NULL,
  `s_section` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 ;

--
-- Dumping data for table `ocp_test_sections`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_text`
--

DROP TABLE IF EXISTS `ocp_text`;
CREATE TABLE IF NOT EXISTS `ocp_text` (
  `activation_time` int(10) unsigned DEFAULT NULL,
  `active_now` tinyint(1) NOT NULL,
  `days` tinyint(4) NOT NULL,
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `notes` longtext NOT NULL,
  `order_time` int(10) unsigned NOT NULL,
  `the_message` int(10) unsigned NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 ;

--
-- Dumping data for table `ocp_text`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_theme_images`
--

DROP TABLE IF EXISTS `ocp_theme_images`;
CREATE TABLE IF NOT EXISTS `ocp_theme_images` (
  `id` varchar(255) NOT NULL,
  `lang` varchar(5) NOT NULL,
  `path` varchar(255) NOT NULL,
  `theme` varchar(40) NOT NULL,
  PRIMARY KEY (`id`,`lang`,`theme`)
) ENGINE=MyISAM;

--
-- Dumping data for table `ocp_theme_images`
--

INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('logo/-logo', 'EN', 'themes/default/images_custom/4b6c6fffb7e0f.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('zone_gradiant', 'EN', 'themes/default/images/zone_gradiant.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('underline', 'EN', 'themes/default/images/underline.gif', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('background_image', 'EN', 'themes/default/images/background_image.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('am_icons/warn_large', 'EN', 'themes/default/images/am_icons/warn_large.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('am_icons/inform_large', 'EN', 'themes/default/images/am_icons/inform_large.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('standardboxes/title_left', 'EN', 'themes/default/images/standardboxes/title_left.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('standardboxes/nontitle_left', 'EN', 'themes/default/images/standardboxes/nontitle_left.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('standardboxes/bottom_left', 'EN', 'themes/default/images/standardboxes/bottom_left.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('standardboxes/title_right', 'EN', 'themes/default/images/standardboxes/title_right.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('standardboxes/nontitle_right', 'EN', 'themes/default/images/standardboxes/nontitle_right.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('standardboxes/bottom_right', 'EN', 'themes/default/images/standardboxes/bottom_right.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('standardboxes/title_gradiant', 'EN', 'themes/default/images/standardboxes/title_gradiant.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('donext/titleleft', 'EN', 'themes/default/images/donext/titleleft.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('donext/titleright', 'EN', 'themes/default/images/donext/titleright.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('donext/topleft', 'EN', 'themes/default/images/donext/topleft.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('donext/topcent', 'EN', 'themes/default/images/donext/topcent.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('donext/topright', 'EN', 'themes/default/images/donext/topright.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('donext/midleft', 'EN', 'themes/default/images/donext/midleft.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('donext/midright', 'EN', 'themes/default/images/donext/midright.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('donext/botleft', 'EN', 'themes/default/images/donext/botleft.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('donext/botmid', 'EN', 'themes/default/images/donext/botmid.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('donext/botright', 'EN', 'themes/default/images/donext/botright.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('edited', 'EN', 'themes/default/images/edited.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('quote_gradiant', 'EN', 'themes/default/images/quote_gradiant.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('arrow_box', 'EN', 'themes/default/images/arrow_box.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('arrow_box_hover', 'EN', 'themes/default/images/arrow_box_hover.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('checklist/checklist1', 'EN', 'themes/default/images/checklist/checklist1.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('carousel/button_left', 'EN', 'themes/default/images/carousel/button_left.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('carousel/button_left_hover', 'EN', 'themes/default/images/carousel/button_left_hover.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('carousel/button_right', 'EN', 'themes/default/images/carousel/button_right.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('carousel/button_right_hover', 'EN', 'themes/default/images/carousel/button_right_hover.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('tab', 'EN', 'themes/default/images/tab.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('menus/menu_bullet_expand', 'EN', 'themes/default/images/menus/menu_bullet_expand.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('menus/menu_bullet_expand_hover', 'EN', 'themes/default/images/menus/menu_bullet_expand_hover.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('menus/menu_bullet_current', 'EN', 'themes/default/images/menus/menu_bullet_current.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('menus/menu_bullet', 'EN', 'themes/default/images/menus/menu_bullet.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('menus/menu_bullet_hover', 'EN', 'themes/default/images/menus/menu_bullet_hover.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('recommend/print', 'EN', 'themes/default/images/recommend/print.gif', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('recommend/recommend', 'EN', 'themes/default/images/recommend/recommend.gif', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('recommend/favorites', 'EN', 'themes/default/images/recommend/favorites.gif', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('recommend/facebook', 'EN', 'themes/default/images/recommend/facebook.gif', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('recommend/twitter', 'EN', 'themes/default/images/recommend/twitter.gif', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('recommend/stumbleupon', 'EN', 'themes/default/images/recommend/stumbleupon.gif', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('recommend/digg', 'EN', 'themes/default/images/recommend/digg.gif', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('filetypes/email_link', 'EN', 'themes/default/images/filetypes/email_link.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('filetypes/page_pdf', 'EN', 'themes/default/images/filetypes/page_pdf.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('filetypes/page_doc', 'EN', 'themes/default/images/filetypes/page_doc.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('filetypes/page_xls', 'EN', 'themes/default/images/filetypes/page_xls.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('filetypes/page_ppt', 'EN', 'themes/default/images/filetypes/page_ppt.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('filetypes/page_txt', 'EN', 'themes/default/images/filetypes/page_txt.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('filetypes/page_odt', 'EN', 'themes/default/images/filetypes/page_odt.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('filetypes/page_ods', 'EN', 'themes/default/images/filetypes/page_ods.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('filetypes/feed', 'EN', 'themes/default/images/filetypes/feed.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('filetypes/page_torrent', 'EN', 'themes/default/images/filetypes/page_torrent.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('filetypes/page_archive', 'EN', 'themes/default/images/filetypes/page_archive.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('filetypes/page_media', 'EN', 'themes/default/images/filetypes/page_media.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('filetypes/external_link', 'EN', 'themes/default/images/filetypes/external_link.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('expand', 'EN', 'themes/default/images/expand.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('contract', 'EN', 'themes/default/images/contract.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('exp_con', 'EN', 'themes/default/images/exp_con.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('help_panel_hide', 'EN', 'themes/default/images/help_panel_hide.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('help_panel_show', 'EN', 'themes/default/images/help_panel_show.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bottom/loading', 'EN', 'themes/default/images/bottom/loading.gif', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/back', 'EN', 'themes/default/images/bigicons/back.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bottom/top', 'EN', 'themes/default/images/bottom/top.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bottom/home', 'EN', 'themes/default/images/bottom/home.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bottom/sitemap', 'EN', 'themes/default/images/bottom/sitemap.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('page/join', 'EN', 'themes/default/images/EN/page/join.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('page/login', 'EN', 'themes/default/images/EN/page/login.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('menus/menu', 'EN', 'themes/default/images/menus/menu.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('comcode', 'EN', 'themes/default/images/comcode.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bottom/managementmenu', 'EN', 'themes/default/images/bottom/managementmenu.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bottom/bookmarksmenu', 'EN', 'themes/default/images/bottom/bookmarksmenu.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('am_icons/notice', 'EN', 'themes/default/images/am_icons/notice.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bottom/occle', 'EN', 'themes/default/images/bottom/occle.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('logo/adminzone-logo', 'EN', 'themes/default/images/EN/logo/adminzone-logo.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('menu_items/management_navigation/start', 'EN', 'themes/default/images/menu_items/management_navigation/start.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('menu_items/management_navigation/structure', 'EN', 'themes/default/images/menu_items/management_navigation/structure.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('menu_items/management_navigation/security', 'EN', 'themes/default/images/menu_items/management_navigation/security.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('menu_items/management_navigation/style', 'EN', 'themes/default/images/menu_items/management_navigation/style.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('menu_items/management_navigation/setup', 'EN', 'themes/default/images/menu_items/management_navigation/setup.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('menu_items/management_navigation/tools', 'EN', 'themes/default/images/menu_items/management_navigation/tools.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('menu_items/management_navigation/usage', 'EN', 'themes/default/images/menu_items/management_navigation/usage.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('menu_items/management_navigation/cms', 'EN', 'themes/default/images/menu_items/management_navigation/cms.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('menu_items/management_navigation/docs', 'EN', 'themes/default/images/menu_items/management_navigation/docs.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('checklist/checklist0', 'EN', 'themes/default/images/checklist/checklist0.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('checklist/checklist-', 'EN', 'themes/default/images/checklist/checklist-.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('pagepics/ocp-logo', 'EN', 'themes/default/images/pagepics/ocp-logo.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/addons', 'EN', 'themes/default/images/bigicons/addons.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/awards', 'EN', 'themes/default/images/bigicons/awards.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/config', 'EN', 'themes/default/images/bigicons/config.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/custom-comcode', 'EN', 'themes/default/images/bigicons/custom-comcode.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/customprofilefields', 'EN', 'themes/default/images/bigicons/customprofilefields.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/baseconfig', 'EN', 'themes/default/images/bigicons/baseconfig.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/pointstore', 'EN', 'themes/default/images/bigicons/pointstore.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/multimods', 'EN', 'themes/default/images/bigicons/multimods.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/posttemplates', 'EN', 'themes/default/images/bigicons/posttemplates.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/setupwizard', 'EN', 'themes/default/images/bigicons/setupwizard.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/tickets', 'EN', 'themes/default/images/bigicons/tickets.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/ecommerce', 'EN', 'themes/default/images/bigicons/ecommerce.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/welcome_emails', 'EN', 'themes/default/images/bigicons/welcome_emails.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('pagepics/configwizard', 'EN', 'themes/default/images/pagepics/configwizard.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('treenav', 'EN', 'themes/default/images/treenav.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('logo/-logo', 'EN', 'themes/_unnamed_/images_custom/4b6c6fffa1a90.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('zone_gradiant', 'EN', 'themes/default/images/zone_gradiant.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('underline', 'EN', 'themes/default/images/underline.gif', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('background_image', 'EN', 'themes/default/images/background_image.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('am_icons/warn_large', 'EN', 'themes/default/images/am_icons/warn_large.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('am_icons/inform_large', 'EN', 'themes/default/images/am_icons/inform_large.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('standardboxes/title_left', 'EN', 'themes/default/images/standardboxes/title_left.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('standardboxes/nontitle_left', 'EN', 'themes/default/images/standardboxes/nontitle_left.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('standardboxes/bottom_left', 'EN', 'themes/default/images/standardboxes/bottom_left.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('standardboxes/title_right', 'EN', 'themes/default/images/standardboxes/title_right.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('standardboxes/nontitle_right', 'EN', 'themes/default/images/standardboxes/nontitle_right.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('standardboxes/bottom_right', 'EN', 'themes/default/images/standardboxes/bottom_right.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('standardboxes/title_gradiant', 'EN', 'themes/default/images/standardboxes/title_gradiant.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('donext/titleleft', 'EN', 'themes/default/images/donext/titleleft.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('donext/titleright', 'EN', 'themes/default/images/donext/titleright.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('donext/topleft', 'EN', 'themes/default/images/donext/topleft.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('donext/topcent', 'EN', 'themes/default/images/donext/topcent.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('donext/topright', 'EN', 'themes/default/images/donext/topright.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('donext/midleft', 'EN', 'themes/default/images/donext/midleft.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('donext/midright', 'EN', 'themes/default/images/donext/midright.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('donext/botleft', 'EN', 'themes/default/images/donext/botleft.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('donext/botmid', 'EN', 'themes/default/images/donext/botmid.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('donext/botright', 'EN', 'themes/default/images/donext/botright.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('edited', 'EN', 'themes/default/images/edited.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('quote_gradiant', 'EN', 'themes/default/images/quote_gradiant.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('arrow_box', 'EN', 'themes/default/images/arrow_box.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('arrow_box_hover', 'EN', 'themes/default/images/arrow_box_hover.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('checklist/checklist1', 'EN', 'themes/default/images/checklist/checklist1.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('carousel/button_left', 'EN', 'themes/default/images/carousel/button_left.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('carousel/button_left_hover', 'EN', 'themes/default/images/carousel/button_left_hover.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('carousel/button_right', 'EN', 'themes/default/images/carousel/button_right.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('carousel/button_right_hover', 'EN', 'themes/default/images/carousel/button_right_hover.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('tab', 'EN', 'themes/default/images/tab.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('menus/menu_bullet_expand', 'EN', 'themes/default/images/menus/menu_bullet_expand.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('menus/menu_bullet_expand_hover', 'EN', 'themes/default/images/menus/menu_bullet_expand_hover.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('menus/menu_bullet_current', 'EN', 'themes/default/images/menus/menu_bullet_current.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('menus/menu_bullet', 'EN', 'themes/default/images/menus/menu_bullet.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('menus/menu_bullet_hover', 'EN', 'themes/default/images/menus/menu_bullet_hover.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('recommend/print', 'EN', 'themes/default/images/recommend/print.gif', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('recommend/recommend', 'EN', 'themes/default/images/recommend/recommend.gif', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('recommend/favorites', 'EN', 'themes/default/images/recommend/favorites.gif', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('recommend/facebook', 'EN', 'themes/default/images/recommend/facebook.gif', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('recommend/twitter', 'EN', 'themes/default/images/recommend/twitter.gif', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('recommend/stumbleupon', 'EN', 'themes/default/images/recommend/stumbleupon.gif', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('recommend/digg', 'EN', 'themes/default/images/recommend/digg.gif', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('filetypes/email_link', 'EN', 'themes/default/images/filetypes/email_link.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('filetypes/page_pdf', 'EN', 'themes/default/images/filetypes/page_pdf.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('filetypes/page_doc', 'EN', 'themes/default/images/filetypes/page_doc.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('filetypes/page_xls', 'EN', 'themes/default/images/filetypes/page_xls.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('filetypes/page_ppt', 'EN', 'themes/default/images/filetypes/page_ppt.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('filetypes/page_txt', 'EN', 'themes/default/images/filetypes/page_txt.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('filetypes/page_odt', 'EN', 'themes/default/images/filetypes/page_odt.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('filetypes/page_ods', 'EN', 'themes/default/images/filetypes/page_ods.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('filetypes/feed', 'EN', 'themes/default/images/filetypes/feed.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('filetypes/page_torrent', 'EN', 'themes/default/images/filetypes/page_torrent.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('filetypes/page_archive', 'EN', 'themes/default/images/filetypes/page_archive.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('filetypes/page_media', 'EN', 'themes/default/images/filetypes/page_media.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('filetypes/external_link', 'EN', 'themes/default/images/filetypes/external_link.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('expand', 'EN', 'themes/default/images/expand.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('contract', 'EN', 'themes/default/images/contract.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('exp_con', 'EN', 'themes/default/images/exp_con.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('help_panel_hide', 'EN', 'themes/default/images/help_panel_hide.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('help_panel_show', 'EN', 'themes/default/images/help_panel_show.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bottom/loading', 'EN', 'themes/default/images/bottom/loading.gif', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/back', 'EN', 'themes/default/images/bigicons/back.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bottom/top', 'EN', 'themes/default/images/bottom/top.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bottom/home', 'EN', 'themes/default/images/bottom/home.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bottom/sitemap', 'EN', 'themes/default/images/bottom/sitemap.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('page/join', 'EN', 'themes/default/images/EN/page/join.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('page/login', 'EN', 'themes/default/images/EN/page/login.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('menus/menu', 'EN', 'themes/default/images/menus/menu.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('comcode', 'EN', 'themes/default/images/comcode.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bottom/managementmenu', 'EN', 'themes/default/images/bottom/managementmenu.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bottom/bookmarksmenu', 'EN', 'themes/default/images/bottom/bookmarksmenu.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('am_icons/notice', 'EN', 'themes/default/images/am_icons/notice.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bottom/occle', 'EN', 'themes/default/images/bottom/occle.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('logo/adminzone-logo', 'EN', 'themes/default/images/EN/logo/adminzone-logo.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('menu_items/management_navigation/start', 'EN', 'themes/default/images/menu_items/management_navigation/start.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('menu_items/management_navigation/structure', 'EN', 'themes/default/images/menu_items/management_navigation/structure.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('menu_items/management_navigation/security', 'EN', 'themes/default/images/menu_items/management_navigation/security.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('menu_items/management_navigation/style', 'EN', 'themes/default/images/menu_items/management_navigation/style.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('menu_items/management_navigation/setup', 'EN', 'themes/default/images/menu_items/management_navigation/setup.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('menu_items/management_navigation/tools', 'EN', 'themes/default/images/menu_items/management_navigation/tools.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('menu_items/management_navigation/usage', 'EN', 'themes/default/images/menu_items/management_navigation/usage.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('menu_items/management_navigation/cms', 'EN', 'themes/default/images/menu_items/management_navigation/cms.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('menu_items/management_navigation/docs', 'EN', 'themes/default/images/menu_items/management_navigation/docs.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('checklist/checklist0', 'EN', 'themes/default/images/checklist/checklist0.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('checklist/checklist-', 'EN', 'themes/default/images/checklist/checklist-.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('pagepics/ocp-logo', 'EN', 'themes/default/images/pagepics/ocp-logo.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/addons', 'EN', 'themes/default/images/bigicons/addons.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/awards', 'EN', 'themes/default/images/bigicons/awards.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/config', 'EN', 'themes/default/images/bigicons/config.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/custom-comcode', 'EN', 'themes/default/images/bigicons/custom-comcode.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/customprofilefields', 'EN', 'themes/default/images/bigicons/customprofilefields.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/baseconfig', 'EN', 'themes/default/images/bigicons/baseconfig.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/pointstore', 'EN', 'themes/default/images/bigicons/pointstore.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/multimods', 'EN', 'themes/default/images/bigicons/multimods.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/posttemplates', 'EN', 'themes/default/images/bigicons/posttemplates.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/setupwizard', 'EN', 'themes/default/images/bigicons/setupwizard.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/tickets', 'EN', 'themes/default/images/bigicons/tickets.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/ecommerce', 'EN', 'themes/default/images/bigicons/ecommerce.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/welcome_emails', 'EN', 'themes/default/images/bigicons/welcome_emails.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('pagepics/configwizard', 'EN', 'themes/default/images/pagepics/configwizard.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('treenav', 'EN', 'themes/default/images/treenav.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('logo-template', 'EN', 'themes/default/images/logo-template.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('logo/collaboration-logo', 'EN', 'themes/_unnamed_/images_custom/4b6c6fffa1a90.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('trimmed-logo-template', 'EN', 'themes/default/images/trimmed-logo-template.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('logo/trimmed-logo', 'EN', 'themes/_unnamed_/images_custom/4b6c6fffb7e0f.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('logo-template', 'EN', 'themes/default/images/logo-template.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('logo/collaboration-logo', 'EN', 'themes/default/images_custom/4b6c6fffb7e0f.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('trimmed-logo-template', 'EN', 'themes/default/images/trimmed-logo-template.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('logo/trimmed-logo', 'EN', 'themes/default/images_custom/4b6c6fffcca14.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/pagewizard', 'EN', 'themes/default/images/bigicons/pagewizard.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/main_home', 'EN', 'themes/default/images/bigicons/main_home.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/cms_home', 'EN', 'themes/default/images/bigicons/cms_home.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/admin_home', 'EN', 'themes/default/images/bigicons/admin_home.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('led_on', 'EN', 'themes/default/images/led_on.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_rank_images/0', 'EN', 'themes/default/images/ocf_rank_images/0.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_rank_images/admin', 'EN', 'themes/default/images/ocf_rank_images/admin.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('help', 'EN', 'themes/default/images/help.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('logo/cms-logo', 'EN', 'themes/default/images/EN/logo/cms-logo.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('pagepics/polls', 'EN', 'themes/default/images/pagepics/polls.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('comcode_emoticon', 'EN', 'themes/default/images/comcode_emoticon.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('am_icons/inform', 'EN', 'themes/default/images/am_icons/inform.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/cheeky', 'EN', 'themes/default/images/ocf_emoticons/cheeky.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/cry', 'EN', 'themes/default/images/ocf_emoticons/cry.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/dry', 'EN', 'themes/default/images/ocf_emoticons/dry.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/blush', 'EN', 'themes/default/images/ocf_emoticons/blush.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/wink', 'EN', 'themes/default/images/ocf_emoticons/wink.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/blink', 'EN', 'themes/default/images/ocf_emoticons/blink.gif', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/wub', 'EN', 'themes/default/images/ocf_emoticons/wub.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/cool', 'EN', 'themes/default/images/ocf_emoticons/cool.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/lol', 'EN', 'themes/default/images/ocf_emoticons/lol.gif', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/sad', 'EN', 'themes/default/images/ocf_emoticons/sad.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/smile', 'EN', 'themes/default/images/ocf_emoticons/smile.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/thumbs', 'EN', 'themes/default/images/ocf_emoticons/thumbs.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/offtopic', 'EN', 'themes/default/images/ocf_emoticons/offtopic.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/mellow', 'EN', 'themes/default/images/ocf_emoticons/mellow.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/ph34r', 'EN', 'themes/default/images/ocf_emoticons/ph34r.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/shocked', 'EN', 'themes/default/images/ocf_emoticons/shocked.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('menu_items/forum_navigation/forums', 'EN', 'themes/default/images/menu_items/forum_navigation/forums.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('menu_items/forum_navigation/rules', 'EN', 'themes/default/images/menu_items/forum_navigation/rules.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('menu_items/forum_navigation/members', 'EN', 'themes/default/images/menu_items/forum_navigation/members.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('menu_items/forum_navigation/groups', 'EN', 'themes/default/images/menu_items/forum_navigation/groups.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('menu_items/forum_navigation/unread_topics', 'EN', 'themes/default/images/menu_items/forum_navigation/unread_topics.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('menu_items/forum_navigation/recommend', 'EN', 'themes/default/images/menu_items/forum_navigation/recommend.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_general/no_new_posts', 'EN', 'themes/default/images/ocf_general/no_new_posts.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_general/new_posts', 'EN', 'themes/default/images/ocf_general/new_posts.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('page/track_forum', 'EN', 'themes/default/images/EN/page/track_forum.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('page/mark_read', 'EN', 'themes/default/images/EN/page/mark_read.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('page/new_topic', 'EN', 'themes/default/images/EN/page/new_topic.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('swfupload/cancelbutton', 'EN', 'themes/default/images/swfupload/cancelbutton.gif', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('pageitem/clear', 'EN', 'themes/default/images/EN/pageitem/clear.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('pageitem/upload', 'EN', 'themes/default/images/EN/pageitem/upload.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('pagepics/iotds', 'EN', 'themes/default/images/pagepics/iotds.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('treefield/plus', 'EN', 'themes/default/images/treefield/plus.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('treefield/minus', 'EN', 'themes/default/images/treefield/minus.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('treefield/category', 'EN', 'themes/default/images/treefield/category.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('treefield/entry', 'EN', 'themes/default/images/treefield/entry.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('pagepics/config', 'EN', 'themes/default/images/pagepics/config.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/add_one_category', 'EN', 'themes/default/images/bigicons/add_one_category.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/edit_one_category', 'EN', 'themes/default/images/bigicons/edit_one_category.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/add_one', 'EN', 'themes/default/images/bigicons/add_one.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/edit_one', 'EN', 'themes/default/images/bigicons/edit_one.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('pagepics/banners', 'EN', 'themes/default/images/pagepics/banners.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('date_chooser/callt', 'EN', 'themes/default/images/date_chooser/callt.gif', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('date_chooser/calrt', 'EN', 'themes/default/images/date_chooser/calrt.gif', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('date_chooser/calx', 'EN', 'themes/default/images/date_chooser/calx.gif', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('date_chooser/pdate', 'EN', 'themes/default/images/date_chooser/pdate.gif', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/main_home', 'EN', 'themes/default/images/bigicons/main_home.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/edit_this', 'EN', 'themes/default/images/bigicons/edit_this.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/view_this', 'EN', 'themes/default/images/bigicons/view_this.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/view_archive', 'EN', 'themes/default/images/bigicons/view_archive.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/edit_this_category', 'EN', 'themes/default/images/bigicons/edit_this_category.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/cms_home', 'EN', 'themes/default/images/bigicons/cms_home.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/admin_home', 'EN', 'themes/default/images/bigicons/admin_home.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('arrow_ruler', 'EN', 'themes/default/images/arrow_ruler.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('page/new', 'EN', 'themes/default/images/EN/page/new.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/cheeky', 'EN', 'themes/default/images/ocf_emoticons/cheeky.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/cry', 'EN', 'themes/default/images/ocf_emoticons/cry.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/dry', 'EN', 'themes/default/images/ocf_emoticons/dry.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/blush', 'EN', 'themes/default/images/ocf_emoticons/blush.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/wink', 'EN', 'themes/default/images/ocf_emoticons/wink.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/blink', 'EN', 'themes/default/images/ocf_emoticons/blink.gif', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/wub', 'EN', 'themes/default/images/ocf_emoticons/wub.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/cool', 'EN', 'themes/default/images/ocf_emoticons/cool.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/lol', 'EN', 'themes/default/images/ocf_emoticons/lol.gif', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/sad', 'EN', 'themes/default/images/ocf_emoticons/sad.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/smile', 'EN', 'themes/default/images/ocf_emoticons/smile.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/thumbs', 'EN', 'themes/default/images/ocf_emoticons/thumbs.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/offtopic', 'EN', 'themes/default/images/ocf_emoticons/offtopic.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/mellow', 'EN', 'themes/default/images/ocf_emoticons/mellow.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/ph34r', 'EN', 'themes/default/images/ocf_emoticons/ph34r.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/shocked', 'EN', 'themes/default/images/ocf_emoticons/shocked.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('logo/cms-logo', 'EN', 'themes/default/images/EN/logo/cms-logo.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('swfupload/cancelbutton', 'EN', 'themes/default/images/swfupload/cancelbutton.gif', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('pageitem/clear', 'EN', 'themes/default/images/EN/pageitem/clear.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('pageitem/upload', 'EN', 'themes/default/images/EN/pageitem/upload.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('pagepics/comcode_page_edit', 'EN', 'themes/default/images/pagepics/comcode_page_edit.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('comcodeeditor/page', 'EN', 'themes/default/images/EN/comcodeeditor/page.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('comcodeeditor/code', 'EN', 'themes/default/images/EN/comcodeeditor/code.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('comcodeeditor/quote', 'EN', 'themes/default/images/EN/comcodeeditor/quote.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('comcodeeditor/hide', 'EN', 'themes/default/images/EN/comcodeeditor/hide.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('comcodeeditor/box', 'EN', 'themes/default/images/EN/comcodeeditor/box.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('comcodeeditor/block', 'EN', 'themes/default/images/EN/comcodeeditor/block.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('comcodeeditor/thumb', 'EN', 'themes/default/images/EN/comcodeeditor/thumb.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('comcodeeditor/url', 'EN', 'themes/default/images/EN/comcodeeditor/url.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('comcodeeditor/email', 'EN', 'themes/default/images/EN/comcodeeditor/email.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('comcodeeditor/list', 'EN', 'themes/default/images/EN/comcodeeditor/list.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('comcodeeditor/html', 'EN', 'themes/default/images/EN/comcodeeditor/html.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('comcodeeditor/b', 'EN', 'themes/default/images/EN/comcodeeditor/b.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('comcodeeditor/i', 'EN', 'themes/default/images/EN/comcodeeditor/i.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('comcodeeditor/apply_changes', 'EN', 'themes/default/images/EN/comcodeeditor/apply_changes.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/edit_this', 'EN', 'themes/default/images/bigicons/edit_this.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/comcode_page_edit', 'EN', 'themes/default/images/bigicons/comcode_page_edit.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/redirect', 'EN', 'themes/default/images/bigicons/redirect.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/sitetree', 'EN', 'themes/default/images/bigicons/sitetree.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/view_this', 'EN', 'themes/default/images/bigicons/view_this.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_rank_images/admin', 'EN', 'themes/default/images/ocf_rank_images/admin.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_rank_images/0', 'EN', 'themes/default/images/ocf_rank_images/0.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('led_on', 'EN', 'themes/default/images/led_on.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('help', 'EN', 'themes/default/images/help.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('google', 'EN', 'themes/default/images/google.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('pageitem/delete', 'EN', 'themes/default/images/EN/pageitem/delete.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('pageitem/export', 'EN', 'themes/default/images/EN/pageitem/export.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/add_one_category', 'EN', 'themes/default/images/bigicons/add_one_category.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/edit_one_category', 'EN', 'themes/default/images/bigicons/edit_one_category.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/add_one', 'EN', 'themes/default/images/bigicons/add_one.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/edit_one', 'EN', 'themes/default/images/bigicons/edit_one.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('am_icons/inform', 'EN', 'themes/default/images/am_icons/inform.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('pagepics/banners', 'EN', 'themes/default/images/pagepics/banners.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/newsletters', 'EN', 'themes/default/images/bigicons/newsletters.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/newsletter_from_changes', 'EN', 'themes/default/images/bigicons/newsletter_from_changes.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/view_archive', 'EN', 'themes/default/images/bigicons/view_archive.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/subscribers', 'EN', 'themes/default/images/bigicons/subscribers.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/import_subscribers', 'EN', 'themes/default/images/bigicons/import_subscribers.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('pagepics/newsletter', 'EN', 'themes/default/images/pagepics/newsletter.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/addmember', 'EN', 'themes/default/images/bigicons/addmember.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/usergroups', 'EN', 'themes/default/images/bigicons/usergroups.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/backups', 'EN', 'themes/default/images/bigicons/backups.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/bulkupload', 'EN', 'themes/default/images/bigicons/bulkupload.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/debrand', 'EN', 'themes/default/images/bigicons/debrand.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/deletelurkers', 'EN', 'themes/default/images/bigicons/deletelurkers.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/download_csv', 'EN', 'themes/default/images/bigicons/download_csv.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/editmember', 'EN', 'themes/default/images/bigicons/editmember.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/import', 'EN', 'themes/default/images/bigicons/import.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/import_csv', 'EN', 'themes/default/images/bigicons/import_csv.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/merge_members', 'EN', 'themes/default/images/bigicons/merge_members.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/occle', 'EN', 'themes/default/images/bigicons/occle.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/phpinfo', 'EN', 'themes/default/images/bigicons/phpinfo.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/cleanup', 'EN', 'themes/default/images/bigicons/cleanup.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/xml', 'EN', 'themes/default/images/bigicons/xml.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('pagepics/iotds', 'EN', 'themes/default/images/pagepics/iotds.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('am_icons/warn', 'EN', 'themes/default/images/am_icons/warn.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/authors', 'EN', 'themes/default/images/bigicons/authors.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/banners', 'EN', 'themes/default/images/bigicons/banners.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/news', 'EN', 'themes/default/images/bigicons/news.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/calendar', 'EN', 'themes/default/images/bigicons/calendar.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/catalogues', 'EN', 'themes/default/images/bigicons/catalogues.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/cedi', 'EN', 'themes/default/images/bigicons/cedi.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/chatrooms', 'EN', 'themes/default/images/bigicons/chatrooms.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/clubs', 'EN', 'themes/default/images/bigicons/clubs.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/of_catalogues', 'EN', 'themes/default/images/bigicons/of_catalogues.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/downloads', 'EN', 'themes/default/images/bigicons/downloads.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/galleries', 'EN', 'themes/default/images/bigicons/galleries.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/iotds', 'EN', 'themes/default/images/bigicons/iotds.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/polls', 'EN', 'themes/default/images/bigicons/polls.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/quiz', 'EN', 'themes/default/images/bigicons/quiz.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('treefield/plus', 'EN', 'themes/default/images/treefield/plus.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('treefield/minus', 'EN', 'themes/default/images/treefield/minus.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('treefield/category', 'EN', 'themes/default/images/treefield/category.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('treefield/entry', 'EN', 'themes/default/images/treefield/entry.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('pagepics/downloads', 'EN', 'themes/default/images/pagepics/downloads.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('comcode_emoticon', 'EN', 'themes/default/images/comcode_emoticon.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/add_one_licence', 'EN', 'themes/default/images/bigicons/add_one_licence.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/edit_one_licence', 'EN', 'themes/default/images/bigicons/edit_one_licence.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('permlevels/3', 'EN', 'themes/default/images/permlevels/3.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('permlevels/2', 'EN', 'themes/default/images/permlevels/2.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('permlevels/1', 'EN', 'themes/default/images/permlevels/1.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('permlevels/inherit', 'EN', 'themes/default/images/permlevels/inherit.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('blank', 'EN', 'themes/default/images/blank.gif', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('permlevels/0', 'EN', 'themes/default/images/permlevels/0.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('led_off', 'EN', 'themes/default/images/led_off.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/add_to_category', 'EN', 'themes/default/images/bigicons/add_to_category.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/edit_this_category', 'EN', 'themes/default/images/bigicons/edit_this_category.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/view_this_category', 'EN', 'themes/default/images/bigicons/view_this_category.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('arrow_ruler', 'EN', 'themes/default/images/arrow_ruler.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/add_image_to_this', 'EN', 'themes/default/images/bigicons/add_image_to_this.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/cash_flow', 'EN', 'themes/default/images/bigicons/cash_flow.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/profit_loss', 'EN', 'themes/default/images/bigicons/profit_loss.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/transactions', 'EN', 'themes/default/images/bigicons/transactions.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/invoices', 'EN', 'themes/default/images/bigicons/invoices.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/orders', 'EN', 'themes/default/images/bigicons/orders.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('pagepics/ecommerce', 'EN', 'themes/default/images/pagepics/ecommerce.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/messaging', 'EN', 'themes/default/images/bigicons/messaging.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/actionlog', 'EN', 'themes/default/images/bigicons/actionlog.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/errorlog', 'EN', 'themes/default/images/bigicons/errorlog.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/pointslog', 'EN', 'themes/default/images/bigicons/pointslog.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/investigateuser', 'EN', 'themes/default/images/bigicons/investigateuser.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/pointstorelog', 'EN', 'themes/default/images/bigicons/pointstorelog.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/securitylog', 'EN', 'themes/default/images/bigicons/securitylog.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/statistics', 'EN', 'themes/default/images/bigicons/statistics.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/edit_one_catalogue', 'EN', 'themes/default/images/bigicons/edit_one_catalogue.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('pagepics/catalogues', 'EN', 'themes/default/images/pagepics/catalogues.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/add_one_catalogue', 'EN', 'themes/default/images/bigicons/add_one_catalogue.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/edit_this_catalogue', 'EN', 'themes/default/images/bigicons/edit_this_catalogue.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('page/cart_view', 'EN', 'themes/default/images/EN/page/cart_view.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('page/cart_add', 'EN', 'themes/default/images/EN/page/cart_add.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('page/shopping_buy_now', 'EN', 'themes/default/images/EN/page/shopping_buy_now.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('pageitem/cart_add', 'EN', 'themes/default/images/EN/pageitem/cart_add.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('pageitem/goto', 'EN', 'themes/default/images/EN/pageitem/goto.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('top', 'EN', 'themes/default/images/top.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('page/changes', 'EN', 'themes/default/images/EN/page/changes.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('page/edit_tree', 'EN', 'themes/default/images/EN/page/edit_tree.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('page/edit', 'EN', 'themes/default/images/EN/page/edit.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('page/new_post', 'EN', 'themes/default/images/EN/page/new_post.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('pagepics/cedi', 'EN', 'themes/default/images/pagepics/cedi.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('comcodeeditor/page', 'EN', 'themes/default/images/EN/comcodeeditor/page.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('comcodeeditor/code', 'EN', 'themes/default/images/EN/comcodeeditor/code.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('comcodeeditor/quote', 'EN', 'themes/default/images/EN/comcodeeditor/quote.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('comcodeeditor/hide', 'EN', 'themes/default/images/EN/comcodeeditor/hide.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('comcodeeditor/box', 'EN', 'themes/default/images/EN/comcodeeditor/box.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('comcodeeditor/block', 'EN', 'themes/default/images/EN/comcodeeditor/block.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('comcodeeditor/thumb', 'EN', 'themes/default/images/EN/comcodeeditor/thumb.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('comcodeeditor/url', 'EN', 'themes/default/images/EN/comcodeeditor/url.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('comcodeeditor/email', 'EN', 'themes/default/images/EN/comcodeeditor/email.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('comcodeeditor/list', 'EN', 'themes/default/images/EN/comcodeeditor/list.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('comcodeeditor/html', 'EN', 'themes/default/images/EN/comcodeeditor/html.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('comcodeeditor/b', 'EN', 'themes/default/images/EN/comcodeeditor/b.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('comcodeeditor/i', 'EN', 'themes/default/images/EN/comcodeeditor/i.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('comcodeeditor/apply_changes', 'EN', 'themes/default/images/EN/comcodeeditor/apply_changes.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('pageitem/edit', 'EN', 'themes/default/images/EN/pageitem/edit.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('pageitem/move', 'EN', 'themes/default/images/EN/pageitem/move.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('page/previous', 'EN', 'themes/default/images/EN/page/previous.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('page/add_event', 'EN', 'themes/default/images/EN/page/add_event.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('page/next', 'EN', 'themes/default/images/EN/page/next.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('date_chooser/callt', 'EN', 'themes/default/images/date_chooser/callt.gif', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('date_chooser/calrt', 'EN', 'themes/default/images/date_chooser/calrt.gif', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('date_chooser/calx', 'EN', 'themes/default/images/date_chooser/calx.gif', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('pagepics/calendar', 'EN', 'themes/default/images/pagepics/calendar.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('date_chooser/pdate', 'EN', 'themes/default/images/date_chooser/pdate.gif', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('led_off', 'EN', 'themes/default/images/led_off.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('calendar/general', 'EN', 'themes/default/images/calendar/general.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('calendar/priority_3', 'EN', 'themes/default/images/calendar/priority_3.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('pagepics/news', 'EN', 'themes/default/images/pagepics/news.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('na', 'EN', 'themes/default/images/na.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('newscats/art', 'EN', 'themes/default/images/newscats/art.jpg', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('newscats/business', 'EN', 'themes/default/images/newscats/business.jpg', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('newscats/community', 'EN', 'themes/default/images/newscats/community.jpg', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('newscats/difficulties', 'EN', 'themes/default/images/newscats/difficulties.jpg', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('newscats/entertainment', 'EN', 'themes/default/images/newscats/entertainment.jpg', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('newscats/general', 'EN', 'themes/default/images/newscats/general.jpg', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('newscats/technology', 'EN', 'themes/default/images/newscats/technology.jpg', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('newscats/general', 'EN', 'themes/default/images/newscats/general.jpg', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('page/all2', 'EN', 'themes/default/images/EN/page/all2.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('pagepics/quiz', 'EN', 'themes/default/images/pagepics/quiz.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/add_one_image', 'EN', 'themes/default/images/bigicons/add_one_image.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/edit_one_image', 'EN', 'themes/default/images/bigicons/edit_one_image.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/add_one_video', 'EN', 'themes/default/images/bigicons/add_one_video.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/edit_one_video', 'EN', 'themes/default/images/bigicons/edit_one_video.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('pagepics/images', 'EN', 'themes/default/images/pagepics/images.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/add_video_to_this', 'EN', 'themes/default/images/bigicons/add_video_to_this.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('page/no_previous', 'EN', 'themes/default/images/EN/page/no_previous.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('page/no_next', 'EN', 'themes/default/images/EN/page/no_next.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('page/slideshow', 'EN', 'themes/default/images/EN/page/slideshow.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('results/sortablefield_asc', 'EN', 'themes/default/images/results/sortablefield_asc.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('results/sortablefield_desc', 'EN', 'themes/default/images/results/sortablefield_desc.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('tableitem/delete', 'EN', 'themes/default/images/tableitem/delete.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('pagepics/awards', 'EN', 'themes/default/images/pagepics/awards.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/emoticons', 'EN', 'themes/default/images/bigicons/emoticons.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/language', 'EN', 'themes/default/images/bigicons/language.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/make_logo', 'EN', 'themes/default/images/bigicons/make_logo.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/manage_themes', 'EN', 'themes/default/images/bigicons/manage_themes.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/quotes', 'EN', 'themes/default/images/bigicons/quotes.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/themewizard', 'EN', 'themes/default/images/bigicons/themewizard.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('carousel/fade_left', 'EN', 'themes/default/images/carousel/fade_left.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('carousel/fade_right', 'EN', 'themes/default/images/carousel/fade_right.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('pagepics/backups', 'EN', 'themes/default/images/pagepics/backups.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('pagepics/statistics', 'EN', 'themes/default/images/pagepics/statistics.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/page_views', 'EN', 'themes/default/images/bigicons/page_views.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/users_online', 'EN', 'themes/default/images/bigicons/users_online.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/submits', 'EN', 'themes/default/images/bigicons/submits.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/load_times', 'EN', 'themes/default/images/bigicons/load_times.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/top_referrers', 'EN', 'themes/default/images/bigicons/top_referrers.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/top_keywords', 'EN', 'themes/default/images/bigicons/top_keywords.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/statistics_demographics', 'EN', 'themes/default/images/bigicons/statistics_demographics.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/statistics_posting_rates', 'EN', 'themes/default/images/bigicons/statistics_posting_rates.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/searchstats', 'EN', 'themes/default/images/bigicons/searchstats.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/geolocate', 'EN', 'themes/default/images/bigicons/geolocate.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/clear_stats', 'EN', 'themes/default/images/bigicons/clear_stats.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('pagepics/investigateuser', 'EN', 'themes/default/images/pagepics/investigateuser.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('pagepics/securitylog', 'EN', 'themes/default/images/pagepics/securitylog.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('results/sortablefield_asc', 'EN', 'themes/default/images/results/sortablefield_asc.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('results/sortablefield_desc', 'EN', 'themes/default/images/results/sortablefield_desc.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/ipban', 'EN', 'themes/default/images/bigicons/ipban.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/specific-permissions', 'EN', 'themes/default/images/bigicons/specific-permissions.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/ldap', 'EN', 'themes/default/images/bigicons/ldap.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/matchkeysecurity', 'EN', 'themes/default/images/bigicons/matchkeysecurity.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/permissionstree', 'EN', 'themes/default/images/bigicons/permissionstree.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/ssl', 'EN', 'themes/default/images/bigicons/ssl.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/staff', 'EN', 'themes/default/images/bigicons/staff.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/wordfilter', 'EN', 'themes/default/images/bigicons/wordfilter.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('pte_view_help', 'EN', 'themes/default/images/pte_view_help.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('pagepics/staff', 'EN', 'themes/default/images/pagepics/staff.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('pagepics/cleanup', 'EN', 'themes/default/images/pagepics/cleanup.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('pagepics/errorlog', 'EN', 'themes/default/images/pagepics/errorlog.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('pagepics/actionlog', 'EN', 'themes/default/images/pagepics/actionlog.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/forums', 'EN', 'themes/default/images/bigicons/forums.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/menus', 'EN', 'themes/default/images/bigicons/menus.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/multisitenetwork', 'EN', 'themes/default/images/bigicons/multisitenetwork.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/zone_editor', 'EN', 'themes/default/images/bigicons/zone_editor.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/zones', 'EN', 'themes/default/images/bigicons/zones.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('pagepics/themewizard', 'EN', 'themes/default/images/pagepics/themewizard.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('pagepics/logowizard', 'EN', 'themes/default/images/pagepics/logowizard.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('pagepics/bulkuploadassistant', 'EN', 'themes/default/images/pagepics/bulkuploadassistant.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('pagepics/wordfilter', 'EN', 'themes/default/images/pagepics/wordfilter.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('pagepics/ipban', 'EN', 'themes/default/images/pagepics/ipban.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('pagepics/debrand', 'EN', 'themes/default/images/pagepics/debrand.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('pagepics/specific-permissions', 'EN', 'themes/default/images/pagepics/specific-permissions.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('pagepics/menus', 'EN', 'themes/default/images/pagepics/menus.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('pagepics/zones', 'EN', 'themes/default/images/pagepics/zones.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('tableitem/delete', 'EN', 'themes/default/images/tableitem/delete.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('pagepics/importdata', 'EN', 'themes/default/images/pagepics/importdata.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('pagepics/ldap', 'EN', 'themes/default/images/pagepics/ldap.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('pagepics/xml', 'EN', 'themes/default/images/pagepics/xml.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('pagepics/usergroups', 'EN', 'themes/default/images/pagepics/usergroups.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('pagepics/customprofilefields', 'EN', 'themes/default/images/pagepics/customprofilefields.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/rolleyes', 'EN', 'themes/default/images/ocf_emoticons/rolleyes.gif', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/grin', 'EN', 'themes/default/images/ocf_emoticons/grin.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/glee', 'EN', 'themes/default/images/ocf_emoticons/glee.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/confused', 'EN', 'themes/default/images/ocf_emoticons/confused.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/angry', 'EN', 'themes/default/images/ocf_emoticons/angry.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/shake', 'EN', 'themes/default/images/ocf_emoticons/shake.gif', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/hand', 'EN', 'themes/default/images/ocf_emoticons/hand.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/drool', 'EN', 'themes/default/images/ocf_emoticons/drool.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/devil', 'EN', 'themes/default/images/ocf_emoticons/devil.gif', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/constipated', 'EN', 'themes/default/images/ocf_emoticons/constipated.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/depressed', 'EN', 'themes/default/images/ocf_emoticons/depressed.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/zzz', 'EN', 'themes/default/images/ocf_emoticons/zzz.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/upsidedown', 'EN', 'themes/default/images/ocf_emoticons/upsidedown.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/sick', 'EN', 'themes/default/images/ocf_emoticons/sick.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/sarcy', 'EN', 'themes/default/images/ocf_emoticons/sarcy.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/puppyeyes', 'EN', 'themes/default/images/ocf_emoticons/puppyeyes.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/nerd', 'EN', 'themes/default/images/ocf_emoticons/nerd.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/king', 'EN', 'themes/default/images/ocf_emoticons/king.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/birthday', 'EN', 'themes/default/images/ocf_emoticons/birthday.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/hippie', 'EN', 'themes/default/images/ocf_emoticons/hippie.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/ninja2', 'EN', 'themes/default/images/ocf_emoticons/ninja2.gif', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/none', 'EN', 'themes/default/images/ocf_emoticons/none.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('page/track_topic', 'EN', 'themes/default/images/EN/page/track_topic.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('page/mark_unread', 'EN', 'themes/default/images/EN/page/mark_unread.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('page/reply', 'EN', 'themes/default/images/EN/page/reply.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('pageitem/report_post', 'EN', 'themes/default/images/EN/pageitem/report_post.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('pageitem/punish', 'EN', 'themes/default/images/EN/pageitem/punish.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('pageitem/quote', 'EN', 'themes/default/images/EN/pageitem/quote.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('pageitem/whisper', 'EN', 'themes/default/images/EN/pageitem/whisper.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('pageitem/delete', 'EN', 'themes/default/images/EN/pageitem/delete.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('poll/poll_l', 'EN', 'themes/default/images/poll/poll_l.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('poll/poll_m', 'EN', 'themes/default/images/poll/poll_m.gif', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('poll/poll_r', 'EN', 'themes/default/images/poll/poll_r.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('bigicons/subscribers', 'EN', 'themes/default/images/bigicons/subscribers.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_topic_modifiers/involved', 'EN', 'themes/default/images/ocf_topic_modifiers/involved.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_topic_modifiers/unvalidated', 'EN', 'themes/default/images/ocf_topic_modifiers/unvalidated.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_topic_modifiers/poll', 'EN', 'themes/default/images/ocf_topic_modifiers/poll.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_topic_modifiers/announcement', 'EN', 'themes/default/images/ocf_topic_modifiers/announcement.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('pagepics/forums', 'EN', 'themes/default/images/pagepics/forums.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_topic_modifiers/unread', 'EN', 'themes/default/images/ocf_topic_modifiers/unread.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('pagepics/clubs', 'EN', 'themes/default/images/pagepics/clubs.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('page/invite_member', 'EN', 'themes/default/images/EN/page/invite_member.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('pagepics/deletelurkers', 'EN', 'themes/default/images/pagepics/deletelurkers.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('pagepics/mergemembers', 'EN', 'themes/default/images/pagepics/mergemembers.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('pagepics/import_csv', 'EN', 'themes/default/images/pagepics/import_csv.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('pagepics/config', 'EN', 'themes/default/images/pagepics/config.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('am_icons/warn', 'EN', 'themes/default/images/am_icons/warn.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/constipated', 'EN', 'themes/default/images/ocf_emoticons/constipated.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/upsidedown', 'EN', 'themes/default/images/ocf_emoticons/upsidedown.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/depressed', 'EN', 'themes/default/images/ocf_emoticons/depressed.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/christmas', 'EN', 'themes/default/images/ocf_emoticons/christmas.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/puppyeyes', 'EN', 'themes/default/images/ocf_emoticons/puppyeyes.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/rolleyes', 'EN', 'themes/default/images/ocf_emoticons/rolleyes.gif', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/birthday', 'EN', 'themes/default/images/ocf_emoticons/birthday.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/whistle', 'EN', 'themes/default/images/ocf_emoticons/whistle.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/rockon', 'EN', 'themes/default/images/ocf_emoticons/rockon.gif', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/hippie', 'EN', 'themes/default/images/ocf_emoticons/hippie.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/cyborg', 'EN', 'themes/default/images/ocf_emoticons/cyborg.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/ninja2', 'EN', 'themes/default/images/ocf_emoticons/ninja2.gif', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/sinner', 'EN', 'themes/default/images/ocf_emoticons/sinner.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/guitar', 'EN', 'themes/default/images/ocf_emoticons/guitar.gif', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/shutup', 'EN', 'themes/default/images/ocf_emoticons/shutup.gif', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/sarcy', 'EN', 'themes/default/images/ocf_emoticons/sarcy.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/devil', 'EN', 'themes/default/images/ocf_emoticons/devil.gif', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/drool', 'EN', 'themes/default/images/ocf_emoticons/drool.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/party', 'EN', 'themes/default/images/ocf_emoticons/party.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/shake', 'EN', 'themes/default/images/ocf_emoticons/shake.gif', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/king', 'EN', 'themes/default/images/ocf_emoticons/king.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/sick', 'EN', 'themes/default/images/ocf_emoticons/sick.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/nerd', 'EN', 'themes/default/images/ocf_emoticons/nerd.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/hand', 'EN', 'themes/default/images/ocf_emoticons/hand.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/zzz', 'EN', 'themes/default/images/ocf_emoticons/zzz.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/nod', 'EN', 'themes/default/images/ocf_emoticons/nod.gif', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/kiss', 'EN', 'themes/default/images/ocf_emoticons/kiss.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/glee', 'EN', 'themes/default/images/ocf_emoticons/glee.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/confused', 'EN', 'themes/default/images/ocf_emoticons/confused.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/angry', 'EN', 'themes/default/images/ocf_emoticons/angry.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_emoticons/grin', 'EN', 'themes/default/images/ocf_emoticons/grin.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('pageitem/goto', 'EN', 'themes/default/images/EN/pageitem/goto.png', 'default');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_topic_modifiers/pinned', 'EN', 'themes/default/images/ocf_topic_modifiers/pinned.png', '_unnamed_');
INSERT INTO `ocp_theme_images` (`id`, `lang`, `path`, `theme`) VALUES('ocf_topic_modifiers/sunk', 'EN', 'themes/default/images/ocf_topic_modifiers/sunk.png', '_unnamed_');

-- --------------------------------------------------------

--
-- Table structure for table `ocp_tickets`
--

DROP TABLE IF EXISTS `ocp_tickets`;
CREATE TABLE IF NOT EXISTS `ocp_tickets` (
  `forum_id` int(11) NOT NULL,
  `ticket_id` varchar(255) NOT NULL,
  `ticket_type` int(10) unsigned NOT NULL,
  `topic_id` int(11) NOT NULL,
  PRIMARY KEY (`ticket_id`)
) ENGINE=MyISAM;

--
-- Dumping data for table `ocp_tickets`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_ticket_types`
--

DROP TABLE IF EXISTS `ocp_ticket_types`;
CREATE TABLE IF NOT EXISTS `ocp_ticket_types` (
  `cache_lead_time` int(10) unsigned DEFAULT NULL,
  `guest_emails_mandatory` tinyint(1) NOT NULL,
  `search_faq` tinyint(1) NOT NULL,
  `send_sms_to` varchar(255) NOT NULL,
  `ticket_type` int(10) unsigned NOT NULL,
  PRIMARY KEY (`ticket_type`)
) ENGINE=MyISAM;

--
-- Dumping data for table `ocp_ticket_types`
--

INSERT INTO `ocp_ticket_types` (`cache_lead_time`, `guest_emails_mandatory`, `search_faq`, `send_sms_to`, `ticket_type`) VALUES(NULL, 0, 0, '', 395);
INSERT INTO `ocp_ticket_types` (`cache_lead_time`, `guest_emails_mandatory`, `search_faq`, `send_sms_to`, `ticket_type`) VALUES(NULL, 0, 0, '', 396);

-- --------------------------------------------------------

--
-- Table structure for table `ocp_trackbacks`
--

DROP TABLE IF EXISTS `ocp_trackbacks`;
CREATE TABLE IF NOT EXISTS `ocp_trackbacks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `trackback_excerpt` longtext NOT NULL,
  `trackback_for_id` varchar(80) NOT NULL,
  `trackback_for_type` varchar(80) NOT NULL,
  `trackback_ip` varchar(40) NOT NULL,
  `trackback_name` varchar(255) NOT NULL,
  `trackback_time` int(10) unsigned NOT NULL,
  `trackback_title` varchar(255) NOT NULL,
  `trackback_url` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 ;

--
-- Dumping data for table `ocp_trackbacks`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_tracking`
--

DROP TABLE IF EXISTS `ocp_tracking`;
CREATE TABLE IF NOT EXISTS `ocp_tracking` (
  `r_filter` longtext NOT NULL,
  `r_member_id` int(11) NOT NULL,
  `r_notify_email` tinyint(1) NOT NULL,
  `r_notify_sms` tinyint(1) NOT NULL,
  `r_resource_id` varchar(80) NOT NULL,
  `r_resource_type` varchar(80) NOT NULL,
  PRIMARY KEY (`r_member_id`,`r_resource_id`,`r_resource_type`)
) ENGINE=MyISAM;

--
-- Dumping data for table `ocp_tracking`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_transactions`
--

DROP TABLE IF EXISTS `ocp_transactions`;
CREATE TABLE IF NOT EXISTS `ocp_transactions` (
  `amount` varchar(255) NOT NULL,
  `id` varchar(80) NOT NULL,
  `item` varchar(255) NOT NULL,
  `linked` varchar(80) NOT NULL,
  `pending_reason` varchar(255) NOT NULL,
  `purchase_id` varchar(80) NOT NULL,
  `reason` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL,
  `t_currency` varchar(80) NOT NULL,
  `t_memo` longtext NOT NULL,
  `t_time` int(10) unsigned NOT NULL,
  `t_via` varchar(80) NOT NULL,
  PRIMARY KEY (`id`,`t_time`)
) ENGINE=MyISAM;

--
-- Dumping data for table `ocp_transactions`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_translate`
--

DROP TABLE IF EXISTS `ocp_translate`;
CREATE TABLE IF NOT EXISTS `ocp_translate` (
  `broken` tinyint(1) NOT NULL,
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `importance_level` tinyint(4) NOT NULL,
  `language` varchar(5) NOT NULL,
  `source_user` int(11) NOT NULL,
  `text_original` longtext NOT NULL,
  `text_parsed` longtext NOT NULL,
  PRIMARY KEY (`id`,`language`),
  FULLTEXT KEY `search` (`text_original`)
) ENGINE=MyISAM  AUTO_INCREMENT=1033 ;

--
-- Dumping data for table `ocp_translate`
--

INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 1, 1, 'EN', 2, 'Serving demo content to you!', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 2, 1, 'EN', 1, 'Admin Zone', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 3, 1, 'EN', 1, 'Collaboration Zone', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 4, 1, 'EN', 2, 'Serving demo content to you!', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 5, 1, 'EN', 1, 'Content Management', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 6, 1, 'EN', 1, 'Guides', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 7, 1, 'EN', 1, 'Welcome', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 8, 1, 'EN', 1, 'Admin Zone', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 9, 1, 'EN', 1, 'Site', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 10, 1, 'EN', 1, 'Collaboration Zone', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 11, 1, 'EN', 1, 'Content Management', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 12, 1, 'EN', 1, 'Forum', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 13, 1, 'EN', 1, 'Account', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 14, 1, 'EN', 1, 'Forums', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 15, 1, 'EN', 1, 'Account', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 16, 2, 'EN', 1, 'About me', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 17, 2, 'EN', 1, 'Some personally written information.', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 18, 2, 'EN', 1, 'AIM ID', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 19, 2, 'EN', 1, 'AIM username.', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 20, 2, 'EN', 1, 'MSN Messenger ID', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 21, 2, 'EN', 1, 'E-mail address of MSN Messenger account.', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 22, 2, 'EN', 1, 'Yahoo messenger ID', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 23, 2, 'EN', 1, 'Log in name of a Yahoo messenger account.', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 24, 2, 'EN', 1, 'Skype ID', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 25, 2, 'EN', 1, 'Skype username.', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 26, 2, 'EN', 1, 'Interests', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 27, 2, 'EN', 1, 'A summary of your interests.', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 28, 2, 'EN', 1, 'Location', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 29, 2, 'EN', 1, 'Your geographical location.', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 30, 2, 'EN', 1, 'Occupation', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 31, 2, 'EN', 1, 'This member''s occupation.', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 32, 2, 'EN', 1, 'Staff notes', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 33, 2, 'EN', 1, 'Notes on this member, only viewable by staff.', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 34, 2, 'EN', 1, 'Guests', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 35, 2, 'EN', 1, 'Guest user', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 36, 2, 'EN', 1, 'Administrators', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 37, 2, 'EN', 1, 'Site director', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 38, 2, 'EN', 1, 'Super-moderators', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 39, 2, 'EN', 1, 'Site staff', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 40, 2, 'EN', 1, 'Super-members', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 41, 2, 'EN', 1, 'Super-member', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 42, 2, 'EN', 1, 'Local hero', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 43, 2, 'EN', 1, 'Standard member', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 44, 2, 'EN', 1, 'Old timer', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 45, 2, 'EN', 1, 'Standard member', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 46, 2, 'EN', 1, 'Local', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 47, 2, 'EN', 1, 'Standard member', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 48, 2, 'EN', 1, 'Regular', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 49, 2, 'EN', 1, 'Standard member', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 50, 2, 'EN', 1, 'Newbie', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 51, 2, 'EN', 1, 'Standard member', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 52, 2, 'EN', 1, 'Probation', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 53, 2, 'EN', 1, 'Members will be considered to be in this usergroup (and only this usergroup) if and whilst they have been placed on probation. This usergroup behaves like any other, and therefore may also be manually placed into it.', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 54, 2, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 55, 3, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 58, 2, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 59, 3, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 60, 2, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 61, 3, 'EN', 2, 'You can specify passwords (or answers to questions) to act as forum-restrictions.\n\nHere, enter the password ''ocPortal'' below to gain access to the forum.', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 62, 2, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 63, 3, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 64, 2, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 65, 3, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 66, 2, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 67, 3, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 68, 2, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 69, 3, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 70, 2, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 71, 3, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 72, 3, 'EN', 1, 'Trash', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 73, 4, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 74, 4, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 75, 3, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 76, 3, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 77, 3, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 78, 4, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 79, 4, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 80, 3, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 81, 3, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 82, 3, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 83, 4, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 84, 4, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 85, 3, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 86, 3, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 87, 3, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 88, 4, 'EN', 1, 'This is the inbuilt forum system (known as OCF).\n\nA forum system is a tool for communication between members; it consists of posts, organised into topics: each topic is a line of conversation.\n\nThe website software provides support for a number of different forum systems, and each forum handles authentication of members: OCF is the built-in forum, which provides seamless integration between the main website, the forums, and the inbuilt member accounts system.', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 89, 2, 'EN', 1, 'ocp_mobile_phone_number', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 90, 2, 'EN', 1, 'This should be the mobile phone number in international format, devoid of any national or international outgoing access codes. For instance, a typical UK (44) number might be nationally known as ''01234 123456'', but internationally and without outgoing access codes would be ''441234123456''.', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 91, 2, 'EN', 1, 'Download of the week', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 92, 2, 'EN', 1, 'The best downloads in the download system, chosen every week.', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 93, 1, 'EN', 1, 'Front page', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 94, 1, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 95, 1, 'EN', 1, 'Rules', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 96, 1, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 98, 1, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 100, 1, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 102, 1, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 103, 1, 'EN', 1, 'Members', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 104, 1, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 105, 1, 'EN', 1, 'Usergroups', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 106, 1, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 107, 1, 'EN', 1, 'Donate', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 108, 1, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 109, 1, 'EN', 1, 'Join', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 110, 1, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 111, 1, 'EN', 1, 'Reset password', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 112, 1, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 113, 1, 'EN', 1, 'Front page', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 114, 1, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 115, 1, 'EN', 1, 'About', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 116, 1, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 117, 1, 'EN', 1, 'Get hosted by us!', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 118, 1, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 119, 1, 'EN', 1, 'View my author profile', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 120, 1, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 121, 1, 'EN', 1, 'Edit my author profile', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 122, 1, 'EN', 1, 'This link is a shortcut: the menu will change', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 123, 1, 'EN', 1, 'My Home', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 124, 1, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 125, 1, 'EN', 1, 'View member profile', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 126, 1, 'EN', 1, 'This link is a shortcut: the menu will change', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 127, 1, 'EN', 1, 'Edit profile', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 128, 1, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 129, 1, 'EN', 1, 'Edit avatar', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 130, 1, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 131, 1, 'EN', 1, 'Edit photo', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 132, 1, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 133, 1, 'EN', 1, 'Edit signature', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 134, 1, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 135, 1, 'EN', 1, 'Edit title', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 136, 1, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 137, 1, 'EN', 1, 'Privacy', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 138, 1, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 139, 1, 'EN', 1, 'Delete account', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 140, 1, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 141, 1, 'EN', 1, 'Rules', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 142, 1, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 143, 1, 'EN', 1, 'Members', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 144, 1, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 145, 1, 'EN', 1, 'View member profile', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 146, 1, 'EN', 1, 'This link is a shortcut: the menu will change', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 147, 1, 'EN', 1, 'Edit profile', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 148, 1, 'EN', 1, 'This link is a shortcut: the menu will change', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 149, 1, 'EN', 1, 'Edit avatar', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 150, 1, 'EN', 1, 'This link is a shortcut: the menu will change', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 151, 1, 'EN', 1, 'Edit photo', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 152, 1, 'EN', 1, 'This link is a shortcut: the menu will change', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 153, 1, 'EN', 1, 'Edit signature', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 154, 1, 'EN', 1, 'This link is a shortcut: the menu will change', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 155, 1, 'EN', 1, 'Edit title', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 156, 1, 'EN', 1, 'This link is a shortcut: the menu will change', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 157, 1, 'EN', 1, 'Site', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 158, 1, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 159, 1, 'EN', 1, 'Forums', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 160, 1, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 161, 1, 'EN', 1, 'Account', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 162, 1, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 163, 1, 'EN', 1, 'Collaboration Zone', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 164, 1, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 165, 1, 'EN', 1, 'Content Management', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 166, 1, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 167, 1, 'EN', 1, 'Admin Zone', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 168, 1, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 169, 2, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 170, 3, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 174, 2, 'EN', 1, '(System command)', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 175, 2, 'EN', 1, 'General', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 176, 2, 'EN', 1, 'Birthday', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 177, 2, 'EN', 1, 'Public holiday', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 178, 2, 'EN', 1, 'Vacation', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 179, 2, 'EN', 1, 'Appointment', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 180, 2, 'EN', 1, 'Task', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 181, 2, 'EN', 1, 'Anniversary', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 182, 1, 'EN', 1, 'Calendar', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 183, 1, 'EN', 1, 'This link is a shortcut: the menu will change', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 683, 3, 'EN', 2, 'The Open Source Initiative (OSI) is a non-profit corporation formed to educate about and advocate for the benefits of open source and to build bridges among different constituencies in the open-source community.', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 690, 2, 'EN', 2, 'open,source,initiative,www,opensource,org', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 688, 2, 'EN', 2, 'ocproducts', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 682, 3, 'EN', 2, 'Open Source Initiative', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 689, 2, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 674, 3, 'EN', 2, 'ocPortal', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 675, 3, 'EN', 2, 'ocPortal is a CMS (Content Management System) that allows you to create and manage your interactive and dynamic website from an easy to use administration interface. ocPortal is unique by the combination of a vast and diverse range of provided functionality, out-of-the-box usability, and an ability for unlimited customisation.', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 687, 2, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 686, 2, 'EN', 2, 'ocportal', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 678, 3, 'EN', 2, 'ocProducts', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 679, 3, 'EN', 2, 'ocProducts is the company behind ocPortal.', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 529, 1, 'EN', 2, 'Donate money', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 705, 2, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 704, 2, 'EN', 2, 'romeo,juliet', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 694, 2, 'EN', 2, 'works,shakespeare', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 695, 2, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 696, 2, 'EN', 2, 'Hamlet', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 697, 2, 'EN', 2, 'The Tragedy of Hamlet, Prince of Denmark, or more simply Hamlet, is a tragedy by William Shakespeare, believed to have been written between 1599 and 1601. The play, set in Denmark, recounts how Prince Hamlet exacts revenge on his uncle Claudius, who has murdered Hamlet''s father, the King, and then taken the throne and married Gertrude, Hamlet''s mother. The play vividly charts the course of real and feigned madness--from overwhelming grief to seething rage--and explores themes of treachery, revenge, incest, and moral corruption.', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 708, 2, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 707, 2, 'EN', 2, 'hamlet', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 700, 2, 'EN', 2, 'Romeo and Juliet', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 701, 2, 'EN', 2, 'Romeo and Juliet is a tragedy written early in the career of playwright William Shakespeare about two young "star-cross''d lovers" whose deaths ultimately unite their feuding families. It was among Shakespeare''s most popular plays during his lifetime and, along with Hamlet and Macbeth, is one of his most frequently performed plays. Today, the title characters are regarded as archetypal young lovers.\n', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 691, 2, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 692, 2, 'EN', 2, 'Works by Shakespeare', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 693, 2, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 220, 2, 'EN', 1, 'Links', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 221, 3, 'EN', 1, 'Warning: these sites are outside our control.', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 222, 1, 'EN', 1, 'Links', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 223, 3, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 224, 2, 'EN', 1, 'Title', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 225, 3, 'EN', 1, 'A concise line that entitles this.', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 226, 2, 'EN', 1, 'URL', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 227, 3, 'EN', 1, 'The entered text will be interpreted as a URL, and used as a hyperlink.', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 228, 2, 'EN', 1, 'Description', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 229, 3, 'EN', 1, 'A concise description for this.', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 706, 2, 'EN', 2, '[attachment thumb="1" type="inline" description=""]1[/attachment]', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 240, 2, 'EN', 1, 'Contacts', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 241, 3, 'EN', 1, 'A contacts/address-book.', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 242, 3, 'EN', 1, 'Forename', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 243, 2, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 244, 3, 'EN', 1, 'Surname', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 245, 2, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 246, 3, 'EN', 1, 'E-mail address', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 247, 2, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 248, 3, 'EN', 1, 'Company', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 249, 2, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 250, 3, 'EN', 1, 'Home address', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 251, 2, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 252, 3, 'EN', 1, 'City', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 253, 2, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 254, 3, 'EN', 1, 'Home phone number', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 255, 2, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 256, 3, 'EN', 1, 'Work phone number', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 257, 2, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 258, 3, 'EN', 1, 'Homepage', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 259, 2, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 260, 3, 'EN', 1, 'Instant messenger handle', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 261, 2, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 262, 3, 'EN', 1, 'Events relating to them', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 263, 2, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 264, 3, 'EN', 1, 'Notes', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 265, 2, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 266, 2, 'EN', 1, 'Contacts', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 267, 3, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 268, 1, 'EN', 1, 'Catalogues', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 269, 1, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 270, 1, 'EN', 1, 'Super-member projects', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 271, 1, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 272, 1, 'EN', 1, 'View', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 273, 1, 'EN', 1, 'This link is a shortcut: the menu will change', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 274, 1, 'EN', 1, 'Add', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 275, 1, 'EN', 1, 'This link is a shortcut: the menu will change', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 276, 2, 'EN', 1, 'Products', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 277, 2, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 278, 1, 'EN', 1, 'Home', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 279, 3, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 280, 3, 'EN', 1, 'Product title', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 281, 3, 'EN', 1, 'A concise line that entitles this.', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 282, 3, 'EN', 1, 'Product code', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 283, 3, 'EN', 1, 'The codename for the product', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 284, 3, 'EN', 1, 'Net price', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 285, 3, 'EN', 1, 'The price, before tax is added, in the primary currency of this website.', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 286, 3, 'EN', 1, 'Stock level', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 287, 3, 'EN', 1, 'The stock level of the product (leave blank if no stock counting is to be done).', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 288, 3, 'EN', 1, 'Stock level warn-threshold', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 289, 3, 'EN', 1, 'Send out an e-mail alert to the staff if the stock goes below this level (leave blank if no stock counting is to be done).', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 290, 3, 'EN', 1, 'Stock maintained', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 291, 3, 'EN', 1, 'Whether stock will be maintained. If the stock is not maintained then users will not be able to purchase it if the stock runs out.', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 292, 3, 'EN', 1, 'Product tax rate', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 293, 3, 'EN', 1, 'The tax rates that products can be assigned.', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 294, 3, 'EN', 1, 'Product image', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 295, 3, 'EN', 1, 'Upload an image of your product.', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 296, 3, 'EN', 1, 'Product weight', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 297, 3, 'EN', 1, 'The weight, in whatever units are assumed by the shipping costs programmed-in to this website.', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 298, 3, 'EN', 1, 'Product description', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 299, 3, 'EN', 1, 'A concise description for this.', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 300, 1, 'EN', 1, 'CEDI home', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 301, 2, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 302, 2, 'EN', 1, 'ocp_points_gained_seedy', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 303, 2, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 304, 1, 'EN', 1, 'CEDI', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 305, 1, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 306, 1, 'EN', 1, 'Random page', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 307, 1, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 308, 1, 'EN', 1, 'CEDI change-log', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 309, 1, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 310, 1, 'EN', 1, 'Tree', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 311, 1, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 312, 2, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 313, 2, 'EN', 1, 'ocp_points_gained_chat', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 314, 2, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 315, 1, 'EN', 1, 'Chat lobby', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 316, 1, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 317, 1, 'EN', 1, 'Chat lobby', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 318, 1, 'EN', 1, 'This link is a shortcut: the menu will change', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 319, 2, 'EN', 1, 'Downloads home', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 320, 3, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 321, 1, 'EN', 1, 'Downloads', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 322, 1, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 323, 1, 'EN', 1, 'Galleries', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 324, 1, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 325, 2, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 326, 2, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 327, 1, 'EN', 1, 'Galleries home', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 328, 2, 'EN', 1, 'galleries,home', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 329, 2, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 330, 2, 'EN', 1, 'General', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 331, 2, 'EN', 1, 'Technology', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 332, 2, 'EN', 1, 'Difficulties', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 333, 2, 'EN', 1, 'Community', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 334, 2, 'EN', 1, 'Entertainment', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 335, 2, 'EN', 1, 'Business', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 336, 2, 'EN', 1, 'Art', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 337, 1, 'EN', 1, 'Blog', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 338, 1, 'EN', 1, 'This link is a shortcut: the menu will change', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 339, 1, 'EN', 1, 'Newsletter', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 340, 1, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 341, 1, 'EN', 1, 'Newsletter', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 342, 1, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 343, 2, 'EN', 1, 'General', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 344, 2, 'EN', 1, 'General messages will be sent out in this newsletter.', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 345, 1, 'EN', 1, 'Points', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 346, 1, 'EN', 1, 'This link is a shortcut: the menu will change', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 347, 1, 'EN', 1, 'Points', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 348, 1, 'EN', 1, 'This link is a shortcut: the menu will change', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 349, 1, 'EN', 1, 'Point-store', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 350, 1, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 351, 2, 'EN', 1, 'ocp_currency', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 352, 2, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 353, 2, 'EN', 1, 'ocp_payment_cardholder_name', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 354, 2, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 355, 2, 'EN', 1, 'ocp_payment_type', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 356, 2, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 357, 2, 'EN', 1, 'ocp_payment_card_number', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 358, 2, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 359, 2, 'EN', 1, 'ocp_payment_card_start_date', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 360, 2, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 361, 2, 'EN', 1, 'ocp_payment_card_expiry_date', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 362, 2, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 363, 2, 'EN', 1, 'ocp_payment_card_issue_number', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 364, 2, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 365, 2, 'EN', 1, 'ocp_payment_card_cv2', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 366, 2, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 367, 1, 'EN', 1, 'Invoices', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 368, 1, 'EN', 1, 'This link is a shortcut: the menu will change', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 369, 1, 'EN', 1, 'Subscriptions', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 370, 1, 'EN', 1, 'This link is a shortcut: the menu will change', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 371, 1, 'EN', 1, 'Purchasing', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 372, 1, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 373, 1, 'EN', 1, 'Invoices', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 374, 1, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 375, 1, 'EN', 1, 'SUBSCRIPTIONS', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 376, 1, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 377, 1, 'EN', 1, 'Orders', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 378, 1, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 379, 2, 'EN', 1, 'ocp_firstname', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 380, 2, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 381, 2, 'EN', 1, 'ocp_lastname', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 382, 2, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 383, 2, 'EN', 1, 'ocp_building_name_or_number', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 384, 2, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 385, 2, 'EN', 1, 'ocp_city', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 386, 2, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 387, 2, 'EN', 1, 'ocp_state', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 388, 2, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 389, 2, 'EN', 1, 'ocp_post_code', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 390, 2, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 391, 2, 'EN', 1, 'ocp_country', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 392, 2, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 393, 1, 'EN', 1, 'Staff', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 394, 1, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 395, 1, 'EN', 1, 'Other', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 396, 1, 'EN', 1, 'Complaint', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 397, 1, 'EN', 1, 'Support tickets', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 398, 1, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 399, 1, 'EN', 1, 'Support tickets', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 400, 1, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 401, 1, 'EN', 1, 'Forum home', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 402, 1, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 403, 1, 'EN', 1, 'Personal topics', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 404, 1, 'EN', 1, 'This link is a shortcut: the menu will change', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 405, 1, 'EN', 1, 'Forum home', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 406, 1, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 407, 1, 'EN', 1, 'Personal topics', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 408, 1, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 409, 1, 'EN', 1, 'Posts since last visit', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 410, 1, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 411, 1, 'EN', 1, 'Topics with unread posts', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 412, 1, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 413, 1, 'EN', 1, 'Recently-read topics', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 414, 1, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 415, 1, 'EN', 1, 'Search', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 416, 1, 'EN', 1, 'This link is a shortcut: the menu will change', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 984, 1, 'EN', 2, 'ocPortal&#039;s different menu-types', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 418, 1, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 419, 1, 'EN', 1, 'Recommend site', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 420, 1, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 421, 1, 'EN', 1, 'File-dump', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 422, 1, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 423, 1, 'EN', 1, 'Super-members', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 424, 1, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 425, 2, 'EN', 1, 'ocp_points_used', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 426, 2, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 427, 2, 'EN', 1, 'ocp_gift_points_used', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 428, 2, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 429, 2, 'EN', 1, 'ocp_points_gained_given', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 430, 2, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 431, 2, 'EN', 1, 'ocp_points_gained_rating', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 432, 2, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 433, 2, 'EN', 1, 'ocp_points_gained_voting', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 434, 2, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 435, 2, 'EN', 1, 'ocp_sites', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 436, 2, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 437, 2, 'EN', 1, 'ocp_role', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 438, 2, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 439, 2, 'EN', 1, 'ocp_fullname', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 440, 2, 'EN', 1, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 442, 1, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 443, 1, 'EN', 2, '[block="root_website" type="tree" caption="Web site"]side_stored_menu[/block]\n[block failsafe="1"]side_users_online[/block]\n[block failsafe="1"]side_stats[/block]\n[block]side_personal_stats[/block]', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 444, 1, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 445, 1, 'EN', 2, '[title="1"]Welcome to {$SITE_NAME}[/title]\n\n[block]main_greeting[/block]\n\n\n[semihtml]\n<div class="float_surrounder">\n<div style="width: 48%; float: left">[block]main_awards[/block]</div>\n<div style="width: 48%; float: right">[block failsafe="1"]main_iotd[/block]</div>\n</div>\n[/semihtml]\n\n[block="14" failsafe="1"]main_news[/block]\n\n[block="quotes" failsafe="1"]main_quotes[/block]\n\n[block failsafe="1"]main_forum_topics[/block]\n\n[block="5" failsafe="1"]main_top_downloads[/block]\n\n[block="5" failsafe="1"]main_recent_downloads[/block]\n\n[block="5" failsafe="1"]main_top_galleries[/block]\n\n[block="5" failsafe="1"]main_gallery_embed[/block]\n\n[block]main_comcode_page_children[/block]', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 446, 1, 'EN', 2, 'Welcome to (unnamed)', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 946, 1, 'EN', 2, 'Child page', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 449, 1, 'EN', 2, 'Admin Zone', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 451, 1, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 948, 1, 'EN', 2, 'Member section of ocPortal demo', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 949, 4, 'EN', 2, 'This post is emphasised.', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 549, 1, 'EN', 2, 'Admin Zone', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 951, 1, 'EN', 2, 'Featured content', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 960, 1, 'EN', 2, 'ocPortal&#039;s different menu-types', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 962, 1, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 964, 1, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 966, 1, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 968, 1, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 970, 1, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 972, 1, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 974, 1, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 976, 1, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 978, 1, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 980, 1, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 547, 1, 'EN', 2, 'Example banners', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 541, 1, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 543, 1, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 986, 1, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 545, 1, 'EN', 2, '(unnamed) Site-Map', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 539, 1, 'EN', 2, 'Welcome to (unnamed)', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 466, 1, 'EN', 2, 'Serving demo content to you!', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 467, 1, 'EN', 2, 'demoing', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 468, 1, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 469, 1, 'EN', 2, 'This is an ocPortal demo.\n\nLog in using the details you put in when you set up the demo, or if this is the shared demo use the username ''admin'' and the password ''demo123''.', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 537, 1, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 592, 1, 'EN', 2, 'Welcome to (unnamed)', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 593, 4, 'EN', 2, 'Add Comcode page', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 952, 2, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 953, 2, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 955, 1, 'EN', 2, 'Featured content', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 956, 4, 'EN', 2, 'Add Comcode page', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 991, 2, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 992, 2, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 479, 1, 'EN', 2, 'Welcome to (unnamed)', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 471, 1, 'EN', 2, 'Welcome to (unnamed)', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 988, 1, 'EN', 2, 'Welcome to ocPortal demo', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 473, 1, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 990, 1, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 994, 1, 'EN', 2, 'ocPortal&#039;s different menu-types', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 995, 1, 'EN', 2, 'Content examples', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 996, 1, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 997, 1, 'EN', 2, 'Menus', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 998, 1, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 999, 1, 'EN', 2, 'Rich content', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 1000, 1, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 1001, 1, 'EN', 2, 'Rules', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 1002, 1, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 1003, 1, 'EN', 2, 'Site map', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 1004, 1, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 1005, 1, 'EN', 2, 'Feedback', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 1006, 1, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 1007, 1, 'EN', 2, 'Downloads', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 1008, 1, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 1009, 1, 'EN', 2, 'CEDI', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 1010, 1, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 1011, 1, 'EN', 2, 'Galleries', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 1012, 1, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 1013, 1, 'EN', 2, 'Forums', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 1014, 1, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 481, 1, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 483, 1, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 484, 1, 'EN', 2, 'What type of books do you prefer?', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 485, 1, 'EN', 2, 'Hardbacks', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 486, 1, 'EN', 2, 'Paperbacks', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 487, 1, 'EN', 2, 'eBooks', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 488, 1, 'EN', 2, 'Audio books', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 489, 1, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 490, 1, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 491, 1, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 492, 1, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 493, 1, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 494, 1, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 495, 4, 'EN', 2, 'Poll', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 496, 4, 'EN', 2, 'Add poll', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 866, 4, 'EN', 2, 'Pinned topics are always displayed at the top of a forum; highlighting them.', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 475, 1, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 532, 1, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 533, 4, 'EN', 2, 'Add Comcode page', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 586, 2, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 585, 2, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 477, 1, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 522, 1, 'EN', 2, 'Admin Zone', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 524, 1, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 525, 2, 'EN', 2, 'This is an example banner.', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 527, 1, 'EN', 2, '404 Not Found', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 498, 1, 'EN', 2, 'Help', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 517, 1, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 519, 1, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 500, 1, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 502, 1, 'EN', 2, 'Guestbook', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 511, 1, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 513, 1, 'EN', 2, 'Welcome to (unnamed)', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 515, 1, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 504, 1, 'EN', 2, 'Admin Zone', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 506, 1, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 507, 1, 'EN', 2, '<p>\n	We wish our comments system to be a polite and helpful area for our visitors, so please stick to our rules\n</p>\n\n<ul>\n	<li>No flaming or profanity</li>\n	<li>No unpleasant rivalry</li>\n	<li>Use the forums for general questions</li>\n	<li>No spamming</li>\n	<li>No incitement to illegality</li>\n</ul>\n\n', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 508, 1, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 509, 1, 'EN', 2, 'You are starting a new support ticket.\n\nThe support ticket system allows you to post private support requests to our support staff. Please do not place multiple unrelated questions in a single support ticket - you can open as many as you like, and we''ll be able to respond faster to individual tickets. Please include any details that will be necessary for us to solve your problem, such as system information, URLs, sample data, or any pertinent passwords we would need.\n\nWe will respond as quickly as possible.', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 568, 1, 'EN', 2, 'Edit quotes', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 915, 1, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 1026, 1, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 902, 1, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 900, 1, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 588, 1, 'EN', 2, 'Banners', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 916, 2, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 917, 2, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 919, 1, 'EN', 2, 'Welcome to ocPortal demo', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 597, 1, 'EN', 2, 'Featured content', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 601, 1, 'EN', 2, 'Featured content', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 602, 2, 'EN', 2, 'Works', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 603, 2, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 606, 2, 'EN', 2, 'Shakespeare, William', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 607, 2, 'EN', 2, 'Works by William Shakespeare.', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 608, 2, 'EN', 2, 'shakespeare,william,works', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 609, 2, 'EN', 2, 'Works by William Shakespeare.', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 612, 2, 'EN', 2, 'books', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 613, 2, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 614, 2, 'EN', 2, 'Romeo and Juliet', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 615, 3, 'EN', 2, '[align="center"][b]ROMEO AND JULIET[/b]\nby William Shakespeare[/align]\n\n[title="2"]Persons represented[/title]\n\n - Escalus, Prince of Verona.\n - Paris, a young Nobleman, kinsman to the Prince.\n - Montague & Capulet, Heads of two Houses at variance with each other.\n - An Old Man, Uncle to Capulet.\n - Romeo, Son to Montague.\n - Mercutio, Kinsman to the Prince, and Friend to Romeo.\n - Benvolio, Nephew to Montague, and Friend to Romeo.\n - Tybalt, Nephew to Lady Capulet.\n - Friar Lawrence, a Franciscan.\n - Friar John, of the same Order.\n - Balthasar, Servant to Romeo.\n - Sampson, Servant to Capulet.\n - Gregory, Servant to Capulet.\n - Peter, Servant to Juliet''s Nurse.\n - Abraham, Servant to Montague.\n - An Apothecary.\n - Three Musicians.\n - Chorus.\n - Page to Paris; another Page.\n - An Officer.\n\n - Lady Montague, Wife to Montague.\n - Lady Capulet, Wife to Capulet.\n - Juliet, Daughter to Capulet.\n - Nurse to Juliet.\n\n - Citizens of Verona\n  - Several Men and Women, relations to both houses\n  - Maskers\n  - Guards\n  - Watchmen\n  - Attendants.\n\n[title="2"]Scene[/title]During the greater part of the Play in Verona; once, in\nthe Fifth Act, at Mantua.', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 616, 3, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 786, 2, 'EN', 2, 'romeo,juliet,align,center,william,shakespeare,title,persons,represented,escalus,prince,verona,paris,young,nobleman,kinsman,montague,capulet,heads,houses,variance,old,man,uncle,son,mercutio,friend,benvolio,nephew,tybalt,lady,friar,lawrence,franciscan,john,', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 787, 2, 'EN', 2, '[align="center"][b]ROMEO AND JULIET[/b] by William Shakespeare[/align]  [title="2"]Persons represented[/title]	- Escalus, Prince of Verona.  - Paris, a young Nobleman, kinsman to the Prince.  - Montague & Capulet, Heads of two Houses at variance with ea', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 619, 2, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 620, 2, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 621, 1, 'EN', 2, 'Gallery for Romeo and Juliet download', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 622, 2, 'EN', 2, 'gallery,romeo,juliet,download', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 623, 2, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 624, 4, 'EN', 2, 'Add a new download', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 628, 1, 'EN', 2, 'Featured content', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 629, 2, 'EN', 2, 'William Shakespeare', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 630, 2, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 631, 4, 'EN', 2, 'Image of the day', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 632, 4, 'EN', 2, 'Add image of the day', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 636, 1, 'EN', 2, 'Featured content', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 640, 1, 'EN', 2, 'Featured content', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 1028, 1, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 652, 3, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 653, 2, 'EN', 2, 'Works by William Shakespeare', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 654, 3, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 655, 2, 'EN', 2, 'Works by William Shakespeare', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 656, 3, 'EN', 2, 'Romeo and Juliet', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 657, 3, 'EN', 2, 'Shakespeare''s classic tragic-romance play, in manuscript format.', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 660, 2, 'EN', 2, 'romeo,juliet,uploads,catalogues,brown,jpg,delightful', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 661, 2, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 662, 3, 'EN', 2, 'Hamlet', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 663, 3, 'EN', 2, 'The Prince of Denmark''s story is told in this epic Shakespearean play.', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 664, 2, 'EN', 2, 'hamlet,uploads,catalogues,edwin,booth,jpg,prince,denmarks,story,told,epic,shakespearean,play', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 665, 2, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 666, 4, 'EN', 2, 'Add catalogue entry', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 672, 2, 'EN', 2, 'barack,obama,barry,whitehouse,gov,executive,office,president,united,states,america,white,house,pennsylvania,avenue,washington,msn,state,union,inauguration', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 669, 4, 'EN', 2, 'Add catalogue entry', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 670, 2, 'EN', 2, 'gordon,brown,number,gov,majestys,government,downing,street,london,www,aol,queens,speech,prime,minister,united,kingdom,great,britain,northern,ireland', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 671, 2, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 673, 2, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 709, 2, 'EN', 2, '[attachment thumb="1" type="inline" description=""]2[/attachment]', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 710, 2, 'EN', 2, 'Meeting', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 711, 3, 'EN', 2, 'Meeting with world leaders on how to effectively deploy ocPortal.', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 712, 2, 'EN', 2, 'meeting,world,leaders,effectively,deploy,ocportal', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 713, 2, 'EN', 2, 'Meeting with world leaders on how to effectively deploy ocPortal.', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 714, 1, 'EN', 2, 'This is the first news article.', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 715, 1, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 716, 2, 'EN', 2, 'This is the first news article in this demonstration.\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed a lacus augue. Quisque luctus erat in sem placerat id facilisis lectus pharetra. Fusce ut dolor turpis, vitae lobortis sapien. In a metus quis eros adipiscing adipiscing non id quam. Aenean sapien leo, feugiat ut consectetur at, blandit nec felis. Duis eu urna nisi. Cras erat libero, lobortis cursus dignissim ut, interdum quis nibh. Integer feugiat mollis libero non aliquet. Proin quis libero quis tellus iaculis varius. Ut suscipit volutpat lorem, quis facilisis elit malesuada vel. Phasellus convallis tincidunt ante in porttitor. Phasellus elementum egestas quam, non laoreet eros euismod quis. Sed vel urna vitae leo gravida ullamcorper.\n\nNunc vitae suscipit elit. Nam porttitor pulvinar purus, id semper lacus fringilla non. Praesent a gravida urna. Curabitur nec ipsum risus, ultrices congue dui. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Sed commodo fermentum elit quis dignissim. Pellentesque ac consequat ante. Sed rutrum imperdiet interdum. Quisque tincidunt semper euismod. Sed sodales molestie arcu eget mattis. Aenean nunc urna, mattis viverra condimentum sit amet, eleifend nec nulla. Suspendisse congue dui sed turpis egestas quis faucibus nulla tempor. Praesent dapibus ligula ut odio congue nec fringilla ante faucibus. Sed odio augue, hendrerit ut egestas vitae, imperdiet a eros. Sed et dui massa. Morbi sed mi vel augue tempus sollicitudin quis at justo. Sed ullamcorper nulla eu nunc tincidunt auctor. Suspendisse potenti.\n\nSed porta sem et est dictum venenatis. Fusce in augue felis. Maecenas ipsum lorem, fermentum id adipiscing sed, sollicitudin id leo. Morbi magna ligula, dapibus vulputate pharetra sed, accumsan vulputate est. Mauris dictum sapien vestibulum sapien pellentesque interdum. Ut sollicitudin, metus ut mattis dignissim, sapien est dapibus sapien, ut gravida tortor neque eget leo. Sed tincidunt laoreet dui, nec luctus metus egestas eget. Integer elit est, tincidunt sit amet vehicula vel, tristique sit amet dui. Donec sed ipsum sed nisi iaculis fermentum. Fusce magna tellus, iaculis vel commodo ut, iaculis tincidunt magna. Phasellus tempor urna ut nisi elementum semper. In bibendum, quam a iaculis pellentesque, lorem ante commodo orci, id dignissim ante enim semper risus. Maecenas at orci a nunc rhoncus pellentesque eget ac sapien.\n\nCurabitur tortor purus, bibendum sed lacinia sit amet, dictum sit amet nibh. Donec sit amet mi vitae urna vehicula condimentum a vitae lectus. Nulla id feugiat enim. Sed porta lacinia tempor. Aenean porta nunc ut enim sagittis congue. Vivamus rutrum nunc eget urna pulvinar sagittis. Etiam commodo arcu in risus dictum ultricies. Quisque purus velit, cursus eu ullamcorper at, tincidunt et ante. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec sem nisl, dignissim quis pulvinar ac, commodo a nibh. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Mauris ac justo vel leo consequat suscipit nec quis augue. Fusce porttitor, neque vel lacinia vestibulum, purus nunc faucibus velit, tempus dapibus ante dolor vel nulla. Curabitur at neque metus, id condimentum mauris. In nibh sapien, porta et elementum vel, facilisis sit amet arcu. Maecenas vel sapien quis enim placerat accumsan sit amet non justo. Integer consectetur, enim et pharetra auctor, quam magna iaculis tortor, nec congue ligula enim ac ligula. Nunc scelerisque porttitor arcu mollis convallis.\n\nDonec fringilla nulla sit amet orci molestie in vestibulum mauris mollis. Pellentesque et diam arcu. Curabitur tempor varius lectus eget condimentum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Praesent sed ligula quis odio fermentum euismod ac a mi. Donec sed sapien odio, in sodales augue. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer sit amet nunc turpis. In scelerisque dictum urna ut porttitor. Fusce quis sapien metus. Proin a mauris magna, sed vestibulum mauris. Sed ipsum tellus, bibendum at egestas a, molestie nec nisl. Suspendisse tristique vestibulum vehicula. Integer pellentesque pretium lobortis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Maecenas vel lacus tincidunt enim volutpat lobortis. Quisque a risus non orci porta ultricies. Donec congue lacinia lacinia.', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 717, 2, 'EN', 2, 'first,news,article', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 718, 2, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 719, 4, 'EN', 2, 'Add news', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 720, 1, 'EN', 2, 'This is the second news article.', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 721, 1, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 722, 2, 'EN', 2, 'This is the second news article in this demonstration.\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed a lacus augue. Quisque luctus erat in sem placerat id facilisis lectus pharetra. Fusce ut dolor turpis, vitae lobortis sapien. In a metus quis eros adipiscing adipiscing non id quam. Aenean sapien leo, feugiat ut consectetur at, blandit nec felis. Duis eu urna nisi. Cras erat libero, lobortis cursus dignissim ut, interdum quis nibh. Integer feugiat mollis libero non aliquet. Proin quis libero quis tellus iaculis varius. Ut suscipit volutpat lorem, quis facilisis elit malesuada vel. Phasellus convallis tincidunt ante in porttitor. Phasellus elementum egestas quam, non laoreet eros euismod quis. Sed vel urna vitae leo gravida ullamcorper.\n\nNunc vitae suscipit elit. Nam porttitor pulvinar purus, id semper lacus fringilla non. Praesent a gravida urna. Curabitur nec ipsum risus, ultrices congue dui. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Sed commodo fermentum elit quis dignissim. Pellentesque ac consequat ante. Sed rutrum imperdiet interdum. Quisque tincidunt semper euismod. Sed sodales molestie arcu eget mattis. Aenean nunc urna, mattis viverra condimentum sit amet, eleifend nec nulla. Suspendisse congue dui sed turpis egestas quis faucibus nulla tempor. Praesent dapibus ligula ut odio congue nec fringilla ante faucibus. Sed odio augue, hendrerit ut egestas vitae, imperdiet a eros. Sed et dui massa. Morbi sed mi vel augue tempus sollicitudin quis at justo. Sed ullamcorper nulla eu nunc tincidunt auctor. Suspendisse potenti.\n\nSed porta sem et est dictum venenatis. Fusce in augue felis. Maecenas ipsum lorem, fermentum id adipiscing sed, sollicitudin id leo. Morbi magna ligula, dapibus vulputate pharetra sed, accumsan vulputate est. Mauris dictum sapien vestibulum sapien pellentesque interdum. Ut sollicitudin, metus ut mattis dignissim, sapien est dapibus sapien, ut gravida tortor neque eget leo. Sed tincidunt laoreet dui, nec luctus metus egestas eget. Integer elit est, tincidunt sit amet vehicula vel, tristique sit amet dui. Donec sed ipsum sed nisi iaculis fermentum. Fusce magna tellus, iaculis vel commodo ut, iaculis tincidunt magna. Phasellus tempor urna ut nisi elementum semper. In bibendum, quam a iaculis pellentesque, lorem ante commodo orci, id dignissim ante enim semper risus. Maecenas at orci a nunc rhoncus pellentesque eget ac sapien.\n\nCurabitur tortor purus, bibendum sed lacinia sit amet, dictum sit amet nibh. Donec sit amet mi vitae urna vehicula condimentum a vitae lectus. Nulla id feugiat enim. Sed porta lacinia tempor. Aenean porta nunc ut enim sagittis congue. Vivamus rutrum nunc eget urna pulvinar sagittis. Etiam commodo arcu in risus dictum ultricies. Quisque purus velit, cursus eu ullamcorper at, tincidunt et ante. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec sem nisl, dignissim quis pulvinar ac, commodo a nibh. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Mauris ac justo vel leo consequat suscipit nec quis augue. Fusce porttitor, neque vel lacinia vestibulum, purus nunc faucibus velit, tempus dapibus ante dolor vel nulla. Curabitur at neque metus, id condimentum mauris. In nibh sapien, porta et elementum vel, facilisis sit amet arcu. Maecenas vel sapien quis enim placerat accumsan sit amet non justo. Integer consectetur, enim et pharetra auctor, quam magna iaculis tortor, nec congue ligula enim ac ligula. Nunc scelerisque porttitor arcu mollis convallis.\n\nDonec fringilla nulla sit amet orci molestie in vestibulum mauris mollis. Pellentesque et diam arcu. Curabitur tempor varius lectus eget condimentum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Praesent sed ligula quis odio fermentum euismod ac a mi. Donec sed sapien odio, in sodales augue. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer sit amet nunc turpis. In scelerisque dictum urna ut porttitor. Fusce quis sapien metus. Proin a mauris magna, sed vestibulum mauris. Sed ipsum tellus, bibendum at egestas a, molestie nec nisl. Suspendisse tristique vestibulum vehicula. Integer pellentesque pretium lobortis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Maecenas vel lacus tincidunt enim volutpat lobortis. Quisque a risus non orci porta ultricies. Donec congue lacinia lacinia.', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 723, 2, 'EN', 2, 'second,news,article', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 724, 2, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 725, 4, 'EN', 2, 'Add news', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 726, 2, 'EN', 2, 'Romeo and Juliet', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 727, 2, 'EN', 2, 'This quiz will test your knowledge of Shakespeare''s Romeo and Juliet.', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 728, 2, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 729, 2, 'EN', 2, 'Does Romeo love Juliet at the beginning of the play?', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 730, 2, 'EN', 2, 'Yes', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 731, 2, 'EN', 2, 'No', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 732, 2, 'EN', 2, 'Where is the play set?', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 733, 2, 'EN', 2, 'London', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 734, 2, 'EN', 2, 'Verona', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 735, 2, 'EN', 2, 'Bankok', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 736, 2, 'EN', 2, 'Who does Tybalt fight in place of Romeo?', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 737, 2, 'EN', 2, 'Mercutio', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 738, 2, 'EN', 2, 'Benvolio', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 739, 2, 'EN', 2, 'Juliet', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 740, 2, 'EN', 2, 'Which scene is the play''s most famous?', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 741, 2, 'EN', 2, 'Banquet scene', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 742, 2, 'EN', 2, 'Balcony scene', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 743, 2, 'EN', 2, 'Space scene', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 744, 2, 'EN', 2, 'Who marries the couple?', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 745, 2, 'EN', 2, 'Friar Martin', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 746, 2, 'EN', 2, 'Friar Lawrence', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 747, 2, 'EN', 2, 'Friar Tuck', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 748, 2, 'EN', 2, 'romeo,juliet,quiz,knowledge,shakespeares', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 749, 2, 'EN', 2, 'This quiz will test your knowledge of Shakespeare''s Romeo and Juliet.', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 884, 1, 'EN', 2, 'Admin Zone', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 751, 2, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 752, 2, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 753, 1, 'EN', 2, 'Romeo and Juliet', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 754, 2, 'EN', 2, 'romeo,juliet', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 755, 2, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 756, 3, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 757, 2, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 758, 2, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 759, 4, 'EN', 2, 'Add image', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 760, 3, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 761, 2, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 762, 2, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 763, 4, 'EN', 2, 'Add image', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 764, 2, 'EN', 2, 'Hamlet', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 765, 3, 'EN', 2, 'The Tragedy of Hamlet, Prince of Denmark, or more simply Hamlet, is a tragedy by William Shakespeare, believed to have been written between 1599 and 1601.', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 766, 3, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 767, 2, 'EN', 2, 'hamlet,tragedy,prince,denmark,simply,william,shakespeare,believed,written,between', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 768, 2, 'EN', 2, 'The Tragedy of Hamlet, Prince of Denmark, or more simply Hamlet, is a tragedy by William Shakespeare, believed to have been written between 1599 and 1601.', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 769, 2, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 770, 2, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 771, 1, 'EN', 2, 'Gallery for Hamlet download', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 772, 2, 'EN', 2, 'gallery,hamlet,download', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 773, 2, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 774, 4, 'EN', 2, 'Add a new download', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 775, 4, 'EN', 2, 'Add Comcode page', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 776, 2, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 777, 2, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 779, 1, 'EN', 2, 'Comcode page support', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 780, 4, 'EN', 2, 'Add Comcode page', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 781, 2, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 782, 2, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 784, 1, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 785, 4, 'EN', 2, 'Gamble', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 795, 4, 'EN', 2, 'Add Comcode page', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 1019, 2, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 1022, 1, 'EN', 2, 'Rich media and presentation support', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 879, 1, 'EN', 2, 'Rich media and presentation support', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 881, 1, 'EN', 2, '404 Not Found', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 803, 1, 'EN', 2, 'Rich media and presentation support', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 805, 1, 'EN', 2, 'Rich media and presentation support', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 1020, 2, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 809, 1, 'EN', 2, 'Rich media and presentation support', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 799, 1, 'EN', 2, 'Rich media and presentation support', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 877, 1, 'EN', 2, 'Child page', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 1024, 1, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 1018, 1, 'EN', 2, 'Rich media and presentation support', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 873, 1, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 875, 1, 'EN', 2, 'Comcode page support', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 871, 1, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 869, 1, 'EN', 2, 'Welcome to (unnamed)', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 921, 1, 'EN', 2, 'Welcome to ocPortal demo', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 867, 4, 'EN', 2, 'Sunk topics are buried lower in a forum; removing them from priority.', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 862, 1, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 864, 1, 'EN', 2, '', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 865, 4, 'EN', 2, 'This is a reported post for a post in the topic [post param="Here is a topic with a poll."]4[/post], by [page type="view" id="2" param="site" caption="admin"]members[/page]\n\n[quote="admin"]\nPlease vote!\n[/quote]\n\n/// PUT YOUR REPORT BELOW \\\\\n\nThis is a reported post. Users may report posts that require the attention of a staff member. Report posts are filed in a specific forum.', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 853, 4, 'EN', 2, 'Posts in a topic have full Comcode support, too!', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 854, 4, 'EN', 2, 'Here is a reply.', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 855, 4, 'EN', 2, 'Please vote!', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 856, 4, 'EN', 2, 'Members can use the whisper feature...', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 857, 4, 'EN', 2, '...to create an in-line personal post to a certain member (in this case, Guests)!', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 858, 4, 'EN', 2, 'Only the intended recipient (and members of the website staff) are able to see whispered posts.', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 859, 4, 'EN', 2, 'When a topic is placed in the forum root and marked as ''cascading'', it will act as an announcement and appear in every subforum!', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 860, 4, 'EN', 2, 'This is a personal topic, between two users.', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 1030, 1, 'EN', 2, 'Welcome to ocPortal demo', '');
INSERT INTO `ocp_translate` (`broken`, `id`, `importance_level`, `language`, `source_user`, `text_original`, `text_parsed`) VALUES(0, 1032, 1, 'EN', 2, 'ocPortal&#039;s different menu-types', '');

-- --------------------------------------------------------

--
-- Table structure for table `ocp_translate_history`
--

DROP TABLE IF EXISTS `ocp_translate_history`;
CREATE TABLE IF NOT EXISTS `ocp_translate_history` (
  `action_member` int(11) NOT NULL,
  `action_time` int(10) unsigned NOT NULL,
  `broken` tinyint(1) NOT NULL,
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `language` varchar(5) NOT NULL,
  `lang_id` int(11) NOT NULL,
  `text_original` longtext NOT NULL,
  PRIMARY KEY (`id`,`language`)
) ENGINE=MyISAM  AUTO_INCREMENT=3 ;

--
-- Dumping data for table `ocp_translate_history`
--

INSERT INTO `ocp_translate_history` (`action_member`, `action_time`, `broken`, `id`, `language`, `lang_id`, `text_original`) VALUES(2, 1264682250, 0, 1, 'EN', 701, '');
INSERT INTO `ocp_translate_history` (`action_member`, `action_time`, `broken`, `id`, `language`, `lang_id`, `text_original`) VALUES(2, 1264682414, 0, 2, 'EN', 697, '');

-- --------------------------------------------------------

--
-- Table structure for table `ocp_trans_expecting`
--

DROP TABLE IF EXISTS `ocp_trans_expecting`;
CREATE TABLE IF NOT EXISTS `ocp_trans_expecting` (
  `e_amount` varchar(255) NOT NULL,
  `e_ip_address` varchar(40) NOT NULL,
  `e_item_name` varchar(255) NOT NULL,
  `e_length` int(11) DEFAULT NULL,
  `e_length_units` varchar(80) NOT NULL,
  `e_member_id` int(11) NOT NULL,
  `e_purchase_id` varchar(80) NOT NULL,
  `e_session_id` int(11) NOT NULL,
  `e_time` int(10) unsigned NOT NULL,
  `id` varchar(80) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM;

--
-- Dumping data for table `ocp_trans_expecting`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_tutorial_links`
--

DROP TABLE IF EXISTS `ocp_tutorial_links`;
CREATE TABLE IF NOT EXISTS `ocp_tutorial_links` (
  `the_name` varchar(80) NOT NULL,
  `the_value` longtext NOT NULL,
  PRIMARY KEY (`the_name`)
) ENGINE=MyISAM;

--
-- Dumping data for table `ocp_tutorial_links`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_url_id_monikers`
--

DROP TABLE IF EXISTS `ocp_url_id_monikers`;
CREATE TABLE IF NOT EXISTS `ocp_url_id_monikers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `m_deprecated` tinyint(1) NOT NULL,
  `m_moniker` varchar(255) NOT NULL,
  `m_resource_id` varchar(80) NOT NULL,
  `m_resource_page` varchar(80) NOT NULL,
  `m_resource_type` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `uim_moniker` (`m_moniker`),
  KEY `uim_pagelink` (`m_resource_page`,`m_resource_type`,`m_resource_id`)
) ENGINE=MyISAM  AUTO_INCREMENT=58 ;

--
-- Dumping data for table `ocp_url_id_monikers`
--

INSERT INTO `ocp_url_id_monikers` (`id`, `m_deprecated`, `m_moniker`, `m_resource_id`, `m_resource_page`, `m_resource_type`) VALUES(1, 0, 'admin', '2', 'members', 'view');
INSERT INTO `ocp_url_id_monikers` (`id`, `m_deprecated`, `m_moniker`, `m_resource_id`, `m_resource_page`, `m_resource_type`) VALUES(2, 0, 'test', '3', 'members', 'view');
INSERT INTO `ocp_url_id_monikers` (`id`, `m_deprecated`, `m_moniker`, `m_resource_id`, `m_resource_page`, `m_resource_type`) VALUES(3, 0, 'links', '3', 'catalogues', 'category');
INSERT INTO `ocp_url_id_monikers` (`id`, `m_deprecated`, `m_moniker`, `m_resource_id`, `m_resource_page`, `m_resource_type`) VALUES(4, 0, 'home', '6', 'catalogues', 'category');
INSERT INTO `ocp_url_id_monikers` (`id`, `m_deprecated`, `m_moniker`, `m_resource_id`, `m_resource_page`, `m_resource_type`) VALUES(5, 0, 'what_type_of_books_do', '1', 'polls', 'view');
INSERT INTO `ocp_url_id_monikers` (`id`, `m_deprecated`, `m_moniker`, `m_resource_id`, `m_resource_page`, `m_resource_type`) VALUES(6, 0, 'news', '2', 'forumview', 'misc');
INSERT INTO `ocp_url_id_monikers` (`id`, `m_deprecated`, `m_moniker`, `m_resource_id`, `m_resource_page`, `m_resource_type`) VALUES(7, 0, 'general_chat', '3', 'forumview', 'misc');
INSERT INTO `ocp_url_id_monikers` (`id`, `m_deprecated`, `m_moniker`, `m_resource_id`, `m_resource_page`, `m_resource_type`) VALUES(8, 0, 'feedback', '4', 'forumview', 'misc');
INSERT INTO `ocp_url_id_monikers` (`id`, `m_deprecated`, `m_moniker`, `m_resource_id`, `m_resource_page`, `m_resource_type`) VALUES(9, 0, 'website_comment_topics', '7', 'forumview', 'misc');
INSERT INTO `ocp_url_id_monikers` (`id`, `m_deprecated`, `m_moniker`, `m_resource_id`, `m_resource_page`, `m_resource_type`) VALUES(10, 0, 'reported_posts_forum', '5', 'forumview', 'misc');
INSERT INTO `ocp_url_id_monikers` (`id`, `m_deprecated`, `m_moniker`, `m_resource_id`, `m_resource_page`, `m_resource_type`) VALUES(11, 0, 'trash', '6', 'forumview', 'misc');
INSERT INTO `ocp_url_id_monikers` (`id`, `m_deprecated`, `m_moniker`, `m_resource_id`, `m_resource_page`, `m_resource_type`) VALUES(12, 0, 'website_support_tickets', '8', 'forumview', 'misc');
INSERT INTO `ocp_url_id_monikers` (`id`, `m_deprecated`, `m_moniker`, `m_resource_id`, `m_resource_page`, `m_resource_type`) VALUES(13, 0, 'staff', '9', 'forumview', 'misc');
INSERT INTO `ocp_url_id_monikers` (`id`, `m_deprecated`, `m_moniker`, `m_resource_id`, `m_resource_page`, `m_resource_type`) VALUES(14, 0, 'website_contact_us', '10', 'forumview', 'misc');
INSERT INTO `ocp_url_id_monikers` (`id`, `m_deprecated`, `m_moniker`, `m_resource_id`, `m_resource_page`, `m_resource_type`) VALUES(15, 0, 'administrators', '2', 'groups', 'view');
INSERT INTO `ocp_url_id_monikers` (`id`, `m_deprecated`, `m_moniker`, `m_resource_id`, `m_resource_page`, `m_resource_type`) VALUES(16, 1, 'books', '2', 'downloads', 'misc');
INSERT INTO `ocp_url_id_monikers` (`id`, `m_deprecated`, `m_moniker`, `m_resource_id`, `m_resource_page`, `m_resource_type`) VALUES(17, 1, 'books/shakespeare_william', '3', 'downloads', 'misc');
INSERT INTO `ocp_url_id_monikers` (`id`, `m_deprecated`, `m_moniker`, `m_resource_id`, `m_resource_page`, `m_resource_type`) VALUES(18, 0, 'works', '2', 'downloads', 'misc');
INSERT INTO `ocp_url_id_monikers` (`id`, `m_deprecated`, `m_moniker`, `m_resource_id`, `m_resource_page`, `m_resource_type`) VALUES(19, 0, 'works/shakespeare_william_2', '3', 'downloads', 'misc');
INSERT INTO `ocp_url_id_monikers` (`id`, `m_deprecated`, `m_moniker`, `m_resource_id`, `m_resource_page`, `m_resource_type`) VALUES(20, 0, 'downloads_home', '1', 'downloads', 'misc');
INSERT INTO `ocp_url_id_monikers` (`id`, `m_deprecated`, `m_moniker`, `m_resource_id`, `m_resource_page`, `m_resource_type`) VALUES(21, 0, 'works/shakespeare_william_2/romeo_and_juliet', '1', 'downloads', 'entry');
INSERT INTO `ocp_url_id_monikers` (`id`, `m_deprecated`, `m_moniker`, `m_resource_id`, `m_resource_page`, `m_resource_type`) VALUES(22, 0, 'william_shakespeare', '1', 'iotds', 'view');
INSERT INTO `ocp_url_id_monikers` (`id`, `m_deprecated`, `m_moniker`, `m_resource_id`, `m_resource_page`, `m_resource_type`) VALUES(23, 0, 'works_by_william', '7', 'catalogues', 'category');
INSERT INTO `ocp_url_id_monikers` (`id`, `m_deprecated`, `m_moniker`, `m_resource_id`, `m_resource_page`, `m_resource_type`) VALUES(24, 0, 'home/works_by_william_2', '8', 'catalogues', 'category');
INSERT INTO `ocp_url_id_monikers` (`id`, `m_deprecated`, `m_moniker`, `m_resource_id`, `m_resource_page`, `m_resource_type`) VALUES(25, 0, 'home/works_by_william_2/romeo_and_juliet', '1', 'catalogues', 'entry');
INSERT INTO `ocp_url_id_monikers` (`id`, `m_deprecated`, `m_moniker`, `m_resource_id`, `m_resource_page`, `m_resource_type`) VALUES(26, 0, 'home/works_by_william_2/hamlet', '2', 'catalogues', 'entry');
INSERT INTO `ocp_url_id_monikers` (`id`, `m_deprecated`, `m_moniker`, `m_resource_id`, `m_resource_page`, `m_resource_type`) VALUES(27, 0, 'contacts', '5', 'catalogues', 'category');
INSERT INTO `ocp_url_id_monikers` (`id`, `m_deprecated`, `m_moniker`, `m_resource_id`, `m_resource_page`, `m_resource_type`) VALUES(28, 0, 'contacts/barack', '3', 'catalogues', 'entry');
INSERT INTO `ocp_url_id_monikers` (`id`, `m_deprecated`, `m_moniker`, `m_resource_id`, `m_resource_page`, `m_resource_type`) VALUES(29, 0, 'contacts/gordon', '4', 'catalogues', 'entry');
INSERT INTO `ocp_url_id_monikers` (`id`, `m_deprecated`, `m_moniker`, `m_resource_id`, `m_resource_page`, `m_resource_type`) VALUES(30, 0, 'frequently_asked', '4', 'catalogues', 'category');
INSERT INTO `ocp_url_id_monikers` (`id`, `m_deprecated`, `m_moniker`, `m_resource_id`, `m_resource_page`, `m_resource_type`) VALUES(31, 0, 'hosted_sites', '2', 'catalogues', 'category');
INSERT INTO `ocp_url_id_monikers` (`id`, `m_deprecated`, `m_moniker`, `m_resource_id`, `m_resource_page`, `m_resource_type`) VALUES(32, 0, 'super-member_projects', '1', 'catalogues', 'category');
INSERT INTO `ocp_url_id_monikers` (`id`, `m_deprecated`, `m_moniker`, `m_resource_id`, `m_resource_page`, `m_resource_type`) VALUES(33, 0, 'links/ocportal', '5', 'catalogues', 'entry');
INSERT INTO `ocp_url_id_monikers` (`id`, `m_deprecated`, `m_moniker`, `m_resource_id`, `m_resource_page`, `m_resource_type`) VALUES(34, 0, 'links/ocproducts', '6', 'catalogues', 'entry');
INSERT INTO `ocp_url_id_monikers` (`id`, `m_deprecated`, `m_moniker`, `m_resource_id`, `m_resource_page`, `m_resource_type`) VALUES(35, 0, 'links/open_source_initiative', '7', 'catalogues', 'entry');
INSERT INTO `ocp_url_id_monikers` (`id`, `m_deprecated`, `m_moniker`, `m_resource_id`, `m_resource_page`, `m_resource_type`) VALUES(36, 0, 'meeting', '1', 'calendar', 'view');
INSERT INTO `ocp_url_id_monikers` (`id`, `m_deprecated`, `m_moniker`, `m_resource_id`, `m_resource_page`, `m_resource_type`) VALUES(37, 0, 'this_is_the_first_news', '1', 'news', 'view');
INSERT INTO `ocp_url_id_monikers` (`id`, `m_deprecated`, `m_moniker`, `m_resource_id`, `m_resource_page`, `m_resource_type`) VALUES(38, 0, 'general', '1', 'news', 'misc');
INSERT INTO `ocp_url_id_monikers` (`id`, `m_deprecated`, `m_moniker`, `m_resource_id`, `m_resource_page`, `m_resource_type`) VALUES(39, 0, 'this_is_the_second_news', '2', 'news', 'view');
INSERT INTO `ocp_url_id_monikers` (`id`, `m_deprecated`, `m_moniker`, `m_resource_id`, `m_resource_page`, `m_resource_type`) VALUES(40, 0, 'romeo_and_juliet', '1', 'quiz', 'do');
INSERT INTO `ocp_url_id_monikers` (`id`, `m_deprecated`, `m_moniker`, `m_resource_id`, `m_resource_page`, `m_resource_type`) VALUES(41, 0, '', '1', 'galleries', 'image');
INSERT INTO `ocp_url_id_monikers` (`id`, `m_deprecated`, `m_moniker`, `m_resource_id`, `m_resource_page`, `m_resource_type`) VALUES(42, 0, '_2', '2', 'galleries', 'image');
INSERT INTO `ocp_url_id_monikers` (`id`, `m_deprecated`, `m_moniker`, `m_resource_id`, `m_resource_page`, `m_resource_type`) VALUES(43, 0, 'works/shakespeare_william_2/hamlet', '2', 'downloads', 'entry');
INSERT INTO `ocp_url_id_monikers` (`id`, `m_deprecated`, `m_moniker`, `m_resource_id`, `m_resource_page`, `m_resource_type`) VALUES(44, 0, 'general_chat', '1', 'chat', 'room');
INSERT INTO `ocp_url_id_monikers` (`id`, `m_deprecated`, `m_moniker`, `m_resource_id`, `m_resource_page`, `m_resource_type`) VALUES(45, 0, 'romeo_and_juliet', '1', 'downloads', 'view');
INSERT INTO `ocp_url_id_monikers` (`id`, `m_deprecated`, `m_moniker`, `m_resource_id`, `m_resource_page`, `m_resource_type`) VALUES(46, 0, 'gallery_for_romeo_and', 'download_1', 'galleries', 'misc');
INSERT INTO `ocp_url_id_monikers` (`id`, `m_deprecated`, `m_moniker`, `m_resource_id`, `m_resource_page`, `m_resource_type`) VALUES(47, 0, 'general_chat/this_is_a_topic_title', '2', 'topicview', 'misc');
INSERT INTO `ocp_url_id_monikers` (`id`, `m_deprecated`, `m_moniker`, `m_resource_id`, `m_resource_page`, `m_resource_type`) VALUES(48, 0, 'general_chat/here_is_a_topic_with_a', '3', 'topicview', 'misc');
INSERT INTO `ocp_url_id_monikers` (`id`, `m_deprecated`, `m_moniker`, `m_resource_id`, `m_resource_page`, `m_resource_type`) VALUES(49, 0, 'general_chat/this_topic_contains_a', '4', 'topicview', 'misc');
INSERT INTO `ocp_url_id_monikers` (`id`, `m_deprecated`, `m_moniker`, `m_resource_id`, `m_resource_page`, `m_resource_type`) VALUES(50, 0, 'this_topic_acts_as_an', '5', 'topicview', 'misc');
INSERT INTO `ocp_url_id_monikers` (`id`, `m_deprecated`, `m_moniker`, `m_resource_id`, `m_resource_page`, `m_resource_type`) VALUES(51, 0, 'guest', '1', 'members', 'view');
INSERT INTO `ocp_url_id_monikers` (`id`, `m_deprecated`, `m_moniker`, `m_resource_id`, `m_resource_page`, `m_resource_type`) VALUES(52, 0, 'staff/welcome_to_the_forums', '1', 'topicview', 'misc');
INSERT INTO `ocp_url_id_monikers` (`id`, `m_deprecated`, `m_moniker`, `m_resource_id`, `m_resource_page`, `m_resource_type`) VALUES(53, 0, 'forum_home', '1', 'forumview', 'misc');
INSERT INTO `ocp_url_id_monikers` (`id`, `m_deprecated`, `m_moniker`, `m_resource_id`, `m_resource_page`, `m_resource_type`) VALUES(54, 0, 'personal_topic_example', '6', 'topicview', 'misc');
INSERT INTO `ocp_url_id_monikers` (`id`, `m_deprecated`, `m_moniker`, `m_resource_id`, `m_resource_page`, `m_resource_type`) VALUES(55, 0, 'reported_posts_forum/reported_post_in_here', '7', 'topicview', 'misc');
INSERT INTO `ocp_url_id_monikers` (`id`, `m_deprecated`, `m_moniker`, `m_resource_id`, `m_resource_page`, `m_resource_type`) VALUES(56, 0, 'general_chat/this_topic_is_pinned', '8', 'topicview', 'misc');
INSERT INTO `ocp_url_id_monikers` (`id`, `m_deprecated`, `m_moniker`, `m_resource_id`, `m_resource_page`, `m_resource_type`) VALUES(57, 0, 'general_chat/this_topic_is_sunk', '9', 'topicview', 'misc');

-- --------------------------------------------------------

--
-- Table structure for table `ocp_url_title_cache`
--

DROP TABLE IF EXISTS `ocp_url_title_cache`;
CREATE TABLE IF NOT EXISTS `ocp_url_title_cache` (
  `t_title` varchar(255) NOT NULL,
  `t_url` varchar(255) NOT NULL,
  PRIMARY KEY (`t_url`)
) ENGINE=MyISAM;

--
-- Dumping data for table `ocp_url_title_cache`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_usersonline_track`
--

DROP TABLE IF EXISTS `ocp_usersonline_track`;
CREATE TABLE IF NOT EXISTS `ocp_usersonline_track` (
  `date_and_time` int(10) unsigned NOT NULL,
  `peak` int(11) NOT NULL,
  PRIMARY KEY (`date_and_time`),
  KEY `peak_track` (`peak`)
) ENGINE=MyISAM;

--
-- Dumping data for table `ocp_usersonline_track`
--

INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264606970, 0);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264606982, 0);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264607030, 0);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264607038, 0);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264607039, 0);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264607066, 0);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264607069, 0);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264607089, 0);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264607094, 0);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264607215, 2);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264607223, 2);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264607237, 2);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264607243, 2);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264607266, 2);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264607290, 2);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264607299, 2);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264607313, 2);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264607399, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264607439, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264607443, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264607451, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264607460, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264607465, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264607478, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264607481, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264607510, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264607513, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264607518, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264607551, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264607556, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264607559, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264607566, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264607599, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264607605, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264607625, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264607627, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264607631, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264607635, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264607664, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264607668, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264607693, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264607697, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264607701, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264607704, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264607707, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264607713, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264607714, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264607718, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264607719, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264607771, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264607775, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264607777, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264607780, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264607791, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264607805, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264607808, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264607811, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264607813, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264607814, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264607817, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264607818, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264607823, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264607826, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264607860, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264607868, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264607888, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264607890, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264607924, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264607929, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264607930, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264607958, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264607961, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264607969, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264607973, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264607975, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264607976, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608031, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608035, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608041, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608044, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608051, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608054, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608096, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608100, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608103, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608125, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608129, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608135, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608137, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608156, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608160, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608163, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608166, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608171, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608173, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608174, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608314, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608329, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608334, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608450, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608452, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608461, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608465, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608466, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608468, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608469, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608471, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608472, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608475, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608476, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608478, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608479, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608481, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608482, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608485, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608486, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608490, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608493, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608494, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608497, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608498, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608501, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608505, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608507, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608510, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608511, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608513, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608514, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608517, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608522, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608528, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608530, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608533, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608541, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608544, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608548, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608557, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608564, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608566, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608580, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608592, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608599, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608602, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608606, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608609, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608610, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608612, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608615, 2);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608618, 2);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608619, 2);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608621, 2);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608626, 2);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608630, 2);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608648, 2);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608660, 2);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608670, 2);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608673, 2);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608674, 2);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608676, 2);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608680, 2);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608682, 2);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608716, 2);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608734, 2);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608742, 2);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608745, 2);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608771, 2);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608776, 2);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608795, 2);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608800, 2);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608816, 2);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608819, 2);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608879, 2);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608882, 2);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608886, 2);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264608889, 2);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264609167, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264609171, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264609183, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264609187, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264609190, 1);
INSERT INTO `ocp_usersonline_track` (`date_and_time`, `peak`) VALUES(1264609337, 1);

-- --------------------------------------------------------

--
-- Table structure for table `ocp_usersubmitban_ip`
--

DROP TABLE IF EXISTS `ocp_usersubmitban_ip`;
CREATE TABLE IF NOT EXISTS `ocp_usersubmitban_ip` (
  `ip` varchar(40) NOT NULL,
  `i_descrip` longtext NOT NULL,
  PRIMARY KEY (`ip`)
) ENGINE=MyISAM;

--
-- Dumping data for table `ocp_usersubmitban_ip`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_usersubmitban_member`
--

DROP TABLE IF EXISTS `ocp_usersubmitban_member`;
CREATE TABLE IF NOT EXISTS `ocp_usersubmitban_member` (
  `the_member` int(11) NOT NULL,
  PRIMARY KEY (`the_member`)
) ENGINE=MyISAM;

--
-- Dumping data for table `ocp_usersubmitban_member`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_validated_once`
--

DROP TABLE IF EXISTS `ocp_validated_once`;
CREATE TABLE IF NOT EXISTS `ocp_validated_once` (
  `hash` varchar(33) NOT NULL,
  PRIMARY KEY (`hash`)
) ENGINE=MyISAM;

--
-- Dumping data for table `ocp_validated_once`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_values`
--

DROP TABLE IF EXISTS `ocp_values`;
CREATE TABLE IF NOT EXISTS `ocp_values` (
  `date_and_time` int(10) unsigned NOT NULL,
  `the_name` varchar(80) NOT NULL,
  `the_value` varchar(80) NOT NULL,
  PRIMARY KEY (`the_name`)
) ENGINE=MyISAM;

--
-- Dumping data for table `ocp_values`
--

INSERT INTO `ocp_values` (`date_and_time`, `the_name`, `the_value`) VALUES(1265488380, 'version', '4.3');
INSERT INTO `ocp_values` (`date_and_time`, `the_name`, `the_value`) VALUES(1265488383, 'ocf_version', '4.3');
INSERT INTO `ocp_values` (`date_and_time`, `the_name`, `the_value`) VALUES(1265489669, 'users_online', '0');
INSERT INTO `ocp_values` (`date_and_time`, `the_name`, `the_value`) VALUES(1265488026, 'user_peak', '2');
INSERT INTO `ocp_values` (`date_and_time`, `the_name`, `the_value`) VALUES(1265488026, 'ocf_member_count', '2');
INSERT INTO `ocp_values` (`date_and_time`, `the_name`, `the_value`) VALUES(1265488026, 'ocf_topic_count', '9');
INSERT INTO `ocp_values` (`date_and_time`, `the_name`, `the_value`) VALUES(1265488026, 'ocf_post_count', '13');
INSERT INTO `ocp_values` (`date_and_time`, `the_name`, `the_value`) VALUES(1264606970, 'ran_once', '1');
INSERT INTO `ocp_values` (`date_and_time`, `the_name`, `the_value`) VALUES(1265488037, 'last_base_url', 'http://localhost/ocproducts/Dropbox/ocproducts/our-website/demo_dev');
INSERT INTO `ocp_values` (`date_and_time`, `the_name`, `the_value`) VALUES(1265488400, 'last_space_check', '1265488400');
INSERT INTO `ocp_values` (`date_and_time`, `the_name`, `the_value`) VALUES(1264607444, 'uses_ftp', '0');
INSERT INTO `ocp_values` (`date_and_time`, `the_name`, `the_value`) VALUES(1265488555, 'site_bestmember', 'test');
INSERT INTO `ocp_values` (`date_and_time`, `the_name`, `the_value`) VALUES(1265476284, 'ocf_newest_member_id', '3');
INSERT INTO `ocp_values` (`date_and_time`, `the_name`, `the_value`) VALUES(1265476284, 'ocf_newest_member_username', 'test');
INSERT INTO `ocp_values` (`date_and_time`, `the_name`, `the_value`) VALUES(1265476483, 'num_error_mails_2010-02-06', '1');
INSERT INTO `ocp_values` (`date_and_time`, `the_name`, `the_value`) VALUES(1264685674, 'num_archive_downloads', '2');
INSERT INTO `ocp_values` (`date_and_time`, `the_name`, `the_value`) VALUES(1264685674, 'archive_size', '140838');
INSERT INTO `ocp_values` (`date_and_time`, `the_name`, `the_value`) VALUES(1264681798, 'num_seedy_pages', '3');
INSERT INTO `ocp_values` (`date_and_time`, `the_name`, `the_value`) VALUES(1264682523, 'num_seedy_posts', '2');
INSERT INTO `ocp_values` (`date_and_time`, `the_name`, `the_value`) VALUES(1264686105, 'last_active_prune', '1264686105');
INSERT INTO `ocp_values` (`date_and_time`, `the_name`, `the_value`) VALUES(1265480679, 'hits', '17');
INSERT INTO `ocp_values` (`date_and_time`, `the_name`, `the_value`) VALUES(1265397866, 'last_backup', '1265397866');

-- --------------------------------------------------------

--
-- Table structure for table `ocp_videos`
--

DROP TABLE IF EXISTS `ocp_videos`;
CREATE TABLE IF NOT EXISTS `ocp_videos` (
  `add_date` int(10) unsigned NOT NULL,
  `allow_comments` tinyint(4) NOT NULL,
  `allow_rating` tinyint(1) NOT NULL,
  `allow_trackbacks` tinyint(1) NOT NULL,
  `cat` varchar(80) NOT NULL,
  `comments` int(10) unsigned NOT NULL,
  `edit_date` int(10) unsigned DEFAULT NULL,
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `notes` longtext NOT NULL,
  `submitter` int(11) NOT NULL,
  `thumb_url` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  `validated` tinyint(1) NOT NULL,
  `video_height` int(11) NOT NULL,
  `video_length` int(11) NOT NULL,
  `video_views` int(11) NOT NULL,
  `video_width` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `category_list` (`cat`)
) ENGINE=MyISAM AUTO_INCREMENT=1 ;

--
-- Dumping data for table `ocp_videos`
--


-- --------------------------------------------------------

--
-- Table structure for table `ocp_wordfilter`
--

DROP TABLE IF EXISTS `ocp_wordfilter`;
CREATE TABLE IF NOT EXISTS `ocp_wordfilter` (
  `word` varchar(255) NOT NULL,
  `w_replacement` varchar(255) NOT NULL,
  `w_substr` tinyint(1) NOT NULL,
  PRIMARY KEY (`word`,`w_substr`)
) ENGINE=MyISAM;

--
-- Dumping data for table `ocp_wordfilter`
--

INSERT INTO `ocp_wordfilter` (`word`, `w_replacement`, `w_substr`) VALUES('arsehole', '', 0);
INSERT INTO `ocp_wordfilter` (`word`, `w_replacement`, `w_substr`) VALUES('asshole', '', 0);
INSERT INTO `ocp_wordfilter` (`word`, `w_replacement`, `w_substr`) VALUES('arse', '', 0);
INSERT INTO `ocp_wordfilter` (`word`, `w_replacement`, `w_substr`) VALUES('cock', '', 0);
INSERT INTO `ocp_wordfilter` (`word`, `w_replacement`, `w_substr`) VALUES('cocked', '', 0);
INSERT INTO `ocp_wordfilter` (`word`, `w_replacement`, `w_substr`) VALUES('cocksucker', '', 0);
INSERT INTO `ocp_wordfilter` (`word`, `w_replacement`, `w_substr`) VALUES('crap', '', 0);
INSERT INTO `ocp_wordfilter` (`word`, `w_replacement`, `w_substr`) VALUES('cunt', '', 0);
INSERT INTO `ocp_wordfilter` (`word`, `w_replacement`, `w_substr`) VALUES('cum', '', 0);
INSERT INTO `ocp_wordfilter` (`word`, `w_replacement`, `w_substr`) VALUES('bastard', '', 0);
INSERT INTO `ocp_wordfilter` (`word`, `w_replacement`, `w_substr`) VALUES('bitch', '', 0);
INSERT INTO `ocp_wordfilter` (`word`, `w_replacement`, `w_substr`) VALUES('blowjob', '', 0);
INSERT INTO `ocp_wordfilter` (`word`, `w_replacement`, `w_substr`) VALUES('bollocks', '', 0);
INSERT INTO `ocp_wordfilter` (`word`, `w_replacement`, `w_substr`) VALUES('bondage', '', 0);
INSERT INTO `ocp_wordfilter` (`word`, `w_replacement`, `w_substr`) VALUES('bugger', '', 0);
INSERT INTO `ocp_wordfilter` (`word`, `w_replacement`, `w_substr`) VALUES('buggery', '', 0);
INSERT INTO `ocp_wordfilter` (`word`, `w_replacement`, `w_substr`) VALUES('dickhead', '', 0);
INSERT INTO `ocp_wordfilter` (`word`, `w_replacement`, `w_substr`) VALUES('fuck', '', 0);
INSERT INTO `ocp_wordfilter` (`word`, `w_replacement`, `w_substr`) VALUES('fucked', '', 0);
INSERT INTO `ocp_wordfilter` (`word`, `w_replacement`, `w_substr`) VALUES('fucking', '', 0);
INSERT INTO `ocp_wordfilter` (`word`, `w_replacement`, `w_substr`) VALUES('fucker', '', 0);
INSERT INTO `ocp_wordfilter` (`word`, `w_replacement`, `w_substr`) VALUES('gayboy', '', 0);
INSERT INTO `ocp_wordfilter` (`word`, `w_replacement`, `w_substr`) VALUES('motherfucker', '', 0);
INSERT INTO `ocp_wordfilter` (`word`, `w_replacement`, `w_substr`) VALUES('nigger', '', 0);
INSERT INTO `ocp_wordfilter` (`word`, `w_replacement`, `w_substr`) VALUES('piss', '', 0);
INSERT INTO `ocp_wordfilter` (`word`, `w_replacement`, `w_substr`) VALUES('pissed', '', 0);
INSERT INTO `ocp_wordfilter` (`word`, `w_replacement`, `w_substr`) VALUES('puffter', '', 0);
INSERT INTO `ocp_wordfilter` (`word`, `w_replacement`, `w_substr`) VALUES('pussy', '', 0);
INSERT INTO `ocp_wordfilter` (`word`, `w_replacement`, `w_substr`) VALUES('shag', '', 0);
INSERT INTO `ocp_wordfilter` (`word`, `w_replacement`, `w_substr`) VALUES('shagged', '', 0);
INSERT INTO `ocp_wordfilter` (`word`, `w_replacement`, `w_substr`) VALUES('shat', '', 0);
INSERT INTO `ocp_wordfilter` (`word`, `w_replacement`, `w_substr`) VALUES('shit', '', 0);
INSERT INTO `ocp_wordfilter` (`word`, `w_replacement`, `w_substr`) VALUES('slut', '', 0);
INSERT INTO `ocp_wordfilter` (`word`, `w_replacement`, `w_substr`) VALUES('twat', '', 0);
INSERT INTO `ocp_wordfilter` (`word`, `w_replacement`, `w_substr`) VALUES('wank', '', 0);
INSERT INTO `ocp_wordfilter` (`word`, `w_replacement`, `w_substr`) VALUES('wanker', '', 0);
INSERT INTO `ocp_wordfilter` (`word`, `w_replacement`, `w_substr`) VALUES('whore', '', 0);

-- --------------------------------------------------------

--
-- Table structure for table `ocp_zones`
--

DROP TABLE IF EXISTS `ocp_zones`;
CREATE TABLE IF NOT EXISTS `ocp_zones` (
  `zone_default_page` varchar(80) NOT NULL,
  `zone_displayed_in_menu` tinyint(1) NOT NULL,
  `zone_header_text` int(10) unsigned NOT NULL,
  `zone_name` varchar(80) NOT NULL,
  `zone_require_session` tinyint(1) NOT NULL,
  `zone_theme` varchar(80) NOT NULL,
  `zone_title` int(10) unsigned NOT NULL,
  `zone_wide` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`zone_name`)
) ENGINE=MyISAM;

--
-- Dumping data for table `ocp_zones`
--

INSERT INTO `ocp_zones` (`zone_default_page`, `zone_displayed_in_menu`, `zone_header_text`, `zone_name`, `zone_require_session`, `zone_theme`, `zone_title`, `zone_wide`) VALUES('start', 0, 1, '', 0, '_unnamed_', 7, 0);
INSERT INTO `ocp_zones` (`zone_default_page`, `zone_displayed_in_menu`, `zone_header_text`, `zone_name`, `zone_require_session`, `zone_theme`, `zone_title`, `zone_wide`) VALUES('start', 1, 2, 'adminzone', 1, 'default', 8, 0);
INSERT INTO `ocp_zones` (`zone_default_page`, `zone_displayed_in_menu`, `zone_header_text`, `zone_name`, `zone_require_session`, `zone_theme`, `zone_title`, `zone_wide`) VALUES('start', 1, 4, 'site', 0, '_unnamed_', 9, 0);
INSERT INTO `ocp_zones` (`zone_default_page`, `zone_displayed_in_menu`, `zone_header_text`, `zone_name`, `zone_require_session`, `zone_theme`, `zone_title`, `zone_wide`) VALUES('start', 1, 3, 'collaboration', 0, '_unnamed_', 10, 0);
INSERT INTO `ocp_zones` (`zone_default_page`, `zone_displayed_in_menu`, `zone_header_text`, `zone_name`, `zone_require_session`, `zone_theme`, `zone_title`, `zone_wide`) VALUES('cms', 1, 5, 'cms', 1, 'default', 11, 0);
INSERT INTO `ocp_zones` (`zone_default_page`, `zone_displayed_in_menu`, `zone_header_text`, `zone_name`, `zone_require_session`, `zone_theme`, `zone_title`, `zone_wide`) VALUES('forumview', 1, 12, 'forum', 0, '_unnamed_', 14, NULL);
INSERT INTO `ocp_zones` (`zone_default_page`, `zone_displayed_in_menu`, `zone_header_text`, `zone_name`, `zone_require_session`, `zone_theme`, `zone_title`, `zone_wide`) VALUES('myhome', 1, 13, 'personalzone', 1, '_unnamed_', 15, 0);
