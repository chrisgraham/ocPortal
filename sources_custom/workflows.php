<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		workflows
 */

/**
 * Adds the specified content (image, video, gallery, etc.) to the
 * specified workflow.
 *
 * @param  SHORT_TEXT		The content-meta-aware name that applies to this content.
 * @param  SHORT_TEXT		The ID of this content. Must be a string. Integers will be extracted from the string if needed.
 * @param  ?AUTO_LINK		The translation table ID of the desired workflow. -1 is none, defaults to NULL (NULL: system default)
 * @param  boolean			Whether to remove any existing workflows from this content beforehand (current permissions must allow this)
 * @return ?AUTO_LINK		The content's ID in the workflow_content table. (NULL: if not added (eg. told to use default when there isn't one))
 */
function add_content_to_workflow($content_type='', $content_id='', $workflow_id=NULL, $remove_existing=false)
{
	//TODO: Remove existing entries, however that requires permissions
	// Garbage in requires garbage out
	if ($content_type=='' || $content_id=='')
	{
		// Bail out
		fatal_exit(do_lang_tempcode('_MISSING_RESOURCE', get_translated_text($workflow_id)));
	}

	// Have we been given a valid workflow to use?
	if (!is_null($workflow_id))
	{
		$valid_workflow=false;		// The caller is guilty of providing false details until proven innocent
		// Look through the distict workflows...
		foreach ($GLOBALS['SITE_DB']->query('SELECT DISTINCT workflow_name FROM '.get_table_prefix().'workflow_requirements') as $a_workflow)
		{
			// ...and see if this one is us
			if ($a_workflow['workflow_name']==$workflow_id)
			{
				$valid_workflow=true;
			}
		}
		// Bail out if we couldn't find the specified workflow
		if (!$valid_workflow)
		{
			warn_exit(do_lang_tempcode('_MISSING_RESOURCE', get_translated_text($workflow_id)));
		}
		// Don't need this anymore
		unset($valid_workflow);
	}
	// Otherwise use the system default
	else
	{
		$default_workflow=get_default_workflow();
		if (is_null($default_workflow))
		{
			// No default, so don't apply any
			return NULL;
		}
		else
		{
			$workflow_id=$default_workflow;
		}
	}

	// Now we know the workflow is OK, what about the content?
	// Look through the content-meta-aware hooks to find it.
	// We don't need to worry too much about multiple hooks with this
	// name, since we're calling the filesystem and if there are multiple
	// files with the same path then we've got bigger problems to worry
	// about!
	$hooks=find_all_hooks('systems','content_meta_aware');
	$found=false;		// Guilty until proven innocent again
	foreach (array_keys($hooks) as $hook)
	{
		// Skip if this is not the hook we're after
		if ($hook != $content_type) continue;

		// Otherwise load and instantiate the hook
		require_code('hooks/systems/content_meta_aware/'.filter_naughty_harsh($hook));
		$ob=object_factory('Hook_content_meta_aware_'.filter_naughty_harsh($hook),true);
		if (is_null($ob)) continue;		// Bail out if the hook fails

		// Grab information about the hook
		$info=$ob->info();
		$content_table=$info['table'];
		$content_field=$info['id_field'];
		if ($info['id_field_numeric'])		// See if we need to extract a number from the provided ID string
		{
			// If so then flag it with a shorter name, and use a different
			// name for the converted ID (ocPortal avoids dynamic typing)
			$numeric=true;
			$numeric_id=intval($content_id);		// Errors arise from passing an object, but should be noticed by type checker
		}
		else
		{
			// Otherwise set the flag as false. We've already got a string.
			$numeric=false;
		}
	}

	// Now we have the information required to access the content.
	// However, we still don't know if the provided ID is valid, so we
	// have to check that too!
	// Need different paths based on ID type, to prevent breaking strict
	// databases
	if ($numeric)
	{
		// Query the database for content matching the found parameters
		if ($GLOBALS['SITE_DB']->query_select($content_table,array($content_field),array($content_field=>$numeric_id),'',1)==array())
		{
			// This content doesn't exist, bail out
			warn_exit(do_lang_tempcode('_MISSING_RESOURCE', escape_html($content_table.'/'.$content_field.'/'.$content_id)));
		}
	}
	else
	{
		// Query the database for content matching the found parameters
		if ($GLOBALS['SITE_DB']->query_select($content_table,array($content_field),array($content_field=>$content_id),'',1)==array())
		{
			// This content doesn't exist, bail out
			warn_exit(do_lang_tempcode('_MISSING_RESOURCE', get_translated_text($workflow_id)));
		}
	}

	// If we've made it this far then we have been asked to apply a
	// valid workflow to a valid piece of content, so let's go ahead

	// Remove existing associations if we've been asked to
	if ($remove_existing)
	{
		$wf=get_workflow_of_content($content_type, $content_id);
		if (!is_null($wf))
		{
			$workflow_content_id=array_map('current',$GLOBALS['SITE_DB']->query_select('workflow_content',array('id'),array('source_type'=>$content_type, 'source_id'=>$content_id)));
			foreach ($workflow_content_id as $this_id)
			{
				$GLOBALS['SITE_DB']->query_delete('workflow_content',array('id'=>$this_id));
				$GLOBALS['SITE_DB']->query_delete('workflow_content_status',array('workflow_content_id'=>$this_id));
			}
		}
	}
	$id=$GLOBALS['SITE_DB']->query_insert('workflow_content',array('source_type'=>$content_type,'source_id'=>$content_id,'workflow_name'=>$workflow_id,'notes'=>'','original_submitter'=>get_member()),true,false,false);

	// Set the workflow status to 0 for each point
	foreach (get_requirements_for_workflow($workflow_id) as $point)
	{
		$GLOBALS['SITE_DB']->query_insert('workflow_content_status',array('workflow_content_id'=>$id,'workflow_approval_name'=>$point,'status_code'=>0,'approved_by'=>get_member()),true,false,false);
	}

	return $id;
}

/**
 * Give the specified workflow a new requirement. If you need to invent
 * a new requirement that's not been used before then just add its name
 * to the translation table via the 'insert_lang' function and use the
 * returned ID as that requirement's ID from then on.
 * Note: The workflow must already exist with at least one requirement.
 * See the 'build_new_workflow' function to define a new workflow.
 * Note: If passing a requirement already in the given workflow, its
 * position will be updated to the new value (or the end if not specified).
 * NOTE: Positions do not need to be contiguous, as long as they are in
 * an order. For example, requirements at positions 12, 34 and 852 will
 * behave the same way as requirements at positions 1, 2 and 3 (except
 * when adding requirements at defined positions of course, since
 * position 4 will appear at the start of the former list but at the end
 * of the latter)
 *
 * @param  AUTO_LINK		The ID of the requirement
 * @param  AUTO_LINK		The ID of the workflow to add this requirement to
 * @param  ?integer		The position in the workflow that this requirement will have. NULL adds it to the end (NULL: default)
 */
