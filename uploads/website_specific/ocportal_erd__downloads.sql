		CREATE TABLE ocp6_download_categories
		(
			id integer auto_increment NULL,
			category integer NOT NULL,
			parent_id integer NOT NULL,
			add_date integer unsigned NOT NULL,
			notes longtext NOT NULL,
			description integer NOT NULL,
			rep_image varchar(255) NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp6_download_downloads
		(
			id integer auto_increment NULL,
			category_id integer NOT NULL,
			name integer NOT NULL,
			url varchar(255) NOT NULL,
			description integer NOT NULL,
			author varchar(80) NOT NULL,
			comments integer NOT NULL,
			num_downloads integer NOT NULL,
			out_mode_id integer NOT NULL,
			add_date integer unsigned NOT NULL,
			edit_date integer unsigned NOT NULL,
			validated tinyint(1) NOT NULL,
			default_pic integer NOT NULL,
			file_size integer NOT NULL,
			allow_rating tinyint(1) NOT NULL,
			allow_comments tinyint NOT NULL,
			allow_trackbacks tinyint(1) NOT NULL,
			notes longtext NOT NULL,
			download_views integer NOT NULL,
			download_cost integer NOT NULL,
			download_submitter_gets_points tinyint(1) NOT NULL,
			submitter integer NOT NULL,
			original_filename varchar(255) NOT NULL,
			rep_image varchar(255) NOT NULL,
			download_licence integer NOT NULL,
			download_data_mash longtext NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp6_download_logging
		(
			id integer NULL,
			the_user integer NULL,
			ip varchar(40) NOT NULL,
			date_and_time integer unsigned NOT NULL,
			PRIMARY KEY (id,the_user)
		) TYPE=InnoDB;

		CREATE TABLE ocp6_download_licences
		(
			id integer auto_increment NULL,
			l_title varchar(255) NOT NULL,
			l_text longtext NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp6_translate
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

		CREATE TABLE ocp6_authors
		(
			author varchar(80) NULL,
			url varchar(255) NOT NULL,
			forum_handle integer NOT NULL,
			description integer NOT NULL,
			skills integer NOT NULL,
			PRIMARY KEY (author)
		) TYPE=InnoDB;

		CREATE TABLE ocp6_f_members
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
			m_timezone_offset integer NOT NULL,
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
			m_track_contributed_topics tinyint(1) NOT NULL,
			m_language varchar(80) NOT NULL,
			m_ip_address varchar(40) NOT NULL,
			m_allow_emails tinyint(1) NOT NULL,
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

		CREATE TABLE ocp6_f_groups
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


		CREATE INDEX `download_categories.category` ON ocp6_download_categories(category);
		ALTER TABLE ocp6_download_categories ADD FOREIGN KEY `download_categories.category` (category) REFERENCES ocp6_translate (id);

		CREATE INDEX `download_categories.parent_id` ON ocp6_download_categories(parent_id);
		ALTER TABLE ocp6_download_categories ADD FOREIGN KEY `download_categories.parent_id` (parent_id) REFERENCES ocp6_download_categories (id);

		CREATE INDEX `download_categories.description` ON ocp6_download_categories(description);
		ALTER TABLE ocp6_download_categories ADD FOREIGN KEY `download_categories.description` (description) REFERENCES ocp6_translate (id);

		CREATE INDEX `download_downloads.category_id` ON ocp6_download_downloads(category_id);
		ALTER TABLE ocp6_download_downloads ADD FOREIGN KEY `download_downloads.category_id` (category_id) REFERENCES ocp6_download_categories (id);

		CREATE INDEX `download_downloads.name` ON ocp6_download_downloads(name);
		ALTER TABLE ocp6_download_downloads ADD FOREIGN KEY `download_downloads.name` (name) REFERENCES ocp6_translate (id);

		CREATE INDEX `download_downloads.description` ON ocp6_download_downloads(description);
		ALTER TABLE ocp6_download_downloads ADD FOREIGN KEY `download_downloads.description` (description) REFERENCES ocp6_translate (id);

		CREATE INDEX `download_downloads.author` ON ocp6_download_downloads(author);
		ALTER TABLE ocp6_download_downloads ADD FOREIGN KEY `download_downloads.author` (author) REFERENCES ocp6_authors (author);

		CREATE INDEX `download_downloads.comments` ON ocp6_download_downloads(comments);
		ALTER TABLE ocp6_download_downloads ADD FOREIGN KEY `download_downloads.comments` (comments) REFERENCES ocp6_translate (id);

		CREATE INDEX `download_downloads.out_mode_id` ON ocp6_download_downloads(out_mode_id);
		ALTER TABLE ocp6_download_downloads ADD FOREIGN KEY `download_downloads.out_mode_id` (out_mode_id) REFERENCES ocp6_download_downloads (id);

		CREATE INDEX `download_downloads.submitter` ON ocp6_download_downloads(submitter);
		ALTER TABLE ocp6_download_downloads ADD FOREIGN KEY `download_downloads.submitter` (submitter) REFERENCES ocp6_f_members (id);

		CREATE INDEX `download_downloads.download_licence` ON ocp6_download_downloads(download_licence);
		ALTER TABLE ocp6_download_downloads ADD FOREIGN KEY `download_downloads.download_licence` (download_licence) REFERENCES ocp6_download_licences (id);

		CREATE INDEX `download_logging.id` ON ocp6_download_logging(id);
		ALTER TABLE ocp6_download_logging ADD FOREIGN KEY `download_logging.id` (id) REFERENCES ocp6_download_downloads (id);

		CREATE INDEX `download_logging.the_user` ON ocp6_download_logging(the_user);
		ALTER TABLE ocp6_download_logging ADD FOREIGN KEY `download_logging.the_user` (the_user) REFERENCES ocp6_f_members (id);

		CREATE INDEX `translate.source_user` ON ocp6_translate(source_user);
		ALTER TABLE ocp6_translate ADD FOREIGN KEY `translate.source_user` (source_user) REFERENCES ocp6_f_members (id);

		CREATE INDEX `authors.forum_handle` ON ocp6_authors(forum_handle);
		ALTER TABLE ocp6_authors ADD FOREIGN KEY `authors.forum_handle` (forum_handle) REFERENCES ocp6_f_members (id);

		CREATE INDEX `authors.description` ON ocp6_authors(description);
		ALTER TABLE ocp6_authors ADD FOREIGN KEY `authors.description` (description) REFERENCES ocp6_translate (id);

		CREATE INDEX `authors.skills` ON ocp6_authors(skills);
		ALTER TABLE ocp6_authors ADD FOREIGN KEY `authors.skills` (skills) REFERENCES ocp6_translate (id);

		CREATE INDEX `f_members.m_primary_group` ON ocp6_f_members(m_primary_group);
		ALTER TABLE ocp6_f_members ADD FOREIGN KEY `f_members.m_primary_group` (m_primary_group) REFERENCES ocp6_f_groups (id);

		CREATE INDEX `f_members.m_signature` ON ocp6_f_members(m_signature);
		ALTER TABLE ocp6_f_members ADD FOREIGN KEY `f_members.m_signature` (m_signature) REFERENCES ocp6_translate (id);

		CREATE INDEX `f_members.m_pt_rules_text` ON ocp6_f_members(m_pt_rules_text);
		ALTER TABLE ocp6_f_members ADD FOREIGN KEY `f_members.m_pt_rules_text` (m_pt_rules_text) REFERENCES ocp6_translate (id);

		CREATE INDEX `f_groups.g_name` ON ocp6_f_groups(g_name);
		ALTER TABLE ocp6_f_groups ADD FOREIGN KEY `f_groups.g_name` (g_name) REFERENCES ocp6_translate (id);

		CREATE INDEX `f_groups.g_group_leader` ON ocp6_f_groups(g_group_leader);
		ALTER TABLE ocp6_f_groups ADD FOREIGN KEY `f_groups.g_group_leader` (g_group_leader) REFERENCES ocp6_f_members (id);

		CREATE INDEX `f_groups.g_title` ON ocp6_f_groups(g_title);
		ALTER TABLE ocp6_f_groups ADD FOREIGN KEY `f_groups.g_title` (g_title) REFERENCES ocp6_translate (id);

		CREATE INDEX `f_groups.g_promotion_target` ON ocp6_f_groups(g_promotion_target);
		ALTER TABLE ocp6_f_groups ADD FOREIGN KEY `f_groups.g_promotion_target` (g_promotion_target) REFERENCES ocp6_f_groups (id);
