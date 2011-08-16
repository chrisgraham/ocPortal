<?php

function init__pages__modules_custom__join($in=NULL)
{
	$in=str_replace("\$GLOBALS['FORUM_DB']->query_update('f_invites',array('i_taken'=>1),array('i_email_address'=>\$email_address,'i_taken'=>0),'',1);",'set_from_referer_field();',$in);
	$in=str_replace('list($fields,$_hidden)=ocf_get_member_fields(true,NULL,$groups);','list($fields,$_hidden)=ocf_get_member_fields(true,NULL,$groups); $fields->attach(get_referer_field());',$in);
	return $in;
}

function get_referer_field()
{
	require_lang('signup_refer');
	$field=form_input_username(do_lang_tempcode('TYPE_REFERER'),do_lang_tempcode('DESCRIPTION_TYPE_REFERER'),'referer',get_param('keep_referer',''),false,true);
	return $field;
}

function set_from_referer_field()
{
	require_lang('signup_refer');

	$referer=post_param('referer','');
	if ($referer=='') return;

	$referer_member=$GLOBALS['FORUM_DB']->query_value_null_ok_full('SELECT id FROM '.$GLOBALS['FORUM_DB']->get_table_prefix().'f_members WHERE '.db_string_equal_to('m_username',$referer).' OR '.db_string_equal_to('m_email_address',$referer));
	if (is_null($referer_member)) warn_exit(do_lang_tempcode('REFERER_NOT_FOUND'));
	
	$GLOBALS['FORUM_DB']->query_insert('f_invites',array(
		'i_inviter'=>$referer_member,
		'i_email_address'=>post_param('email_address'),
		'i_time'=>time(),
		'i_taken'=>0
	));
}
