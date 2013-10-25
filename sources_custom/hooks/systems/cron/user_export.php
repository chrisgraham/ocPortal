<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.

*/

class Hook_cron_user_export
{

	/**
	 * Standard modular run function for CRON hooks. Searches for tasks to perform.
	 */
	function run()
	{
		require_code('user_export');

		if (!USER_EXPORT_ENABLED) return;

		$last=get_value('last_user_export');
		if ((is_null($last)) || ($last<time()-60*USER_EXPORT_MINUTES))
		{
			set_value('last_user_export',strval(time()));

			do_user_export();
		}
	}

}


