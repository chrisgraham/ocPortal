<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

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

require_code('crud_module');

/**
 * Module page class.
 */
class Module_cms_banners extends standard_crud_module
{
	var $lang_type='BANNER';
	var $view_entry_point='_SEARCH:banners:type=view:source=_ID';
	var $user_facing=true;
	var $permissions_require='mid';
	var $select_name='NAME';
	var $select_name_description='DESCRIPTION_BANNER_NAME';
	var $upload='image';
	var $non_integer_id=true;
	var $permission_module='banners';
	var $menu_label='BANNERS';
	var $array_key='name';
	var $title_is_multi_lang=false;

	var $do_next_type=NULL;

	/**
	 * Standard crud_module run_start.
	 *
	 * @param  ID_TEXT		The type of module execution
	 * @return tempcode		The output of the run
	 */
	function run_start($type)
	{
//		if (get_file_base()!=get_custom_file_base()) warn_exit(do_lang_tempcode('SHARED_INSTALL_PROHIBIT'));

		if ((has_privilege(get_member(),'banner_free')) && (get_option('admin_banners')=='0'))
		{
			attach_message(do_lang_tempcode('PERMISSION_BANNER_SKIP'),'inform');
		}

		$this->cat_crud_module=new Module_cms_banners_cat();

		require_code('banners');
		require_code('banners2');
		require_lang('banners');

		set_helper_panel_pic('pagepics/banners');
		set_helper_panel_tutorial('tut_banners');

		if ($type=='misc') return $this->misc();

		$this->javascript='
			document.getElementById("importancemodulus").onkeyup=function()
			{
				var _im_here=document.getElementById("im_here");
				if (_im_here)
				{
					var _im_total=document.getElementById("im_total");
					var im_here=window.parseInt(document.getElementById("importancemodulus").value);
					var im_total=window.parseInt(_im_total.className.replace("im_",""))+im_here;
					set_inner_html(_im_here,im_here);
					set_inner_html(document.getElementById("im_here_2"),im_here);
					set_inner_html(_im_total,im_total);
					set_inner_html(document.getElementById("im_total_2"),im_total);
				}
			}
		';

		if ($type=='ad')
		{
			require_javascript('javascript_ajax');
			$script=find_script('snippet');
			$this->javascript.="
				var form=document.getElementById('main_form');
				form.old_submit=form.onsubmit;
				form.onsubmit=function()
					{
						document.getElementById('submit_button').disabled=true;
						var url='".addslashes($script)."?snippet=exists_banner&name='+window.encodeURIComponent(form.elements['name'].value);
						if (!do_ajax_field_test(url))
						{
							document.getElementById('submit_button').disabled=false;
							return false;
						}
						document.getElementById('submit_button').disabled=false;
						if (typeof form.old_submit!='undefined' && form.old_submit) return form.old_submit();
						return true;
					};
			";
		}

		if ($type=='ac')
		{
			require_javascript('javascript_ajax');
			$script=find_script('snippet');
			$this->cat_crud_module->javascript="
				var form=document.getElementById('main_form');
				form.old_submit=form.onsubmit;
				form.onsubmit=function()
					{
						document.getElementById('submit_button').disabled=true;
						var url='".addslashes($script)."?snippet=exists_banner_type&name='+window.encodeURIComponent(form.elements['new_id'].value);
						if (!do_ajax_field_test(url))
						{
							document.getElementById('submit_button').disabled=false;
							return false;
						}
						document.getElementById('submit_button').disabled=false;
						if (typeof form.old_submit!='undefined' && form.old_submit) return form.old_submit();
						return true;
					};
			";
		}

		return new ocp_tempcode();
	}

	/**
	 * Standard modular entry-point finder function.
	 *
	 * @return ?array	A map of entry points (type-code=>language-code) (NULL: disabled).
	 */
	function get_entry_points()
	{
		return array_merge(array('misc'=>'MANAGE_BANNERS'),parent::get_entry_points());
	}

