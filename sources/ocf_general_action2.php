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
 * @package		core_ocf
 */

/**
 * Edit a post template.
 *
 * @param  AUTO_LINK		The ID of the post template to edit.
 * @param  SHORT_TEXT	The title for the template.
 * @param  LONG_TEXT		The text of the template.
 * @param  SHORT_TEXT	The multi code specifying which forums this is applicable in.
 * @param  BINARY			Whether to use this as the default post in applicable forum.
 */
function ocf_edit_post_template($id,$title,$text,$forum_multi_code,$use_default_forums)
{
	$GLOBALS['FORUM_DB']->query_update('f_post_templates',array(
		't_title'=>$title,
		't_text'=>$text,
		't_forum_multi_code'=>$forum_multi_code,
		't_use_default_forums'=>$use_default_forums
	),array('id'=>$id),'',1);

	log_it('EDIT_POST_TEMPLATE',strval($id),$title);

	if ((addon_installed('occle')) && (!running_script('install')))
	{
		require_code('resource_fs');
		generate_resourcefs_moniker('post_template',strval($id));
	}
}

/**
 * Delete a post template.
 *
 * @param  AUTO_LINK The ID of the post template to delete.
 */
function ocf_delete_post_template($id)
{
	$GLOBALS['FORUM_DB']->query_delete('f_post_templates',array('id'=>$id),'',1);

	log_it('DELETE_POST_TEMPLATE',strval($id));

	if ((addon_installed('occle')) && (!running_script('install')))
	{
		require_code('resource_fs');
		expunge_resourcefs_moniker('post_template',strval($id));
	}
}

/**
 * Edit an emoticon.
 *
 * @param  SHORT_TEXT	The textual code entered to make the emoticon appear.
 * @param  SHORT_TEXT	The old textual code.
 * @param  ID_TEXT		The image code used for the emoticon.
 * @param  integer		The relevance level.
 * @range  0 4
 * @param  BINARY			Whether this may be used as a topic emoticon.
 * @param  BINARY			Whether this may only be used by privileged members
 */
function ocf_edit_emoticon($old_code,$code,$theme_img_code,$relevance_level,$use_topics,$is_special=0)
{
	if ($code!=$old_code)
	{
		$test=$GLOBALS['FORUM_DB']->query_select_value_if_there('f_emoticons','e_code',array('e_code'=>$code));
		if (!is_null($test)) warn_exit(do_lang_tempcode('CONFLICTING_EMOTICON_CODE',escape_html($code)));
	}

	$old_theme_img_code=$GLOBALS['FORUM_DB']->query_select_value('f_emoticons','e_theme_img_code',array('e_code'=>$old_code));

	$GLOBALS['FORUM_DB']->query_update('f_emoticons',array(
		'e_code'=>$code,
		'e_theme_img_code'=>$theme_img_code,
		'e_relevance_level'=>$relevance_level,
		'e_use_topics'=>$use_topics,
		'e_is_special'=>$is_special
	),array('e_code'=>$old_code),'',1);

	require_code('themes2');
	tidy_theme_img_code($theme_img_code,$old_theme_img_code,'f_emoticons','e_theme_img_code');

	log_it('EDIT_EMOTICON',$code,$theme_img_code);
}

/**
 * Delete an emoticon.
 *
 * @param  SHORT_TEXT The ID of the emoticon to delete.
 */
function ocf_delete_emoticon($code)
{
	$old_theme_img_code=$GLOBALS['FORUM_DB']->query_select_value('f_emoticons','e_theme_img_code',array('e_code'=>$code));

	$GLOBALS['FORUM_DB']->query_delete('f_emoticons',array('e_code'=>$code),'',1);

	require_code('themes2');
	tidy_theme_img_code(NULL,$old_theme_img_code,'f_emoticons','e_theme_img_code');

	log_it('DELETE_EMOTICON',$code);
}

