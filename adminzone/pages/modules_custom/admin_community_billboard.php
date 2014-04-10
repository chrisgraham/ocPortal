<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		community_billboard
 */

require_code('crud_module');

/**
 * Module page class.
 */
class Module_admin_community_billboard extends standard_crud_module
{
	var $lang_type='COMMUNITY_BILLBOARD';
	var $special_edit_frontend=true;
	var $redirect_type='ed';
	var $menu_label='COMMUNITY_BILLBOARD';
	var $select_name='MESSAGE';
	var $table='community_billboard';
	var $orderer='the_message';
	var $title_is_multi_lang=true;

	/**
	 * Standard modular info function.
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
		$info['update_require_upgrade']=1;
		$info['version']=4;
		$info['locked']=false;
		return $info;
	}

	/**
	 * Standard modular uninstall function.
	 */
	function uninstall()
	{
		$GLOBALS['SITE_DB']->drop_table_if_exists('community_billboard');
	}

	/**
	 * Standard modular install function.
	 *
	 * @param  ?integer	What version we're upgrading from (NULL: new install)
	 * @param  ?integer	What hack version we're upgrading from (NULL: new-install/not-upgrading-from-a-hacked-version)
	 */
	function install($upgrade_from=NULL,$upgrade_from_hack=NULL)
	{
		if (is_null($upgrade_from))
		{
			$GLOBALS['SITE_DB']->create_table('community_billboard',array(
				'id'=>'*AUTO',
				'member_id'=>'MEMBER',
				'the_message'=>'SHORT_TRANS',	// Comcode
				'days'=>'INTEGER',
				'order_time'=>'TIME',
				'activation_time'=>'?TIME',
				'active_now'=>'BINARY',
				'notes'=>'LONG_TEXT'
			));

			$GLOBALS['SITE_DB']->create_index('community_billboard','find_active_billboard_msg',array('active_now'));
		}

		if ((!is_null($upgrade_from)) && ($upgrade_from<4))
		{
			rename_config_option('system_flagrant','system_community_billboard');

			$GLOBALS['SITE_DB']->rename_table('text','community_billboard');

			$GLOBALS['SITE_DB']->alter_table_field('community_billboard','user_id','MEMBER','member_id');
		}
	}

	var $title;

	/**
	 * Standard modular pre-run function, so we know meta-data for <head> before we start streaming output.
	 *
	 * @param  boolean		Whether this is running at the top level, prior to having sub-objects called.
	 * @param  ?ID_TEXT		The screen type to consider for meta-data purposes (NULL: read from environment).
	 * @return ?tempcode		Tempcode indicating some kind of exceptional output (NULL: none).
	 */
	function pre_run($top_level=true,$type=NULL)
	{
		$type=get_param('type','misc');

		require_lang('community_billboard');

		set_helper_panel_tutorial('tut_points');

		return parent::pre_run($top_level);
	}

	/**
	 * Standard crud_module run_start.
	 *
	 * @param  ID_TEXT		The type of module execution
	 * @return tempcode		The output of the run
	 */
	function run_start($type)
	{
		require_code('community_billboard');

		$this->add_one_label=do_lang_tempcode('ADD_COMMUNITY_BILLBOARD');
		$this->edit_this_label=do_lang_tempcode('EDIT_THIS_COMMUNITY_BILLBOARD');
		$this->edit_one_label=do_lang_tempcode('EDIT_COMMUNITY_BILLBOARD');

		if ($type=='misc') return $this->misc();

		return new ocp_tempcode();
	}

	/**
	 * The do-next manager for before content management.
	 *
	 * @return tempcode		The UI
	 */
	function misc()
	{
		require_code('templates_donext');
		return do_next_manager(get_screen_title('COMMUNITY_BILLBOARD'),comcode_lang_string('DOC_COMMUNITY_BILLBOARD'),
			array(
				array('menu/_generic_admin/add_one',array('_SELF',array('type'=>'ad'),'_SELF'),do_lang('ADD_COMMUNITY_BILLBOARD')),
				array('menu/_generic_admin/edit_one',array('_SELF',array('type'=>'ed'),'_SELF'),do_lang('EDIT_COMMUNITY_BILLBOARD')),
			),
			do_lang('COMMUNITY_BILLBOARD')
		);
	}

