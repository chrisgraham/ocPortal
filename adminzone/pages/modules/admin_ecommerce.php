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

require_code('crud_module');

/**
 * Module page class.
 */
class Module_admin_ecommerce extends standard_crud_module
{
	var $lang_type='USERGROUP_SUBSCRIPTION';
	var $select_name='TITLE';
	var $select_name_description='DESCRIPTION_TITLE';
	var $menu_label='ECOMMERCE';
	var $table='f_usergroup_subs';
	var $orderer='s_title';
	var $title_is_multi_lang=true;

	var $javascript="
		var _length_units=document.getElementById('length_units'),_length=document.getElementById('length');
		var adjust_lengths=function()
		{
			var length_units=_length_units.options[_length_units.selectedIndex].value,length=_length.value;
			if ((length_units=='d') && ((length<1) || (length>90)))
				_length.value=(length<1)?1:90;
			if ((length_units=='w') && ((length<1) || (length>52)))
				_length.value=(length<1)?1:52;
			if ((length_units=='m') && ((length<1) || (length>24)))
				_length.value=(length<1)?1:24;
			if ((length_units=='y') && ((length<1) || (length>5)))
				_length.value=(length<1)?1:5;
		}
		_length_units.onchange=adjust_lengths;
		_length.onchange=adjust_lengths;
	";

	/**
	 * Standard modular info function.
	 *
	 * @return ?array	Map of module info (NULL: module is disabled).
	 */
	function info()
	{
		$info=array();
		$info['author']='Chris Graham';
		$info['organisation']='ocProducts';
		$info['hacked_by']=NULL;
		$info['hack_version']=NULL;
		$info['version']=2;
		$info['locked']=false;
		return $info;
	}

	/**
	 * Standard modular entry-point finder function.
	 *
	 * @return ?array	A map of entry points (type-code=>language-code) (NULL: disabled).
	 */
	function get_entry_points()
	{
		return array_merge(parent::get_entry_points(),array('misc'=>'CUSTOM_PRODUCT_USERGROUP','logs'=>'TRANSACTIONS','trigger'=>'MANUAL_TRANSACTION','profit_loss'=>'PROFIT_LOSS','cash_flow'=>'CASH_FLOW'));
	}

	var $title;

	/**
	 * Standard modular pre-run function, so we know meta-data for <head> before we start streaming output.
	 *
	 * @param  boolean		Whether this is running at the top level, prior to having sub-objects called.
	 * @param  ?ID_TEXT		The screen type to consider for meta-data purposes (NULL: read from environment).
	 * @return ?tempcode		Tempcode indicating some kind of exceptional output (NULL: none).
	 */
	function pre_run($top_level=true,$type=NULL)
	{
		$type=get_param('type','misc');

		require_lang('ecommerce');

		if ($type!='logs')
		{
			set_helper_panel_pic('pagepics/ecommerce');
			set_helper_panel_tutorial('tut_ecommerce');
		}

		if ($type=='cash_flow')
		{
			set_helper_panel_pic('pagepics/cash_flow');

			breadcrumb_set_parents(array(array('_SELF:_SELF:ecom_usage',do_lang_tempcode('ECOMMERCE'))));
			breadcrumb_set_self(do_lang_tempcode('RESULT'));

			$this->title=get_screen_title('CASH_FLOW');
		}

		if ($type=='profit_loss')
		{
			set_helper_panel_pic('pagepics/profit_loss');

			breadcrumb_set_parents(array(array('_SELF:_SELF:ecom_usage',do_lang_tempcode('ECOMMERCE'))));
			breadcrumb_set_self(do_lang_tempcode('RESULT'));

			$this->title=get_screen_title('PROFIT_LOSS');
		}

		if ($type=='misc')
		{
			$also_url=build_url(array('page'=>'_SELF','type'=>'ecom_usage'),'_SELF');
			attach_message(do_lang_tempcode('menus:ALSO_SEE_USAGE',escape_html($also_url->evaluate())),'inform');

			$this->title=get_screen_title('CUSTOM_PRODUCT_USERGROUP');
		}

		if ($type=='ecom_usage')
		{
			$also_url=build_url(array('page'=>'_SELF','type'=>'misc'),'_SELF');
			attach_message(do_lang_tempcode('menus:ALSO_SEE_SETUP',escape_html($also_url->evaluate())),'inform');

			$this->title=get_screen_title('ECOMMERCE');
		}

		if ($type=='logs')
		{
			breadcrumb_set_parents(array(array('_SELF:_SELF:ecom_usage',do_lang_tempcode('ECOMMERCE'))));
			breadcrumb_set_self(do_lang_tempcode('TRANSACTIONS'));

			$this->title=get_screen_title('TRANSACTIONS');
		}

		if ($type=='trigger')
		{
			breadcrumb_set_self(do_lang_tempcode('PRODUCT'));
			breadcrumb_set_parents(array(array('_SELF:_SELF:ecom_usage',do_lang_tempcode('ECOMMERCE'))));

			$this->title=get_screen_title('MANUAL_TRANSACTION');
		}

		if ($type=='trigger')
		{
			breadcrumb_set_self(do_lang_tempcode('DONE'));
			$item_name=get_param('item_name',NULL);
			if (is_null($item_name))
			{
				breadcrumb_set_parents(array(array('_SELF:_SELF:ecom_usage',do_lang_tempcode('ECOMMERCE')),array('_SELF:_SELF:trigger',do_lang_tempcode('PRODUCT'))));
			} else
			{
				breadcrumb_set_parents(array(array('_SELF:_SELF:ecom_usage',do_lang_tempcode('ECOMMERCE')),array('_SELF:_SELF:trigger',do_lang_tempcode('PRODUCT')),array('_SELF:_SELF:trigger:item_name='.$item_name,do_lang_tempcode('MANUAL_TRANSACTION'))));
			}

			$this->title=get_screen_title('MANUAL_TRANSACTION');
		}

		if ($type=='view_manual_subscriptions')
		{
			$this->title=get_screen_title('MANUAL_SUBSCRIPTIONS');
		}

		if ($type=='cancel_subscription')
		{
			$this->title=get_screen_title('CANCEL_MANUAL_SUBSCRIPTION');
		}

		if (($type=='ad') || ($type=='_ad') || ($type=='ed') || ($type=='_ed') || ($type=='__ed'))
		{
			if (get_forum_type()=='ocf')
			{
				breadcrumb_set_parents(array(array('_SEARCH:admin_ocf_join:menu',do_lang_tempcode('MEMBERS'))));
			}
		}

		return parent::pre_run($top_level);
	}

