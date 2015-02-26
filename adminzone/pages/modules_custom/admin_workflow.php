<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		core
 */

require_code('aed_module');

class Module_admin_workflow extends standard_aed_module
{
	var $lang_type='WORKFLOW';
	var $select_name='NAME';
	var $javascript='';
	var $award_type=NULL;
	var $possibly_some_kind_of_upload=false;
	var $output_of_action_is_confirmation=true;
	var $do_preview=NULL;
	var $archive_entry_point=NULL;
	var $archive_label=NULL;
	var $view_entry_point=NULL;
	var $menu_label='WORKFLOW';
	var $appended_actions_already=true;

	/**
	 * Standard modular info function.
	 *
	 * @return ?array	Map of module info (NULL: module is disabled).
	 */
	function info()
	{
		$info=array();
		$info['author']='Chris Warburton';
		$info['organisation']='ocProducts';
		$info['hacked_by']=NULL;
		$info['hack_version']=NULL;
		$info['update_require_upgrade']=0;
		$info['version']=1;
		$info['locked']=false;
		return $info;
	}

	/**
	 * Standard modular uninstall function.
	 */
	function uninstall()
	{
		require_lang('workflows');
		// Remove database tables
		$GLOBALS['SITE_DB']->drop_if_exists('workflow_permissions');
		$GLOBALS['SITE_DB']->drop_if_exists('workflow_requirements');
		$GLOBALS['SITE_DB']->drop_if_exists('workflow_content');
		$GLOBALS['SITE_DB']->drop_if_exists('workflow_content_status');
	}

	/**
	 * Standard modular install function.
	 *
	 * @param  ?integer	What version we're upgrading from (NULL: new install)
	 * @param  ?integer	What hack version we're upgrading from (NULL: new-install/not-upgrading-from-a-hacked-version)
	 */
	function install($upgrade_from=NULL,$upgrade_from_hack=NULL)
	{
		// Create required database structures
		require_lang('workflows');

		// The workflow_permissions table stores which usergroups are
		// allowed to approve which points
		$GLOBALS['SITE_DB']->create_table('workflow_permissions',array(
			'id'=>'*AUTO',		// ID for reference
			'workflow_approval_name'=>'SHORT_TRANS',		// The name (and ID) of this approval point
			'usergroup'=>'GROUP',		// The usergroup to give permission to
			'validated'=>'BINARY'		// Whether this permission has been approved
		));

		// The workflow_requirements table records which workflows require which points to approve
		$GLOBALS['SITE_DB']->create_table('workflow_requirements',array(
			'id'=>'*AUTO',		// ID for reference
			'workflow_name'=>'SHORT_TRANS',		// The name (and ID) of this workflow
			'workflow_approval_name'=>'SHORT_TRANS',		// The name (and ID) of the approval point to require in this workflow
			'the_position'=>'INTEGER',		// The position of this requirement in the workflow (ie. any approval can be given at any time, but encourage users into a prespecified order)
			'is_default'=>'BINARY'		// Keep default workflow information here, since the system config makes it difficult to display a list of strings whilst returning associated ID ints. NOTE: For the default workflow, set this to 1 for ALL of its requirements
		));

		// The workflow_content table records which site resources are in
		// which workflows, along with any notes made during the approval
		// process
		$GLOBALS['SITE_DB']->create_table('workflow_content',array(
			'id'=>'*AUTO',		// ID for reference
			'source_type'=>'SHORT_TEXT',		// The content-meta-aware type we'd find this content in
			'source_id'=>'SHORT_TEXT',		// The ID of the source, wherever it happens to be
			'workflow_name'=>'SHORT_TRANS',		// The name (and ID) of the workflow this content is in
			'notes'=>'LONG_TEXT',		// No point translating the notes, since they're transient
			'original_submitter'=>'USER'		// Save this here since there's no standard way to discover it later (eg. through content-meta-aware hooks)
		));

		// The workflow_content_status table records the status of each
		// approval point for a piece of content and the member who
		// approved the point (if any)
		$GLOBALS['SITE_DB']->create_table('workflow_content_status',array(
			'id'=>'*AUTO',		// ID for reference. Larger IDs will override smaller ones if they report a different status (nondeterministic for non-incremental IDs!)
			'workflow_content_id'=>'INTEGER',		// The ID of this content in the workflow_content table
			'workflow_approval_name'=>'SHORT_TRANS',		// The name of the ID field in the source table
			'status_code'=>'SHORT_INTEGER',		// A code indicating the status
			'approved_by'=>'USER'		// Remember who set this status, if the need arises to investigate this later
		));

	}

