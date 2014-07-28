<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		iotds
 */

/**
 * Add an IOTD to the database and return the ID of the new entry.
 *
 * @param  URLPATH			The URL to the IOTD image
 * @param  SHORT_TEXT		The IOTD title
 * @param  LONG_TEXT			The IOTD caption
 * @param  URLPATH			The URL to the IOTD thumbnail image
 * @param  BINARY				Whether the IOTD is currently in use (note: setting this to 1 will not actually set the IOTD, and if it is 1, then the IOTD must be explicitly set only to this)
 * @param  BINARY				Whether the IOTD may be rated
 * @param  SHORT_INTEGER	Whether comments are allowed (0=no, 1=yes, 2=review style)
 * @param  BINARY				Whether the IOTD may be trackbacked
 * @param  LONG_TEXT			Notes for the IOTD
 * @param  ?TIME				The time of submission (NULL: now)
 * @param  ?MEMBER			The IOTD submitter (NULL: current member)
 * @param  BINARY				Whether the IOTD has been used before
 * @param  ?TIME				The time the IOTD was used (NULL: never)
 * @param  integer			The number of views had
 * @param  ?TIME				The edit date (NULL: never)
 * @return AUTO_LINK			The ID of the IOTD just added
 */
function add_iotd($url,$title,$caption,$thumb_url,$current,$allow_rating,$allow_comments,$allow_trackbacks,$notes,$time=NULL,$submitter=NULL,$used=0,$use_time=NULL,$views=0,$edit_date=NULL)
{
	require_code('global4');
	prevent_double_submit('ADD_IOTD',NULL,$caption);

	if (is_null($time)) $time=time();
	if (is_null($submitter)) $submitter=get_member();

	$id=$GLOBALS['SITE_DB']->query_insert('iotd',array('i_title'=>insert_lang_comcode($title,2),'add_date'=>time(),'edit_date'=>$edit_date,'iotd_views'=>$views,'allow_rating'=>$allow_rating,'allow_comments'=>$allow_comments,'allow_trackbacks'=>$allow_trackbacks,'notes'=>$notes,'date_and_time'=>$use_time,'used'=>$used,'url'=>$url,'caption'=>insert_lang_comcode($caption,2),'thumb_url'=>$thumb_url,'submitter'=>$submitter,'is_current'=>$current),true);

	log_it('ADD_IOTD',strval($id),$caption);

	if ((addon_installed('occle')) && (!running_script('install')))
	{
		require_code('resource_fs');
		generate_resourcefs_moniker('iotd',strval($id),NULL,NULL,true);
	}

	return $id;
}

/**
 * Edit an IOTD.
 *
 * @param  AUTO_LINK			The ID of the IOTD to edit
 * @param  SHORT_TEXT		The IOTD title
 * @param  LONG_TEXT			The IOTD caption
 * @param  URLPATH			The URL to the IOTD image
 * @param  URLPATH			The URL to the IOTD thumbnail image
 * @param  BINARY				Whether the IOTD may be rated
 * @param  SHORT_INTEGER	Whether comments are allowed (0=no, 1=yes, 2=review style)
 * @param  BINARY				Whether the IOTD may be trackbacked
 * @param  LONG_TEXT			Notes for the IOTD
 * @param  ?TIME				Edit time (NULL: either means current time, or if $null_is_literal, means reset to to NULL)
 * @param  ?TIME				Add time (NULL: do not change)
 * @param  ?integer			Number of views (NULL: do not change)
 * @param  ?MEMBER			Submitter (NULL: do not change)
 * @param  boolean			Determines whether some NULLs passed mean 'use a default' or literally mean 'set to NULL'
 */
