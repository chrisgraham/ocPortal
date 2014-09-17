<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.


 NOTE TO PROGRAMMERS:
   Do not edit this file. If you need to make changes, save your changed file to the appropriate *_custom folder
   **** If you ignore this advice, then your website upgrades (e.g. for bug fixes) will likely kill your changes ****

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		banners
 */

/**
 * Module page class.
 */
class Module_banners
{
	/**
	 * Find details of the module.
	 *
	 * @return ?array	Map of module info (NULL: module is disabled).
	 */
	function info()
	{
		$info=array();
		$info['author']='Chris Graham';
		$info['organisation']='ocProducts';
		$info['hacked_by']=NULL;
		$info['hack_version']=NULL;
		$info['version']=6;
		$info['locked']=true;
		$info['update_require_upgrade']=1;
		return $info;
	}

	/**
	 * Uninstall the module.
	 */
	function uninstall()
	{
		$GLOBALS['SITE_DB']->drop_table_if_exists('banners');
		$GLOBALS['SITE_DB']->drop_table_if_exists('banner_types');
		$GLOBALS['SITE_DB']->drop_table_if_exists('banner_clicks');

		$GLOBALS['SITE_DB']->query_delete('group_category_access',array('module_the_name'=>'banners'));

		delete_privilege('full_banner_setup');
		delete_privilege('view_anyones_banner_stats');
		delete_privilege('banner_free');
		delete_privilege('use_html_banner');
		delete_privilege('use_php_banner');

		require_code('files');
		deldir_contents(get_custom_file_base().'/uploads/banners',true);
	}

