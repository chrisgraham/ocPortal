<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		testing_platform
 */

/**
 * ocPortal test case class (unit testing).
 */
class ecommerce_test_set extends ocp_test_case
{	
	var $admin_ecom;
	var $item_id;
	var $order_id;
	var $access_mapping;
	var $admin_orders;

	function setUp()
	{
		parent::setUp();

		require_code('ecommerce');
		require_code('autosave');
		require_code('shopping');
		require_code('form_templates');

		require_lang('ecommerce');

		$this->access_mapping=array(db_get_first_id()=>4);
		// Creating cms catalogues object
		require_code('adminzone/pages/modules/admin_ecommerce.php');
		$this->admin_ecom=new Module_admin_ecommerce();

		/*require_code('adminzone/pages/modules/admin_shipping.php');
		$this->admin_shipping=new Module_admin_shipping();
		$this->admin_shipping->run_start('misc');*/

		/*require_code('adminzone/pages/modules_custom/admin_credits.php');
		$this->admin_credits=new Module_admin_credits();*/

		require_code('adminzone/pages/modules/admin_orders.php');
		$this->admin_orders=new Module_admin_orders();
		if (method_exists($this->admin_orders,'pre_run')) $this->admin_orders->pre_run();
		$this->admin_orders->run();

		$GLOBALS['SITE_DB']->query_insert('shopping_order',array(
			'c_member'		=>	get_member(),
			'session_id'		=>	get_session_id(),
			'add_date'		=>	time(),
			'tot_price'		=>	0.0,
			'order_status'		=>	'NEW',
			'notes'			=>	'',
			'transaction_id'	=>	'ddfsfdsdfsdfs',
			'purchase_through'	=>	'paypal',
			'tax_opted_out'	=>	0,
		));

		/*require_code('adminzone/pages/modules/admin_permissions_products.php');
		$this->admin_permission_products=new Module_admin_permissions_products();
		if (method_exists($this->admin_permission_products,'pre_run')) $this->admin_permission_products->pre_run();
		$this->admin_permission_products->run();*/
	}

	/*function testTaxrateUI()
	{
		//Create own ecommerce store
		$this->admin_ecom->run_start();
		return $this->admin_ecom->tax_rates();
	}

	function testTaxrateActualiser()
	{
		//Create own ecommerce store
		$this->admin_ecom->run_start();

		//Set post data
		$_POST['tax_rates']='Alabama=9.0% Alaska=nil% Arizona=7.8% Arkansas=6.0% California=8.25% Colorado=2.9% Connecticut=6.0% Delaware=2.07% Florida=6.0% Georgia=4.0% Hawaii=4.0% Idaho=6.0% Illinois=6.25% Indiana=15.0% Iowa=6.0 % Kansas=5.3% Kentucky=6.0% Louisiana=4.0% Maine=16.0% Maryland=10.0% Massachusetts=6.25% Michigan=6.0 % Minnesota=6.875% Mississippi=7.0% Missouri=4.225% Montana=nil% Nebraska=5.5% Nevada=6.85% New Hampshire=nil% New Jersey=7.0% New Mexico=5.375% New York=4.0% North Carolina=4.5% North Dakota=5.0% Ohio=5.5% Oklahoma=4.5% Oregon=nil% Pennsylvania=6.0% Rhode Island=7.0% South Carolina=6.0% South Dakota=4.0% Tennessee=7.0% Texas=6.25% Utah=5.95% Vermont=6.0% Virginia=5.0% West Virginia=6.0% Wisconsin=5.0% Washington=20% Washington DC=18% Wyoming=4.0%';

		return $this->admin_ecom->_tax_rates();
	}*

	/*function testAddShippingEquationUI()
	{		
		$this->admin_shipping->ad();
	}

	function testAddShippingEquationActualiser()
	{
		//Set sample data to POST

		$_POST['title']='Standard shipping';
		$_POST['description']='Standard shipping';
		$_POST['equation']='3.00+(($weight>10)?(($weight-10)*0.23):0.00)';	

		$this->item_id=$this->admin_shipping->add_actualisation();
	}

	function testEditShippingEquationActualiser()
	{
		$_POST['title']='Standard shipping - modified';
		$_POST['description']='Standard shipping - modified';
		$_POST['equation']='3.00+(($weight>10)?(($weight-10)*0.23):0.00)';	

		$this->admin_shipping->edit_actualisation($this->item_id);
	}

	function testDeleteShippingEquationActualiser()
	{
		$this->admin_shipping->delete_actualisation($this->item_id);
	}*/

