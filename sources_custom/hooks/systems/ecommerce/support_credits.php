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

/**
 * Handling of adding support credits to a member's account.
 *
 * @param  ID_TEXT	The key.
 * @param  array	Details relating to the product.
 * @param  ID_TEXT	The product.
 */
function handle_support_credits($_key,$details,$product)
{
	$row=$GLOBALS['SITE_DB']->query_select('credit_purchases',array('member_id','num_credits'),array('purchase_validated'=>0,'purchase_id'=>intval($_key)),'',1);
	if (count ($row) != 1) return;
	$member_id=$row[0]['member_id'];
	$num_credits=$row[0]['num_credits'];
	if (is_null($member_id)) return;

	require_code('ocf_members');
	$cpfs=ocf_get_all_custom_fields_match(NULL,NULL,NULL,NULL,NULL,NULL,NULL,1);
	$cpf_id=NULL;
	foreach ($cpfs as $cpf)
	{
		if ($cpf['trans_name']=='ocp_support_credits')
		{
			$cpf_id=$cpf['id'];
			break;
		}
	}
	if (is_null($cpf_id)) return;

	// Increment the number of credits this customer has
	require_code('ocf_members_action2');
	$fields=ocf_get_custom_field_mappings($member_id);
	ocf_set_custom_field($member_id,$cpf_id,intval($fields['field_'.$cpf_id])+intval($num_credits));

	// Update the row in the credit_purchases table
	$GLOBALS['SITE_DB']->query_update('credit_purchases',array('purchase_validated'=>1),array('purchase_id'=>intval($_key)));
}

/**
 * eCommerce product hook.
 */
class Hook_support_credits
{
	/**
	 * Get the products handled by this eCommerce hook.
	 *
	 * @return array	A map of product name to list of product details.
	 */
	function get_products()
	{
		if (get_forum_type()!='ocf') return array();
		require_lang('customers');
		$products=array(
			'1CREDITS'=>array(PRODUCT_PURCHASE_WIZARD,1*floatval(get_option('support_credit_value')),'handle_support_credits',NULL,do_lang('CUSTOMER_SUPPORT_CREDIT')),			/* £5.50, by default */
			'2CREDITS'=>array(PRODUCT_PURCHASE_WIZARD,2*floatval(get_option('support_credit_value')),'handle_support_credits',NULL,do_lang('CUSTOMER_SUPPORT_CREDITS','2')),	/* approx. £17, 0.5 hours on budget */
			'3CREDITS'=>array(PRODUCT_PURCHASE_WIZARD,3*floatval(get_option('support_credit_value')),'handle_support_credits',NULL,do_lang('CUSTOMER_SUPPORT_CREDITS','3')),	/* approx. £17, 0.5 hours on budget */
			'4CREDITS'=>array(PRODUCT_PURCHASE_WIZARD,4*floatval(get_option('support_credit_value')),'handle_support_credits',NULL,do_lang('CUSTOMER_SUPPORT_CREDITS','4')),	/* approx. £17, 0.5 hours on budget */
			'5CREDITS'=>array(PRODUCT_PURCHASE_WIZARD,5*floatval(get_option('support_credit_value')),'handle_support_credits',NULL,do_lang('CUSTOMER_SUPPORT_CREDITS','5')),		/* approx. £30 */
			'6CREDITS'=>array(PRODUCT_PURCHASE_WIZARD,6*floatval(get_option('support_credit_value')),'handle_support_credits',NULL,do_lang('CUSTOMER_SUPPORT_CREDITS','6')),		/* approx. £30 */
			'9CREDITS'=>array(PRODUCT_PURCHASE_WIZARD,9*floatval(get_option('support_credit_value')),'handle_support_credits',NULL,do_lang('CUSTOMER_SUPPORT_CREDITS','9')),	/* approx. £50, 1.5 hours on budget */
			'20CREDITS'=>array(PRODUCT_PURCHASE_WIZARD,20*floatval(get_option('support_credit_value')),'handle_support_credits',NULL,do_lang('CUSTOMER_SUPPORT_CREDITS','20')),	/* approx. £100 */
			'25CREDITS'=>array(PRODUCT_PURCHASE_WIZARD,25*floatval(get_option('support_credit_value')),'handle_support_credits',NULL,do_lang('CUSTOMER_SUPPORT_CREDITS','25')),	/* approx. £140 */
			'35CREDITS'=>array(PRODUCT_PURCHASE_WIZARD,35*floatval(get_option('support_credit_value')),'handle_support_credits',NULL,do_lang('CUSTOMER_SUPPORT_CREDITS','35')),	/* approx. £200 */
			'50CREDITS'=>array(PRODUCT_PURCHASE_WIZARD,50*floatval(get_option('support_credit_value')),'handle_support_credits',NULL,do_lang('CUSTOMER_SUPPORT_CREDITS','50')),	/* approx. £300 */
			'90CREDITS'=>array(PRODUCT_PURCHASE_WIZARD,90*floatval(get_option('support_credit_value')),'handle_support_credits',NULL,do_lang('CUSTOMER_SUPPORT_CREDITS','90')),	/* approx. £500 */
			'180CREDITS'=>array(PRODUCT_PURCHASE_WIZARD,180*floatval(get_option('support_credit_value')),'handle_support_credits',NULL,do_lang('CUSTOMER_SUPPORT_CREDITS','180')),	/* approx. £1000 */
			'550CREDITS'=>array(PRODUCT_PURCHASE_WIZARD,550*floatval(get_option('support_credit_value')),'handle_support_credits',NULL,do_lang('CUSTOMER_SUPPORT_CREDITS','550')),	/* approx. £3000 */
		);

		return $products;
	}

