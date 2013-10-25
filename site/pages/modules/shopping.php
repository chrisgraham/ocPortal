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
 * @package		shopping
 */

/**
 * Module page class.
 */
class Module_shopping
{

	/**
	 * Standard modular info function.
	 *
	 * @return ?array	Map of module info (NULL: module is disabled).
	 */
	function info()
	{
		$info=array();
		$info['author']='Manuprathap';
		$info['organisation']='ocProducts';
		$info['hacked_by']=NULL;
		$info['hack_version']=NULL;
		$info['version']=6;
		$info['update_require_upgrade']=1;
		$info['locked']=false;
		return $info;
	}

	/**
	 * Standard modular uninstall function.
	 */
	function uninstall()
	{		
		$GLOBALS['SITE_DB']->drop_table_if_exists('shopping_cart');
		$GLOBALS['SITE_DB']->drop_table_if_exists('shopping_order_details');
		$GLOBALS['SITE_DB']->drop_table_if_exists('shopping_order');
		$GLOBALS['SITE_DB']->drop_table_if_exists('shopping_logging');
		$GLOBALS['SITE_DB']->drop_table_if_exists('shopping_order_addresses');

		$GLOBALS['SITE_DB']->query_delete('group_category_access',array('module_the_name'=>'shopping'));

		delete_menu_item_simple('_SEARCH:catalogues:type=category:catalogue_name=products');

		$GLOBALS['FORUM_DRIVER']->install_delete_custom_field('firstname');
		$GLOBALS['FORUM_DRIVER']->install_delete_custom_field('lastname');
		$GLOBALS['FORUM_DRIVER']->install_delete_custom_field('building_name_or_number');
		$GLOBALS['FORUM_DRIVER']->install_delete_custom_field('city');
		$GLOBALS['FORUM_DRIVER']->install_delete_custom_field('state');
		$GLOBALS['FORUM_DRIVER']->install_delete_custom_field('post_code');
		$GLOBALS['FORUM_DRIVER']->install_delete_custom_field('country');
	}