function add_requirement_to_workflow($requirement_id,$workflow_id,$position=NULL)
{
	// Check we've not been given garbage. If so then bail out.
	if (is_null($requirement_id))
	{	
		fatal_exit(do_lang_tempcode('_MISSING_RESOURCE', 'NULL requirement'));
	}
	if (is_null($workflow_id))
	{
		fatal_exit(do_lang_tempcode('_MISSING_RESOURCE', 'NULL workflow'));
	}

	// Make sure this workflow exists
	if ($GLOBALS['SITE_DB']->query_select('workflow_requirements',array('workflow_name'),array('workflow_name'=>$workflow_id),'',1)==array())
	{
		// If not then give a warning and exit
		warn_exit(do_lang_tempcode('_MISSING_RESOURCE', get_translated_text($workflow_id)));
	}

	// If this requirement is already in this workflow then we need to
	// update its position. However, it is easiest if we simply delete
	// the entry here, so that the following code will apply to all cases
	$GLOBALS['SITE_DB']->query_delete('workflow_requirements',array('workflow_name'=>$workflow_id,'workflow_approval_name'=>$requirement_id),'',1,NULL,true);

	// Now see what position we're adding to. We either need to determine
	// the next position (if we've been given NULL), or else just dump
	// the position in the record (we don't assume that positions are
	// unique in any case, points with the same position will appear
	// together but their specific order is undefined)
	if (is_null($position))
	{
		// The easy case, we simply grab the existing requirements in
		// order of position and +1 to the highest.
		$current_positions=$GLOBALS['SITE_DB']->query_select('workflow_requirements',array('the_position'),array('workflow_name'=>$workflow_id),'ORDER BY the_position DESC',1);
		$position=$current_positions[0]['the_position'] + 1;
	}

	// Do the insertion.
	// TODO: We should set the default appropriately here, since the case
	// of adding new requirements then removing the original requirements
	// would cause a workflow to lose its default status.
	$GLOBALS['SITE_DB']->query_insert('workflow_requirements',array('workflow_name'=>$workflow_id,'workflow_approval_name'=>$requirement_id,'the_position'=>$position,'is_default'=>0),true,false,false);
}

/**
 * Approves the given point for the given piece of content. The optional
 * user argument will be set as the approver (ie. the one to blame if
 * this approval is in error) , otherwise the current user will be set.
 *
 * @param  AUTO_LINK		The *workflow content* ID (NOT the gallery, category, etc. ID!)
 * @param  AUTO_LINK		The approval point name (translation table ID)
 * @param  ?MEMBER		The user ID to use as the approver, (NULL: for current user)
 */
function approve_content_for_point($content_id,$approval_name,$user=NULL)
{
	// TODO: Add some sanity checks here
	// Grab the current user if we've not been given one
	if (is_null($user)) $user=get_member();

	// Grab the current status of this point, firstly to see if we need
	// to set it at all, but more importantly to make sure that the given
	// parameters make sense and are valid
	$status=$GLOBALS['SITE_DB']->query_select('workflow_content_status',array('status_code'),array('workflow_content_id'=>$content_id,'workflow_approval_name'=>$approval_name),'',1);

	// Now approve the point if needed
	if ($status['status_code']==0)
	{
		$GLOBALS['SITE_DB']->query_update('workflow_content_status',array('status_code'=>1),array('workflow_content_id'=>$content_id,'workflow_approval_name'=>$approval_name),'',1);
	}

	// Done
}

/**
 * Add a new workflow to the system. The workflow needs at least one
 * requirement, which you should put in the $requirements array passed
 * as the second argument. The indices of this array must be natural
 * numbers, since they will indicate the position of this requirement in
 * the workflow. The requirements themselves are simply integers which
 * map to language strings containing the requirement name. They can be
 * made up arbitrarily before passing to this function by calling
 * insert_lang('requirement_name').
 *
 * @param  ?AUTO_LINK	The ID of this workflow, if you've already inserted the language string. (NULL: If not already inserted).
 * @param  string			The string to use as this requirement's name in the current language
 * @param  array			A mapping from workflow position to workflow requirement (language string lookup integer)
 * @param  boolean		Whether to make this workflow the default workflow (default value is false)
 * @return AUTO_LINK		The workflow's ID (language string lookup integer)
 */
function build_new_workflow($id, $name, $requirements, $default=false)
{
	// First let's get a unique ID for this workflow if it has none
	if (is_null($id))
	{
		// HACKHACK We should use a normalised table with an ID field
		$id=insert_lang($name,3);
	}
	// Remove any existing requirements just in case this workflow already exists
	$GLOBALS['SITE_DB']->query_delete('workflow_requirements',array('workflow_name'=>$id));

	// Now add each requirement to this workflow; as a side-effect this will
	// give the workflow a presence in the database
	foreach ($requirements as $position=>$requirement)
	{
		// Set default to 0 to start with
		$GLOBALS['SITE_DB']->query_insert('workflow_requirements',array('workflow_name'=>$id,'workflow_approval_name'=>$requirement,'the_position'=>$position,'is_default'=>0),true,false,false);
	}
	// Now see if we're to be the default
	if ($default)
	{
		// If so then set all defaults to 0 (which is why we didn't bother
		// setting it upon insertion)
		$GLOBALS['SITE_DB']->query_update('workflow_requirements',array('is_default'=>0));
		// Now set our defaults to 1
		$GLOBALS['SITE_DB']->query_update('workflow_requirements',array('is_default'=>1),array('workflow_name'=>$id));
	}
	// And we're done!
	return $id;
}

/**
 * Deleting a workflow will remove the workflow, leaving the validated/
 * unvalidated system to handle content, ie. content which has passed
 * completely through the workflow will have its validated bit set and
 * will thus remain live. Those not completely through will not have
 * theirs set yet and will thus remain unvalidated and not live.
 * NOTE: Approval points can be reused, so they will stay behind.
 *
 * @param  AUTO_LINK		The ID of the workflow to delete
 */
