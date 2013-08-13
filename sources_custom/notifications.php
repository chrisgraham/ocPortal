<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2013

 See text/EN/licence.txt for full licencing information.

*/

if (!function_exists('init__notifications'))
{
	function init__notifications($in=NULL)
	{
		if (is_null($in)) return $in; // HipHop PHP can't do code rewrites, but will call init functions if there is none in the original. Do nothing.

		$before='$dispatcher=';
		$after='if ($notification_code==\'ocf_topic\' && is_numeric($code_category) && is_null($GLOBALS[\'FORUM_DB\']->query_value_null_ok(\'f_topics\',\'t_forum_id\',array(\'id\'=>intval($code_category)))) || $notification_code==\'ocf_new_pt\' || $notification_code==\'ticket\' || $notification_code==\'ticket_reply\' || $notification_code==\'ticket_reply_staff\') { require_code(\'password_censor\'); $message=_password_censor($message,PASSWORD_CENSOR__INTERACTIVE_SCAN); } $dispatcher=';
		$in=str_replace($before,$after,$in);
		return $in;
	}
}
