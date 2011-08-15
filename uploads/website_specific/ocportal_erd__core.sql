		CREATE TABLE ocp6_seo_meta
		(
			id integer auto_increment NULL,
			meta_for_type varchar(80) NOT NULL,
			meta_for_id varchar(80) NOT NULL,
			meta_keywords integer NOT NULL,
			meta_description integer NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp6_https_pages
		(
			https_page_name varchar(80) NULL,
			PRIMARY KEY (https_page_name)
		) TYPE=InnoDB;

		CREATE TABLE ocp6_attachments
		(
			id integer auto_increment NULL,
			a_member_id integer NOT NULL,
			a_file_size integer NOT NULL,
			a_url varchar(255) NOT NULL,
			a_description varchar(255) NOT NULL,
			a_thumb_url varchar(255) NOT NULL,
			a_original_filename varchar(255) NOT NULL,
			a_num_downloads integer NOT NULL,
			a_last_downloaded_time integer NOT NULL,
			a_add_time integer NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp6_attachment_refs
		(
			id integer auto_increment NULL,
			r_referer_type varchar(80) NOT NULL,
			r_referer_id varchar(80) NOT NULL,
			a_id integer NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp6_menu_items
		(
			id integer auto_increment NULL,
			i_menu varchar(80) NOT NULL,
			i_order integer NOT NULL,
			i_parent integer NOT NULL,
			i_caption integer NOT NULL,
			i_caption_long integer NOT NULL,
			i_url varchar(255) NOT NULL,
			i_check_permissions tinyint(1) NOT NULL,
			i_expanded tinyint(1) NOT NULL,
			i_new_window tinyint(1) NOT NULL,
			i_page_only varchar(80) NOT NULL,
			i_theme_img_code varchar(80) NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp6_trackbacks
		(
			id integer auto_increment NULL,
			trackback_for_type varchar(80) NOT NULL,
			trackback_for_id varchar(80) NOT NULL,
			trackback_ip varchar(40) NOT NULL,
			trackback_time integer unsigned NOT NULL,
			trackback_url varchar(255) NOT NULL,
			trackback_title varchar(255) NOT NULL,
			trackback_excerpt longtext NOT NULL,
			trackback_name varchar(255) NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp6_security_images
		(
			si_session_id integer NULL,
			si_time integer unsigned NOT NULL,
			si_code integer NOT NULL,
			PRIMARY KEY (si_session_id)
		) TYPE=InnoDB;

		CREATE TABLE ocp6_member_tracking
		(
			mt_member_id integer NULL,
			mt_cache_username varchar(80) NOT NULL,
			mt_time integer unsigned NULL,
			mt_page varchar(80) NULL,
			mt_type varchar(80) NULL,
			mt_id varchar(80) NULL,
			PRIMARY KEY (mt_member_id,mt_time,mt_page,mt_type,mt_id)
		) TYPE=InnoDB;

		CREATE TABLE ocp6_cache_on
		(
			cached_for varchar(80) NULL,
			cache_on longtext NOT NULL,
			cache_ttl integer NOT NULL,
			PRIMARY KEY (cached_for)
		) TYPE=InnoDB;

		CREATE TABLE ocp6_validated_once
		(
			hash varchar(33) NULL,
			PRIMARY KEY (hash)
		) TYPE=InnoDB;

		CREATE TABLE ocp6_edit_pings
		(
			id integer auto_increment NULL,
			the_page varchar(80) NOT NULL,
			the_type varchar(80) NOT NULL,
			the_id varchar(80) NOT NULL,
			the_time integer unsigned NOT NULL,
			the_member integer NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp6_translate_history
		(
			id integer auto_increment NULL,
			lang_id integer NOT NULL,
			language varchar(5) NULL,
			text_original longtext NOT NULL,
			broken tinyint(1) NOT NULL,
			action_member integer NOT NULL,
			action_time integer unsigned NOT NULL,
			PRIMARY KEY (id,language)
		) TYPE=InnoDB;

		CREATE TABLE ocp6_long_values
		(
			the_name varchar(80) NULL,
			the_value longtext NOT NULL,
			date_and_time integer unsigned NOT NULL,
			PRIMARY KEY (the_name)
		) TYPE=InnoDB;

		CREATE TABLE ocp6_tutorial_links
		(
			the_name varchar(80) NULL,
			the_value longtext NOT NULL,
			PRIMARY KEY (the_name)
		) TYPE=InnoDB;

		CREATE TABLE ocp6_msp
		(
			active_until integer unsigned NULL,
			member_id integer NULL,
			specific_permission varchar(80) NULL,
			the_page varchar(80) NULL,
			module_the_name varchar(80) NULL,
			category_name varchar(80) NULL,
			the_value tinyint(1) NOT NULL,
			PRIMARY KEY (active_until,member_id,specific_permission,the_page,module_the_name,category_name)
		) TYPE=InnoDB;

		CREATE TABLE ocp6_member_zone_access
		(
			active_until integer unsigned NULL,
			zone_name varchar(80) NULL,
			member_id integer NULL,
			PRIMARY KEY (active_until,zone_name,member_id)
		) TYPE=InnoDB;

		CREATE TABLE ocp6_member_page_access
		(
			active_until integer unsigned NULL,
			page_name varchar(80) NULL,
			zone_name varchar(80) NULL,
			member_id integer NULL,
			PRIMARY KEY (active_until,page_name,zone_name,member_id)
		) TYPE=InnoDB;

		CREATE TABLE ocp6_member_category_access
		(
			active_until integer unsigned NULL,
			module_the_name varchar(80) NULL,
			category_name varchar(80) NULL,
			member_id integer NULL,
			PRIMARY KEY (active_until,module_the_name,category_name,member_id)
		) TYPE=InnoDB;

		CREATE TABLE ocp6_tracking
		(
			r_resource_type varchar(80) NULL,
			r_resource_id varchar(80) NULL,
			r_member_id integer NULL,
			r_notify_sms tinyint(1) NOT NULL,
			r_notify_email tinyint(1) NOT NULL,
			r_filter longtext NOT NULL,
			PRIMARY KEY (r_resource_type,r_resource_id,r_member_id)
		) TYPE=InnoDB;

		CREATE TABLE ocp6_autosave
		(
			id integer auto_increment NULL,
			a_member_id integer NOT NULL,
			a_key longtext NOT NULL,
			a_value longtext NOT NULL,
			a_time integer unsigned NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp6_messages_to_render
		(
			id integer auto_increment NULL,
			r_session_id integer NOT NULL,
			r_message longtext NOT NULL,
			r_type varchar(80) NOT NULL,
			r_time integer unsigned NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp6_url_title_cache
		(
			id integer auto_increment NULL,
			t_url varchar(255) NOT NULL,
			t_title varchar(255) NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp6_url_id_monikers
		(
			id integer auto_increment NULL,
			m_resource_page varchar(80) NOT NULL,
			m_resource_type varchar(80) NOT NULL,
			m_resource_id varchar(80) NOT NULL,
			m_moniker varchar(255) NOT NULL,
			m_deprecated tinyint(1) NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp6_review_supplement
		(
			r_post_id integer NULL,
			r_rating_type varchar(80) NULL,
			r_rating tinyint NOT NULL,
			r_topic_id integer NOT NULL,
			r_rating_for_id varchar(80) NOT NULL,
			r_rating_for_type varchar(80) NOT NULL,
			PRIMARY KEY (r_post_id,r_rating_type)
		) TYPE=InnoDB;

		CREATE TABLE ocp6_sms_log
		(
			id integer auto_increment NULL,
			s_member_id integer NOT NULL,
			s_time integer unsigned NOT NULL,
			s_trigger_ip varchar(40) NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp6_logged_mail_messages
		(
			id integer auto_increment NULL,
			m_subject varchar(255) NOT NULL,
			m_message longtext NOT NULL,
			m_to_email longtext NOT NULL,
			m_to_name longtext NOT NULL,
			m_from_email varchar(255) NOT NULL,
			m_from_name varchar(255) NOT NULL,
			m_priority tinyint NOT NULL,
			m_attachments longtext NOT NULL,
			m_no_cc tinyint(1) NOT NULL,
			m_as integer NOT NULL,
			m_as_admin tinyint(1) NOT NULL,
			m_in_html tinyint(1) NOT NULL,
			m_date_and_time integer unsigned NOT NULL,
			m_member_id integer NOT NULL,
			m_url longtext NOT NULL,
			m_queued tinyint(1) NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp6_link_tracker
		(
			id integer auto_increment NULL,
			c_date_and_time integer unsigned NOT NULL,
			c_member_id integer NOT NULL,
			c_ip_address varchar(40) NOT NULL,
			c_url varchar(255) NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp6_incoming_uploads
		(
			id integer auto_increment NULL,
			i_submitter integer NOT NULL,
			i_date_and_time integer unsigned NOT NULL,
			i_orig_filename varchar(80) NOT NULL,
			i_save_url varchar(255) NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp6_cache
		(
			cached_for varchar(80) NULL,
			identifier varchar(40) NULL,
			the_value longtext NOT NULL,
			date_and_time integer unsigned NOT NULL,
			the_theme varchar(80) NULL,
			lang varchar(5) NULL,
			langs_required longtext NOT NULL,
			PRIMARY KEY (cached_for,identifier,the_theme,lang)
		) TYPE=InnoDB;

		CREATE TABLE ocp6_f_group_member_timeouts
		(
			member_id integer NULL,
			group_id integer NULL,
			timeout integer unsigned NOT NULL,
			PRIMARY KEY (member_id,group_id)
		) TYPE=InnoDB;

		CREATE TABLE ocp6_rating
		(
			id integer auto_increment NULL,
			rating_for_type varchar(80) NOT NULL,
			rating_for_id varchar(80) NOT NULL,
			rating_member integer NOT NULL,
			rating_ip varchar(40) NOT NULL,
			rating_time integer unsigned NOT NULL,
			rating tinyint NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp6_failedlogins
		(
			id integer auto_increment NULL,
			failed_account varchar(80) NOT NULL,
			date_and_time integer unsigned NOT NULL,
			ip varchar(40) NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp6_group_zone_access
		(
			zone_name varchar(80) NULL,
			group_id integer NULL,
			PRIMARY KEY (zone_name,group_id)
		) TYPE=InnoDB;

		CREATE TABLE ocp6_group_page_access
		(
			page_name varchar(80) NULL,
			zone_name varchar(80) NULL,
			group_id integer NULL,
			PRIMARY KEY (page_name,zone_name,group_id)
		) TYPE=InnoDB;

		CREATE TABLE ocp6_blocks
		(
			block_name varchar(80) NULL,
			block_author varchar(80) NOT NULL,
			block_organisation varchar(80) NOT NULL,
			block_hacked_by varchar(80) NOT NULL,
			block_hack_version integer NOT NULL,
			block_version integer NOT NULL,
			PRIMARY KEY (block_name)
		) TYPE=InnoDB;

		CREATE TABLE ocp6_config
		(
			the_name varchar(80) NULL,
			human_name varchar(80) NOT NULL,
			c_set tinyint(1) NOT NULL,
			config_value longtext NOT NULL,
			the_type varchar(80) NOT NULL,
			eval varchar(255) NOT NULL,
			the_page varchar(80) NOT NULL,
			section varchar(80) NOT NULL,
			explanation varchar(80) NOT NULL,
			shared_hosting_restricted tinyint(1) NOT NULL,
			c_data varchar(255) NOT NULL,
			PRIMARY KEY (the_name)
		) TYPE=InnoDB;

		CREATE TABLE ocp6_diseases
		(
			cure varchar(255) NOT NULL,
			image varchar(255) NOT NULL,
			name varchar(255) NOT NULL,
			id integer auto_increment NULL,
			cure_price integer NOT NULL,
			immunisation varchar(255) NOT NULL,
			immunisation_price integer NOT NULL,
			spread_rate integer NOT NULL,
			points_per_spread integer NOT NULL,
			last_spread_time integer NOT NULL,
			enabled tinyint(1) NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp6_group_category_access
		(
			module_the_name varchar(80) NULL,
			category_name varchar(80) NULL,
			group_id integer NULL,
			PRIMARY KEY (module_the_name,category_name,group_id)
		) TYPE=InnoDB;

		CREATE TABLE ocp6_gsp
		(
			group_id integer NULL,
			specific_permission varchar(80) NULL,
			the_page varchar(80) NULL,
			module_the_name varchar(80) NULL,
			category_name varchar(80) NULL,
			the_value tinyint(1) NOT NULL,
			PRIMARY KEY (group_id,specific_permission,the_page,module_the_name,category_name)
		) TYPE=InnoDB;

		CREATE TABLE ocp6_main_activities
		(
			id integer auto_increment NULL,
			a_member_id integer NULL,
			a_language_string_code varchar(80) NULL,
			a_label_1 varchar(255) NOT NULL,
			a_label_2 varchar(255) NOT NULL,
			a_label_3 varchar(255) NOT NULL,
			a_pagelink_1 varchar(255) NOT NULL,
			a_pagelink_2 varchar(255) NOT NULL,
			a_pagelink_3 varchar(255) NOT NULL,
			a_time integer unsigned NOT NULL,
			a_addon varchar(80) NOT NULL,
			a_is_public varchar(255) NOT NULL,
			PRIMARY KEY (id,a_member_id,a_language_string_code)
		) TYPE=InnoDB;

		CREATE TABLE ocp6_members_diseases
		(
			sick tinyint(1) NOT NULL,
			cure tinyint(1) NOT NULL,
			immunisation tinyint(1) NOT NULL,
			desease_id integer NULL,
			user_id integer NULL,
			PRIMARY KEY (desease_id,user_id)
		) TYPE=InnoDB;

		CREATE TABLE ocp6_members_gifts
		(
			id integer auto_increment NULL,
			to_user_id integer NOT NULL,
			from_user_id integer NOT NULL,
			gift_id integer NOT NULL,
			add_time integer unsigned NOT NULL,
			annonymous tinyint(1) NOT NULL,
			topic_id integer NOT NULL,
			gift_message longtext NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp6_modules
		(
			module_the_name varchar(80) NULL,
			module_author varchar(80) NOT NULL,
			module_organisation varchar(80) NOT NULL,
			module_hacked_by varchar(80) NOT NULL,
			module_hack_version integer NOT NULL,
			module_version integer NOT NULL,
			PRIMARY KEY (module_the_name)
		) TYPE=InnoDB;

		CREATE TABLE ocp6_ocgifts
		(
			id integer auto_increment NULL,
			name varchar(255) NOT NULL,
			image varchar(255) NOT NULL,
			price integer NOT NULL,
			enabled tinyint(1) NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp6_reported_content
		(
			r_session_id integer NULL,
			r_content_type varchar(80) NULL,
			r_content_id varchar(80) NULL,
			r_counts tinyint(1) NOT NULL,
			PRIMARY KEY (r_session_id,r_content_type,r_content_id)
		) TYPE=InnoDB;

		CREATE TABLE ocp6_sessions
		(
			the_session integer NULL,
			last_activity integer unsigned NOT NULL,
			the_user integer NOT NULL,
			ip varchar(40) NOT NULL,
			session_confirmed tinyint(1) NOT NULL,
			session_invisible tinyint(1) NOT NULL,
			cache_username varchar(255) NOT NULL,
			the_zone varchar(80) NOT NULL,
			the_page varchar(80) NOT NULL,
			the_type varchar(80) NOT NULL,
			the_id varchar(80) NOT NULL,
			the_title varchar(255) NOT NULL,
			PRIMARY KEY (the_session)
		) TYPE=InnoDB;

		CREATE TABLE ocp6_sp_list
		(
			p_section varchar(80) NOT NULL,
			the_name varchar(80) NULL,
			the_default tinyint(1) NULL,
			PRIMARY KEY (the_name,the_default)
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

		CREATE TABLE ocp6_values
		(
			the_name varchar(80) NULL,
			the_value varchar(80) NOT NULL,
			date_and_time integer unsigned NOT NULL,
			PRIMARY KEY (the_name)
		) TYPE=InnoDB;

		CREATE TABLE ocp6_zones
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

		CREATE TABLE ocp6_anything
		(
			id varchar(80) NULL,
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

		CREATE TABLE ocp6_f_posts
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
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp6_f_topics
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

		CREATE TABLE ocp6_f_forums
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
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp6_f_polls
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

		CREATE TABLE ocp6_f_categories
		(
			id integer auto_increment NULL,
			c_title varchar(255) NOT NULL,
			c_description longtext NOT NULL,
			c_expanded_by_default tinyint(1) NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;


		CREATE INDEX `seo_meta.meta_for_id` ON ocp6_seo_meta(meta_for_id);
		ALTER TABLE ocp6_seo_meta ADD FOREIGN KEY `seo_meta.meta_for_id` (meta_for_id) REFERENCES ocp6_anything (id);

		CREATE INDEX `seo_meta.meta_keywords` ON ocp6_seo_meta(meta_keywords);
		ALTER TABLE ocp6_seo_meta ADD FOREIGN KEY `seo_meta.meta_keywords` (meta_keywords) REFERENCES ocp6_translate (id);

		CREATE INDEX `seo_meta.meta_description` ON ocp6_seo_meta(meta_description);
		ALTER TABLE ocp6_seo_meta ADD FOREIGN KEY `seo_meta.meta_description` (meta_description) REFERENCES ocp6_translate (id);

		CREATE INDEX `attachments.a_member_id` ON ocp6_attachments(a_member_id);
		ALTER TABLE ocp6_attachments ADD FOREIGN KEY `attachments.a_member_id` (a_member_id) REFERENCES ocp6_f_members (id);

		CREATE INDEX `attachment_refs.r_referer_id` ON ocp6_attachment_refs(r_referer_id);
		ALTER TABLE ocp6_attachment_refs ADD FOREIGN KEY `attachment_refs.r_referer_id` (r_referer_id) REFERENCES ocp6_anything (id);

		CREATE INDEX `attachment_refs.a_id` ON ocp6_attachment_refs(a_id);
		ALTER TABLE ocp6_attachment_refs ADD FOREIGN KEY `attachment_refs.a_id` (a_id) REFERENCES ocp6_attachments (id);

		CREATE INDEX `menu_items.i_parent` ON ocp6_menu_items(i_parent);
		ALTER TABLE ocp6_menu_items ADD FOREIGN KEY `menu_items.i_parent` (i_parent) REFERENCES ocp6_menu_items (id);

		CREATE INDEX `menu_items.i_caption` ON ocp6_menu_items(i_caption);
		ALTER TABLE ocp6_menu_items ADD FOREIGN KEY `menu_items.i_caption` (i_caption) REFERENCES ocp6_translate (id);

		CREATE INDEX `menu_items.i_caption_long` ON ocp6_menu_items(i_caption_long);
		ALTER TABLE ocp6_menu_items ADD FOREIGN KEY `menu_items.i_caption_long` (i_caption_long) REFERENCES ocp6_translate (id);

		CREATE INDEX `trackbacks.trackback_for_id` ON ocp6_trackbacks(trackback_for_id);
		ALTER TABLE ocp6_trackbacks ADD FOREIGN KEY `trackbacks.trackback_for_id` (trackback_for_id) REFERENCES ocp6_anything (id);

		CREATE INDEX `member_tracking.mt_member_id` ON ocp6_member_tracking(mt_member_id);
		ALTER TABLE ocp6_member_tracking ADD FOREIGN KEY `member_tracking.mt_member_id` (mt_member_id) REFERENCES ocp6_f_members (id);

		CREATE INDEX `edit_pings.the_member` ON ocp6_edit_pings(the_member);
		ALTER TABLE ocp6_edit_pings ADD FOREIGN KEY `edit_pings.the_member` (the_member) REFERENCES ocp6_f_members (id);

		CREATE INDEX `translate_history.lang_id` ON ocp6_translate_history(lang_id);
		ALTER TABLE ocp6_translate_history ADD FOREIGN KEY `translate_history.lang_id` (lang_id) REFERENCES ocp6_translate (id);

		CREATE INDEX `translate_history.action_member` ON ocp6_translate_history(action_member);
		ALTER TABLE ocp6_translate_history ADD FOREIGN KEY `translate_history.action_member` (action_member) REFERENCES ocp6_f_members (id);

		CREATE INDEX `msp.specific_permission` ON ocp6_msp(specific_permission);
		ALTER TABLE ocp6_msp ADD FOREIGN KEY `msp.specific_permission` (specific_permission) REFERENCES ocp6_sp_list (the_name);

		CREATE INDEX `msp.the_page` ON ocp6_msp(the_page);
		ALTER TABLE ocp6_msp ADD FOREIGN KEY `msp.the_page` (the_page) REFERENCES ocp6_modules (module_the_name);

		CREATE INDEX `msp.category_name` ON ocp6_msp(category_name);
		ALTER TABLE ocp6_msp ADD FOREIGN KEY `msp.category_name` (category_name) REFERENCES ocp6_anything (id);

		CREATE INDEX `member_zone_access.zone_name` ON ocp6_member_zone_access(zone_name);
		ALTER TABLE ocp6_member_zone_access ADD FOREIGN KEY `member_zone_access.zone_name` (zone_name) REFERENCES ocp6_zones (zone_name);

		CREATE INDEX `member_zone_access.member_id` ON ocp6_member_zone_access(member_id);
		ALTER TABLE ocp6_member_zone_access ADD FOREIGN KEY `member_zone_access.member_id` (member_id) REFERENCES ocp6_f_members (id);

		CREATE INDEX `member_page_access.page_name` ON ocp6_member_page_access(page_name);
		ALTER TABLE ocp6_member_page_access ADD FOREIGN KEY `member_page_access.page_name` (page_name) REFERENCES ocp6_modules (module_the_name);

		CREATE INDEX `member_page_access.zone_name` ON ocp6_member_page_access(zone_name);
		ALTER TABLE ocp6_member_page_access ADD FOREIGN KEY `member_page_access.zone_name` (zone_name) REFERENCES ocp6_zones (zone_name);

		CREATE INDEX `member_page_access.member_id` ON ocp6_member_page_access(member_id);
		ALTER TABLE ocp6_member_page_access ADD FOREIGN KEY `member_page_access.member_id` (member_id) REFERENCES ocp6_f_members (id);

		CREATE INDEX `member_category_access.category_name` ON ocp6_member_category_access(category_name);
		ALTER TABLE ocp6_member_category_access ADD FOREIGN KEY `member_category_access.category_name` (category_name) REFERENCES ocp6_anything (id);

		CREATE INDEX `member_category_access.member_id` ON ocp6_member_category_access(member_id);
		ALTER TABLE ocp6_member_category_access ADD FOREIGN KEY `member_category_access.member_id` (member_id) REFERENCES ocp6_f_members (id);

		CREATE INDEX `tracking.r_resource_id` ON ocp6_tracking(r_resource_id);
		ALTER TABLE ocp6_tracking ADD FOREIGN KEY `tracking.r_resource_id` (r_resource_id) REFERENCES ocp6_anything (id);

		CREATE INDEX `tracking.r_member_id` ON ocp6_tracking(r_member_id);
		ALTER TABLE ocp6_tracking ADD FOREIGN KEY `tracking.r_member_id` (r_member_id) REFERENCES ocp6_f_members (id);

		CREATE INDEX `autosave.a_member_id` ON ocp6_autosave(a_member_id);
		ALTER TABLE ocp6_autosave ADD FOREIGN KEY `autosave.a_member_id` (a_member_id) REFERENCES ocp6_f_members (id);

		CREATE INDEX `messages_to_render.r_session_id` ON ocp6_messages_to_render(r_session_id);
		ALTER TABLE ocp6_messages_to_render ADD FOREIGN KEY `messages_to_render.r_session_id` (r_session_id) REFERENCES ocp6_sessions (the_session);

		CREATE INDEX `url_id_monikers.m_resource_id` ON ocp6_url_id_monikers(m_resource_id);
		ALTER TABLE ocp6_url_id_monikers ADD FOREIGN KEY `url_id_monikers.m_resource_id` (m_resource_id) REFERENCES ocp6_anything (id);

		CREATE INDEX `review_supplement.r_post_id` ON ocp6_review_supplement(r_post_id);
		ALTER TABLE ocp6_review_supplement ADD FOREIGN KEY `review_supplement.r_post_id` (r_post_id) REFERENCES ocp6_f_posts (id);

		CREATE INDEX `review_supplement.r_topic_id` ON ocp6_review_supplement(r_topic_id);
		ALTER TABLE ocp6_review_supplement ADD FOREIGN KEY `review_supplement.r_topic_id` (r_topic_id) REFERENCES ocp6_f_topics (id);

		CREATE INDEX `review_supplement.r_rating_for_id` ON ocp6_review_supplement(r_rating_for_id);
		ALTER TABLE ocp6_review_supplement ADD FOREIGN KEY `review_supplement.r_rating_for_id` (r_rating_for_id) REFERENCES ocp6_modules (module_the_name);

		CREATE INDEX `sms_log.s_member_id` ON ocp6_sms_log(s_member_id);
		ALTER TABLE ocp6_sms_log ADD FOREIGN KEY `sms_log.s_member_id` (s_member_id) REFERENCES ocp6_f_members (id);

		CREATE INDEX `logged_mail_messages.m_as` ON ocp6_logged_mail_messages(m_as);
		ALTER TABLE ocp6_logged_mail_messages ADD FOREIGN KEY `logged_mail_messages.m_as` (m_as) REFERENCES ocp6_f_members (id);

		CREATE INDEX `logged_mail_messages.m_member_id` ON ocp6_logged_mail_messages(m_member_id);
		ALTER TABLE ocp6_logged_mail_messages ADD FOREIGN KEY `logged_mail_messages.m_member_id` (m_member_id) REFERENCES ocp6_f_members (id);

		CREATE INDEX `link_tracker.c_member_id` ON ocp6_link_tracker(c_member_id);
		ALTER TABLE ocp6_link_tracker ADD FOREIGN KEY `link_tracker.c_member_id` (c_member_id) REFERENCES ocp6_f_members (id);

		CREATE INDEX `incoming_uploads.i_submitter` ON ocp6_incoming_uploads(i_submitter);
		ALTER TABLE ocp6_incoming_uploads ADD FOREIGN KEY `incoming_uploads.i_submitter` (i_submitter) REFERENCES ocp6_f_members (id);

		CREATE INDEX `f_group_member_timeouts.member_id` ON ocp6_f_group_member_timeouts(member_id);
		ALTER TABLE ocp6_f_group_member_timeouts ADD FOREIGN KEY `f_group_member_timeouts.member_id` (member_id) REFERENCES ocp6_f_members (id);

		CREATE INDEX `f_group_member_timeouts.group_id` ON ocp6_f_group_member_timeouts(group_id);
		ALTER TABLE ocp6_f_group_member_timeouts ADD FOREIGN KEY `f_group_member_timeouts.group_id` (group_id) REFERENCES ocp6_f_groups (id);

		CREATE INDEX `rating.rating_for_id` ON ocp6_rating(rating_for_id);
		ALTER TABLE ocp6_rating ADD FOREIGN KEY `rating.rating_for_id` (rating_for_id) REFERENCES ocp6_modules (module_the_name);

		CREATE INDEX `rating.rating_member` ON ocp6_rating(rating_member);
		ALTER TABLE ocp6_rating ADD FOREIGN KEY `rating.rating_member` (rating_member) REFERENCES ocp6_f_members (id);

		CREATE INDEX `group_zone_access.zone_name` ON ocp6_group_zone_access(zone_name);
		ALTER TABLE ocp6_group_zone_access ADD FOREIGN KEY `group_zone_access.zone_name` (zone_name) REFERENCES ocp6_zones (zone_name);

		CREATE INDEX `group_zone_access.group_id` ON ocp6_group_zone_access(group_id);
		ALTER TABLE ocp6_group_zone_access ADD FOREIGN KEY `group_zone_access.group_id` (group_id) REFERENCES ocp6_f_groups (id);

		CREATE INDEX `group_page_access.zone_name` ON ocp6_group_page_access(zone_name);
		ALTER TABLE ocp6_group_page_access ADD FOREIGN KEY `group_page_access.zone_name` (zone_name) REFERENCES ocp6_zones (zone_name);

		CREATE INDEX `group_page_access.group_id` ON ocp6_group_page_access(group_id);
		ALTER TABLE ocp6_group_page_access ADD FOREIGN KEY `group_page_access.group_id` (group_id) REFERENCES ocp6_f_groups (id);

		CREATE INDEX `group_category_access.category_name` ON ocp6_group_category_access(category_name);
		ALTER TABLE ocp6_group_category_access ADD FOREIGN KEY `group_category_access.category_name` (category_name) REFERENCES ocp6_anything (id);

		CREATE INDEX `group_category_access.group_id` ON ocp6_group_category_access(group_id);
		ALTER TABLE ocp6_group_category_access ADD FOREIGN KEY `group_category_access.group_id` (group_id) REFERENCES ocp6_f_groups (id);

		CREATE INDEX `gsp.specific_permission` ON ocp6_gsp(specific_permission);
		ALTER TABLE ocp6_gsp ADD FOREIGN KEY `gsp.specific_permission` (specific_permission) REFERENCES ocp6_sp_list (the_name);

		CREATE INDEX `gsp.the_page` ON ocp6_gsp(the_page);
		ALTER TABLE ocp6_gsp ADD FOREIGN KEY `gsp.the_page` (the_page) REFERENCES ocp6_modules (module_the_name);

		CREATE INDEX `gsp.category_name` ON ocp6_gsp(category_name);
		ALTER TABLE ocp6_gsp ADD FOREIGN KEY `gsp.category_name` (category_name) REFERENCES ocp6_anything (id);

		CREATE INDEX `main_activities.a_member_id` ON ocp6_main_activities(a_member_id);
		ALTER TABLE ocp6_main_activities ADD FOREIGN KEY `main_activities.a_member_id` (a_member_id) REFERENCES ocp6_f_members (id);

		CREATE INDEX `members_gifts.to_user_id` ON ocp6_members_gifts(to_user_id);
		ALTER TABLE ocp6_members_gifts ADD FOREIGN KEY `members_gifts.to_user_id` (to_user_id) REFERENCES ocp6_f_members (id);

		CREATE INDEX `members_gifts.from_user_id` ON ocp6_members_gifts(from_user_id);
		ALTER TABLE ocp6_members_gifts ADD FOREIGN KEY `members_gifts.from_user_id` (from_user_id) REFERENCES ocp6_f_members (id);

		CREATE INDEX `members_gifts.topic_id` ON ocp6_members_gifts(topic_id);
		ALTER TABLE ocp6_members_gifts ADD FOREIGN KEY `members_gifts.topic_id` (topic_id) REFERENCES ocp6_ ();

		CREATE INDEX `reported_content.r_session_id` ON ocp6_reported_content(r_session_id);
		ALTER TABLE ocp6_reported_content ADD FOREIGN KEY `reported_content.r_session_id` (r_session_id) REFERENCES ocp6_sessions (id);

		CREATE INDEX `sessions.the_user` ON ocp6_sessions(the_user);
		ALTER TABLE ocp6_sessions ADD FOREIGN KEY `sessions.the_user` (the_user) REFERENCES ocp6_f_members (id);

		CREATE INDEX `translate.source_user` ON ocp6_translate(source_user);
		ALTER TABLE ocp6_translate ADD FOREIGN KEY `translate.source_user` (source_user) REFERENCES ocp6_f_members (id);

		CREATE INDEX `zones.zone_title` ON ocp6_zones(zone_title);
		ALTER TABLE ocp6_zones ADD FOREIGN KEY `zones.zone_title` (zone_title) REFERENCES ocp6_translate (id);

		CREATE INDEX `zones.zone_header_text` ON ocp6_zones(zone_header_text);
		ALTER TABLE ocp6_zones ADD FOREIGN KEY `zones.zone_header_text` (zone_header_text) REFERENCES ocp6_translate (id);

		CREATE INDEX `f_members.m_primary_group` ON ocp6_f_members(m_primary_group);
		ALTER TABLE ocp6_f_members ADD FOREIGN KEY `f_members.m_primary_group` (m_primary_group) REFERENCES ocp6_f_groups (id);

		CREATE INDEX `f_members.m_signature` ON ocp6_f_members(m_signature);
		ALTER TABLE ocp6_f_members ADD FOREIGN KEY `f_members.m_signature` (m_signature) REFERENCES ocp6_translate (id);

		CREATE INDEX `f_members.m_pt_rules_text` ON ocp6_f_members(m_pt_rules_text);
		ALTER TABLE ocp6_f_members ADD FOREIGN KEY `f_members.m_pt_rules_text` (m_pt_rules_text) REFERENCES ocp6_translate (id);

		CREATE INDEX `f_posts.p_post` ON ocp6_f_posts(p_post);
		ALTER TABLE ocp6_f_posts ADD FOREIGN KEY `f_posts.p_post` (p_post) REFERENCES ocp6_translate (id);

		CREATE INDEX `f_posts.p_poster` ON ocp6_f_posts(p_poster);
		ALTER TABLE ocp6_f_posts ADD FOREIGN KEY `f_posts.p_poster` (p_poster) REFERENCES ocp6_f_members (id);

		CREATE INDEX `f_posts.p_intended_solely_for` ON ocp6_f_posts(p_intended_solely_for);
		ALTER TABLE ocp6_f_posts ADD FOREIGN KEY `f_posts.p_intended_solely_for` (p_intended_solely_for) REFERENCES ocp6_f_members (id);

		CREATE INDEX `f_posts.p_topic_id` ON ocp6_f_posts(p_topic_id);
		ALTER TABLE ocp6_f_posts ADD FOREIGN KEY `f_posts.p_topic_id` (p_topic_id) REFERENCES ocp6_f_topics (id);

		CREATE INDEX `f_posts.p_cache_forum_id` ON ocp6_f_posts(p_cache_forum_id);
		ALTER TABLE ocp6_f_posts ADD FOREIGN KEY `f_posts.p_cache_forum_id` (p_cache_forum_id) REFERENCES ocp6_f_forums (id);

		CREATE INDEX `f_posts.p_last_edit_by` ON ocp6_f_posts(p_last_edit_by);
		ALTER TABLE ocp6_f_posts ADD FOREIGN KEY `f_posts.p_last_edit_by` (p_last_edit_by) REFERENCES ocp6_f_members (id);

		CREATE INDEX `f_topics.t_forum_id` ON ocp6_f_topics(t_forum_id);
		ALTER TABLE ocp6_f_topics ADD FOREIGN KEY `f_topics.t_forum_id` (t_forum_id) REFERENCES ocp6_f_forums (id);

		CREATE INDEX `f_topics.t_pt_from` ON ocp6_f_topics(t_pt_from);
		ALTER TABLE ocp6_f_topics ADD FOREIGN KEY `f_topics.t_pt_from` (t_pt_from) REFERENCES ocp6_f_members (id);

		CREATE INDEX `f_topics.t_pt_to` ON ocp6_f_topics(t_pt_to);
		ALTER TABLE ocp6_f_topics ADD FOREIGN KEY `f_topics.t_pt_to` (t_pt_to) REFERENCES ocp6_f_members (id);

		CREATE INDEX `f_topics.t_poll_id` ON ocp6_f_topics(t_poll_id);
		ALTER TABLE ocp6_f_topics ADD FOREIGN KEY `f_topics.t_poll_id` (t_poll_id) REFERENCES ocp6_f_polls (id);

		CREATE INDEX `f_topics.t_cache_first_post_id` ON ocp6_f_topics(t_cache_first_post_id);
		ALTER TABLE ocp6_f_topics ADD FOREIGN KEY `f_topics.t_cache_first_post_id` (t_cache_first_post_id) REFERENCES ocp6_f_posts (id);

		CREATE INDEX `f_topics.t_cache_first_post` ON ocp6_f_topics(t_cache_first_post);
		ALTER TABLE ocp6_f_topics ADD FOREIGN KEY `f_topics.t_cache_first_post` (t_cache_first_post) REFERENCES ocp6_translate (id);

		CREATE INDEX `f_topics.t_cache_first_member_id` ON ocp6_f_topics(t_cache_first_member_id);
		ALTER TABLE ocp6_f_topics ADD FOREIGN KEY `f_topics.t_cache_first_member_id` (t_cache_first_member_id) REFERENCES ocp6_f_members (id);

		CREATE INDEX `f_topics.t_cache_last_post_id` ON ocp6_f_topics(t_cache_last_post_id);
		ALTER TABLE ocp6_f_topics ADD FOREIGN KEY `f_topics.t_cache_last_post_id` (t_cache_last_post_id) REFERENCES ocp6_f_posts (id);

		CREATE INDEX `f_topics.t_cache_last_member_id` ON ocp6_f_topics(t_cache_last_member_id);
		ALTER TABLE ocp6_f_topics ADD FOREIGN KEY `f_topics.t_cache_last_member_id` (t_cache_last_member_id) REFERENCES ocp6_f_members (id);

		CREATE INDEX `f_groups.g_name` ON ocp6_f_groups(g_name);
		ALTER TABLE ocp6_f_groups ADD FOREIGN KEY `f_groups.g_name` (g_name) REFERENCES ocp6_translate (id);

		CREATE INDEX `f_groups.g_group_leader` ON ocp6_f_groups(g_group_leader);
		ALTER TABLE ocp6_f_groups ADD FOREIGN KEY `f_groups.g_group_leader` (g_group_leader) REFERENCES ocp6_f_members (id);

		CREATE INDEX `f_groups.g_title` ON ocp6_f_groups(g_title);
		ALTER TABLE ocp6_f_groups ADD FOREIGN KEY `f_groups.g_title` (g_title) REFERENCES ocp6_translate (id);

		CREATE INDEX `f_groups.g_promotion_target` ON ocp6_f_groups(g_promotion_target);
		ALTER TABLE ocp6_f_groups ADD FOREIGN KEY `f_groups.g_promotion_target` (g_promotion_target) REFERENCES ocp6_f_groups (id);

		CREATE INDEX `f_forums.f_description` ON ocp6_f_forums(f_description);
		ALTER TABLE ocp6_f_forums ADD FOREIGN KEY `f_forums.f_description` (f_description) REFERENCES ocp6_translate (id);

		CREATE INDEX `f_forums.f_category_id` ON ocp6_f_forums(f_category_id);
		ALTER TABLE ocp6_f_forums ADD FOREIGN KEY `f_forums.f_category_id` (f_category_id) REFERENCES ocp6_f_categories (id);

		CREATE INDEX `f_forums.f_parent_forum` ON ocp6_f_forums(f_parent_forum);
		ALTER TABLE ocp6_f_forums ADD FOREIGN KEY `f_forums.f_parent_forum` (f_parent_forum) REFERENCES ocp6_f_forums (id);

		CREATE INDEX `f_forums.f_intro_question` ON ocp6_f_forums(f_intro_question);
		ALTER TABLE ocp6_f_forums ADD FOREIGN KEY `f_forums.f_intro_question` (f_intro_question) REFERENCES ocp6_translate (id);

		CREATE INDEX `f_forums.f_cache_last_topic_id` ON ocp6_f_forums(f_cache_last_topic_id);
		ALTER TABLE ocp6_f_forums ADD FOREIGN KEY `f_forums.f_cache_last_topic_id` (f_cache_last_topic_id) REFERENCES ocp6_f_topics (id);

		CREATE INDEX `f_forums.f_cache_last_member_id` ON ocp6_f_forums(f_cache_last_member_id);
		ALTER TABLE ocp6_f_forums ADD FOREIGN KEY `f_forums.f_cache_last_member_id` (f_cache_last_member_id) REFERENCES ocp6_f_members (id);

		CREATE INDEX `f_forums.f_cache_last_forum_id` ON ocp6_f_forums(f_cache_last_forum_id);
		ALTER TABLE ocp6_f_forums ADD FOREIGN KEY `f_forums.f_cache_last_forum_id` (f_cache_last_forum_id) REFERENCES ocp6_f_forums (id);