	/**
	 * Standard crud_module run_start.
	 *
	 * @param  ID_TEXT		The type of module execution
	 * @return tempcode		The output of the run
	 */
	function run_start($type)
	{
		require_code('ecommerce');
		require_code('ecommerce2');

		if ((get_value('unofficial_ecommerce')!='1') && (count(find_all_hooks('systems','ecommerce'))==8))
		{
			if (get_forum_type()!='ocf') warn_exit(do_lang_tempcode('NO_OCF')); else ocf_require_all_forum_stuff();
		}

		$this->add_one_label=do_lang_tempcode('ADD_USERGROUP_SUBSCRIPTION');
		$this->edit_this_label=do_lang_tempcode('EDIT_THIS_USERGROUP_SUBSCRIPTION');
		$this->edit_one_label=do_lang_tempcode('EDIT_USERGROUP_SUBSCRIPTION');

		if ($type=='misc') return $this->misc();
		if ($type=='logs') return $this->logs();
		if ($type=='ecom_usage') return $this->usage();
		if ($type=='cash_flow') return $this->cash_flow();
		if ($type=='profit_loss') return $this->profit_loss();
		//if ($type=='balance_sheet') return $this->balance_sheet();
		if ($type=='trigger') return $this->trigger();
		if ($type=='_trigger') return $this->_trigger();
		if ($type=='view_manual_subscriptions') return $this->view_manual_subscriptions();
		if ($type=='cancel_subscription') return $this->cancel_subscription();

		return new ocp_tempcode();
	}

	/**
	 * The do-next manager for before setup management.
	 *
	 * @return tempcode		The UI
	 */
	function misc()
	{
		require_code('templates_donext');
		return do_next_manager($this->title,comcode_lang_string('DOC_USERGROUP_SUBSCRIPTION'),
			array(
				/*	 type							  page	 params													 zone	  */
				((get_forum_type()!='ocf') && (get_value('unofficial_ecommerce')!='1'))?NULL:array('add_one',array('_SELF',array('type'=>'ad'),'_SELF'),do_lang('ADD_USERGROUP_SUBSCRIPTION')),
				((get_forum_type()!='ocf') && (get_value('unofficial_ecommerce')!='1'))?NULL:array('edit_one',array('_SELF',array('type'=>'ed'),'_SELF'),do_lang('EDIT_USERGROUP_SUBSCRIPTION')),
			),
			do_lang('CUSTOM_PRODUCT_USERGROUP')
		);
	}

	/**
	 * The do-next manager for before usage management.
	 *
	 * @return tempcode		The UI
	 */
	function usage()
	{
		require_code('templates_donext');
		return do_next_manager($this->title,comcode_lang_string('DOC_ECOMMERCE'),
			array(
				/*	 type							  page	 params													 zone	  */
				array('cash_flow',array('_SELF',array('type'=>'cash_flow'),'_SELF'),do_lang('CASH_FLOW')),
				array('profit_loss',array('_SELF',array('type'=>'profit_loss'),'_SELF'),do_lang('PROFIT_LOSS')),
				array('add_to_category',array('_SELF',array('type'=>'trigger'),'_SELF'),do_lang('MANUAL_TRANSACTION')),
				array('transactions',array('_SELF',array('type'=>'logs'),'_SELF'),do_lang('LOGS')),
				array('invoices',array('admin_invoices',array('type'=>'misc'),get_module_zone('admin_invoices')),do_lang('INVOICES')),
				addon_installed('shopping')?array('orders',array('admin_orders',array('type'=>'misc'),get_module_zone('admin_orders')),do_lang('shopping:ORDERS')):NULL,
				array('invoices',array('_SELF',array('type'=>'view_manual_subscriptions'),'_SELF'),do_lang('MANUAL_SUBSCRIPTIONS')),
			),
			do_lang('ECOMMERCE')
		);
	}

