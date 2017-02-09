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
* @package		shopping
*/

class Hook_catalogue_items
{
	/**
	 * Get the products handled by this eCommerce hook.
	 *
	 * IMPORTANT NOTE TO PROGRAMMERS: This function may depend only on the database, and not on get_member() or any GET/POST values.
	 *  Such dependencies will break IPN, which works via a Guest and no dependable environment variables. It would also break manual transactions from the Admin Zone.
	 *
	 * @param  boolean	Whether to make sure the language for item_name is the site default language (crucial for when we read/go to third-party sales systems and use the item_name as a key).
	 * @param  ?ID_TEXT	Product being searched for (NULL: none).
	 * @param  boolean 	Whether $search refers to the product name rather than the product_id.
	 * @return array		A map of product name to list of product details.
	 */
	function get_products($site_lang=false,$search=NULL,$search_titles_not_ids=false)
	{
		if (is_null($search))
		{
			$cnt=$GLOBALS['SITE_DB']->query_value('catalogue_entries t1 LEFT JOIN '.get_table_prefix().'catalogues t2 ON t1.c_name=t2.c_name','COUNT(*)',array('c_ecommerce'=>1));
			if ($cnt>50)
				return array(); // Too many to list
		}

		require_code('catalogues');

		$products=array();

		$where=array('c_ecommerce'=>1);
		if (!is_null($search))
		{
			if (!$search_titles_not_ids)
			{
				if (!is_numeric($search)) return array();
				$where['id']=intval($search);
			} else
			{
				// Unfortunately no easy efficient solution due to inability to do easy querying on catalogue fields. However, practically speaking, this code path will not be called, as catalogue items are purchased as part of a card order rather than separately.
			}
		}

		if (function_exists('set_time_limit')) @set_time_limit(0);

		$start=0;
		do
		{
			$items=$GLOBALS['SITE_DB']->query_select('catalogue_entries t1 LEFT JOIN '.get_table_prefix().'catalogues t2 ON t1.c_name=t2.c_name',array('t1.id','t1.c_name'),$where,'',500,$start);
			foreach ($items as $ecomm_item)
			{
				$map=get_catalogue_entry_field_values($ecomm_item['c_name'],$ecomm_item['id'],NULL,NULL,true);

				$product_title=array_key_exists('effective_value_pure',$map[0])?$map[0]['effective_value_pure']:$map[0]['effective_value'];

				if ((!is_null($search)) && ($search_titles_not_ids))
				{
					if ($product_title!=$search) continue;
				}

				$item_price='0.0';
				$tax=0.0;

				$product_weight=0.0;

				if (array_key_exists(2,$map))
					$item_price=is_object($map[2]['effective_value'])?$map[2]['effective_value']->evaluate():$map[2]['effective_value'];

				if (array_key_exists(6,$map))
					$tax=floatval(preg_replace('#[^\d\.]#','',is_object($map[6]['effective_value'])?$map[6]['effective_value']->evaluate():$map[6]['effective_value']));

				if (array_key_exists(8,$map))
					$product_weight=floatval(is_object($map[8]['effective_value'])?$map[8]['effective_value']->evaluate():$map[8]['effective_value']);

				$price=float_to_raw_string($this->calculate_product_price(floatval($item_price),$tax,$product_weight));

				/* For catalogue items we make the numeric product ID the raw ID for the eCommerce item. This is unique to catalogue items (necessarily so, to avoid conflicts), and we do it for convenience */
				$products[strval($ecomm_item['id'])]=array(PRODUCT_CATALOGUE,$price,'handle_catalogue_items',array('tax'=>$tax),$product_title);
			}
			$start+=500;
		}
		while (count($items)==500);

		return $products;
	}

