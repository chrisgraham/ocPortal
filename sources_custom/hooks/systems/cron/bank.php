<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2011

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		stats
 */

class Hook_cron_bank
{

	/**
	 * Standard modular run function for CRON hooks. Searches for tasks to perform.
	 */
	function run()
	{
		//if (!addon_installed('bank')) return;
		
		$to_be_restored=$GLOBALS['SITE_DB']->query('SELECT * FROM '.get_table_prefix().'bank WHERE add_time<'.strval(time()-(30*24*60*60)),NULL,NULL,true);
		if (is_null($to_be_restored)) return;

		require_code('points2');
		require_lang('bank');

		$bank_divident=intval(get_option('bank_divident'));

		foreach ($to_be_restored as $deposit)
		{
		   if(isset($deposit['amount']) && ($deposit['amount']>0)) {
			   $restore_amount=round($deposit['amount'] + $deposit['amount']*($bank_divident/100));
			   system_gift_transfer(do_lang('RESTORED_DEPOSIT'),$restore_amount,$deposit['user_id']);

				$GLOBALS['SITE_DB']->query('DELETE FROM '.get_table_prefix().'bank WHERE id='.strval($deposit['id']));
		   }
		}

	}

}


