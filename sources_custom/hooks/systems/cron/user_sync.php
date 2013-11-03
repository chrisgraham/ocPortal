<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		user_sync
 */

class Hook_cron_user_sync
{

	/**
	 * Standard modular run function for CRON hooks. Searches for tasks to perform.
	 */
	function run()
	{
		if (get_value('user_sync_enabled')==='1')
		{
			$_last_time=get_long_value('last_cron_user_sync');
			$last_time=is_null($_last_time)?mixed():intval($_last_time);
			if (!is_null($last_time))
			{
				if ((time()-$last_time)<60*60*24) return;
			}

			$time=time();
			set_long_value('last_cron_user_sync',strval($time));

			require_code('user_sync');

			user_sync__inbound($last_time);
		}
	}
}


