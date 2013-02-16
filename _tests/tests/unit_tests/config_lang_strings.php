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
		$options=$GLOBALS['SITE_DB']->query_select('config',array('the_name','human_name','the_type'));
		require_all_lang();
		foreach ($options as $option)
		{
			$test=do_lang($option['human_name'],NULL,NULL,NULL,NULL,false);
			$this->assertFalse(is_null($test),'Error on: '.$option['human_name']);

			//if ($option['the_type']!='tick')
			if ((strpos($option['the_name'],'link')===false) && (strpos($option['the_name'],'stats')===false) && (strpos($option['the_name'],'show')===false))
			{
				$test=do_lang('CONFIG_OPTION_'.$option['the_name'],NULL,NULL,NULL,NULL,false);
				$this->assertFalse(is_null($test),'Error on: '.'CONFIG_OPTION_'.$option['the_name']);
			}
		}
	}

	function tearDown()
	{		
		parent::tearDown();
	}
}