	/**
	 * Standard modular privilege-override finder function.
	 *
	 * @return array	A map of privileges that are overridable; privilege to 0 or 1. 0 means "not category overridable". 1 means "category overridable".
	 */
	function get_privilege_overrides()
	{
		require_lang('banners');
		return array('submit_cat_highrange_content'=>array(0,'ADD_BANNER_TYPE'),'edit_cat_highrange_content'=>array(0,'EDIT_BANNER_TYPE'),'delete_cat_highrange_content'=>array(0,'DELETE_BANNER_TYPE'),'submit_midrange_content'=>array(0,'ADD_BANNER'),'bypass_validation_midrange_content'=>array(0,'BYPASS_VALIDATION_BANNER'),'edit_own_midrange_content'=>array(0,'EDIT_OWN_BANNER'),'edit_midrange_content'=>array(0,'EDIT_BANNER'),'delete_own_midrange_content'=>array(0,'DELETE_OWN_BANNER'),'delete_midrange_content'=>array(0,'DELETE_BANNER'));
	}

	/**
	 * The do-next manager for before content management.
	 *
	 * @return tempcode		The UI
	 */
	function misc()
	{
		if (has_actual_page_access(get_member(),'admin_banners'))
		{
			$also_url=build_url(array('page'=>'admin_banners'),get_module_zone('admin_banners'));
			attach_message(do_lang_tempcode('menus:ALSO_SEE_ADMIN',escape_html($also_url->evaluate())),'inform');
		}

		require_code('templates_donext');
		return do_next_manager(get_screen_title('MANAGE_BANNERS'),comcode_lang_string('DOC_BANNERS'),
					array(
						/*	 type							  page	 params													 zone	  */
						has_privilege(get_member(),'submit_cat_highrange_content','cms_banners')?array('add_one_category',array('_SELF',array('type'=>'ac'),'_SELF'),do_lang('ADD_BANNER_TYPE')):NULL,
						has_privilege(get_member(),'edit_cat_highrange_content','cms_banners')?array('edit_one_category',array('_SELF',array('type'=>'ec'),'_SELF'),do_lang('EDIT_BANNER_TYPE')):NULL,
						has_privilege(get_member(),'submit_midrange_content','cms_banners')?array('add_one',array('_SELF',array('type'=>'ad'),'_SELF'),do_lang('ADD_BANNER')):NULL,
						has_privilege(get_member(),'edit_own_midrange_content','cms_banners')?array('edit_one',array('_SELF',array('type'=>'ed'),'_SELF'),do_lang('EDIT_BANNER')):NULL,
					),
					do_lang('MANAGE_BANNERS')
		);
	}

	/**
	 * Standard crud_module table function.
	 *
	 * @param  array			Details to go to build_url for link to the next screen.
	 * @return array			A pair: The choose table, Whether re-ordering is supported from this screen.
	 */
	function nice_get_choose_table($url_map)
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
		inform_non_canonical_parameter('sort');

		$hr=array(
			do_lang_tempcode('CODENAME'),
			do_lang_tempcode('_BANNER_TYPE'),
			do_lang_tempcode('DEPLOYMENT_AGREEMENT'),
			//do_lang_tempcode('HITS_ALLOCATED'),		Save space by not putting in
			do_lang_tempcode('IMPORTANCE_MODULUS'),
			do_lang_tempcode('EXPIRY_DATE'),
			do_lang_tempcode('ADDED'),
		);
		if (addon_installed('unvalidated')) $hr[]=do_lang_tempcode('VALIDATED');
		$hr[]=do_lang_tempcode('ACTIONS');
		$header_row=results_field_title($hr,$sortables,'sort',$sortable.' '.$sort_order);

		$fields=new ocp_tempcode();

