<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

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

/**
 * Handling of a usergroup subscription.
 *
 * @param  ID_TEXT	The purchase ID.
 * @param  array		Details relating to the product.
 * @param  ID_TEXT	The product.
 */
function handle_usergroup_subscription($purchase_id,$details,$product)
{
	$member_id=$GLOBALS['SITE_DB']->query_value_null_ok('subscriptions','s_member_id',array('id'=>intval($purchase_id)));

	if (is_null($member_id)) return;

	require_code('ocf_groups_action');
	require_code('ocf_groups_action2');
	require_code('ocf_members');
	require_code('notifications');

	$usergroup_subscription_id=intval(substr($product,9));
	$dbs_bak=$GLOBALS['NO_DB_SCOPE_CHECK'];
	$GLOBALS['NO_DB_SCOPE_CHECK']=true;
	$rows=$GLOBALS[(get_forum_type()=='ocf')?'FORUM_DB':'SITE_DB']->query_select('f_usergroup_subs',array('*'),array('id'=>$usergroup_subscription_id),'',1);
	$GLOBALS['NO_DB_SCOPE_CHECK']=$dbs_bak;
	if (array_key_exists(0,$rows))
	{
		$myrow=$rows[0];
		$new_group=$myrow['s_group_id'];
		$object=find_product($product);
	} else $object=NULL;

	if (is_null($object))
	{
		return; // The usergroup subscription has been deleted, and this was to remove the payment for it
	}

	$test=$GLOBALS['SITE_DB']->query_value_null_ok_full('SELECT id FROM '.$GLOBALS['SITE_DB']->get_table_prefix().'subscriptions WHERE ('.db_string_equal_to('s_state','cancelled').') AND '.db_string_equal_to('id',$purchase_id));
	if (!is_null($test))
	{
		$test=in_array($new_group,$GLOBALS['FORUM_DRIVER']->get_members_groups($member_id));
		if ($test)
		{
			// Remove them from the group

			if (is_null($GLOBALS[(get_forum_type()=='ocf')?'FORUM_DB':'SITE_DB']->query_value_null_ok('f_group_member_timeouts','member_id',array('member_id'=>$member_id,'group_id'=>$new_group))))
			{
				if ((get_value('unofficial_ecommerce')=='1') && (get_forum_type()!='ocf'))
				{
					$GLOBALS['FORUM_DB']->remove_member_from_group($member_id,$new_group);
				} else
				{
	//				if ($GLOBALS['FORUM_DRIVER']->get_member_row_field($member_id,'m_primary_group')==$new_group)
					if ($myrow['s_uses_primary']==1)
					{
						$GLOBALS[(get_forum_type()=='ocf')?'FORUM_DB':'SITE_DB']->query_update('f_members',array('m_primary_group'=>get_first_default_group()),array('id'=>$member_id),'',1);
					} else
					{
						$GLOBALS[(get_forum_type()=='ocf')?'FORUM_DB':'SITE_DB']->query_delete('f_group_members',array('gm_group_id'=>$new_group,'gm_member_id'=>$member_id));// ,'',1
					}
				}

				dispatch_notification('paid_subscription_ended',NULL/*strval($usergroup_subscription_id)*/,do_lang('PAID_SUBSCRIPTION_ENDED',NULL,NULL,NULL,get_lang($member_id)),get_translated_text($myrow['s_mail_end'],NULL,get_lang($member_id)),array($member_id),A_FROM_SYSTEM_PRIVILEGED);
			}
		}
	} else
	{
		$test=in_array($new_group,$GLOBALS['FORUM_DRIVER']->get_members_groups($member_id));
		if (!$test)
		{
			// Add them to the group

			if ((get_value('unofficial_ecommerce')=='1') && (get_forum_type()!='ocf'))
			{
				$GLOBALS['FORUM_DB']->add_member_to_group($member_id,$new_group);
			} else
			{
				if ($myrow['s_uses_primary']==1)
				{
					$GLOBALS[(get_forum_type()=='ocf')?'FORUM_DB':'SITE_DB']->query_update('f_members',array('m_primary_group'=>$new_group),array('id'=>$member_id),'',1);
				} else
				{
					ocf_add_member_to_group($member_id,$new_group);
				}
			}
			dispatch_notification('paid_subscription_started',NULL/*strval($usergroup_subscription_id)*/,do_lang('PAID_SUBSCRIPTION_STARTED'),get_translated_text($myrow['s_mail_start'],NULL,get_lang($member_id)),array($member_id),A_FROM_SYSTEM_PRIVILEGED);
		}
	}
}

/**
 * eCommerce product hook.
 */
class Hook_usergroup
{

