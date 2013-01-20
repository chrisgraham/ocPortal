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
class iotd_test_set extends ocp_test_case
{
	var $iotd_id;

	function setUp()
	{
		parent::setUp();

		require_code('iotds2');

		$this->iotd_id=add_iotd('google.com','welcome','Google','images/google.jpg',0,0,0,0,'Notes ?',NULL,NULL,0,NULL,0,NULL);

		$this->assertTrue('google.com'==$GLOBALS['SITE_DB']->query_select_value('iotd','url',array('id'=>$this->iotd_id)));
	}

	function testEditIotd()
	{
		edit_iotd($this->iotd_id,'Thank you','Caption ?','images/yahoo.jpg','yahoo.com',0,0,0,'Notes');

		$this->assertTrue('yahoo.com'==$GLOBALS['SITE_DB']->query_select_value('iotd','url',array('id'=>$this->iotd_id)));
	}

	function tearDown()
	{
		delete_iotd($this->iotd_id);
		parent::tearDown();
	}
}