	/**
	 * Install the module.
	 *
	 * @param  ?integer	What version we're upgrading from (NULL: new install)
	 * @param  ?integer	What hack version we're upgrading from (NULL: new-install/not-upgrading-from-a-hacked-version)
	 */
	function install($upgrade_from=NULL,$upgrade_from_hack=NULL)
	{
		if (is_null($upgrade_from))
		{
			$GLOBALS['SITE_DB']->create_table('banners',array(
				'name'=>'*ID_TEXT',
				'expiry_date'=>'?TIME',
				'submitter'=>'MEMBER',
				'img_url'=>'URLPATH',
				'the_type'=>'SHORT_INTEGER', // 0=permanent|1=campaign|2=default
				'b_title_text'=>'SHORT_TEXT',
				'caption'=>'SHORT_TRANS__COMCODE',
				'b_direct_code'=>'LONG_TEXT',
				'campaign_remaining'=>'INTEGER',
				'site_url'=>'URLPATH',
				'hits_from'=>'INTEGER',
				'views_from'=>'INTEGER',
				'hits_to'=>'INTEGER',
				'views_to'=>'INTEGER',
				'importance_modulus'=>'INTEGER',
				'notes'=>'LONG_TEXT',
				'validated'=>'BINARY',
				'add_date'=>'TIME',
				'edit_date'=>'?TIME',
				'b_type'=>'ID_TEXT'
			));

			$GLOBALS['SITE_DB']->create_index('banners','banner_child_find',array('b_type'));
			$GLOBALS['SITE_DB']->create_index('banners','the_type',array('the_type'));
			$GLOBALS['SITE_DB']->create_index('banners','expiry_date',array('expiry_date'));
			$GLOBALS['SITE_DB']->create_index('banners','badd_date',array('add_date'));
			$GLOBALS['SITE_DB']->create_index('banners','topsites',array('hits_from','hits_to'));
			$GLOBALS['SITE_DB']->create_index('banners','campaign_remaining',array('campaign_remaining'));
			$GLOBALS['SITE_DB']->create_index('banners','bvalidated',array('validated'));

			$map=array(
				'name'=>'advertise_here',
				'b_title_text'=>'',
				'b_direct_code'=>'',
				'the_type'=>2,
				'img_url'=>'data/images/advertise_here.png',
				'campaign_remaining'=>0,
				'site_url'=>get_base_url().'/site/index.php?page=advertise',
				'hits_from'=>0,
				'views_from'=>0,
				'hits_to'=>0,
				'views_to'=>0,
				'importance_modulus'=>10,
				'notes'=>'Provided as default. This is a default banner (it shows when others are not available).',
				'validated'=>1,
				'add_date'=>time(),
				'submitter'=>$GLOBALS['FORUM_DRIVER']->get_guest_id(),
				'b_type'=>'',
				'expiry_date'=>NULL,
				'edit_date'=>NULL,
			);
			$map+=lang_code_to_default_content('caption','ADVERTISE_HERE',true,1);
			$GLOBALS['SITE_DB']->query_insert('banners',$map);
			$banner_a='advertise_here';

			$map=array(
				'name'=>'donate',
				'b_title_text'=>'',
				'b_direct_code'=>'',
				'the_type'=>0,
				'img_url'=>'data/images/donate.png',
				'campaign_remaining'=>0,
				'site_url'=>get_base_url().'/site/index.php?page=donate',
				'hits_from'=>0,
				'views_from'=>0,
				'hits_to'=>0,
				'views_to'=>0,
				'importance_modulus'=>30,
				'notes'=>'Provided as default.',
				'validated'=>1,
				'add_date'=>time(),
				'submitter'=>$GLOBALS['FORUM_DRIVER']->get_guest_id(),
				'b_type'=>'',
				'expiry_date'=>NULL,
				'edit_date'=>NULL,
			);
			$map+=lang_code_to_default_content('caption','DONATION',true,1);
			$GLOBALS['SITE_DB']->query_insert('banners',$map);
			$banner_c='donate';

			$groups=$GLOBALS['FORUM_DRIVER']->get_usergroup_list(false,true);
			foreach (array_keys($groups) as $group_id)
			{
				$GLOBALS['SITE_DB']->query_insert('group_category_access',array('module_the_name'=>'banners','category_name'=>$banner_a,'group_id'=>$group_id));
				$GLOBALS['SITE_DB']->query_insert('group_category_access',array('module_the_name'=>'banners','category_name'=>$banner_c,'group_id'=>$group_id));
			}

			add_privilege('BANNERS','full_banner_setup',false);
			add_privilege('BANNERS','view_anyones_banner_stats',false);

			$GLOBALS['SITE_DB']->create_table('banner_types',array(
				'id'=>'*ID_TEXT',
				't_is_textual'=>'BINARY',
				't_image_width'=>'INTEGER',
				't_image_height'=>'INTEGER',
				't_max_file_size'=>'INTEGER',
				't_comcode_inline'=>'BINARY'
			));

			$GLOBALS['SITE_DB']->create_index('banner_types','hottext',array('t_comcode_inline'));

			$GLOBALS['SITE_DB']->query_insert('banner_types',array(
				'id'=>'',
				't_is_textual'=>0,
				't_image_width'=>728,
				't_image_height'=>90,
				't_max_file_size'=>80,
				't_comcode_inline'=>0
			));

			$GLOBALS['SITE_DB']->create_table('banner_clicks',array(
				'id'=>'*AUTO',
				'c_date_and_time'=>'TIME',
				'c_member_id'=>'MEMBER',
				'c_ip_address'=>'IP',
				'c_source'=>'ID_TEXT',
				'c_banner_id'=>'ID_TEXT'
			));
			$GLOBALS['SITE_DB']->create_index('banner_clicks','clicker_ip',array('c_ip_address'));

			add_privilege('BANNERS','banner_free',false);
		}

		if ((!is_null($upgrade_from)) && ($upgrade_from<6))
		{
			$GLOBALS['SITE_DB']->add_table_field('banners','b_direct_code','LONG_TEXT');
			delete_config_option('money_ad_code');
			delete_config_option('advert_chance');
			delete_config_option('is_on_banners');
		}

		if ((is_null($upgrade_from)) || ($upgrade_from<6))
		{
			add_privilege('BANNERS','use_html_banner',false);
			add_privilege('BANNERS','use_php_banner',false,true);
		}
	}

