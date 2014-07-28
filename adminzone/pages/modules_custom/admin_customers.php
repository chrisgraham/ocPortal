<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		ocportalcom_support_credits
 */

/**
 * Module page class.
 */
class Module_admin_customers
{
	/**
	 * Standard modular info function.
	 *
	 * @return ?array	Map of module info (NULL: module is disabled).
	 */
	function info()
	{
		$info=array();
		$info['author']='Philip Withnall';
		$info['organisation']='ocProducts';
		$info['hacked_by']='Troy Moore';
		$info['hack_version']=NULL;
		$info['version']=1;
		$info['locked']=false;
		return $info;
	}

	/**
	 * Standard modular uninstall function.
	 */
	function uninstall()
	{
		$GLOBALS['SITE_DB']->drop_table_if_exists('credit_purchases');

		// MANTIS TABLE DELETION

		$GLOBALS['SITE_DB']->_query("DROP TABLE IF EXISTS `mantis_bugnote_table`");
		$GLOBALS['SITE_DB']->_query("DROP TABLE IF EXISTS `mantis_bugnote_text_table`");
		$GLOBALS['SITE_DB']->_query("DROP TABLE IF EXISTS `mantis_bug_file_table`");
		$GLOBALS['SITE_DB']->_query("DROP TABLE IF EXISTS `mantis_bug_history_table`");
		$GLOBALS['SITE_DB']->_query("DROP TABLE IF EXISTS `mantis_bug_monitor_table`");
		$GLOBALS['SITE_DB']->_query("DROP TABLE IF EXISTS `mantis_bug_relationship_table`");
		$GLOBALS['SITE_DB']->_query("DROP TABLE IF EXISTS `mantis_bug_revision_table`");
		$GLOBALS['SITE_DB']->_query("DROP TABLE IF EXISTS `mantis_bug_table`");
		$GLOBALS['SITE_DB']->_query("DROP TABLE IF EXISTS `mantis_bug_tag_table`");
		$GLOBALS['SITE_DB']->_query("DROP TABLE IF EXISTS `mantis_bug_text_table`");
		$GLOBALS['SITE_DB']->_query("DROP TABLE IF EXISTS `mantis_category_table`");
		$GLOBALS['SITE_DB']->_query("DROP TABLE IF EXISTS `mantis_config_table`");
		$GLOBALS['SITE_DB']->_query("DROP TABLE IF EXISTS `mantis_custom_field_project_table`");
		$GLOBALS['SITE_DB']->_query("DROP TABLE IF EXISTS `mantis_custom_field_string_table`");
		$GLOBALS['SITE_DB']->_query("DROP TABLE IF EXISTS `mantis_custom_field_table`");
		$GLOBALS['SITE_DB']->_query("DROP TABLE IF EXISTS `mantis_email_table`");
		$GLOBALS['SITE_DB']->_query("DROP TABLE IF EXISTS `mantis_filters_table`");
		$GLOBALS['SITE_DB']->_query("DROP TABLE IF EXISTS `mantis_news_table`");
		$GLOBALS['SITE_DB']->_query("DROP TABLE IF EXISTS `mantis_plugin_table`");
		$GLOBALS['SITE_DB']->_query("DROP TABLE IF EXISTS `mantis_project_file_table`");
		$GLOBALS['SITE_DB']->_query("DROP TABLE IF EXISTS `mantis_project_hierarchy_table`");
		$GLOBALS['SITE_DB']->_query("DROP TABLE IF EXISTS `mantis_project_table`");
		$GLOBALS['SITE_DB']->_query("DROP TABLE IF EXISTS `mantis_project_user_list_table`");
		$GLOBALS['SITE_DB']->_query("DROP TABLE IF EXISTS `mantis_project_version_table`");
		$GLOBALS['SITE_DB']->_query("DROP TABLE IF EXISTS `mantis_sponsorship_table`");
		$GLOBALS['SITE_DB']->_query("DROP TABLE IF EXISTS `mantis_tag_table`");
		$GLOBALS['SITE_DB']->_query("DROP TABLE IF EXISTS `mantis_tokens_table`");
		$GLOBALS['SITE_DB']->_query("DROP TABLE IF EXISTS `mantis_user_pref_table`");
		$GLOBALS['SITE_DB']->_query("DROP TABLE IF EXISTS `mantis_user_print_pref_table`");
		$GLOBALS['SITE_DB']->_query("DROP TABLE IF EXISTS `mantis_user_profile_table`");
		$GLOBALS['SITE_DB']->_query("DROP TABLE IF EXISTS `mantis_user_table`");
	}