		require_code('form_templates');
		$only_owned=has_privilege(get_member(),'edit_midrange_content','cms_banners')?NULL:get_member();
		list($rows,$max_rows)=$this->get_entry_rows(false,$current_ordering,is_null($only_owned)?NULL:array('submitter'=>$only_owned));
		foreach ($rows as $row)
		{
			$edit_link=build_url($url_map+array('id'=>$row['name']),'_SELF');

			$deployment_agreement=new ocp_tempcode();
			switch ($row['the_type'])
			{
				case 0:
					$deployment_agreement=do_lang_tempcode('BANNER_PERMANENT');
					break;
				case 1:
					$deployment_agreement=do_lang_tempcode('BANNER_CAMPAIGN');
					break;
				case 2:
					$deployment_agreement=do_lang_tempcode('BANNER_DEFAULT');
					break;
			}

			$fr=array(
				hyperlink(build_url(array('page'=>'banners','type'=>'view','source'=>$row['name']),get_module_zone('banners')),escape_html($row['name'])),
				($row['b_type']=='')?do_lang('GENERAL'):$row['b_type'],
				$deployment_agreement,
				//integer_format($row['campaign_remaining']),
				strval($row['importance_modulus']),
				is_null($row['expiry_date'])?protect_from_escaping(do_lang_tempcode('NA_EM')):make_string_tempcode(get_timezoned_date($row['expiry_date'])),
				get_timezoned_date($row['add_date']),
			);
			if (addon_installed('unvalidated')) $fr[]=($row['validated']==1)?do_lang_tempcode('YES'):do_lang_tempcode('NO');
			$fr[]=protect_from_escaping(hyperlink($edit_link,do_lang_tempcode('EDIT'),false,true,$row['name']));

			$fields->attach(results_entry($fr),true);
		}