function delete_workflow($id)
{
	// Grab all of the content in this workflow
	$content=$GLOBALS['SITE_DB']->query_select('workflow_content',array('id','source_type','source_id'),array('workflow_name'=>$id));

	// Now remove those references
	$GLOBALS['SITE_DB']->query_delete('workflow_content',array('workflow_name'=>$id));

	// Then remove their workflow status
	foreach ($content as $content_item)
	{
		$GLOBALS['SITE_DB']->query_delete('workflow_content_status',array('workflow_content_id'=>$content_item['id']));
	}

	// Grab the approval points in this workflow and remove those which aren't
	// used by any other workflows
	$points=array_map('current',$GLOBALS['SITE_DB']->query_select('workflow_requirements',array('workflow_approval_name'),array('workflow_name'=>$id)));
	foreach ($points as $p)
	{
		if (count(
			array_unique(
				array_map('current',$GLOBALS['SITE_DB']->query_select('workflow_requirements',array('workflow_name'),array('workflow_approval_name'=>$p)))
			)
		)==1)
		{
			// This approval point is only in one workflow (ie. this one) so remove
			// it from the permissions table
			$GLOBALS['SITE_DB']->query_delete('workflow_permissions',array('workflow_approval_name'=>$p));
		}
	}

	// Now remove the workflow from the database (ie. remove its association with
	// approval points)
	$GLOBALS['SITE_DB']->query_delete('workflow_requirements',array('workflow_name'=>$id));
}

/**
 * Deleting an approval point will remove it from any workflow it is a
 * part of. Any content which has been approved for this requirement
 * will be unaffected, whilst those not-yet-approved will first be
 * approved, then have the requirement removed. This is to prevent any
 * content asking to be approved on a point which doesn't exist.
 *
 * @param  AUTO_LINK		The workflow approval point name (translation table ID)
 */
function delete_approval_point($name)
{
	// Grab all content awaiting this approval
	$content=$GLOBALS['SITE_DB']->query_select('workflow_content_status', array('status_code','workflow_content_id'),array('workflow_approval_name'=>$name));

	// Now go through each, approving them if needed
	foreach ($content as $content_item)
	{
		// 0 means unapproved
		if ($content['status_code']==0)
		{
			// Set the approval
			approve_content_for_point($content['workflow_content_id'], $name);
		}
	}
	// Now remove these requirements en-mass from the content
	$GLOBALS['SITE_DB']->query_delete('workflow_content_status',array('workflow_content_id'=>$name));

	// We have to be careful about removing requirements from workflows,
	// since a workflow is defined by the approval points it requires.
	// We must check to see if we're about to throw out any workflows as
	// a result of removing this point. If so then we'd like to remove
	// the workflow sanely and completely.
	$affected_workflows=$GLOBALS['SITE_DB']->query_select('workflow_requirements', array('workflow_name'), array('workflow_approval_name'=>$name));
	foreach ($affected_workflows as $workflow)
	{
		// If there is only one requirement then it's the one we've been
		// asked to remove. Let's just remove the whole workflow.
		if (count(get_requirements_for_workflow($workflow['workflow_name']))==1)
		{
			delete_workflow($workflow['workflow_name']);
		}
		// Otherwise we can just remove this one point
		else
		{
			$GLOBALS['SITE_DB']->query_delete('workflow_requirements',array('workflow_approval_name'=>$name, 'workflow_name'=>$workflow['workflow_name']),'',1);
		}
	}

	// Now we remove the permissions associated with this approval point
	$GLOBALS['SITE_DB']->query_delete('workflow_permissions', array('workflow_approval_name'=>$name));
}

/**
 * Returns all of the workflows which are currently defined.
 *
 * @return array		The workflows which are defined. Empty if none are defined.
 */
function get_all_workflows()
{
	$workflows=array_map('current',$GLOBALS['SITE_DB']->query('SELECT DISTINCT workflow_name FROM '.get_table_prefix().'workflow_requirements'));
	$output=array();
	foreach ($workflows as $w)
	{
		$output[$w]=get_translated_text($w);
	}
	return $output;
}

/**
 * Returns all of the approval point which are currently defined. Indices are
 * IDs, values are names.
 *
 * @return array		The approval points which are defined. Empty if none are defined.
 */
function get_all_approval_points()
{
	$points=array_map('current',$GLOBALS['SITE_DB']->query('SELECT DISTINCT workflow_approval_name FROM '.get_table_prefix().'workflow_requirements'));
	$points=array_unique(array_merge($points,array_map('current',$GLOBALS['SITE_DB']->query('SELECT DISTINCT workflow_approval_name FROM '.get_table_prefix().'workflow_permissions'))));
	$output=array();
	foreach ($points as $p)
	{
		$output[$p]=get_translated_text($p);
	}
	return $output;
}

/**
 * Get the system's default workflow. If there is only one workflow this
 * will return it, otherwise (multiple with no default specified, or no
 * workflows at all) it will give NULL.
 *
 * @return ?AUTO_LINK		The ID of the default workflow. (NULL: if none set)
 */
function get_default_workflow()
{
	// Grab every workflow ID
	$workflows=get_all_workflows();
	// Only bother doing anything more complicated if we've got multiple
	// workflows to dig through
	if (count($workflows)>1)
	{
		// Look for those which are set as default
		$defaults=$GLOBALS['SITE_DB']->query('SELECT DISTINCT workflow_name FROM '.get_table_prefix().'workflow_requirements WHERE is_default=1');
		// If there aren't any then we can't presume to know which should
		// be returned, so return an empty array
		if ($defaults==array())
		{
			return NULL;
		}
		// Likewise we cannot choose between multiple defaults, so return
		// an empty array
		elseif (count($defaults) > 1)
		{
			return NULL;
		}
		// If we're here then we have one default, so return it
		return current(current($defaults));
	}
	// Otherwise just give back what we've found (singleton or empty)
	elseif (count($workflows)==1)
	{
		return current(array_keys($workflows));
	}
	else
	{
		return NULL;
	}
}

/**
 * Get the workflow content ID for the given piece of content.
 *
 * @param  string		The type of the source (eg. download, gallery, etc.)
 * @param  string		The ID of the specific piece of content (if numeric, pass as a string anyway)
 * @return AUTO_LINK	The workflow_content_id
 */
function get_workflow_content_id($source_type,$source_id)
{
	// Grab the specified content's ID
	$content=$GLOBALS['SITE_DB']->query_select('workflow_content',array('id'),array('source_type'=>$source_type,'source_id'=>$source_id),'',1);
	if ($content==array())
	{
		return NULL;
	}
	return $content[0]['id'];
}

/**
 * Gets an array of the approval point IDs required by the given
 * workflow ID
 *
 * @param  AUTO_LINK		The ID of the workflow
 * @return array			The IDs of the approval points for the workflow, in workflow order
 */