	/**
	 * Standard modular entry-point finder function.
	 *
	 * @return ?array	A map of entry points (type-code=>language-code) (NULL: disabled).
	 */
	function get_entry_points()
	{
		require_lang('workflows');
		return array_merge(array('misc'=>'MANAGE_WORKFLOWS'),parent::get_entry_points());
	}

	/**
	 * Standard aed_module run_start.
	 *
	 * @param  ID_TEXT		The type of module execution
	 * @return tempcode		The output of the run
	 */
	function run_start($type)
	{
		// TODO: Add pic & tutorial
		//$GLOBALS['HELPER_PANEL_PIC']='pagepics/usergroups';
		//$GLOBALS['HELPER_PANEL_TUTORIAL']='tut_subcom';

		require_lang('workflows');
		require_code('workflows');

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
		require_lang('workflows');
		return do_next_manager(get_screen_title('MANAGE_WORKFLOWS'),comcode_to_tempcode(do_lang('DOC_WORKFLOWS'),NULL,true),
					array(
						/*	 type							  page	 params													 zone	  */
						array('add_one',array('_SELF',array('type'=>'ad'),'_SELF'),do_lang('ADD_WORKFLOW')),
						array('edit_one',array('_SELF',array('type'=>'ed'),'_SELF'),do_lang('EDIT_WORKFLOW')),
					),
					do_lang('MANAGE_WORKFLOWS')
		);
	}

	/**
	 * Get tempcode for a adding/editing form.
	 *
	 * @param  ?integer		The workflow being edited (NULL: adding, not editing)
	 * @return array			A pair: The input fields, Hidden fields
	 */
	function get_form_fields($id=NULL)
	{
		/////////////////////////////////
		// Get all of our requirements //
		/////////////////////////////////

		require_code('form_templates');
		require_lang('workflows');
		require_code('workflows');

		// These will hold our form elements, visible & hidden
		$fields=new ocp_tempcode();
		$hidden=new ocp_tempcode();

		// Grab all of the data we can about this workflow
		// Make some assumptions first
		$default=false;
		$approval_points=array();
		$name_string='';

		// Now overwrite those assumptions if they're wrong
		if (!is_null($id))
		{
			// We can grab the name straight away
			$name_string=get_translated_text($id);
			// Now see if we're the default
			$default_workflow=get_default_workflow();
			if (!is_null($default_workflow) && $id==$default_workflow)
			{
				$default=true;
			}	
			// Get the approval points in workflow order
			$approval_points=array_map('get_translated_text',get_requirements_for_workflow($id));
		}
		else
		{
			// -1 indicates an invalid ID
			$id=-1;
		}

		////////////////////
		// Build the form //
		////////////////////

		// First we must be given a name (defaulting to the given name if
		// it has been passed). We want to show the user which names are
		// unavailable, so scrape the database for this information.
		$workflow_names=get_all_workflows();
		$workflow_name_ids=array_keys($workflow_names);

		if (count($workflow_names) > 0)
		{
			$defined_names=do_lang_tempcode('DEFINED_WORKFLOWS', escape_html(implode(', ', $workflow_names)));
		}
		else
		{
			$defined_names=do_lang_tempcode('NO_DEFINED_WORKFLOWS');
		}

		$fields->attach(form_input_line(do_lang_tempcode('NAME'),do_lang_tempcode('WORKFLOW_NAME_DESCRIPTION', $defined_names),'name',$name_string,true));

		// Now we must handle the ID for this workflow. The ID is an index
		// to the translation table, thus if it is NULL we can generate
		// one simply by adding the given name to the translation table
		// later. Otherwise we must update the language string for this
		// ID. Either way this must be handled during the form processing,
		// since we don't have access to the string until then. Since we
		// want ID to be a number we will set it to an invalid value (-1)
		// to indicate a NULL status.
		$hidden->attach(form_input_hidden('workflow_id',strval($id)));

		// Give the user a multiline text entry to specify the approval
		// points for this workflow. Not as elegant as it could be, but it
		// doesn't require Javascript.
		$all_points=get_all_approval_points();		// We need to display which points are available
		$points_text=array_values($all_points);		// An array of approval point names (strings)

		if ($points_text==array())
		{
			$points_list=do_lang_tempcode('APPROVAL_POINTS_DESCRIPTION_EMPTY_LIST');
		}
		else
		{
			$points_list=do_lang_tempcode('APPROVAL_POINTS_DESCRIPTION_LIST', escape_html(implode(', ', $points_text)));
		}

		// Now add the approval point lines
		$fields->attach(form_input_text(do_lang_tempcode('WORKFLOW_APPROVAL_POINTS'),do_lang_tempcode('APPROVAL_POINTS_DESCRIPTION',$points_list),'points',implode("\n",$approval_points),true,NULL,true));

		// Add an option to make this default
		$fields->attach(form_input_tick(do_lang('DEFAULT_WORKFLOW'),do_lang('DEFAULT_WORKFLOW_DESCRIPTION'),'is_default',$default));

		// Actions
		$fields2=new ocp_tempcode();
		$fields2->attach(do_template('FORM_SCREEN_FIELD_SPACER',array('TITLE'=>do_lang_tempcode('ACTIONS'))));

		// Add an option to redefine the approval permissions
		$fields2->attach(form_input_tick(do_lang('REDEFINE_WORKFLOW_POINTS'), do_lang('REDEFINE_WORKFLOW_POINTS_DESC'), 'redefine_points', false));

		return array($fields,$hidden,new ocp_tempcode(),'',false,'',$fields2);
	}

