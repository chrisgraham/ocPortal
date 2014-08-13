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
		// Remove database tables
		$GLOBALS['SITE_DB']->drop_if_exists('workflows');
		$GLOBALS['SITE_DB']->drop_if_exists('workflow_permissions');
		$GLOBALS['SITE_DB']->drop_if_exists('workflow_approval_points');
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

		$GLOBALS['SITE_DB']->create_table('workflows',array(
			'id'=>'*AUTO',		// ID
			'workflow_name'=>'SHORT_TRANS',		// The name (and ID) of this approval point
			'is_default'=>'BINARY',
		));

		// The workflow_approval_points table records which workflows require which points to approve
		$GLOBALS['SITE_DB']->create_table('workflow_approval_points',array(
			'id'=>'*AUTO',		// ID for reference
			'workflow_id'=>'AUTO_LINK',		// The name (and ID) of this workflow
			'workflow_approval_name'=>'SHORT_TRANS',		// The name (and ID) of the approval point to require in this workflow
			'the_position'=>'INTEGER',		// The position of this approval point in the workflow (ie. any approval can be given at any time, but encourage users into a prespecified order)
		));

		// The workflow_permissions table stores which usergroups are
		// allowed to approve which points
		$GLOBALS['SITE_DB']->create_table('workflow_permissions',array(
			'id'=>'*AUTO',		// ID for reference
			'workflow_approval_point_id'=>'AUTO_LINK',		// The ID of the approval point
			'usergroup'=>'GROUP',		// The usergroup to give permission to
		));

		// The workflow_content table records which site resources are in
		// which workflows, along with any notes made during the approval
		// process
		$GLOBALS['SITE_DB']->create_table('workflow_content',array(
			'id'=>'*AUTO',		// ID for reference
			'content_type'=>'ID_TEXT',		// The content-meta-aware type we'd find this content in
			'content_id'=>'ID_TEXT',		// The ID of the content, wherever it happens to be
			'workflow_id'=>'AUTO_LINK',		// The ID of the workflow this content is in
			'notes'=>'LONG_TEXT',		// No point translating the notes, since they're transient
			'original_submitter'=>'USER'		// Save this here since there's no standard way to discover it later (eg. through content-meta-aware hooks)
		));

		// The workflow_content_status table records the status of each
		// approval point for a piece of content and the member who
		// approved the point (if any)
		$GLOBALS['SITE_DB']->create_table('workflow_content_status',array(
			'id'=>'*AUTO',		// ID for reference. Larger IDs will override smaller ones if they report a different status (nondeterministic for non-incremental IDs!)
			'workflow_content_id'=>'INTEGER',		// The ID of this content in the workflow_content table
			'workflow_approval_point_id'=>'AUTO_LINK',		// The ID of the approval point
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
	 * Standard crud_module run_start.
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
		require_code('workflows2');

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
	 * Standard crud_module edit form filler.
	 *
	 * @param  ID_TEXT		The entry being edited
	 * @return array			A triple: fields, hidden-fields, delete-fields
	 */
	function fill_in_edit_form($id)
	{
		return $this->get_form_fields(intval($id));
	}

	/**
	 * Get a list of point names specified.
	 *
	 * @return array			List of point names
	 */
	function get_points_in_edited_workflow()
	{
		// Grab all of the requested points
		$point_names=array_map('trim',explode("\n",post_param('points')));
		$temp_point_names=array();
		foreach ($point_names as $p)
		{
			if ($p!='')
				$temp_point_names[]=$p;
		}
		return $temp_point_names;
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

		// These will hold our form elements, visible & hidden
		$fields=new ocp_tempcode();
		$hidden=new ocp_tempcode();

		// Grab all of the data we can about this workflow
		// Make some assumptions first
		$default=false;
		$approval_points=array();
		$workflow_name='';

		// Now overwrite those assumptions if they're wrong
		if (!is_null($id))
		{
			$workflows=$GLOBALS['SITE_DB']->query_select('workflows',array('*'),array('id'=>$id),'',1);
			if (!array_key_exists(0,$workflows)) warn_exit(do_lang_tempcode('MISSING_RESOURCE'));
			$workflow=$workflows[0];

			// We can grab the name straight away
			$workflow_name=get_translated_text($workflow['workflow_name']);

			// Now see if we're the default
			$default_workflow=get_default_workflow();
			if (!is_null($default_workflow) && $id==$default_workflow)
			{
				$default=true;
			}	
			// Get the approval points in workflow order
			$approval_points=get_all_approval_points($id);
		} else
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
		$workflows=get_all_workflows();

		if (count($workflows)>0)
		{
			$defined_names=do_lang('DEFINED_WORKFLOWS',implode(', ',$workflows));
		} else
		{
			$defined_names=do_lang('NO_DEFINED_WORKFLOWS');
		}

		$fields->attach(form_input_line(do_lang_tempcode('NAME'),do_lang_tempcode('WORKFLOW_NAME_DESCRIPTION',$defined_names),'name',$workflow_name,true));

		// Now we must handle the ID for this workflow.
		// This must be handled during the form processing,
		// since we don't have access to the string until then. Since we
		// want ID to be a number we will set it to an invalid value (-1)
		// to indicate a NULL status.
		$hidden->attach(form_input_hidden('workflow_id',strval($id)));

		$all_points=get_all_approval_points($id);		// We need to display which points are available
		if ($all_points==array())
		{
			$points_list=do_lang('APPROVAL_POINTS_DESCRIPTION_EMPTY_LIST');
		} else
		{
			$points_list=do_lang('APPROVAL_POINTS_DESCRIPTION_LIST',implode(', ',$all_points));
		}

		// Now add the approval point lines
		$fields->attach(form_input_text(do_lang_tempcode('WORKFLOW_APPROVAL_POINTS'),do_lang_tempcode('APPROVAL_POINTS_DESCRIPTION',$points_list),'points',implode("\n",$approval_points),true,NULL,true));

		// Add an option to make this default
		$fields->attach(form_input_tick(do_lang('DEFAULT_WORKFLOW'),do_lang('DEFAULT_WORKFLOW_DESCRIPTION'),'is_default',$default));

		// Actions
		$fields2=new ocp_tempcode();
		$fields2->attach(do_template('FORM_SCREEN_FIELD_SPACER',array('TITLE'=>do_lang_tempcode('ACTIONS'))));

		// Add an option to redefine the approval permissions
		$fields2->attach(form_input_tick(do_lang('REDEFINE_WORKFLOW_POINTS'),do_lang('REDEFINE_WORKFLOW_POINTS_DESC'),'redefine_points',false));

		return array($fields,$hidden,new ocp_tempcode(),'',false,'',$fields2);
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
		if (post_param_integer('redefine_points',0)==1)
		{
			return true;
		}

		// Otherwise the only reason we might need more information is if there
		// are approval points specified that haven't been defined.

		$point_names=$this->get_points_in_edited_workflow();

		// Find any points which are already defined
		$all_points=get_all_approval_points();

		// See if we need to define any
		foreach ($point_names as $p)
		{
			if (!in_array($p,$all_points)) // This point has not been defined previously...
				return true;
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

		$point_names=$this->get_points_in_edited_workflow();

		// Find any points which are already defined
		$all_points=array_flip(get_all_approval_points());

		// This will hold new points
		$clarify_points=array();

		// This will hold existing points we're redefining
		$redefine_points=array();

		// See if we need to define any
		foreach ($point_names as $seq_id=>$p)
		{
			if (!in_array($p,$all_points))
			{
				// Found an undefined point. We need more information.
				$clarify_points[$seq_id]=$p;
			} else
			{
				$redefine_points[$seq_id]=$p;
			}
		}

		// These will hold our form fields
		$fields=new ocp_tempcode();
		$hidden=new ocp_tempcode();

		// Pass through the previous screen's data
		foreach (array('points','is_default','name') as $n)
		{
			$hidden->attach(form_input_hidden($n,post_param($n,'')));
		}

		// We need a list of groups so that the user can choose those to give
		// permission to
		$usergroups=$GLOBALS['FORUM_DRIVER']->get_usergroup_list(true,true,false,NULL,NULL);

		// Add the form elements for each section
		if (count($clarify_points)>0)
		{
			$fields->attach(do_template('FORM_SCREEN_FIELD_SPACER',array(
				'TITLE'=>do_lang('DEFINE_WORKFLOW_POINTS'),
				'HELP'=>do_lang_tempcode('DEFINE_WORKFLOW_POINTS_HELP',implode(', ',$clarify_points)),
			)));
			foreach ($clarify_points as $seq_id=>$p)
			{
				// Now add a list of the groups to allow
				$content=array();
				foreach ($usergroups as $group_id=>$group_name)
				{
					$content[]=array($group_name,'groups_'.strval($seq_id).'['.strval($group_id).']',false,'');
				}
				$fields->attach(form_input_various_ticks(
					$content,
					do_lang('WORKFLOW_POINT_GROUPS_DESC',$p),
					NULL,
					do_lang('WORKFLOW_POINT_GROUPS',$p),
					true
				));
			}
		}

		if (count($redefine_points)>0)
		{
			$fields->attach(do_template('FORM_SCREEN_FIELD_SPACER',array(
				'TITLE'=>do_lang('REDEFINE_WORKFLOW_POINTS'),
				'HELP'=>do_lang('REDEFINE_WORKFLOW_POINTS_HELP'),
			)));

			// These points already exist, so look them up
			$all_points=array_flip(get_all_approval_points());

			foreach ($redefine_points as $seq_id=>$p)
			{
				// Now add a list of the groups to allow, defaulting to those which
				// already have permission
				$groups=get_usergroups_for_approval_point($all_points[$p],false);

				$content=array();
				foreach ($usergroups as $group_id=>$group_name)
				{
					$content[]=array($group_name,'groups_'.strval($seq_id).'['.strval($group_id).']',in_array($group_id,$groups),'');
				}
				$fields->attach(form_input_various_ticks(
					$content,
					do_lang('WORKFLOW_POINT_GROUPS_DESC',$p),
					NULL,
					do_lang('WORKFLOW_POINT_GROUPS',$p),
					true
				));
			}
		}

		$self_url=get_self_url();

		$title=get_screen_title('DEFINE_WORKFLOW_POINTS');

		return do_template('FORM_SCREEN',array(
			'TITLE'=>$title,
			'FIELDS'=>$fields,
			'TEXT'=>'',
			'HIDDEN'=>$hidden,
			'URL'=>$self_url,
			'SUBMIT_NAME'=>do_lang_tempcode('PROCEED'),
		));
	}

	/**
	 * Standard crud_module list function.
	 *
	 * @return tempcode		The selection list
	 */
	function nice_get_entries()
	{
		$fields=new ocp_tempcode();
		$rows=get_all_workflows();
		foreach ($rows as $id=>$name)
		{
			$fields->attach(form_input_list_entry($id,false,$name));
		}

		return $fields;
	}

	/**
	 * Standard crud_module delete possibility checker.
	 *
	 * @param  ID_TEXT		The entry being potentially deleted
	 * @return boolean		Whether it may be deleted
	 */
	function may_delete_this($id)
	{
		// Workflows are optional, so we can always delete them
		return true;
	}

	/**
	 * Read in data posted by an add/edit form
	 *
	 * @param  boolean	Whether to insert unknown workflows into the database. For adding this should be true, otherwise false (the default)
	 * @return array		(workflow_id, workflow_name, array(approval point IDs=>names), default)
	 */
	function read_in_data($insert_if_needed=false)
	{
		$name=post_param('name');
		$is_default=(post_param_integer('is_default',0)==1);

		$workflow_id=post_param_integer('workflow_id');
		if ($workflow_id==-1)
		{
			if ($insert_if_needed) // Adding
			{
				$map=array();
				$map+=insert_lang('workflow_name',$name,3);
				$workflow_id=$GLOBALS['SITE_DB']->query_insert('workflows',$map,true);
			} else
			{
				warn_exit(do_lang_tempcode('INTERNAL_ERROR'));
			}
		}

		$point_names=$this->get_points_in_edited_workflow();

		// Find any points and new settings for them
		$all_points=get_all_approval_points($workflow_id);
		$point_ids=array();
		foreach ($point_names as $seq_id=>$point_name)
		{
			$point_id=array_search($point_name,$all_points);
			if ($point_id!==false)
			{
				// This already exists. Use the existing version.
				$point_ids[$point_id]=$point_name;

				// Clear previous permissions for this approval point
				$GLOBALS['SITE_DB']->query_delete('workflow_permissions',array('workflow_approval_point_id'=>$point_id));
			} else
			{
				// This doesn't exist yet. Create it.

				$point_id=add_approval_point_to_workflow(insert_lang('workflow_approval_name',$point_name,3),$workflow_id);
				$point_ids[$point_id]=$point_name;
			}

			// Insert the new permissions for this approval point
			if (array_key_exists('groups_'.strval($seq_id),$_POST))
			{
				foreach (array_keys($_POST['groups_'.strval($seq_id)]) as $group_id)
				{
					$GLOBALS['SITE_DB']->query_insert('workflow_permissions',array(
						'usergroup'=>intval($group_id),
						'workflow_approval_point_id'=>$point_id,
					));
				}
			}
		}

		// Now we remove those points which are not wanted. We have to do this
		// after the insertions, since we need to keep at least one approval point
		// for the workflow in order for it to exist.
		$sql='DELETE FROM '.get_table_prefix().'workflow_approval_points WHERE workflow_id='.strval($workflow_id).' AND id NOT IN ('.implode(',',array_map('strval',array_keys($point_ids))).')';
		$GLOBALS['SITE_DB']->query($sql);

		return array($workflow_id,$name,$point_ids,$is_default);
	}

	/**
	 * Standard modular UI/actualiser to add an entry.
	 *
	 * @return tempcode	The UI
	 */
	function _ad()
	{
		// We override the add screen here so that we can provide multiple screens

		$doing='ADD_'.$this->lang_type;

		$title=get_screen_title($doing);

		$test=$this->handle_confirmations($title);
		if (!is_null($test)) return $test;

		// Interrupt standard CRUD stuff, so we can choose our screen
		if ($this->need_second_screen())
		{
			// We need more info from the user. Ask for it here.
			return $this->second_screen();
		}

		// If we reach here, the form is complete so we resume the CRUD process

		$id=$this->add_actualisation();

		$description=do_lang_tempcode('SUCCESS');

		$url=get_param('redirect',NULL);
		if (!is_null($url)) return redirect_screen($title,$url,$description);

		breadcrumb_set_parents(array_merge($GLOBALS['BREADCRUMB_SET_PARENTS'],array(array('_SELF:_SELF:a'.$this->type_code,do_lang_tempcode($doing)))));

		return $this->do_next_manager($title,$description,$id);
	}

	/**
	 * Standard crud_module add actualiser.
	 *
	 * @return ID_TEXT		The entry added
	 */
	function add_actualisation()
	{	
		// Grab our data. We pass true so that it will create non-existant content
		// for us (workflow and approval points)
		list($workflow_id,$workflow_name,$approval_points,$is_default)=$this->read_in_data(true);

		return strval($workflow_id);
	}

	/**
	 * Standard modular UI/actualiser to edit an entry.
	 *
	 * @return tempcode	The UI
	 */
	function __ed()
	{
		// We override the standard CRUD edit actualiser in order to redirect to a
		// second edit screen if certain conditions are met. Other than this, the
		// rest of this method's code is copypasta'd from the standard CRUD module

		// CRUD stuff to begin with

		$id=strval(get_param_integer('id'));

		$doing='EDIT_'.$this->lang_type;
		$title=get_screen_title($doing);

		breadcrumb_set_parents(array_merge($GLOBALS['BREADCRUMB_SET_PARENTS'],array(array('_SELF:_SELF:_e'.$this->type_code.':'.$id,do_lang_tempcode($doing)))));

		$delete=post_param_integer('delete',0);
		if ($delete==1)
		{
			$doing='DELETE_'.$this->lang_type;
			$title=get_screen_title($doing);

			$test=$this->handle_confirmations($title);
			if (!is_null($test)) return $test;

			$this->delete_actualisation($id);

			clear_ocp_autosave();

			$description=do_lang_tempcode('SUCCESS');

			return $this->do_next_manager($title,$description,NULL);
		} else
		{
			$test=$this->handle_confirmations($title);
			if (!is_null($test)) return $test;

			// Here we interrupt the regular CRUD code see if we should redirect to
			// a second data entry screen
			if ($this->need_second_screen())
			{
				return $this->second_screen();
			}

			$this->edit_actualisation($id);

			$description=do_lang_tempcode('SUCCESS');
		}

		clear_ocp_autosave();

		return $this->do_next_manager($title,$description,$id);
	}

	/**
	 * Standard crud_module edit actualiser.
	 *
	 * @param  ID_TEXT		The entry being edited
	 * @return ?tempcode		Confirm message (NULL: continue)
	 */
	function edit_actualisation($id)
	{
		list($workflow_id,$workflow_name,$approval_points,$is_default)=$this->read_in_data(false);
		return NULL;
	}

	/**
	 * Standard crud_module delete actualiser.
	 *
	 * @param  ID_TEXT		The entry being deleted
	 */
	function delete_actualisation($id)
	{
		delete_workflow(intval($id));
	}
}