function get_requirements_for_workflow($workflow_id)
{
	// Make sure we have something to work with
	if (is_null($workflow_id))
	{
		warn_exit(do_lang_tempcode('_MISSING_RESOURCE', 'NULL workflow'));
	}
	// Now grab each point along with its position
	$approval_points=$GLOBALS['SITE_DB']->query_select('workflow_requirements',array('workflow_approval_name'),array('workflow_name'=>$workflow_id),'ORDER BY the_position ASC');
	$raw_names=array();		// This will store the points in order
	// Fill the $raw_names array
	foreach ($approval_points as $point)
	{
		$raw_names[]=$point['workflow_approval_name'];
	}
	return $raw_names;
}

/**
 * Gets the position of the given requirement in the given workflow.
 *
 * @param  AUTO_LINK		The ID of the approval point
 * @param  AUTO_LINK		The ID of the workflow
 * @return ?integer		The position of the approval point in this case (NULL: if not found)
 */
function get_requirement_position($requirement_id, $workflow_id)
{
	$found=$GLOBALS['SITE_DB']->query_select('workflow_requirements',array('the_position'),array('workflow_name'=>$workflow_id,'workflow_approval_name'=>$requirement_id),'ORDER BY the_position ASC');
	if ($found==array())
	{
		return NULL;
	}
	else
	{
		return $found[0]['the_position'];
	}
}

/**
 * Gets an array of the group IDs allowed to approve the given point
 *
 * @param  AUTO_LINK		The ID of the approval point
 * @param  boolean		Should we only return groups which are validated? (default: true)
 * @return array			The IDs of the groups allowed to signoff on it
 */
function get_groups_for_point($approval_id,$only_validated=true)
{
	// TODO: Implement $only_validated

	if (is_null($approval_id))
	{
		warn_exit(do_lang_tempcode('_MISSING_RESOURCE', 'NULL approval'));
	}
	$groups=$GLOBALS['SITE_DB']->query_select('workflow_permissions',array('usergroup'),array('workflow_approval_name'=>$approval_id));
	$raw_names=array();
	foreach ($groups as $group)
	{
		$raw_names[]=$group['usergroup'];
	}
	return $raw_names;
}

/**
 * Find out who submitted a piece of content from a workflow.
 *
 * @param  AUTO_LINK		The workflow content ID
 * @return ?MEMBER		The submitter (NULL: if unknown)
 */
function get_submitter_of_workflow_content($content_id)
{
	// Exit on misuse
	if (is_null($content_id))
	{
		warn_exit(do_lang_tempcode('MISSING_RESOURCE'));
	}
	// Find out the author straight from the workflow_content table
	$submitter=$GLOBALS['SITE_DB']->query_select('workflow_content',array('original_submitter'),array('id'=>$content_id));
	if ($submitter==array())
	{
		// Exit if we can't find the given resource
		warn_exit(do_lang_tempcode('_MISSING_RESOURCE','workflow_content->'.strval($content_id)));
	}
	// Now extract the submitter (if there is one)
	return $submitter[0]['original_submitter'];
}

/**
 * Get the tempcode for viewing/editing the workflow status of the given content
 *
 * @param  AUTO_LINK	The ID of this content in the workflow_content table
 * @return tempcode	The form for this content
 */