	/**
	 * Standard aed_module list function.
	 *
	 * @return tempcode		The selection list
	 */
	function nice_get_entries()
	{
		require_lang('workflows');
		$fields=new ocp_tempcode();
		$rows=get_all_workflows();
		foreach ($rows as $id=>$name)
		{
			$fields->attach(form_input_list_entry($id,false,$name));
		}

		return $fields;
	}

	/**
	 * Standard aed_module delete possibility checker.
	 *
	 * @param  ID_TEXT		The entry being potentially deleted
	 * @return boolean		Whether it may be deleted
	 */
	function may_delete_this($id)
	{
		require_lang('workflows');
		// Workflows are optional, so we can always delete them
		return true;
	}

	/**
	 * Standard aed_module edit form filler.
	 *
	 * @param  ID_TEXT		The entry being edited
	 * @return array			A triple: fields, hidden-fields, delete-fields
	 */
	function fill_in_edit_form($id)
	{
		require_lang('workflows');
		// Grab all of our workflow IDs
		$all_workflows=array_keys(get_all_workflows());
		// See if there are any
		if (!array_key_exists(0,$all_workflows))
		{
			warn_exit(do_lang_tempcode('MISSING_RESOURCE'));
		}

		list($fields,$hidden,$delete,$edit_text,$all_delete_fields_given,$posting_form_text,$fields2)=$this->get_form_fields(intval($id));

		$default_workflow=get_default_workflow();

		$workflows=new ocp_tempcode();

		return array($fields,$hidden,$delete,$edit_text,$all_delete_fields_given,$posting_form_text,$fields2);
	}

