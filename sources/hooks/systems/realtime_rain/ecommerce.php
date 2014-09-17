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
 * @package		ecommerce
 */

class Hook_realtime_rain_ecommerce
{
	/**
	 * Run function for realtime-rain hooks.
	 *
	 * @param  TIME			Start of time range.
	 * @param  TIME			End of time range.
	 * @return array			A list of template parameter sets for rendering a 'drop'.
	 */
	function run($from,$to)
	{
		$drops=array();

		if (has_actual_page_access(get_member(),'admin_ecommerce'))
		{
			$rows=$GLOBALS['SITE_DB']->query('SELECT t_amount,t_type_code,t_time AS timestamp FROM '.$GLOBALS['SITE_DB']->get_table_prefix().'transactions WHERE t_time BETWEEN '.strval($from).' AND '.strval($to));

			foreach ($rows as $row)
			{
				require_code('ecommerce');
				list($product_row,)=find_product_row($row['t_type_code']);
				if (!is_null($product_row))
				{
					$title=$product_row[4];
				} else
				{
					require_lang('ecommerce');
					$title=do_lang('SALE_MADE');
				}

				$timestamp=$row['t_timestamp'];

				$ticker_text=do_lang('KA_CHING',ecommerce_get_currency_symbol(),$row['t_amount']);

				$drops[]=rain_get_special_icons(NULL,$timestamp,NULL,$ticker_text)+array(
					'TYPE'=>'ecommerce',
					'FROM_MEMBER_ID'=>NULL,
					'TO_MEMBER_ID'=>NULL,
					'TITLE'=>$title,
					'IMAGE'=>find_theme_image('icons/48x48/menu/rich_content/ecommerce/purchase'),
					'TIMESTAMP'=>strval($timestamp),
					'RELATIVE_TIMESTAMP'=>strval($timestamp-$from),
					'TICKER_TEXT'=>$ticker_text,
					'URL'=>NULL,
					'IS_POSITIVE'=>true,
					'IS_NEGATIVE'=>false,

					// These are for showing connections between drops. They are not discriminated, it's just three slots to give an ID code that may be seen as a commonality with other drops.
					'FROM_ID'=>NULL,
					'TO_ID'=>NULL,
					'GROUP_ID'=>'product_'.$row['t_type_code'],
				);
			}
		}

		return $drops;
	}
}