function get_workflow_form($workflow_content_id)
{
	// Load our prerequisites
	require_lang('workflows');
	require_code('form_templates');
	require_code('users');

	// Do not let guests edit the status of content
	if (is_guest())
	{
		return new ocp_tempcode();
	}

	//////////////////////////////////////////////////
	// Gather the details we need to build the form //
	//////////////////////////////////////////////////

	// These will hold the form code
	$workflow_form=new ocp_tempcode();
	$workflow_fields=new ocp_tempcode();
	$workflow_hidden=new ocp_tempcode();

	// We already know the content ID
	$workflow_hidden->attach(form_input_hidden('content_id',strval($workflow_content_id)));

	// Check if this is a valid piece of content for a workflow
	$row=$GLOBALS['SITE_DB']->query_select('workflow_content',array('*'),array('id'=>$workflow_content_id),'',1);
	if (count($row)==0)
	{
		warn_exit(do_lang_tempcode('_MISSING_RESOURCE', get_translated_text($workflow_content_id)));
	}

	$row=array_pop($row);

	// If so then find the workflow name for it
	$relevant_workflow=$row['workflow_name'];

	$workflow_hidden->attach(form_input_hidden('workflow_id',strval($relevant_workflow)));

	// Make sure there are some points to approve
	$approval_points=get_requirements_for_workflow($relevant_workflow);
	if ($approval_points==array())
	{
		warn_exit(do_lang_tempcode('_MISSING_RESOURCE', get_translated_text($workflow_content_id)));
	}

	/////////////////////////
	// Approval tick boxes //
	/////////////////////////

	$available_groups=$GLOBALS['FORUM_DRIVER']->get_members_groups(get_member());		// What groups our user is in
	$existing_status=array();		// This shows the current approval status, but is not editable
	$approval_status=array();		// This holds tick-boxes for editing the approval status
	$send_next=array();		// This holds the details for who to send this to next
	$approve_count=0;		// This keeps each approval box distinct
	$send_count=0;		// This keeps the 'send next' boxes distinct
	$groups_shown=array();		// This keeps track of the groups we've already shown
	$group_names=$GLOBALS['FORUM_DRIVER']->get_usergroup_list();		// Allows us to find readable group names
	$permission_limit=false;		// Points are added in order, so take notice when we no longer have permission (so we can send to whoever does)
	$next_point=NULL;		// This will store the next workflow point for which we don't have the permission to approve

	// Get the status of each point
	$statuses=array();
	foreach ($GLOBALS['SITE_DB']->query_select('workflow_content_status',array('workflow_approval_name', 'status_code'),array('workflow_content_id'=>$workflow_content_id)) as $stat)
	{
		$statuses[$stat['workflow_approval_name']]=$stat['status_code'];
	}

	// Assume we can't do anything
	$have_permission_over_a_point=false;

	// Now loop through all approval points in workflow order	
	foreach ($approval_points as $point)
	{
		// Only show one tick box for each approval point, if any
		$approval_shown=false;

		// Go through each group allowed to modify this value...
		foreach (get_groups_for_point($point) as $allowed_group)
		{
			// ... and check whether the user is in it
			if (!$approval_shown && in_array($allowed_group, $available_groups))
			{
				// If so then remember that we've handled this point
				$approval_shown=true;

				// Remember that we can tick something
				$have_permission_over_a_point=true;

				// Add the details to the editable tick-box values
				$approval_status[$approve_count]=array();
				$approval_status[$approve_count][]=get_translated_text($point);		// Pretty name
				$approval_status[$approve_count][]='approval_'.strval($point);		// Name
				$approval_status[$approve_count][]=array_key_exists($point,$statuses)? $statuses[$point] : 0;		// The value (defaults to 0)
				$approval_status[$approve_count][]=do_lang_tempcode('APPROVAL_TICK_DESCRIPTION',get_translated_text($point));		// Description
				$approval_status[$approve_count][]=false;		// Not disabled, since we have permission

				// Add the details to the uneditable, existing status values
				$existing_status[$approve_count]=array();
				$existing_status[$approve_count][]=get_translated_text($point);		// Pretty name
				$existing_status[$approve_count][]='existing_'.strval($point);		// Name
				if (array_key_exists($point,$statuses) && ($statuses[$point]==1))
				{
					$existing_status[$approve_count][]=1;		// The value (1 due to our if condition)
					$existing_status[$approve_count][]=do_lang_tempcode('ALREADY_APPROVED',get_translated_text($point));		// Description
				}
				else
				{
					$existing_status[$approve_count][]=0;		// The value defaults to 0
					$existing_status[$approve_count][]=do_lang_tempcode('NOT_YET_APPROVED',get_translated_text($point));		// Description
				}
				$existing_status[$approve_count][]=true;		// Disabled, since this is for informative purposes only

				// Increment the unique ID for the array elements
				$approve_count=$approve_count + 1;
			}

			// We want the send boxes to name usergroups, rather than
			// approval points, so we may as well add those here.
			// Take care not to add groups we've already got!
			if (!in_array($allowed_group,$groups_shown))
			{
				$send_next[$allowed_group]=array();
				$send_next[$allowed_group][]=$group_names[$allowed_group];		// Pretty name
				$send_next[$allowed_group][]='send_'.strval($allowed_group);		// Name
				// Set the default value. We want groups allowed to approve the
				// next+1 point ticked (assuming we're approving the next one)
				// For simplicity, let's keep these unticked for now.
				//if (in_array($allowed_group['usergroup'],$groups_shown))
				//{
					$send_next[$allowed_group][]=false;
				//}
				$send_next[$allowed_group][]=do_lang_tempcode('NEXT_APPROVAL_DESCRIPTION',$group_names[$allowed_group]);		// Description
				$groups_shown[]=$allowed_group;
			}
		}

		// If it's not handled at this point, we don't have permission
		if (!$approval_shown)
		{
			// Thus we should show a disabled check box
			$existing_status[$approve_count]=array();
			$existing_status[$approve_count][]=get_translated_text($point);		// Pretty name
			$existing_status[$approve_count][]='approval_'.strval($point);		// Name
			$existing_status[$approve_count][]=array_key_exists($point,$statuses)? $statuses[$point] : 0;		// Value (defaults to 0)
			$existing_status[$approve_count][]=do_lang_tempcode('APPROVAL_TICK_DESCRIPTION',get_translated_text($point));		// Description
			$existing_status[$approve_count][]=true;		// Disabled, we have no permission
			// Increment the unique ID for the array elements
			$approve_count=$approve_count + 1;

			// If this is the first entry we're not permitted to change and
			// it is not already ticked...
			if (!$permission_limit && (!array_key_exists($point,$statuses) || ($statuses[$point]==0)))
			{
				// ... remember it (since we can send-to those who are
				// permitted)
				$next_point=$point;
				$permission_limit=true;
			}
		}

	}

	// If we have no control over this workflow then don't bother showing it
	if (!$have_permission_over_a_point)
	{
		return new ocp_tempcode();
	}

	///////////////////
	// Send-to boxes //
	///////////////////

	// Now we attempt to impose some sort of order to the send-to boxes.
	// The order we're going to use is to collect groups where the sum of
	// the workflow positions they can approve is equal, and put the
	// collections in ascending order. The collections are ordered based
	// on the group's average workflow approval position. Any further
	// ambiguity is not worth considering.
	$group_scores=array();		// Track the sum of positions for each group
	$group_counts=array();		// Track the number of points each group can approve (so we can calculate the average)
	$active_groups=array();		// Note which groups have permission to approve the next workflow point we can't do ourselves
	// Get all of the approval points and all of the groups
	foreach ($approval_points as $point)
	{
		foreach (get_groups_for_point($point) as $group)
		{
			// See whether this group should be active
			if ($next_point==$point)
			{
				$active_groups[]=$group;
			}
			// Add on the point's position to this group's score
			if (array_key_exists($group, $group_scores))
			{
				$group_scores[$group]=$group_scores[$group] + get_requirement_position($point, $relevant_workflow);
			}
			// Otherwise give it a new score equal to this point's position
			else
			{
				$group_scores[$group]=get_requirement_position($point, $relevant_workflow);
			}
			// Now increment the group's approval point count
			if (array_key_exists($group, $group_counts))
			{
				$group_counts[$group]=$group_counts[$group] + 1;
			}
			else
			{
				$group_counts[$group]=1;
			}
		}
	}
	// Now we can order the groups:
	$group_order=array();		// This will store collections of groups in order of score
	foreach ($group_scores as $group_id=>$score)
	{
		// Make a new collection if we've not got one
		if (!array_key_exists($score,$group_order))
		{
			$group_order[$score]=array();
		}
		// Add this group to the collection
		$group_order[$score][]=$group_id;
	}

	// Finally we can get the tick-box details we found earlier and put
	// them in the right order
	$send_to_boxes=array();
	foreach ($group_order as $score=>$collection)
	{
		// Add the group if its the only one
		if (count($collection)==1)
		{
			// Before adding the tick box, see if it should be active
			if (in_array($collection[0],$active_groups))
			{
				$send_next[$collection[0]][2]=1;
			}
			$send_to_boxes[]=$send_next[$collection[0]];
		}
		else
		{
			// Otherwise order the collection first
			$collection_order=array();
			foreach ($collection as $group_id)
			{
				// Work out the average position of each group's approval
				// points (we need an int for use as an index, but add a
				// couple of orders of magnitude to give us 2 more sig figs)
				$group_average=intval((floatval($score) / floatval($group_counts[$group_id]))*100);
				// Make a new collection if we've not got one
				if (!array_key_exists($group_average,$collection_order))
				{
					$collection_order[$group_average]=array();
				}
				// Add this group to the average collection
				$collection_order[$group_average][]=$group_id;
			}
			// Now we can add them in order of average
			foreach ($collection_order as $average_collection)
			{
				foreach ($average_collection as $group_id)
				{
					// Before adding the tick box, see if it should be active
					if (in_array($group_id,$active_groups))
					{
						$send_next[$group_id][2]=1;
					}
					$send_to_boxes[]=$send_next[$group_id];
				}
			}
		}
	}

	// Now tack the original submitter onto the end of the send-to list,
	// if we know who it is
	$submitter=get_submitter_of_workflow_content($workflow_content_id);
	if (!is_null($submitter))
	{
		$submitter_details=array();		// Build the array independently
		$submitter_details[]=$GLOBALS['FORUM_DRIVER']->get_username($submitter).' ('.do_lang('SUBMITTER').')';
		$submitter_details[]='send_author';		// Name
		$submitter_details[]=false;		// Value
		$submitter_details[]=do_lang_tempcode('NEXT_APPROVAL_AUTHOR',$GLOBALS['FORUM_DRIVER']->get_username($submitter));		// Description
		$send_to_boxes[]=$submitter_details;		// Then tack it on the end
	}

	/* NOTE: Not currently used; content becomes live once all points are
	 * approved
	///////////////////
	// Live tick-box //
	///////////////////
	// The 'Live' tickbox is just the regular 'validated' box with a thin
	// veneer of approval logic. It should only be enabled if we have
	// permission over all approval points (ie. there is no 'next' point)
	if (is_null($next_point))
	{
		$live_box=form_input_tick(do_lang_tempcode('WORKFLOW_LIVE'),do_lang_tempcode('WORKFLOW_LIVE_DESCRIPTION'),'validated',$validated,NULL,'1',false);
	}
	else
	{
		$live_box=form_input_tick(do_lang_tempcode('WORKFLOW_LIVE'),do_lang_tempcode('WORKFLOW_LIVE_DESCRIPTION'),'validated',$validated,NULL,'1',true);
	}			
	*/

	////////////////////////
	// Now build the form //
	////////////////////////

	// Bail out if there's nothing to the workflow
	if ($approval_status==array())
	{
		return new ocp_tempcode();
	}

	// Attach the title to the form first, along with usage info
	$workflow_fields->attach(do_template('FORM_SCREEN_FIELD_SPACER',array('TITLE'=>NULL,'HELP'=>do_lang_tempcode('WORKFLOW_USAGE'))));

	// Show the current status next
	$workflow_fields->attach(form_input_various_ticks($existing_status,'',NULL,do_lang_tempcode('CURRENT_APPROVAL_STATUS'),false));

	// Attach the workflow tick boxes next
	$workflow_fields->attach(form_input_various_ticks($approval_status,'',NULL,do_lang_tempcode('POINTS_TO_APPROVE'),false));

	// Add the 'live' tickbox
	// NOTE: Not used at the moment; content becomes live once all points
	// have been approved
	//$workflow_fields->attach($live_box);

	// Add a section for notes
	$notes=$GLOBALS['SITE_DB']->query_select('workflow_content',array('notes'),array('id'=>$workflow_content_id));
	$workflow_fields->attach(form_input_huge(do_lang('NOTES'),do_lang('WORKFLOW_NOTES_DESCRIPTION'),'workflow_notes',$notes[0]['notes'],false,NULL,6,'',true));

	// Set who to send it to next
	$workflow_fields->attach(form_input_various_ticks($send_to_boxes,do_lang_tempcode('NEXT_APPROVAL_SIDE_DESCRIPTION'),NULL,do_lang_tempcode('NEXT_APPROVAL'),false));

	// Set the URL for handling the response to this form
	$post_url=build_url(array('page'=>'_SELF','type'=>'workflow'),'_SELF');

	// Set the URL to return to after the handling has taken place
	$workflow_hidden->attach(form_input_hidden('return_url',get_self_url(true)));

	// Add all of these to the form
	$workflow_form->attach(do_template('FORM',array('_GUID'=>'9eb9a74add2b4fea737d0af7b65a2d85','FIELDS'=>$workflow_fields,'HIDDEN'=>$workflow_hidden,'TEXT'=>'','URL'=>$post_url,'SUBMIT_NAME'=>do_lang_tempcode('SUBMIT_WORKFLOW_CHANGES'),'SKIP_REQUIRED'=>true)));

	// Then pass it to whoever wanted it
	return do_template('WORKFLOW_BOX',array('_GUID'=>'cc80db735825a058c0d90e40e783ed30','FORM'=>$workflow_form));
}