	/**
	 * Read in data posted by an add/edit form
	 *
	 * @param  boolean	Whether to insert unknown workflows into the database. For adding this should be true, otherwise false (the default)
	 * @return array		(workflow_id, workflow_name, array(approval point IDs=>names), default)
	 */
	function read_in_data($insert_if_needed=false)
	{
		require_lang('workflows');

		// Grab the given name. We allow spaces, letters and numbers.
		$name=implode(' ',array_map('strip_tags',explode(' ',trim(post_param('name')))));

		// Look for an existing workflow with this name
		$workflows=get_all_workflows();
		if (in_array($name,$workflows))
		{
			// Found one, use it
			$workflow_id=current(array_keys($workflows,$name));
		}
		elseif ($insert_if_needed)
		{
			// Couldn't find any. Let's make one, with a dummy approval point.
			// HACKHACK We should use a normalised table with an ID column
			$workflow_id=insert_lang($name,3);
			$GLOBALS['SITE_DB']->query_insert('workflow_requirements',array('workflow_name'=>$workflow_id,'is_default'=>0,'the_position'=>0,'workflow_approval_name'=>0));
		}
		else
		{
			warn_exit(do_lang_tempcode('_MISSING_RESOURCE',escape_html($name)));
		}

		// Grab all of the requested points
		$points=array_map('trim',explode("\n",trim(post_param('points'))));

		// Discard whitespace
		$temp_points=array();
		foreach ($points as $p)
		{
			if (strlen(trim($p)) > 0)
				$temp_points[]=trim($p);
		}
		$points=$temp_points;
		unset($temp_points);

		// Clean them up a bit. We'll allow spaces, but no other punctuation.
		$clean_points=array();
		foreach ($points as $p)
		{
			$clean_points[]=implode(' ',array_map('strip_tags',explode(' ',$p)));
		}
		$points=$clean_points;
		unset($clean_points);

		// Find any points which are already defined
		$all_points=get_all_approval_points();
		$point_ids=array();
		foreach ($points as $p)
		{
			if (in_array($p, array_values($all_points)))
			{
				// This already exists. Use the existing version.
				$point_id=current(array_keys($all_points,$p));
				$point_ids[$point_id]=$p;
			}
			else
			{
				// This doesn't exist yet. Define it now.

				// HACKHACK We should use a normalised table with an ID field
				$point_id=insert_lang($p,3);
				$point_ids[$point_id]=$p;
			}

			// Make sure that there are groups allowed to approve this point
			$this_key=NULL;
			foreach (array_keys($_POST) as $post_key)
			{
				if (strpos($post_key,'code_')===0)
				{
					$this_key=intval(str_replace('code_','',$post_key));
				}
				elseif (strpos($post_key,'redef_')===0)
				{
					$this_key=intval(str_replace('redef_','',$post_key));
				}
			}
			if (is_null($this_key))
			{
				// If we can't find any then it may be that the browser didn't send
				// us the ticks, since the user didn't change them (notably Chrome
				// does this).
				// If this is the case then we leave existing points alone...
				$has_defaults=$GLOBALS['SITE_DB']->query_select('workflow_requirements',array('*'),array('workflow_approval_name'=>$point_id));
				if (count($has_defaults) > 0)
				{
					continue;
				}
				else
				{
					// ... but this is an error is there are no existing permissions

					// Clean up any dummies we made
					$GLOBALS['SITE_DB']->query_delete('workflow_requirements',array('workflow_approval_name'=>0));
					warn_exit(do_lang('WORKFLOW_POINT_MUST_HAVE_GROUP',$p));
				}
			}

			// Clear previous permissions for this approval point
			$GLOBALS['SITE_DB']->query_delete('workflow_permissions',array('workflow_approval_name'=>$point_id));

			// Insert the new permissions for this approval point
			if (array_key_exists('groups_'.strval($this_key),$_POST))
			{
				foreach ($_POST['groups_'.strval($this_key)] as $k=>$v)
				{
					$GLOBALS['SITE_DB']->query_insert('workflow_permissions',array(
						'usergroup'=>intval($k),
						'workflow_approval_name'=>$point_id,
						'validated'=>1,		// Keep things simple for now
					));
				}
			}
			if (array_key_exists('redef_groups_'.strval($this_key),$_POST))
			{
				foreach ($_POST['redef_groups_'.strval($this_key)] as $k=>$v)
				{
					$GLOBALS['SITE_DB']->query_insert('workflow_permissions',array(
						'usergroup'=>intval($k),
						'workflow_approval_name'=>$point_id,
						'validated'=>1,		// Keep things simple for now
					));
				}
			}

		}

		// Now replace the workflow requirements. Add the new points (existing
		// instances will be replaced, so we don't need to worry about duplicates)
		$point_names=array_flip($point_ids);
		$points_we_want=array();
		foreach ($points as $p)
		{
			add_requirement_to_workflow($point_names[$p],$workflow_id);
			$points_we_want[]=$point_names[$p];
		}
		// Now we remove those points which are not wanted. We have to do this
		// after the insertions, since we need to keep at least one approval point
		// for the workflow in order for it to exist.
		$GLOBALS['SITE_DB']->query('DELETE FROM '.get_table_prefix().'workflow_requirements WHERE workflow_name='.strval($workflow_id).' AND workflow_approval_name NOT IN ('.implode(',',$points_we_want).')');

		return array($workflow_id, $name, $point_ids, post_param_integer('is_default',0)==1);
	}