	/**
	 * Standard modular install function.
	 *
	 * @param  ?integer	What version we're upgrading from (NULL: new install)
	 * @param  ?integer	What hack version we're upgrading from (NULL: new-install/not-upgrading-from-a-hacked-version)
	 */
	function install($upgrade_from=NULL,$upgrade_from_hack=NULL)
	{
		if ((is_null($upgrade_from)) || (!$GLOBALS['SITE_DB']->table_exists('shopping_order'))) // This was badly versioned
		{
			$GLOBALS['SITE_DB']->create_table('shopping_order',array(
				'id'=>'*AUTO',
				'c_member'=>'INTEGER',
				'session_id'=>'INTEGER',
				'add_date'=>'TIME',
				'tot_price'=>'REAL',
				'order_status'=>'ID_TEXT',
				'notes'=>'LONG_TEXT',
				'transaction_id'=>'SHORT_TEXT',
				'purchase_through'=>'SHORT_TEXT',
				'tax_opted_out'=>'BINARY',
			));
			$GLOBALS['SITE_DB']->create_index('shopping_order','finddispatchable',array('order_status'));
			$GLOBALS['SITE_DB']->create_index('shopping_order','soc_member',array('c_member'));
			$GLOBALS['SITE_DB']->create_index('shopping_order','sosession_id',array('session_id'));
			$GLOBALS['SITE_DB']->create_index('shopping_order','soadd_date',array('add_date'));
		} else
		{
			if (is_null($GLOBALS['SITE_DB']->query('SELECT COUNT(DISTINCT tax_opted_out) FROM '.$GLOBALS['SITE_DB']->get_table_prefix().'shopping_order',NULL,NULL,true)))
				$GLOBALS['SITE_DB']->add_table_field('shopping_order','tax_opted_out','BINARY',0); // This was badly versioned
		}

		if (is_null($upgrade_from))
		{	
			$GLOBALS['SITE_DB']->create_table('shopping_cart',array(
				'id'=>'*AUTO',
				'session_id'=>'INTEGER',
				'ordered_by'=>'*MEMBER',
				'product_id'=>'*AUTO_LINK',
				'product_name'=>'SHORT_TEXT',
				'product_code'=>'SHORT_TEXT',
				'quantity'=>'INTEGER',
				'price_pre_tax'=>'REAL',
				'price'=>'REAL',
				'product_description'=>'LONG_TEXT',
				'product_type'=>'SHORT_TEXT',
				'product_weight'=>'REAL',
				'is_deleted'=>'BINARY',
			));
			$GLOBALS['SITE_DB']->create_index('shopping_cart','ordered_by',array('ordered_by'));
			$GLOBALS['SITE_DB']->create_index('shopping_cart','session_id',array('session_id'));
			$GLOBALS['SITE_DB']->create_index('shopping_cart','product_id',array('product_id'));

			$GLOBALS['SITE_DB']->create_table('shopping_order_details',array(
				'id'=>'*AUTO',
				'order_id'=>'?AUTO_LINK',
				'p_id'=>'?AUTO_LINK',
				'p_name'=>'SHORT_TEXT',
				'p_code'=>'SHORT_TEXT',
				'p_type'=>'SHORT_TEXT',
				'p_quantity'=>'INTEGER',
				'p_price'=>'REAL',
				'included_tax'=>'REAL',
				'dispatch_status'=>'SHORT_TEXT'
			));
			$GLOBALS['SITE_DB']->create_index('shopping_order_details','p_id',array('p_id'));
			$GLOBALS['SITE_DB']->create_index('shopping_order_details','order_id',array('order_id'));

			$GLOBALS['SITE_DB']->create_table('shopping_logging',array(
				'id'=>'*AUTO',
				'e_member_id'=>'*MEMBER',
				'session_id'=>'INTEGER',
				'ip'=>'IP',
				'last_action'=>'SHORT_TEXT',
				'date_and_time'=>'TIME'
			));

			$GLOBALS['SITE_DB']->create_table('shopping_order_addresses',array(
				'id'=>'*AUTO',
				'order_id'=>'?AUTO_LINK',
				'address_name'=>'SHORT_TEXT',
				'address_street'=>'LONG_TEXT',
				'address_city'=>'SHORT_TEXT',
				'address_zip'=>'SHORT_TEXT',
				'address_country'=>'SHORT_TEXT',
				'receiver_email'=>'SHORT_TEXT',
			));
			$GLOBALS['SITE_DB']->create_index('shopping_order_addresses','order_id',array('order_id'));

			require_lang('shopping');

			$GLOBALS['SITE_DB']->create_index('shopping_order','recent_shopped',array('add_date'));

			$GLOBALS['SITE_DB']->create_index('shopping_logging','calculate_bandwidth',array('date_and_time'));

			add_menu_item_simple('ecommerce_features',NULL,'ORDERS','_SEARCH:shopping:type=my_orders');

			// CPFs for ecommerce purchase...

			$GLOBALS['FORUM_DRIVER']->install_create_custom_field('firstname',20,1,0,0,0,'','short_text');
			$GLOBALS['FORUM_DRIVER']->install_create_custom_field('lastname',20,1,0,0,0,'','short_text');
			$GLOBALS['FORUM_DRIVER']->install_create_custom_field('building_name_or_number',100,1,0,0,0,'','long_text');
			$GLOBALS['FORUM_DRIVER']->install_create_custom_field('city',20,1,0,0,0,'','short_text');
			$GLOBALS['FORUM_DRIVER']->install_create_custom_field('state',100,1,0,0,0,'','short_text');
			$GLOBALS['FORUM_DRIVER']->install_create_custom_field('post_code',20,1,0,0,0,'','short_text');
			require_code('currency');
			$currencies=get_currency_map();
			$_countries=array();
			foreach ($currencies as $c)
				$_countries=array_merge($_countries,$c);
			$_countries=array_unique($_countries);
			sort($_countries);
			$countries='|'.implode('|',$_countries);
			$GLOBALS['FORUM_DRIVER']->install_create_custom_field('country',100,1,0,0,0,'','list',0,$countries);
		}
	}

