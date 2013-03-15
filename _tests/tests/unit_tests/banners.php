<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

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
class banners_test_set extends ocp_test_case
{
	var $banner_type;
	var $banner_name;

	function setUp()
	{
		parent::setUp();

		require_code('banners');
		require_code('banners2');
		require_code('submit');

		$this->banner_type='Welcome';
		$this->banner_name='Goodmorning';

		// Cleanup possible old failed test
		delete_banner_type($this->banner_type);
		//delete_banner($this->banner_name);

		// Add banner type
		add_banner_type($this->banner_type,0,100,100,100,0);
	}

	function testAddBannerTypes()
	{
		// Test the benner was actually created
		$this->assertTrue(100==$GLOBALS['FORUM_DB']->query_value('banner_types','t_image_width',array('id'=>$this->banner_type)));
	}

	function testEditbannerType()
	{
		// Test the banner type details modification
		edit_banner_type($this->banner_type,$this->banner_type,0,200,100,100,0);

		//Test the width is updated to 200 for the banner "Welcome"
		$this->assertTrue(200==$GLOBALS['FORUM_DB']->query_value('banner_types','t_image_width',array('id'=>$this->banner_type)));
	}

	function testAddbanner()
	{
		add_banner($this->banner_name,'http://ocportal.com/themes/ocproducts/images/newlogo.gif','Good morning','Welcome','',10,'http://ocportal.com',3,'test notes',1,1329153480,get_member(),1,$this->banner_type);

		//make sure the banner is created with given name
		$this->assertTrue('http://ocportal.com/themes/ocproducts/images/newlogo.gif'==$GLOBALS['FORUM_DB']->query_value('banners','img_url',array('name'=>$this->banner_name)));
	}

	function testDeleteitems()
	{	
		delete_banner_type($this->banner_type);
		delete_banner($this->banner_name);
	}

	function tearDown()
	{		
		parent::tearDown();
	}
}