		return array(results_table(do_lang($this->menu_label),get_param_integer('start',0),'start',get_param_integer('max',20),'max',$max_rows,$header_row,$fields,$sortables,$sortable,$sort_order),false);
	}

	/**
	 * Standard crud_module list function.
	 *
	 * @return tempcode		The selection list
	 */
	function nice_get_entries()
	{
		$only_owned=has_privilege(get_member(),'edit_midrange_content','cms_banners')?NULL:get_member();
		return nice_get_banners(NULL,$only_owned);
	}

	/**
	 * Get the tempcode for the form to add a banner, with the information passed along to it via the parameters already added in.
	 *
	 * @param  ID_TEXT			The name of the banner
	 * @param  URLPATH			The URL to the banner image
	 * @param  URLPATH			The URL to the site the banner leads to
	 * @param  SHORT_TEXT		The caption of the banner
	 * @param  LONG_TEXT			Complete HTML/PHP for the banner
	 * @param  LONG_TEXT			Any notes associated with the banner
	 * @param  integer			The banners "importance modulus"
	 * @range  1 max
	 * @param  ?integer			The number of hits the banner may have (NULL: not applicable for this banner type)
	 * @range  0 max
	 * @param  SHORT_INTEGER	The type of banner (0=permanent, 1=campaign, 2=default)
	 * @set    0 1 2
	 * @param  ?TIME				The banner expiry date (NULL: never expires)
	 * @param  ?MEMBER			The banners submitter (NULL: current member)
	 * @param  BINARY				Whether the banner has been validated
	 * @param  ID_TEXT			The banner type (can be anything, where blank means 'normal')
	 * @param  SHORT_TEXT		The title text for the banner (only used for text banners, and functions as the 'trigger text' if the banner type is shown inline)
	 * @return array				Bits
	 */
	function get_form_fields($name='',$image_url='',$site_url='',$caption='',$direct_code='',$notes='',$importancemodulus=3,$campaignremaining=50,$the_type=0,$expiry_date=NULL,$submitter=NULL,$validated=1,$b_type='',$title_text='')
	{
		inform_non_canonical_parameter('b_type');

		if ($b_type=='') $b_type=get_param('b_type','');

		list($fields,$_javascript)=get_banner_form_fields(false,$name,$image_url,$site_url,$caption,$direct_code,$notes,$importancemodulus,$campaignremaining,$the_type,$expiry_date,$submitter,$validated,$b_type,$title_text);
		$this->javascript.=$_javascript;

		// Permissions
		if (get_option('use_banner_permissions')=='1') $fields->attach($this->get_permission_fields($name,NULL,($name=='')));

		$edit_text=($name=='')?new ocp_tempcode():do_template('BANNER_PREVIEW',array('_GUID'=>'b7c58bc13ff317870b6823716fd36f0c','PREVIEW'=>show_banner($name,$title_text,comcode_to_tempcode($caption,$submitter),$direct_code,$image_url,'',$site_url,$b_type,is_null($submitter)?get_member():$submitter)));

		$hidden=new ocp_tempcode();
		handle_max_file_size($hidden,'image');

		return array($fields,$hidden,NULL,$edit_text);
	}

	/**
	 * Standard crud_module submitter getter.
	 *
	 * @param  ID_TEXT		The entry for which the submitter is sought
	 * @return array			The submitter, and the time of submission (null submission time implies no known submission time)
	 */
	function get_submitter($id)
	{
		$rows=$GLOBALS['SITE_DB']->query_select('banners',array('submitter','add_date'),array('name'=>$id),'',1);
		if (!array_key_exists(0,$rows)) return array(NULL,NULL);
		return array($rows[0]['submitter'],$rows[0]['add_date']);
	}

	/**
	 * Standard crud_module edit form filler.
	 *
	 * @param  ID_TEXT		The entry being edited
	 * @return array			Bits
	 */
	function fill_in_edit_form($id)
	{
		$rows=$GLOBALS['SITE_DB']->query_select('banners',array('*'),array('name'=>$id),'',1);
		if (!array_key_exists(0,$rows))
		{
			warn_exit(do_lang_tempcode('MISSING_RESOURCE'));
		}
		$myrow=$rows[0];

		return $this->get_form_fields($id,$myrow['img_url'],$myrow['site_url'],get_translated_text($myrow['caption']),$myrow['b_direct_code'],$myrow['notes'],$myrow['importance_modulus'],$myrow['campaign_remaining'],$myrow['the_type'],$myrow['expiry_date'],$myrow['submitter'],$myrow['validated'],$myrow['b_type'],$myrow['b_title_text']);
	}

	/**
	 * Standard crud_module add actualiser.
	 *
	 * @return array			A pair: The entry added, Description about usage
	 */
	function add_actualisation()
	{
		$name=post_param('name');
		$caption=post_param('caption');
		$direct_code=post_param('direct_code','');
		$campaignremaining=post_param_integer('campaignremaining',0);
		$siteurl=fixup_protocolless_urls(post_param('site_url',''));
		$importancemodulus=post_param_integer('importancemodulus',3);
		$notes=post_param('notes','');
		$the_type=post_param_integer('the_type',1);
		$expiry_date=get_input_date('expiry_date');
		$_submitter=post_param('submitter',strval(get_member()));
		$submitter=(!is_numeric($_submitter))?$GLOBALS['FORUM_DRIVER']->get_member_from_username($_submitter):intval($_submitter);
		$validated=post_param_integer('validated',0);
		$b_type=post_param('b_type');

		$title_text=post_param('title_text','');
		$b_type=post_param('b_type');
		$this->donext_type=$b_type;

		list($url,$title_text)=check_banner($title_text,$direct_code,$b_type);

		add_banner($name,$url,$title_text,$caption,$direct_code,$campaignremaining,$siteurl,$importancemodulus,$notes,$the_type,$expiry_date,$submitter,$validated,$b_type);

		$_banner_type_row=$GLOBALS['SITE_DB']->query_select('banner_types',array('t_image_width','t_image_height'),array('id'=>$b_type),'',1);
		if (array_key_exists(0,$_banner_type_row))
		{
			$banner_type_row=$_banner_type_row[0];
		} else
		{
			$banner_type_row=array('t_image_width'=>468,'t_image_height'=>60);
		}
		$stats_url=build_url(array('page'=>'_SELF','type'=>'view','source'=>$name),'_SELF');
		$banner_code=do_template('BANNER_SHOW_CODE',array('_GUID'=>'745d555fcca3a1320123ad3a5a04418b','TYPE'=>$b_type,'NAME'=>$name,'WIDTH'=>strval($banner_type_row['t_image_width']),'HEIGHT'=>strval($banner_type_row['t_image_height'])));
		$tpl=do_template('BANNER_ADDED_SCREEN',array('_GUID'=>'897bab3e444f0d3c909e7a95b84d4396','DO_NEXT'=>'','TEXT'=>'','TITLE'=>'','BANNER_CODE'=>$banner_code,'STATS_URL'=>$stats_url));

		if (get_option('use_banner_permissions')=='1') $this->set_permissions($name);

		return array($name,$tpl);
	}

	/**
	 * Standard crud_module edit actualiser.
	 *
	 * @param  ID_TEXT		The entry being edited
	 */
	function edit_actualisation($id)
	{
		$orig_submitter=$GLOBALS['SITE_DB']->query_select_value_if_there('banners','submitter',array('name'=>$id));
		if (is_null($orig_submitter)) warn_exit(do_lang_tempcode('MISSING_RESOURCE'));

		$b_type=post_param('b_type');

		$title_text=post_param('title_text','');
		$direct_code=post_param('direct_code','');
		$b_type=post_param('b_type');
		$this->donext_type=$b_type;

		list($url,$title_text)=check_banner($title_text,$direct_code,$b_type);

		$validated=post_param_integer('validated',0);
		$_submitter=post_param('submitter',strval(get_member()));
		$submitter=!is_numeric($_submitter)?$GLOBALS['FORUM_DRIVER']->get_member_from_username($_submitter):intval($_submitter);

		edit_banner($id,post_param('name'),$url,$title_text,post_param('caption'),$direct_code,post_param_integer('campaignremaining',0),fixup_protocolless_urls(post_param('site_url')),post_param_integer('importancemodulus'),post_param('notes',''),post_param_integer('the_type',1),get_input_date('expiry_date'),$submitter,$validated,$b_type);

		$this->new_id=post_param('name');

		if (get_option('use_banner_permissions')=='1') $this->set_permissions($id);
	}

	/**
	 * Standard crud_module delete actualiser.
	 *
	 * @param  ID_TEXT		The entry being deleted
	 */
	function delete_actualisation($id)
	{
		$b_type=post_param('b_type');
		$this->donext_type=$b_type;

		delete_banner($id);
	}

	/**
	 * The do-next manager for after banner content management (banners only).
	 *
	 * @param  tempcode		The title (output of get_screen_title)
	 * @param  tempcode		Some description to show, saying what happened
	 * @param  ?AUTO_LINK	The ID of whatever was just handled (NULL: N/A)
	 * @return tempcode		The UI
	 */
	function do_next_manager($title,$description,$id)
	{
		return $this->cat_crud_module->_do_next_manager($title,$description,$id,$this->donext_type);
	}
}