	/**
	 * Find entry-points available within this module.
	 *
	 * @param  boolean	Whether to check permissions.
	 * @param  ?MEMBER	The member to check permissions as (NULL: current user).
	 * @param  boolean	Whether to allow cross links to other modules (identifiable via a full-page-link rather than a screen-name).
	 * @param  boolean	Whether to avoid any entry-point (or even return NULL to disable the page in the Sitemap) if we know another module, or page_group, is going to link to that entry-point. Note that "!" and "misc" entry points are automatically merged with container page nodes (likely called by page-groupings) as appropriate.
	 * @return ?array		A map of entry points (screen-name=>language-code/string or screen-name=>[language-code/string, icon-theme-image]) (NULL: disabled).
	 */
	function get_entry_points($check_perms=true,$member_id=NULL,$support_crosslinks=true,$be_deferential=false)
	{
		if ($check_perms && is_guest($member_id)) return array();

		if (is_null($member_id)) $member_id=get_member();
		if (!has_zone_access($member_id,'adminzone'))
		{
			$num_banners_owned=$GLOBALS['SITE_DB']->query_select_value('banners','COUNT(*)',array('submitter'=>$member_id));
			if ($num_banners_owned==0) return NULL;
		}

		return array(
			'misc'=>array('BANNERS','menu/cms/banners'),
		);
	}

	var $title;
	var $source;
	var $myrow;

	/**
	 * Module pre-run function. Allows us to know meta-data for <head> before we start streaming output.
	 *
	 * @return ?tempcode		Tempcode indicating some kind of exceptional output (NULL: none).
	 */
	function pre_run()
	{
		$type=get_param('type','misc');

		require_lang('banners');

		if ($type=='misc')
		{
			$this->title=get_screen_title('BANNERS');
		}

		if ($type=='view')
		{
			$source=get_param('source');

			$rows=$GLOBALS['SITE_DB']->query_select('banners',array('*'),array('name'=>$source));
			if (!array_key_exists(0,$rows))
			{
				warn_exit(do_lang_tempcode('BANNER_MISSING_SOURCE'));
			}
			$myrow=$rows[0];

			set_extra_request_metadata(array(
				'created'=>date('Y-m-d',$myrow['add_date']),
				'creator'=>$GLOBALS['FORUM_DRIVER']->get_username($myrow['submitter']),
				'publisher'=>'', // blank means same as creator
				'modified'=>is_null($myrow['edit_date'])?'':date('Y-m-d',$myrow['edit_date']),
				'type'=>'Banner',
				'title'=>get_translated_text($myrow['caption']),
				'identifier'=>'_SEARCH:banners:view:'.$source,
				'description'=>'',
				'image'=>$myrow['img_url'],
				//'category'=>$type,
			));

			breadcrumb_set_parents(array(array('_SELF:_SELF:misc',do_lang_tempcode('BANNERS'))));

			$this->title=get_screen_title('BANNER_INFORMATION');

			$this->source=$source;
			$this->myrow=$myrow;
		}

		return NULL;
	}

	/**
	 * Execute the module.
	 *
	 * @return tempcode	The result of execution.
	 */
	function run()
	{
		if (!is_null($GLOBALS['CURRENT_SHARE_USER'])) warn_exit(do_lang_tempcode('SHARED_INSTALL_PROHIBIT'));

		require_code('banners');

		// Decide what we're doing
		$type=get_param('type','misc');

		if ($type=='misc') return $this->choose_banner();
		if ($type=='view') return $this->view_banner();

		return new ocp_tempcode();
	}

