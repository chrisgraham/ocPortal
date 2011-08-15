<?php

function init__cms__pages__modules_custom__cms_cedi($old)
{
	$new_code='
		if ($page_id!=-1)
		{
			require_lang(\'tracking\');

			$track=($GLOBALS[\'SITE_DB\']->query_value_null_ok(\'seedy_changes\',\'MAX(date_and_time)\',array(\'the_page\'=>$page_id))<time()-60*10);
			$radios=form_input_radio_entry(\'do_tracking\',\'0\',!$track,do_lang_tempcode(\'NO\'));
			$radios->attach(form_input_radio_entry(\'do_tracking\',\'1\',$track,do_lang_tempcode(\'YES\')));
			$fields2->attach(form_input_radio(do_lang_tempcode(\'SEND_TRACKING_ALERT\'),do_lang_tempcode(\'DESCRIPTION_SEND_TRACKING_ALERT\'),$radios));
		}
	';
	$new_code=str_replace('$fields2->attach(do_template(\'FORM_SCREEN_FIELD_SPACER\',array(\'SECTION_H',$new_code.'$fields2->attach(do_template(\'FORM_SCREEN_FIELD_SPACER\',array(\'SECTION_H',$old);
	return $new_code;
}