	/**
	 * Standard modular entry-point finder function.
	 *
	 * @return ?array	A map of entry points (type-code=>language-code) (NULL: disabled).
	 */
	function get_entry_points()
	{
		return is_guest()?array('misc'=>'SHOPPING'):array('my_orders'=>'MY_ORDERS','misc'=>'SHOPPING');
	}

	var $title;

	/**
	 * Standard modular pre-run function, so we know meta-data for <head> before we start streaming output.
	 *
	 * @return ?tempcode		Tempcode indicating some kind of exceptional output (NULL: none).
	 */
	function pre_run()
	{
		$type=get_param('type','misc');

		require_lang('shopping');

		if ($type=='misc')
		{
			breadcrumb_set_parents(array(array('_SELF:catalogues:misc:ecommerce=1',do_lang_tempcode('CATALOGUES'))));

			$this->title=get_screen_title('SHOPPING');
		}

		if ($type=='add_item')
		{
			$this->title=get_screen_title('SHOPPING');	
		}

		if ($type=='update_cart')
		{
			$this->title=get_screen_title('SHOPPING');
		}

		if ($type=='empty_cart')
		{
			$this->title=get_screen_title('SHOPPING');
		}

		if ($type=='finish')
		{
			breadcrumb_set_parents(array(array('_SELF:catalogues:misc:ecommerce=1',do_lang_tempcode('CATALOGUES')),array('_SELF:_SELF:misc',do_lang_tempcode('SHOPPING'))));

			$this->title=get_screen_title('_PURCHASE_FINISHED');
		}

		if ($type=='my_orders')
		{
			$this->title=get_screen_title('MY_ORDERS');
		}

		if ($type=='order_det')
		{
			breadcrumb_set_parents(array(array('_SELF:orders:misc',do_lang_tempcode('MY_ORDERS'))));

			$id=get_param_integer('id');
			$this->title=get_screen_title('_MY_ORDER_DETAILS',true,array($id));
		}

		return NULL;
	}

	/**
	 * Standard modular run function.
	 *
	 * @return tempcode	The result of execution.
	 */
	function run()
	{	
		@ignore_user_abort(true); // Must keep going till completion

		require_lang('catalogues');
		require_code('shopping');
		require_code('feedback');
		require_lang('ecommerce');
		require_code('ecommerce');

		if (get_forum_type()!='ocf') warn_exit(do_lang_tempcode('NO_OCF'));

		// Kill switch
		if ((ecommerce_test_mode()) && (!$GLOBALS['IS_ACTUALLY_ADMIN']) && (!has_privilege(get_member(),'access_ecommerce_in_test_mode'))) warn_exit(do_lang_tempcode('PURCHASE_DISABLED'));

		$GLOBALS['NO_QUERY_LIMIT']=true;

		$type=get_param('type','misc');

		delete_incomplete_orders();

		if ($type=='misc') return $this->view_shopping_cart();
		if ($type=='add_item') return $this->add_item_to_cart();
		if ($type=='update_cart') return $this->update_cart();
		if ($type=='empty_cart') return $this->empty_cart();
		if ($type=='finish') return $this->finish();
		if ($type=='my_orders') return $this->my_orders();
		if ($type=='order_det') return $this->order_det();

		return new ocp_tempcode();
	}