	/**
	 * Standard modular entry-point finder function.
	 *
	 * @param  boolean	Whether to check permissions.
	 * @param  ?MEMBER	The member to check permissions as (NULL: current user).
	 * @param  boolean	Whether to allow cross links to other modules (identifiable via a full-page-link rather than a screen-name).
	 * @param  boolean	Whether to avoid any entry-point (or even return NULL to disable the page in the Sitemap) if we know another module, or page_group, is going to link to that entry-point. Note that "!" and "misc" entry points are automatically merged with container page nodes (likely called by page-groupings) as appropriate.
	 * @return ?array		A map of entry points (screen-name=>language-code/string or screen-name=>[language-code/string, icon-theme-image]) (NULL: disabled).
	 */
	function get_entry_points($check_perms=true,$member_id=NULL,$support_crosslinks=true,$be_deferential=false)
	{
		return array(
			'misc'=>array('COMMUNITY_BILLBOARD_MANAGE','menu/adminzone/audit/community_billboard'),
		);
	}

	/**
	 * Standard crud_module table function.
	 *
	 * @param  array			Details to go to build_url for link to the next screen.
	 * @return array			A pair: The choose table, Whether re-ordering is supported from this screen.
	 */
	function create_selection_list_choose_table($url_map)
	{
		require_code('templates_results_table');

		$current_ordering=get_param('sort','the_message ASC');
		if (strpos($current_ordering,' ')===false) warn_exit(do_lang_tempcode('INTERNAL_ERROR'));
		list($sortable,$sort_order)=explode(' ',$current_ordering,2);
		$sortables=array(
			'the_message'=>do_lang_tempcode('MESSAGE'),
			'days'=>do_lang_tempcode('NUMBER_DAYS'),
			'order_time'=>do_lang_tempcode('ORDER_DATE'),
			'member_id'=>do_lang_tempcode('OWNER'),
		);
		if (((strtoupper($sort_order)!='ASC') && (strtoupper($sort_order)!='DESC')) || (!array_key_exists($sortable,$sortables)))
			log_hack_attack_and_exit('ORDERBY_HACK');

		$header_row=results_field_title(array(
			do_lang_tempcode('MESSAGE'),
			do_lang_tempcode('NUMBER_DAYS'),
			do_lang_tempcode('ORDER_DATE'),
			do_lang_tempcode('_UP_FOR'),
			do_lang_tempcode('OWNER'),
			do_lang_tempcode('ACTIONS'),
		),$sortables,'sort',$sortable.' '.$sort_order);

		$fields=new ocp_tempcode();

		require_code('form_templates');
		list($rows,$max_rows)=$this->get_entry_rows(false,$current_ordering);
		foreach ($rows as $row)
		{
			$edit_link=build_url($url_map+array('id'=>$row['id']),'_SELF');

			$username=protect_from_escaping($GLOBALS['FORUM_DRIVER']->member_profile_hyperlink($row['member_id']));

			$activation_time=$row['activation_time'];
			$days=is_null($activation_time)?'':float_format(round((time()-$activation_time)/60/60/24,3));

			$fields->attach(results_entry(array(protect_from_escaping(get_translated_tempcode($row['the_message'])),integer_format($row['days']),get_timezoned_date($row['order_time']),($row['active_now']==1)?$days:do_lang_tempcode('NA_EM'),$username,protect_from_escaping(hyperlink($edit_link,do_lang_tempcode('EDIT'),false,true,do_lang('EDIT').' #'.strval($row['id']))))),true);
		}

		return array(results_table(do_lang($this->menu_label),either_param_integer('start',0),'start',either_param_integer('max',20),'max',$max_rows,$header_row,$fields,$sortables,$sortable,$sort_order),false);
	}

