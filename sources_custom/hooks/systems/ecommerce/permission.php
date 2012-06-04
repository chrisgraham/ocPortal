<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		pointstore_to_main
 */

/**
 * Handling of a purchased permission.
 *
 * @param  ID_TEXT	The purchase ID.
 * @param  array		Details relating to the product.
 * @param  ID_TEXT	The product.
 */
function handle_permission_purchase($purchase_id,$details,$product)
{
	$id=intval(substr($product,strlen('PERMISSION_')));

	$rows=$GLOBALS['SITE_DB']->query_select('pstore_permissions',array('*'),array('id'=>$id));
	if (!array_key_exists(0,$rows)) warn_exit(do_lang_tempcode('MISSING_RESOURCE'));

	$member=$purchase_id;

	$row=$rows[0];

	$map=get_sales_permission_map($row,$member);
	$map['active_until']=time()+$row['p_hours']*60*60;
	$GLOBALS['SITE_DB']->query_insert(filter_naughty_harsh($row['p_type']),$map);

	// Email member
	require_code('mail');
	$subject_line=get_translated_text($row['p_mail_subject']);
	if ($subject_line!='')
	{
		$message_raw=get_translated_text($row['p_mail_body']);
		$email=$GLOBALS['FORUM_DRIVER']->get_member_email_address($member);
		$to_name=$GLOBALS['FORUM_DRIVER']->get_username($member);
		mail_wrap($subject_line,$message_raw,array($email),$to_name,'','',3,NULL,false,NULL,true);
	}
}

/**
 * Get a database map for our permission row.
 *
 * @param  array			Map row of item
 * @param  MEMBER			Member ID
 * @return array			Permission map row
 */
function get_sales_permission_map($row,$member)
{
	$map=array('member_id'=>$member);
	switch ($row['p_type'])
	{
		case 'msp':
			$map['specific_permission']=$row['p_specific_permission'];
			$map['the_page']=$row['p_page'];
			$map['module_the_name']=$row['p_module'];
			$map['category_name']=$row['p_category'];
			$map['the_value']='1';
			break;
		case 'member_category_access':
			$map['module_the_name']=$row['p_module'];
			$map['category_name']=$row['p_category'];
			break;
		case 'member_page_access':
			$map['zone_name']=$row['p_zone'];
			$map['page_name']=$row['p_page'];
			break;
		case 'member_zone_access':
			$map['zone_name']=$row['p_zone'];
			break;
	}
	return $map;
}

class Hook_permission
{

	/**
	 * Get the products handled by this eCommerce hook.
	 *
	 * @return array		A map of product name to list of product details.
	 */
	function get_products()
	{
		$ppc=floatval(get_option('points_per_currency_unit'));
		if ($ppc<=0.0) return array();

		$rows=$GLOBALS['SITE_DB']->query_select('pstore_permissions',array('*'),array('p_enabled'=>1));

		$products=array();
		foreach ($rows as $row)
		{
			if ($row['p_cost']!=0)
			{
				$cost=floatval($row['p_cost'])/$ppc;
				$products['PERMISSION_'.strval($row['id'])]=array(PRODUCT_PURCHASE_WIZARD,float_to_raw_string($cost),'handle_permission_purchase',array(),get_translated_text($row['p_title']));
			}
		}

		return $products;
	}

	/**
	 * Whether this product is available.
	 *
	 * @return integer	The availability code (a ECOMMERCE_PRODUCT_* constant).
	 */
	function is_available($product,$member)
	{
		if (is_guest($member)) return ECOMMERCE_PRODUCT_NO_GUESTS;

		$id=intval(substr($product,strlen('PERMISSION_')));

		$rows=$GLOBALS['SITE_DB']->query_select('pstore_permissions',array('*'),array('id'=>$id),'',1);
		if (array_key_exists(0,$rows))
		{
			$row=$rows[0];

			if ($row['p_enabled']==0)
			{
				return ECOMMERCE_PRODUCT_DISABLED;
			}

			$map=get_sales_permission_map($row,$member);
			$test=$GLOBALS['SITE_DB']->query_value_null_ok(filter_naughty_harsh($row['p_type']),'member_id',$map);
			return is_null($test)?ECOMMERCE_PRODUCT_AVAILABLE:ECOMMERCE_PRODUCT_ALREADY_HAS;
		}

		return ECOMMERCE_PRODUCT_MISSING;
	}

	/**
	 * Get the message for use in the purchase wizard.
	 *
	 * @param  string		The product in question.
	 * @return tempcode	The message.
	 */
	function get_message($product)
	{
		$id=intval(substr($product,strlen('PERMISSION_')));

		$rows=$GLOBALS['SITE_DB']->query_select('pstore_permissions',array('*'),array('id'=>$id),'',1);
		if (array_key_exists(0,$rows))
		{
			$row=$rows[0];
			return get_translated_tempcode($row['p_description']);
		}
		return new ocp_tempcode();
	}

	/**
	 * Get fields that need to be filled in in the purchase wizard.
	 *
	 * @return ?array		The fields and message text (NULL: none).
	 */
	function get_needed_fields()
	{
		return NULL;
	}

}
