<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		shopping	
 */

class Hook_checklist_ecommerce_orders
{

	/**
	 * Standard modular run function.
	 *
	 * @return array		An array of tuples: The task row to show, the number of seconds until it is due (or NULL if not on a timer), the number of things to sort out (or NULL if not on a queue), The name of the config option that controls the schedule (or NULL if no option).
	 */
	function run()
	{
		if (!addon_installed('ecommerce')) return array();
		if (!addon_installed('shopping')) return array();

		require_lang('shopping');

		$to_dispatch_order_cnt=$GLOBALS['SITE_DB']->query_value_null_ok('shopping_order','count(id)',array('order_status'=>'ORDER_STATUS_payment_received'));

		if ($to_dispatch_order_cnt>0)
		{
			$status=do_template('BLOCK_MAIN_STAFF_CHECKLIST_ITEM_STATUS_0',array('_GUID'=>'a5138b84598f5c45113fc169a44d55c7'));
		} else
		{	
			$status=do_template('BLOCK_MAIN_STAFF_CHECKLIST_ITEM_STATUS_1',array('_GUID'=>'b5138b84598f5c45113fc169a44d55c7'));
		}

		$url=build_url(array('page'=>'admin_orders','type'=>'show_orders','filter'=>'undispatched'),get_module_zone('admin_orders'));

		$tpl=do_template('BLOCK_MAIN_STAFF_CHECKLIST_ITEM',array('_GUID'=>'440a79b164533416f4d086a93efba9ea','URL'=>$url,'STATUS'=>$status,'TASK'=>do_lang_tempcode('ORDERS'),'INFO'=>do_lang_tempcode('NUM_QUEUE',escape_html(integer_format($to_dispatch_order_cnt)))));
		return array(array($tpl,NULL,$to_dispatch_order_cnt,NULL));
	}

}