/**
 * Edit a Welcome E-mail.
 *
 * @param  AUTO_LINK		The ID
 * @param  SHORT_TEXT	A name for the Welcome E-mail
 * @param  SHORT_TEXT	The subject of the Welcome E-mail
 * @param  LONG_TEXT		The message body of the Welcome E-mail
 * @param  integer		The number of hours before sending the e-mail
 * @param  ?AUTO_LINK	What newsletter to send out to instead of members (NULL: none)
 * @param  ?AUTO_LINK	The usergroup to tie to (NULL: none)
 * @param  ID_TEXT		How to send regarding usergroups (blank: indiscriminately)
 * @set primary secondary 
 */
function ocf_edit_welcome_email($id,$name,$subject,$text,$send_time,$newsletter,$usergroup,$usergroup_type)
{
	$_subject=$GLOBALS['SITE_DB']->query_select_value('f_welcome_emails','w_subject',array('id'=>$id));
	$_text=$GLOBALS['SITE_DB']->query_select_value('f_welcome_emails','w_text',array('id'=>$id));
	$GLOBALS['SITE_DB']->query_update(
		'f_welcome_emails',
		array(
			'w_name'=>$name,
			'w_newsletter'=>$newsletter,
			'w_subject'=>lang_remap($_subject,$subject),
			'w_text'=>lang_remap($_text,$text),
			'w_send_time'=>$send_time,
			'w_usergroup'=>$usergroup,
			'w_usergroup_type'=>$usergroup_type,
		),
		array('id'=>$id),
		'',
		1
	);
	log_it('EDIT_WELCOME_EMAIL',strval($id),get_translated_text($_subject));
}

/**
 * Delete a Welcome E-mail.
 *
 * @param  AUTO_LINK		The ID
 */
function ocf_delete_welcome_email($id)
{
	$_subject=$GLOBALS['SITE_DB']->query_select_value('f_welcome_emails','w_subject',array('id'=>$id));
	$_text=$GLOBALS['SITE_DB']->query_select_value('f_welcome_emails','w_text',array('id'=>$id));
	log_it('DELETE_WELCOME_EMAIL',strval($id),get_translated_text($_subject));
	$GLOBALS['SITE_DB']->query_delete('f_welcome_emails',array('id'=>$id),'',1);
	delete_lang($_subject);
	delete_lang($_text);
}

/**
 * Get a form field for editing a forum multi code, set up with a default of the given forum multi code.
 *
 * @param  SHORT_TEXT	The multi code.
 * @return tempcode		The form field.
 */
function ocf_get_forum_multi_code_field($forum_multi_code)
{
	require_code('form_templates');
	if ($forum_multi_code!='')
	{
		$selected=array_map('intval',explode(',',substr($forum_multi_code,1)));
		$type=$forum_multi_code[0];
	} else
	{
		$selected=NULL;
		$type='+';
	}
	require_code('ocf_forums2');
	$list=ocf_get_forum_tree_secure(NULL,NULL,true,$selected);
	return form_input_all_and_not(do_lang_tempcode('SECTION_FORUMS'),do_lang_tempcode('USE_IN_ALL_FORUMS'),'forum_multi_code',$list,$type);
}

/**
 * Log a moderation action.
 *
 * @param  ID_TEXT		The type of moderation.
 * @param  SHORT_TEXT	First detailing parameter.
 * @param  SHORT_TEXT	Second detailing parameter.
 * @param  LONG_TEXT		The reason for the moderation (may be blank).
 * @param  ?MEMBER		The member performing the moderation (NULL: current member).
 * @param  ?TIME			The time of the moderation (NULL: just now).
 */
function ocf_mod_log_it($the_type,$param_a='',$param_b='',$reason='',$by=NULL,$date_and_time=NULL)
{
	if (is_null($date_and_time)) $date_and_time=time();
	if (is_null($by)) $by=get_member();

	$GLOBALS['FORUM_DB']->query_insert('f_moderator_logs',array(
		'l_the_type'=>$the_type,
		'l_param_a'=>$param_a,
		'l_param_b'=>$param_b,
		'l_date_and_time'=>$date_and_time,
		'l_reason'=>$reason,
		'l_by'=>$by
	));
}