	/**
	 * The UI to view all point transactions ordered by date.
	 *
	 * @return tempcode		The UI
	 */
	function logs()
	{
		$start=get_param_integer('start',0);
		$max=get_param_integer('max',50);
		$sortables=array('t_time'=>do_lang_tempcode('DATE'),'amount'=>do_lang_tempcode('AMOUNT'));
		$test=explode(' ',get_param('sort','t_time DESC'),2);
		if (count($test)==1) $test[1]='DESC';
		list($sortable,$sort_order)=$test;
		if (((strtoupper($sort_order)!='ASC') && (strtoupper($sort_order)!='DESC')) || (!array_key_exists($sortable,$sortables)))
			log_hack_attack_and_exit('ORDERBY_HACK');

		$where=NULL;
		$product=get_param('product',NULL);
		$id=get_param('id',NULL);
		if (!is_null($product))
		{
			$where=array('item'=>$product);
			if ((!is_null($id)) && ($id!=''))
			{
				$where['purchase_id']=$id;
			}
		}
		$max_rows=$GLOBALS['SITE_DB']->query_select_value('transactions','COUNT(*)',$where);
		$rows=$GLOBALS['SITE_DB']->query_select('transactions',array('*'),$where,'ORDER BY '.$sortable.' '.$sort_order,$max,$start);
		if (count($rows)==0)
		{
			return inform_screen($this->title,do_lang_tempcode('NO_ENTRIES'));
		}
		$fields=new ocp_tempcode();
		require_code('templates_results_table');
		$fields_title=results_field_title(array(do_lang('TRANSACTION'),do_lang('IDENTIFIER'),do_lang('LINKED_ID'),do_lang('DATE'),do_lang('AMOUNT'),do_lang('CURRENCY'),do_lang('PRODUCT'),do_lang('STATUS'),do_lang('REASON'),do_lang('PENDING_REASON'),do_lang('NOTES'),do_lang('MEMBER')),$sortables,'sort',$sortable.' '.$sort_order);
		foreach ($rows as $myrow)
		{
			$date=get_timezoned_date($myrow['t_time']);

			if ($myrow['status']!='Completed')
			{
				$trigger_url=build_url(array('page'=>'_SELF','type'=>'trigger','product'=>$myrow['item'],'id'=>$myrow['purchase_id']),'_SELF');
				$status=do_template('ECOM_TRANSACTION_LOGS_MANUAL_TRIGGER',array('_GUID'=>'5e770b9b30db88032bcc56efe8e3dc23','STATUS'=>$myrow['status'],'TRIGGER_URL'=>$trigger_url));
			} else $status=protect_from_escaping(escape_html($myrow['status']));

			// Find member link, if possible
			$member_id=NULL;
			$product_ob=find_product($myrow['item']);
			if (!is_null($product_ob))
			{
				$member_id=method_exists($product_ob,'member_for')?$product_ob->member_for($myrow['purchase_id']):NULL;
			}
			if (!is_null($member_id))
			{
				$member_link=$GLOBALS['FORUM_DRIVER']->member_profile_hyperlink($member_id,false,'',false);
			} else $member_link=do_lang_tempcode('UNKNOWN_EM');

			$fields->attach(results_entry(array(escape_html($myrow['id']),escape_html($myrow['purchase_id']),escape_html($myrow['linked']),escape_html($date),escape_html($myrow['amount']),escape_html($myrow['t_currency']),escape_html($myrow['item']),$status,escape_html($myrow['reason']),escape_html($myrow['pending_reason']),escape_html($myrow['t_memo']),$member_link)));
		}

		$results_table=results_table(do_lang('TRANSACTIONS'),$start,'start',$max,'max',$max_rows,$fields_title,$fields,$sortables,$sortable,$sort_order,'sort');

		$post_url=build_url(array('page'=>'_SELF','type'=>'logs'/*,'start'=>$start,'max'=>$max*/,'sort'=>$sortable.' '.$sort_order),'_SELF');

		$products=new ocp_tempcode();
		$product_rows=$GLOBALS['SITE_DB']->query_select('transactions',array('DISTINCT item'),NULL,'ORDER BY item');
		foreach ($product_rows as $p)
		{
			$products->attach(form_input_list_entry($p['item']));
		}

		$tpl=do_template('ECOM_TRANSACTION_LOGS_SCREEN',array('_GUID'=>'a6ba07e4be36ecc85157511e3807df75','TITLE'=>$this->title,'PRODUCTS'=>$products,'URL'=>$post_url,'RESULTS_TABLE'=>$results_table));

		require_code('templates_internalise_screen');
		return internalise_own_screen($tpl);
	}

	/**
	 * The UI to take details on a manually triggered transaction.
	 *
	 * @return tempcode	The UI.
	 */
	function trigger()
	{
		require_code('form_templates');
		$fields=new ocp_tempcode();

		url_default_parameters__enable();

		// Choose product
		$item_name=get_param('item_name',NULL);
		if (is_null($item_name))
		{
			$products=find_all_products();
			$list=new ocp_tempcode();
			foreach ($products as $product=>$details)
			{
				if (!is_string($product)) $product=strval($product);
				$label=$details[4];
				$label.=' ('.escape_html($product);

				if ($details[1]!==NULL)
					$label.=', '.ecommerce_get_currency_symbol().escape_html(is_float($details[1])?float_to_raw_string($details[1],2):$details[1]);
				$label.=')';
				$list->attach(form_input_list_entry($product,do_lang('CUSTOM_PRODUCT_'.$product,NULL,NULL,NULL,NULL,false)===get_param('product',NULL),protect_from_escaping($label)));
			}
			$fields->attach(form_input_huge_list(do_lang_tempcode('PRODUCT'),'','item_name',$list,NULL,true));

			$submit_name=do_lang('CHOOSE');

			url_default_parameters__disable();

			return do_template('FORM_SCREEN',array('_GUID'=>'a2fe914c23e378c493f6e1dad0dc11eb','TITLE'=>$this->title,'SUBMIT_NAME'=>$submit_name,'FIELDS'=>$fields,'TEXT'=>'','URL'=>get_self_url(),'GET'=>true,'HIDDEN'=>''));
		}

		$post_url=build_url(array('page'=>'_SELF','type'=>'_trigger','redirect'=>get_param('redirect',NULL)),'_SELF');
		$text=do_lang('MANUAL_TRANSACTION_TEXT');
		$submit_name=do_lang('MANUAL_TRANSACTION');

		$product_ob=find_product($item_name);

		// To work out key
		if (post_param_integer('got_purchase_key_dependencies',0)==0)
		{
			$needed_fields=method_exists($product_ob,'get_needed_fields')?$product_ob->get_needed_fields($item_name):NULL;
			if (!is_null($needed_fields)) // Only do step if we actually have fields - create intermediary step. get_self_url ensures first product-choose step choice is propagated.
			{
				$submit_name=do_lang('PROCEED');
				$extra_hidden=new ocp_tempcode();
				$extra_hidden->attach(form_input_hidden('got_purchase_key_dependencies','1'));
				if (is_array($needed_fields))
					$extra_hidden->attach($needed_fields[0]);

				url_default_parameters__disable();

				return do_template('FORM_SCREEN',array('_GUID'=>'90ee397ac24dcf0b3a0176da9e9c9741','TITLE'=>$this->title,'SUBMIT_NAME'=>$submit_name,'FIELDS'=>is_array($needed_fields)?$needed_fields[1]:$needed_fields,'TEXT'=>'','URL'=>get_self_url(),'HIDDEN'=>$extra_hidden));
			}
		}

		// Remaining fields, customised for product chosen
		if (method_exists($product_ob,'get_identifier_manual_field_inputter'))
		{
			$f=$product_ob->get_identifier_manual_field_inputter($item_name);
			if (!is_null($f)) $fields->attach($f);
		} else
		{
			$default_purchase_id=get_param('id',NULL);
			if (is_null($default_purchase_id))
			{	
				if (method_exists($product_ob,'set_needed_fields'))
					$default_purchase_id=$product_ob->set_needed_fields($item_name);
				else
					$default_purchase_id=strval(get_member());
			}

			$fields->attach(form_input_codename(do_lang_tempcode('IDENTIFIER'),do_lang('MANUAL_TRANSACTION_IDENTIFIER'),'purchase_id',$default_purchase_id,false));
		}
		$fields->attach(form_input_text(do_lang_tempcode('NOTES'),do_lang('TRANSACTION_NOTES'),'memo','',false));

		$products=$product_ob->get_products();
		if ($products[$item_name][0]==PRODUCT_SUBSCRIPTION)
			$fields->attach(form_input_date(do_lang_tempcode('CUSTOM_EXPIRY_DATE'),do_lang_tempcode('DESCRIPTION_CUSTOM_EXPIRY_DATE'),'cexpiry',true,false,false));

		$fields->attach(do_template('FORM_SCREEN_FIELD_SPACER',array('_GUID'=>'f4e52dff9353fb767afbe0be9808591c','SECTION_HIDDEN'=>true,'TITLE'=>do_lang_tempcode('ADVANCED'))));
		$fields->attach(form_input_float(do_lang_tempcode('AMOUNT'),do_lang_tempcode('MONEY_AMOUNT_DESCRIPTION',ecommerce_get_currency_symbol()),'amount',NULL,false));

		$hidden=new ocp_tempcode();
		$hidden->attach(form_input_hidden('item_name',$item_name));

		url_default_parameters__disable();

		return do_template('FORM_SCREEN',array('_GUID'=>'990d955cb14b6681685ec9e1d1448d9d','TITLE'=>$this->title,'SUBMIT_NAME'=>$submit_name,'FIELDS'=>$fields,'TEXT'=>$text,'URL'=>$post_url,'HIDDEN'=>$hidden));
	}