	/**
	 * The UI to show shopping cart
	 *
	 * @return tempcode		The UI	
	 */
	function view_shopping_cart()
	{
		$pro_ids=array();

		$pro_ids_val=NULL;

		require_code('templates_results_table');
		require_code('form_templates');
		require_css('shopping');
		require_javascript('javascript_shopping');

		log_cart_actions('View cart');

		$where=array('ordered_by'=>get_member(),'is_deleted'=>0);
		if (is_guest())
		{
			$where['session_id']=get_session_id();
		} else
		{
			$where['ordered_by']=get_member();
		}
		$result=$GLOBALS['SITE_DB']->query_select('shopping_cart',array('*'),$where);

		$max_rows=count($result);

		if ($max_rows>0)
		{
			$shopping_cart=new ocp_tempcode();
			$checkout_details=new ocp_tempcode();

			$fields_title=results_field_title(
				array(
					'',
					do_lang_tempcode('PRODUCT_NAME'),
					do_lang_tempcode('UNIT_PRICE'),
					do_lang_tempcode('QUANTITY'),	
					do_lang_tempcode('ORDER_PRICE_AMT'),
					do_lang_tempcode('TAX'),
					do_lang_tempcode('SHIPPING_PRICE'),
					do_lang_tempcode('TOTAL_PRICE'),
					do_lang_tempcode('REMOVE_FROM_CART')
				),NULL
			);

			$i=1;
			$sub_tot=0.0;
			$shipping_cost=0.0;

			foreach ($result as $value)
			{
				$pro_ids[]=$value['product_id'];

				$_hook=$value['product_type'];

				$value['sl_no']=$i;	

				require_code('hooks/systems/ecommerce/'.filter_naughty_harsh($_hook));

				$object=object_factory('Hook_'.filter_naughty_harsh($_hook));

				if (method_exists($object,'show_cart_entry'))
					$object->show_cart_entry($shopping_cart,$value);

				$tax=0;
				if (method_exists($object,'calculate_tax'))
					$tax=$object->calculate_tax($value['price'],$value['price_pre_tax']);

				// Shipping
				if (method_exists($object,'calculate_shipping_cost'))
					$shipping_cost=$object->calculate_shipping_cost($value['product_weight']);
				else
					$shipping_cost=0;	

				$sub_tot+=round($value['price']+$tax+$shipping_cost,2)*$value['quantity'];

				$i++;
			}

			$width=NULL;//array('50','100%','85','85','85','85','85','85','85');

			$results_table=results_table(do_lang_tempcode('SHOPPING'),0,'cart_start',$max_rows,'cart_max',$max_rows,$fields_title,$shopping_cart,NULL,NULL,NULL,'sort',NULL,$width,'cart');

			$update_cart=build_url(array('page'=>'_SELF','type'=>'update_cart'),'_SELF');
			$empty_cart=build_url(array('page'=>'_SELF','type'=>'empty_cart'),'_SELF');

			$payment_form=payment_form();			

			$proceed_box=do_template('ECOM_SHOPPING_CART_PROCEED',array(
				'_GUID'=>'02c90b68ca06620d39a42727766ce8b0',
				'SUB_TOTAL'=>float_format($sub_tot),
				'SHIPPING_COST'=>float_format($shipping_cost),
				'GRAND_TOTAL'=>float_format($sub_tot),
				'PROCEED'=>do_lang_tempcode('PROCEED'),
				'CURRENCY'=>ecommerce_get_currency_symbol(),
				'PAYMENT_FORM'=>$payment_form,
			));
		} else
		{	
			$update_cart=new ocp_tempcode();
			$empty_cart=new ocp_tempcode();
			$checkout=new ocp_tempcode();

			$results_table=do_lang_tempcode('CART_EMPTY');
			$proceed_box=new ocp_tempcode();
		}

		$ecom_catalogue=$GLOBALS['SITE_DB']->query_select_value_if_there('catalogues','c_name',array('c_ecommerce'=>1));

		$cont_shopping=is_null($ecom_catalogue)?new ocp_tempcode():build_url(array('page'=>'catalogues','type'=>'category','catalogue_name'=>$ecom_catalogue),get_module_zone('catalogues'));

		// Product id string for hidden field in Shopping cart
		$pro_ids_val=is_array($pro_ids)?implode(',',$pro_ids):'';

		$allow_opt_out_tax=get_option('allow_opting_out_of_tax');

		$allow_opt_out_tax_value=get_order_tax_opt_out_status();

		$tpl=do_template('ECOM_SHOPPING_CART_SCREEN',array(
			'_GUID'=>'badff09daf52ee1c84b472c44be1bfae',
			'TITLE'=>$this->title,
			'RESULTS_TABLE'=>$results_table,
			'CONTENT'=>'',
			'FORM_URL'=>$update_cart,
			'CONT_SHOPPING'=>$cont_shopping,
			'MESSAGE'=>'',
			'BACK'=>$cont_shopping,
			'PRO_IDS'=>$pro_ids_val,
			'EMPTY_CART'=>$empty_cart,
			'EMPTY'=>do_lang_tempcode('EMPTY_CART'),
			'UPDATE'=>do_lang_tempcode('UPDATE'),
			'CONTINUE_SHOPPING'=>do_lang_tempcode('CONTINUE_SHOPPING'),
			'PROCEED_BOX'=>$proceed_box,
			'ALLOW_OPTOUT_TAX'=>$allow_opt_out_tax,
			'ALLOW_OPTOUT_TAX_VALUE'=>strval($allow_opt_out_tax_value),
		));

		require_code('templates_internalise_screen');
		return internalise_own_screen($tpl);
	}