	/**
	 * The UI to choose a banner to view.
	 *
	 * @return tempcode		The UI
	 */
	function choose_banner()
	{
		require_code('templates_results_table');

		$current_ordering=get_param('sort','name ASC');
		if (strpos($current_ordering,' ')===false) warn_exit(do_lang_tempcode('INTERNAL_ERROR'));
		list($sortable,$sort_order)=explode(' ',$current_ordering,2);
		$sortables=array(
			'name'=>do_lang_tempcode('CODENAME'),
			'b_type'=>do_lang_tempcode('_BANNER_TYPE'),
			'the_type'=>do_lang_tempcode('DEPLOYMENT_AGREEMENT'),
			//'campaign_remaining'=>do_lang_tempcode('HITS_ALLOCATED'),
			'importance_modulus'=>do_lang_tempcode('IMPORTANCE_MODULUS'),
			'expiry_date'=>do_lang_tempcode('EXPIRY_DATE'),
			'add_date'=>do_lang_tempcode('ADDED'),
		);
		if (addon_installed('unvalidated')) $sortables['validated']=do_lang_tempcode('VALIDATED');
		if (((strtoupper($sort_order)!='ASC') && (strtoupper($sort_order)!='DESC')) || (!array_key_exists($sortable,$sortables)))
			log_hack_attack_and_exit('ORDERBY_HACK');

		$hr=array(
			do_lang_tempcode('CODENAME'),
			do_lang_tempcode('_BANNER_TYPE'),
			//do_lang_tempcode('DEPLOYMENT_AGREEMENT'),
			//do_lang_tempcode('HITS_ALLOCATED'),
			do_lang_tempcode('_IMPORTANCE_MODULUS'),
			do_lang_tempcode('EXPIRY_DATE'),
			do_lang_tempcode('ADDED'),
		);
		if (addon_installed('unvalidated')) $hr[]=do_lang_tempcode('VALIDATED');
		$hr[]=do_lang_tempcode('ACTIONS');
		$header_row=results_field_title($hr,$sortables,'sort',$sortable.' '.$sort_order);

		$fields=new ocp_tempcode();

		$url_map=array('page'=>'_SELF','type'=>'view');

		require_code('form_templates');
		$only_owned=has_privilege(get_member(),'edit_midrange_content','cms_banners')?NULL:get_member();
		$max_rows=$GLOBALS['SITE_DB']->query_select_value('banners','COUNT(*)',is_null($only_owned)?NULL:array('submitter'=>$only_owned));
		if ($max_rows==0) inform_exit(do_lang_tempcode('NO_ENTRIES'));
		$max=get_param_integer('banner_max',20);
		$start=get_param_integer('banner_start',0);
		$rows=$GLOBALS['SITE_DB']->query_select('banners',array('*'),is_null($only_owned)?NULL:array('submitter'=>$only_owned),'ORDER BY '.$current_ordering,$max,$start);
		foreach ($rows as $row)
		{
			$view_link=build_url($url_map+array('source'=>$row['name']),'_SELF');

			$deployment_agreement=new ocp_tempcode();
			switch ($row['the_type'])
			{
				case BANNER_PERMANENT:
					$deployment_agreement=do_lang_tempcode('BANNER_PERMANENT');
					break;
				case BANNER_CAMPAIGN:
					$deployment_agreement=do_lang_tempcode('BANNER_CAMPAIGN');
					break;
				case BANNER_DEFAULT:
					$deployment_agreement=do_lang_tempcode('BANNER_DEFAULT');
					break;
			}

			$fr=array(
				$row['name'],
				($row['b_type']=='')?do_lang('GENERAL'):$row['b_type'],
				//$deployment_agreement,	Too much detail
				//integer_format($row['campaign_remaining']),	Too much detail
				strval($row['importance_modulus']),
				is_null($row['expiry_date'])?protect_from_escaping(do_lang_tempcode('NA_EM')):make_string_tempcode(get_timezoned_date($row['expiry_date'])),
				get_timezoned_date($row['add_date'],false),
			);
			if (addon_installed('unvalidated')) $fr[]=($row['validated']==1)?do_lang_tempcode('YES'):do_lang_tempcode('NO');
			$fr[]=protect_from_escaping(hyperlink($view_link,do_lang_tempcode('VIEW'),false,true,$row['name']));

			$fields->attach(results_entry($fr),true);
		}

		$table=results_table(do_lang('BANNERS'),$start,'banner_start',$max,'banner_max',$max_rows,$header_row,$fields,$sortables,$sortable,$sort_order);

		$text=do_lang_tempcode('CHOOSE_VIEW_LIST');

		$tpl=do_template('COLUMNED_TABLE_SCREEN',array('_GUID'=>'be5248da379faeead5a18d9f2b62bd6b','TITLE'=>$this->title,'TEXT'=>$text,'TABLE'=>$table,'SUBMIT_ICON'=>'buttons__proceed','SUBMIT_NAME'=>NULL,'POST_URL'=>get_self_url()));

		require_code('templates_internalise_screen');
		return internalise_own_screen($tpl);
	}

