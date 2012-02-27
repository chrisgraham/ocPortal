		CREATE TABLE ocp_chat_rooms
		(
			id integer auto_increment NULL,
			room_name varchar(255) NOT NULL,
			room_owner integer NOT NULL,
			allow_list longtext NOT NULL,
			allow_list_groups longtext NOT NULL,
			disallow_list longtext NOT NULL,
			disallow_list_groups longtext NOT NULL,
			room_language varchar(5) NOT NULL,
			c_welcome integer NOT NULL,
			is_im tinyint(1) NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp_chat_messages
		(
			id integer auto_increment NULL,
			system_message tinyint(1) NOT NULL,
			ip_address varchar(40) NOT NULL,
			room_id integer NOT NULL,
			user_id integer NOT NULL,
			date_and_time integer unsigned NOT NULL,
			the_message integer NOT NULL,
			text_colour varchar(255) NOT NULL,
			font_name varchar(255) NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp_chat_blocking
		(
			member_blocker integer NULL,
			member_blocked integer NULL,
			date_and_time integer unsigned NOT NULL,
			PRIMARY KEY (member_blocker,member_blocked)
		) TYPE=InnoDB;

		CREATE TABLE ocp_chat_buddies
		(
			member_likes integer NULL,
			member_liked integer NULL,
			date_and_time integer unsigned NOT NULL,
			PRIMARY KEY (member_likes,member_liked)
		) TYPE=InnoDB;

		CREATE TABLE ocp_chat_events
		(
			id integer auto_increment NULL,
			e_type_code varchar(80) NOT NULL,
			e_member_id integer NOT NULL,
			e_room_id integer NOT NULL,
			e_date_and_time integer unsigned NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp_chat_active
		(
			id integer auto_increment NULL,
			member_id integer NOT NULL,
			room_id integer NOT NULL,
			date_and_time integer unsigned NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp_chat_sound_effects
		(
			s_member integer NULL,
			s_effect_id varchar(80) NULL,
			s_url varchar(255) NOT NULL,
			PRIMARY KEY (s_member,s_effect_id)
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


		CREATE INDEX `chat_rooms.c_welcome` ON ocp_chat_rooms(c_welcome);
		ALTER TABLE ocp_chat_rooms ADD FOREIGN KEY `chat_rooms.c_welcome` (c_welcome) REFERENCES ocp_translate (id);

		CREATE INDEX `chat_messages.room_id` ON ocp_chat_messages(room_id);
		ALTER TABLE ocp_chat_messages ADD FOREIGN KEY `chat_messages.room_id` (room_id) REFERENCES ocp_chat_rooms (id);

		CREATE INDEX `chat_messages.user_id` ON ocp_chat_messages(user_id);
		ALTER TABLE ocp_chat_messages ADD FOREIGN KEY `chat_messages.user_id` (user_id) REFERENCES ocp_f_members (id);

		CREATE INDEX `chat_messages.the_message` ON ocp_chat_messages(the_message);
		ALTER TABLE ocp_chat_messages ADD FOREIGN KEY `chat_messages.the_message` (the_message) REFERENCES ocp_translate (id);

		CREATE INDEX `chat_blocking.member_blocker` ON ocp_chat_blocking(member_blocker);
		ALTER TABLE ocp_chat_blocking ADD FOREIGN KEY `chat_blocking.member_blocker` (member_blocker) REFERENCES ocp_f_members (id);

		CREATE INDEX `chat_blocking.member_blocked` ON ocp_chat_blocking(member_blocked);
		ALTER TABLE ocp_chat_blocking ADD FOREIGN KEY `chat_blocking.member_blocked` (member_blocked) REFERENCES ocp_f_members (id);

		CREATE INDEX `chat_buddies.member_likes` ON ocp_chat_buddies(member_likes);
		ALTER TABLE ocp_chat_buddies ADD FOREIGN KEY `chat_buddies.member_likes` (member_likes) REFERENCES ocp_f_members (id);

		CREATE INDEX `chat_buddies.member_liked` ON ocp_chat_buddies(member_liked);
		ALTER TABLE ocp_chat_buddies ADD FOREIGN KEY `chat_buddies.member_liked` (member_liked) REFERENCES ocp_f_members (id);

		CREATE INDEX `chat_events.e_member_id` ON ocp_chat_events(e_member_id);
		ALTER TABLE ocp_chat_events ADD FOREIGN KEY `chat_events.e_member_id` (e_member_id) REFERENCES ocp_f_members (id);

		CREATE INDEX `chat_events.e_room_id` ON ocp_chat_events(e_room_id);
		ALTER TABLE ocp_chat_events ADD FOREIGN KEY `chat_events.e_room_id` (e_room_id) REFERENCES ocp_chat_rooms (id);

		CREATE INDEX `chat_active.member_id` ON ocp_chat_active(member_id);
		ALTER TABLE ocp_chat_active ADD FOREIGN KEY `chat_active.member_id` (member_id) REFERENCES ocp_f_members (id);

		CREATE INDEX `chat_active.room_id` ON ocp_chat_active(room_id);
		ALTER TABLE ocp_chat_active ADD FOREIGN KEY `chat_active.room_id` (room_id) REFERENCES ocp_chat_rooms (id);

		CREATE INDEX `chat_sound_effects.s_member` ON ocp_chat_sound_effects(s_member);
		ALTER TABLE ocp_chat_sound_effects ADD FOREIGN KEY `chat_sound_effects.s_member` (s_member) REFERENCES ocp_f_members (id);

		CREATE INDEX `translate.source_user` ON ocp_translate(source_user);
		ALTER TABLE ocp_translate ADD FOREIGN KEY `translate.source_user` (source_user) REFERENCES ocp_f_members (id);

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
