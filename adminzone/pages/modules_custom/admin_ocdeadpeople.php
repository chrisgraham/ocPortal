<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		core_ocf
 */

require_code('aed_module');

/**
 * Module page class.
 */
class Module_admin_ocdeadpeople extends standard_aed_module
{
	var $lang_type='DISEASE';
	var $select_name='NAME';
	var $award_type='group';
	var $possibly_some_kind_of_upload=true;
	var $output_of_action_is_confirmation=true;
	var $menu_label='OCDEADPEOPLE_TITLE';
	var $do_preview=NULL;
	var $view_entry_point='_SEARCH:admin_ocdeadpeople:view:id=_ID';

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
		$info['version']=3;
		$info['update_require_upgrade']=1;
		$info['locked']=false;
		return $info;
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
			$GLOBALS['SITE_DB']->create_table('diseases',array(
				'id'=>'*AUTO',
				'name'=>'SHORT_TEXT',
				'image'=>'URLPATH',
				'cure'=>'SHORT_TEXT',
				'cure_price'=>'INTEGER',
				'immunisation'=>'SHORT_TEXT',
				'immunisation_price'=>'INTEGER',
				'spread_rate'=>'INTEGER',
				'points_per_spread'=>'INTEGER',
				'last_spread_time'=>'INTEGER',
				'enabled'=>'BINARY'
			));

			$GLOBALS['SITE_DB']->create_table('members_diseases',array(
				'user_id'=>'*USER',
				'disease_id'=>'*AUTO_LINK',
				'sick'=>'BINARY',
				'cure'=>'BINARY',
				'immunisation'=>'BINARY',
			));