/**
 * Module page class.
 */
class Module_cms_banners_cat extends standard_crud_module
{
	var $lang_type='BANNER_TYPE';
	var $select_name='_BANNER_TYPE';
	var $select_name_description='_DESCRIPTION_BANNER_TYPE';
	var $orderer='id';
	var $array_key='id';
	var $title_is_multi_lang=false;
	var $non_integer_id=true;
	var $protect_first=1;
	var $table='banner_types';
	var $permissions_require='cat_high';
	var $menu_label='BANNERS';
	var $no_blank_ids=false;

	/**
	 * Standard crud_module table function.
	 *
	 * @param  array			Details to go to build_url for link to the next screen.
	 * @return array			A pair: The choose table, Whether re-ordering is supported from this screen.
	 */
	function nice_get_choose_table($url_map)
	{
		require_code('templates_results_table');

		$current_ordering=get_param('sort','id ASC',true);
		list($sortable,$sort_order)=array(substr($current_ordering,0,strrpos($current_ordering,' ')),substr($current_ordering,strrpos($current_ordering,' ')+1));
		$sortables=array(
			'id'=>do_lang_tempcode('CODENAME'),
			't_is_textual'=>do_lang_tempcode('BANNER_IS_TEXTUAL'),
			't_image_width'=>do_lang_tempcode('WIDTH'),
			't_image_height'=>do_lang_tempcode('HEIGHT'),
			't_max_file_size'=>do_lang_tempcode('_FILE_SIZE'),
			't_comcode_inline'=>do_lang_tempcode('COMCODE_INLINE'),
		);
		if (db_has_subqueries($GLOBALS['SITE_DB']->connection_read))
		{
			$sortables['(SELECT COUNT(*) FROM '.get_table_prefix().'banners WHERE b_type=r.id)']=do_lang_tempcode('COUNT_TOTAL');
		}
		if (((strtoupper($sort_order)!='ASC') && (strtoupper($sort_order)!='DESC')) || (!array_key_exists($sortable,$sortables)))
			log_hack_attack_and_exit('ORDERBY_HACK');
		inform_non_canonical_parameter('sort');

		$header_row=results_field_title(array(
			do_lang_tempcode('CODENAME'),
			do_lang_tempcode('BANNER_IS_TEXTUAL'),
			do_lang_tempcode('WIDTH'),
			do_lang_tempcode('HEIGHT'),
			do_lang_tempcode('_FILE_SIZE'),
			do_lang_tempcode('COMCODE_INLINE'),
			do_lang_tempcode('COUNT_TOTAL'),
			do_lang_tempcode('ACTIONS'),
		),$sortables,'sort',$sortable.' '.$sort_order);

		$fields=new ocp_tempcode();

		require_code('form_templates');
		list($rows,$max_rows)=$this->get_entry_rows(false,$current_ordering);
		foreach ($rows as $row)
		{
			$edit_link=build_url($url_map+array('id'=>$row['id']),'_SELF');

			$total=integer_format($GLOBALS['SITE_DB']->query_select_value('banners','COUNT(*)',array('b_type'=>$row['id'])));

			$fields->attach(results_entry(array(($row['id']=='')?do_lang('GENERAL'):$row['id'],($row['t_is_textual']==1)?do_lang_tempcode('YES'):do_lang_tempcode('NO'),integer_format($row['t_image_width']),integer_format($row['t_image_height']),clean_file_size($row['t_max_file_size']*1024),($row['t_comcode_inline']==1)?do_lang_tempcode('YES'):do_lang_tempcode('NO'),$total,protect_from_escaping(hyperlink($edit_link,do_lang_tempcode('EDIT'),false,true,'#'.strval($row['id']))))),true);
		}

		return array(results_table(do_lang($this->menu_label),get_param_integer('start',0),'start',get_param_integer('max',20),'max',$max_rows,$header_row,$fields,$sortables,$sortable,$sort_order),false);
	}