	/**
	 * Function to add item to cart.
	 *
	 * @return tempcode		The UI
	 */
	function add_item_to_cart()
	{
		if (is_guest())
		{
			require_code('users_inactive_occasionals');
			set_session_id(get_session_id(),true); // Persist guest sessions longer
		}

		$product_details=get_product_details();

		add_to_cart($product_details);

		log_cart_actions('Added to cart');

		$cart_view=build_url(array('page'=>'_SELF','type'=>'misc'),'_SELF');

		return redirect_screen($this->title,$cart_view,do_lang_tempcode('SUCCESS'));		
	}

	/**
	 * Function to Update cart
	 *
	 * @return tempcode			The UI	
	 */
	function update_cart()
	{
		$p_ids=post_param('product_ids');

		$pids=explode(",",$p_ids);

		$product_to_remove=array();

		$product_details=array();

		if (count($pids)>0)
		{
			foreach ($pids as $pid)
			{
				$qty=post_param_integer('quantity_'.$pid);

				$object=find_product($pid);

				if (method_exists($object,'get_available_quantity'))
				{	
					$available_qty=$object->get_available_quantity($pid);	

					if ((!is_null($available_qty)) && ($available_qty<=$qty))
					{
						$qty=$available_qty;

						attach_message(do_lang_tempcode('PRODUCT_QUANTITY_CHANGED',strval($pid)),'warn');
					}
				}

				$product_details[]=array('product_id'=>$pid,'Quantity'=>$qty);

				$remove=post_param_integer('remove_'.$pid,0);

				if ($remove==1)	$product_to_remove	[]=$pid;
			}
		}

		update_cart($product_details);

		log_cart_actions('Updated cart');

		if (count($product_to_remove)>0)
			remove_from_cart($product_to_remove);


		$cart_view=build_url(array('page'=>'_SELF','type'=>'misc'),'_SELF');

		return redirect_screen($this->title,$cart_view,do_lang_tempcode('CART_UPDATED'));
	}

	/**
	 * Function to empty shopping cart
	 *
	 * @return tempcode		The UI
	 */
	function empty_cart()
	{
		log_cart_actions('Cart emptied');

		$where=array();

		if (is_guest())
		{
			$where['session_id']=get_session_id();
		} else
		{
			$where['ordered_by']=get_member();
		}

		$GLOBALS['SITE_DB']->query_update('shopping_cart',array('is_deleted'=>1),$where);

		$cart_view=build_url(array('page'=>'_SELF','type'=>'misc'),'_SELF');

		return redirect_screen($this->title,$cart_view,do_lang_tempcode('CART_EMPTIED'));
	}