	/**
	 * The UI to view a banner.
	 *
	 * @return tempcode		The UI
	 */
	function view_banner()
	{
		$source=$this->source;

		$myrow=$this->myrow;

		if ((is_guest($myrow['submitter'])) || ($myrow['submitter']!=get_member()))
			check_privilege('view_anyones_banner_stats');

		switch ($myrow['the_type'])
		{
			case BANNER_PERMANENT:
				$type=do_lang_tempcode('BANNER_PERMANENT');
				break;
			case BANNER_CAMPAIGN:
				$type=do_lang_tempcode('_BANNER_HITS_LEFT',do_lang_tempcode('BANNER_CAMPAIGN'),make_string_tempcode(integer_format($myrow['campaign_remaining'])));
				break;
			case BANNER_DEFAULT:
				$type=do_lang_tempcode('BANNER_DEFAULT');
				break;
		}

		if ($myrow['views_to']!=0)
			$click_through=protect_from_escaping(escape_html(float_format(round(100.0*($myrow['hits_to']/$myrow['views_to'])))));
		else $click_through=do_lang_tempcode('NA_EM');

		$has_banner_network=$GLOBALS['SITE_DB']->query_select_value('banners','SUM(views_from)')!=0.0;

		$fields=new ocp_tempcode();
		require_code('templates_map_table');
		$fields->attach(map_table_field(do_lang_tempcode('TYPE'),$type));
		if ($myrow['b_type']!='') $fields->attach(map_table_field(do_lang_tempcode('_BANNER_TYPE'),$myrow['b_type']));
		$expiry_date=is_null($myrow['expiry_date'])?do_lang_tempcode('NA_EM'):make_string_tempcode(escape_html(get_timezoned_date($myrow['expiry_date'],true)));
		$fields->attach(map_table_field(do_lang_tempcode('EXPIRY_DATE'),$expiry_date));
		if ($has_banner_network)
		{
			$fields->attach(map_table_field(do_lang_tempcode('BANNER_HITSFROM'),integer_format($myrow['hits_from']),false,'hits_from'));
			$fields->attach(map_table_field(do_lang_tempcode('BANNER_VIEWSFROM'),integer_format($myrow['views_from']),false,'views_from'));
		}
		$fields->attach(map_table_field(do_lang_tempcode('BANNER_HITSTO'),($myrow['site_url']=='')?do_lang_tempcode('CANT_TRACK'):protect_from_escaping(escape_html(integer_format($myrow['hits_to']))),false,'hits_to'));
		$fields->attach(map_table_field(do_lang_tempcode('BANNER_VIEWSTO'),($myrow['site_url']=='')?do_lang_tempcode('CANT_TRACK'):protect_from_escaping(escape_html(integer_format($myrow['views_to']))),false,'views_to'));
		$fields->attach(map_table_field(do_lang_tempcode('BANNER_CLICKTHROUGH'),$click_through));
		$username=$GLOBALS['FORUM_DRIVER']->member_profile_hyperlink($myrow['submitter']);
		$fields->attach(map_table_field(do_lang_tempcode('SUBMITTER'),$username,true));

		$map_table=do_template('MAP_TABLE',array('_GUID'=>'eb97a46d8e9813da7081991d5beed270','WIDTH'=>'300','FIELDS'=>$fields));

		$banner=show_banner($myrow['name'],$myrow['b_title_text'],get_translated_tempcode('banners',$myrow,'caption'),$myrow['b_direct_code'],$myrow['img_url'],$source,$myrow['site_url'],$myrow['b_type'],$myrow['submitter']);

		$edit_url=new ocp_tempcode();
		if ((has_actual_page_access(NULL,'cms_banners',NULL,NULL)) && (has_edit_permission('mid',get_member(),$myrow['submitter'],'cms_banners')))
		{
			$edit_url=build_url(array('page'=>'cms_banners','type'=>'_ed','id'=>$source),get_module_zone('cms_banners'));
		}

		return do_template('BANNER_VIEW_SCREEN',array(
			'_GUID'=>'ed923ae0682c6ed679c0efda688c49ea',
			'TITLE'=>$this->title,
			'EDIT_URL'=>$edit_url,
			'MAP_TABLE'=>$map_table,
			'BANNER'=>$banner,
			'NAME'=>$source,
		));
	}
}