	/**
	 * Get tempcode for a post template adding/editing form.
	 *
	 * @param  ID_TEXT		The ID of the banner type
	 * @param  BINARY			Whether this is a textual banner
	 * @param  integer		The image width (ignored for textual banners)
	 * @param  integer		The image height (ignored for textual banners)
	 * @param  integer		The maximum file size for the banners (this is a string length for textual banners)
	 * @param  BINARY			Whether the banner will be automatically shown via Comcode hot-text (this can only happen if banners of the title are given title-text)
	 * @return array			A pair: the tempcode for the visible fields, and the tempcode for the hidden fields
	 */
	function get_form_fields($id='',$is_textual=0,$image_width=160,$image_height=600,$max_file_size=250,$comcode_inline=0)
	{
		$fields=new ocp_tempcode();
		$hidden=new ocp_tempcode();

		$fields->attach(form_input_line(do_lang_tempcode('CODENAME'),do_lang_tempcode('DESCRIPTION_CODENAME'),'new_id',$id,false));
		if ($id!='')
		{
			$hidden->attach(form_input_hidden('is_textual',strval($is_textual)));
		} else
		{
			$fields->attach(form_input_tick(do_lang_tempcode('BANNER_IS_TEXTUAL'),do_lang_tempcode('DESCRIPTION_BANNER_IS_TEXTUAL'),'is_textual',$is_textual==1));
		}
		$fields->attach(form_input_integer(do_lang_tempcode('WIDTH'),do_lang_tempcode('DESCRIPTION_BANNER_WIDTH'),'image_width',$image_width,true));
		$fields->attach(form_input_integer(do_lang_tempcode('HEIGHT'),do_lang_tempcode('DESCRIPTION_BANNER_HEIGHT'),'image_height',$image_height,true));
		$fields->attach(form_input_integer(do_lang_tempcode('_FILE_SIZE'),do_lang_tempcode('DESCRIPTION_BANNER_FILE_SIZE'),'max_file_size',$max_file_size,true));
		$fields->attach(form_input_tick(do_lang_tempcode('COMCODE_INLINE'),do_lang_tempcode('DESCRIPTION_COMCODE_INLINE'),'comcode_inline',$comcode_inline==1));

		return array($fields,$hidden);
	}