			$GLOBALS['SITE_DB']->query_insert('diseases',array('name'=>'Zombiism','image'=>'uploads/diseases_addon/hazard.jpg','cure'=>'Zombiism vaccine','cure_price'=>100,'immunisation'=>'Immunise yourself from Zombiism','immunisation_price'=>50,'spread_rate'=>12,'points_per_spread'=>10,'last_spread_time'=>0,'enabled'=>1),true);
			$GLOBALS['SITE_DB']->query_insert('diseases',array('name'=>'A bad case of Hiccups','image'=>'uploads/diseases_addon/hazard.jpg','cure'=>'Hiccup vaccine','cure_price'=>100,'immunisation'=>'Immunise yourself from the Hiccups','immunisation_price'=>50,'spread_rate'=>12,'points_per_spread'=>10,'last_spread_time'=>0,'enabled'=>1),true);
			$GLOBALS['SITE_DB']->query_insert('diseases',array('name'=>'Vampirism','image'=>'uploads/diseases_addon/hazard.jpg','cure'=>'Vampirism vaccine','cure_price'=>100,'immunisation'=>'Immunise yourself against Vampirism','immunisation_price'=>50,'spread_rate'=>12,'points_per_spread'=>10,'last_spread_time'=>0,'enabled'=>1),true);
			$GLOBALS['SITE_DB']->query_insert('diseases',array('name'=>'The Flu','image'=>'uploads/diseases_addon/hazard.jpg','cure'=>'Flu vaccine','cure_price'=>100,'immunisation'=>'Immunise yourself against the Flu','immunisation_price'=>50,'spread_rate'=>12,'points_per_spread'=>10,'last_spread_time'=>0,'enabled'=>1),true);
			$GLOBALS['SITE_DB']->query_insert('diseases',array('name'=>'Lice','image'=>'uploads/diseases_addon/hazard.jpg','cure'=>'Lice-Away Spray','cure_price'=>100,'immunisation'=>'Lice repellant','immunisation_price'=>50,'spread_rate'=>12,'points_per_spread'=>10,'last_spread_time'=>0,'enabled'=>1),true);
			$GLOBALS['SITE_DB']->query_insert('diseases',array('name'=>'Fleas','image'=>'uploads/diseases_addon/hazard.jpg','cure'=>'Flea spray','cure_price'=>100,'immunisation'=>'Flea repellant','immunisation_price'=>50,'spread_rate'=>12,'points_per_spread'=>10,'last_spread_time'=>0,'enabled'=>1),true);
			$GLOBALS['SITE_DB']->query_insert('diseases',array('name'=>'Man-Flu','image'=>'uploads/diseases_addon/hazard.jpg','cure'=>'Lots and lots of TLC','cure_price'=>1000,'immunisation'=>'Anti Man-Flu Serum','immunisation_price'=>250,'spread_rate'=>12,'points_per_spread'=>100,'last_spread_time'=>0,'enabled'=>1),true);
		}

		if ((!is_null($upgrade_from)) && ($upgrade_from<3))
		{
			$GLOBALS['SITE_DB']->alter_table_field('members_diseases','desease_id','AUTO_LINK','disease_id');
		}
	}

	/**
	 * Standard modular uninstall function.
	 *
	 */
	function uninstall()
	{
		$GLOBALS['SITE_DB']->drop_if_exists('diseases');
		$GLOBALS['SITE_DB']->drop_if_exists('members_diseases');

		//deldir_contents(get_custom_file_base().'/uploads/diseases_addon',true);
	}

	/**
	 * Standard modular entry-point finder function.
	 *
	 * @return ?array	A map of entry points (type-code=>language-code) (NULL: disabled).
	 */
	function get_entry_points()
	{
		return array_merge(array('misc'=>'MANAGE_DISEASES'),parent::get_entry_points());
	}

	/**
	 * Standard aed_module run_start.
	 *
	 * @param  ID_TEXT		The type of module execution
	 * @return tempcode		The output of the run
	 */
	function run_start($type)
	{
		$GLOBALS['HELPER_PANEL_TUTORIAL']='tut_subcom';

		if (get_forum_type()!='ocf') warn_exit(do_lang_tempcode('NO_OCF')); else ocf_require_all_forum_stuff();
		require_code('ocf_groups_action');
		require_code('ocf_forums_action');
		require_code('ocf_groups_action2');
		require_code('ocf_forums_action2');

		if ($type=='misc') return $this->misc();
		if ($type=='view') return $this->view();
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
		require_lang('ocdeadpeople');
		return do_next_manager(get_screen_title('OCDEADPEOPLE_TITLE'),comcode_lang_string('DOC_OCDEADPEOPLE'),
					array(
						/*	 type							  page	 params													 zone	  */
						array('add_one',array('_SELF',array('type'=>'ad'),'_SELF'),do_lang('ADD_DISEASE')),
						array('edit_one',array('_SELF',array('type'=>'ed'),'_SELF'),do_lang('EDIT_DISEASE')),
					),
					do_lang('OCDEADPEOPLE_TITLE')
		);
	}

	function view()
	{
		$id=NULL;
		$name='';
		$image='';
		$cure='';
		$cure_price=0;
		$immunization='';
		$immunization_price=0;
		$spread_rate=0;
		$points_per_spread=10;
		$enabled=do_lang_tempcode('DISEASE_DISABLED');

		$id=get_param_integer('id',0);
		if($id>0)
		{
			$rows=$GLOBALS['SITE_DB']->query_select('diseases',array('*'),array('id'=>$id));

			if(isset($rows[0]['id']) && $rows[0]['id']>0)
			{
				$id=$rows[0]['id'];
				$name=$rows[0]['name'];
				$image=$rows[0]['image'];
				$cure=$rows[0]['cure'];
				$cure_price=$rows[0]['cure_price'];
				$immunization=$rows[0]['immunisation'];
				$immunization_price=$rows[0]['immunisation_price'];
				$spread_rate=$rows[0]['spread_rate'];
				$points_per_spread=$rows[0]['points_per_spread'];
				$enabled=($rows[0]['enabled']==1)?do_lang_tempcode('DISEASE_ENABLED'):do_lang_tempcode('DISEASE_DISABLED');
			}
		}

		breadcrumb_set_parents(array(array('_SELF:_SELF:misc',do_lang_tempcode('OCDEADPEOPLE_TITLE'))));
		breadcrumb_set_self(do_lang_tempcode('VIEW_DISEASE'));

		require_code('templates_map_table');
		return map_table(get_screen_title('VIEW_DISEASE'),array('NAME'=>$name,'IMAGE'=>$image,'CURE'=>$cure,'CURE_PRICE'=>integer_format($cure_price),'IMMUNIZATION'=>$immunization,'IMMUNIZATION_PRICE'=>integer_format($immunization_price),'SPREAD_RATE'=>integer_format($spread_rate),'POINTS_PER_SPREAD'=>integer_format($points_per_spread),'ENABLED'=>$enabled));

	}

	function get_form_fields($id=NULL,$name='',$image='',$cure='',$cure_price=10,$immunization='',$immunization_price=5,$spread_rate=12,$points_per_spread=10,$enabled=0)
	{
		$fields=new ocp_tempcode();
		$hidden=new ocp_tempcode();

		require_code('form_templates');

		$fields->attach(form_input_line(do_lang_tempcode('DISEASE'),do_lang_tempcode('DESCRIPTION_DISEASE'),'name',$name,true));

		$set_name='image';
		$required=true;
		$set_title=do_lang_tempcode('IMAGE');
		$field_set=alternate_fields_set__start($set_name);

		$field_set->attach(form_input_upload(do_lang_tempcode('UPLOAD'),'','image',false,NULL,NULL,true,str_replace(' ','',get_option('valid_images'))));

		$field_set->attach(form_input_line(do_lang_tempcode('URL'),'','url',$image,false));

		$fields->attach(alternate_fields_set__end($set_name,$set_title,'',$field_set,$required));

		handle_max_file_size($hidden,'image');

		$fields->attach(form_input_line(do_lang_tempcode('CURE'),do_lang_tempcode('DESCRIPTION_CURE'),'cure',$cure,true));

		$fields->attach(form_input_line(do_lang_tempcode('CURE_PRICE'),'','cure_price',strval($cure_price),true));

		$fields->attach(form_input_line(do_lang_tempcode('IMMUNIZATION'),do_lang_tempcode('DESCRIPTION_IMMUNIZATION'),'immunization',$immunization,true));

		$fields->attach(form_input_line(do_lang_tempcode('IMMUNIZATION_PRICE'),'','immunization_price',strval($immunization_price),true));

		$fields->attach(form_input_line(do_lang_tempcode('SPREAD_RATE'),do_lang_tempcode('DESCRIPTION_SPREAD_RATE'),'spread_rate',strval($spread_rate),true));

		$fields->attach(form_input_line(do_lang_tempcode('POINTS_PER_SPREAD'),do_lang_tempcode('DESCRIPTION_POINTS_PER_SPREAD'),'points_per_spread',strval($points_per_spread),true));

		$fields->attach(form_input_tick(do_lang_tempcode('DISEASE_ENABLED'),do_lang_tempcode('DESCRIPTION_DISEASE_ENABLED'),'enabled',$enabled==1));

		return array($fields,$hidden);
	}

	/**
	 * Standard aed_module list function.
	 *
	 * @return tempcode		The selection list
	 */
	function nice_get_entries()
	{
		$fields=new ocp_tempcode();

		$rows=$GLOBALS['SITE_DB']->query_select('diseases',array('*'),NULL);

		foreach ($rows as $row)
		{

			$fields->attach(form_input_list_entry(strval($row['id']),false,$row['name']));
		}

		return $fields;
	}

	/**
	 * Standard aed_module edit form filler.
	 *
	 * @param  ID_TEXT		The entry being edited
	 * @return array			A pair: The input fields, Hidden fields
	 */
	function fill_in_edit_form($id)
	{
		$rows=$GLOBALS['SITE_DB']->query_select('diseases',array('*'),array('id'=>intval($id)));
		if (!array_key_exists(0,$rows))
		{
			warn_exit(do_lang_tempcode('MISSING_RESOURCE'));
		}
		$myrow=$rows[0];

		$name=$myrow['name'];
		$image=$myrow['image'];
		$cure=$myrow['cure'];
		$cure_price=$myrow['cure_price'];
		$immunization=$myrow['immunisation'];
		$immunization_price=$myrow['immunisation_price'];
		$spread_rate=$myrow['spread_rate'];
		$points_per_spread=$myrow['points_per_spread'];
		$enabled=$myrow['enabled'];

		$ret=$this->get_form_fields($id,$name,$image,$cure,$cure_price,$immunization,$immunization_price,$spread_rate,$points_per_spread,$enabled);

		return $ret;
	}

	/**
	 * Standard aed_module add actualiser.
	 *
	 * @return ID_TEXT		The entry added
	 */
	function add_actualisation()
	{
		$name=post_param('name','');
		$cure=post_param('cure','');
		$cure_price=post_param_integer('cure_price',0);
		$immunization=post_param('immunization','');
		$immunization_price=post_param_integer('immunization_price',0);
		$spread_rate=post_param_integer('spread_rate',12);
		$points_per_spread=post_param_integer('points_per_spread',10);
		$enabled=post_param_integer('enabled',0);

		require_code('uploads');
		$urls=get_url('url','image','uploads/diseases_addon',0,OCP_UPLOAD_IMAGE,false,'','');
		if ($urls[0]=='')
		{
			warn_exit(do_lang_tempcode('IMPROPERLY_FILLED_IN_UPLOAD'));
		}

		if ((substr($urls[0],0,8)!='uploads/') && (is_null(http_download_file($urls[0],0,false))) && (!is_null($GLOBALS['HTTP_MESSAGE_B'])))
			attach_message($GLOBALS['HTTP_MESSAGE_B'],'warn');

		$url=$urls[0];

		$id=$GLOBALS['SITE_DB']->query_insert('diseases',array(
			'name'=>$name,
			'image'=>$url,
			'cure'=>$cure,
			'cure_price'=>$cure_price,
			'immunisation'=>$immunization,
			'immunisation_price'=>$immunization_price,
			'spread_rate'=>$spread_rate,
			'points_per_spread'=>$points_per_spread,
			'last_spread_time'=>0,
			'enabled'=>$enabled,
		),true);

		return strval($id);
	}

	/**
	 * Standard aed_module edit actualiser.
	 *
	 * @param  ID_TEXT		The entry being edited
	 * @return ?tempcode		Confirm message (NULL: continue)
	 */
	function edit_actualisation($id)
	{
		$id=intval($id);
		$name=post_param('name','');
		$cure=post_param('cure','');
		$cure_price=post_param_integer('cure_price',0);
		$immunization=post_param('immunization','');
		$immunization_price=post_param_integer('immunization_price',0);
		$spread_rate=post_param_integer('spread_rate',12);
		$points_per_spread=post_param_integer('points_per_spread',10);
		$enabled=post_param_integer('enabled',0);

		require_code('uploads');
		$urls=get_url('url','image','uploads/diseases_addon',0,OCP_UPLOAD_IMAGE,false,'','');
		if ($urls[0]=='')
		{
			warn_exit(do_lang_tempcode('IMPROPERLY_FILLED_IN_UPLOAD'));
		}

		if ((substr($urls[0],0,8)!='uploads/') && (is_null(http_download_file($urls[0],0,false))) && (!is_null($GLOBALS['HTTP_MESSAGE_B'])))
			attach_message($GLOBALS['HTTP_MESSAGE_B'],'warn');

		$url=$urls[0];

		$GLOBALS['SITE_DB']->query_update('diseases',array('name'=>$name,'image'=>$url,'cure'=>$cure,'cure_price'=>$cure_price,'immunisation'=>$immunization,'immunisation_price'=>$immunization_price,'spread_rate'=>$spread_rate,'points_per_spread'=>$points_per_spread,'enabled'=>$enabled),array('id'=>$id),'',1);

		return NULL;
	}

	/**
	 * Standard aed_module delete actualiser.
	 *
	 * @param  ID_TEXT		The entry being deleted
	 */
	function delete_actualisation($id)
	{
		$id=intval($id);
		$GLOBALS['SITE_DB']->query_delete('diseases',array('id'=>$id),'',1);
	}
}