	/**
	 * Standard modular install function.
	 *
	 * @param  ?integer	What version we're upgrading from (NULL: new install)
	 * @param  ?integer	What hack version we're upgrading from (NULL: new-install/not-upgrading-from-a-hacked-version)
	 */
	function install($upgrade_from=NULL,$upgrade_from_hack=NULL)
	{
		require_lang('customers');

		/* CPFs */
		require_code('ocf_members_action');
		require_code('ocf_members_action2');
		require_code('mantis');
		$cur_id=NULL;
		$cur_id=get_credits_profile_field_id('ocp_currency');
		if (!is_null($cur_id ))
		{
			$GLOBALS['SITE_DB']->query_update('f_custom_fields',array('cf_owner_view'=>1,'cf_owner_set'=>1),array('id'=>$cur_id),'',1);
		}
		ocf_make_custom_field('ocp_support_credits',1,'','',0,1,0,0,'integer');
		ocf_make_custom_field('ocp_ftp_host',1,do_lang('ENCRYPTED_TO_WEBSITE'),'',0,1,1,1,'short_text');
		ocf_make_custom_field('ocp_ftp_path',1,do_lang('ENCRYPTED_TO_WEBSITE'),'',0,1,1,1,'short_text');
		ocf_make_custom_field('ocp_ftp_username',1,do_lang('ENCRYPTED_TO_WEBSITE'),'',0,1,1,1,'short_text');
		ocf_make_custom_field('ocp_ftp_password',1,do_lang('ENCRYPTED_TO_WEBSITE'),'',0,1,1,1,'short_text');
		ocf_make_custom_field('ocp_profession',1,'',do_lang('CUSTOMER_PROFESSION_CPF_LIST'),0,1,1,0,'list');

		$GLOBALS['SITE_DB']->create_table('credit_purchases',array(
			'purchase_id'=>'*AUTO',
			'member_id'=>'AUTO_LINK',
			'num_credits'=>'INTEGER',
			'date_and_time'=>'TIME',
			'purchase_validated'=>'BINARY',
			'is_manual'=>'BINARY'
		));

		if (get_db_type()!='xml')
		{
			$GLOBALS['SITE_DB']->_query("CREATE TABLE IF NOT EXISTS `mantis_bugnote_table` (
	  				`id` int(10) unsigned NOT NULL AUTO_INCREMENT,
	  				`bug_id` int(10) unsigned NOT NULL DEFAULT '0',
	  				`reporter_id` int(10) unsigned NOT NULL DEFAULT '0',
	  				`bugnote_text_id` int(10) unsigned NOT NULL DEFAULT '0',
	  				`view_state` smallint(6) NOT NULL DEFAULT '10',
	  				`note_type` int(11) DEFAULT '0',
	  				`note_attr` varchar(250) DEFAULT '',
	  				`time_tracking` int(10) unsigned NOT NULL DEFAULT '0',
	  				`last_modified` int(10) unsigned NOT NULL DEFAULT '1',
	  				`date_submitted` int(10) unsigned NOT NULL DEFAULT '1',
	  				PRIMARY KEY (`id`),
	  				KEY `idx_bug` (`bug_id`),
	  				KEY `idx_last_mod` (`last_modified`)
				) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1"
			);

			$GLOBALS['SITE_DB']->_query("CREATE TABLE IF NOT EXISTS `mantis_bugnote_text_table` (
					`id` int(10) unsigned NOT NULL AUTO_INCREMENT,
					`note` longtext NOT NULL,
					PRIMARY KEY (`id`)
				) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1"
			);

