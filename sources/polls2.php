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
 * @package		polls
 */

/**
 * Add a new poll to the database, then return the ID of the new entry.
 *
 * @param  SHORT_TEXT		The question
 * @param  SHORT_TEXT		The first choice
 * @range  1 max
 * @param  SHORT_TEXT		The second choice
 * @range  1 max
 * @param  SHORT_TEXT		The third choice (blank means not a choice)
 * @param  SHORT_TEXT		The fourth choice (blank means not a choice)
 * @param  SHORT_TEXT		The fifth choice (blank means not a choice)
 * @param  SHORT_TEXT		The sixth choice (blank means not a choice)
 * @param  SHORT_TEXT		The seventh choice (blank means not a choice)
 * @param  SHORT_TEXT		The eighth choice (blank means not a choice)
 * @param  SHORT_TEXT		The ninth choice (blank means not a choice)
 * @param  SHORT_TEXT		The tenth choice (blank means not a choice)
 * @param  ?integer			The number of choices (NULL: calculate)
 * @range  2 5
 * @param  BINARY				Whether the poll is the current poll
 * @param  BINARY				Whether to allow rating of this poll
 * @param  SHORT_INTEGER	Whether comments are allowed (0=no, 1=yes, 2=review style)
 * @param  BINARY				Whether to allow trackbacking on this poll
 * @param  LONG_TEXT			Notes about this poll
 * @param  ?TIME				The time the poll was submitted (NULL: now)
 * @param  ?MEMBER			The member who submitted (NULL: the current member)
 * @param  ?TIME				The time the poll was put to use (NULL: not put to use yet)
 * @param  integer			How many have voted for option 1
 * @range  0 max
 * @param  integer			How many have voted for option 2
 * @range  0 max
 * @param  integer			How many have voted for option 3
 * @range  0 max
 * @param  integer			How many have voted for option 4
 * @range  0 max
 * @param  integer			How many have voted for option 5
 * @range  0 max
 * @param  integer			How many have voted for option 6
 * @range  0 max
 * @param  integer			How many have voted for option 7
 * @range  0 max
 * @param  integer			How many have voted for option 8
 * @range  0 max
 * @param  integer			How many have voted for option 9
 * @range  0 max
 * @param  integer			How many have voted for option 10
 * @range  0 max
 * @param  integer			The number of views had
 * @param  ?TIME				The edit date (NULL: never)
 * @return AUTO_LINK			The poll ID of our new poll
 */
function add_poll($question,$a1,$a2,$a3='',$a4='',$a5='',$a6='',$a7='',$a8='',$a9='',$a10='',$num_options=NULL,$current=0,$allow_rating=1,$allow_comments=1,$allow_trackbacks=1,$notes='',$time=NULL,$submitter=NULL,$use_time=NULL,$v1=0,$v2=0,$v3=0,$v4=0,$v5=0,$v6=0,$v7=0,$v8=0,$v9=0,$v10=0,$views=0,$edit_date=NULL)
{
	if (is_null($num_options))
	{
		$num_options=2;
		if ($a3!='') $num_options++;
		if ($a4!='') $num_options++;
		if ($a5!='') $num_options++;
		if ($a6!='') $num_options++;
		if ($a7!='') $num_options++;
		if ($a8!='') $num_options++;
		if ($a9!='') $num_options++;
		if ($a10!='') $num_options++;
	}

	if ($current==1)
	{
		persistent_cache_delete('POLL');
		$GLOBALS['SITE_DB']->query_update('poll',array('is_current'=>0),array('is_current'=>1),'',1);
	}

	if (is_null($time)) $time=time();
	if (is_null($submitter)) $submitter=get_member();

	$id=$GLOBALS['SITE_DB']->query_insert('poll',array('edit_date'=>$edit_date,'poll_views'=>$views,'add_time'=>$time,'allow_trackbacks'=>$allow_trackbacks,'allow_rating'=>$allow_rating,'allow_comments'=>$allow_comments,'notes'=>$notes,'submitter'=>$submitter,'date_and_time'=>$use_time,'votes1'=>$v1,'votes2'=>$v2,'votes3'=>$v3,'votes4'=>$v4,'votes5'=>$v5,'votes6'=>$v6,'votes7'=>$v7,'votes8'=>$v8,'votes9'=>$v9,'votes10'=>$v10,'question'=>insert_lang_comcode($question,1),'option1'=>insert_lang_comcode($a1,1),'option2'=>insert_lang_comcode($a2,1),'option3'=>insert_lang_comcode($a3,1),'option4'=>insert_lang_comcode($a4,1),'option5'=>insert_lang_comcode($a5,1),'option6'=>insert_lang_comcode($a6,1),'option7'=>insert_lang_comcode($a7,1),'option8'=>insert_lang_comcode($a8,1),'option9'=>insert_lang_comcode($a9,1),'option10'=>insert_lang_comcode($a10,1),'num_options'=>$num_options,'is_current'=>$current),true);

	log_it('ADD_POLL',strval($id),$question);

	if ((addon_installed('occle')) && (!running_script('install')))
	{
		require_code('resource_fs');
		generate_resourcefs_moniker('poll',strval($id),NULL,NULL,true);
	}

	return $id;
}