	/**
	 * Check whether the product code is available for purchase by the member.
	 *
	 * @param  ID_TEXT	The product.
	 * @param  ?MEMBER	The member we are checking against (NULL: current meber).
	 * @param  integer	The number required.
	 * @return boolean	Whether it is.
	 */
	function is_available($product,$member=NULL,$req_quantity=1)
	{
		require_code('catalogues');

		$res=$GLOBALS['SITE_DB']->query_select('catalogue_entries',array('*'),array('id'=>$product),'',1);

		if (!array_key_exists(0,$res)) return false;

		$product_det=$res[0];

		$fields=get_catalogue_entry_field_values($product_det['c_name'],$product_det['id'],NULL,NULL,true);

		$str=NULL;

		if (!array_key_exists(3,$fields)) return true;

		if (is_object($fields[4]['effective_value'])) $fields[4]['effective_value']=$fields[4]['effective_value']->evaluate();
		if ((is_null($fields[4]['effective_value'])) || (intval($fields[4]['effective_value'])==0)) return true;

		if (is_object($fields[3]['effective_value'])) $fields[3]['effective_value']=$fields[3]['effective_value']->evaluate();
		if ($fields[3]['effective_value']!='' && $fields[3]['effective_value']!=do_lang('NA'))
		{
			$available_stock=intval($fields[3]['effective_value']);

			//Locked order check
			$res=$GLOBALS['SITE_DB']->query('SELECT sum(t2.p_quantity) as qty FROM '.get_table_prefix().'shopping_order t1,'.get_table_prefix().'shopping_order_details t2 WHERE t1.id=t2.order_id AND t1.order_status=\'ORDER_STATUS_awaiting_payment\' AND t2.p_id='.strval(intval($product)));

			if (array_key_exists(0,$res))
				$item_count=intval($res[0]['qty']);
			else
				$item_count=0;

			if (($available_stock-$item_count)<$req_quantity) return false; else return true;
		}

		return true;
	}

	/**
	 * Get currently available quantity of selected product
	 *
	 * @param  ID_TEXT	The product.
	 * @return ?integer	Quantity (NULL: no limit).
	 */
	function get_available_quantity($product)
	{
		require_code('catalogues');

		$res=$GLOBALS['SITE_DB']->query_select('catalogue_entries',array('*'),array('id'=>$product));

		if (!array_key_exists(0,$res)) return 0;

		$product_det=$res[0];

		$fields=get_catalogue_entry_field_values($product_det['c_name'],$product_det['id'],NULL,NULL,true);

		$str=NULL;

		if (is_object($fields[3]['effective_value'])) $fields[3]['effective_value']=$fields[3]['effective_value']->evaluate();
		if ((is_null($fields[3]['effective_value'])) || (intval($fields[3]['effective_value'])==0)) return NULL;

		if ($fields[3]['effective_value']!='' && $fields[3]['effective_value']!=do_lang('NA'))
		{
			$available_stock=intval($fields[3]['effective_value']);

			//Locked order check
			$query='SELECT sum(t2.p_quantity) as qty FROM '.get_table_prefix().'shopping_order t1 JOIN '.get_table_prefix().'shopping_order_details t2 ON t1.id=t2.order_id WHERE t1.c_member='.strval($GLOBALS['FORUM_DRIVER']->get_guest_id()).' AND add_date>'.strval(time()-60*60*24).' AND '.db_string_equal_to('t1.order_status','ORDER_STATUS_awaiting_payment').' AND t2.p_id='.strval(intval($product));
			if (is_guest())
			{
				$query.=' AND t1.session_id<>'.strval(get_session_id());
			} else
			{
				$query.=' AND t1.c_member<>'.strval(get_member());
			}
			$res=$GLOBALS['SITE_DB']->query($query);

			if (array_key_exists(0,$res))
				$item_count=intval($res[0]['qty']);
			else
				$item_count=0;

			return ($available_stock-$item_count);
		}

		return NULL;
	}