			$GLOBALS['SITE_DB']->_query("CREATE TABLE IF NOT EXISTS `mantis_bug_file_table` (
			  		`id` int(10) unsigned NOT NULL AUTO_INCREMENT,
			  		`bug_id` int(10) unsigned NOT NULL DEFAULT '0',
			  		`title` varchar(250) NOT NULL DEFAULT '',
			  		`description` varchar(250) NOT NULL DEFAULT '',
			  		`diskfile` varchar(250) NOT NULL DEFAULT '',
			  		`filename` varchar(250) NOT NULL DEFAULT '',
			  		`folder` varchar(250) NOT NULL DEFAULT '',
			  		`filesize` int(11) NOT NULL DEFAULT '0',
			  		`file_type` varchar(250) NOT NULL DEFAULT '',
			  		`content` longblob NOT NULL,
			  		`date_added` int(10) unsigned NOT NULL DEFAULT '1',
			  		`user_id` int(10) unsigned NOT NULL DEFAULT '0',
			  		PRIMARY KEY (`id`),
			  		KEY `idx_bug_file_bug_id` (`bug_id`),
			  		KEY `idx_diskfile` (`diskfile`)
				) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1"
			);

			$GLOBALS['SITE_DB']->_query("CREATE TABLE IF NOT EXISTS `mantis_bug_history_table` (
			  		`id` int(10) unsigned NOT NULL AUTO_INCREMENT,
			  		`user_id` int(10) unsigned NOT NULL DEFAULT '0',
			  		`bug_id` int(10) unsigned NOT NULL DEFAULT '0',
			  		`field_name` varchar(64) NOT NULL,
			  		`old_value` varchar(255) NOT NULL,
			  		`new_value` varchar(255) NOT NULL,
			  		`type` smallint(6) NOT NULL DEFAULT '0',
			  		`date_modified` int(10) unsigned NOT NULL DEFAULT '1',
			  		PRIMARY KEY (`id`),
			  		KEY `idx_bug_history_bug_id` (`bug_id`),
			  		KEY `idx_history_user_id` (`user_id`)
				) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1"
			);

			$GLOBALS['SITE_DB']->_query("CREATE TABLE IF NOT EXISTS `mantis_bug_monitor_table` (
			  		`user_id` int(10) unsigned NOT NULL DEFAULT '0',
			  		`bug_id` int(10) unsigned NOT NULL DEFAULT '0',
			  		PRIMARY KEY (`user_id`,`bug_id`)
				) ENGINE=MyISAM DEFAULT CHARSET=utf8"
			);

			$GLOBALS['SITE_DB']->_query("CREATE TABLE IF NOT EXISTS `mantis_bug_relationship_table` (
					`id` int(10) unsigned NOT NULL AUTO_INCREMENT,
					`source_bug_id` int(10) unsigned NOT NULL DEFAULT '0',
					`destination_bug_id` int(10) unsigned NOT NULL DEFAULT '0',
					`relationship_type` smallint(6) NOT NULL DEFAULT '0',
					PRIMARY KEY (`id`),
					KEY `idx_relationship_source` (`source_bug_id`),
					KEY `idx_relationship_destination` (`destination_bug_id`)
				) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1"
			);

			$GLOBALS['SITE_DB']->_query("CREATE TABLE IF NOT EXISTS `mantis_bug_revision_table` (
					`id` int(10) unsigned NOT NULL AUTO_INCREMENT,
					`bug_id` int(10) unsigned NOT NULL,
					`bugnote_id` int(10) unsigned NOT NULL DEFAULT '0',
					`user_id` int(10) unsigned NOT NULL,
					`type` int(10) unsigned NOT NULL,
					`value` longtext NOT NULL,
					`timestamp` int(10) unsigned NOT NULL DEFAULT '1',
					PRIMARY KEY (`id`),
					KEY `idx_bug_rev_type` (`type`),
					KEY `idx_bug_rev_id_time` (`bug_id`,`timestamp`)
				) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1"
			);

			$GLOBALS['SITE_DB']->_query("CREATE TABLE IF NOT EXISTS `mantis_bug_table` (
					  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
					  `project_id` int(10) unsigned NOT NULL DEFAULT '0',
					  `reporter_id` int(10) unsigned NOT NULL DEFAULT '0',
					  `handler_id` int(10) unsigned NOT NULL DEFAULT '0',
					  `duplicate_id` int(10) unsigned NOT NULL DEFAULT '0',
					  `priority` smallint(6) NOT NULL DEFAULT '30',
					  `severity` smallint(6) NOT NULL DEFAULT '50',
					  `reproducibility` smallint(6) NOT NULL DEFAULT '10',
					  `status` smallint(6) NOT NULL DEFAULT '10',
					  `resolution` smallint(6) NOT NULL DEFAULT '10',
					  `projection` smallint(6) NOT NULL DEFAULT '10',
					  `eta` smallint(6) NOT NULL DEFAULT '10',
					  `bug_text_id` int(10) unsigned NOT NULL DEFAULT '0',
					  `os` varchar(32) NOT NULL DEFAULT '',
					  `os_build` varchar(32) NOT NULL DEFAULT '',
					  `platform` varchar(32) NOT NULL DEFAULT '',
					  `version` varchar(64) NOT NULL DEFAULT '',
					  `fixed_in_version` varchar(64) NOT NULL DEFAULT '',
					  `build` varchar(32) NOT NULL DEFAULT '',
					  `profile_id` int(10) unsigned NOT NULL DEFAULT '0',
					  `view_state` smallint(6) NOT NULL DEFAULT '10',
					  `summary` varchar(128) NOT NULL DEFAULT '',
					  `sponsorship_total` int(11) NOT NULL DEFAULT '0',
					  `sticky` tinyint(4) NOT NULL DEFAULT '0',
					  `target_version` varchar(64) NOT NULL DEFAULT '',
					  `category_id` int(10) unsigned NOT NULL DEFAULT '1',
					  `date_submitted` int(10) unsigned NOT NULL DEFAULT '1',
					  `due_date` int(10) unsigned NOT NULL DEFAULT '1',
					  `last_updated` int(10) unsigned NOT NULL DEFAULT '1',
					  PRIMARY KEY (`id`),
					  KEY `idx_bug_sponsorship_total` (`sponsorship_total`),
					  KEY `idx_bug_fixed_in_version` (`fixed_in_version`),
					  KEY `idx_bug_status` (`status`),
					  KEY `idx_project` (`project_id`)
				) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1"
			);

			$GLOBALS['SITE_DB']->_query("CREATE TABLE IF NOT EXISTS `mantis_bug_tag_table` (
					  `bug_id` int(10) unsigned NOT NULL DEFAULT '0',
					  `tag_id` int(10) unsigned NOT NULL DEFAULT '0',
					  `user_id` int(10) unsigned NOT NULL DEFAULT '0',
					  `date_attached` int(10) unsigned NOT NULL DEFAULT '1',
					  PRIMARY KEY (`bug_id`,`tag_id`),
					  KEY `idx_bug_tag_tag_id` (`tag_id`)
				) ENGINE=MyISAM DEFAULT CHARSET=utf8"
			);

			$GLOBALS['SITE_DB']->_query("CREATE TABLE IF NOT EXISTS `mantis_bug_text_table` (
					`id` int(10) unsigned NOT NULL AUTO_INCREMENT,
					`description` longtext NOT NULL,
					`steps_to_reproduce` longtext NOT NULL,
					`additional_information` longtext NOT NULL,
					PRIMARY KEY (`id`)
				) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1"
			);

			$GLOBALS['SITE_DB']->_query("CREATE TABLE IF NOT EXISTS `mantis_category_table` (
					`id` int(10) unsigned NOT NULL AUTO_INCREMENT,
					`project_id` int(10) unsigned NOT NULL DEFAULT '0',
					`user_id` int(10) unsigned NOT NULL DEFAULT '0',
					`name` varchar(128) NOT NULL DEFAULT '',
					`status` int(10) unsigned NOT NULL DEFAULT '0',
					PRIMARY KEY (`id`),
					UNIQUE KEY `idx_category_project_name` (`project_id`,`name`)
				) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2"
			);

			$GLOBALS['SITE_DB']->_query("INSERT INTO `mantis_category_table` (`id`, `project_id`, `user_id`, `name`, `status`) VALUES (1, 0, 0, 'General', 0)");

			$GLOBALS['SITE_DB']->_query("CREATE TABLE IF NOT EXISTS `mantis_config_table` (
					  `config_id` varchar(64) NOT NULL,
					  `project_id` int(11) NOT NULL DEFAULT '0',
					  `user_id` int(11) NOT NULL DEFAULT '0',
					  `access_reqd` int(11) DEFAULT '0',
					  `type` int(11) DEFAULT '90',
					  `value` longtext NOT NULL,
					  PRIMARY KEY (`config_id`,`project_id`,`user_id`)
				) ENGINE=MyISAM DEFAULT CHARSET=utf8"
			);

			$GLOBALS['SITE_DB']->_query("INSERT INTO `mantis_config_table` (`config_id`, `project_id`, `user_id`, `access_reqd`, `type`, `value`) VALUES ('database_version', 0, 0, 90, 1, '182')");

			$GLOBALS['SITE_DB']->_query("CREATE TABLE IF NOT EXISTS `mantis_custom_field_project_table` (
					`field_id` int(11) NOT NULL DEFAULT '0',
					`project_id` int(10) unsigned NOT NULL DEFAULT '0',
					`sequence` smallint(6) NOT NULL DEFAULT '0',
					PRIMARY KEY (`field_id`,`project_id`)
				) ENGINE=MyISAM DEFAULT CHARSET=utf8"
			);

			$GLOBALS['SITE_DB']->_query("INSERT INTO `mantis_custom_field_project_table` (`field_id`, `project_id`, `sequence`) VALUES (1, 1, 0)");


			$GLOBALS['SITE_DB']->_query("CREATE TABLE IF NOT EXISTS `mantis_custom_field_string_table` (
					  `field_id` int(11) NOT NULL DEFAULT '0',
					  `bug_id` int(11) NOT NULL DEFAULT '0',
					  `value` varchar(255) NOT NULL DEFAULT '',
					  PRIMARY KEY (`field_id`,`bug_id`),
					  KEY `idx_custom_field_bug` (`bug_id`)
				) ENGINE=MyISAM DEFAULT CHARSET=utf8"
			);

			$GLOBALS['SITE_DB']->_query("CREATE TABLE IF NOT EXISTS `mantis_custom_field_table` (
					  `id` int(11) NOT NULL AUTO_INCREMENT,
					  `name` varchar(64) NOT NULL DEFAULT '',
					  `type` smallint(6) NOT NULL DEFAULT '0',
					  `possible_values` text NOT NULL,
					  `default_value` varchar(255) NOT NULL DEFAULT '',
					  `valid_regexp` varchar(255) NOT NULL DEFAULT '',
					  `access_level_r` smallint(6) NOT NULL DEFAULT '0',
					  `access_level_rw` smallint(6) NOT NULL DEFAULT '0',
					  `length_min` int(11) NOT NULL DEFAULT '0',
					  `length_max` int(11) NOT NULL DEFAULT '0',
					  `require_report` tinyint(4) NOT NULL DEFAULT '0',
					  `require_update` tinyint(4) NOT NULL DEFAULT '0',
					  `display_report` tinyint(4) NOT NULL DEFAULT '0',
					  `display_update` tinyint(4) NOT NULL DEFAULT '1',
					  `require_resolved` tinyint(4) NOT NULL DEFAULT '0',
					  `display_resolved` tinyint(4) NOT NULL DEFAULT '0',
					  `display_closed` tinyint(4) NOT NULL DEFAULT '0',
					  `require_closed` tinyint(4) NOT NULL DEFAULT '0',
					  `filter_by` tinyint(4) NOT NULL DEFAULT '1',
					  PRIMARY KEY (`id`),
					  KEY `idx_custom_field_name` (`name`)
				) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=2"
			);

			$GLOBALS['SITE_DB']->_query("INSERT INTO `mantis_custom_field_table` (
					`id`,
					`name`,
					`type`,
					`possible_values`,
					`default_value`,
					`valid_regexp`,
					`access_level_r`,
					`access_level_rw`,
					`length_min`,
					`length_max`,
					`require_report`,
					`require_update`,
					`display_report`,
					`display_update`,
					`require_resolved`,
					`display_resolved`,
					`display_closed`,
					`require_closed`,
					`filter_by`
				) VALUES (
					1,
					'Time estimation (hours)',
					2,
					'',
					'0',
					'',
					10,
					10,
					0,
					0,
					0,
					0,
					1,
					1,
					0,
					1,
					1,
					0,
					1
				)"
			);

			$GLOBALS['SITE_DB']->_query("CREATE TABLE IF NOT EXISTS `mantis_email_table` (
					  `email_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
					  `email` varchar(64) NOT NULL DEFAULT '',
					  `subject` varchar(250) NOT NULL DEFAULT '',
					  `metadata` longtext NOT NULL,
					  `body` longtext NOT NULL,
					  `submitted` int(10) unsigned NOT NULL DEFAULT '1',
					  PRIMARY KEY (`email_id`)
				) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1"
			);

			$GLOBALS['SITE_DB']->_query("CREATE TABLE IF NOT EXISTS `mantis_filters_table` (
			  		`id` int(10) unsigned NOT NULL AUTO_INCREMENT,
			  		`user_id` int(11) NOT NULL DEFAULT '0',
			  		`project_id` int(11) NOT NULL DEFAULT '0',
			  		`is_public` tinyint(4) DEFAULT NULL,
			  		`name` varchar(64) NOT NULL DEFAULT '',
			  		`filter_string` longtext NOT NULL,
			  		PRIMARY KEY (`id`)
				) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1"
			);

			$GLOBALS['SITE_DB']->_query("CREATE TABLE IF NOT EXISTS `mantis_news_table` (
			  		`id` int(10) unsigned NOT NULL AUTO_INCREMENT,
			  		`project_id` int(10) unsigned NOT NULL DEFAULT '0',
			  		`poster_id` int(10) unsigned NOT NULL DEFAULT '0',
			  		`view_state` smallint(6) NOT NULL DEFAULT '10',
			  		`announcement` tinyint(4) NOT NULL DEFAULT '0',
			  		`headline` varchar(64) NOT NULL DEFAULT '',
			  		`body` longtext NOT NULL,
			  		`last_modified` int(10) unsigned NOT NULL DEFAULT '1',
			  		`date_posted` int(10) unsigned NOT NULL DEFAULT '1',
			  		PRIMARY KEY (`id`)
				) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1"
			);

			$GLOBALS['SITE_DB']->_query("CREATE TABLE IF NOT EXISTS `mantis_plugin_table` (
					  `basename` varchar(40) NOT NULL,
					  `enabled` tinyint(4) NOT NULL DEFAULT '0',
					  `protected` tinyint(4) NOT NULL DEFAULT '0',
					  `priority` int(10) unsigned NOT NULL DEFAULT '3',
					  PRIMARY KEY (`basename`)
				) ENGINE=MyISAM DEFAULT CHARSET=utf8"
			);

			$GLOBALS['SITE_DB']->_query("INSERT INTO `mantis_plugin_table` (`basename`, `enabled`, `protected`, `priority`) VALUES ('MantisCoreFormatting', 1, 0, 3)");

			$GLOBALS['SITE_DB']->_query("CREATE TABLE IF NOT EXISTS `mantis_project_file_table` (
					  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
					  `project_id` int(10) unsigned NOT NULL DEFAULT '0',
					  `title` varchar(250) NOT NULL DEFAULT '',
					  `description` varchar(250) NOT NULL DEFAULT '',
					  `diskfile` varchar(250) NOT NULL DEFAULT '',
					  `filename` varchar(250) NOT NULL DEFAULT '',
					  `folder` varchar(250) NOT NULL DEFAULT '',
					  `filesize` int(11) NOT NULL DEFAULT '0',
					  `file_type` varchar(250) NOT NULL DEFAULT '',
					  `content` longblob NOT NULL,
					  `date_added` int(10) unsigned NOT NULL DEFAULT '1',
					  `user_id` int(10) unsigned NOT NULL DEFAULT '0',
					  PRIMARY KEY (`id`)
				) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1"
			);

			$GLOBALS['SITE_DB']->_query("CREATE TABLE IF NOT EXISTS `mantis_project_hierarchy_table` (
			  		`child_id` int(10) unsigned NOT NULL,
			  		`parent_id` int(10) unsigned NOT NULL,
			  		`inherit_parent` int(10) unsigned NOT NULL DEFAULT '0',
			  		KEY `idx_project_hierarchy_child_id` (`child_id`),
			  		KEY `idx_project_hierarchy_parent_id` (`parent_id`)
				) ENGINE=MyISAM DEFAULT CHARSET=utf8"
			);

			$GLOBALS['SITE_DB']->_query("CREATE TABLE IF NOT EXISTS `mantis_project_table` (
					  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
					  `name` varchar(128) NOT NULL DEFAULT '',
					  `status` smallint(6) NOT NULL DEFAULT '10',
					  `enabled` tinyint(4) NOT NULL DEFAULT '1',
					  `view_state` smallint(6) NOT NULL DEFAULT '10',
					  `access_min` smallint(6) NOT NULL DEFAULT '10',
					  `file_path` varchar(250) NOT NULL DEFAULT '',
					  `description` longtext NOT NULL,
					  `category_id` int(10) unsigned NOT NULL DEFAULT '1',
					  `inherit_global` int(10) unsigned NOT NULL DEFAULT '0',
					  PRIMARY KEY (`id`),
					  UNIQUE KEY `idx_project_name` (`name`),
					  KEY `idx_project_view` (`view_state`)
				) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=2"
			);

			$GLOBALS['SITE_DB']->_query("INSERT INTO `mantis_project_table` (
					`id`,
					`name`,
					`status`,
					`enabled`,
					`view_state`,
					`access_min`,
					`file_path`,
					`description`,
					`category_id`,
					`inherit_global`
				) VALUES (
					1,
					'All Projects',
					10,
					1,
					10,
					10,
					'',
					'',
					1,
					1
				)"
			);

			$GLOBALS['SITE_DB']->_query("CREATE TABLE IF NOT EXISTS `mantis_project_user_list_table` (
					  `project_id` int(10) unsigned NOT NULL DEFAULT '0',
					  `user_id` int(10) unsigned NOT NULL DEFAULT '0',
					  `access_level` smallint(6) NOT NULL DEFAULT '10',
					  PRIMARY KEY (`project_id`,`user_id`),
					  KEY `idx_project_user` (`user_id`)
				) ENGINE=MyISAM DEFAULT CHARSET=utf8"
			);

			$GLOBALS['SITE_DB']->_query("CREATE TABLE IF NOT EXISTS `mantis_project_version_table` (
					  `id` int(11) NOT NULL AUTO_INCREMENT,
					  `project_id` int(10) unsigned NOT NULL DEFAULT '0',
					  `version` varchar(64) NOT NULL DEFAULT '',
					  `description` longtext NOT NULL,
					  `released` tinyint(4) NOT NULL DEFAULT '1',
					  `obsolete` tinyint(4) NOT NULL DEFAULT '0',
					  `date_order` int(10) unsigned NOT NULL DEFAULT '1',
					  PRIMARY KEY (`id`),
					  UNIQUE KEY `idx_project_version` (`project_id`,`version`)
				) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1"
			);

			$GLOBALS['SITE_DB']->_query("CREATE TABLE IF NOT EXISTS `mantis_sponsorship_table` (
					  `id` int(11) NOT NULL AUTO_INCREMENT,
					  `bug_id` int(11) NOT NULL DEFAULT '0',
					  `user_id` int(11) NOT NULL DEFAULT '0',
					  `amount` int(11) NOT NULL DEFAULT '0',
					  `logo` varchar(128) NOT NULL DEFAULT '',
					  `url` varchar(128) NOT NULL DEFAULT '',
					  `paid` tinyint(4) NOT NULL DEFAULT '0',
					  `date_submitted` int(10) unsigned NOT NULL DEFAULT '1',
					  `last_updated` int(10) unsigned NOT NULL DEFAULT '1',
					  PRIMARY KEY (`id`),
					  KEY `idx_sponsorship_bug_id` (`bug_id`),
					  KEY `idx_sponsorship_user_id` (`user_id`)
				) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1"
			);

			$GLOBALS['SITE_DB']->_query("CREATE TABLE IF NOT EXISTS `mantis_tag_table` (
					  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
					  `user_id` int(10) unsigned NOT NULL DEFAULT '0',
					  `name` varchar(100) NOT NULL DEFAULT '',
					  `description` longtext NOT NULL,
					  `date_created` int(10) unsigned NOT NULL DEFAULT '1',
					  `date_updated` int(10) unsigned NOT NULL DEFAULT '1',
					  PRIMARY KEY (`id`,`name`),
					  KEY `idx_tag_name` (`name`)
				) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1"
			);

			$GLOBALS['SITE_DB']->_query("CREATE TABLE IF NOT EXISTS `mantis_tokens_table` (
					  `id` int(11) NOT NULL AUTO_INCREMENT,
					  `owner` int(11) NOT NULL,
					  `type` int(11) NOT NULL,
					  `value` longtext NOT NULL,
					  `timestamp` int(10) unsigned NOT NULL DEFAULT '1',
					  `expiry` int(10) unsigned NOT NULL DEFAULT '1',
					  PRIMARY KEY (`id`),
					  KEY `idx_typeowner` (`type`,`owner`)
				) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1"
			);

			$GLOBALS['SITE_DB']->_query("CREATE TABLE IF NOT EXISTS `mantis_user_pref_table` (
					  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
					  `user_id` int(10) unsigned NOT NULL DEFAULT '0',
					  `project_id` int(10) unsigned NOT NULL DEFAULT '0',
					  `default_profile` int(10) unsigned NOT NULL DEFAULT '0',
					  `default_project` int(10) unsigned NOT NULL DEFAULT '0',
					  `refresh_delay` int(11) NOT NULL DEFAULT '0',
					  `redirect_delay` int(11) NOT NULL DEFAULT '0',
					  `bugnote_order` varchar(4) NOT NULL DEFAULT 'ASC',
					  `email_on_new` tinyint(4) NOT NULL DEFAULT '0',
					  `email_on_assigned` tinyint(4) NOT NULL DEFAULT '0',
					  `email_on_feedback` tinyint(4) NOT NULL DEFAULT '0',
					  `email_on_resolved` tinyint(4) NOT NULL DEFAULT '0',
					  `email_on_closed` tinyint(4) NOT NULL DEFAULT '0',
					  `email_on_reopened` tinyint(4) NOT NULL DEFAULT '0',
					  `email_on_bugnote` tinyint(4) NOT NULL DEFAULT '0',
					  `email_on_status` tinyint(4) NOT NULL DEFAULT '0',
					  `email_on_priority` tinyint(4) NOT NULL DEFAULT '0',
					  `email_on_priority_min_severity` smallint(6) NOT NULL DEFAULT '10',
					  `email_on_status_min_severity` smallint(6) NOT NULL DEFAULT '10',
					  `email_on_bugnote_min_severity` smallint(6) NOT NULL DEFAULT '10',
					  `email_on_reopened_min_severity` smallint(6) NOT NULL DEFAULT '10',
					  `email_on_closed_min_severity` smallint(6) NOT NULL DEFAULT '10',
					  `email_on_resolved_min_severity` smallint(6) NOT NULL DEFAULT '10',
					  `email_on_feedback_min_severity` smallint(6) NOT NULL DEFAULT '10',
					  `email_on_assigned_min_severity` smallint(6) NOT NULL DEFAULT '10',
					  `email_on_new_min_severity` smallint(6) NOT NULL DEFAULT '10',
					  `email_bugnote_limit` smallint(6) NOT NULL DEFAULT '0',
					  `language` varchar(32) NOT NULL DEFAULT 'english',
					  `timezone` varchar(32) NOT NULL DEFAULT '',
					  PRIMARY KEY (`id`)
				) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1"
			);

			$GLOBALS['SITE_DB']->_query("CREATE TABLE IF NOT EXISTS `mantis_user_print_pref_table` (
					  `user_id` int(10) unsigned NOT NULL DEFAULT '0',
					  `print_pref` varchar(64) NOT NULL,
					  PRIMARY KEY (`user_id`)
				) ENGINE=MyISAM DEFAULT CHARSET=utf8"
			);

			$GLOBALS['SITE_DB']->_query("CREATE TABLE IF NOT EXISTS `mantis_user_profile_table` (
					  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
					  `user_id` int(10) unsigned NOT NULL DEFAULT '0',
					  `platform` varchar(32) NOT NULL DEFAULT '',
					  `os` varchar(32) NOT NULL DEFAULT '',
					  `os_build` varchar(32) NOT NULL DEFAULT '',
					  `description` longtext NOT NULL,
					  PRIMARY KEY (`id`)
				) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1"
			);

			$GLOBALS['SITE_DB']->_query("CREATE TABLE IF NOT EXISTS `mantis_user_table` (
					  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
					  `username` varchar(32) NOT NULL DEFAULT '',
					  `realname` varchar(64) NOT NULL DEFAULT '',
					  `email` varchar(64) NOT NULL DEFAULT '',
					  `password` varchar(32) NOT NULL DEFAULT '',
					  `enabled` tinyint(4) NOT NULL DEFAULT '1',
					  `protected` tinyint(4) NOT NULL DEFAULT '0',
					  `access_level` smallint(6) NOT NULL DEFAULT '10',
					  `login_count` int(11) NOT NULL DEFAULT '0',
					  `lost_password_request_count` smallint(6) NOT NULL DEFAULT '0',
					  `failed_login_count` smallint(6) NOT NULL DEFAULT '0',
					  `cookie_string` varchar(64) NOT NULL DEFAULT '',
					  `last_visit` int(10) unsigned NOT NULL DEFAULT '1',
					  `date_created` int(10) unsigned NOT NULL DEFAULT '1',
					  PRIMARY KEY (`id`),
					  UNIQUE KEY `idx_user_cookie_string` (`cookie_string`),
					  UNIQUE KEY `idx_user_username` (`username`),
					  KEY `idx_enable` (`enabled`),
					  KEY `idx_access` (`access_level`)
				) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1"
			);
		}

		/* Multi-mods */
		require_code('ocf_moderation_action');

		ocf_make_multi_moderation(do_lang('TICKET_MM_TAKE_OWNERSHIP'),do_lang('TICKET_MM_TAKE_OWNERSHIP_POST'),NULL,NULL,NULL,NULL,'*');
		ocf_make_multi_moderation(do_lang('TICKET_MM_QUOTE'),do_lang('TICKET_MM_QUOTE_POST'),NULL,NULL,NULL,NULL,'*');
		ocf_make_multi_moderation(do_lang('TICKET_MM_PRICE'),do_lang('TICKET_MM_PRICE_POST'),NULL,NULL,NULL,NULL,'*');
		ocf_make_multi_moderation(do_lang('TICKET_MM_CLOSE'),do_lang('TICKET_MM_CLOSE_POST'),NULL,NULL,NULL,NULL,'*');
		ocf_make_multi_moderation(do_lang('TICKET_MM_CHARGED'),do_lang('TICKET_MM_CHARGED_POST'),NULL,NULL,NULL,NULL,'*');
		ocf_make_multi_moderation(do_lang('TICKET_MM_NOT_FOR_FREE'),do_lang('TICKET_MM_NOT_FOR_FREE_POST'),NULL,NULL,NULL,NULL,'*');
		ocf_make_multi_moderation(do_lang('TICKET_MM_FREE_WORK'),do_lang('TICKET_MM_FREE_WORK_POST'),NULL,NULL,NULL,NULL,'*');
		ocf_make_multi_moderation(do_lang('TICKET_MM_FREE_CREDITS'),do_lang('TICKET_MM_FREE_CREDITS_POST'),NULL,NULL,NULL,NULL,'*');
	}

	/**
	 * Standard modular entry-point finder function.
	 *
	 * @param  boolean	Whether to check permissions.
	 * @param  ?MEMBER	The member to check permissions as (NULL: current user).
	 * @param  boolean	Whether to allow cross links to other modules (identifiable via a full-page-link rather than a screen-name).
	 * @param  boolean	Whether to avoid any entry-point (or even return NULL to disable the page in the Sitemap) if we know another module, or page_group, is going to link to that entry-point. Note that "!" and "misc" entry points are automatically merged with container page nodes (likely called by page-groupings) as appropriate.
	 * @return ?array		A map of entry points (screen-name=>language-code/string or screen-name=>[language-code/string, icon-theme-image]) (NULL: disabled).
	 */
	function get_entry_points($check_perms=true,$member_id=NULL,$support_crosslinks=true,$be_deferential=false)
	{
		return array(
			'misc'=>array('CHARGE_CUSTOMER','menu/_generic_admin/tool'),
		);
	}

	var $title;

	/**
	 * Standard modular pre-run function, so we know meta-data for <head> before we start streaming output.
	 *
	 * @return ?tempcode		Tempcode indicating some kind of exceptional output (NULL: none).
	 */
	function pre_run()
	{
		$type=get_param('type','misc');

		require_lang('customers');

		$this->title=get_screen_title('CHARGE_CUSTOMER');

		return NULL;
	}

	/**
	 * Standard modular run function.
	 *
	 * @return tempcode	The result of execution.
	 */
	function run()
	{
		$type=get_param('type','misc');

		if ($type=='charge') return $this->charge();
		if ($type=='_charge') return $this->_charge();
		if ($type=='misc') return $this->charge();

		return new ocp_tempcode();
	}

	/**
	 * The UI to charge a customer.
	 *
	 * @return tempcode		The UI
	 */
	function charge()
	{
		require_code('form_templates');

		$post_url=build_url(array('page'=>'_SELF','type'=>'_charge'),'_SELF');
		$submit_name=do_lang_tempcode('CHARGE');

		$username=get_param('username',NULL);
		if (is_null($username))
		{
			$member_id=get_param_integer('member_id',NULL);
			if (!is_null($member_id)) $username=$GLOBALS['FORUM_DRIVER']->get_username($member_id);
			else $username='';
		} else
		{
			$member_id=$GLOBALS['FORUM_DRIVER']->get_member_from_username($username);
		}

		$fields=new ocp_tempcode();
		$fields->attach(form_input_username(do_lang_tempcode('USERNAME'),'','member_username',$username,true));
		$fields->attach(form_input_integer(do_lang_tempcode('CREDIT_AMOUNT'),do_lang_tempcode('CREDIT_AMOUNT_DESCRIPTION'),'amount',get_param_integer('amount',3),true));
		$fields->attach(form_input_tick(do_lang_tempcode('ALLOW_OVERDRAFT'),do_lang_tempcode('DESCRIPTION_ALLOW_OVERDRAFT'),'allow_overdraft',true));

		if (!is_null($member_id))
		{
			$cpf_id=get_credits_profile_field_id();
			if (is_null($cpf_id))
			{
				$msg_tpl=warn_screen($this->title,do_lang_tempcode('INVALID_FIELD_ID'));
				$msg_tpl->evaluate_echo();
				return;
			}
			$num_credits=0;
			if (!is_null($cpf_id))
			{
				require_code('ocf_members_action2');
				$_fields=ocf_get_custom_field_mappings($member_id);
				$num_credits=intval($_fields['field_'.strval($cpf_id)]);
			}

			$text=do_lang_tempcode('CUSTOMER_CURRENTLY_HAS',escape_html(number_format($num_credits)));
		} else $text=new ocp_tempcode();

		return do_template('FORM_SCREEN',array('_GUID'=>'f91185ee725f47ffa652d5fef8d85c0b','TITLE'=>$this->title,'HIDDEN'=>'','TEXT'=>$text,'FIELDS'=>$fields,'SUBMIT_ICON'=>'buttons__proceed','SUBMIT_NAME'=>$submit_name,'URL'=>$post_url));
	}

	/**
	 * The actualiser to charge a customer.
	 *
	 * @return tempcode		The UI
	 */
	function _charge()
	{
		$username=post_param('member_username');
		$member_id=$GLOBALS['FORUM_DRIVER']->get_member_from_username($username);
		$amount=post_param_integer('amount');

		$cpf_id=get_credits_profile_field_id();
		if (is_null($cpf_id))
		{
			$msg_tpl=warn_screen($this->title,do_lang_tempcode('INVALID_FIELD_ID'));
			$msg_tpl->evaluate_echo();
			return;
		}

		// Increment the number of credits this customer has
		require_code('ocf_members_action2');
		$fields=ocf_get_custom_field_mappings($member_id);

		// Work out new total credits
		$new_amount=$fields['field_'.strval($cpf_id)]-$amount;
		if (post_param_integer('allow_overdraft',0)==0)
		{
			if ($new_amount<0) $new_amount=0;
		}

		ocf_set_custom_field($member_id,$cpf_id,$new_amount);

		// Show it worked / Refresh
		$url=build_url(array('page'=>'_SELF','type'=>'misc','username'=>$username),'_SELF');
		return redirect_screen($this->title,$url,do_lang_tempcode('SUCCESS'));
	}
}