	/**
	 * The actualiser for a manually triggered transaction.
	 *
	 * @return tempcode	The result of execution.
	 */
	function _trigger()
	{
		$item_name=post_param('item_name');

		$purchase_id=post_param('purchase_id','');
		$memo=post_param('memo');
		$mc_gross=post_param('amount','');
		$custom_expiry=get_input_date('cexpiry');
		
		$object=find_product($item_name);
		$products=$object->get_products(true);
		if ($mc_gross=='')
		{
			$mc_gross=$products[$item_name][1];
		}
		$payment_status='Completed';
		$reason_code='';
		$pending_reason='';
		$mc_currency=get_option('currency');
		$txn_id='manual-'.substr(uniqid('',true),0,10);
		$parent_txn_id='';

		$_item_name=$products[$item_name][4];

		if ($products[$item_name][0]==PRODUCT_SUBSCRIPTION)
		{
			if ($purchase_id=='')
			{
				$member_id=get_member();
				$username=post_param('username','');
				if ($username!='')
				{
					$_member_id=$GLOBALS['FORUM_DRIVER']->get_member_from_username($username);
					if (!is_null($_member_id)) $member_id=$_member_id;
				}

				$purchase_id=strval($GLOBALS['SITE_DB']->query_insert('subscriptions',array(
					's_type_code'=>$item_name,
					's_member_id'=>$member_id,
					's_state'=>'new',
					's_amount'=>$products[$item_name][1],
					's_special'=>$purchase_id,
					's_time'=>time(),
					's_auto_fund_source'=>'',
					's_auto_fund_key'=>'',
					's_via'=>'manual',
				),true));
			}

			$_item_name=''; // Flag for handle_confirmed_transaction to know it's a subscription

			if ($custom_expiry!==NULL)
			{
				$s_length=$products[$item_name][3]['length'];
				$s_length_units=$products[$item_name][3]['length_units']; // y-year, m-month, w-week, d-day
				$time_period_units=array('y'=>'year','m'=>'month','w'=>'week','d'=>'day');
				$new_s_time=strtotime('-'.strval($s_length).' '.$time_period_units[$s_length_units],$custom_expiry);
				$GLOBALS['SITE_DB']->query_update('subscriptions',array('s_time'=>$new_s_time),array('id'=>$purchase_id));
			}
		}

		handle_confirmed_transaction($purchase_id,$_item_name,$payment_status,$reason_code,$pending_reason,$memo,$mc_gross,$mc_currency,$txn_id,$parent_txn_id);

		$url=get_param('redirect',NULL);
		if (!is_null($url)) return redirect_screen($this->title,$url,do_lang_tempcode('SUCCESS'));

		return inform_screen($this->title,do_lang_tempcode('SUCCESS'));
	}

	/**
	 * An interface for choosing between dates.
	 *
	 * @param  tempcode	The title to display.
	 * @return tempcode	The result of execution.
	 */
	function _get_between($title)
	{
		require_code('form_templates');

		$fields=new ocp_tempcode();
		$month_start=array(0,0,intval(date('m')),1,intval(date('Y')));
		$fields->attach(form_input_date(do_lang_tempcode('FROM'),'','from',false,false,false,$month_start,10,intval(date('Y'))-9));
		$fields->attach(form_input_date(do_lang_tempcode('TO'),'','to',false,false,false,time(),10,intval(date('Y'))-9));

		return do_template('FORM_SCREEN',array(
			'_GUID'=>'92888622a3ed6b7edbd4d1e5e2b35986',
			'GET'=>true,
			'SKIP_VALIDATION'=>true,
			'TITLE'=>$title,
			'FIELDS'=>$fields,
			'TEXT'=>'',
			'HIDDEN'=>'',
			'URL'=>get_self_url(false,false,NULL,false,true),
			'SUBMIT_NAME'=>do_lang_tempcode('CHOOSE'),
		));
	}

