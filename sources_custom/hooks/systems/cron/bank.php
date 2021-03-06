<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

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

		$bank_dividend=intval(get_option('bank_divident'));

		foreach ($to_be_restored as $deposit)
		{
			if ($deposit['amount']>0)
			{
				require_code('points2');
				require_lang('bank');

				$restore_amount=round(floatval($deposit['amount'])*(1.0+floatval($bank_dividend)/100.0));
				system_gift_transfer(do_lang('RESTORED_DEPOSIT'),intval($restore_amount),$deposit['user_id']);

				$GLOBALS['SITE_DB']->query_delete('bank',array('id'=>$deposit['id']),'',1);
			}
		}

	}

}


