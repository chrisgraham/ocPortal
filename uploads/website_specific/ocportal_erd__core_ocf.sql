		CREATE TABLE ocp_f_categories
		(
			id integer auto_increment NULL,
			c_title varchar(255) NOT NULL,
			c_description longtext NOT NULL,
			c_expanded_by_default tinyint(1) NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp_f_custom_fields
		(
			id integer auto_increment NULL,
			cf_locked tinyint(1) NOT NULL,
			cf_name integer NOT NULL,
			cf_description integer NOT NULL,
			cf_default longtext NOT NULL,
			cf_public_view tinyint(1) NOT NULL,
			cf_owner_view tinyint(1) NOT NULL,
			cf_owner_set tinyint(1) NOT NULL,
			cf_type varchar(80) NOT NULL,
			cf_required tinyint(1) NOT NULL,
			cf_show_in_posts tinyint(1) NOT NULL,
			cf_show_in_post_previews tinyint(1) NOT NULL,
			cf_order integer NOT NULL,
			cf_only_group longtext NOT NULL,
			cf_encrypted tinyint(1) NOT NULL,
			cf_show_on_join_form tinyint(1) NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp_f_emoticons
		(
			e_code varchar(80) NULL,
			e_theme_img_code varchar(255) NOT NULL,
			e_relevance_level integer NOT NULL,
			e_use_topics tinyint(1) NOT NULL,
			e_is_special tinyint(1) NOT NULL,
			PRIMARY KEY (e_code)
		) TYPE=InnoDB;

		CREATE TABLE ocp_f_forums
		(
			id integer auto_increment NULL,
			f_name varchar(255) NOT NULL,
			f_description integer NOT NULL,
			f_category_id integer NOT NULL,
			f_parent_forum integer NOT NULL,
			f_position integer NOT NULL,
			f_order_sub_alpha tinyint(1) NOT NULL,
			f_post_count_increment tinyint(1) NOT NULL,
			f_intro_question integer NOT NULL,
			f_intro_answer varchar(255) NOT NULL,
			f_cache_num_topics integer NOT NULL,
			f_cache_num_posts integer NOT NULL,
			f_cache_last_topic_id integer NOT NULL,
			f_cache_last_title varchar(255) NOT NULL,
			f_cache_last_time integer unsigned NOT NULL,
			f_cache_last_username varchar(255) NOT NULL,
			f_cache_last_member_id integer NOT NULL,
			f_cache_last_forum_id integer NOT NULL,
			f_redirection varchar(255) NOT NULL,
			f_order varchar(80) NOT NULL,
			f_is_threaded tinyint(1) NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp_f_forum_intro_ip
		(
			i_forum_id integer NULL,
			i_ip varchar(40) NULL,
			PRIMARY KEY (i_forum_id,i_ip)
		) TYPE=InnoDB;

		CREATE TABLE ocp_f_forum_intro_member
		(
			i_forum_id integer NULL,
			i_member_id integer NULL,
			PRIMARY KEY (i_forum_id,i_member_id)
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

		CREATE TABLE ocp_f_group_members
		(
			gm_group_id integer NULL,
			gm_member_id integer NULL,
			gm_validated tinyint(1) NOT NULL,
			PRIMARY KEY (gm_group_id,gm_member_id)
		) TYPE=InnoDB;

		CREATE TABLE ocp_f_invites
		(
			id integer auto_increment NULL,
			i_inviter integer NOT NULL,
			i_email_address varchar(255) NOT NULL,
			i_time integer unsigned NOT NULL,
			i_taken tinyint(1) NOT NULL,
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

		CREATE TABLE ocp_f_member_cpf_perms
		(
			member_id integer NULL,
			field_id integer NULL,
			guest_view tinyint(1) NOT NULL,
			member_view tinyint(1) NOT NULL,
			friend_view tinyint(1) NOT NULL,
			group_view varchar(255) NOT NULL,
			PRIMARY KEY (member_id,field_id)
		) TYPE=InnoDB;

		CREATE TABLE ocp_f_member_custom_fields
		(
			mf_member_id integer NULL,
			field_1 integer NOT NULL,
			field_2 varchar(255) NOT NULL,
			field_3 varchar(255) NOT NULL,
			field_4 varchar(255) NOT NULL,
			field_5 varchar(255) NOT NULL,
			field_6 integer NOT NULL,
			field_7 varchar(255) NOT NULL,
			field_8 varchar(255) NOT NULL,
			field_9 integer NOT NULL,
			field_10 varchar(255) NOT NULL,
			field_11 varchar(255) NOT NULL,
			field_12 varchar(255) NOT NULL,
			field_13 varchar(255) NOT NULL,
			field_14 varchar(255) NOT NULL,
			field_15 varchar(255) NOT NULL,
			field_16 longtext NOT NULL,
			field_17 varchar(255) NOT NULL,
			field_18 varchar(255) NOT NULL,
			field_19 longtext NOT NULL,
			field_20 varchar(255) NOT NULL,
			field_21 longtext NOT NULL,
			field_22 varchar(255) NOT NULL,
			field_23 varchar(255) NOT NULL,
			field_24 varchar(255) NOT NULL,
			field_25 varchar(255) NOT NULL,
			field_26 varchar(255) NOT NULL,
			field_27 varchar(255) NOT NULL,
			field_28 varchar(255) NOT NULL,
			field_29 longtext NOT NULL,
			field_30 varchar(255) NOT NULL,
			field_31 varchar(255) NOT NULL,
			field_32 varchar(255) NOT NULL,
			field_33 longtext NOT NULL,
			field_34 varchar(255) NOT NULL,
			field_35 varchar(255) NOT NULL,
			field_36 varchar(255) NOT NULL,
			field_37 varchar(255) NOT NULL,
			field_38 varchar(255) NOT NULL,
			field_39 varchar(255) NOT NULL,
			field_40 varchar(255) NOT NULL,
			field_41 varchar(255) NOT NULL,
			field_42 varchar(255) NOT NULL,
			field_43 varchar(255) NOT NULL,
			field_44 longtext NOT NULL,
			PRIMARY KEY (mf_member_id)
		) TYPE=InnoDB;

		CREATE TABLE ocp_f_member_known_login_ips
		(
			i_member_id integer NULL,
			i_ip varchar(40) NULL,
			i_val_code varchar(255) NOT NULL,
			PRIMARY KEY (i_member_id,i_ip)
		) TYPE=InnoDB;

		CREATE TABLE ocp_f_moderator_logs
		(
			id integer auto_increment NULL,
			l_the_type varchar(80) NOT NULL,
			l_param_a varchar(255) NOT NULL,
			l_param_b varchar(255) NOT NULL,
			l_date_and_time integer unsigned NOT NULL,
			l_reason longtext NOT NULL,
			l_by integer NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp_f_multi_moderations
		(
			id integer auto_increment NULL,
			mm_name integer NOT NULL,
			mm_post_text longtext NOT NULL,
			mm_move_to integer NOT NULL,
			mm_pin_state tinyint(1) NOT NULL,
			mm_sink_state tinyint(1) NOT NULL,
			mm_open_state tinyint(1) NOT NULL,
			mm_forum_multi_code varchar(255) NOT NULL,
			mm_title_suffix varchar(255) NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp_f_polls
		(
			id integer auto_increment NULL,
			po_question varchar(255) NOT NULL,
			po_cache_total_votes integer NOT NULL,
			po_is_private tinyint(1) NOT NULL,
			po_is_open tinyint(1) NOT NULL,
			po_minimum_selections integer NOT NULL,
			po_maximum_selections integer NOT NULL,
			po_requires_reply tinyint(1) NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp_f_poll_answers
		(
			id integer auto_increment NULL,
			pa_poll_id integer NOT NULL,
			pa_answer varchar(255) NOT NULL,
			pa_cache_num_votes integer NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp_f_poll_votes
		(
			pv_poll_id integer NULL,
			pv_member_id integer NULL,
			pv_answer_id integer NULL,
			PRIMARY KEY (pv_poll_id,pv_member_id,pv_answer_id)
		) TYPE=InnoDB;

		CREATE TABLE ocp_f_posts
		(
			id integer auto_increment NULL,
			p_title varchar(255) NOT NULL,
			p_post integer NOT NULL,
			p_ip_address varchar(40) NOT NULL,
			p_time integer unsigned NOT NULL,
			p_poster integer NOT NULL,
			p_intended_solely_for integer NOT NULL,
			p_poster_name_if_guest varchar(80) NOT NULL,
			p_validated tinyint(1) NOT NULL,
			p_topic_id integer NOT NULL,
			p_cache_forum_id integer NOT NULL,
			p_last_edit_time integer unsigned NOT NULL,
			p_last_edit_by integer NOT NULL,
			p_is_emphasised tinyint(1) NOT NULL,
			p_skip_sig tinyint(1) NOT NULL,
			p_parent_id integer NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp_f_post_history
		(
			id integer auto_increment NULL,
			h_create_date_and_time integer unsigned NOT NULL,
			h_action_date_and_time integer unsigned NOT NULL,
			h_owner_member_id integer NOT NULL,
			h_alterer_member_id integer NOT NULL,
			h_post_id integer NOT NULL,
			h_topic_id integer NOT NULL,
			h_before longtext NOT NULL,
			h_action varchar(80) NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp_f_post_templates
		(
			id integer auto_increment NULL,
			t_title varchar(255) NOT NULL,
			t_text longtext NOT NULL,
			t_forum_multi_code varchar(255) NOT NULL,
			t_use_default_forums tinyint(1) NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp_f_read_logs
		(
			l_member_id integer NULL,
			l_topic_id integer NULL,
			l_time integer unsigned NOT NULL,
			PRIMARY KEY (l_member_id,l_topic_id)
		) TYPE=InnoDB;

		CREATE TABLE ocp_f_saved_warnings
		(
			s_title varchar(255) NULL,
			s_explanation longtext NOT NULL,
			s_message longtext NOT NULL,
			PRIMARY KEY (s_title)
		) TYPE=InnoDB;

		CREATE TABLE ocp_f_special_pt_access
		(
			s_member_id integer NULL,
			s_topic_id integer NULL,
			PRIMARY KEY (s_member_id,s_topic_id)
		) TYPE=InnoDB;

		CREATE TABLE ocp_f_topics
		(
			id integer auto_increment NULL,
			t_pinned tinyint(1) NOT NULL,
			t_sunk tinyint(1) NOT NULL,
			t_cascading tinyint(1) NOT NULL,
			t_forum_id integer NOT NULL,
			t_pt_from integer NOT NULL,
			t_pt_to integer NOT NULL,
			t_pt_from_category varchar(255) NOT NULL,
			t_pt_to_category varchar(255) NOT NULL,
			t_description varchar(255) NOT NULL,
			t_description_link varchar(255) NOT NULL,
			t_emoticon varchar(255) NOT NULL,
			t_num_views integer NOT NULL,
			t_validated tinyint(1) NOT NULL,
			t_is_open tinyint(1) NOT NULL,
			t_poll_id integer NOT NULL,
			t_cache_first_post_id integer NOT NULL,
			t_cache_first_time integer unsigned NOT NULL,
			t_cache_first_title varchar(255) NOT NULL,
			t_cache_first_post integer NOT NULL,
			t_cache_first_username varchar(80) NOT NULL,
			t_cache_first_member_id integer NOT NULL,
			t_cache_last_post_id integer NOT NULL,
			t_cache_last_time integer unsigned NOT NULL,
			t_cache_last_title varchar(255) NOT NULL,
			t_cache_last_username varchar(80) NOT NULL,
			t_cache_last_member_id integer NOT NULL,
			t_cache_num_posts integer NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp_f_warnings
		(
			id integer auto_increment NULL,
			w_member_id integer NOT NULL,
			w_time integer unsigned NOT NULL,
			w_explanation longtext NOT NULL,
			w_by integer NOT NULL,
			w_is_warning tinyint(1) NOT NULL,
			p_silence_from_topic integer NOT NULL,
			p_silence_from_forum integer NOT NULL,
			p_probation integer NOT NULL,
			p_banned_ip varchar(40) NOT NULL,
			p_charged_points integer NOT NULL,
			p_banned_member tinyint(1) NOT NULL,
			p_changed_usergroup_from integer NOT NULL,
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


		CREATE INDEX `f_custom_fields.cf_name` ON ocp_f_custom_fields(cf_name);
		ALTER TABLE ocp_f_custom_fields ADD FOREIGN KEY `f_custom_fields.cf_name` (cf_name) REFERENCES ocp_translate (id);

		CREATE INDEX `f_custom_fields.cf_description` ON ocp_f_custom_fields(cf_description);
		ALTER TABLE ocp_f_custom_fields ADD FOREIGN KEY `f_custom_fields.cf_description` (cf_description) REFERENCES ocp_translate (id);

		CREATE INDEX `f_forums.f_description` ON ocp_f_forums(f_description);
		ALTER TABLE ocp_f_forums ADD FOREIGN KEY `f_forums.f_description` (f_description) REFERENCES ocp_translate (id);

		CREATE INDEX `f_forums.f_category_id` ON ocp_f_forums(f_category_id);
		ALTER TABLE ocp_f_forums ADD FOREIGN KEY `f_forums.f_category_id` (f_category_id) REFERENCES ocp_f_categories (id);

		CREATE INDEX `f_forums.f_parent_forum` ON ocp_f_forums(f_parent_forum);
		ALTER TABLE ocp_f_forums ADD FOREIGN KEY `f_forums.f_parent_forum` (f_parent_forum) REFERENCES ocp_f_forums (id);

		CREATE INDEX `f_forums.f_intro_question` ON ocp_f_forums(f_intro_question);
		ALTER TABLE ocp_f_forums ADD FOREIGN KEY `f_forums.f_intro_question` (f_intro_question) REFERENCES ocp_translate (id);

		CREATE INDEX `f_forums.f_cache_last_topic_id` ON ocp_f_forums(f_cache_last_topic_id);
		ALTER TABLE ocp_f_forums ADD FOREIGN KEY `f_forums.f_cache_last_topic_id` (f_cache_last_topic_id) REFERENCES ocp_f_topics (id);

		CREATE INDEX `f_forums.f_cache_last_member_id` ON ocp_f_forums(f_cache_last_member_id);
		ALTER TABLE ocp_f_forums ADD FOREIGN KEY `f_forums.f_cache_last_member_id` (f_cache_last_member_id) REFERENCES ocp_f_members (id);

		CREATE INDEX `f_forums.f_cache_last_forum_id` ON ocp_f_forums(f_cache_last_forum_id);
		ALTER TABLE ocp_f_forums ADD FOREIGN KEY `f_forums.f_cache_last_forum_id` (f_cache_last_forum_id) REFERENCES ocp_f_forums (id);

		CREATE INDEX `f_forum_intro_ip.i_forum_id` ON ocp_f_forum_intro_ip(i_forum_id);
		ALTER TABLE ocp_f_forum_intro_ip ADD FOREIGN KEY `f_forum_intro_ip.i_forum_id` (i_forum_id) REFERENCES ocp_f_forums (id);

		CREATE INDEX `f_forum_intro_member.i_forum_id` ON ocp_f_forum_intro_member(i_forum_id);
		ALTER TABLE ocp_f_forum_intro_member ADD FOREIGN KEY `f_forum_intro_member.i_forum_id` (i_forum_id) REFERENCES ocp_f_forums (id);

		CREATE INDEX `f_forum_intro_member.i_member_id` ON ocp_f_forum_intro_member(i_member_id);
		ALTER TABLE ocp_f_forum_intro_member ADD FOREIGN KEY `f_forum_intro_member.i_member_id` (i_member_id) REFERENCES ocp_f_members (id);

		CREATE INDEX `f_groups.g_name` ON ocp_f_groups(g_name);
		ALTER TABLE ocp_f_groups ADD FOREIGN KEY `f_groups.g_name` (g_name) REFERENCES ocp_translate (id);

		CREATE INDEX `f_groups.g_group_leader` ON ocp_f_groups(g_group_leader);
		ALTER TABLE ocp_f_groups ADD FOREIGN KEY `f_groups.g_group_leader` (g_group_leader) REFERENCES ocp_f_members (id);

		CREATE INDEX `f_groups.g_title` ON ocp_f_groups(g_title);
		ALTER TABLE ocp_f_groups ADD FOREIGN KEY `f_groups.g_title` (g_title) REFERENCES ocp_translate (id);

		CREATE INDEX `f_groups.g_promotion_target` ON ocp_f_groups(g_promotion_target);
		ALTER TABLE ocp_f_groups ADD FOREIGN KEY `f_groups.g_promotion_target` (g_promotion_target) REFERENCES ocp_f_groups (id);

		CREATE INDEX `f_group_members.gm_group_id` ON ocp_f_group_members(gm_group_id);
		ALTER TABLE ocp_f_group_members ADD FOREIGN KEY `f_group_members.gm_group_id` (gm_group_id) REFERENCES ocp_f_groups (id);

		CREATE INDEX `f_group_members.gm_member_id` ON ocp_f_group_members(gm_member_id);
		ALTER TABLE ocp_f_group_members ADD FOREIGN KEY `f_group_members.gm_member_id` (gm_member_id) REFERENCES ocp_f_members (id);

		CREATE INDEX `f_invites.i_inviter` ON ocp_f_invites(i_inviter);
		ALTER TABLE ocp_f_invites ADD FOREIGN KEY `f_invites.i_inviter` (i_inviter) REFERENCES ocp_f_members (id);

		CREATE INDEX `f_members.m_primary_group` ON ocp_f_members(m_primary_group);
		ALTER TABLE ocp_f_members ADD FOREIGN KEY `f_members.m_primary_group` (m_primary_group) REFERENCES ocp_f_groups (id);

		CREATE INDEX `f_members.m_signature` ON ocp_f_members(m_signature);
		ALTER TABLE ocp_f_members ADD FOREIGN KEY `f_members.m_signature` (m_signature) REFERENCES ocp_translate (id);

		CREATE INDEX `f_members.m_pt_rules_text` ON ocp_f_members(m_pt_rules_text);
		ALTER TABLE ocp_f_members ADD FOREIGN KEY `f_members.m_pt_rules_text` (m_pt_rules_text) REFERENCES ocp_translate (id);

		CREATE INDEX `f_member_cpf_perms.member_id` ON ocp_f_member_cpf_perms(member_id);
		ALTER TABLE ocp_f_member_cpf_perms ADD FOREIGN KEY `f_member_cpf_perms.member_id` (member_id) REFERENCES ocp_f_members (id);

		CREATE INDEX `f_member_cpf_perms.field_id` ON ocp_f_member_cpf_perms(field_id);
		ALTER TABLE ocp_f_member_cpf_perms ADD FOREIGN KEY `f_member_cpf_perms.field_id` (field_id) REFERENCES ocp_f_custom_fields (id);

		CREATE INDEX `f_member_custom_fields.mf_member_id` ON ocp_f_member_custom_fields(mf_member_id);
		ALTER TABLE ocp_f_member_custom_fields ADD FOREIGN KEY `f_member_custom_fields.mf_member_id` (mf_member_id) REFERENCES ocp_f_members (id);

		CREATE INDEX `f_member_custom_fields.field_1` ON ocp_f_member_custom_fields(field_1);
		ALTER TABLE ocp_f_member_custom_fields ADD FOREIGN KEY `f_member_custom_fields.field_1` (field_1) REFERENCES ocp_translate (id);

		CREATE INDEX `f_member_custom_fields.field_6` ON ocp_f_member_custom_fields(field_6);
		ALTER TABLE ocp_f_member_custom_fields ADD FOREIGN KEY `f_member_custom_fields.field_6` (field_6) REFERENCES ocp_translate (id);

		CREATE INDEX `f_member_custom_fields.field_9` ON ocp_f_member_custom_fields(field_9);
		ALTER TABLE ocp_f_member_custom_fields ADD FOREIGN KEY `f_member_custom_fields.field_9` (field_9) REFERENCES ocp_translate (id);

		CREATE INDEX `f_member_known_login_ips.i_member_id` ON ocp_f_member_known_login_ips(i_member_id);
		ALTER TABLE ocp_f_member_known_login_ips ADD FOREIGN KEY `f_member_known_login_ips.i_member_id` (i_member_id) REFERENCES ocp_f_members (id);

		CREATE INDEX `f_moderator_logs.l_by` ON ocp_f_moderator_logs(l_by);
		ALTER TABLE ocp_f_moderator_logs ADD FOREIGN KEY `f_moderator_logs.l_by` (l_by) REFERENCES ocp_f_members (id);

		CREATE INDEX `f_multi_moderations.mm_name` ON ocp_f_multi_moderations(mm_name);
		ALTER TABLE ocp_f_multi_moderations ADD FOREIGN KEY `f_multi_moderations.mm_name` (mm_name) REFERENCES ocp_translate (id);

		CREATE INDEX `f_poll_answers.pa_poll_id` ON ocp_f_poll_answers(pa_poll_id);
		ALTER TABLE ocp_f_poll_answers ADD FOREIGN KEY `f_poll_answers.pa_poll_id` (pa_poll_id) REFERENCES ocp_f_polls (id);

		CREATE INDEX `f_poll_votes.pv_poll_id` ON ocp_f_poll_votes(pv_poll_id);
		ALTER TABLE ocp_f_poll_votes ADD FOREIGN KEY `f_poll_votes.pv_poll_id` (pv_poll_id) REFERENCES ocp_f_polls (id);

		CREATE INDEX `f_poll_votes.pv_member_id` ON ocp_f_poll_votes(pv_member_id);
		ALTER TABLE ocp_f_poll_votes ADD FOREIGN KEY `f_poll_votes.pv_member_id` (pv_member_id) REFERENCES ocp_f_members (id);

		CREATE INDEX `f_poll_votes.pv_answer_id` ON ocp_f_poll_votes(pv_answer_id);
		ALTER TABLE ocp_f_poll_votes ADD FOREIGN KEY `f_poll_votes.pv_answer_id` (pv_answer_id) REFERENCES ocp_f_poll_answers (id);

		CREATE INDEX `f_posts.p_post` ON ocp_f_posts(p_post);
		ALTER TABLE ocp_f_posts ADD FOREIGN KEY `f_posts.p_post` (p_post) REFERENCES ocp_translate (id);

		CREATE INDEX `f_posts.p_poster` ON ocp_f_posts(p_poster);
		ALTER TABLE ocp_f_posts ADD FOREIGN KEY `f_posts.p_poster` (p_poster) REFERENCES ocp_f_members (id);

		CREATE INDEX `f_posts.p_intended_solely_for` ON ocp_f_posts(p_intended_solely_for);
		ALTER TABLE ocp_f_posts ADD FOREIGN KEY `f_posts.p_intended_solely_for` (p_intended_solely_for) REFERENCES ocp_f_members (id);

		CREATE INDEX `f_posts.p_topic_id` ON ocp_f_posts(p_topic_id);
		ALTER TABLE ocp_f_posts ADD FOREIGN KEY `f_posts.p_topic_id` (p_topic_id) REFERENCES ocp_f_topics (id);

		CREATE INDEX `f_posts.p_cache_forum_id` ON ocp_f_posts(p_cache_forum_id);
		ALTER TABLE ocp_f_posts ADD FOREIGN KEY `f_posts.p_cache_forum_id` (p_cache_forum_id) REFERENCES ocp_f_forums (id);

		CREATE INDEX `f_posts.p_last_edit_by` ON ocp_f_posts(p_last_edit_by);
		ALTER TABLE ocp_f_posts ADD FOREIGN KEY `f_posts.p_last_edit_by` (p_last_edit_by) REFERENCES ocp_f_members (id);

		CREATE INDEX `f_posts.p_parent_id` ON ocp_f_posts(p_parent_id);
		ALTER TABLE ocp_f_posts ADD FOREIGN KEY `f_posts.p_parent_id` (p_parent_id) REFERENCES ocp_f_posts (id);

		CREATE INDEX `f_post_history.h_owner_member_id` ON ocp_f_post_history(h_owner_member_id);
		ALTER TABLE ocp_f_post_history ADD FOREIGN KEY `f_post_history.h_owner_member_id` (h_owner_member_id) REFERENCES ocp_f_members (id);

		CREATE INDEX `f_post_history.h_alterer_member_id` ON ocp_f_post_history(h_alterer_member_id);
		ALTER TABLE ocp_f_post_history ADD FOREIGN KEY `f_post_history.h_alterer_member_id` (h_alterer_member_id) REFERENCES ocp_f_members (id);

		CREATE INDEX `f_post_history.h_post_id` ON ocp_f_post_history(h_post_id);
		ALTER TABLE ocp_f_post_history ADD FOREIGN KEY `f_post_history.h_post_id` (h_post_id) REFERENCES ocp_f_posts (id);

		CREATE INDEX `f_post_history.h_topic_id` ON ocp_f_post_history(h_topic_id);
		ALTER TABLE ocp_f_post_history ADD FOREIGN KEY `f_post_history.h_topic_id` (h_topic_id) REFERENCES ocp_f_topics (id);

		CREATE INDEX `f_read_logs.l_member_id` ON ocp_f_read_logs(l_member_id);
		ALTER TABLE ocp_f_read_logs ADD FOREIGN KEY `f_read_logs.l_member_id` (l_member_id) REFERENCES ocp_f_members (id);

		CREATE INDEX `f_read_logs.l_topic_id` ON ocp_f_read_logs(l_topic_id);
		ALTER TABLE ocp_f_read_logs ADD FOREIGN KEY `f_read_logs.l_topic_id` (l_topic_id) REFERENCES ocp_f_topics (id);

		CREATE INDEX `f_special_pt_access.s_member_id` ON ocp_f_special_pt_access(s_member_id);
		ALTER TABLE ocp_f_special_pt_access ADD FOREIGN KEY `f_special_pt_access.s_member_id` (s_member_id) REFERENCES ocp_f_members (id);

		CREATE INDEX `f_special_pt_access.s_topic_id` ON ocp_f_special_pt_access(s_topic_id);
		ALTER TABLE ocp_f_special_pt_access ADD FOREIGN KEY `f_special_pt_access.s_topic_id` (s_topic_id) REFERENCES ocp_f_topics (id);

		CREATE INDEX `f_topics.t_forum_id` ON ocp_f_topics(t_forum_id);
		ALTER TABLE ocp_f_topics ADD FOREIGN KEY `f_topics.t_forum_id` (t_forum_id) REFERENCES ocp_f_forums (id);

		CREATE INDEX `f_topics.t_pt_from` ON ocp_f_topics(t_pt_from);
		ALTER TABLE ocp_f_topics ADD FOREIGN KEY `f_topics.t_pt_from` (t_pt_from) REFERENCES ocp_f_members (id);

		CREATE INDEX `f_topics.t_pt_to` ON ocp_f_topics(t_pt_to);
		ALTER TABLE ocp_f_topics ADD FOREIGN KEY `f_topics.t_pt_to` (t_pt_to) REFERENCES ocp_f_members (id);

		CREATE INDEX `f_topics.t_poll_id` ON ocp_f_topics(t_poll_id);
		ALTER TABLE ocp_f_topics ADD FOREIGN KEY `f_topics.t_poll_id` (t_poll_id) REFERENCES ocp_f_polls (id);

		CREATE INDEX `f_topics.t_cache_first_post_id` ON ocp_f_topics(t_cache_first_post_id);
		ALTER TABLE ocp_f_topics ADD FOREIGN KEY `f_topics.t_cache_first_post_id` (t_cache_first_post_id) REFERENCES ocp_f_posts (id);

		CREATE INDEX `f_topics.t_cache_first_post` ON ocp_f_topics(t_cache_first_post);
		ALTER TABLE ocp_f_topics ADD FOREIGN KEY `f_topics.t_cache_first_post` (t_cache_first_post) REFERENCES ocp_translate (id);

		CREATE INDEX `f_topics.t_cache_first_member_id` ON ocp_f_topics(t_cache_first_member_id);
		ALTER TABLE ocp_f_topics ADD FOREIGN KEY `f_topics.t_cache_first_member_id` (t_cache_first_member_id) REFERENCES ocp_f_members (id);

		CREATE INDEX `f_topics.t_cache_last_post_id` ON ocp_f_topics(t_cache_last_post_id);
		ALTER TABLE ocp_f_topics ADD FOREIGN KEY `f_topics.t_cache_last_post_id` (t_cache_last_post_id) REFERENCES ocp_f_posts (id);

		CREATE INDEX `f_topics.t_cache_last_member_id` ON ocp_f_topics(t_cache_last_member_id);
		ALTER TABLE ocp_f_topics ADD FOREIGN KEY `f_topics.t_cache_last_member_id` (t_cache_last_member_id) REFERENCES ocp_f_members (id);

		CREATE INDEX `f_warnings.w_member_id` ON ocp_f_warnings(w_member_id);
		ALTER TABLE ocp_f_warnings ADD FOREIGN KEY `f_warnings.w_member_id` (w_member_id) REFERENCES ocp_f_members (id);

		CREATE INDEX `f_warnings.w_by` ON ocp_f_warnings(w_by);
		ALTER TABLE ocp_f_warnings ADD FOREIGN KEY `f_warnings.w_by` (w_by) REFERENCES ocp_f_members (id);

		CREATE INDEX `f_warnings.p_silence_from_topic` ON ocp_f_warnings(p_silence_from_topic);
		ALTER TABLE ocp_f_warnings ADD FOREIGN KEY `f_warnings.p_silence_from_topic` (p_silence_from_topic) REFERENCES ocp_f_topics (id);

		CREATE INDEX `f_warnings.p_silence_from_forum` ON ocp_f_warnings(p_silence_from_forum);
		ALTER TABLE ocp_f_warnings ADD FOREIGN KEY `f_warnings.p_silence_from_forum` (p_silence_from_forum) REFERENCES ocp_f_forums (id);

		CREATE INDEX `f_warnings.p_changed_usergroup_from` ON ocp_f_warnings(p_changed_usergroup_from);
		ALTER TABLE ocp_f_warnings ADD FOREIGN KEY `f_warnings.p_changed_usergroup_from` (p_changed_usergroup_from) REFERENCES ocp_f_groups (id);

		CREATE INDEX `translate.source_user` ON ocp_translate(source_user);
		ALTER TABLE ocp_translate ADD FOREIGN KEY `translate.source_user` (source_user) REFERENCES ocp_f_members (id);