	/**
	 * Get the message for use in the purchase wizard
	 *
	 * @param  AUTO_LINK		The product in question.
	 * @return tempcode		The message.
	 */
	function get_message($product)
	{
		require_code('catalogues');

		$catalogue_name=$GLOBALS['SITE_DB']->query_value('catalogue_entries','c_name',array('id'=>$product));

		$catalogues=$GLOBALS['SITE_DB']->query_select('catalogues',array('*'),array('c_name'=>$catalogue_name),'',1);

		if (!array_key_exists(0,$catalogues)) warn_exit(do_lang_tempcode('CATALOGUE_NOT_FOUND',$catalogue_name));

		$catalogue=$catalogues[0];

		$entries=$GLOBALS['SITE_DB']->query_select('catalogue_entries',array('*'),array('id'=>$product),'',1);

		if (!array_key_exists(0,$entries)) return warn_screen(get_page_title('CATALOGUES'),do_lang_tempcode('MISSING_RESOURCE'));

		$entry=$entries[0];

		$map=get_catalogue_entry_map($entry,$catalogue,'PAGE',$catalogue_name,$product,NULL,NULL,true,true);

		return do_template('ECOMMERCE_ITEM_DETAILS',$map,NULL,false,'ECOMMERCE_ITEM_DETAILS');
	}

	/**
	 * Get the products details
	 *
	 * @param	?AUTO_LINK	Product ID (NULL: read from environment, product_id)
	 * @return 	array			A map of product name to list of product details.
	 */
	function get_product_details($pid=NULL)
	{
		require_code('catalogues');

		$product_det=array();

		if (is_null($pid))
		{
			$pid=either_param_integer('product_id');
		}

		$qty=post_param_integer('quantity',1);

		$catalogue_name=$GLOBALS['SITE_DB']->query_value_null_ok('catalogue_entries','c_name',array('id'=>$pid));
		if (is_null($catalogue_name)) warn_exit(do_lang_tempcode('MISSING_RESOURCE'));

		$product_det=get_catalogue_entry_field_values($catalogue_name,$pid,NULL,NULL,true);

		foreach ($product_det as $key=>$value)
		{
			$product_det[$key]=array_key_exists('effective_value_pure',$value)?$value['effective_value_pure']:$value['effective_value'];
		}

		for ($i=0;$i<=9;$i++)
		{
			if (!isset($product_det[$i])) $product_det[$i]='';
		}

		$product=array(
						'product_id'=>$pid,
						'product_name'=>$product_det[0],
						'product_code'=>$product_det[1],
						'price'=>$product_det[2],
						'tax'=>preg_replace('#[^\d\.]#','',$product_det[6]),
						'description'=>$product_det[9],
						'quantity'=>$qty,
						'product_type'=>'catalogue_items',
						'product_weight'=>$product_det[8]
					);

		return $product;
	}

	/**
	 * Add an order
	 *
	 * @param  array	Array of product details.
	 * @return AUTO_LINK	Order id of newly added order.
	 */
	function add_order($product_det)
	{
		if (!$this->is_available($product_det['product_id'],get_member(),1))
		{
			warn_exit(do_lang_tempcode('PRODUCT_UNAVAILABLE_NAMED',escape_html($product_det['product_name'])));
		}

		$where=array('product_code'=>$product_det['product_code'],'is_deleted'=>0);
		if (is_guest())
		{
			$where['session_id']=get_session_id();
		} else
		{
			$where['ordered_by']=get_member();
		}
		$qty=$GLOBALS['SITE_DB']->query_value_null_ok('shopping_cart','quantity',$where);

		if ($qty==0)
		{
			$id=$GLOBALS['SITE_DB']->query_insert('shopping_cart',
					array(
						'session_id'=>get_session_id(),
						'ordered_by'=>get_member(),
						'product_id'=>$product_det['product_id'],
						'product_name'=>$product_det['product_name'],
						'product_code'=>$product_det['product_code'],
						'quantity'=>$product_det['quantity'],
						'price'=>round(floatval($product_det['price']),2),
						'price_pre_tax'=>round(floatval($product_det['tax']),2),
						'product_description'=>$product_det['description'],
						'product_type'=>$product_det['product_type'],
						'product_weight'=>floatval($product_det['product_weight']),
						'is_deleted' => 0,
					)
			);
		}
		else
		{
			$where=array('product_name'=>$product_det['product_name'],'product_code'=>$product_det['product_code']);
			if (is_guest())
			{
				$where['session_id']=get_session_id();
			} else
			{
				$where['ordered_by']=get_member();
			}
			$id=$GLOBALS['SITE_DB']->query_update(
				'shopping_cart',
				array(
					'quantity'=>($qty+$product_det['quantity']),
					'price'=>round(floatval($product_det['price']),2),
					'price_pre_tax'=>round(floatval($product_det['tax']),2),
				),
				$where
			);
		}

		return $id;
	}

