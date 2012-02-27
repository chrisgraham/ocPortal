		CREATE TABLE ocp_seedy_changes
		(
			id integer auto_increment NULL,
			the_action varchar(80) NOT NULL,
			the_page integer NOT NULL,
			date_and_time integer unsigned NOT NULL,
			ip varchar(40) NOT NULL,
			the_user integer NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp_seedy_children
		(
			parent_id integer NULL,
			child_id integer NULL,
			the_order integer NOT NULL,
			title varchar(255) NOT NULL,
			PRIMARY KEY (parent_id,child_id)
		) TYPE=InnoDB;

		CREATE TABLE ocp_seedy_pages
		(
			id integer auto_increment NULL,
			title integer NOT NULL,
			notes longtext NOT NULL,
			description integer NOT NULL,
			add_date integer unsigned NOT NULL,
			seedy_views integer NOT NULL,
			hide_posts tinyint(1) NOT NULL,
			submitter integer NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp_seedy_posts
		(
			id integer auto_increment NULL,
			page_id integer NOT NULL,
			the_message integer NOT NULL,
			date_and_time integer unsigned NOT NULL,
			validated tinyint(1) NOT NULL,
			seedy_views integer NOT NULL,
			the_user integer NOT NULL,
			edit_date integer unsigned NOT NULL,
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


		CREATE INDEX `seedy_changes.the_page` ON ocp_seedy_changes(the_page);
		ALTER TABLE ocp_seedy_changes ADD FOREIGN KEY `seedy_changes.the_page` (the_page) REFERENCES ocp_seedy_pages (id);

		CREATE INDEX `seedy_changes.the_user` ON ocp_seedy_changes(the_user);
		ALTER TABLE ocp_seedy_changes ADD FOREIGN KEY `seedy_changes.the_user` (the_user) REFERENCES ocp_f_members (id);

		CREATE INDEX `seedy_children.parent_id` ON ocp_seedy_children(parent_id);
		ALTER TABLE ocp_seedy_children ADD FOREIGN KEY `seedy_children.parent_id` (parent_id) REFERENCES ocp_seedy_pages (id);

		CREATE INDEX `seedy_children.child_id` ON ocp_seedy_children(child_id);
		ALTER TABLE ocp_seedy_children ADD FOREIGN KEY `seedy_children.child_id` (child_id) REFERENCES ocp_seedy_pages (id);

		CREATE INDEX `seedy_pages.title` ON ocp_seedy_pages(title);
		ALTER TABLE ocp_seedy_pages ADD FOREIGN KEY `seedy_pages.title` (title) REFERENCES ocp_translate (id);

		CREATE INDEX `seedy_pages.description` ON ocp_seedy_pages(description);
		ALTER TABLE ocp_seedy_pages ADD FOREIGN KEY `seedy_pages.description` (description) REFERENCES ocp_translate (id);

		CREATE INDEX `seedy_pages.submitter` ON ocp_seedy_pages(submitter);
		ALTER TABLE ocp_seedy_pages ADD FOREIGN KEY `seedy_pages.submitter` (submitter) REFERENCES ocp_f_members (id);

		CREATE INDEX `seedy_posts.page_id` ON ocp_seedy_posts(page_id);
		ALTER TABLE ocp_seedy_posts ADD FOREIGN KEY `seedy_posts.page_id` (page_id) REFERENCES ocp_seedy_pages (id);

		CREATE INDEX `seedy_posts.the_message` ON ocp_seedy_posts(the_message);
		ALTER TABLE ocp_seedy_posts ADD FOREIGN KEY `seedy_posts.the_message` (the_message) REFERENCES ocp_translate (id);

		CREATE INDEX `seedy_posts.the_user` ON ocp_seedy_posts(the_user);
		ALTER TABLE ocp_seedy_posts ADD FOREIGN KEY `seedy_posts.the_user` (the_user) REFERENCES ocp_f_members (id);

		CREATE INDEX `f_members.m_primary_group` ON ocp_f_members(m_primary_group);
		ALTER TABLE ocp_f_members ADD FOREIGN KEY `f_members.m_primary_group` (m_primary_group) REFERENCES ocp_f_groups (id);

		CREATE INDEX `f_members.m_signature` ON ocp_f_members(m_signature);
		ALTER TABLE ocp_f_members ADD FOREIGN KEY `f_members.m_signature` (m_signature) REFERENCES ocp_translate (id);

		CREATE INDEX `f_members.m_pt_rules_text` ON ocp_f_members(m_pt_rules_text);
		ALTER TABLE ocp_f_members ADD FOREIGN KEY `f_members.m_pt_rules_text` (m_pt_rules_text) REFERENCES ocp_translate (id);

		CREATE INDEX `translate.source_user` ON ocp_translate(source_user);
		ALTER TABLE ocp_translate ADD FOREIGN KEY `translate.source_user` (source_user) REFERENCES ocp_f_members (id);

		CREATE INDEX `f_groups.g_name` ON ocp_f_groups(g_name);
		ALTER TABLE ocp_f_groups ADD FOREIGN KEY `f_groups.g_name` (g_name) REFERENCES ocp_translate (id);

		CREATE INDEX `f_groups.g_group_leader` ON ocp_f_groups(g_group_leader);
		ALTER TABLE ocp_f_groups ADD FOREIGN KEY `f_groups.g_group_leader` (g_group_leader) REFERENCES ocp_f_members (id);

		CREATE INDEX `f_groups.g_title` ON ocp_f_groups(g_title);
		ALTER TABLE ocp_f_groups ADD FOREIGN KEY `f_groups.g_title` (g_title) REFERENCES ocp_translate (id);

		CREATE INDEX `f_groups.g_promotion_target` ON ocp_f_groups(g_promotion_target);
		ALTER TABLE ocp_f_groups ADD FOREIGN KEY `f_groups.g_promotion_target` (g_promotion_target) REFERENCES ocp_f_groups (id);
