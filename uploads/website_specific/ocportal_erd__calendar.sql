		CREATE TABLE ocp_calendar_events
		(
			id integer auto_increment NULL,
			e_submitter integer NOT NULL,
			e_views integer NOT NULL,
			e_title integer NOT NULL,
			e_content integer NOT NULL,
			e_add_date integer unsigned NOT NULL,
			e_edit_date integer unsigned NOT NULL,
			e_recurrence varchar(80) NOT NULL,
			e_recurrences integer NOT NULL,
			e_seg_recurrences tinyint(1) NOT NULL,
			e_start_year integer NOT NULL,
			e_start_month integer NOT NULL,
			e_start_day integer NOT NULL,
			e_start_monthly_spec_type varchar(80) NOT NULL,
			e_start_hour integer NOT NULL,
			e_start_minute integer NOT NULL,
			e_end_year integer NOT NULL,
			e_end_month integer NOT NULL,
			e_end_day integer NOT NULL,
			e_end_monthly_spec_type varchar(80) NOT NULL,
			e_end_hour integer NOT NULL,
			e_end_minute integer NOT NULL,
			e_timezone varchar(80) NOT NULL,
			e_do_timezone_conv tinyint(1) NOT NULL,
			e_is_public tinyint(1) NOT NULL,
			e_priority integer NOT NULL,
			allow_rating tinyint(1) NOT NULL,
			allow_comments tinyint NOT NULL,
			allow_trackbacks tinyint(1) NOT NULL,
			notes longtext NOT NULL,
			e_type integer NOT NULL,
			validated tinyint(1) NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp_calendar_types
		(
			id integer auto_increment NULL,
			t_title integer NOT NULL,
			t_logo varchar(255) NOT NULL,
			t_external_feed varchar(255) NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp_calendar_reminders
		(
			id integer auto_increment NULL,
			e_id integer NOT NULL,
			n_member_id integer NOT NULL,
			n_seconds_before integer NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp_calendar_interests
		(
			i_member_id integer NULL,
			t_type integer NULL,
			PRIMARY KEY (i_member_id,t_type)
		) TYPE=InnoDB;

		CREATE TABLE ocp_calendar_jobs
		(
			id integer auto_increment NULL,
			j_time integer unsigned NOT NULL,
			j_reminder_id integer NOT NULL,
			j_member_id integer NOT NULL,
			j_event_id integer NOT NULL,
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


		CREATE INDEX `calendar_events.e_submitter` ON ocp_calendar_events(e_submitter);
		ALTER TABLE ocp_calendar_events ADD FOREIGN KEY `calendar_events.e_submitter` (e_submitter) REFERENCES ocp_f_members (id);

		CREATE INDEX `calendar_events.e_title` ON ocp_calendar_events(e_title);
		ALTER TABLE ocp_calendar_events ADD FOREIGN KEY `calendar_events.e_title` (e_title) REFERENCES ocp_translate (id);

		CREATE INDEX `calendar_events.e_content` ON ocp_calendar_events(e_content);
		ALTER TABLE ocp_calendar_events ADD FOREIGN KEY `calendar_events.e_content` (e_content) REFERENCES ocp_translate (id);

		CREATE INDEX `calendar_events.e_type` ON ocp_calendar_events(e_type);
		ALTER TABLE ocp_calendar_events ADD FOREIGN KEY `calendar_events.e_type` (e_type) REFERENCES ocp_calendar_types (id);

		CREATE INDEX `calendar_types.t_title` ON ocp_calendar_types(t_title);
		ALTER TABLE ocp_calendar_types ADD FOREIGN KEY `calendar_types.t_title` (t_title) REFERENCES ocp_translate (id);

		CREATE INDEX `calendar_reminders.e_id` ON ocp_calendar_reminders(e_id);
		ALTER TABLE ocp_calendar_reminders ADD FOREIGN KEY `calendar_reminders.e_id` (e_id) REFERENCES ocp_calendar_events (id);

		CREATE INDEX `calendar_reminders.n_member_id` ON ocp_calendar_reminders(n_member_id);
		ALTER TABLE ocp_calendar_reminders ADD FOREIGN KEY `calendar_reminders.n_member_id` (n_member_id) REFERENCES ocp_f_members (id);

		CREATE INDEX `calendar_interests.i_member_id` ON ocp_calendar_interests(i_member_id);
		ALTER TABLE ocp_calendar_interests ADD FOREIGN KEY `calendar_interests.i_member_id` (i_member_id) REFERENCES ocp_f_members (id);

		CREATE INDEX `calendar_interests.t_type` ON ocp_calendar_interests(t_type);
		ALTER TABLE ocp_calendar_interests ADD FOREIGN KEY `calendar_interests.t_type` (t_type) REFERENCES ocp_calendar_types (id);

		CREATE INDEX `calendar_jobs.j_reminder_id` ON ocp_calendar_jobs(j_reminder_id);
		ALTER TABLE ocp_calendar_jobs ADD FOREIGN KEY `calendar_jobs.j_reminder_id` (j_reminder_id) REFERENCES ocp_calendar_reminders (id);

		CREATE INDEX `calendar_jobs.j_member_id` ON ocp_calendar_jobs(j_member_id);
		ALTER TABLE ocp_calendar_jobs ADD FOREIGN KEY `calendar_jobs.j_member_id` (j_member_id) REFERENCES ocp_f_members (id);

		CREATE INDEX `calendar_jobs.j_event_id` ON ocp_calendar_jobs(j_event_id);
		ALTER TABLE ocp_calendar_jobs ADD FOREIGN KEY `calendar_jobs.j_event_id` (j_event_id) REFERENCES ocp_calendar_events (id);

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