	/**
	 * Wrap-up so as to remove redundancy in templates.
	 *
	 * @param  tempcode	To wrap.
	 * @param  tempcode	The title to use.
	 * @param  ?mixed		URL (NULL: no next URL).
	 * @param  boolean	Whether it is a GET form
	 * @return tempcode	Wrapped.
	 */
	function wrap($content,$title,$url,$get=false)
	{
		if (is_null($url)) $url='';
		require_javascript('javascript_validation');

		return do_template('PURCHASE_WIZARD_SCREEN',array('_GUID'=>'02fd80e2b4d4fc2348736a72e504a208','GET'=>$get?true:NULL,'TITLE'=>$title,'CONTENT'=>$content,'URL'=>$url));
	}

	/**
	 * Finish step.
	 *
	 * @return tempcode	The result of execution.
	 */
	function finish()
	{
		$message=get_param('message',NULL,true); // TODO: Assumption, needs to really go through the payment gateway API			#145 on tracker

		if (get_param_integer('cancel',0)==0)
		{
			// Empty the cart.
			$where=array();
			if (is_guest())
			{
				$where['session_id']=get_session_id();
			} else
			{
				$where['ordered_by']=get_member();
			}
			$GLOBALS['SITE_DB']->query_delete('shopping_cart',$where);

			log_cart_actions('Completed payment');

			if (perform_local_payment())
			{
				$trans_id=post_param('trans_id');

				$transaction_rows=$GLOBALS['SITE_DB']->query_select('trans_expecting',array('*'),array('id'=>$trans_id),'',1);
				if (!array_key_exists(0,$transaction_rows)) warn_exit(do_lang_tempcode('MISSING_RESOURCE'));

				$transaction_row=$transaction_rows[0];

				$amount=$transaction_row['e_amount'];
				$length=$transaction_row['e_length'];
				$length_units=$transaction_row['e_length_units'];

				$via=get_option('payment_gateway');
				require_code('hooks/systems/ecommerce_via/'.filter_naughty_harsh($via));
				$object=object_factory('Hook_'.$via);

				$name=post_param('name');
				$card_number=post_param('card_number');
				$expiry_date=str_replace('/','',post_param('expiry_date'));
				$issue_number=post_param_integer('issue_number',NULL);
				$start_date=str_replace('/','',post_param('start_date'));
				$card_type=post_param('card_type');
				$cv2=post_param('cv2');

				list($success,,$message,$message_raw)=$object->do_transaction($trans_id,$name,$card_number,$amount,$expiry_date,$issue_number,$start_date,$card_type,$cv2,$length,$length_units);

				if (($success) || (!is_null($length)))
				{
					$status=((!is_null($length)) && (!$success))?'SCancelled':'Completed';
					handle_confirmed_transaction($transaction_row['e_purchase_id'],$transaction_row['e_item_name'],$status,$message_raw,'','',$amount,get_option('currency'),$trans_id,'',$via,is_null($length)?'':strtolower(strval($length).' '.$length_units));
				}

				if ($success)
				{
					$member_id=$transaction_row['e_member_id'];
					require_code('notifications');
					dispatch_notification('payment_received',NULL,do_lang('PAYMENT_RECEIVED_SUBJECT',$trans_id),do_lang('PAYMENT_RECEIVED_BODY',float_format(floatval($amount)),get_option('currency'),get_site_name()),array($member_id),A_FROM_SYSTEM_PRIVILEGED);
				}
			}

			attach_message(do_lang_tempcode('SUCCESS'),'inform');

			if (count($_POST)!=0)
			{
				$order_id=handle_transaction_script();

				$object=find_product(do_lang('CART-ORDER',$order_id));

				if (method_exists($object,'get_finish_url'))
				{
					return redirect_screen($this->title,$object->get_finish_url(),$message);
				}
			}

			return $this->wrap(do_template('PURCHASE_WIZARD_STAGE_FINISH',array('_GUID'=>'3857e761ab75f314f4960805bc76b936','TITLE'=>$this->title,'MESSAGE'=>$message)),$this->title,NULL);
		}

		if (!is_null($message))
		{
			return $this->wrap(do_template('PURCHASE_WIZARD_STAGE_FINISH',array('_GUID'=>'6eafce1925e5069ceb438ec24754b47d','TITLE'=>$this->title,'MESSAGE'=>$message)),$this->title,NULL);
		}

		return inform_screen(get_screen_title('PURCHASING'),do_lang_tempcode('PRODUCT_PURCHASE_CANCEL'),true);
	}