/**
 * Handler for workflow form submission.
 *
 * @return tempcode		Either an error page or a success message
 */
function workflow_update_handler()
{
	require_lang('workflows');
	require_code('database');
	$success_message=do_lang('APPROVAL_UNCHANGED');

	/////////////////////////////////////////
	// Grab everything we need from $_POST //
	/////////////////////////////////////////

	$workflow_id=post_param('workflow_id');
	$content_id=post_param('content_id');
	$workflow_notes=post_param('workflow_notes');

	// Find out which approvals have been given
	$approvals=array();
	foreach (get_requirements_for_workflow(post_param('workflow_id')) as $approval_id)
	{
		// We might not have a value for this point, since we may not have given a tick box for it
		if (array_key_exists('approval_'.strval($approval_id),$_POST))
		{
			$approvals[$approval_id]=post_param_integer('approval_'.strval($approval_id));
		}
		// Unticked boxes don't seem to appear in $_POST, so get the
		// raw tickbox value instead
		elseif (array_key_exists('tick_on_form__approval_'.strval($approval_id),$_POST))
		{
			$approvals[$approval_id]=post_param_integer('tick_on_form__approval_'.strval($approval_id));
		}
	}

	////////////////////////
	// Get member details //
	////////////////////////

	// Find out which groups/members to inform, starting with the
	// original submitter
	$send_to_members=array();
	if (array_key_exists('send_author',$_POST))
	{
		if (post_param_integer('send_author')==1)
		{
			$submitter=get_submitter_of_workflow_content($content_id);
			if (!is_null($submitter))
			{
				$send_to_members[$submitter]=1;
			}
		}
	}

	// Now get the groups
	$group_ids=array();		// Only remember 1 copy of each group
	foreach (get_requirements_for_workflow($workflow_id) as $requirement)
	{
		foreach (get_groups_for_point($requirement) as $group)
		{
			if (!in_array($group, $group_ids))
			{
				if (post_param_integer('send_'.strval($group),0)==1)
					$group_ids[]=$group;
			}
		}
	}

	// From the groups we can get the members, and from there the emails
	foreach ($GLOBALS['FORUM_DRIVER']->member_group_query($group_ids) as $member)		// FIXME: OCF-specific
	{
		$send_to_members[$member['id']]=1;
	}

	////////////////////////////////////////////
	// Now play with the database as required //
	////////////////////////////////////////////

	// See which values need updating (ie. approvals have been given/withdrawn)
	$updated_approvals=array();
	$all_approval_statuses=array();

	// Grab each point's status from the database
	$old_values=$GLOBALS['SITE_DB']->query_select('workflow_content_status',array('workflow_approval_name', 'status_code'),array('workflow_content_id'=>$content_id));

	$accounted_for_statuses=array();

	// Look for any differences we need to make
	foreach ($old_values as $old_value)
	{
		$noted=false;		// Keep a note of each value for including in emails
		// Only compare against values which we've been given
		if (array_key_exists($old_value['workflow_approval_name'],$approvals))
		{
			$accounted_for_statuses[]=$old_value['workflow_approval_name'];

			// See if the database entry is the same as the given status
			if ($old_value['status_code'] != $approvals[$old_value['workflow_approval_name']])
			{
				// If not then see if we have permission to change it
				$members_with_permission=array();
				foreach ($GLOBALS['FORUM_DRIVER']->member_group_query(get_groups_for_point($old_value['workflow_approval_name'])) as $permitted)
				{
					$members_with_permission[]=$permitted['id'];
				}
				if (in_array(get_member(), $members_with_permission))
				{
					// Remember that this needs to be changed
					$updated_approvals[$old_value['workflow_approval_name']]=$approvals[$old_value['workflow_approval_name']];
					// Make a note of this value in the array of all statuses
					$all_approval_statuses[$old_value['workflow_approval_name']]=$approvals[$old_value['workflow_approval_name']];
					$noted=true;
				}
			}
		}
		if (!$noted)
		{
			// If we're here then this status has either not been passed or
			// it does not need modifying. Either way we can grab a valid
			// status from the database.
			$all_approval_statuses[$old_value['workflow_approval_name']]=$old_value['status_code'];
		}
	}
	// Now add any unaccounted-for points to those which need updating
	$new_approvals=array();
	foreach (array_keys($approvals) as $a)
	{
		if (!in_array($a, $accounted_for_statuses))
		{
			$updated_approvals[$a]=$approvals[$a];
			$new_approvals[]=$a;
		}
	}
	// Now we know which fields to update, let's do so
	foreach ($updated_approvals as $approval_id=>$status_code)
	{
		$success_message=do_lang('APPROVAL_CHANGED_DESCRIPTION');
		if (in_array($approval_id,$new_approvals))
		{
			$GLOBALS['SITE_DB']->query_insert('workflow_content_status',array('status_code'=>$status_code,'approved_by'=>get_member(),'workflow_content_id'=>$content_id,'workflow_approval_name'=>$approval_id));
		}
		else
		{
			$GLOBALS['SITE_DB']->query_update('workflow_content_status',array('status_code'=>$status_code,'approved_by'=>get_member()),array('workflow_content_id'=>$content_id,'workflow_approval_name'=>$approval_id),'',1,NULL,false,false);
		}
	}

	// Update the notes (this is done destructively, but is simplest)
	// We append a timestamped log of the action taken
	$notes_approved=array();
	$notes_disapproved=array();
	foreach ($updated_approvals as $approval_id=>$status_code)
	{
		if ($status_code)
		{
			$notes_approved[]=$approval_id;
		}
		else
		{
			// Just because it's not approved, doesn't mean that it was unticked.
			// It may have just been added to the workflow.
			if (!in_array($approval_id,$new_approvals))
				$notes_disapproved[]=$approval_id;
		}
	}
	if (count($notes_approved)+count($notes_disapproved) > 0)
	{
		$note_title=date('Y-m-d H:i').' '.$GLOBALS['FORUM_DRIVER']->get_username(get_member());
		$workflow_notes=$workflow_notes."\n\n".$note_title."\n".str_repeat('-', strlen($note_title));

		$notes_approved=array_map('get_translated_text',$notes_approved);
		$notes_disapproved=array_map('get_translated_text',$notes_disapproved);
		if (count($notes_approved) > 0)
			$workflow_notes.="\n".do_lang('WORKFLOW_APPROVED').': '.implode(', ',$notes_approved);
		if (count($notes_disapproved) > 0)
			$workflow_notes.="\n".do_lang('WORKFLOW_DISAPPROVED').': '.implode(', ',$notes_disapproved);
	}
	$GLOBALS['SITE_DB']->query_update('workflow_content',array('notes'=>$workflow_notes),array('id'=>$content_id),'',1);

	/////////////////////////////
	// See if we're going live //
	/////////////////////////////

	// Validation is stored, for the most part, in a 'validated' field
	// of the content's table. Those which store it elsewhere must
	// specify this via their content-meta-aware info.

	// Grab lookup data from the workflows database
	$content_details=$GLOBALS['SITE_DB']->query_select('workflow_content',array('source_type', 'source_id'),array('id'=>$content_id),'',1);
	if ($content_details==array())
	{
		warn_exit(do_lang_tempcode('_MISSING_RESOURCE','workflow_content->'.strval($content_id)));
	}

	// Now use it to find this content's validation field
	$hooks=find_all_hooks('systems','content_meta_aware');
	$found=false;		// Guilty until proven innocent again
	foreach (array_keys($hooks) as $hook)
	{
		// Skip if this is not the hook we're after
		if ($hook != $content_details[0]['source_type']) continue;

		// Otherwise load and instantiate the hook
		require_code('hooks/systems/content_meta_aware/'.filter_naughty_harsh($hook));
		$ob=object_factory('Hook_content_meta_aware_'.filter_naughty_harsh($hook),true);
		if (is_null($ob)) continue;		// Bail out if the hook fails

		// Grab information about the hook
		$info=$ob->info();
		$content_table=$info['table'];
		$content_field=$info['id_field'];
		if (array_key_exists('validated_field',$info))
		{
			$content_validated_field=$info['validated_field'];
		}
		else
		{
			// Fall back to 'validated' if nothing is specified
			$content_validated_field='validated';
		}

		if ($info['id_field_numeric'])		// See if we need to extract a number from the provided ID string
		{
			// If so then flag it with a shorter name, and use a different
			// name for the converted ID (ocPortal avoids dynamic typing)
			$numeric=true;
			$numeric_id=intval($content_details[0]['source_id']);		// Errors arise from passing an object, but should be noticed by type checker
		}
		else
		{
			// Otherwise set the flag as false. We've already got a string.
			$numeric=false;
		}
	}

	// Now we have the details required to lookup this entry, wherever it
	// is. Let's get its current validation status and compare to what
	// the workflow would have it be
	if ($numeric)
	{
		$content_is_validated=$GLOBALS['SITE_DB']->query_select($content_table,array($content_validated_field),array($content_field=>$numeric_id),'',1);
	}
	else
	{
		$content_is_validated=$GLOBALS['SITE_DB']->query_select($content_table,array($content_validated_field),array($content_field=>$content_details[0]['source_id']),'',1);
	}
	// Make sure we've actually found something
	if ($content_is_validated==array())
	{
		$source_id=$content_details[0]['source_id'];
		$validated_field=$source_id->content_validated_field;
		warn_exit(do_lang_tempcode('_MISSING_RESOURCE',$content_table.'->'.$content_field.'->'.$validated_field));
	}
	// In order for content to go live all points must be approved
	// See if all points have been approved. If so, none will have
	// status 0
	$all_points_approved=false;
	if ($GLOBALS['SITE_DB']->query_select('workflow_content_status',array('workflow_approval_name'),array('workflow_content_id'=>$content_id,'status_code'=>0))==array())
	{
		$all_points_approved=true;
	}

	// We need to act if the validation status is different to the total
	// completion of the workflow
	if (($content_is_validated[0][$content_validated_field]==1)!=$all_points_approved)
	{
		$success_message=$all_points_approved? do_lang('APPROVAL_COMPLETE') : do_lang('APPROVAL_REVOKED');
		$GLOBALS['SITE_DB']->query_update($content_table,array($content_validated_field=>$all_points_approved?1:0),array($content_field=>$content_details[0]['source_id']),'',1);
	}

	///////////////////////////////////////////
	// Now inform members about this content //
	///////////////////////////////////////////
	// Make a nicely formatted list of the statuses
	$status_list='';
	foreach ($all_approval_statuses as $point=>$status)
	{
		$status_list.=get_translated_text($point).': ';
		$status_list.=($status==1)?'approved':'not approved';
		$status_list.=', ';
	}

	// At last we can send the email
	require_code('notifications');
	if (count($send_to_members) > 0)
	{
		$success_message.=do_lang('APPROVAL_CHANGED_NOTIFICATIONS');
	}
	//require_code('developer_tools');
	//inspect($emails);
	$subject=do_lang('APPROVAL_EMAIL_SUBJECT',/*TODO: Should pass title in, for unique email subject line*/NULL,NULL,NULL,get_site_default_lang());
	$body=do_lang('APPROVAL_EMAIL_BODY',post_param('http_referer',ocp_srv('HTTP_REFERER')),$status_list,$workflow_notes,get_site_default_lang());
	dispatch_notification('workflow_step',NULL/*strval($workflow_id)*/,$subject,$body,$send_to_members);

	// Finally return a success message
	$return_url=strip_tags(post_param('return_url'));
	return redirect_screen(new ocp_tempcode(),$return_url,$success_message);

}