	/**
	 * Standard modular UI/actualiser to add an entry.
	 *
	 * @return tempcode	The UI
	 */
	function _ad()
	{
		// We override the add screen here so that we can provide multiple screens

		/* Standard AED stuff */
		if (!is_null($this->permissions_require)) check_submit_permission($this->permissions_require,array($this->permissions_cat_require,is_null($this->permissions_cat_name)?'':post_param($this->permissions_cat_name),$this->permissions_cat_require_b,is_null($this->permissions_cat_name_b)?'':post_param($this->permissions_cat_name_b)));

		$doing='ADD_'.$this->lang_type;
		if (($this->catalogue) && (get_param('catalogue_name','')!=''))
		{
			$catalogue_title=get_translated_text($GLOBALS['SITE_DB']->query_value('catalogues','c_title',array('c_name'=>get_param('catalogue_name'))));
			if ($this->type_code=='d')
			{
				$doing=do_lang('CATALOGUE_GENERIC_ADD',escape_html($catalogue_title));
			}
			elseif ($this->type_code=='c')
			{
				$doing=do_lang('CATALOGUE_GENERIC_ADD_CATEGORY',escape_html($catalogue_title));
			}
		}

		$title=get_screen_title($doing);

		if (($this->second_stage_preview) && (get_param_integer('preview',0)==1))
		{
			return $this->preview_intercept($title);
		}

		$test=$this->handle_confirmations($title);
		if (!is_null($test)) return $test;

		if (($this->user_facing) && (!is_null($this->permissions_require)))
		{
			if (!has_specific_permission(get_member(),'bypass_validation_'.$this->permissions_require.'range_content',NULL,array($this->permissions_cat_require,is_null($this->permissions_cat_name)?'':post_param($this->permissions_cat_name),$this->permissions_cat_require_b,is_null($this->permissions_cat_name_b)?'':post_param($this->permissions_cat_name_b))))
				$_POST['validated']='0';
		}

		if (!is_null($this->upload)) require_code('uploads');

		/* Interrupt standard AED stuff, so we can choose our screen */
		if ($this->need_second_screen())
		{
			// We need more info from the user. Ask for it here.
			return $this->second_screen();
		}

		/* If we reach here, the form is complete so we resume the AED process */

		$temp=$this->add_actualisation();

		$description=is_null($this->do_next_description)?do_lang_tempcode('SUCCESS'):$this->do_next_description;

		if (is_array($temp))
		{
			list($id,$text)=$temp;
			if (!is_null($text)) $description->attach($text);
		} else
		{
			$id=$temp;
		}

		if ($this->user_facing)
		{
			require_code('submit');
			if (($this->check_validation) && (post_param_integer('validated',0)==0))
			{
				if ($this->send_validation_request)
				{
					$edit_url=build_url(array('page'=>'_SELF','type'=>'_e'.$this->type_code,'id'=>$id),'_SELF',NULL,false,false,true);
					if (addon_installed('unvalidated'))
						send_validation_request($doing,$this->table,$this->non_integer_id,$id,$edit_url);
				}

				$description->attach(paragraph(do_lang_tempcode('SUBMIT_UNVALIDATED')));
			}
			give_submit_points($doing);
		}

		if (addon_installed('awards'))
		{
			if (!is_null($this->award_type))
			{
				require_code('awards');
				handle_award_setting($this->award_type,$id);
			}
		}

		clear_ocp_autosave();
		decache('main_awards');

//		if ($this->redirect_type=='!')
		{
			$url=get_param('redirect',NULL);
			if (!is_null($url)) return redirect_screen($title,$url,$description);
		}

		breadcrumb_set_parents(array_merge($GLOBALS['BREADCRUMB_SET_PARENTS'],array(array('_SELF:_SELF:a'.$this->type_code,(strpos($doing,' ')!==false)?protect_from_escaping($doing):do_lang_tempcode($doing)))));

		return $this->do_next_manager($title,$description,$id);
	}