	/**
	 * Standard crud_module edit form filler.
	 *
	 * @param  ID_TEXT		The entry being edited
	 * @return array			A pair: the tempcode for the visible fields, and the tempcode for the hidden fields
	 */
	function fill_in_edit_form($id)
	{
		$m=$GLOBALS['SITE_DB']->query_select('banner_types',array('*'),array('id'=>$id),'',1);
		if (!array_key_exists(0,$m)) warn_exit(do_lang_tempcode('MISSING_RESOURCE'));
		$r=$m[0];

		list($fields,$hidden)=$this->get_form_fields($id,$r['t_is_textual'],$r['t_image_width'],$r['t_image_height'],$r['t_max_file_size'],$r['t_comcode_inline']);

		return array($fields,$hidden);
	}

	/**
	 * Standard crud_module add actualiser.
	 *
	 * @return array			A pair: The entry added, description about usage
	 */
	function add_actualisation()
	{
		$id=post_param('new_id');
		$is_textual=post_param_integer('is_textual',0);
		$image_width=post_param_integer('image_width');
		$image_height=post_param_integer('image_height');
		$max_file_size=post_param_integer('max_file_size');
		$comcode_inline=post_param_integer('comcode_inline',0);

		add_banner_type($id,$is_textual,$image_width,$image_height,$max_file_size,$comcode_inline);

		return array($id,do_lang_tempcode('ADD_BANNER_TEMPLATING'));
	}

	/**
	 * Standard crud_module edit actualiser.
	 *
	 * @param  ID_TEXT		The entry being edited
	 * @return tempcode		Description about usage
	 */
	function edit_actualisation($id)
	{
		$is_textual=post_param_integer('is_textual',0);
		$image_width=post_param_integer('image_width');
		$image_height=post_param_integer('image_height');
		$max_file_size=post_param_integer('max_file_size');
		$comcode_inline=post_param_integer('comcode_inline',0);

		edit_banner_type($id,post_param('new_id'),$is_textual,$image_width,$image_height,$max_file_size,$comcode_inline);

		$this->new_id=post_param('new_id');

		return do_lang_tempcode('ADD_BANNER_TEMPLATING');
	}

	/**
	 * Standard crud_module delete actualiser.
	 *
	 * @param  ID_TEXT		The entry being deleted
	 */
	function delete_actualisation($id)
	{
		delete_banner_type($id);
	}

	/**
	 * The do-next manager for after download content management (event types only).
	 *
	 * @param  tempcode		The title (output of get_screen_title)
	 * @param  tempcode		Some description to show, saying what happened
	 * @param  ?AUTO_LINK	The ID of whatever was just handled (NULL: N/A)
	 * @return tempcode		The UI
	 */
	function do_next_manager($title,$description,$id)
	{
		return $this->_do_next_manager($title,$description,$id,'');
	}