function edit_iotd($id,$title,$caption,$thumb_url,$url,$allow_rating,$allow_comments,$allow_trackbacks,$notes,$edit_time=NULL,$add_time=NULL,$views=NULL,$submitter=NULL,$null_is_literal=false)
{
	if (is_null($edit_time)) $edit_time=$null_is_literal?NULL:time();

	$_caption=$GLOBALS['SITE_DB']->query_select_value('iotd','caption',array('id'=>$id));
	$_title=$GLOBALS['SITE_DB']->query_select_value('iotd','i_title',array('id'=>$id));

	if (addon_installed('catalogues'))
	{
		$GLOBALS['SITE_DB']->query_update('catalogue_fields f JOIN '.$GLOBALS['SITE_DB']->get_table_prefix().'catalogue_efv_short v ON v.cf_id=f.id',array('cv_value'=>''),array('cv_value'=>strval($id),'cf_type'=>'iotd'));
	}

	require_code('files2');
	delete_upload('uploads/iotds','iotd','url','id',$id,$url);
	delete_upload('uploads/iotds_thumbs','iotd','thumb_url','id',$id,$thumb_url);

	$update_map=array(
		'i_title'=>lang_remap_comcode($_title,$title),
		'allow_rating'=>$allow_rating,
		'allow_comments'=>$allow_comments,
		'allow_trackbacks'=>$allow_trackbacks,
		'notes'=>$notes,
		'caption'=>lang_remap_comcode($_caption,$caption),
		'thumb_url'=>$thumb_url,
		'url'=>$url,
	);

	$update_map['edit_date']=$edit_time;
	if (!is_null($add_time))
		$update_map['add_date']=$add_time;
	if (!is_null($views))
		$update_map['iotd_views']=$views;
	if (!is_null($submitter))
		$update_map['submitter']=$submitter;

	$GLOBALS['SITE_DB']->query_update('iotd',$update_map,array('id'=>$id),'',1);

	require_code('urls2');
	suggest_new_idmoniker_for('iotds','view',strval($id),'',$title);

	decache('main_iotd');

	require_code('feedback');
	update_spacer_post(
		$allow_comments!=0,
		'videos',
		strval($id),
		build_url(array('page'=>'iotds','type'=>'view','id'=>$id),get_module_zone('iotds'),NULL,false,false,true),
		$title,
		find_overridden_comment_forum('iotds')
	);

	log_it('EDIT_IOTD',strval($id),get_translated_text($_caption));

	if ((addon_installed('occle')) && (!running_script('install')))
	{
		require_code('resource_fs');
		generate_resourcefs_moniker('iotd',strval($id));
	}
}

/**
 * Delete an IOTD.
 *
 * @param  AUTO_LINK		The ID of the IOTD to delete
 */
function delete_iotd($id)
{
	$caption=$GLOBALS['SITE_DB']->query_select_value('iotd','caption',array('id'=>$id));
	$title=$GLOBALS['SITE_DB']->query_select_value('iotd','i_title',array('id'=>$id));

	delete_lang($caption);
	delete_lang($title);

	require_code('files2');
	delete_upload('uploads/iotds','iotd','url','id',$id);
	delete_upload('uploads/iotds_thumbs','iotd','thumb_url','id',$id);

	// Delete from the database
	$GLOBALS['SITE_DB']->query_delete('iotd',array('id'=>$id),'',1);
	$GLOBALS['SITE_DB']->query_delete('rating',array('rating_for_type'=>'iotds','rating_for_id'=>$id));
	$GLOBALS['SITE_DB']->query_delete('trackbacks',array('trackback_for_type'=>'iotds','trackback_for_id'=>$id));
	require_code('notifications');
	delete_all_notifications_on('comment_posted','iotds_'.strval($id));

	decache('main_iotd');

	log_it('DELETE_IOTD',strval($id),get_translated_text($caption));

	if ((addon_installed('occle')) && (!running_script('install')))
	{
		require_code('resource_fs');
		expunge_resourcefs_moniker('iotd',strval($id));
	}
}

/**
 * Set the IOTD.
 *
 * @param  AUTO_LINK		The IOTD ID to set
 */
function set_iotd($id)
{
	$rows=$GLOBALS['SITE_DB']->query_select('iotd',array('*'),array('id'=>$id),'',1);
	$title=get_translated_text($rows[0]['i_title']);
	$submitter=$rows[0]['submitter'];

	log_it('CHOOSE_IOTD',strval($id),$title);
	require_code('users2');
	if (has_actual_page_access(get_modal_user(),'iotds'))
	{
		require_code('activities');
		syndicate_described_activity('iotds:ACTIVITY_CHOOSE_IOTD',$title,'','','_SEARCH:iotds:view:'.strval($id),'','','iotds');
	}

	if ((!is_guest($submitter)) && (addon_installed('points')))
	{
		require_code('points2');
		$points_chosen=intval(get_option('points_CHOOSE_IOTD'));
		if ($points_chosen!=0)
			system_gift_transfer(do_lang('IOTD'),$points_chosen,$submitter);
	}

	// Turn all others off
	$GLOBALS['SITE_DB']->query_update('iotd',array('is_current'=>0),array('is_current'=>1));

	// Turn ours on
	$GLOBALS['SITE_DB']->query_update('iotd',array('is_current'=>1,'used'=>1,'date_and_time'=>time()),array('id'=>$id),'',1);

	require_lang('iotds');
	require_code('notifications');
	$view_url=build_url(array('page'=>'iotds','type'=>'view','id'=>$id),get_module_zone('iotds'),NULL,false,false,true);
	$thumb_url=$rows[0]['thumb_url'];
	if (url_is_local($thumb_url)) $thumb_url=get_custom_base_url().'/'.$thumb_url;
	$subject=do_lang('IOTD_CHOSEN_NOTIFICATION_MAIL_SUBJECT',get_site_name(),$title);
	$mail=do_lang('IOTD_CHOSEN_NOTIFICATION_MAIL',comcode_escape(get_site_name()),$title,array($view_url->evaluate(),$thumb_url));
	dispatch_notification('iotd_chosen',NULL,$subject,$mail);

	decache('main_iotd');
}