	//Credit points display - Admin_credits module
	/*function testAdminCreditLogs()
	{
		$this->admin_credits->logs();
	}

	function testGiveCreditUI()
	{	
		$_GET['member_id']=2;
		$this->admin_credits->credit_screen();
	}

	function testGiveCreditActuliser()
	{
		$_POST['member_id']=2;
		$_POST['credit_point']=10;
		$_POST['note']='You have got 10 Points';
		$this->admin_credits->credit_actualiser_screen();
	}*/

	//Member statuses
	/*function testmemberStatusesUI()
	{
		return $this->admin_orders->user_orders();
	}*/

	//order module methods
	function testShowOrders()
	{
		return $this->admin_orders->show_orders();
	}	

	function testOrderDetails()
	{
		$this->order_id=$GLOBALS['SITE_DB']->query_select_value('shopping_order','max(id)',array());
		$_GET['id']=strval($this->order_id);
		return $this->admin_orders->order_details();
	}

	function testAddNoteToOrderUI()
	{	
		$this->admin_orders->add_note();
	}

	function testAddNoteToOrderActuliser()
	{
		$this->order_id=$GLOBALS['SITE_DB']->query_select_value('shopping_order','max(id)',array());
		$_POST['order_id']=$this->order_id;
		$_POST['note']='Test note';	
		$this->admin_orders->_add_note();
	}

	function testorderDispatch()
	{
		$order_id=$GLOBALS['SITE_DB']->query_select_value_if_there('shopping_order','max(id)',array('order_status'=>'ORDER_STATUS_payment_received'));
		if(!is_null($order_id))
		{	
			$this->order_id=$order_id;
			$_GET['id']=$this->order_id;
			$this->admin_orders->dispatch();
		}
	}

	function testOrderDispatchNotification()
	{
		$this->order_id=$GLOBALS['SITE_DB']->query_select_value('shopping_order','max(id)',array());
		$this->admin_orders->send_dispatch_notification($this->order_id);
	}

	function testDeleteOrder()
	{
		$this->order_id=$GLOBALS['SITE_DB']->query_select_value('shopping_order','max(id)',array());
		$_GET['id']=$this->order_id;
		$this->admin_orders->delete_order();
	}

	function testReturnOrder()
	{
		$this->order_id=$GLOBALS['SITE_DB']->query_select_value('shopping_order','max(id)',array());
		$_GET['id']=$this->order_id;
		$this->admin_orders->return_order();		
	}

	function testholdOrder()
	{
		$this->order_id=$GLOBALS['SITE_DB']->query_select_value('shopping_order','max(id)',array());
		$_GET['id']=$this->order_id;
		$this->admin_orders->hold_order();		
	}

	function testOrderExportUI()
	{
		$this->admin_orders->order_export();
	}

	function testOrderExportActuliser()
	{		
		$_POST=array(			
			'order_status'=>'ORDER_STATUS_awaiting_payment',
			'require__order_status'=>0,
			'start_date'=>1,
			'start_date_day'=>10,
			'start_date_month'=>12,
			'start_date_year'=>2008,
			'start_date_hour'=>7,
			'start_date_minute'=>0,
			'require__start_date'=>1,
			'end_date'=>1,
			'end_date_day'=>10,
			'end_date_month'=>12,
			'end_date_year'=>2009,
			'end_date_hour'=>7,
			'end_date_minute'=>0,
			'require__end_date'=>1,
			'is_from_unit_test'=>1
		);

		$this->admin_orders->_order_export(true);
	}

	/*function testPermissionProductsUI()
	{
		$this->admin_permission_products->permissions_product_management();
	}

	function testPermissionProductActulizer()
	{
		//Set post values
		$_POST=array(
			'permission_title'=>'Tour images',
			'require__permission_title'=>1,
			'permission_description'=>'Tour images',
			'pre_f_permission_description'=>1,
			'require__permission_description'=>1,
			'permission_cost'=>25,
			'require__permission_cost'=>1,
			'permission_hours'=>240,
			'require__permission_hours'=>1,
			'permission_type'=>'member_privileges',
			'require__permission_type'=>1,
			'permission_privilege' =>' banner_free',
			'require__permission_privilege'=>0,
			'permission_zone'=>'',
			'require__permission_zone'=>0,
			'privilege_page'=>'',
			'require__privilege_page'=>0,
			'permission_module'=>'',
			'require__permission_module'=>0,
			'permission_category'=>'',
			'require__permission_category'=>0,
			'permission_enabled'=>1,
			'tick_on_form__permission_enabled'=>0,
			'require__permission_enabled'=>0,
		);
		$this->admin_permission_products->set_prices();
	}*/
}