/**
 * Edit a poll.
 *
 * @param  AUTO_LINK			The ID of the poll to edit
 * @param  SHORT_TEXT		The question
 * @param  SHORT_TEXT		The first choice
 * @range  1 max
 * @param  SHORT_TEXT		The second choice
 * @range  1 max
 * @param  SHORT_TEXT		The third choice (blank means not a choice)
 * @param  SHORT_TEXT		The fourth choice (blank means not a choice)
 * @param  SHORT_TEXT		The fifth choice (blank means not a choice)
 * @param  SHORT_TEXT		The sixth choice (blank means not a choice)
 * @param  SHORT_TEXT		The seventh choice (blank means not a choice)
 * @param  SHORT_TEXT		The eighth choice (blank means not a choice)
 * @param  SHORT_TEXT		The ninth choice (blank means not a choice)
 * @param  SHORT_TEXT		The tenth choice (blank means not a choice)
 * @param  integer			The number of choices
 * @param  BINARY				Whether to allow rating of this poll
 * @param  SHORT_INTEGER	Whether comments are allowed (0=no, 1=yes, 2=review style)
 * @param  BINARY				Whether to allow trackbacking on this poll
 * @param  LONG_TEXT			Notes about this poll
 * @param  ?TIME				Edit time (NULL: either means current time, or if $null_is_literal, means reset to to NULL)
 * @param  ?TIME				Add time (NULL: do not change)
 * @param  ?integer			Number of views (NULL: do not change)
 * @param  ?MEMBER			Submitter (NULL: do not change)
 * @param  boolean			Determines whether some NULLs passed mean 'use a default' or literally mean 'set to NULL'
 */
function edit_poll($id,$question,$a1,$a2,$a3,$a4,$a5,$a6,$a7,$a8,$a9,$a10,$num_options,$allow_rating,$allow_comments,$allow_trackbacks,$notes,$edit_time=NULL,$add_time=NULL,$views=NULL,$submitter=NULL,$null_is_literal=false)
{
	if (is_null($edit_time)) $edit_time=$null_is_literal?NULL:time();

	log_it('EDIT_POLL',strval($id),$question);

	if ((addon_installed('occle')) && (!running_script('install')))
	{
		require_code('resource_fs');
		generate_resourcefs_moniker('poll',strval($id));
	}

	persistent_cache_delete('POLL');

	$rows=$GLOBALS['SITE_DB']->query_select('poll',array('*'),array('id'=>$id),'',1);
	$_question=$rows[0]['question'];
	$_a1=$rows[0]['option1'];
	$_a2=$rows[0]['option2'];
	$_a3=$rows[0]['option3'];
	$_a4=$rows[0]['option4'];
	$_a5=$rows[0]['option5'];
	$_a6=$rows[0]['option6'];
	$_a7=$rows[0]['option7'];
	$_a8=$rows[0]['option8'];
	$_a9=$rows[0]['option9'];
	$_a10=$rows[0]['option10'];

	$update_map=array(
		'allow_rating'=>$allow_rating,
		'allow_comments'=>$allow_comments,
		'allow_trackbacks'=>$allow_trackbacks,
		'notes'=>$notes,
		'num_options'=>$num_options,
		'question'=>lang_remap_comcode($_question,$question),
		'option1'=>lang_remap_comcode($_a1,$a1),
		'option2'=>lang_remap_comcode($_a2,$a2),
		'option3'=>lang_remap_comcode($_a3,$a3),
		'option4'=>lang_remap_comcode($_a4,$a4),
		'option5'=>lang_remap_comcode($_a5,$a5),
		'option6'=>lang_remap_comcode($_a6,$a6),
		'option7'=>lang_remap_comcode($_a7,$a7),
		'option8'=>lang_remap_comcode($_a8,$a8),
		'option9'=>lang_remap_comcode($_a9,$a9),
		'option10'=>lang_remap_comcode($_a10,$a10)
	);

	$update_map['edit_date']=$edit_time;
	if (!is_null($add_time))
		$update_map['add_time']=$add_time;
	if (!is_null($views))
		$update_map['poll_views']=$views;
	if (!is_null($submitter))
		$update_map['submitter']=$submitter;

	$GLOBALS['SITE_DB']->query_update('poll',$update_map,array('id'=>$id),'',1);
	decache('main_poll');

	require_code('urls2');
	suggest_new_idmoniker_for('polls','view',strval($id),'',$question);

	require_code('feedback');
	update_spacer_post(
		$allow_comments!=0,
		'polls',
		strval($id),
		build_url(array('page'=>'polls','type'=>'view','id'=>$id),get_module_zone('polls'),NULL,false,false,true),
		$question,
		find_overridden_comment_forum('polls')
	);
}