	/**
	 * Standard modular UI/actualiser to edit an entry.
	 *
	 * @return tempcode	The UI
	 */
	function __ed()
	{
		// We override the standard AED edit actualiser in order to redirect to a
		// second edit screen if certain conditions are met. Other than this, the
		// rest of this method's code is copypasta'd from the standard AED module

		// AED stuff to begin with

		$id=mixed(); // Define type as mixed
		$id=$this->non_integer_id?get_param('id',false,true):strval(get_param_integer('id'));

		$doing='EDIT_'.$this->lang_type;
		if (($this->catalogue) && (get_param('catalogue_name','')!=''))
		{
			$catalogue_title=get_translated_text($GLOBALS['SITE_DB']->query_value('catalogues','c_title',array('c_name'=>get_param('catalogue_name'))));
			if ($this->type_code=='d')
			{
				$doing=do_lang('CATALOGUE_GENERIC_EDIT',escape_html($catalogue_title));
			}
			elseif ($this->type_code=='c')
			{
				$doing=do_lang('CATALOGUE_GENERIC_EDIT_CATEGORY',escape_html($catalogue_title));
			}
		}
		$title=get_screen_title($doing);

		if (($this->second_stage_preview) && (get_param_integer('preview',0)==1))
		{
			return $this->preview_intercept($title);
		}


		if (method_exists($this,'get_submitter'))
		{
			list($submitter,$date_and_time)=$this->get_submitter($id);
			if ((!is_null($date_and_time)) && (addon_installed('points')))
			{
				$reverse=post_param_integer('reverse_point_transaction',0);
				if ($reverse==1)
				{
					$points_test=$GLOBALS['SITE_DB']->query_select('gifts',array('*'),array('date_and_time'=>$date_and_time,'gift_to'=>$submitter,'gift_from'=>$GLOBALS['FORUM_DRIVER']->get_guest_id()));
					if (array_key_exists(0,$points_test))
					{
						$amount=$points_test[0]['amount'];
						$sender_id=$points_test[0]['gift_from'];
						$recipient_id=$points_test[0]['gift_to'];
						$GLOBALS['SITE_DB']->query_delete('gifts',array('id'=>$points_test[0]['id']),'',1);
						if (!is_guest($sender_id))
						{
							$_sender_gift_points_used=point_info($sender_id);
							$sender_gift_points_used=array_key_exists('gift_points_used',$_sender_gift_points_used)?$_sender_gift_points_used['gift_points_used']:0;
							$GLOBALS['FORUM_DRIVER']->set_custom_field($sender_id,'gift_points_used',strval($sender_gift_points_used-$amount));
						}
						require_code('points');
						$temp_points=point_info($recipient_id);
						$GLOBALS['FORUM_DRIVER']->set_custom_field($recipient_id,'points_gained_given',strval((array_key_exists('points_gained_given',$temp_points)?$temp_points['points_gained_given']:0)-$amount));
					}
				}
			}
		} else $submitter=NULL;

		breadcrumb_set_parents(array_merge($GLOBALS['BREADCRUMB_SET_PARENTS'],array(array('_SELF:_SELF:_e'.$this->type_code.':'.$id,(strpos($doing,' ')!==false)?protect_from_escaping($doing):do_lang_tempcode($doing)))));

		$delete=post_param_integer('delete',0);
		if (($delete==1) || ($delete==2)) //1=partial,2=full,...=unknown,thus handled as an edit
		{
			if (!is_null($this->permissions_require))
			{
				check_delete_permission($this->permissions_require,$submitter,array($this->permissions_cat_require,is_null($this->permissions_cat_name)?NULL:$this->get_cat($id),$this->permissions_cat_require_b,is_null($this->permissions_cat_name_b)?NULL:$this->get_cat_b($id)));
			}

			$doing='DELETE_'.$this->lang_type;
			if (($this->catalogue) && (get_param('catalogue_name','')!=''))
			{
				$catalogue_title=get_translated_text($GLOBALS['SITE_DB']->query_value('catalogues','c_title',array('c_name'=>get_param('catalogue_name'))));
				if ($this->type_code=='d')
				{
					$doing=do_lang('CATALOGUE_GENERIC_DELETE',escape_html($catalogue_title));
				}
				elseif ($this->type_code=='c')
				{
					$doing=do_lang('CATALOGUE_GENERIC_DELETE_CATEGORY',escape_html($catalogue_title));
				}
			}
			$title=get_screen_title($doing);

			$test=$this->handle_confirmations($title);
			if (!is_null($test)) return $test;

			$this->delete_actualisation($id);

			/*if ((!is_null($this->redirect_type)) || ((!is_null(get_param('redirect',NULL)))))		No - resource is gone now, and redirect would almost certainly try to take us back there
			{
				$url=(($this->redirect_type=='!') || (is_null($this->redirect_type)))?get_param('redirect'):build_url(array('page'=>'_SELF','type'=>$this->redirect_type),'_SELF');
				return redirect_screen($title,$url,do_lang_tempcode('SUCCESS'));
			}*/

			clear_ocp_autosave();

			$description=is_null($this->do_next_description)?do_lang_tempcode('SUCCESS'):$this->do_next_description;

			return $this->do_next_manager($title,$description,NULL);
		}
		else
		{
			if (!is_null($this->permissions_require))
			{
				check_edit_permission($this->permissions_require,$submitter,array($this->permissions_cat_require,is_null($this->permissions_cat_name)?NULL:$this->get_cat($id),$this->permissions_cat_require_b,is_null($this->permissions_cat_name_b)?NULL:$this->get_cat_b($id)));
			}

			$test=$this->handle_confirmations($title);
			if (!is_null($test)) return $test;

			if (($this->user_facing) && (!is_null($this->permissions_require)) && (array_key_exists('validated',$_POST)))
			{
				if (!has_specific_permission(get_member(),'bypass_validation_'.$this->permissions_require.'range_content',NULL,array($this->permissions_cat_require,is_null($this->permissions_cat_name)?'':post_param($this->permissions_cat_name),$this->permissions_cat_require_b,is_null($this->permissions_cat_name_b)?'':post_param($this->permissions_cat_name_b))))
					$_POST['validated']='0';
			}

			// Here we interrupt the regular AED code see if we should redirect to
			// a second data entry screen
			if ($this->need_second_screen())
			{
				return $this->second_screen();
			}

			if (!is_null($this->upload)) require_code('uploads');
			$description=$this->edit_actualisation($id);
			if (!is_null($this->new_id)) $id=$this->new_id;
			if (($this->output_of_action_is_confirmation) && (!is_null($description))) return $description;

			if (is_null($description)) $description=do_lang_tempcode('SUCCESS');

			if (addon_installed('awards'))
			{
				if (!is_null($this->award_type))
				{
					require_code('awards');
					handle_award_setting($this->award_type,$id);
				}
			}

			if ($this->user_facing)
			{
				if (($this->check_validation) && (post_param_integer('validated',0)==0))
				{
					require_code('submit');
					if ($this->send_validation_request)
					{
						$edit_url=build_url(array('page'=>'_SELF','type'=>'_e'.$this->type_code,'id'=>$id),'_SELF',NULL,false,false,true);
						if (addon_installed('unvalidated'))
							send_validation_request($doing,$this->table,$this->non_integer_id,$id,$edit_url);
					}

					$description->attach(paragraph(do_lang_tempcode('SUBMIT_UNVALIDATED')));
				}
			}
		}

		if ((!is_null($this->redirect_type)) || ((!is_null(get_param('redirect',NULL)))))
		{
			$url=(($this->redirect_type=='!') || (is_null($this->redirect_type)))?make_string_tempcode(get_param('redirect')):build_url(array('page'=>'_SELF','type'=>$this->redirect_type),'_SELF');
			return redirect_screen($title,$url,do_lang_tempcode('SUCCESS'));
		}

		clear_ocp_autosave();
		decache('main_awards');

		return $this->do_next_manager($title,$description,$id);
	}

