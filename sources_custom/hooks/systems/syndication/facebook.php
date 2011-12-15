function syndicate_user_activity()
{
	require_code('facebook_publish');
	require_code('facebook_connect');
	$cookie=get_facebook_cookie();
	if (!is_null($cookie)) // Logged into Facebook
	{
		require_lang('activities');
		
		$guest_id=intval($GLOBALS['FORUM_DRIVER']->get_guest_id());
		$link_1=($row['a_pagelink_1']=='')?new ocp_tempcode():pagelink_to_tempcode($row['a_pagelink_1'],true);
		$link_2=($row['a_pagelink_2']=='')?new ocp_tempcode():pagelink_to_tempcode($row['a_pagelink_2'],true);
		$link_3=($row['a_pagelink_3']=='')?new ocp_tempcode():pagelink_to_tempcode($row['a_pagelink_3'],true);
		$tempcode=do_lang_tempcode($row['a_language_string_code'],comcode_to_tempcode(escape_html($row['a_label_1']),$guest_id,false,NULL),comcode_to_tempcode(escape_html($row['a_label_2']),$guest_id,false,NULL),array(comcode_to_tempcode(escape_html($row['a_label_3']),$guest_id,false,NULL),escape_html($link_1->evaluate()),escape_html($link_2->evaluate()),escape_html($link_3->evaluate())));

		publish_to_FB($tempcode->evaluate(),'',$link_1->evaluate(),$cookie['uid']);
	}
}

function syndicate_site_activity()
{
}