	/**
	 * Show all my orders
	 *
	 * @return tempcode	The interface.
	 */
	function my_orders()
	{
		$member_id=get_member();

		if (has_privilege(get_member(),'assume_any_member')) $member_id=get_param_integer('id',$member_id);

		$orders=array();

		$rows=$GLOBALS['SITE_DB']->query_select('shopping_order',array('*'),array('c_member'=>$member_id));

		foreach ($rows as $row)
		{
			if ($row['purchase_through']=='cart')
			{
				$order_det_url=build_url(array('page'=>'_SELF','type'=>'order_det','id'=>$row['id']),'_SELF');

				$order_title=do_lang('CART_ORDER',$row['id']);
			}
			else
			{
				$res=$GLOBALS['SITE_DB']->query_select('shopping_order_details',array('p_id','p_name'),array('order_id'=>$row['id']));

				if (!array_key_exists(0,$res)) continue; // DB corruption
				$product_det=$res[0];

				$order_title=$product_det['p_name'];

				$order_det_url=build_url(array('page'=>'catalogues','type'=>'entry','id'=>$product_det['p_id']),get_module_zone('catalogues'));

			}

			$orders[]=array('ORDER_TITLE'=>$order_title,'ID'=>strval($row['id']),'AMOUNT'=>strval($row['tot_price']),'TIME'=>get_timezoned_date($row['add_date'],true,false,true,true),'STATE'=>do_lang_tempcode($row['order_status']),'NOTE'=>'','ORDER_DET_URL'=>$order_det_url,'DELIVERABLE'=>'');
		}

		if (count($orders)==0) inform_exit(do_lang_tempcode('NO_ENTRIES'));

		return do_template('ECOM_ORDERS_SCREEN',array('_GUID'=>'79eb5f17cf4bc2dc4f0cccf438261c73','TITLE'=>$this->title,'CURRENCY'=>get_option('currency'),'ORDERS'=>$orders));
	}

	/**
	 * Show an order details
	 *
	 * @return tempcode	The interface.
	 */
	function order_det()
	{
		$id=get_param_integer('id');

		$products=array();

		$rows=$GLOBALS['SITE_DB']->query_select('shopping_order_details',array('*'),array('order_id'=>$id));
		foreach ($rows as $row)
		{
			$product_info_url=build_url(array('page'=>'catalogues','type'=>'entry','id'=>$row['p_id']),get_module_zone('catalogues'));

			$products[]=array('PRODUCT_NAME'=>$row['p_name'],'ID'=>strval($row['p_id']),'AMOUNT'=>strval($row['p_price']),'QUANTITY'=>strval($row['p_quantity']),'DISPATCH_STATUS'=>do_lang_tempcode($row['dispatch_status']),'PRODUCT_DET_URL'=>$product_info_url,'DELIVERABLE'=>'');
		}

		if (count($products)==0) inform_exit(do_lang_tempcode('NO_ENTRIES'));

		return do_template('ECOM_ORDERS_DETAILS_SCREEN',array('_GUID'=>'8122a53dc0ccf27648af460759a2b6f6','TITLE'=>$this->title,'CURRENCY'=>get_option('currency'),'PRODUCTS'=>$products));
	}
}