	/**
	 * Get the message for use in the purchase wizard.
	 *
	 * @param  string	The product in question.
	 * @return tempcode	The message.
	 */
	function get_message($product)
	{
		return do_lang('SUPPORT_CREDITS_PRODUCT_DESCRIPTION');
	}

	function get_agreement()
	{
		require_code('textfiles');
		return read_text_file('support_credits_licence','EN');
	}

	/**
	 * Find the corresponding member to a given key.
	 *
	 * @param  ID_TEXT		The key.
	 * @return ?MEMBER		The member (NULL: unknown / can't perform operation).
	 */
	function member_for($key)
	{
		return $GLOBALS['SITE_DB']->query_select_value_if_there('credit_purchases','member_id',array('purchase_id'=>intval($key)));
	}

	function get_needed_fields()
	{
		if (!has_actual_page_access(get_member(),'admin_ecommerce',get_module_zone('admin_ecommerce'))) return NULL;

		// Check if we've already been passed a member ID and use it to pre-populate the field
		$member_id=get_param_integer('member_id',NULL);
		if (!is_null($member_id)) $username=$GLOBALS['FORUM_DRIVER']->get_username($member_id);
		else $username=$GLOBALS['FORUM_DRIVER']->get_username(get_member());

		return form_input_username(do_lang('USERNAME'),do_lang('USERNAME_CREDITS_FOR'),'member_username',$username,true);
	}

	/**
	 * Get the filled in fields and do something with them.
	 *
	 * @param  ID_TEXT	The product name
	 * @return ID_TEXT		The purchase id.
	 */
	function set_needed_fields($product)
	{
		$num_credits=substr($product,0,-7);
		$manual=0;
		$member_id=get_member();

		// Allow admins to specify the member who should receive the credits with the field in get_needed_fields
		if (has_actual_page_access(get_member(),'admin_ecommerce',get_module_zone('admin_ecommerce')))
		{
			$id=post_param_integer('member_id',NULL);
			if (!is_null($id))
			{
				$manual=1;
				$member_id=$id;
			}
			else
			{
				$username=post_param('member_username',NULL);
				if (!is_null($username))
				{
					$manual=1;
					$member_id=$GLOBALS['FORUM_DRIVER']->get_member_from_username($username);
				}
			}
		}

		return strval($GLOBALS['SITE_DB']->query_insert('credit_purchases',array('member_id'=>$member_id,'date_and_time'=>time(),'num_credits'=>$num_credits,'is_manual'=>$manual,'purchase_validated'=>0),true));
	}

	/**
	 * Check whether the product code is available for purchase by the member.
	 *
	 * @param  ID_TEXT	The product.
	 * @param  MEMBER		The member.
	 * @return boolean	Whether it is.
	 */
	function is_available($product,$member)
	{
		return $member!=$GLOBALS['FORUM_DRIVER']->get_guest_id();
	}
}