	/**
	 * Standard aed_module add actualiser.
	 *
	 * @return ID_TEXT		The entry added
	 */
	function add_actualisation()
	{	
		require_lang('workflows');

		// Grab our data. We pass true so that it will create non-existant content
		// for us (workflow and approval points)
		list($workflow_id,$workflow_name,$approval_points,$is_default)=$this->read_in_data(true);

		// Now create the workflow's presence in the database, by giving
		// it the approval points as requirements.
		$id=build_new_workflow($workflow_id, $workflow_name, array_keys($approval_points), $is_default);

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
		require_lang('workflows');
		// Grab our data
		list($workflow_id,$workflow_name,$approval_points,$is_default)=$this->read_in_data(false);

		// TODO
	}

	/**
	 * Standard aed_module delete actualiser.
	 *
	 * @param  ID_TEXT		The entry being deleted
	 */
	function delete_actualisation($id)
	{
		delete_workflow(intval($id));
	}

	/**
	 * Tells us if more information is needed from the user. This is required
	 * since the user may create a workflow out of predefined components, which
	 * requires no further information, or they may want to define new approval
	 * points, which requires more information.
	 *
	 * @return boolean		Whether more information is needed from the user.
	 */
	function need_second_screen()
	{
		// We need to show the second screen if it has been specifically requested
		// via the edit form
		if (array_key_exists('redefine_points',$_POST))
		{
			return true;
		}

		// Otherwise the only reason we might need more information is if there
		// are approval points specified that haven't been defined.

		// Grab all of the requested points
		$points=array_map('trim',explode("\n",trim(post_param('points'))));

		// Throw out whitespace
		$temp_points=array();
		foreach ($points as $p)
		{
			if (strlen(trim($p)) > 0)
				$temp_points[]=trim($p);
		}
		$points=$temp_points;
		unset($temp_points);

		// Clean them up a bit. We'll allow spaces, but no other punctuation.
		$clean_points=array();
		foreach ($points as $p)
		{
			$clean_points[]=implode(' ',array_map('strip_tags',explode(' ',$p)));
		}
		$points=$clean_points;
		unset($clean_points);

		// Find any points which are already defined
		$all_points=get_all_approval_points();

		// See if we need to define any
		foreach ($points as $p)
		{
			if (!in_array($p,$all_points) &&												// This point has not been defined previously...
				(
					!@in_array(get_magic_quotes_gpc()?addslashes($p):$p,$_POST) ||													// ... and we are not defining it now...
					($_POST['points']==get_magic_quotes_gpc()?addslashes($p):$p && count(array_keys($_POST,get_magic_quotes_gpc()?addslashes($p):$p))==1)	// ... or our definition is restricted to just the approval point list
				)
			)
			{
				// Found an undefined point. We need more information.
				return true;
			}
		}

		// If we've reached here then there's nothing to do
		return false;
	}