	/**
	 * Function for administrators to pick an identifier (only used by admins, usually the identifier would be picked via some other means in the wider ocPortal codebase).
	 *
	 * @param  ID_TEXT		Product type code.
	 * @return ?tempcode		Input field in standard Tempcode format for fields (NULL: no identifier).
	 */
	function get_identifier_manual_field_inputter($type_code)
	{
		$list=new ocp_tempcode();
		$rows=$GLOBALS['SITE_DB']->query_select('subscriptions',array('*'),array('s_type_code'=>$type_code,'s_state'=>'new'),'ORDER BY id DESC');
		foreach ($rows as $row)
		{
			$username=$GLOBALS['FORUM_DRIVER']->get_username($row['s_member_id']);
			if (is_null($username)) $username=do_lang('UNKNOWN');
			$list->attach(form_input_list_entry(strval($row['id']),false,do_lang('SUBSCRIPTION_OF',strval($row['id']),$username)));
		}
		return form_input_list(do_lang_tempcode('SUBSCRIPTION'),'','purchase_id',$list);
	}

	/**
	 * Find the corresponding member to a given purchase ID.
	 *
	 * @param  ID_TEXT		The purchase ID.
	 * @return ?MEMBER		The member (NULL: unknown / can't perform operation).
	 */
	function member_for($purchase_id)
	{
		return $GLOBALS['SITE_DB']->query_value_null_ok('subscriptions','s_member_id',array('id'=>intval($purchase_id)));
	}

	/**
	 * Get the products handled by this eCommerce hook.
    *
	 * IMPORTANT NOTE TO PROGRAMMERS: This function may depend only on the database, and not on get_member() or any GET/POST values.
    *  Such dependencies will break IPN, which works via a Guest and no dependable environment variables. It would also break manual transactions from the Admin Zone.
	 *
	 * @param  boolean	Whether to make sure the language for item_name is the site default language (crucial for when we read/go to third-party sales systems and use the item_name as a key).
	 * @return array		A map of product name to list of product details.
	 */
	function get_products($site_lang=false)
	{
		if ((get_forum_type()!='ocf') && (get_value('unofficial_ecommerce')!='1')) return array();

		$dbs_bak=$GLOBALS['NO_DB_SCOPE_CHECK'];
		$GLOBALS['NO_DB_SCOPE_CHECK']=true;

		$usergroup_subs=$GLOBALS[(get_forum_type()=='ocf')?'FORUM_DB':'SITE_DB']->query_select('f_usergroup_subs',array('*'),array('s_enabled'=>1));
		$products=array();
		foreach ($usergroup_subs as $sub)
		{
			$item_name=get_translated_text($sub['s_title'],$GLOBALS[(get_forum_type()=='ocf')?'FORUM_DB':'SITE_DB'],$site_lang?get_site_default_lang():NULL);

			$products['USERGROUP'.strval($sub['id'])]=array(PRODUCT_SUBSCRIPTION,$sub['s_cost'],'handle_usergroup_subscription',array('length'=>$sub['s_length'],'length_units'=>$sub['s_length_units']),$item_name);
		}

		$GLOBALS['NO_DB_SCOPE_CHECK']=$dbs_bak;

		return $products;
	}

	/**
	 * Get the message for use in the purchase wizard.
	 *
	 * @param  string		The product in question.
	 * @return tempcode	The message.
	 */
	function get_message($product)
	{
		$dbs_bak=$GLOBALS['NO_DB_SCOPE_CHECK'];
		$GLOBALS['NO_DB_SCOPE_CHECK']=true;

		$id=intval(substr($product,9));
		$_description=$GLOBALS[(get_forum_type()=='ocf')?'FORUM_DB':'SITE_DB']->query_value('f_usergroup_subs','s_description',array('id'=>$id));
		$ret=get_translated_tempcode($_description,$GLOBALS[(get_forum_type()=='ocf')?'FORUM_DB':'SITE_DB']);

		$GLOBALS['NO_DB_SCOPE_CHECK']=$dbs_bak;

		return $ret;
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

	/**
	 * Check whether the product code is available for purchase by the member.
	 *
	 * @param  ID_TEXT	The product.
	 * @param  MEMBER	The member.
	 * @return integer	The availability code (a ECOMMERCE_PRODUCT_* constant).
	 */
	function is_available($product,$member)
	{
		if (is_guest($member)) return ECOMMERCE_PRODUCT_NO_GUESTS;
		if ($GLOBALS['FORUM_DRIVER']->is_super_admin($member)) return ECOMMERCE_PRODUCT_AVAILABLE;

		$id=intval(substr($product,9));
		$dbs_bak=$GLOBALS['NO_DB_SCOPE_CHECK'];
		$GLOBALS['NO_DB_SCOPE_CHECK']=true;
		$group_id=$GLOBALS[(get_forum_type()=='ocf')?'FORUM_DB':'SITE_DB']->query_value('f_usergroup_subs','s_group_id',array('id'=>$id));
		$GLOBALS['NO_DB_SCOPE_CHECK']=$dbs_bak;

		$groups=$GLOBALS['FORUM_DRIVER']->get_members_groups($member);
		if (in_array($group_id,$groups)) return ECOMMERCE_PRODUCT_ALREADY_HAS;
		return ECOMMERCE_PRODUCT_AVAILABLE;
	}
}
