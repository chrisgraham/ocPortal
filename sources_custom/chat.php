<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2011

 See text/EN/licence.txt for full licencing information.

*/

if (!function_exists('init__chat'))
{
	function init__chat($code)
	{
		global $MEMBERS_BEFRIENDED;
		$MEMBERS_BEFRIENDED=NULL;

		global $EFFECT_SETTINGS_ROWS;
		$EFFECT_SETTINGS_ROWS=NULL;

		if (!defined('CHAT_ACTIVITY_PRUNE'))
		{
			define('CHAT_ACTIVITY_PRUNE',25);
			define('CHAT_BACKLOG_TIME',60*5); // 5 minutes of messages if you enter an existing room
			define('CHAT_EVENT_PRUNE',60*24);
		}

		if (get_page_name()=='chat')
		{
			require_code('developer_tools');
			destrictify(false);
		}
	}
}
