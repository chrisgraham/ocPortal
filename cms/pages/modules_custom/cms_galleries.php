<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * Inject workflow code into the galleries module.
 *
 * @return  string Altered code
 */
function init__cms__pages__modules_custom__cms_galleries($code)
{
	// NOTE: There are many classes defined in the cms_galleries file. We need to
	// make all work.

	// Replace the validation field for images and videos with a workflow field.
	// We start a comment to disable the regular validation steps.
	$code=str_replace(
		'$thumb_width=intval(get_option(\'thumb_width\'));',
		'$thumb_width=intval(get_option(\'thumb_width\'));
		require_code("workflows");
		require_lang("workflows");
		if (!isset($adding))
			$adding=$url=="";
		if (can_choose_workflow())
		{
			$fields->attach(workflow_choose_ui(false,!$adding));		// Set the first argument to true to show "inherit from parent"
		}
		else
		{
			if ($adding)
				$fields->attach(form_input_hidden("workflow","wf_-1"));
		}
		',
		$code
	);

	// Here we end the comment we started above, both for images...
	$code=str_replace(
		'$validated_field=form_input_tick(do_lang_tempcode(\'VALIDATED\'),do_lang_tempcode(\'DESCRIPTION_VALIDATED\'),\'validated\',$validated==1);',
		'$validated_field=new ocp_tempcode();',
		$code
	);
	// ...and videos.
	$code=str_replace(
		'$validated_field=form_input_tick(do_lang_tempcode(\'VALIDATED\'),do_lang_tempcode(\'DESCRIPTION_VALIDATED\'),\'validated\',$validated==1);',
		'$validated_field=new ocp_tempcode();',
		$code
	);

	// Now we add a workflow selection to the gallery creation form. This is a
	// little complicated, since galleries should inherit the workflow of their
	// parent by default, but their parent is chosen on the form. Thus we add an
	// option to inherit the parent's workflow
	$code=str_replace(
		'$fields->attach(form_input_tick(do_lang_tempcode(\'FLOW_MODE_INTERFACE\'),do_lang_tempcode(\'DESCRIPTION_FLOW_MODE_INTERFACE\'),\'flow_mode_interface\',$flow_mode_interface==1));',
		'$fields->attach(form_input_tick(do_lang_tempcode(\'FLOW_MODE_INTERFACE\'),do_lang_tempcode(\'DESCRIPTION_FLOW_MODE_INTERFACE\'),\'flow_mode_interface\',$flow_mode_interface==1));
		require_code("workflows");
		require_lang("workflows");
		if (can_choose_workflow())
		{
			$fields->attach(workflow_choose_ui(false,$name!=""));
		}
		else
		{
			$fields->attach(form_input_hidden("workflow","wf_-1"));
		}
		',
		$code
	);
	return $code;
}

