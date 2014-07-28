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
			$path=get_file_base().'/sources/hooks/systems/config/'.filter_naughty($hook).'.php';
			if (!file_exists($path))
				$path=get_file_base().'/sources_custom/hooks/systems/config/'.filter_naughty($hook).'.php';
			$code=file_get_contents($path);

			require_code('hooks/systems/config/'.filter_naughty($hook));
			$ob=object_factory('Hook_config_'.$hook);
			$details=$ob->get_details();
			$options[]=$details;

			$this->assertTrue(strpos($code,"@package\t\t".$details['addon'])!==false,'Addon definition mismatch in '.$hook);
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
