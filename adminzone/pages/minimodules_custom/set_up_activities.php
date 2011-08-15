<?php
/* 
 * This simple minimodule will set up the required database structures for the
 * activities system to function.
 */

// Create the main_activities table if needed
if (!$GLOBALS['SITE_DB']->table_exists('main_activities'))
{
	$GLOBALS['SITE_DB']->create_table('main_activities',array(
		'id'=>'*AUTO',
		'a_member_id'=>'*USER',
		'a_language_string_code'=>'*ID_TEXT',
		'a_label_1'=>'SHORT_TEXT',
		'a_label_2'=>'SHORT_TEXT',
		'a_label_3'=>'SHORT_TEXT',
		'a_pagelink_1'=>'SHORT_TEXT',
		'a_pagelink_2'=>'SHORT_TEXT',
		'a_pagelink_3'=>'SHORT_TEXT',
		'a_time'=>'TIME',
		'a_addon'=>'ID_TEXT',
		'a_is_public'=>'SHORT_TEXT'
	));
}

// Create a directory to store avatar thumbnails (errors are suppressed, so this
// shouldn't cause issues if the directory already exists).
require_code('abstract_file_manager');
afm_make_directory('uploads/avatar_normalise',true,false);

// Set up a default avatar if there isn't one
afm_make_directory('themes/default/images_custom/ocf_default_avatars',true,false);
if (!file_exists(get_custom_file_base().'/themes/default/images_custom/ocf_default_avatars/default.jpg') &&
	!file_exists(get_custom_file_base().'/themes/default/images_custom/ocf_default_avatars/default.png') &&
	!file_exists(get_custom_file_base().'/themes/default/images_custom/ocf_default_avatars/default.gif'))
{
	afm_copy('themes/default/images_custom/activities_avatar_fallback.png','themes/default/images_custom/ocf_default_avatars/default.png',true);
}

// Set the latest activity to 0
require_code('main_activities_submission');
log_newest_activity(0,1000,true);

echo 'You may now use the activities blocks!';
