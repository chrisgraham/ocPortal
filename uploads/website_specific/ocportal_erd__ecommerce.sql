		CREATE TABLE ocp6_trans_expecting
		(
			id varchar(80) NULL,
			e_purchase_id varchar(80) NOT NULL,
			e_item_name varchar(255) NOT NULL,
			e_member_id integer NOT NULL,
			e_amount varchar(255) NOT NULL,
			e_ip_address varchar(40) NOT NULL,
			e_session_id integer NOT NULL,
			e_time integer unsigned NOT NULL,
			e_length integer NOT NULL,
			e_length_units varchar(80) NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp6_transactions
		(
			id varchar(80) NULL,
			purchase_id varchar(80) NOT NULL,
			status varchar(255) NOT NULL,
			reason varchar(255) NOT NULL,
			amount varchar(255) NOT NULL,
			t_currency varchar(80) NOT NULL,
			linked varchar(80) NOT NULL,
			t_time integer unsigned NULL,
			item varchar(255) NOT NULL,
			pending_reason varchar(255) NOT NULL,
			t_memo longtext NOT NULL,
			t_via varchar(80) NOT NULL,
			PRIMARY KEY (id,t_time)
		) TYPE=InnoDB;

		CREATE TABLE ocp6_subscriptions
		(
			id integer auto_increment NULL,
			s_type_code varchar(80) NOT NULL,
			s_member_id integer NOT NULL,
			s_state varchar(80) NOT NULL,
			s_amount varchar(255) NOT NULL,
			s_special varchar(255) NOT NULL,
			s_time integer unsigned NOT NULL,
			s_auto_fund_source varchar(80) NOT NULL,
			s_auto_fund_key varchar(255) NOT NULL,
			s_via varchar(80) NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp6_f_usergroup_subs
		(
			id integer auto_increment NULL,
			s_title integer NOT NULL,
			s_description integer NOT NULL,
			s_cost varchar(255) NOT NULL,
			s_length integer NOT NULL,
			s_length_units varchar(255) NOT NULL,
			s_group_id integer NOT NULL,
			s_enabled tinyint(1) NOT NULL,
			s_mail_start integer NOT NULL,
			s_mail_end integer NOT NULL,
			s_mail_uhoh integer NOT NULL,
			s_uses_primary tinyint(1) NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp6_invoices
		(
			id integer auto_increment NULL,
			i_type_code varchar(80) NOT NULL,
			i_member_id integer NOT NULL,
			i_state varchar(80) NOT NULL,
			i_amount varchar(255) NOT NULL,
			i_special varchar(255) NOT NULL,
			i_time integer unsigned NOT NULL,
			i_note longtext NOT NULL,
			PRIMARY KEY (id)
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


		CREATE INDEX `trans_expecting.e_member_id` ON ocp6_trans_expecting(e_member_id);
		ALTER TABLE ocp6_trans_expecting ADD FOREIGN KEY `trans_expecting.e_member_id` (e_member_id) REFERENCES ocp6_f_members (id);

		CREATE INDEX `subscriptions.s_member_id` ON ocp6_subscriptions(s_member_id);
		ALTER TABLE ocp6_subscriptions ADD FOREIGN KEY `subscriptions.s_member_id` (s_member_id) REFERENCES ocp6_f_members (id);

		CREATE INDEX `f_usergroup_subs.s_title` ON ocp6_f_usergroup_subs(s_title);
		ALTER TABLE ocp6_f_usergroup_subs ADD FOREIGN KEY `f_usergroup_subs.s_title` (s_title) REFERENCES ocp6_translate (id);

		CREATE INDEX `f_usergroup_subs.s_description` ON ocp6_f_usergroup_subs(s_description);
		ALTER TABLE ocp6_f_usergroup_subs ADD FOREIGN KEY `f_usergroup_subs.s_description` (s_description) REFERENCES ocp6_translate (id);

		CREATE INDEX `f_usergroup_subs.s_group_id` ON ocp6_f_usergroup_subs(s_group_id);
		ALTER TABLE ocp6_f_usergroup_subs ADD FOREIGN KEY `f_usergroup_subs.s_group_id` (s_group_id) REFERENCES ocp6_f_groups (id);

		CREATE INDEX `f_usergroup_subs.s_mail_start` ON ocp6_f_usergroup_subs(s_mail_start);
		ALTER TABLE ocp6_f_usergroup_subs ADD FOREIGN KEY `f_usergroup_subs.s_mail_start` (s_mail_start) REFERENCES ocp6_translate (id);

		CREATE INDEX `f_usergroup_subs.s_mail_end` ON ocp6_f_usergroup_subs(s_mail_end);
		ALTER TABLE ocp6_f_usergroup_subs ADD FOREIGN KEY `f_usergroup_subs.s_mail_end` (s_mail_end) REFERENCES ocp6_translate (id);

		CREATE INDEX `f_usergroup_subs.s_mail_uhoh` ON ocp6_f_usergroup_subs(s_mail_uhoh);
		ALTER TABLE ocp6_f_usergroup_subs ADD FOREIGN KEY `f_usergroup_subs.s_mail_uhoh` (s_mail_uhoh) REFERENCES ocp6_translate (id);

		CREATE INDEX `invoices.i_member_id` ON ocp6_invoices(i_member_id);
		ALTER TABLE ocp6_invoices ADD FOREIGN KEY `invoices.i_member_id` (i_member_id) REFERENCES ocp6_f_members (id);

		CREATE INDEX `f_members.m_primary_group` ON ocp6_f_members(m_primary_group);
		ALTER TABLE ocp6_f_members ADD FOREIGN KEY `f_members.m_primary_group` (m_primary_group) REFERENCES ocp6_f_groups (id);

		CREATE INDEX `f_members.m_signature` ON ocp6_f_members(m_signature);
		ALTER TABLE ocp6_f_members ADD FOREIGN KEY `f_members.m_signature` (m_signature) REFERENCES ocp6_translate (id);

		CREATE INDEX `f_members.m_pt_rules_text` ON ocp6_f_members(m_pt_rules_text);
		ALTER TABLE ocp6_f_members ADD FOREIGN KEY `f_members.m_pt_rules_text` (m_pt_rules_text) REFERENCES ocp6_translate (id);

		CREATE INDEX `translate.source_user` ON ocp6_translate(source_user);
		ALTER TABLE ocp6_translate ADD FOREIGN KEY `translate.source_user` (source_user) REFERENCES ocp6_f_members (id);

		CREATE INDEX `f_groups.g_name` ON ocp6_f_groups(g_name);
		ALTER TABLE ocp6_f_groups ADD FOREIGN KEY `f_groups.g_name` (g_name) REFERENCES ocp6_translate (id);

		CREATE INDEX `f_groups.g_group_leader` ON ocp6_f_groups(g_group_leader);
		ALTER TABLE ocp6_f_groups ADD FOREIGN KEY `f_groups.g_group_leader` (g_group_leader) REFERENCES ocp6_f_members (id);

		CREATE INDEX `f_groups.g_title` ON ocp6_f_groups(g_title);
		ALTER TABLE ocp6_f_groups ADD FOREIGN KEY `f_groups.g_title` (g_title) REFERENCES ocp6_translate (id);

		CREATE INDEX `f_groups.g_promotion_target` ON ocp6_f_groups(g_promotion_target);
		ALTER TABLE ocp6_f_groups ADD FOREIGN KEY `f_groups.g_promotion_target` (g_promotion_target) REFERENCES ocp6_f_groups (id);
