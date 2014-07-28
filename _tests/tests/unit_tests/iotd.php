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
class iotd_test_set extends ocp_test_case
{
	var $iotd_id;

	function setUp()
	{
		if (!addon_installed('iotds')) return;

		parent::setUp();

		if (in_safe_mode())
		{
			$this->assertTrue(false,'Cannot work in safe mode');
			return;
		}

		require_code('iotds');
		require_code('iotds2');

		$this->iotd_id=add_iotd('http://google.com','welcome','Google','images/google.jpg',0,0,0,0,'Notes ?',NULL,NULL,0,NULL,0,NULL);

		$this->assertTrue('http://google.com'==$GLOBALS['SITE_DB']->query_select_value('iotd','url',array('id'=>$this->iotd_id)));
	}

	function testEditIotd()
	{
		if (!addon_installed('iotds')) return;

		if (in_safe_mode())
		{
			$this->assertTrue(false,'Cannot work in safe mode');
			return;
		}

		edit_iotd($this->iotd_id,'Thank you','Caption ?','images/yahoo.jpg','yahoo.com',0,0,0,'Notes');

		$this->assertTrue('yahoo.com'==$GLOBALS['SITE_DB']->query_select_value('iotd','url',array('id'=>$this->iotd_id)));
	}

	function tearDown()
	{
		if (!addon_installed('iotds')) return;

		if (in_safe_mode())
		{
			$this->assertTrue(false,'Cannot work in safe mode');
			return;
		}

		delete_iotd($this->iotd_id);
		parent::tearDown();
	}
}