	/**
	 * Get transaction summaries.
	 *
	 * @param  TIME		Start of time range
	 * @param  TIME		End of time range
	 * @param  boolean	Whether to count unpaid invoices into this. This means any invoicing in transactions will be ignored, and instead invoicing will be read directly.
	 * @return array		A template-ready list of maps of summary for multiple transaction types.
	 */
	function get_types($from,$to,$unpaid_invoices_count=false)
	{
		$types=array(
					'OPENING'=>array('TYPE'=>do_lang_tempcode('OPENING_BALANCE'),'AMOUNT'=>0,'SPECIAL'=>true),
					'INTEREST_PLUS'=>array('TYPE'=>do_lang_tempcode('M_INTEREST_PLUS'),'AMOUNT'=>0,'SPECIAL'=>false),
					);
		$products=find_all_products();
		foreach ($products as $product=>$details)
		{
			$types[$product]=array('TYPE'=>$details[4],'AMOUNT'=>0,'SPECIAL'=>false);
		}
		$types+=array(
					'COST'=>array('TYPE'=>do_lang_tempcode('EXPENSES'),'AMOUNT'=>0,'SPECIAL'=>false),
					'TRANS'=>array('TYPE'=>do_lang_tempcode('TRANSACTION_FEES'),'AMOUNT'=>0,'SPECIAL'=>false),
					'WAGE'=>array('TYPE'=>do_lang_tempcode('WAGES'),'AMOUNT'=>0,'SPECIAL'=>false),
					'INTEREST_MINUS'=>array('TYPE'=>do_lang_tempcode('M_INTEREST_MINUS'),'AMOUNT'=>0,'SPECIAL'=>false),
					'TAX'=>array('TYPE'=>do_lang_tempcode('TAX_GENERAL'),'AMOUNT'=>0,'SPECIAL'=>false),
					'CLOSING'=>array('TYPE'=>do_lang_tempcode('CLOSING_BALANCE'),'AMOUNT'=>0,'SPECIAL'=>true),
					'PROFIT'=>array('TYPE'=>do_lang_tempcode('NET_PROFIT'),'AMOUNT'=>0,'SPECIAL'=>true),
					);

		require_code('currency');

		$transactions=$GLOBALS['SITE_DB']->query('SELECT * FROM '.$GLOBALS['SITE_DB']->get_table_prefix().'transactions WHERE t_time<'.strval($to).' AND '.db_string_equal_to('status','Completed').' ORDER BY t_time');
		foreach ($transactions as $transaction)
		{
			if ($transaction['t_time']>$from)
			{
				$types['TRANS']['AMOUNT']+=get_transaction_fee($transaction['amount'],$transaction['t_via']);
			}

			if ($unpaid_invoices_count)
			{
				foreach ($products as $product=>$details)
				{
					if (($transaction['item']==$product) && ($details[0]==PRODUCT_INVOICE)) continue 2;
				}
			}

			$product=$transaction['item'];

			$transaction['amount']=currency_convert($transaction['amount'],$transaction['t_currency'],get_option('currency'));

			$types['CLOSING']['AMOUNT']+=$transaction['amount'];

			if ($transaction['t_time']<$from)
			{
				$types['OPENING']['AMOUNT']+=$transaction['amount']-get_transaction_fee($transaction['amount'],$transaction['t_via']);
				continue;
			}

			if (($transaction['item']=='OTHER') && ($transaction['amount']<0))
			{
				$types['COST']['AMOUNT']+=$transaction['amount'];
			}
			elseif ($transaction['item']=='TAX')
			{
				$types['TAX']['AMOUNT']+=$transaction['amount'];
			}
			elseif ($transaction['item']=='INTEREST')
			{
				$types[$product][($transaction['amount']<0)?'INTEREST_MINUS':'INTEREST_PLUS']['AMOUNT']+=$transaction['amount'];
			}
			elseif ($transaction['item']=='WAGE')
			{
				$types['WAGE']['AMOUNT']+=$transaction['amount'];
			} else
			{
				if (!array_key_exists($product,$types)) $types[$product]=array('TYPE'=>$product,'AMOUNT'=>0,'SPECIAL'=>false); // In case product no longer exists
				$types[$product]['AMOUNT']+=$transaction['amount'];
			}
		}

		if ($unpaid_invoices_count)
		{
			$invoices=$GLOBALS['SITE_DB']->query('SELECT * FROM '.$GLOBALS['SITE_DB']->get_table_prefix().'invoices WHERE '.db_string_equal_to('i_state','new').' AND i_time<'.strval($to).' ORDER BY i_time');
			foreach ($invoices as $invoice)
			{
				$product=$invoice['i_type_code'];

				$types['CLOSING']['AMOUNT']+=$invoice['i_amount'];

				if ($invoice['i_time']<$from)
				{
					$types['OPENING']['AMOUNT']+=$invoice['i_amount'];
					continue;
				}

				$types[$product]['AMOUNT']+=$invoice['amount'];
			}
		}

		// $types['PROFIT_GROSS'] is not calculated
		$types['PROFIT']['AMOUNT']=$types['CLOSING']['AMOUNT']-$types['OPENING']['AMOUNT']+$types['TAX']['AMOUNT'];
		// $types['PROFIT_NET_TAXED'] is not calculated

		foreach ($types as $item=>$details)
		{
			$types[$item]['AMOUNT']=integer_format($types[$item]['AMOUNT']);
		}

		foreach ($types as $i=>$t)
		{
			if (is_float($t['AMOUNT'])) $types[$i]['AMOUNT']=float_to_raw_string($t['AMOUNT']);
			elseif (is_integer($t['AMOUNT'])) $types[$i]['AMOUNT']=strval($t['AMOUNT']);
		}

		return $types;
	}

	/**
	 * Show a cash flow diagram.
	 *
	 * @return tempcode	The result of execution.
	 */
	function cash_flow()
	{
		$d=array(get_input_date('from',true),get_input_date('to',true));
		if (is_null($d[0])) return $this->_get_between($this->title);
		list($from,$to)=$d;

		$types=$this->get_types($from,$to);
		unset($types['PROFIT']);

		return do_template('ECOM_CASH_FLOW_SCREEN',array('_GUID'=>'a042e16418417f46c24818890679f38a','TITLE'=>$this->title,'TYPES'=>$types));
	}

	/**
	 * Show a profit/loss account.
	 *
	 * @return tempcode	The result of execution.
	 */
	function profit_loss()
	{
		$d=array(get_input_date('from',true),get_input_date('to',true));
		if (is_null($d[0])) return $this->_get_between($this->title);
		list($from,$to)=$d;

		$types=$this->get_types($from,$to,true);
		unset($types['OPENING']);
		unset($types['CLOSING']);

		return do_template('ECOM_CASH_FLOW_SCREEN',array('_GUID'=>'255681ec95e90e36e085d14cf984b725','TITLE'=>$this->title,'TYPES'=>$types));
	}

