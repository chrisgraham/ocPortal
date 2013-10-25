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
 * @package		chat
 */

class Hook_chat_bot_default
{

	/**
	 * Handle hooks supported bot commands. Note multiple bots may support the same commands, and all respond. It is recommended all bots support the command 'help'.
	 *
	 * @param  AUTO_LINK		The ID of the chat room
	 * @param  string			The command used. This is just the chat message, so you can encode and recognise your own parameter scheme if you like.
	 * @return ?string		Bot reply (NULL: bot does not handle the command)
	 */
	function handle_commands($room_id,$command)
	{
		switch ($command)
		{
			case 'help':
				$out=do_lang('CHAT_HELP_BOTMSG');
				return do_lang('CHAT_WEBSITE_HELPER_BOT',$out);

			case 'users_online':
				// On the site
				$count=0;
				require_code('users2');
				$members=get_online_members(true,NULL,$count);
				if (is_null($members)) return do_lang('TOO_MANY_USERS_ONLINE');
				$guests=0;
				$site_members='';
				foreach ($members as $member)
				{
					if ((is_guest($member['member_id'])) || (is_null($member['cache_username'])))
					{
						$guests++;
					} else
					{
						if ($site_members!='') $site_members.=', ';
						$site_members.='{{'.$member['cache_username'].'}}';
					}
				}

				// In this room
				$room_members=get_chatters_in_room($room_id);
				$_room_members='';
				foreach ($room_members as $room_member)
				{
					if ($_room_members!='') $_room_members.=', ';
					$_room_members.='{{'.$room_member.'}}';
				}

				// Show our complete result
				$out=do_lang('CHAT_USERSONLINE_BOTMSG',$site_members,$_room_members);
				return do_lang('CHAT_WEBSITE_HELPER_BOT',$out);

			case 'time':
				$out=do_lang('CHAT_TIME_BOTMSG',get_timezoned_date(time(),true,true,true,true));
				return do_lang('CHAT_WEBSITE_HELPER_BOT',$out);
		}

		return NULL;
	}

}