	/**
	 * Add order - (order coming from purchase module)
	 *
	 * @param AUTO_LINK	Product id
	 * @param array		Product details
	 * @return AUTO_LINK	order id
	 */
	function add_purchase_order($product,$product_det)
	{
		require_lang('shopping');

		if (get_option('allow_opting_out_of_tax')=='1' && post_param_integer('tax_opted_out',0)==1)
			$tax_opted_out=1;
		else
			$tax_opted_out=0;

		if (method_exists($this,'calculate_tax') && $tax_opted_out==0)
		{
			$tax_percentage=array_key_exists(0,$product_det[3])? $product_det[3][0] : 0;
			$tax=round($this->calculate_tax($product_det[1],$tax_percentage),2);
		}
		else
			$tax=0.0;

		$order_id=$GLOBALS['SITE_DB']->query_insert(
			'shopping_order',
			array(
				'c_member'=>get_member(),
				'session_id'=>get_session_id(),
				'add_date'=>time(),
				'tot_price'=>$product_det[1],
				'order_status'=>'ORDER_STATUS_awaiting_payment',
				'notes'=>'',
				'purchase_through'=>'purchase_module',
				'transaction_id'=> '',
				'tax_opted_out'=>$tax_opted_out
			),
			true
		);

		$GLOBALS['SITE_DB']->query_insert(
			'shopping_order_details',
			array(
				'p_id'=>$product,
				'p_name'=>$product_det[4],
				'p_code'=>$product_det[0],
				'p_type'=>'catalogue_items',
				'p_quantity'=>1,
				'p_price'=>$product_det[1],
				'order_id'=>$order_id,
				'dispatch_status' => '',
				'included_tax'=>$tax
			)
		);

		return $order_id;
	}

	/**
	 * Show shopping cart entries
	 *
	 * @param  tempcode	Tempcode object of shopping cart result table.
	 * @param  array		Details of new entry to the shopping cart.
	 * @return tempcode	Tempcode object of shopping cart result table.
	 */
	function show_cart_entry(&$shopping_cart,$entry)
	{
		$tpl_set='cart';

		require_code('images');

		$edit_qnty=do_template('SHOPPING_ITEM_QUANTITY_FIELD',array(
						'PRODUCT_ID'=>strval($entry['product_id']),
						'QUANTITY'=>strval($entry['quantity'])
						)
					);

		$tax=$this->calculate_tax($entry['price'],$entry['price_pre_tax']);

		$shipping_cost=$this->calculate_shipping_cost($entry['product_weight']);

		$del_item=do_template('SHOPPING_ITEM_REMOVE_FIELD',array(
							'PRODUCT_ID'=>strval($entry['product_id']),
							)
					);

		$catalogue_name=$GLOBALS['SITE_DB']->query_value_null_ok('catalogue_entries','c_name',array('id'=>$entry['product_id']));
		if (is_null($catalogue_name))
		{
			$GLOBALS['SITE_DB']->query_delete('shopping_cart',array('product_id'=>$entry['product_id']));
			return new ocp_tempcode();
		}

		$image=$this->get_product_image($catalogue_name,$entry['product_id']);

		if ($image=='')
			$product_image=do_image_thumb('themes/default/images/no_image.png',do_lang('NO_IMAGE'),do_lang('NO_IMAGE'),false,50,50);
		else
			$product_image=do_image_thumb(url_is_local($image)?(get_custom_base_url().'/'.$image):($image),$entry['product_name'],$entry['product_name'],false,50,50);

		$currency=ecommerce_get_currency_symbol();

		$price=round((round($entry['price']+$tax+$shipping_cost,2))*$entry['quantity'],2);

		$total_tax=$tax*$entry['quantity'];
		$total_shipping=$shipping_cost*$entry['quantity'];
		$order_price=$entry["price"]*$entry['quantity'];

		$product_url=build_url(array('page'=>'catalogues','type'=>'entry','id'=>$entry['product_id']),'_SELF');

		$product_link=hyperlink($product_url,$entry['product_name'],false,true,do_lang('INDEX'));

		$shopping_cart->attach(results_entry(
						array(
							$product_image,
							$product_link,
							$currency.escape_html(float_format(round($entry["price"],2))),
							$edit_qnty,
							$currency.escape_html(float_format($order_price)),
							$currency.escape_html(float_format(round($total_tax,2))),
							$currency.escape_html(float_format(round($total_shipping,2))),
							$currency.escape_html(float_format(round($price,2))),
							$del_item
						),false,$tpl_set
					)
				);

		return $shopping_cart;
	}