	/* *
	 * Show a balance sheet. NOT REALLY FEASIBLE: REQUIRES HUMAN INTERPRETATION OF ASSETS, and recording of liabilities
	 *
	 * @return tempcode	The result of execution.
	 */
	/*function balance_sheet()
	{
	}*/

	/**
	 * Get tempcode for adding/editing form.
	 *
	 * @param  SHORT_TEXT	The title
	 * @param  LONG_TEXT		The description
	 * @param  SHORT_TEXT	The cost
	 * @param  integer		The length
	 * @param  SHORT_TEXT	The units for the length
	 * @set    y m d w
	 * @param  ?GROUP			The usergroup that purchasing gains membership to (NULL: super members)
	 * @param  BINARY			Whether this is applied to primary usergroup membership
	 * @param  BINARY			Whether this is currently enabled
	 * @param  ?LONG_TEXT	The text of the e-mail to send out when a subscription is start (NULL: default)
	 * @param  ?LONG_TEXT	The text of the e-mail to send out when a subscription is ended (NULL: default)
	 * @param  ?LONG_TEXT	The text of the e-mail to send out when a subscription cannot be renewed because the subproduct is gone (NULL: default)
	 * @param  ?AUTO_LINK	ID of existing subscription (NULL: new)
	 * @return array			Tuple: The input fields, The hidden fields, The delete fields
	 */
	function get_form_fields($title='',$description='',$cost='9.99',$length=12,$length_units='m',$group_id=NULL,$uses_primary=0,$enabled=1,$mail_start=NULL,$mail_end=NULL,$mail_uhoh=NULL,$id=NULL)
	{
		if (($title=='') && (get_forum_type()=='ocf'))
		{
			$add_usergroup_url=build_url(array('page'=>'admin_ocf_groups','type'=>'ad'),get_module_zone('admin_ocf_groups'));
			attach_message(do_lang_tempcode('ADD_USER_GROUP_FIRST',escape_html($add_usergroup_url->evaluate())),'inform');
		}

		if (is_null($group_id)) $group_id=get_param_integer('group_id',db_get_first_id()+3);
		if (is_null($mail_start)) $mail_start=do_lang('_PAID_SUBSCRIPTION_STARTED',get_option('site_name'));
		if (is_null($mail_end))
		{
			$_purchase_url=build_url(array('page'=>'purchase'),get_module_zone('purchase'),NULL,false,false,true);
			$purchase_url=$_purchase_url->evaluate();
			$mail_end=do_lang('_PAID_SUBSCRIPTION_ENDED',get_option('site_name'),$purchase_url);
		}
		if (is_null($mail_uhoh)) $mail_uhoh=do_lang('_PAID_SUBSCRIPTION_UHOH',get_option('site_name'));

		$fields=new ocp_tempcode();
		$fields->attach(form_input_line(do_lang_tempcode('TITLE'),do_lang_tempcode('DESCRIPTION_USERGROUP_SUBSCRIPTION_TITLE'),'title',$title,true));
		$fields->attach(form_input_text_comcode(do_lang_tempcode('DESCRIPTION'),do_lang_tempcode('DESCRIPTION_USERGROUP_SUBSCRIPTION_DESCRIPTION'),'description',$description,true));
		$fields->attach(form_input_float(do_lang_tempcode('COST'),do_lang_tempcode('DESCRIPTION_USERGROUP_SUBSCRIPTION_COST'),'cost',floatval($cost),true));
		$list=new ocp_tempcode();
		foreach (array('d','w','m','y') as $unit)
		{
			$list->attach(form_input_list_entry($unit,$unit==$length_units,do_lang_tempcode('LENGTH_UNIT_'.$unit)));
		}
		$fields->attach(form_input_list(do_lang_tempcode('LENGTH_UNITS'),do_lang_tempcode('DESCRIPTION_LENGTH_UNITS'),'length_units',$list));

		$list=new ocp_tempcode();
		$groups=$GLOBALS['FORUM_DRIVER']->get_usergroup_list();
		if (get_forum_type()=='ocf')
		{
			require_code('ocf_groups');
			$default_groups=ocf_get_all_default_groups(true);
		}
		foreach ($groups as $id=>$group)
		{
			if (get_forum_type()=='ocf')
			{
				if ((in_array($id,$default_groups)) && ($id!==$group_id)) continue;
			}

			if ($id!=$GLOBALS['FORUM_DRIVER']->get_guest_id())
				$list->attach(form_input_list_entry(strval($id),$id==$group_id,$group));
		}

		$fields->attach(form_input_integer(do_lang_tempcode('SUBSCRIPTION_LENGTH'),do_lang_tempcode('DESCRIPTION_USERGROUP_SUBSCRIPTION_LENGTH'),'length',$length,true));
		$fields->attach(form_input_list(do_lang_tempcode('GROUP'),do_lang_tempcode('DESCRIPTION_USERGROUP_SUBSCRIPTION_GROUP'),'group_id',$list));
		$fields->attach(form_input_tick(do_lang_tempcode('USES_PRIMARY'),do_lang_tempcode('DESCRIPTION_USES_PRIMARY'),'uses_primary',$uses_primary==1));
		$fields->attach(form_input_tick(do_lang_tempcode('ENABLED'),do_lang_tempcode('DESCRIPTION_USERGROUP_SUBSCRIPTION_ENABLED'),'enabled',$enabled==1));
		$fields->attach(form_input_text_comcode(do_lang_tempcode('MAIL_START'),do_lang_tempcode('DESCRIPTION_USERGROUP_SUBSCRIPTION_MAIL_START'),'mail_start',$mail_start,true,NULL,true));
		$fields->attach(form_input_text_comcode(do_lang_tempcode('MAIL_END'),do_lang_tempcode('DESCRIPTION_USERGROUP_SUBSCRIPTION_MAIL_END'),'mail_end',$mail_end,true,NULL,true));
		$fields->attach(form_input_text_comcode(do_lang_tempcode('MAIL_UHOH'),do_lang_tempcode('DESCRIPTION_USERGROUP_SUBSCRIPTION_MAIL_UHOH'),'mail_uhoh',$mail_uhoh,false,NULL,true));

		$delete_fields=NULL;
		if ($GLOBALS['SITE_DB']->query_select_value('subscriptions','COUNT(*)',array('s_type_code'=>'USERGROUP'.strval($id)))>0)
		{
			$delete_fields=new ocp_tempcode();
			$delete_fields->attach(form_input_tick(do_lang_tempcode('DELETE'),do_lang_tempcode('DESCRIPTION_DELETE_USERGROUP_SUB_DANGER'),'delete',false));
		}

		return array($fields,new ocp_tempcode(),$delete_fields,NULL,!is_null($delete_fields));
	}

