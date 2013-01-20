<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2013

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		unit_testing
 */

/**
 * ocPortal test case class (unit testing).
 */
class menu_test_set extends ocp_test_case
{
	var $menu_id;

	function setUp()
	{
		parent::setUp();
		require_code('menus2');

		$this->menu_id=add_menu_item('Test',1,NULL,'testing menu','www.ocportal.com',1,'downloads',0,1,'testing');

		// Test the forum was actually created
		$this->assertTrue('Test'==$GLOBALS['SITE_DB']->query_select_value('menu_items','i_menu',array('id'=>$this->menu_id)));
	}

	function testEditmenu()
	{
		// Test the forum edits
		edit_menu_item($this->menu_id,'Service',2,NULL,'Serv','www.google.com',0,'catalogues',1,0,'tested','');

		// Test the forum was actually created
		$this->assertTrue('Service'==$GLOBALS['SITE_DB']->query_select_value('menu_items','i_menu',array('id'=>$this->menu_id)));
	}

	function tearDown()
	{
		delete_menu_item($this->menu_id);
		parent::tearDown();
	}
}