	/**
	 * Calculate tax of catalogue product.
	 *
	 * @param  float		Gross cost of product.
	 * @param  float		Tax in percentage
	 * @return float		Calculated tax for the product.
	 */
	function calculate_tax($gross_cost,$tax_percentage)
	{
		if (addon_installed('shopping'))
		{
			require_code('shopping');
			if (get_order_tax_opt_out_status()==1) return 0.0;
		}

		$tax=($gross_cost*$tax_percentage)/100.0;
		return $tax;
	}

	/**
	 * Calculate shipping cost of product.
	 *
	 * @param  float		Weight of product
	 * @return float		Calculated shipping cost for the product
	 */
	function calculate_shipping_cost($item_weight)
	{
		$shipping_cost=$item_weight*floatval(get_option('shipping_cost_factor'))/100.0;

		return $shipping_cost;
	}

	/**
	 * Calculate product price
	 *
	 * @param  float		Weight of product
	 * @param  float		Tax in percentage
	 * @param  integer	Weight of item
	 * @return float		Calculated shipping cost for the product
	 */
	function calculate_product_price($item_price,$tax,$item_weight)
	{
		$item_price=round($item_price,2);

		$shipping_cost=$this->calculate_shipping_cost($item_weight);

		if (get_option('allow_opting_out_of_tax')=='1' && post_param_integer('tax_opted_out',0)==1)
			$tax=0.0;
		else
			$tax=$this->calculate_tax($item_price,$tax);

		$product_price=round(($item_price+$tax+$shipping_cost),2);

		return $product_price;
	}

	/**
	 * Find product image for a specific catalogue product
	 *
	 * @param  ID_TEXT		Catalogue name
	 * @param  AUTO_LINK		Catalogue entry id
	 * @return ?SHORT_TEXT	Image name (NULL: no image)
	 */
	function get_product_image($catalogue_name,$entry_id)
	{
		require_code('catalogues');

		$map=get_catalogue_entry_field_values($catalogue_name,$entry_id,NULL,NULL,true);

		$image=NULL;

		if (array_key_exists(7,$map))
			return is_object($map[7]['effective_value'])?$map[7]['effective_value']->evaluate():$map[7]['effective_value'];
		else
			return NULL;
	}

	/**
	 * Calculate product price
	 *
	 * @param  AUTO_LINK	Catalogue entry id
	 * @param  integer	Quantity to deduct
	 */
	function update_stock($entry_id,$quantity)
	{
		require_code('catalogues');

		$stock_level_warn_threshold=0;

		$current_stock=0;

		$stock_maintained=false;

		$res=$GLOBALS['SITE_DB']->query_select('catalogue_entries',array('c_name','cc_id'),array('id'=>$entry_id),'',1);

		if (!array_key_exists(0,$res)) return;

		$row=$res[0];

		$catalogue_name=$row['c_name'];

		$fields=get_catalogue_entry_field_values($catalogue_name,$entry_id,NULL,NULL,true);

		if (array_key_exists(3,$fields))	//Stock level
		{
			if (is_object($fields[3]['effective_value'])) $fields[3]['effective_value']=$fields[3]['effective_value']->evaluate();

			if ($fields[3]['effective_value']=='' || $fields[3]['effective_value']==do_lang('NA'))	return;

			$stock_field=$fields[3]['id'];
			$current_stock=intval($fields[3]['effective_value']);
		}

		if (array_key_exists(5,$fields))	//Stock maintained
		{
			if (is_object($fields[5]['effective_value'])) $fields[5]['effective_value']=$fields[5]['effective_value']->evaluate();

			if (is_null($fields[5]['effective_value'])) return;

			$stock_maintained=($fields[5]['effective_value']==do_lang('YES'));
		}

		if (array_key_exists(4,$fields))	//Stock level warn threshold
		{
			if (is_object($fields[4]['effective_value'])) $fields[4]['effective_value']=$fields[4]['effective_value']->evaluate();

			if (is_null($fields[4]['effective_value'])) return;

			$stock_level_warn_threshold=intval($fields[4]['effective_value']);
		}

		$product_name=$fields[0]['effective_value_pure'];

		if ($current_stock<$quantity && !$stock_maintained)
		{
			require_code('site');
			attach_message(do_lang_tempcode('LOW_STOCK_DISPATCH_FAILED',$product_name));
		}

		$stock_after_dispatch=$current_stock-$quantity;

		if ($stock_after_dispatch<$stock_level_warn_threshold)
		{
			stock_maintain_warn_mail($product_name,$entry_id);
		}

		$GLOBALS['SITE_DB']->query_update('catalogue_efv_integer',array('cv_value'=>intval($stock_after_dispatch)),array('cf_id'=>$stock_field,'ce_id'=>$entry_id));
	}