/**
 * Returns a form field to choose the desired workflow (if there is more than
 * one in the system).
 *
 * @param  boolean		Whether to include an option for inheriting
 * @param  boolean		Whether to include an option for leaving it alone
 * @return tempcode		The UI for choosing a workflow (if needed)
 */
function workflow_choose_ui($include_inherit=false,$include_current=false)
{
	// Grab the necessary code
	require_code('workflows');
	require_lang('workflows');

	// Find out which workflows are available
	$all_workflows=get_all_workflows();

	// Only give an option to select a workflow if there is more
	// than one available
	if (count($all_workflows) > 1)
	{
		// Grab the default workflow
		$def=get_default_workflow();
		$workflows=new ocp_tempcode();

		// If we've been asked to show a "current" option then add that
		if ($include_current)
		{
			$workflows->attach(form_input_list_entry('wf_-2',true,do_lang('KEEP_WORKFLOW'),false,false));
		}

		// If we've been asked to show an "inherit" option then add that
		if ($include_inherit)
		{
			$workflows->attach(form_input_list_entry('wf_-1',!$include_current,do_lang('INHERIT_WORKFLOW'),false,false));
		}

		// Get all of the workflows we have
		foreach ($all_workflows as $id=>$workflow)
		{
			$workflows->attach(form_input_list_entry('wf_'.strval($id),(!$include_inherit && !$include_current && $id==$def),$workflow,false,false));
		}

		// Return a list entry to choose from
		$help=$include_inherit? do_lang('INHERIT_WORKFLOW_HELP') : '';
		$help.=$include_current? do_lang('CURRENT_WORKFLOW_HELP') : '';
		return form_input_list(do_lang_tempcode('USE_WORKFLOW'),do_lang_tempcode('USE_WORKFLOW_DESCRIPTION', $help),'workflow',$workflows,NULL,false);
	}
	elseif (count($all_workflows)==1)
	{
		return form_input_hidden('workflow','wf_'.strval(current(array_keys($all_workflows))));
	}
	else
	{
		return new ocp_tempcode();
	}
}

