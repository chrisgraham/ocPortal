<?php

function init__site__pages__modules_custom__cedi($old)
{
	$new_code='
		list($page_id,)=get_param_cedi_chain(\'id\',strval(db_get_first_id()));

		require_lang(\'tracking\');

		$track=($GLOBALS[\'SITE_DB\']->query_value_null_ok(\'seedy_changes\',\'MAX(date_and_time)\',array(\'the_page\'=>$page_id))<time()-60*10);
		$radios=form_input_radio_entry(\'do_tracking\',\'0\',!$track,do_lang_tempcode(\'NO\'));
		$radios->attach(form_input_radio_entry(\'do_tracking\',\'1\',$track,do_lang_tempcode(\'YES\')));
		$specialisation->attach(form_input_radio(do_lang_tempcode(\'SEND_TRACKING_ALERT\'),do_lang_tempcode(\'DESCRIPTION_SEND_TRACKING_ALERT\'),$radios));
	';
	$new_code=str_replace('$text=new ocp_tempcode();',$new_code.'$text=new ocp_tempcode();',$old);
	return $new_code;
}