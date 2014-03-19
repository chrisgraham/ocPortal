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
class flagrant_test_set extends ocp_test_case
{
	var $flag_id;

	function setUp()
	{
		parent::setUp();

		if (in_safe_mode())
		{
			$this->assertTrue(false,'Cannot work in safe mode');
			return;
		}

		require_code('flagrant');

		$this->flag_id=add_flagrant('test',3,'Welcome to ocPortal',1);

		$this->assertTrue('Welcome to ocPortal'==$GLOBALS['SITE_DB']->query_value('text','notes',array('id'=>$this->flag_id)));
	}

	function testEditFlagrant()
	{
		if (in_safe_mode())
		{
			$this->assertTrue(false,'Cannot work in safe mode');
			return;
		}

		edit_flagrant($this->flag_id,'Tested','Thank you',0);

		$this->assertTrue('Thank you'==$GLOBALS['SITE_DB']->query_value('text','notes',array('id'=>$this->flag_id)));
	}

	function tearDown()
	{
		if (in_safe_mode())
		{
			$this->assertTrue(false,'Cannot work in safe mode');
			return;
		}

		delete_flagrant($this->flag_id);
		parent::tearDown();
	}
}
