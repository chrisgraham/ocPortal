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
class config_lang_strings_test_set extends ocp_test_case
{
	var $id;

	function setUp()
	{
		parent::setUp();
	}

	function testStrings()
	{
		$hooks=find_all_hooks('systems','config');
		$options=array();
		foreach (array_keys($hooks) as $hook)
		{
			require_code('hooks/systems/config/'.filter_naughty($hook));
			$ob=object_factory('Hook_config_'.$hook);
			$options[]=$ob->get_details();
		}
		require_all_lang();
		foreach ($options as $option)
		{
			$test=do_lang($option['human_name'],NULL,NULL,NULL,NULL,false);
			$this->assertFalse(is_null($test),'Error on: '.$option['human_name']);
		}
	}

	function tearDown()
	{		
		parent::tearDown();
	}
}
