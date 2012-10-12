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
 * @package		awards
 */

/**
 * Make an award type.
 *
 * @param  SHORT_TEXT	The title
 * @param  LONG_TEXT		The description
 * @param  integer		How many points are given to the awardee
 * @param  ID_TEXT		The content type the award type is for
 * @param  BINARY			Whether to not show the awardee when displaying this award
 * @param  integer		The approximate time in hours between awards (e.g. 168 for a week)
 * @return AUTO_LINK		The ID
 */
function add_award_type($title,$description,$points,$content_type,$hide_awardee,$update_time_hours)
{
	$id=$GLOBALS['SITE_DB']->query_insert('award_types',array('a_title'=>insert_lang_comcode($title,2),'a_description'=>insert_lang($description,2),'a_points'=>$points,'a_content_type'=>filter_naughty_harsh($content_type),'a_hide_awardee'=>$hide_awardee,'a_update_time_hours'=>$update_time_hours),true);
	log_it('ADD_AWARD_TYPE',strval($id),$title);
	return $id;
}

/**
 * Edit an award type
 *
 * @param  AUTO_LINK		The ID
 * @param  SHORT_TEXT	The title
 * @param  LONG_TEXT		The description
 * @param  integer		How many points are given to the awardee
 * @param  ID_TEXT		The content type the award type is for
 * @param  BINARY			Whether to not show the awardee when displaying this award
 * @param  integer		The approximate time in hours between awards (e.g. 168 for a week)
 */
function edit_award_type($id,$title,$description,$points,$content_type,$hide_awardee,$update_time_hours)
{
	$_title=$GLOBALS['SITE_DB']->query_select_value_if_there('award_types','a_title',array('id'=>$id));
	if (is_null($_title)) warn_exit(do_lang_tempcode('MISSING_RESOURCE'));
	$_description=$GLOBALS['SITE_DB']->query_select_value('award_types','a_description',array('id'=>$id));
	$GLOBALS['SITE_DB']->query_update('award_types',array('a_title'=>lang_remap_comcode($_title,$title),'a_description'=>lang_remap($_description,$description),'a_points'=>$points,'a_content_type'=>filter_naughty_harsh($content_type),'a_hide_awardee'=>$hide_awardee,'a_update_time_hours'=>$update_time_hours),array('id'=>$id));
	log_it('EDIT_AWARD_TYPE',strval($id),$title);
}

/**
 * Delete an award type.
 *
 * @param  AUTO_LINK		The ID
 */
function delete_award_type($id)
{
	$_title=$GLOBALS['SITE_DB']->query_select_value_if_there('award_types','a_title',array('id'=>$id));
	if (is_null($_title)) warn_exit(do_lang_tempcode('MISSING_RESOURCE'));
	$_description=$GLOBALS['SITE_DB']->query_select_value('award_types','a_description',array('id'=>$id));
	log_it('DELETE_AWARD_TYPE',strval($id),get_translated_text($_title));
	$GLOBALS['SITE_DB']->query_delete('award_types',array('id'=>$id),'',1);
	$GLOBALS['SITE_DB']->query_delete('award_archive',array('a_type_id'=>$id),'',1);
	delete_lang($_title);
	delete_lang($_description);
}