/**
 * Delete a poll.
 *
 * @param  AUTO_LINK		The ID of the poll to delete
 */
function delete_poll($id)
{
	$rows=$GLOBALS['SITE_DB']->query_select('poll',array('*'),array('id'=>$id),'',1);

	persistent_cache_delete('POLL');

	$question=get_translated_text($rows[0]['question']);

	delete_lang($rows[0]['question']);
	for ($i=1;$i<=10;$i++)
	{
		delete_lang($rows[0]['option'.strval($i)]);
	}

	$GLOBALS['SITE_DB']->query_delete('rating',array('rating_for_type'=>'polls','rating_for_id'=>$id));
	$GLOBALS['SITE_DB']->query_delete('trackbacks',array('trackback_for_type'=>'polls','trackback_for_id'=>$id));
	require_code('notifications');
	delete_all_notifications_on('comment_posted','polls_'.strval($id));

	$GLOBALS['SITE_DB']->query_delete('poll',array('id'=>$id),'',1);

	log_it('DELETE_POLL',strval($id),$question);

	if ((addon_installed('occle')) && (!running_script('install')))
	{
		require_code('resource_fs');
		expunge_resourcefs_moniker('poll',strval($id));
	}
}

/**
 * Set the poll.
 *
 * @param  AUTO_LINK		The poll ID to set
 */
function set_poll($id)
{
	persistent_cache_delete('POLL');

	$rows=$GLOBALS['SITE_DB']->query_select('poll',array('question','submitter'),array('id'=>$id));
	$question=$rows[0]['question'];
	$submitter=$rows[0]['submitter'];

	log_it('CHOOSE_POLL',strval($id),get_translated_text($question));

	require_code('users2');
	if (has_actual_page_access(get_modal_user(),'polls'))
	{
		require_code('activities');
		syndicate_described_activity('polls:ACTIVITY_CHOOSE_POLL',get_translated_text($question),'','','_SEARCH:polls:view:'.strval($id),'','','polls');
	}

	if ((!is_guest($submitter)) && (addon_installed('points')))
	{
		require_code('points2');
		$points_chosen=intval(get_option('points_CHOOSE_POLL'));
		if ($points_chosen!=0)
			system_gift_transfer(do_lang('POLL'),$points_chosen,$submitter);
	}

	$GLOBALS['SITE_DB']->query_update('poll',array('is_current'=>0),array('is_current'=>1));
	$GLOBALS['SITE_DB']->query_update('poll',array('is_current'=>1,'date_and_time'=>time()),array('id'=>$id),'',1);
	decache('main_poll');

	require_lang('polls');
	require_code('notifications');
	$subject=do_lang('POLL_CHOSEN_NOTIFICATION_MAIL_SUBJECT',get_site_name(),$question);
	$poll_url=build_url(array('page'=>'polls','type'=>'view','id'=>$id),get_module_zone('polls'),NULL,false,false,true);
	$mail=do_lang('POLL_CHOSEN_NOTIFICATION_MAIL',comcode_escape(get_site_name()),comcode_escape(get_translated_text($question)),$poll_url->evaluate());
	dispatch_notification('poll_chosen',NULL,$subject,$mail);
}