	/**
	 * Get tempcode for a community billboard message adding/editing form.
	 *
	 * @param  SHORT_TEXT	The message
	 * @param  integer		The number of days to display for
	 * @param  LONG_TEXT		Notes
	 * @param  BINARY			Whether the message is for immediate use
	 * @return array			A pair: The input fields, Hidden fields
	 */
	function get_form_fields($message='',$days=1,$notes='',$validated=0)
	{
		$fields=new ocp_tempcode();
		require_code('form_templates');
		$fields->attach(form_input_line_comcode(do_lang_tempcode('MESSAGE'),do_lang_tempcode('DESCRIPTION_MESSAGE'),'message',$message,true));
		$fields->attach(form_input_integer(do_lang_tempcode('NUMBER_DAYS'),do_lang_tempcode('NUMBER_DAYS_DESCRIPTION'),'days',$days,true));
		if (get_option('enable_staff_notes')=='1')
			$fields->attach(form_input_text(do_lang_tempcode('NOTES'),do_lang_tempcode('DESCRIPTION_NOTES'),'notes',$notes,false));
		$fields->attach(form_input_tick(do_lang_tempcode('IMMEDIATE_USE'),do_lang_tempcode('DESCRIPTION_IMMEDIATE_USE'),'validated',$validated==1));

		return array($fields,new ocp_tempcode());
	}

	/**
	 * Standard crud_module edit form filler.
	 *
	 * @param  ID_TEXT		The entry being edited
	 * @return array			A quartet: fields, hidden, delete-fields, text
	 */
	function fill_in_edit_form($id)
	{
		$rows=$GLOBALS['SITE_DB']->query_select('community_billboard',array('*'),array('id'=>intval($id)));
		if (!array_key_exists(0,$rows))
		{
			warn_exit(do_lang_tempcode('MISSING_RESOURCE'));
		}
		$myrow=$rows[0];
		$date=get_timezoned_date($myrow['order_time']);
		$date_raw=$myrow['order_time'];
		list($fields,$hidden)=$this->get_form_fields(get_translated_text($myrow['the_message']),$myrow['days'],$myrow['notes'],$myrow['active_now']);

		$username=$GLOBALS['FORUM_DRIVER']->member_profile_hyperlink($myrow['member_id']);

		$text=do_template('COMMUNITY_BILLBOARD_DETAILS',array('_GUID'=>'dcc7a8b027d450a3c17c79b23b39cd87','USERNAME'=>$username,'DAYS_ORDERED'=>integer_format($myrow['days']),'DATE_RAW'=>strval($date_raw),'DATE'=>$date));

		return array($fields,$hidden,new ocp_tempcode(),$text);
	}

	/**
	 * Get posted access map.
	 *
	 * @return array			A map of access permissions
	 */
	function get_permissions()
	{
		$groups=$GLOBALS['FORUM_DRIVER']->get_usergroup_list(false,true);
		$output=array();
		foreach (array_keys($groups) as $group_id)
		{
			$value=post_param_integer('access_'.$group_id,0);
			$output[$group_id]=$value;
		}

		return $output;
	}

	/**
	 * Standard crud_module add actualiser.
	 *
	 * @return ID_TEXT		The entry added
	 */
	function add_actualisation()
	{
		$message=post_param('message');
		$notes=post_param('notes','');
		$validated=post_param_integer('validated',0);

		return strval(add_community_billboard_message($message,post_param_integer('days'),$notes,$validated));
	}

	/**
	 * Standard crud_module edit actualiser.
	 *
	 * @param  ID_TEXT		The entry being edited
	 */
	function edit_actualisation($id)
	{
		$message=post_param('message');
		$notes=post_param('notes','');
		$validated=post_param_integer('validated',0);
		edit_community_billboard_message(intval($id),$message,$notes,$validated);
	}

	/**
	 * Standard crud_module delete actualiser.
	 *
	 * @param  ID_TEXT		The entry being deleted
	 */
	function delete_actualisation($id)
	{
		delete_community_billboard_message(intval($id));
	}
}