	/**
	 * Standard crud_module table function.
	 *
	 * @param  array			Details to go to build_url for link to the next screen.
	 * @return array			A pair: The choose table, Whether re-ordering is supported from this screen.
	 */
	function nice_get_choose_table($url_map)
	{
		require_code('templates_results_table');

		$current_ordering=get_param('sort','s_title ASC');
		if (strpos($current_ordering,' ')===false) warn_exit(do_lang_tempcode('INTERNAL_ERROR'));
		list($sortable,$sort_order)=explode(' ',$current_ordering,2);
		$sortables=array(
			's_title'=>do_lang_tempcode('TITLE'),
			's_cost'=>do_lang_tempcode('COST'),
			's_length'=>do_lang_tempcode('SUBSCRIPTION_LENGTH'),
			's_group_id'=>do_lang_tempcode('GROUP'),
			's_enabled'=>do_lang('ENABLED'),
		);
		if (((strtoupper($sort_order)!='ASC') && (strtoupper($sort_order)!='DESC')) || (!array_key_exists($sortable,$sortables)))
			log_hack_attack_and_exit('ORDERBY_HACK');

		$header_row=results_field_title(array(
			do_lang_tempcode('TITLE'),
			do_lang_tempcode('COST'),
			do_lang_tempcode('SUBSCRIPTION_LENGTH'),
			do_lang_tempcode('GROUP'),
			do_lang('ENABLED'),
			do_lang_tempcode('ACTIONS'),
		),$sortables,'sort',$sortable.' '.$sort_order);

		$fields=new ocp_tempcode();

		require_lang('ecommerce');

		require_code('form_templates');
		list($rows,$max_rows)=$this->get_entry_rows(false,$current_ordering,NULL,get_forum_type()!='ocf');
		foreach ($rows as $r)
		{
			$edit_link=build_url($url_map+array('id'=>$r['id']),'_SELF');

			$fields->attach(results_entry(array(get_translated_text($r['s_title'],$GLOBALS[(get_forum_type()=='ocf')?'FORUM_DB':'SITE_DB']),$r['s_cost'],do_lang('_LENGTH_UNIT_'.$r['s_length_units'],integer_format($r['s_length'])),ocf_get_group_name($r['s_group_id']),($r['s_enabled']==1)?do_lang_tempcode('YES'):do_lang_tempcode('NO'),protect_from_escaping(hyperlink($edit_link,do_lang_tempcode('EDIT'),false,true,'#'.strval($r['id']))))),true);
		}

		return array(results_table(do_lang($this->menu_label),get_param_integer('start',0),'start',get_param_integer('max',20),'max',$max_rows,$header_row,$fields,$sortables,$sortable,$sort_order),false);
	}

	/**
	 * Standard crud_module list function.
	 *
	 * @return tempcode		The selection list
	 */
	function nice_get_entries()
	{
		$dbs_bak=$GLOBALS['NO_DB_SCOPE_CHECK'];
		$GLOBALS['NO_DB_SCOPE_CHECK']=true;

		$_m=$GLOBALS[(get_forum_type()=='ocf')?'FORUM_DB':'SITE_DB']->query_select('f_usergroup_subs',array('*'));
		$entries=new ocp_tempcode();
		foreach ($_m as $m)
		{
			$entries->attach(form_input_list_entry(strval($m['id']),false,get_translated_text($m['s_title'],$GLOBALS[(get_forum_type()=='ocf')?'FORUM_DB':'SITE_DB'])));
		}

		$GLOBALS['NO_DB_SCOPE_CHECK']=$dbs_bak;

		return $entries;
	}

	/**
	 * Standard crud_module edit form filler.
	 *
	 * @param  ID_TEXT		The entry being edited
	 * @return array			Tuple: The input fields, The hidden fields, The delete fields
	 */
	function fill_in_edit_form($id)
	{
		$dbs_bak=$GLOBALS['NO_DB_SCOPE_CHECK'];
		$GLOBALS['NO_DB_SCOPE_CHECK']=true;

		$m=$GLOBALS['FORUM_DB']->query_select('f_usergroup_subs',array('*'),array('id'=>intval($id)),'',1);
		if (!array_key_exists(0,$m)) warn_exit(do_lang_tempcode('MISSING_RESOURCE'));
		$r=$m[0];

		$fields=$this->get_form_fields(get_translated_text($r['s_title'],$GLOBALS[(get_forum_type()=='ocf')?'FORUM_DB':'SITE_DB']),get_translated_text($r['s_description'],$GLOBALS[(get_forum_type()=='ocf')?'FORUM_DB':'SITE_DB']),$r['s_cost'],$r['s_length'],$r['s_length_units'],$r['s_group_id'],$r['s_uses_primary'],$r['s_enabled'],get_translated_text($r['s_mail_start'],$GLOBALS[(get_forum_type()=='ocf')?'FORUM_DB':'SITE_DB']),get_translated_text($r['s_mail_end'],$GLOBALS[(get_forum_type()=='ocf')?'FORUM_DB':'SITE_DB']),get_translated_text($r['s_mail_uhoh'],$GLOBALS[(get_forum_type()=='ocf')?'FORUM_DB':'SITE_DB']),$id);

		$GLOBALS['NO_DB_SCOPE_CHECK']=$dbs_bak;

		return $fields;
	}

