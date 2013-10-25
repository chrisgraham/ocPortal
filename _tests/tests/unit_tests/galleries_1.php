<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

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
class galleries_1_test_set extends ocp_test_case
{
	var $glry_id;

	function setUp()
	{
		parent::setUp();

		require_code('galleries');
		require_code('galleries2');

		$this->glry_id=add_image('','','','http://www.msn.com','images/test.jpg',0,0,0,0,'',NULL,NULL,NULL,0,NULL);

		$this->assertTrue('http://www.msn.com'==$GLOBALS['SITE_DB']->query_select_value('images','url',array('id'=>$this->glry_id)));
	}

	function testEditGalleries()
	{
		edit_image($this->glry_id,'','','','http://www.google.com','images/sample.jpg',0,0,0,0,'','','');

		$this->assertTrue('http://www.google.com'==$GLOBALS['SITE_DB']->query_select_value('images','url',array('id'=>$this->glry_id)));
	}

	function tearDown()
	{
		delete_image($this->glry_id,false);
		parent::tearDown();
	}
}