	/**
	 * Function to return dispatch type of product.
	 *
	 * @return  ID_TEXT	Dispatch type (manual/automatic)
	 */
	function get_product_dispatch_type()
	{
		return 'manual';
	}

	/**
	 * Return product info details
	 *
	 * @param  AUTO_LINK	Product id
	 * @return tempcode	Product information
	 */
	function product_info($id)
	{
		return render_catalogue_entry_screen($id,true);
	}

	/**
	 * Get custom fields for ecommerce product
	 *
	 * @param	AUTO_LINK	Product entry ID
	 * @param	array			Map where product details are placed
	 */
	function get_custom_product_map_fields($id,&$map)
	{
		require_code('feedback');

		require_lang('shopping');

		require_code('ecommerce');

		require_code('images');

		$shopping_cart_url=build_url(array('page'=>'shopping','type'=>'misc'),'_SELF');

		$product_title=NULL;

		if (array_key_exists('FIELD_0',$map))
		{
			$product_title=$map['FIELD_0_PLAIN'];
			if (is_object($product_title)) $product_title=@html_entity_decode(strip_tags($product_title->evaluate()),ENT_QUOTES);
		}

		$licence=method_exists($this,'get_agreement')?$this->get_agreement(strval($id)):'';

		$fields=method_exists($this,'get_needed_fields')?$this->get_needed_fields(strval($id)):NULL;

		if (array_key_exists('FIELD_3',$map))
		{
			if (!is_object($map['FIELD_3']))
			{
				$out_of_stock=($map['FIELD_3']=='0');
			} else
			{
				$out_of_stock=($map['FIELD_3']->evaluate()=='0');
			}
		} else
		{
			$out_of_stock=false;
		}

		$cart_url=build_url(array('page'=>'shopping','type'=>'add_item','hook'=>'catalogue_items'),'_SELF');

		$purchase_mod_url=build_url(array('page'=>'purchase','type'=>($licence=='')?(is_null($fields)?'pay':'details'):'licence','product'=>strval($id),'id'=>$id),'_SELF');

		$map['CART_BUTTONS']=do_template('CATALOGUE_ENTRY_ADD_TO_CART',array('OUT_OF_STOCK'=>$out_of_stock,'ACTION_URL'=>$cart_url,'PRODUCT_ID'=>strval($id),'ALLOW_OPTOUT_TAX'=>get_option('allow_opting_out_of_tax'),'PURCHASE_ACTION_URL'=>$purchase_mod_url,'CART_URL'=>$shopping_cart_url));

		$map['CART_LINK']=show_cart_image();
	}
}

/**
 * Update order status,transaction id after transaction
 *
 * @param  AUTO_LINK	Purchase/Order id.
 * @param  array		Details of product.
 */
function handle_catalogue_items($entry_id,$details)
{
	$object=object_factory('Hook_catalogue_items');
	$object->update_stock($entry_id,1);
}