	/**
	 * Standard crud_module add actualiser.
	 *
	 * @return array			A pair: The entry added, Description about usage
	 */
	function add_actualisation()
	{
		if (has_actual_page_access(get_member(),'admin_config'))
		{
			$_config_url=build_url(array('page'=>'admin_config','type'=>'category','id'=>'ECOMMERCE'),get_module_zone('admin_config'));
			$config_url=$_config_url->evaluate();
			$config_url.='#group_ECOMMERCE';

			$text=do_lang_tempcode('ECOM_ADDED_SUBSCRIP',escape_html($config_url));
		} else $text=NULL;

		$title=post_param('title');

		return array(strval(add_usergroup_subscription($title,post_param('description'),post_param('cost'),post_param_integer('length'),post_param('length_units'),post_param_integer('group_id'),post_param_integer('uses_primary',0),post_param_integer('enabled',0),post_param('mail_start'),post_param('mail_end'),post_param('mail_uhoh'))),$text);
	}

	/**
	 * Standard crud_module edit actualiser.
	 *
	 * @param  ID_TEXT		The entry being edited
	 */
	function edit_actualisation($id)
	{
		$title=post_param('title');

		edit_usergroup_subscription(intval($id),$title,post_param('description'),post_param('cost'),post_param_integer('length'),post_param('length_units'),post_param_integer('group_id'),post_param_integer('uses_primary',0),post_param_integer('enabled',0),post_param('mail_start'),post_param('mail_end'),post_param('mail_uhoh'));
	}

	/**
	 * Standard crud_module delete actualiser.
	 *
	 * @param  ID_TEXT		The entry being deleted
	 */
	function delete_actualisation($id)
	{
		$uhoh_mail=post_param('mail_uhoh');

		delete_usergroup_subscription(intval($id),$uhoh_mail);
	}
	
	/**
	 * Show manual subscriptions.
	 *
	 * @return tempcode	The result of execution.
	 */
	function view_manual_subscriptions()
	{
		disable_php_memory_limit();

		$where=array('s_via'=>'manual');
		if (get_param_integer('all',0)==1) $where=NULL;

		$subscriptions=$GLOBALS['SITE_DB']->query_select('subscriptions',array('*'),$where,'ORDER BY s_type_code,s_time',10000/*reasonable limit*/);
		if (count($subscriptions)==0)
			inform_exit(do_lang_tempcode('NO_ENTRIES'));

		$data=array();
		foreach ($subscriptions as $subs)
		{
			$product_obj=find_product($subs['s_type_code']);
			if (is_null($product_obj)) continue;

			$products=$product_obj->get_products(true);

			$product_name=$products[$subs['s_type_code']][4];
			$s_length=$products[$subs['s_type_code']][3]['length'];
			$s_length_units=$products[$subs['s_type_code']][3]['length_units']; // y-year, m-month, w-week, d-day
			$time_period_units=array('y'=>'year','m'=>'month','w'=>'week','d'=>'day');
			$expiry_time=strtotime('+'.strval($s_length).' '.$time_period_units[$s_length_units],$subs['s_time']);
			$expiry_date=get_timezoned_date($expiry_time,false,false,false,true);
			$member_link=$GLOBALS['FORUM_DRIVER']->member_profile_hyperlink($subs['s_member_id'],true,'',false);
			$cancel_url=build_url(array('page'=>'_SELF','type'=>'cancel_subscription','subscription_id'=>$subs['id']),'_SELF');

			$data[$product_name][]=array($member_link,$expiry_date,$cancel_url,$subs['id']);
		}

		$result=new ocp_tempcode();
		foreach ($data as $key=>$value)
		{
			$continues_for_same_product=true;
			foreach ($value as $val)
			{
				if ($continues_for_same_product)
				{
					$result->attach(do_template('ECOM_VIEW_MANUAL_TRANSACTIONS_LINE',array('_GUID'=>'979a0e7ca87437bc7ee1035afd16e07c','ID'=>strval($val[3]),'SUBSCRIPTION'=>$key,'MEMBER'=>$val[0],'EXPIRY'=>$val[1],'ROWSPAN'=>strval(count($data[$key])),'CANCEL_URL'=>$val[2])));
					$continues_for_same_product=false;
				}
				else
				{
					$result->attach(do_template('ECOM_VIEW_MANUAL_TRANSACTIONS_LINE',array('_GUID'=>'4abea40b654471f0fec0961a1e8716e4','ID'=>'','SUBSCRIPTION'=>'','MEMBER'=>$val[0],'EXPIRY'=>$val[1],'ROWSPAN'=>'','CANCEL_URL'=>$val[2])));
				}
			}
		}

		return do_template('ECOM_VIEW_MANUAL_TRANSACTIONS_SCREEN',array('_GUID'=>'35a782b45d391f7766303b05c9422305','TITLE'=>$this->title,'CONTENT'=>$result));
	}

	/**
	 * Cancel a manual subscription.
	 *
	 * @return tempcode	The result of execution.
	 */
	function cancel_subscription()
	{
		$id=get_param_integer('subscription_id');
		$subscription=$GLOBALS['SITE_DB']->query_select('subscriptions',array('s_type_code','s_member_id'),array('id'=>$id),'',1);
		if (!array_key_exists(0,$subscription)) warn_exit(do_lang_tempcode('MISSING_RESOURCE'));

		$product_obj=find_product($subscription[0]['s_type_code']);
		$products=$product_obj->get_products(true);
		$product_name=$products[$subscription[0]['s_type_code']][4];
		$username=$GLOBALS['FORUM_DRIVER']->get_username($subscription[0]['s_member_id']);

		$repost_id=post_param_integer('id',NULL);
		if (($repost_id!==NULL) && ($repost_id==$id))
		{
			require_code('ecommerce');
			handle_confirmed_transaction(strval($id),'','SCancelled','','','','','','manual',''); // Runs a cancel
			return inform_screen($this->title,do_lang_tempcode('SUCCESS'));
		}

		// We need to get confirmation via POST, for security/confirmation reasons
		$preview=do_lang_tempcode('CANCEL_MANUAL_SUBSCRIPTION_CONFIRM',$product_name,$username);
		$fields=form_input_hidden('id',strval($id));
		$map=array('page'=>'_SELF','type'=>get_param('type'),'subscription_id'=>$id);
		$url=build_url($map,'_SELF');
		return do_template('CONFIRM_SCREEN',array('_GUID'=>'3b76b0e41541d5a38671134e92128d9f','TITLE'=>$this->title,'FIELDS'=>$fields,'URL'=>$url,'PREVIEW'=>$preview));
	}

}


