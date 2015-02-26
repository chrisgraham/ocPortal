		CREATE TABLE ocp_pstore_customs
		(
			id integer auto_increment NULL,
			c_title integer NOT NULL,
			c_description integer NOT NULL,
			c_mail_subject integer NOT NULL,
			c_mail_body integer NOT NULL,
			c_enabled tinyint(1) NOT NULL,
			c_cost integer NOT NULL,
			c_one_per_member tinyint(1) NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp_pstore_permissions
		(
			id integer auto_increment NULL,
			p_title integer NOT NULL,
			p_description integer NOT NULL,
			p_mail_subject integer NOT NULL,
			p_mail_body integer NOT NULL,
			p_enabled tinyint(1) NOT NULL,
			p_cost integer NOT NULL,
			p_hours integer NOT NULL,
			p_type varchar(80) NOT NULL,
			p_specific_permission varchar(80) NOT NULL,
			p_zone varchar(80) NOT NULL,
			p_page varchar(80) NOT NULL,
			p_module varchar(80) NOT NULL,
			p_category varchar(80) NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp_prices
		(
			name varchar(80) NULL,
			price integer NOT NULL,
			PRIMARY KEY (name)
		) TYPE=InnoDB;

		CREATE TABLE ocp_sales
		(
			id integer auto_increment NULL,
			date_and_time integer unsigned NOT NULL,
			memberid integer NOT NULL,
			purchasetype varchar(80) NOT NULL,
			details varchar(255) NOT NULL,
			details2 varchar(255) NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp_translate
		(
			id integer auto_increment NULL,
			language varchar(5) NULL,
			importance_level tinyint NOT NULL,
			text_original longtext NOT NULL,
			text_parsed longtext NOT NULL,
			broken tinyint(1) NOT NULL,
			source_user integer NOT NULL,
			PRIMARY KEY (id,language)
		) TYPE=InnoDB;

		CREATE TABLE ocp_sp_list
		(
			p_section varchar(80) NOT NULL,
			the_name varchar(80) NULL,
			the_default tinyint(1) NULL,
			PRIMARY KEY (the_name,the_default)
		) TYPE=InnoDB;

		CREATE TABLE ocp_zones
		(
			zone_name varchar(80) NULL,
			zone_title integer NOT NULL,
			zone_default_page varchar(80) NOT NULL,
			zone_header_text integer NOT NULL,
			zone_theme varchar(80) NOT NULL,
			zone_wide tinyint(1) NOT NULL,
			zone_require_session tinyint(1) NOT NULL,
			zone_displayed_in_menu tinyint(1) NOT NULL,
			PRIMARY KEY (zone_name)
		) TYPE=InnoDB;

		CREATE TABLE ocp_modules
		(
			module_the_name varchar(80) NULL,
			module_author varchar(80) NOT NULL,
			module_organisation varchar(80) NOT NULL,
			module_hacked_by varchar(80) NOT NULL,
			module_hack_version integer NOT NULL,
			module_version integer NOT NULL,
			PRIMARY KEY (module_the_name)
		) TYPE=InnoDB;

		CREATE TABLE ocp_anything
		(
			id varchar(80) NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp_f_members
		(
			id integer auto_increment NULL,
			m_username varchar(80) NOT NULL,
			m_pass_hash_salted varchar(255) NOT NULL,
			m_pass_salt varchar(255) NOT NULL,
			m_theme varchar(80) NOT NULL,
			m_avatar_url varchar(255) NOT NULL,
			m_validated tinyint(1) NOT NULL,
			m_validated_email_confirm_code varchar(255) NOT NULL,
			m_cache_num_posts integer NOT NULL,
			m_cache_warnings integer NOT NULL,
			m_join_time integer unsigned NOT NULL,
			m_timezone_offset varchar(255) NOT NULL,
			m_primary_group integer NOT NULL,
			m_last_visit_time integer unsigned NOT NULL,
			m_last_submit_time integer unsigned NOT NULL,
			m_signature integer NOT NULL,
			m_is_perm_banned tinyint(1) NOT NULL,
			m_preview_posts tinyint(1) NOT NULL,
			m_dob_day integer NOT NULL,
			m_dob_month integer NOT NULL,
			m_dob_year integer NOT NULL,
			m_reveal_age tinyint(1) NOT NULL,
			m_email_address varchar(255) NOT NULL,
			m_title varchar(255) NOT NULL,
			m_photo_url varchar(255) NOT NULL,
			m_photo_thumb_url varchar(255) NOT NULL,
			m_views_signatures tinyint(1) NOT NULL,
			m_auto_monitor_contrib_content tinyint(1) NOT NULL,
			m_language varchar(80) NOT NULL,
			m_ip_address varchar(40) NOT NULL,
			m_allow_emails tinyint(1) NOT NULL,
			m_allow_emails_from_staff tinyint(1) NOT NULL,
			m_notes longtext NOT NULL,
			m_zone_wide tinyint(1) NOT NULL,
			m_highlighted_name tinyint(1) NOT NULL,
			m_pt_allow varchar(255) NOT NULL,
			m_pt_rules_text integer NOT NULL,
			m_max_email_attach_size_mb integer NOT NULL,
			m_password_change_code varchar(255) NOT NULL,
			m_password_compat_scheme varchar(80) NOT NULL,
			m_on_probation_until integer unsigned NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp_f_groups
		(
			id integer auto_increment NULL,
			g_name integer NOT NULL,
			g_is_default tinyint(1) NOT NULL,
			g_is_presented_at_install tinyint(1) NOT NULL,
			g_is_super_admin tinyint(1) NOT NULL,
			g_is_super_moderator tinyint(1) NOT NULL,
			g_group_leader integer NOT NULL,
			g_title integer NOT NULL,
			g_promotion_target integer NOT NULL,
			g_promotion_threshold integer NOT NULL,
			g_flood_control_submit_secs integer NOT NULL,
			g_flood_control_access_secs integer NOT NULL,
			g_gift_points_base integer NOT NULL,
			g_gift_points_per_day integer NOT NULL,
			g_max_daily_upload_mb integer NOT NULL,
			g_max_attachments_per_post integer NOT NULL,
			g_max_avatar_width integer NOT NULL,
			g_max_avatar_height integer NOT NULL,
			g_max_post_length_comcode integer NOT NULL,
			g_max_sig_length_comcode integer NOT NULL,
			g_enquire_on_new_ips tinyint(1) NOT NULL,
			g_rank_image varchar(80) NOT NULL,
			g_hidden tinyint(1) NOT NULL,
			g_order integer NOT NULL,
			g_rank_image_pri_only tinyint(1) NOT NULL,
			g_open_membership tinyint(1) NOT NULL,
			g_is_private_club tinyint(1) NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;


		CREATE INDEX `pstore_customs.c_title` ON ocp_pstore_customs(c_title);
		ALTER TABLE ocp_pstore_customs ADD FOREIGN KEY `pstore_customs.c_title` (c_title) REFERENCES ocp_translate (id);

		CREATE INDEX `pstore_customs.c_description` ON ocp_pstore_customs(c_description);
		ALTER TABLE ocp_pstore_customs ADD FOREIGN KEY `pstore_customs.c_description` (c_description) REFERENCES ocp_translate (id);

		CREATE INDEX `pstore_customs.c_mail_subject` ON ocp_pstore_customs(c_mail_subject);
		ALTER TABLE ocp_pstore_customs ADD FOREIGN KEY `pstore_customs.c_mail_subject` (c_mail_subject) REFERENCES ocp_translate (id);

		CREATE INDEX `pstore_customs.c_mail_body` ON ocp_pstore_customs(c_mail_body);
		ALTER TABLE ocp_pstore_customs ADD FOREIGN KEY `pstore_customs.c_mail_body` (c_mail_body) REFERENCES ocp_translate (id);

		CREATE INDEX `pstore_permissions.p_title` ON ocp_pstore_permissions(p_title);
		ALTER TABLE ocp_pstore_permissions ADD FOREIGN KEY `pstore_permissions.p_title` (p_title) REFERENCES ocp_translate (id);

		CREATE INDEX `pstore_permissions.p_description` ON ocp_pstore_permissions(p_description);
		ALTER TABLE ocp_pstore_permissions ADD FOREIGN KEY `pstore_permissions.p_description` (p_description) REFERENCES ocp_translate (id);

		CREATE INDEX `pstore_permissions.p_mail_subject` ON ocp_pstore_permissions(p_mail_subject);
		ALTER TABLE ocp_pstore_permissions ADD FOREIGN KEY `pstore_permissions.p_mail_subject` (p_mail_subject) REFERENCES ocp_translate (id);

		CREATE INDEX `pstore_permissions.p_mail_body` ON ocp_pstore_permissions(p_mail_body);
		ALTER TABLE ocp_pstore_permissions ADD FOREIGN KEY `pstore_permissions.p_mail_body` (p_mail_body) REFERENCES ocp_translate (id);

		CREATE INDEX `pstore_permissions.p_specific_permission` ON ocp_pstore_permissions(p_specific_permission);
		ALTER TABLE ocp_pstore_permissions ADD FOREIGN KEY `pstore_permissions.p_specific_permission` (p_specific_permission) REFERENCES ocp_sp_list (the_name);

		CREATE INDEX `pstore_permissions.p_zone` ON ocp_pstore_permissions(p_zone);
		ALTER TABLE ocp_pstore_permissions ADD FOREIGN KEY `pstore_permissions.p_zone` (p_zone) REFERENCES ocp_zones (zone_name);

		CREATE INDEX `pstore_permissions.p_page` ON ocp_pstore_permissions(p_page);
		ALTER TABLE ocp_pstore_permissions ADD FOREIGN KEY `pstore_permissions.p_page` (p_page) REFERENCES ocp_modules (module_the_name);

		CREATE INDEX `pstore_permissions.p_category` ON ocp_pstore_permissions(p_category);
		ALTER TABLE ocp_pstore_permissions ADD FOREIGN KEY `pstore_permissions.p_category` (p_category) REFERENCES ocp_anything (id);

		CREATE INDEX `sales.memberid` ON ocp_sales(memberid);
		ALTER TABLE ocp_sales ADD FOREIGN KEY `sales.memberid` (memberid) REFERENCES ocp_f_members (id);

		CREATE INDEX `translate.source_user` ON ocp_translate(source_user);
		ALTER TABLE ocp_translate ADD FOREIGN KEY `translate.source_user` (source_user) REFERENCES ocp_f_members (id);

		CREATE INDEX `zones.zone_title` ON ocp_zones(zone_title);
		ALTER TABLE ocp_zones ADD FOREIGN KEY `zones.zone_title` (zone_title) REFERENCES ocp_translate (id);

		CREATE INDEX `zones.zone_header_text` ON ocp_zones(zone_header_text);
		ALTER TABLE ocp_zones ADD FOREIGN KEY `zones.zone_header_text` (zone_header_text) REFERENCES ocp_translate (id);

		CREATE INDEX `f_members.m_primary_group` ON ocp_f_members(m_primary_group);
		ALTER TABLE ocp_f_members ADD FOREIGN KEY `f_members.m_primary_group` (m_primary_group) REFERENCES ocp_f_groups (id);

		CREATE INDEX `f_members.m_signature` ON ocp_f_members(m_signature);
		ALTER TABLE ocp_f_members ADD FOREIGN KEY `f_members.m_signature` (m_signature) REFERENCES ocp_translate (id);

		CREATE INDEX `f_members.m_pt_rules_text` ON ocp_f_members(m_pt_rules_text);
		ALTER TABLE ocp_f_members ADD FOREIGN KEY `f_members.m_pt_rules_text` (m_pt_rules_text) REFERENCES ocp_translate (id);

		CREATE INDEX `f_groups.g_name` ON ocp_f_groups(g_name);
		ALTER TABLE ocp_f_groups ADD FOREIGN KEY `f_groups.g_name` (g_name) REFERENCES ocp_translate (id);

		CREATE INDEX `f_groups.g_group_leader` ON ocp_f_groups(g_group_leader);
		ALTER TABLE ocp_f_groups ADD FOREIGN KEY `f_groups.g_group_leader` (g_group_leader) REFERENCES ocp_f_members (id);

		CREATE INDEX `f_groups.g_title` ON ocp_f_groups(g_title);
		ALTER TABLE ocp_f_groups ADD FOREIGN KEY `f_groups.g_title` (g_title) REFERENCES ocp_translate (id);

		CREATE INDEX `f_groups.g_promotion_target` ON ocp_f_groups(g_promotion_target);
		ALTER TABLE ocp_f_groups ADD FOREIGN KEY `f_groups.g_promotion_target` (g_promotion_target) REFERENCES ocp_f_groups (id);
