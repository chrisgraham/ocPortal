		CREATE TABLE ocp10_feature_lifetime_monitor
		(
			content_id varchar(80) NULL,
			block_cache_id varchar(80) NULL,
			run_period integer NOT NULL,
			running_now tinyint(1) NOT NULL,
			last_update integer unsigned NOT NULL,
			PRIMARY KEY (content_id,block_cache_id)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_url_id_monikers
		(
			id integer auto_increment NULL,
			m_resource_page varchar(80) NOT NULL,
			m_resource_type varchar(80) NOT NULL,
			m_resource_id varchar(80) NOT NULL,
			m_moniker varchar(255) NOT NULL,
			m_deprecated tinyint(1) NOT NULL,
			m_manually_chosen tinyint(1) NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_review_supplement
		(
			r_post_id integer NULL,
			r_rating_type varchar(80) NULL,
			r_rating tinyint NOT NULL,
			r_topic_id integer NOT NULL,
			r_rating_for_id varchar(80) NOT NULL,
			r_rating_for_type varchar(80) NOT NULL,
			PRIMARY KEY (r_post_id,r_rating_type)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_sms_log
		(
			id integer auto_increment NULL,
			s_member_id integer NOT NULL,
			s_time integer unsigned NOT NULL,
			s_trigger_ip varchar(40) NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_logged_mail_messages
		(
			id integer auto_increment NULL,
			m_subject longtext NOT NULL,
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
			m_template varchar(80) NOT NULL,
			m_extra_cc_addresses longtext NOT NULL,
			m_extra_bcc_addresses longtext NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_link_tracker
		(
			id integer auto_increment NULL,
			c_date_and_time integer unsigned NOT NULL,
			c_member_id integer NOT NULL,
			c_ip_address varchar(40) NOT NULL,
			c_url varchar(255) NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_incoming_uploads
		(
			id integer auto_increment NULL,
			i_submitter integer NOT NULL,
			i_date_and_time integer unsigned NOT NULL,
			i_orig_filename varchar(255) NOT NULL,
			i_save_url varchar(255) NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_cache
		(
			cached_for varchar(80) NULL,
			identifier varchar(40) NULL,
			the_value longtext NOT NULL,
			date_and_time integer unsigned NOT NULL,
			the_theme varchar(80) NULL,
			lang varchar(5) NULL,
			dependencies longtext NOT NULL,
			PRIMARY KEY (cached_for,identifier,the_theme,lang)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_f_group_member_timeouts
		(
			member_id integer NULL,
			group_id integer NULL,
			timeout integer unsigned NOT NULL,
			PRIMARY KEY (member_id,group_id)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_temp_block_permissions
		(
			id integer auto_increment NULL,
			p_session_id integer NOT NULL,
			p_block_constraints longtext NOT NULL,
			p_time integer unsigned NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_cron_caching_requests
		(
			id integer auto_increment NULL,
			c_codename varchar(80) NOT NULL,
			c_map longtext NOT NULL,
			c_timezone varchar(80) NOT NULL,
			c_is_bot tinyint(1) NOT NULL,
			c_store_as_tempcode tinyint(1) NOT NULL,
			c_lang varchar(5) NOT NULL,
			c_theme varchar(80) NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_notifications_enabled
		(
			id integer auto_increment NULL,
			l_member_id integer NOT NULL,
			l_notification_code varchar(80) NOT NULL,
			l_code_category varchar(255) NOT NULL,
			l_setting integer NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_digestives_tin
		(
			id integer auto_increment NULL,
			d_subject longtext NOT NULL,
			d_message integer NOT NULL,
			d_from_member_id integer NOT NULL,
			d_to_member_id integer NOT NULL,
			d_priority tinyint NOT NULL,
			d_no_cc tinyint(1) NOT NULL,
			d_date_and_time integer unsigned NOT NULL,
			d_notification_code varchar(80) NOT NULL,
			d_code_category varchar(255) NOT NULL,
			d_frequency integer NOT NULL,
			d_read tinyint(1) NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_digestives_consumed
		(
			c_member_id integer NULL,
			c_frequency integer NULL,
			c_time integer unsigned NOT NULL,
			PRIMARY KEY (c_member_id,c_frequency)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_alternative_ids
		(
			resource_type varchar(80) NULL,
			resource_id varchar(80) NULL,
			resource_moniker varchar(80) NOT NULL,
			resource_label varchar(255) NOT NULL,
			resource_guid varchar(80) NOT NULL,
			resource_resourcefs_hook varchar(80) NOT NULL,
			PRIMARY KEY (resource_type,resource_id)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_content_privacy
		(
			content_type varchar(80) NULL,
			content_id varchar(80) NULL,
			guest_view tinyint(1) NOT NULL,
			member_view tinyint(1) NOT NULL,
			friend_view tinyint(1) NOT NULL,
			PRIMARY KEY (content_type,content_id)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_content_primary__members
		(
			content_type varchar(80) NULL,
			content_id varchar(80) NULL,
			member_id integer NULL,
			PRIMARY KEY (content_type,content_id,member_id)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_task_queue
		(
			id integer auto_increment NULL,
			t_title varchar(255) NOT NULL,
			t_hook varchar(80) NOT NULL,
			t_args longtext NOT NULL,
			t_member_id integer NOT NULL,
			t_secure_ref varchar(80) NOT NULL,
			t_send_notification tinyint(1) NOT NULL,
			t_locked tinyint(1) NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_menu_items
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

		CREATE TABLE ocp10_trackbacks
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

		CREATE TABLE ocp10_captchas
		(
			si_session_id integer NULL,
			si_time integer unsigned NOT NULL,
			si_code integer NOT NULL,
			PRIMARY KEY (si_session_id)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_member_tracking
		(
			mt_member_id integer NULL,
			mt_cache_username varchar(80) NOT NULL,
			mt_time integer unsigned NULL,
			mt_page varchar(80) NULL,
			mt_type varchar(80) NULL,
			mt_id varchar(80) NULL,
			PRIMARY KEY (mt_member_id,mt_time,mt_page,mt_type,mt_id)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_cache_on
		(
			cached_for varchar(80) NULL,
			cache_on longtext NOT NULL,
			cache_ttl integer NOT NULL,
			PRIMARY KEY (cached_for)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_validated_once
		(
			hash varchar(33) NULL,
			PRIMARY KEY (hash)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_edit_pings
		(
			id integer auto_increment NULL,
			the_page varchar(80) NOT NULL,
			the_type varchar(80) NOT NULL,
			the_id varchar(80) NOT NULL,
			the_time integer unsigned NOT NULL,
			the_member integer NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_translate_history
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

		CREATE TABLE ocp10_long_values
		(
			the_name varchar(80) NULL,
			the_value longtext NOT NULL,
			date_and_time integer unsigned NOT NULL,
			PRIMARY KEY (the_name)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_tutorial_links
		(
			the_name varchar(80) NULL,
			the_value longtext NOT NULL,
			PRIMARY KEY (the_name)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_member_privileges
		(
			member_id integer NULL,
			privilege varchar(80) NULL,
			the_page varchar(80) NULL,
			module_the_name varchar(80) NULL,
			category_name varchar(80) NULL,
			the_value tinyint(1) NOT NULL,
			active_until integer unsigned NOT NULL,
			PRIMARY KEY (member_id,privilege,the_page,module_the_name,category_name)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_member_zone_access
		(
			zone_name varchar(80) NULL,
			member_id integer NULL,
			active_until integer unsigned NOT NULL,
			PRIMARY KEY (zone_name,member_id)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_member_page_access
		(
			page_name varchar(80) NULL,
			zone_name varchar(80) NULL,
			member_id integer NULL,
			active_until integer unsigned NOT NULL,
			PRIMARY KEY (page_name,zone_name,member_id)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_member_category_access
		(
			module_the_name varchar(80) NULL,
			category_name varchar(80) NULL,
			member_id integer NULL,
			active_until integer unsigned NOT NULL,
			PRIMARY KEY (module_the_name,category_name,member_id)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_autosave
		(
			id integer auto_increment NULL,
			a_member_id integer NOT NULL,
			a_key longtext NOT NULL,
			a_value longtext NOT NULL,
			a_time integer unsigned NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_messages_to_render
		(
			id integer auto_increment NULL,
			r_session_id integer NOT NULL,
			r_message longtext NOT NULL,
			r_type varchar(80) NOT NULL,
			r_time integer unsigned NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_url_title_cache
		(
			id integer auto_increment NULL,
			t_url varchar(255) NOT NULL,
			t_title varchar(255) NOT NULL,
			t_meta_title longtext NOT NULL,
			t_keywords longtext NOT NULL,
			t_description longtext NOT NULL,
			t_image_url varchar(255) NOT NULL,
			m_mime_type varchar(80) NOT NULL,
			m_json_discovery varchar(255) NOT NULL,
			m_xml_discovery varchar(255) NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_rating
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

		CREATE TABLE ocp10_failedlogins
		(
			failed_account varchar(80) NOT NULL,
			id integer auto_increment NULL,
			date_and_time integer unsigned NOT NULL,
			ip varchar(40) NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_group_zone_access
		(
			zone_name varchar(80) NULL,
			group_id integer NULL,
			PRIMARY KEY (zone_name,group_id)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_group_page_access
		(
			page_name varchar(80) NULL,
			zone_name varchar(80) NULL,
			group_id integer NULL,
			PRIMARY KEY (page_name,zone_name,group_id)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_activities
		(
			id integer auto_increment NULL,
			a_member_id integer NULL,
			a_also_involving integer NOT NULL,
			a_language_string_code varchar(80) NULL,
			a_label_1 varchar(255) NOT NULL,
			a_label_2 varchar(255) NOT NULL,
			a_label_3 varchar(255) NOT NULL,
			a_page_link_1 varchar(255) NOT NULL,
			a_page_link_2 varchar(255) NOT NULL,
			a_page_link_3 varchar(255) NOT NULL,
			a_time integer unsigned NOT NULL,
			a_addon varchar(80) NOT NULL,
			a_is_public tinyint(1) NOT NULL,
			PRIMARY KEY (id,a_member_id,a_language_string_code)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_attachments
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

		CREATE TABLE ocp10_attachment_refs
		(
			id integer auto_increment NULL,
			r_referer_type varchar(80) NOT NULL,
			r_referer_id varchar(80) NOT NULL,
			a_id integer NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_blocks
		(
			block_name varchar(80) NULL,
			block_author varchar(80) NOT NULL,
			block_organisation varchar(80) NOT NULL,
			block_hacked_by varchar(80) NOT NULL,
			block_hack_version integer NOT NULL,
			block_version integer NOT NULL,
			PRIMARY KEY (block_name)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_bookable
		(
			id integer auto_increment NULL,
			title integer NOT NULL,
			description integer NOT NULL,
			price real NOT NULL,
			categorisation integer NOT NULL,
			cycle_type varchar(80) NOT NULL,
			cycle_pattern varchar(255) NOT NULL,
			user_may_choose_code tinyint(1) NOT NULL,
			supports_notes tinyint(1) NOT NULL,
			dates_are_ranges tinyint(1) NOT NULL,
			calendar_type integer NOT NULL,
			add_date integer unsigned NOT NULL,
			edit_date integer unsigned NOT NULL,
			submitter integer NOT NULL,
			sort_order integer NOT NULL,
			enabled tinyint(1) NOT NULL,
			active_from_day tinyint NOT NULL,
			active_from_month tinyint NOT NULL,
			active_from_year integer NOT NULL,
			active_to_day tinyint NOT NULL,
			active_to_month tinyint NOT NULL,
			active_to_year integer NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_bookable_blacked
		(
			id integer auto_increment NULL,
			blacked_from_day tinyint NOT NULL,
			blacked_from_month tinyint NOT NULL,
			blacked_from_year integer NOT NULL,
			blacked_to_day tinyint NOT NULL,
			blacked_to_month tinyint NOT NULL,
			blacked_to_year integer NOT NULL,
			blacked_explanation integer NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_bookable_blacked_for
		(
			bookable_id integer NULL,
			blacked_id integer NULL,
			PRIMARY KEY (bookable_id,blacked_id)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_bookable_codes
		(
			bookable_id integer NULL,
			code varchar(80) NULL,
			PRIMARY KEY (bookable_id,code)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_bookable_supplement
		(
			id integer auto_increment NULL,
			price real NOT NULL,
			price_is_per_period tinyint(1) NOT NULL,
			supports_quantities tinyint(1) NOT NULL,
			title integer NOT NULL,
			promo_code varchar(80) NOT NULL,
			supports_notes tinyint(1) NOT NULL,
			sort_order integer NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_bookable_supplement_for
		(
			supplement_id integer NULL,
			bookable_id integer NULL,
			PRIMARY KEY (supplement_id,bookable_id)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_booking
		(
			id integer auto_increment NULL,
			bookable_id integer NOT NULL,
			member_id integer NOT NULL,
			b_day tinyint NOT NULL,
			b_month tinyint NOT NULL,
			b_year integer NOT NULL,
			code_allocation varchar(80) NOT NULL,
			notes longtext NOT NULL,
			booked_at integer unsigned NOT NULL,
			paid_at integer unsigned NOT NULL,
			paid_trans_id integer NOT NULL,
			customer_name varchar(255) NOT NULL,
			customer_email varchar(255) NOT NULL,
			customer_mobile varchar(255) NOT NULL,
			customer_phone varchar(255) NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_booking_supplement
		(
			booking_id integer NULL,
			supplement_id integer NULL,
			quantity integer NOT NULL,
			notes longtext NOT NULL,
			PRIMARY KEY (booking_id,supplement_id)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_cached_weather_codes
		(
			id integer auto_increment NULL,
			w_string varchar(255) NOT NULL,
			w_code integer NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_classifieds_prices
		(
			id integer auto_increment NULL,
			c_catalogue_name varchar(80) NOT NULL,
			c_days integer NOT NULL,
			c_label integer NOT NULL,
			c_price real NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_clinic_bookings
		(
			id integer auto_increment NULL,
			b_student_id integer NOT NULL,
			b_course_id integer NOT NULL,
			b_session_id integer NOT NULL,
			b_day tinyint NOT NULL,
			b_month tinyint NOT NULL,
			b_year integer NOT NULL,
			b_session_title varchar(255) NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_clinic_booking_clients
		(
			id integer auto_increment NULL,
			c_booking_id integer NOT NULL,
			c_name varchar(255) NOT NULL,
			c_email varchar(255) NOT NULL,
			c_start_hour tinyint NOT NULL,
			c_start_minute tinyint NOT NULL,
			c_end_hour tinyint NOT NULL,
			c_end_minute tinyint NOT NULL,
			c_slot_run tinyint NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_clinic_sessions
		(
			id integer auto_increment NULL,
			s_from_d tinyint NOT NULL,
			s_from_m tinyint NOT NULL,
			s_from_y integer NOT NULL,
			s_to_d tinyint NOT NULL,
			s_to_m tinyint NOT NULL,
			s_to_y integer NOT NULL,
			s_repeat_mon tinyint(1) NOT NULL,
			s_repeat_tue tinyint(1) NOT NULL,
			s_repeat_wed tinyint(1) NOT NULL,
			s_repeat_thu tinyint(1) NOT NULL,
			s_repeat_fri tinyint(1) NOT NULL,
			s_repeat_sat tinyint(1) NOT NULL,
			s_repeat_sun tinyint(1) NOT NULL,
			s_hours_counts_towards real NOT NULL,
			s_num_student_spots integer NOT NULL,
			s_allow_student_client_choice tinyint(1) NOT NULL,
			s_room_name varchar(255) NOT NULL,
			s_room_start_hour tinyint NOT NULL,
			s_room_start_minute tinyint NOT NULL,
			s_room_end_hour tinyint NOT NULL,
			s_room_end_minute tinyint NOT NULL,
			s_college_id integer NOT NULL,
			s_course_type_id integer NOT NULL,
			s_add_date integer unsigned NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_clinic_sessions_no_dates
		(
			id integer auto_increment NULL,
			s_session_id integer NOT NULL,
			s_day tinyint NOT NULL,
			s_month tinyint NOT NULL,
			s_year integer NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_clinic_sessions_times
		(
			id integer auto_increment NULL,
			s_session_id integer NOT NULL,
			s_start_hour tinyint NOT NULL,
			s_start_minute tinyint NOT NULL,
			s_end_hour tinyint NOT NULL,
			s_end_minute tinyint NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_clinic_sessions_titles
		(
			id integer auto_increment NULL,
			s_session_id integer NOT NULL,
			s_session_title varchar(255) NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_clinic_session_emails
		(
			id integer auto_increment NULL,
			e_subject varchar(255) NOT NULL,
			e_body longtext NOT NULL,
			e_session_title varchar(255) NOT NULL,
			e_for_students tinyint(1) NOT NULL,
			e_for_clients tinyint(1) NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_clinic_session_files
		(
			id integer auto_increment NULL,
			f_email_id integer NOT NULL,
			f_path varchar(255) NOT NULL,
			f_filename varchar(80) NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_config
		(
			c_name varchar(80) NULL,
			c_set tinyint(1) NOT NULL,
			c_value longtext NOT NULL,
			c_needs_dereference tinyint(1) NOT NULL,
			PRIMARY KEY (c_name)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_course_types
		(
			id integer auto_increment NULL,
			t_label varchar(255) NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_credit_purchases
		(
			purchase_id integer auto_increment NULL,
			member_id integer NOT NULL,
			num_credits integer NOT NULL,
			date_and_time integer unsigned NOT NULL,
			purchase_validated tinyint(1) NOT NULL,
			is_manual tinyint(1) NOT NULL,
			PRIMARY KEY (purchase_id)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_diseases
		(
			id integer auto_increment NULL,
			name varchar(255) NOT NULL,
			image varchar(255) NOT NULL,
			cure varchar(255) NOT NULL,
			cure_price integer NOT NULL,
			immunisation varchar(255) NOT NULL,
			immunisation_price integer NOT NULL,
			spread_rate integer NOT NULL,
			points_per_spread integer NOT NULL,
			last_spread_time integer NOT NULL,
			enabled tinyint(1) NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_group_category_access
		(
			module_the_name varchar(80) NULL,
			category_name varchar(80) NULL,
			group_id integer NULL,
			PRIMARY KEY (module_the_name,category_name,group_id)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_group_points
		(
			p_group_id integer NULL,
			p_points_one_off integer NOT NULL,
			p_points_per_month integer NOT NULL,
			PRIMARY KEY (p_group_id)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_group_privileges
		(
			group_id integer NULL,
			privilege varchar(80) NULL,
			the_page varchar(80) NULL,
			module_the_name varchar(80) NULL,
			category_name varchar(80) NULL,
			the_value tinyint(1) NOT NULL,
			PRIMARY KEY (group_id,privilege,the_page,module_the_name,category_name)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_https_pages
		(
			https_page_name varchar(80) NULL,
			PRIMARY KEY (https_page_name)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_logged
		(
			id integer auto_increment NULL,
			website_url varchar(255) NOT NULL,
			website_name varchar(255) NOT NULL,
			is_registered tinyint(1) NOT NULL,
			log_key integer NOT NULL,
			expire integer NOT NULL,
			l_version varchar(80) NOT NULL,
			hittime integer unsigned NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_mayfeature
		(
			id integer auto_increment NULL,
			url varchar(255) NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_members_diseases
		(
			member_id integer NULL,
			disease_id integer NULL,
			sick tinyint(1) NOT NULL,
			cure tinyint(1) NOT NULL,
			immunisation tinyint(1) NOT NULL,
			PRIMARY KEY (member_id,disease_id)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_members_gifts
		(
			id integer auto_increment NULL,
			to_member_id integer NOT NULL,
			from_member_id integer NOT NULL,
			gift_id integer NOT NULL,
			add_time integer unsigned NOT NULL,
			is_anonymous tinyint(1) NOT NULL,
			gift_message longtext NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_modules
		(
			module_the_name varchar(80) NULL,
			module_author varchar(80) NOT NULL,
			module_organisation varchar(80) NOT NULL,
			module_hacked_by varchar(80) NOT NULL,
			module_hack_version integer NOT NULL,
			module_version integer NOT NULL,
			PRIMARY KEY (module_the_name)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_ocgifts
		(
			id integer auto_increment NULL,
			name varchar(255) NOT NULL,
			image varchar(255) NOT NULL,
			price integer NOT NULL,
			enabled tinyint(1) NOT NULL,
			category varchar(255) NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_privilege_list
		(
			p_section varchar(80) NOT NULL,
			the_name varchar(80) NULL,
			the_default tinyint(1) NULL,
			PRIMARY KEY (the_name,the_default)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_referrees_qualified_for
		(
			id integer auto_increment NULL,
			q_referee integer NOT NULL,
			i_inviter integer NOT NULL,
			q_scheme_name varchar(80) NOT NULL,
			q_email_address varchar(255) NOT NULL,
			q_time integer unsigned NOT NULL,
			q_action varchar(80) NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_referrer_override
		(
			o_referrer integer NULL,
			o_scheme_name varchar(80) NULL,
			o_referrals_dif integer NOT NULL,
			o_is_qualified tinyint(1) NOT NULL,
			PRIMARY KEY (o_referrer,o_scheme_name)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_reported_content
		(
			r_session_id integer NULL,
			r_content_type varchar(80) NULL,
			r_content_id varchar(80) NULL,
			r_counts tinyint(1) NOT NULL,
			PRIMARY KEY (r_session_id,r_content_type,r_content_id)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_seo_meta
		(
			id integer auto_increment NULL,
			meta_for_type varchar(80) NOT NULL,
			meta_for_id varchar(80) NOT NULL,
			meta_keywords integer NOT NULL,
			meta_description integer NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_sessions
		(
			the_session integer NULL,
			last_activity integer unsigned NOT NULL,
			member_id integer NOT NULL,
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

		CREATE TABLE ocp10_sites
		(
			s_codename varchar(80) NULL,
			s_name varchar(255) NOT NULL,
			s_description longtext NOT NULL,
			s_category varchar(255) NOT NULL,
			s_domain_name varchar(255) NOT NULL,
			s_server varchar(80) NOT NULL,
			s_member_id integer NOT NULL,
			s_add_time integer unsigned NOT NULL,
			s_last_backup_time integer unsigned NOT NULL,
			s_subscribed tinyint(1) NOT NULL,
			s_sponsored_in_category tinyint(1) NOT NULL,
			s_show_in_directory tinyint(1) NOT NULL,
			s_sent_expire_message tinyint(1) NOT NULL,
			PRIMARY KEY (s_codename)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_sites_advert_pings
		(
			id integer auto_increment NULL,
			s_codename varchar(80) NOT NULL,
			s_time integer unsigned NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_sites_deletion_codes
		(
			s_codename varchar(80) NULL,
			s_code varchar(80) NOT NULL,
			s_time integer unsigned NOT NULL,
			PRIMARY KEY (s_codename)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_sites_email
		(
			s_codename varchar(80) NULL,
			s_email_from varchar(80) NULL,
			s_email_to varchar(255) NOT NULL,
			PRIMARY KEY (s_codename,s_email_from)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_student_course_data
		(
			s_student_id integer NULL,
			s_course_id integer NULL,
			s_hours_dif real NOT NULL,
			PRIMARY KEY (s_student_id,s_course_id)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_tests
		(
			id integer auto_increment NULL,
			t_section integer NOT NULL,
			t_test longtext NOT NULL,
			t_assigned_to integer NOT NULL,
			t_enabled tinyint(1) NOT NULL,
			t_status integer NOT NULL,
			t_inherit_section integer NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_test_sections
		(
			id integer auto_increment NULL,
			s_section varchar(255) NOT NULL,
			s_notes longtext NOT NULL,
			s_inheritable tinyint(1) NOT NULL,
			s_assigned_to integer NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_translate
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

		CREATE TABLE ocp10_values
		(
			the_name varchar(80) NULL,
			the_value varchar(255) NOT NULL,
			date_and_time integer unsigned NOT NULL,
			PRIMARY KEY (the_name)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_workflow_content
		(
			id integer auto_increment NULL,
			source_type varchar(255) NOT NULL,
			source_id varchar(255) NOT NULL,
			workflow_name integer NOT NULL,
			notes longtext NOT NULL,
			original_submitter integer NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_workflow_content_status
		(
			id integer auto_increment NULL,
			workflow_content_id integer NOT NULL,
			workflow_approval_name integer NOT NULL,
			status_code tinyint NOT NULL,
			approved_by integer NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_workflow_permissions
		(
			id integer auto_increment NULL,
			workflow_approval_name integer NOT NULL,
			usergroup integer NOT NULL,
			validated tinyint(1) NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_workflow_requirements
		(
			id integer auto_increment NULL,
			workflow_name integer NOT NULL,
			workflow_approval_name integer NOT NULL,
			the_position integer NOT NULL,
			is_default tinyint(1) NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_zones
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

		CREATE TABLE ocp10_anything
		(
			id varchar(80) NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_f_posts
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

		CREATE TABLE ocp10_f_topics
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

		CREATE TABLE ocp10_f_members
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
			m_dob_day tinyint NOT NULL,
			m_dob_month tinyint NOT NULL,
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

		CREATE TABLE ocp10_f_groups
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

		CREATE TABLE ocp10_calendar_types
		(
			id integer auto_increment NULL,
			t_title integer NOT NULL,
			t_logo varchar(255) NOT NULL,
			t_external_feed varchar(255) NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_transactions
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

		CREATE TABLE ocp10_gifts
		(
			id integer auto_increment NULL,
			date_and_time integer unsigned NOT NULL,
			amount integer NOT NULL,
			gift_from integer NOT NULL,
			gift_to integer NOT NULL,
			reason integer NOT NULL,
			anonymous tinyint(1) NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;

		CREATE TABLE ocp10_f_forums
		(
			id integer auto_increment NULL,
			f_name varchar(255) NOT NULL,
			f_description integer NOT NULL,
			f_forum_grouping_id integer NOT NULL,
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

		CREATE TABLE ocp10_f_polls
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

		CREATE TABLE ocp10_f_forum_groupings
		(
			id integer auto_increment NULL,
			c_title varchar(255) NOT NULL,
			c_description longtext NOT NULL,
			c_expanded_by_default tinyint(1) NOT NULL,
			PRIMARY KEY (id)
		) TYPE=InnoDB;


		CREATE INDEX `url_id_monikers.m_resource_id` ON ocp10_url_id_monikers(m_resource_id);
		ALTER TABLE ocp10_url_id_monikers ADD FOREIGN KEY `url_id_monikers.m_resource_id` (m_resource_id) REFERENCES ocp10_anything (id);

		CREATE INDEX `review_supplement.r_post_id` ON ocp10_review_supplement(r_post_id);
		ALTER TABLE ocp10_review_supplement ADD FOREIGN KEY `review_supplement.r_post_id` (r_post_id) REFERENCES ocp10_f_posts (id);

		CREATE INDEX `review_supplement.r_topic_id` ON ocp10_review_supplement(r_topic_id);
		ALTER TABLE ocp10_review_supplement ADD FOREIGN KEY `review_supplement.r_topic_id` (r_topic_id) REFERENCES ocp10_f_topics (id);

		CREATE INDEX `review_supplement.r_rating_for_id` ON ocp10_review_supplement(r_rating_for_id);
		ALTER TABLE ocp10_review_supplement ADD FOREIGN KEY `review_supplement.r_rating_for_id` (r_rating_for_id) REFERENCES ocp10_modules (module_the_name);

		CREATE INDEX `sms_log.s_member_id` ON ocp10_sms_log(s_member_id);
		ALTER TABLE ocp10_sms_log ADD FOREIGN KEY `sms_log.s_member_id` (s_member_id) REFERENCES ocp10_f_members (id);

		CREATE INDEX `logged_mail_messages.m_as` ON ocp10_logged_mail_messages(m_as);
		ALTER TABLE ocp10_logged_mail_messages ADD FOREIGN KEY `logged_mail_messages.m_as` (m_as) REFERENCES ocp10_f_members (id);

		CREATE INDEX `logged_mail_messages.m_member_id` ON ocp10_logged_mail_messages(m_member_id);
		ALTER TABLE ocp10_logged_mail_messages ADD FOREIGN KEY `logged_mail_messages.m_member_id` (m_member_id) REFERENCES ocp10_f_members (id);

		CREATE INDEX `link_tracker.c_member_id` ON ocp10_link_tracker(c_member_id);
		ALTER TABLE ocp10_link_tracker ADD FOREIGN KEY `link_tracker.c_member_id` (c_member_id) REFERENCES ocp10_f_members (id);

		CREATE INDEX `incoming_uploads.i_submitter` ON ocp10_incoming_uploads(i_submitter);
		ALTER TABLE ocp10_incoming_uploads ADD FOREIGN KEY `incoming_uploads.i_submitter` (i_submitter) REFERENCES ocp10_f_members (id);

		CREATE INDEX `f_group_member_timeouts.member_id` ON ocp10_f_group_member_timeouts(member_id);
		ALTER TABLE ocp10_f_group_member_timeouts ADD FOREIGN KEY `f_group_member_timeouts.member_id` (member_id) REFERENCES ocp10_f_members (id);

		CREATE INDEX `f_group_member_timeouts.group_id` ON ocp10_f_group_member_timeouts(group_id);
		ALTER TABLE ocp10_f_group_member_timeouts ADD FOREIGN KEY `f_group_member_timeouts.group_id` (group_id) REFERENCES ocp10_f_groups (id);

		CREATE INDEX `temp_block_permissions.p_session_id` ON ocp10_temp_block_permissions(p_session_id);
		ALTER TABLE ocp10_temp_block_permissions ADD FOREIGN KEY `temp_block_permissions.p_session_id` (p_session_id) REFERENCES ocp10_sessions (id);

		CREATE INDEX `notifications_enabled.l_member_id` ON ocp10_notifications_enabled(l_member_id);
		ALTER TABLE ocp10_notifications_enabled ADD FOREIGN KEY `notifications_enabled.l_member_id` (l_member_id) REFERENCES ocp10_f_members (id);

		CREATE INDEX `digestives_tin.d_message` ON ocp10_digestives_tin(d_message);
		ALTER TABLE ocp10_digestives_tin ADD FOREIGN KEY `digestives_tin.d_message` (d_message) REFERENCES ocp10_translate (id);

		CREATE INDEX `digestives_tin.d_from_member_id` ON ocp10_digestives_tin(d_from_member_id);
		ALTER TABLE ocp10_digestives_tin ADD FOREIGN KEY `digestives_tin.d_from_member_id` (d_from_member_id) REFERENCES ocp10_f_members (id);

		CREATE INDEX `digestives_tin.d_to_member_id` ON ocp10_digestives_tin(d_to_member_id);
		ALTER TABLE ocp10_digestives_tin ADD FOREIGN KEY `digestives_tin.d_to_member_id` (d_to_member_id) REFERENCES ocp10_f_members (id);

		CREATE INDEX `digestives_consumed.c_member_id` ON ocp10_digestives_consumed(c_member_id);
		ALTER TABLE ocp10_digestives_consumed ADD FOREIGN KEY `digestives_consumed.c_member_id` (c_member_id) REFERENCES ocp10_f_members (id);

		CREATE INDEX `content_primary__members.member_id` ON ocp10_content_primary__members(member_id);
		ALTER TABLE ocp10_content_primary__members ADD FOREIGN KEY `content_primary__members.member_id` (member_id) REFERENCES ocp10_f_members (id);

		CREATE INDEX `task_queue.t_member_id` ON ocp10_task_queue(t_member_id);
		ALTER TABLE ocp10_task_queue ADD FOREIGN KEY `task_queue.t_member_id` (t_member_id) REFERENCES ocp10_f_members (id);

		CREATE INDEX `menu_items.i_parent` ON ocp10_menu_items(i_parent);
		ALTER TABLE ocp10_menu_items ADD FOREIGN KEY `menu_items.i_parent` (i_parent) REFERENCES ocp10_menu_items (id);

		CREATE INDEX `menu_items.i_caption` ON ocp10_menu_items(i_caption);
		ALTER TABLE ocp10_menu_items ADD FOREIGN KEY `menu_items.i_caption` (i_caption) REFERENCES ocp10_translate (id);

		CREATE INDEX `menu_items.i_caption_long` ON ocp10_menu_items(i_caption_long);
		ALTER TABLE ocp10_menu_items ADD FOREIGN KEY `menu_items.i_caption_long` (i_caption_long) REFERENCES ocp10_translate (id);

		CREATE INDEX `trackbacks.trackback_for_id` ON ocp10_trackbacks(trackback_for_id);
		ALTER TABLE ocp10_trackbacks ADD FOREIGN KEY `trackbacks.trackback_for_id` (trackback_for_id) REFERENCES ocp10_anything (id);

		CREATE INDEX `member_tracking.mt_member_id` ON ocp10_member_tracking(mt_member_id);
		ALTER TABLE ocp10_member_tracking ADD FOREIGN KEY `member_tracking.mt_member_id` (mt_member_id) REFERENCES ocp10_f_members (id);

		CREATE INDEX `edit_pings.the_member` ON ocp10_edit_pings(the_member);
		ALTER TABLE ocp10_edit_pings ADD FOREIGN KEY `edit_pings.the_member` (the_member) REFERENCES ocp10_f_members (id);

		CREATE INDEX `translate_history.lang_id` ON ocp10_translate_history(lang_id);
		ALTER TABLE ocp10_translate_history ADD FOREIGN KEY `translate_history.lang_id` (lang_id) REFERENCES ocp10_translate (id);

		CREATE INDEX `translate_history.action_member` ON ocp10_translate_history(action_member);
		ALTER TABLE ocp10_translate_history ADD FOREIGN KEY `translate_history.action_member` (action_member) REFERENCES ocp10_f_members (id);

		CREATE INDEX `member_privileges.privilege` ON ocp10_member_privileges(privilege);
		ALTER TABLE ocp10_member_privileges ADD FOREIGN KEY `member_privileges.privilege` (privilege) REFERENCES ocp10_privilege_list (the_name);

		CREATE INDEX `member_privileges.the_page` ON ocp10_member_privileges(the_page);
		ALTER TABLE ocp10_member_privileges ADD FOREIGN KEY `member_privileges.the_page` (the_page) REFERENCES ocp10_modules (module_the_name);

		CREATE INDEX `member_privileges.category_name` ON ocp10_member_privileges(category_name);
		ALTER TABLE ocp10_member_privileges ADD FOREIGN KEY `member_privileges.category_name` (category_name) REFERENCES ocp10_anything (id);

		CREATE INDEX `member_zone_access.zone_name` ON ocp10_member_zone_access(zone_name);
		ALTER TABLE ocp10_member_zone_access ADD FOREIGN KEY `member_zone_access.zone_name` (zone_name) REFERENCES ocp10_zones (zone_name);

		CREATE INDEX `member_zone_access.member_id` ON ocp10_member_zone_access(member_id);
		ALTER TABLE ocp10_member_zone_access ADD FOREIGN KEY `member_zone_access.member_id` (member_id) REFERENCES ocp10_f_members (id);

		CREATE INDEX `member_page_access.page_name` ON ocp10_member_page_access(page_name);
		ALTER TABLE ocp10_member_page_access ADD FOREIGN KEY `member_page_access.page_name` (page_name) REFERENCES ocp10_modules (module_the_name);

		CREATE INDEX `member_page_access.zone_name` ON ocp10_member_page_access(zone_name);
		ALTER TABLE ocp10_member_page_access ADD FOREIGN KEY `member_page_access.zone_name` (zone_name) REFERENCES ocp10_zones (zone_name);

		CREATE INDEX `member_page_access.member_id` ON ocp10_member_page_access(member_id);
		ALTER TABLE ocp10_member_page_access ADD FOREIGN KEY `member_page_access.member_id` (member_id) REFERENCES ocp10_f_members (id);

		CREATE INDEX `member_category_access.category_name` ON ocp10_member_category_access(category_name);
		ALTER TABLE ocp10_member_category_access ADD FOREIGN KEY `member_category_access.category_name` (category_name) REFERENCES ocp10_anything (id);

		CREATE INDEX `member_category_access.member_id` ON ocp10_member_category_access(member_id);
		ALTER TABLE ocp10_member_category_access ADD FOREIGN KEY `member_category_access.member_id` (member_id) REFERENCES ocp10_f_members (id);

		CREATE INDEX `autosave.a_member_id` ON ocp10_autosave(a_member_id);
		ALTER TABLE ocp10_autosave ADD FOREIGN KEY `autosave.a_member_id` (a_member_id) REFERENCES ocp10_f_members (id);

		CREATE INDEX `messages_to_render.r_session_id` ON ocp10_messages_to_render(r_session_id);
		ALTER TABLE ocp10_messages_to_render ADD FOREIGN KEY `messages_to_render.r_session_id` (r_session_id) REFERENCES ocp10_sessions (the_session);

		CREATE INDEX `rating.rating_for_id` ON ocp10_rating(rating_for_id);
		ALTER TABLE ocp10_rating ADD FOREIGN KEY `rating.rating_for_id` (rating_for_id) REFERENCES ocp10_modules (module_the_name);

		CREATE INDEX `rating.rating_member` ON ocp10_rating(rating_member);
		ALTER TABLE ocp10_rating ADD FOREIGN KEY `rating.rating_member` (rating_member) REFERENCES ocp10_f_members (id);

		CREATE INDEX `group_zone_access.zone_name` ON ocp10_group_zone_access(zone_name);
		ALTER TABLE ocp10_group_zone_access ADD FOREIGN KEY `group_zone_access.zone_name` (zone_name) REFERENCES ocp10_zones (zone_name);

		CREATE INDEX `group_zone_access.group_id` ON ocp10_group_zone_access(group_id);
		ALTER TABLE ocp10_group_zone_access ADD FOREIGN KEY `group_zone_access.group_id` (group_id) REFERENCES ocp10_f_groups (id);

		CREATE INDEX `group_page_access.zone_name` ON ocp10_group_page_access(zone_name);
		ALTER TABLE ocp10_group_page_access ADD FOREIGN KEY `group_page_access.zone_name` (zone_name) REFERENCES ocp10_zones (zone_name);

		CREATE INDEX `group_page_access.group_id` ON ocp10_group_page_access(group_id);
		ALTER TABLE ocp10_group_page_access ADD FOREIGN KEY `group_page_access.group_id` (group_id) REFERENCES ocp10_f_groups (id);

		CREATE INDEX `activities.a_member_id` ON ocp10_activities(a_member_id);
		ALTER TABLE ocp10_activities ADD FOREIGN KEY `activities.a_member_id` (a_member_id) REFERENCES ocp10_f_members (id);

		CREATE INDEX `activities.a_also_involving` ON ocp10_activities(a_also_involving);
		ALTER TABLE ocp10_activities ADD FOREIGN KEY `activities.a_also_involving` (a_also_involving) REFERENCES ocp10_f_members (id);

		CREATE INDEX `attachments.a_member_id` ON ocp10_attachments(a_member_id);
		ALTER TABLE ocp10_attachments ADD FOREIGN KEY `attachments.a_member_id` (a_member_id) REFERENCES ocp10_f_members (id);

		CREATE INDEX `attachment_refs.r_referer_id` ON ocp10_attachment_refs(r_referer_id);
		ALTER TABLE ocp10_attachment_refs ADD FOREIGN KEY `attachment_refs.r_referer_id` (r_referer_id) REFERENCES ocp10_anything (id);

		CREATE INDEX `attachment_refs.a_id` ON ocp10_attachment_refs(a_id);
		ALTER TABLE ocp10_attachment_refs ADD FOREIGN KEY `attachment_refs.a_id` (a_id) REFERENCES ocp10_attachments (id);

		CREATE INDEX `bookable.title` ON ocp10_bookable(title);
		ALTER TABLE ocp10_bookable ADD FOREIGN KEY `bookable.title` (title) REFERENCES ocp10_translate (id);

		CREATE INDEX `bookable.description` ON ocp10_bookable(description);
		ALTER TABLE ocp10_bookable ADD FOREIGN KEY `bookable.description` (description) REFERENCES ocp10_translate (id);

		CREATE INDEX `bookable.categorisation` ON ocp10_bookable(categorisation);
		ALTER TABLE ocp10_bookable ADD FOREIGN KEY `bookable.categorisation` (categorisation) REFERENCES ocp10_translate (id);

		CREATE INDEX `bookable.calendar_type` ON ocp10_bookable(calendar_type);
		ALTER TABLE ocp10_bookable ADD FOREIGN KEY `bookable.calendar_type` (calendar_type) REFERENCES ocp10_calendar_types (id);

		CREATE INDEX `bookable.submitter` ON ocp10_bookable(submitter);
		ALTER TABLE ocp10_bookable ADD FOREIGN KEY `bookable.submitter` (submitter) REFERENCES ocp10_f_members (id);

		CREATE INDEX `bookable_blacked.blacked_explanation` ON ocp10_bookable_blacked(blacked_explanation);
		ALTER TABLE ocp10_bookable_blacked ADD FOREIGN KEY `bookable_blacked.blacked_explanation` (blacked_explanation) REFERENCES ocp10_translate (id);

		CREATE INDEX `bookable_blacked_for.bookable_id` ON ocp10_bookable_blacked_for(bookable_id);
		ALTER TABLE ocp10_bookable_blacked_for ADD FOREIGN KEY `bookable_blacked_for.bookable_id` (bookable_id) REFERENCES ocp10_bookable (id);

		CREATE INDEX `bookable_blacked_for.blacked_id` ON ocp10_bookable_blacked_for(blacked_id);
		ALTER TABLE ocp10_bookable_blacked_for ADD FOREIGN KEY `bookable_blacked_for.blacked_id` (blacked_id) REFERENCES ocp10_bookable_codes (code);

		CREATE INDEX `bookable_codes.bookable_id` ON ocp10_bookable_codes(bookable_id);
		ALTER TABLE ocp10_bookable_codes ADD FOREIGN KEY `bookable_codes.bookable_id` (bookable_id) REFERENCES ocp10_bookable (id);

		CREATE INDEX `bookable_supplement.title` ON ocp10_bookable_supplement(title);
		ALTER TABLE ocp10_bookable_supplement ADD FOREIGN KEY `bookable_supplement.title` (title) REFERENCES ocp10_translate (id);

		CREATE INDEX `bookable_supplement_for.supplement_id` ON ocp10_bookable_supplement_for(supplement_id);
		ALTER TABLE ocp10_bookable_supplement_for ADD FOREIGN KEY `bookable_supplement_for.supplement_id` (supplement_id) REFERENCES ocp10_bookable_supplement (id);

		CREATE INDEX `bookable_supplement_for.bookable_id` ON ocp10_bookable_supplement_for(bookable_id);
		ALTER TABLE ocp10_bookable_supplement_for ADD FOREIGN KEY `bookable_supplement_for.bookable_id` (bookable_id) REFERENCES ocp10_bookable (id);

		CREATE INDEX `booking.bookable_id` ON ocp10_booking(bookable_id);
		ALTER TABLE ocp10_booking ADD FOREIGN KEY `booking.bookable_id` (bookable_id) REFERENCES ocp10_bookable (id);

		CREATE INDEX `booking.member_id` ON ocp10_booking(member_id);
		ALTER TABLE ocp10_booking ADD FOREIGN KEY `booking.member_id` (member_id) REFERENCES ocp10_f_members (id);

		CREATE INDEX `booking.paid_trans_id` ON ocp10_booking(paid_trans_id);
		ALTER TABLE ocp10_booking ADD FOREIGN KEY `booking.paid_trans_id` (paid_trans_id) REFERENCES ocp10_transactions (id);

		CREATE INDEX `booking_supplement.booking_id` ON ocp10_booking_supplement(booking_id);
		ALTER TABLE ocp10_booking_supplement ADD FOREIGN KEY `booking_supplement.booking_id` (booking_id) REFERENCES ocp10_booking (id);

		CREATE INDEX `booking_supplement.supplement_id` ON ocp10_booking_supplement(supplement_id);
		ALTER TABLE ocp10_booking_supplement ADD FOREIGN KEY `booking_supplement.supplement_id` (supplement_id) REFERENCES ocp10_bookable_supplement (id);

		CREATE INDEX `classifieds_prices.c_label` ON ocp10_classifieds_prices(c_label);
		ALTER TABLE ocp10_classifieds_prices ADD FOREIGN KEY `classifieds_prices.c_label` (c_label) REFERENCES ocp10_translate (id);

		CREATE INDEX `clinic_bookings.b_student_id` ON ocp10_clinic_bookings(b_student_id);
		ALTER TABLE ocp10_clinic_bookings ADD FOREIGN KEY `clinic_bookings.b_student_id` (b_student_id) REFERENCES ocp10_ ();

		CREATE INDEX `clinic_bookings.b_course_id` ON ocp10_clinic_bookings(b_course_id);
		ALTER TABLE ocp10_clinic_bookings ADD FOREIGN KEY `clinic_bookings.b_course_id` (b_course_id) REFERENCES ocp10_ ();

		CREATE INDEX `clinic_bookings.b_session_id` ON ocp10_clinic_bookings(b_session_id);
		ALTER TABLE ocp10_clinic_bookings ADD FOREIGN KEY `clinic_bookings.b_session_id` (b_session_id) REFERENCES ocp10_ ();

		CREATE INDEX `clinic_booking_clients.c_booking_id` ON ocp10_clinic_booking_clients(c_booking_id);
		ALTER TABLE ocp10_clinic_booking_clients ADD FOREIGN KEY `clinic_booking_clients.c_booking_id` (c_booking_id) REFERENCES ocp10_ ();

		CREATE INDEX `clinic_sessions.s_college_id` ON ocp10_clinic_sessions(s_college_id);
		ALTER TABLE ocp10_clinic_sessions ADD FOREIGN KEY `clinic_sessions.s_college_id` (s_college_id) REFERENCES ocp10_ ();

		CREATE INDEX `clinic_sessions.s_course_type_id` ON ocp10_clinic_sessions(s_course_type_id);
		ALTER TABLE ocp10_clinic_sessions ADD FOREIGN KEY `clinic_sessions.s_course_type_id` (s_course_type_id) REFERENCES ocp10_ ();

		CREATE INDEX `clinic_sessions_no_dates.s_session_id` ON ocp10_clinic_sessions_no_dates(s_session_id);
		ALTER TABLE ocp10_clinic_sessions_no_dates ADD FOREIGN KEY `clinic_sessions_no_dates.s_session_id` (s_session_id) REFERENCES ocp10_ ();

		CREATE INDEX `clinic_sessions_times.s_session_id` ON ocp10_clinic_sessions_times(s_session_id);
		ALTER TABLE ocp10_clinic_sessions_times ADD FOREIGN KEY `clinic_sessions_times.s_session_id` (s_session_id) REFERENCES ocp10_ ();

		CREATE INDEX `clinic_sessions_titles.s_session_id` ON ocp10_clinic_sessions_titles(s_session_id);
		ALTER TABLE ocp10_clinic_sessions_titles ADD FOREIGN KEY `clinic_sessions_titles.s_session_id` (s_session_id) REFERENCES ocp10_ ();

		CREATE INDEX `clinic_session_files.f_email_id` ON ocp10_clinic_session_files(f_email_id);
		ALTER TABLE ocp10_clinic_session_files ADD FOREIGN KEY `clinic_session_files.f_email_id` (f_email_id) REFERENCES ocp10_ ();

		CREATE INDEX `credit_purchases.member_id` ON ocp10_credit_purchases(member_id);
		ALTER TABLE ocp10_credit_purchases ADD FOREIGN KEY `credit_purchases.member_id` (member_id) REFERENCES ocp10_f_members (id);

		CREATE INDEX `group_category_access.category_name` ON ocp10_group_category_access(category_name);
		ALTER TABLE ocp10_group_category_access ADD FOREIGN KEY `group_category_access.category_name` (category_name) REFERENCES ocp10_anything (id);

		CREATE INDEX `group_category_access.group_id` ON ocp10_group_category_access(group_id);
		ALTER TABLE ocp10_group_category_access ADD FOREIGN KEY `group_category_access.group_id` (group_id) REFERENCES ocp10_f_groups (id);

		CREATE INDEX `group_points.p_group_id` ON ocp10_group_points(p_group_id);
		ALTER TABLE ocp10_group_points ADD FOREIGN KEY `group_points.p_group_id` (p_group_id) REFERENCES ocp10_f_groups (id);

		CREATE INDEX `group_privileges.privilege` ON ocp10_group_privileges(privilege);
		ALTER TABLE ocp10_group_privileges ADD FOREIGN KEY `group_privileges.privilege` (privilege) REFERENCES ocp10_privilege_list (the_name);

		CREATE INDEX `group_privileges.the_page` ON ocp10_group_privileges(the_page);
		ALTER TABLE ocp10_group_privileges ADD FOREIGN KEY `group_privileges.the_page` (the_page) REFERENCES ocp10_modules (module_the_name);

		CREATE INDEX `group_privileges.category_name` ON ocp10_group_privileges(category_name);
		ALTER TABLE ocp10_group_privileges ADD FOREIGN KEY `group_privileges.category_name` (category_name) REFERENCES ocp10_anything (id);

		CREATE INDEX `members_diseases.member_id` ON ocp10_members_diseases(member_id);
		ALTER TABLE ocp10_members_diseases ADD FOREIGN KEY `members_diseases.member_id` (member_id) REFERENCES ocp10_f_members (id);

		CREATE INDEX `members_diseases.disease_id` ON ocp10_members_diseases(disease_id);
		ALTER TABLE ocp10_members_diseases ADD FOREIGN KEY `members_diseases.disease_id` (disease_id) REFERENCES ocp10_diseases (id);

		CREATE INDEX `members_gifts.to_member_id` ON ocp10_members_gifts(to_member_id);
		ALTER TABLE ocp10_members_gifts ADD FOREIGN KEY `members_gifts.to_member_id` (to_member_id) REFERENCES ocp10_f_members (id);

		CREATE INDEX `members_gifts.from_member_id` ON ocp10_members_gifts(from_member_id);
		ALTER TABLE ocp10_members_gifts ADD FOREIGN KEY `members_gifts.from_member_id` (from_member_id) REFERENCES ocp10_f_members (id);

		CREATE INDEX `members_gifts.gift_id` ON ocp10_members_gifts(gift_id);
		ALTER TABLE ocp10_members_gifts ADD FOREIGN KEY `members_gifts.gift_id` (gift_id) REFERENCES ocp10_gifts (id);

		CREATE INDEX `referrees_qualified_for.q_referee` ON ocp10_referrees_qualified_for(q_referee);
		ALTER TABLE ocp10_referrees_qualified_for ADD FOREIGN KEY `referrees_qualified_for.q_referee` (q_referee) REFERENCES ocp10_f_members (id);

		CREATE INDEX `referrees_qualified_for.i_inviter` ON ocp10_referrees_qualified_for(i_inviter);
		ALTER TABLE ocp10_referrees_qualified_for ADD FOREIGN KEY `referrees_qualified_for.i_inviter` (i_inviter) REFERENCES ocp10_f_members (id);

		CREATE INDEX `referrer_override.o_referrer` ON ocp10_referrer_override(o_referrer);
		ALTER TABLE ocp10_referrer_override ADD FOREIGN KEY `referrer_override.o_referrer` (o_referrer) REFERENCES ocp10_f_members (id);

		CREATE INDEX `reported_content.r_session_id` ON ocp10_reported_content(r_session_id);
		ALTER TABLE ocp10_reported_content ADD FOREIGN KEY `reported_content.r_session_id` (r_session_id) REFERENCES ocp10_sessions (id);

		CREATE INDEX `seo_meta.meta_for_id` ON ocp10_seo_meta(meta_for_id);
		ALTER TABLE ocp10_seo_meta ADD FOREIGN KEY `seo_meta.meta_for_id` (meta_for_id) REFERENCES ocp10_anything (id);

		CREATE INDEX `seo_meta.meta_keywords` ON ocp10_seo_meta(meta_keywords);
		ALTER TABLE ocp10_seo_meta ADD FOREIGN KEY `seo_meta.meta_keywords` (meta_keywords) REFERENCES ocp10_translate (id);

		CREATE INDEX `seo_meta.meta_description` ON ocp10_seo_meta(meta_description);
		ALTER TABLE ocp10_seo_meta ADD FOREIGN KEY `seo_meta.meta_description` (meta_description) REFERENCES ocp10_translate (id);

		CREATE INDEX `sessions.member_id` ON ocp10_sessions(member_id);
		ALTER TABLE ocp10_sessions ADD FOREIGN KEY `sessions.member_id` (member_id) REFERENCES ocp10_f_members (id);

		CREATE INDEX `sites.s_member_id` ON ocp10_sites(s_member_id);
		ALTER TABLE ocp10_sites ADD FOREIGN KEY `sites.s_member_id` (s_member_id) REFERENCES ocp10_f_members (id);

		CREATE INDEX `student_course_data.s_student_id` ON ocp10_student_course_data(s_student_id);
		ALTER TABLE ocp10_student_course_data ADD FOREIGN KEY `student_course_data.s_student_id` (s_student_id) REFERENCES ocp10_ ();

		CREATE INDEX `student_course_data.s_course_id` ON ocp10_student_course_data(s_course_id);
		ALTER TABLE ocp10_student_course_data ADD FOREIGN KEY `student_course_data.s_course_id` (s_course_id) REFERENCES ocp10_ ();

		CREATE INDEX `tests.t_section` ON ocp10_tests(t_section);
		ALTER TABLE ocp10_tests ADD FOREIGN KEY `tests.t_section` (t_section) REFERENCES ocp10_test_sections (id);

		CREATE INDEX `tests.t_assigned_to` ON ocp10_tests(t_assigned_to);
		ALTER TABLE ocp10_tests ADD FOREIGN KEY `tests.t_assigned_to` (t_assigned_to) REFERENCES ocp10_f_members (id);

		CREATE INDEX `tests.t_inherit_section` ON ocp10_tests(t_inherit_section);
		ALTER TABLE ocp10_tests ADD FOREIGN KEY `tests.t_inherit_section` (t_inherit_section) REFERENCES ocp10_test_sections (id);

		CREATE INDEX `test_sections.s_assigned_to` ON ocp10_test_sections(s_assigned_to);
		ALTER TABLE ocp10_test_sections ADD FOREIGN KEY `test_sections.s_assigned_to` (s_assigned_to) REFERENCES ocp10_f_members (id);

		CREATE INDEX `translate.source_user` ON ocp10_translate(source_user);
		ALTER TABLE ocp10_translate ADD FOREIGN KEY `translate.source_user` (source_user) REFERENCES ocp10_f_members (id);

		CREATE INDEX `workflow_content.workflow_name` ON ocp10_workflow_content(workflow_name);
		ALTER TABLE ocp10_workflow_content ADD FOREIGN KEY `workflow_content.workflow_name` (workflow_name) REFERENCES ocp10_translate (id);

		CREATE INDEX `workflow_content.original_submitter` ON ocp10_workflow_content(original_submitter);
		ALTER TABLE ocp10_workflow_content ADD FOREIGN KEY `workflow_content.original_submitter` (original_submitter) REFERENCES ocp10_f_members (id);

		CREATE INDEX `workflow_content_status.workflow_approval_name` ON ocp10_workflow_content_status(workflow_approval_name);
		ALTER TABLE ocp10_workflow_content_status ADD FOREIGN KEY `workflow_content_status.workflow_approval_name` (workflow_approval_name) REFERENCES ocp10_translate (id);

		CREATE INDEX `workflow_content_status.approved_by` ON ocp10_workflow_content_status(approved_by);
		ALTER TABLE ocp10_workflow_content_status ADD FOREIGN KEY `workflow_content_status.approved_by` (approved_by) REFERENCES ocp10_f_members (id);

		CREATE INDEX `workflow_permissions.workflow_approval_name` ON ocp10_workflow_permissions(workflow_approval_name);
		ALTER TABLE ocp10_workflow_permissions ADD FOREIGN KEY `workflow_permissions.workflow_approval_name` (workflow_approval_name) REFERENCES ocp10_translate (id);

		CREATE INDEX `workflow_permissions.usergroup` ON ocp10_workflow_permissions(usergroup);
		ALTER TABLE ocp10_workflow_permissions ADD FOREIGN KEY `workflow_permissions.usergroup` (usergroup) REFERENCES ocp10_f_groups (id);

		CREATE INDEX `workflow_requirements.workflow_name` ON ocp10_workflow_requirements(workflow_name);
		ALTER TABLE ocp10_workflow_requirements ADD FOREIGN KEY `workflow_requirements.workflow_name` (workflow_name) REFERENCES ocp10_translate (id);

		CREATE INDEX `workflow_requirements.workflow_approval_name` ON ocp10_workflow_requirements(workflow_approval_name);
		ALTER TABLE ocp10_workflow_requirements ADD FOREIGN KEY `workflow_requirements.workflow_approval_name` (workflow_approval_name) REFERENCES ocp10_translate (id);

		CREATE INDEX `zones.zone_title` ON ocp10_zones(zone_title);
		ALTER TABLE ocp10_zones ADD FOREIGN KEY `zones.zone_title` (zone_title) REFERENCES ocp10_translate (id);

		CREATE INDEX `zones.zone_header_text` ON ocp10_zones(zone_header_text);
		ALTER TABLE ocp10_zones ADD FOREIGN KEY `zones.zone_header_text` (zone_header_text) REFERENCES ocp10_translate (id);

		CREATE INDEX `f_posts.p_post` ON ocp10_f_posts(p_post);
		ALTER TABLE ocp10_f_posts ADD FOREIGN KEY `f_posts.p_post` (p_post) REFERENCES ocp10_translate (id);

		CREATE INDEX `f_posts.p_poster` ON ocp10_f_posts(p_poster);
		ALTER TABLE ocp10_f_posts ADD FOREIGN KEY `f_posts.p_poster` (p_poster) REFERENCES ocp10_f_members (id);

		CREATE INDEX `f_posts.p_intended_solely_for` ON ocp10_f_posts(p_intended_solely_for);
		ALTER TABLE ocp10_f_posts ADD FOREIGN KEY `f_posts.p_intended_solely_for` (p_intended_solely_for) REFERENCES ocp10_f_members (id);

		CREATE INDEX `f_posts.p_topic_id` ON ocp10_f_posts(p_topic_id);
		ALTER TABLE ocp10_f_posts ADD FOREIGN KEY `f_posts.p_topic_id` (p_topic_id) REFERENCES ocp10_f_topics (id);

		CREATE INDEX `f_posts.p_cache_forum_id` ON ocp10_f_posts(p_cache_forum_id);
		ALTER TABLE ocp10_f_posts ADD FOREIGN KEY `f_posts.p_cache_forum_id` (p_cache_forum_id) REFERENCES ocp10_f_forums (id);

		CREATE INDEX `f_posts.p_last_edit_by` ON ocp10_f_posts(p_last_edit_by);
		ALTER TABLE ocp10_f_posts ADD FOREIGN KEY `f_posts.p_last_edit_by` (p_last_edit_by) REFERENCES ocp10_f_members (id);

		CREATE INDEX `f_posts.p_parent_id` ON ocp10_f_posts(p_parent_id);
		ALTER TABLE ocp10_f_posts ADD FOREIGN KEY `f_posts.p_parent_id` (p_parent_id) REFERENCES ocp10_f_posts (id);

		CREATE INDEX `f_topics.t_forum_id` ON ocp10_f_topics(t_forum_id);
		ALTER TABLE ocp10_f_topics ADD FOREIGN KEY `f_topics.t_forum_id` (t_forum_id) REFERENCES ocp10_f_forums (id);

		CREATE INDEX `f_topics.t_pt_from` ON ocp10_f_topics(t_pt_from);
		ALTER TABLE ocp10_f_topics ADD FOREIGN KEY `f_topics.t_pt_from` (t_pt_from) REFERENCES ocp10_f_members (id);

		CREATE INDEX `f_topics.t_pt_to` ON ocp10_f_topics(t_pt_to);
		ALTER TABLE ocp10_f_topics ADD FOREIGN KEY `f_topics.t_pt_to` (t_pt_to) REFERENCES ocp10_f_members (id);

		CREATE INDEX `f_topics.t_poll_id` ON ocp10_f_topics(t_poll_id);
		ALTER TABLE ocp10_f_topics ADD FOREIGN KEY `f_topics.t_poll_id` (t_poll_id) REFERENCES ocp10_f_polls (id);

		CREATE INDEX `f_topics.t_cache_first_post_id` ON ocp10_f_topics(t_cache_first_post_id);
		ALTER TABLE ocp10_f_topics ADD FOREIGN KEY `f_topics.t_cache_first_post_id` (t_cache_first_post_id) REFERENCES ocp10_f_posts (id);

		CREATE INDEX `f_topics.t_cache_first_post` ON ocp10_f_topics(t_cache_first_post);
		ALTER TABLE ocp10_f_topics ADD FOREIGN KEY `f_topics.t_cache_first_post` (t_cache_first_post) REFERENCES ocp10_translate (id);

		CREATE INDEX `f_topics.t_cache_first_member_id` ON ocp10_f_topics(t_cache_first_member_id);
		ALTER TABLE ocp10_f_topics ADD FOREIGN KEY `f_topics.t_cache_first_member_id` (t_cache_first_member_id) REFERENCES ocp10_f_members (id);

		CREATE INDEX `f_topics.t_cache_last_post_id` ON ocp10_f_topics(t_cache_last_post_id);
		ALTER TABLE ocp10_f_topics ADD FOREIGN KEY `f_topics.t_cache_last_post_id` (t_cache_last_post_id) REFERENCES ocp10_f_posts (id);

		CREATE INDEX `f_topics.t_cache_last_member_id` ON ocp10_f_topics(t_cache_last_member_id);
		ALTER TABLE ocp10_f_topics ADD FOREIGN KEY `f_topics.t_cache_last_member_id` (t_cache_last_member_id) REFERENCES ocp10_f_members (id);

		CREATE INDEX `f_members.m_primary_group` ON ocp10_f_members(m_primary_group);
		ALTER TABLE ocp10_f_members ADD FOREIGN KEY `f_members.m_primary_group` (m_primary_group) REFERENCES ocp10_f_groups (id);

		CREATE INDEX `f_members.m_signature` ON ocp10_f_members(m_signature);
		ALTER TABLE ocp10_f_members ADD FOREIGN KEY `f_members.m_signature` (m_signature) REFERENCES ocp10_translate (id);

		CREATE INDEX `f_members.m_pt_rules_text` ON ocp10_f_members(m_pt_rules_text);
		ALTER TABLE ocp10_f_members ADD FOREIGN KEY `f_members.m_pt_rules_text` (m_pt_rules_text) REFERENCES ocp10_translate (id);

		CREATE INDEX `f_groups.g_name` ON ocp10_f_groups(g_name);
		ALTER TABLE ocp10_f_groups ADD FOREIGN KEY `f_groups.g_name` (g_name) REFERENCES ocp10_translate (id);

		CREATE INDEX `f_groups.g_group_leader` ON ocp10_f_groups(g_group_leader);
		ALTER TABLE ocp10_f_groups ADD FOREIGN KEY `f_groups.g_group_leader` (g_group_leader) REFERENCES ocp10_f_members (id);

		CREATE INDEX `f_groups.g_title` ON ocp10_f_groups(g_title);
		ALTER TABLE ocp10_f_groups ADD FOREIGN KEY `f_groups.g_title` (g_title) REFERENCES ocp10_translate (id);

		CREATE INDEX `f_groups.g_promotion_target` ON ocp10_f_groups(g_promotion_target);
		ALTER TABLE ocp10_f_groups ADD FOREIGN KEY `f_groups.g_promotion_target` (g_promotion_target) REFERENCES ocp10_f_groups (id);

		CREATE INDEX `calendar_types.t_title` ON ocp10_calendar_types(t_title);
		ALTER TABLE ocp10_calendar_types ADD FOREIGN KEY `calendar_types.t_title` (t_title) REFERENCES ocp10_translate (id);

		CREATE INDEX `gifts.gift_from` ON ocp10_gifts(gift_from);
		ALTER TABLE ocp10_gifts ADD FOREIGN KEY `gifts.gift_from` (gift_from) REFERENCES ocp10_f_members (id);

		CREATE INDEX `gifts.gift_to` ON ocp10_gifts(gift_to);
		ALTER TABLE ocp10_gifts ADD FOREIGN KEY `gifts.gift_to` (gift_to) REFERENCES ocp10_f_members (id);

		CREATE INDEX `gifts.reason` ON ocp10_gifts(reason);
		ALTER TABLE ocp10_gifts ADD FOREIGN KEY `gifts.reason` (reason) REFERENCES ocp10_translate (id);

		CREATE INDEX `f_forums.f_description` ON ocp10_f_forums(f_description);
		ALTER TABLE ocp10_f_forums ADD FOREIGN KEY `f_forums.f_description` (f_description) REFERENCES ocp10_translate (id);

		CREATE INDEX `f_forums.f_forum_grouping_id` ON ocp10_f_forums(f_forum_grouping_id);
		ALTER TABLE ocp10_f_forums ADD FOREIGN KEY `f_forums.f_forum_grouping_id` (f_forum_grouping_id) REFERENCES ocp10_f_forum_groupings (id);

		CREATE INDEX `f_forums.f_parent_forum` ON ocp10_f_forums(f_parent_forum);
		ALTER TABLE ocp10_f_forums ADD FOREIGN KEY `f_forums.f_parent_forum` (f_parent_forum) REFERENCES ocp10_f_forums (id);

		CREATE INDEX `f_forums.f_intro_question` ON ocp10_f_forums(f_intro_question);
		ALTER TABLE ocp10_f_forums ADD FOREIGN KEY `f_forums.f_intro_question` (f_intro_question) REFERENCES ocp10_translate (id);

		CREATE INDEX `f_forums.f_cache_last_topic_id` ON ocp10_f_forums(f_cache_last_topic_id);
		ALTER TABLE ocp10_f_forums ADD FOREIGN KEY `f_forums.f_cache_last_topic_id` (f_cache_last_topic_id) REFERENCES ocp10_f_topics (id);

		CREATE INDEX `f_forums.f_cache_last_member_id` ON ocp10_f_forums(f_cache_last_member_id);
		ALTER TABLE ocp10_f_forums ADD FOREIGN KEY `f_forums.f_cache_last_member_id` (f_cache_last_member_id) REFERENCES ocp10_f_members (id);

		CREATE INDEX `f_forums.f_cache_last_forum_id` ON ocp10_f_forums(f_cache_last_forum_id);
		ALTER TABLE ocp10_f_forums ADD FOREIGN KEY `f_forums.f_cache_last_forum_id` (f_cache_last_forum_id) REFERENCES ocp10_f_forums (id);