	/**
	 * Renders a screen for setting permissions on approval points.
	 *
	 * @return tempcode		The UI
	 */
	function second_screen()
	{
		require_code('form_templates');

		// See if we're redefining everything
		$redefining=array_key_exists('redefine_points',$_POST);

		// Grab all of the requested points
		$points=array_map('trim',explode("\n",trim(post_param('points'))));

		// Throw out whitespace
		$temp_points=array();
		foreach ($points as $p)
		{
			if (strlen(trim($p)) > 0)
				$temp_points[]=trim($p);
		}
		$points=$temp_points;
		unset($temp_points);

		// Clean them up a bit. We'll allow spaces, but no other punctuation.
		$clean_points=array();
		foreach ($points as $p)
		{
			$clean_points[]=implode(' ',array_map('strip_tags',explode(' ',$p)));
		}
		$points=$clean_points;
		unset($clean_points);

		// Find any points which are already defined
		$all_points=get_all_approval_points();

		// This will hold new points
		$clarify_points=array();

		// This will hold existing points we're redefining
		$redefine_points=array();

		// See if we need to define any
		foreach ($points as $p)
		{
			if (!in_array($p,$all_points))
			{
				// Found an undefined point. We need more information.
				$clarify_points[]=$p;
			}
			elseif ($redefining)
			{
				$redefine_points[]=$p;
			}
		}

		// These will hold our form fields
		$fields=new ocp_tempcode();
		$hidden=new ocp_tempcode();

		// Pass through the previous screen's data
		foreach (array('points','is_default','name') as $n)
		{
			$hidden->attach(form_input_hidden($n, post_param($n,'')));
		}

		// We need a list of groups so that the user can choose those to give
		// permission to
		$usergroups=$GLOBALS['FORUM_DRIVER']->get_usergroup_list(true,true,false,NULL,NULL);

		// Add the form elements for each section
		if (count($clarify_points) > 0)
		{
			$fields->attach(do_template('FORM_SCREEN_FIELD_SPACER',array(
				'TITLE'=>do_lang_tempcode('DEFINE_WORKFLOW_POINTS'),
				'HELP'=>do_lang_tempcode('DEFINE_WORKFLOW_POINTS_HELP',escape_html(implode(', ',$clarify_points))),
			)));
			$counter=0;
			foreach ($clarify_points as $p)
			{
				// Add a code to reference these elements by later
				$hidden->attach(form_input_hidden('code_'.strval($counter), $p));

				// Now add a list of the groups to allow
				$content=array();
				foreach ($usergroups as $group_id=>$group_name)
				{
					$content[]=array($group_name,'groups_'.strval($counter).'['.strval($group_id).']', false, '');
				}
				$fields->attach(form_input_various_ticks(
					$content,
					do_lang_tempcode('WORKFLOW_POINT_GROUPS_DESC',escape_html($p)),
					NULL,
					do_lang_tempcode('WORKFLOW_POINT_GROUPS',escape_html($p)),
					true
				));
				$counter++;
			}
		}

		if (count($redefine_points) > 0)
		{
			$fields->attach(do_template('FORM_SCREEN_FIELD_SPACER',array(
				'TITLE'=>do_lang_tempcode('REDEFINE_WORKFLOW_POINTS'),
				'HELP'=>do_lang_tempcode('REDEFINE_WORKFLOW_POINTS_HELP'),
			)));

			// These points already exist, so look them up
			$all_points=array_flip(get_all_approval_points());

			foreach ($redefine_points as $p)
			{
				// Add a code to reference these elements by later
				$hidden->attach(form_input_hidden('redef_'.strval($all_points[$p]), $p));

				// Now add a list of the groups to allow, defaulting to those which
				// already have permission
				$groups=get_groups_for_point($all_points[$p],false);

				$content=array();
				foreach ($usergroups as $group_id=>$group_name)
				{
					$content[]=array($group_name,'redef_groups_'.strval($all_points[$p]).'['.strval($group_id).']', in_array($group_id,$groups), '');
				}
				$fields->attach(form_input_various_ticks(
					$content,
					do_lang_tempcode('WORKFLOW_POINT_GROUPS_DESC',escape_html($p)),
					NULL,
					do_lang_tempcode('WORKFLOW_POINT_GROUPS',escape_html($p)),
					true
				));
			}
		}

		$self_url=get_self_url();

		return do_template('FORM_SCREEN',array(
			'TITLE'=>do_template('SCREEN_TITLE',array(
				'TITLE'=>do_lang('DEFINE_WORKFLOW_POINTS'),
				'HELP_URL'=>'',
			)),
			'FIELDS'=>$fields,
			'TEXT'=>'',
			'HIDDEN'=>$hidden,
			'URL'=>is_object($self_url)?$self_url->evaluate():$self_url,
			'SUBMIT_NAME'=>do_lang_tempcode('PROCEED'),
		));
	}
}


