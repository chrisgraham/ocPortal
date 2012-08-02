<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		ocportalcom_support_credits
 */

require_code('ecommerce');
require_code('hooks/systems/ecommerce/support_credits');
$ob=new Hook_support_credits();
$products=$ob->get_products();

$credit_kinds=array();
foreach ($products as $p=>$v)
{
	$num_credits=str_replace('CREDITS','',$p);
	if ((intval($num_credits)<9) && (is_null($GLOBALS['SITE_DB']->query_value_null_ok_full('SELECT id FROM mantis_sponsorship_table WHERE user_id='.strval(get_member())))))
	{
		continue;
	}
	$credit_kinds[]=array(
		'NUM_CREDITS'=>$num_credits,
		'PRICE'=>float_format($v[1]),
	);
}

$tpl=do_template('BLOCK_CREDIT_EXPS',array('_GUID'=>'6c6134a1b7157637dae280b54e90a877','CREDIT_KINDS'=>$credit_kinds));
$tpl->evaluate_echo();