	/**
	 * The do-next manager for after banner content management.
	 *
	 * @param  tempcode		The title (output of get_screen_title)
	 * @param  tempcode		Some description to show, saying what happened
	 * @param  ?AUTO_LINK	The ID of whatever was just handled (NULL: N/A)
	 * @param  ID_TEXT		The type ID we were working in (NULL: N/A)
	 * @return tempcode		The UI
	 */
	function _do_next_manager($title,$description,$id,$type)
	{
		require_code('templates_donext');

		breadcrumb_set_self(do_lang_tempcode('DONE'));

		if ((is_null($id)) && (is_null($type)))
		{
			return do_next_manager($title,$description,
						NULL,
						NULL,
						/*		TYPED-ORDERED LIST OF 'LINKS'		*/
						/*	 page	 params				  zone	  */
						array('_SELF',array('type'=>'ad'),'_SELF',do_lang_tempcode('ADD_BANNER')),							// Add one
						NULL,							 // Edit this
						has_privilege(get_member(),'edit_own_lowrange_content','cms_banners')?array('_SELF',array('type'=>'ed'),'_SELF',do_lang_tempcode('EDIT_BANNER')):NULL,											// Edit one
						NULL,							// View this
						NULL,				// View archive
						NULL,	  // Add to category
						has_privilege(get_member(),'submit_cat_highrange_content','cms_banners')?array('_SELF',array('type'=>'ac'),'_SELF',do_lang_tempcode('ADD_BANNER_TYPE')):NULL,					  // Add one category
						has_privilege(get_member(),'edit_cat_highrange_content','cms_banners')?array('_SELF',array('type'=>'ec'),'_SELF',do_lang_tempcode('EDIT_BANNER_TYPE')):NULL,					  // Edit one category
						NULL,			 // Edit this category
						NULL,																						 // View this category
						NULL,
						NULL,
						NULL,
						NULL,
						NULL,
						NULL,
						do_lang_tempcode('BANNER_TYPES')
			);
		}

		return do_next_manager($title,$description,
					NULL,
					NULL,
					/*		TYPED-ORDERED LIST OF 'LINKS'		*/
					/*	 page	 params				  zone	  */
					array('_SELF',array('type'=>'ad','b_type'=>$type),'_SELF',do_lang_tempcode('ADD_BANNER')),											// Add one
					(is_null($id) || (!has_privilege(get_member(),'edit_own_lowrange_content','cms_banners')))?NULL:array('_SELF',array('type'=>'_ed','id'=>$id),'_SELF',do_lang_tempcode('EDIT_THIS_BANNER')),							 // Edit this
					has_privilege(get_member(),'edit_own_lowrange_content','cms_banners')?array('_SELF',array('type'=>'ed'),'_SELF',do_lang_tempcode('EDIT_BANNER')):NULL,											// Edit one
					((is_null($id)) || (/*Don't go direct to view if simplified do-next on as too unnatural*/get_option('simplified_donext')=='1'))?NULL:array('banners',array('type'=>'view','source'=>$id),get_module_zone('banners')),						  // View this
					array('admin_banners',array('type'=>'misc'),get_module_zone('admin_banners')),				// View archive
					NULL,																						// Add to category
					has_privilege(get_member(),'submit_cat_highrange_content','cms_banners')?array('_SELF',array('type'=>'ac'),'_SELF',do_lang_tempcode('ADD_BANNER_TYPE')):NULL,				// Add one category
					has_privilege(get_member(),'edit_cat_highrange_content','cms_banners')?array('_SELF',array('type'=>'ec'),'_SELF',do_lang_tempcode('EDIT_BANNER_TYPE')):NULL,				// Edit one category
					has_privilege(get_member(),'edit_cat_highrange_content','cms_banners')?array('_SELF',array('type'=>'_ec','id'=>$type),'_SELF'):NULL,			  // Edit this category
					NULL,																						// View this category
					NULL,
					NULL,
					NULL,
					NULL,
					NULL,
					NULL,
					do_lang_tempcode('BANNER_TYPES')
		);
	}

}