/**
 * Returns the workflow that the given content is in. This is useful for putting
 * a workflow on a container, like a gallery, and applying it to its contents,
 * like images.
 *
 * @param  string			The type of content (as specified when it was entered into the workflow system)
 * @param  string			The ID of the content (as specified when it was entered into the workflow system)
 * @return ?AUTO_LINK	The ID of the workflow that this content is in (NULL: not found)
 */
function get_workflow_of_content($type,$id)
{
	return $GLOBALS['SITE_DB']->query_value_null_ok('workflow_content','workflow_name',array('source_type'=>$type,'source_id'=>$id));
}

/**
 * Returns whether the given user (default: current member) can choose the
 * workflow to apply to some content they're submitting/editing.
 *
 * @param  ?MEMBER		Member (NULL: current member)
 * @return boolean		Whether the user has permission or not
 */
function can_choose_workflow($user=NULL)
{
	// Sort out the user
	if (is_null($user)) $user=get_member();

	// We currently use access to the workflow management page as the defining
	// criterion
	return has_actual_page_access(get_member(), "admin_workflow", get_module_zone("admin_workflow"));
}

/**
 * This will remove the given content from the workflow system. This is useful
 * to call from content deletion functions. NOTE: This is not the same as
 * approving the content, since the validation will remain unchanged.
 *
 * @param  string		The type of the content, as defined in the workflow_content table
 * @param  string		The ID of the content, as defined in the workflow content table
 */
function remove_content_from_workflows($type,$id)
{
	$content_id=get_workflow_content_id($type, $id);
	$GLOBALS['SITE_DB']->query_delete('workflow_content',array('id'=>$content_id));
	$GLOBALS['SITE_DB']->query_delete('workflow_content_status',array('workflow_content_id'=>$content_id));
}
