<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		myocp
 */

class Hook_cron_site_cleanup
{

	/**
	 * Standard modular run function for CRON hooks. Searches for tasks to perform.
	 */
	function run()
	{
		require_lang('sites');
		require_code('ocpcom');
		myocp_delete_old_sites();

		// Reset demo
		$last=get_value('last_demo_set_time');
		if ((is_null($last)) || (intval($last)<time()-60*60*12))
		{
			set_value('last_demo_set_time',strval(time()));
			
			require_lang('ocpcom');

			$servers=find_all_servers();
			$server=array_shift($servers);
			$codename='shareddemo';
			$password='demo123';
			$email_address='';
			myocp_add_site_raw($server,$codename,$email_address,$password);
		}
	}

}


