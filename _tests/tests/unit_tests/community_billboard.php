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
class community_billboard_test_set extends ocp_test_case
{
	var $flag_id;

	function setUp()
	{
		if (!addon_installed('community_billboard')) return;

		parent::setUp();

		if (in_safe_mode())
		{
			$this->assertTrue(false,'Cannot work in safe mode');
			return;
		}

		require_code('community_billboard');

		$this->flag_id=add_community_billboard_message('test',3,'Welcome to ocPortal',1);

		$this->assertTrue('Welcome to ocPortal'==$GLOBALS['SITE_DB']->query_select_value('community_billboard','notes',array('id'=>$this->flag_id)));
	}

	function testEditCommunityBillboard()
	{
		if (!addon_installed('community_billboard')) return;

		if (in_safe_mode())
		{
			$this->assertTrue(false,'Cannot work in safe mode');
			return;
		}

		edit_community_billboard_message($this->flag_id,'Tested','Thank you',0);

		$this->assertTrue('Thank you'==$GLOBALS['SITE_DB']->query_select_value('community_billboard','notes',array('id'=>$this->flag_id)));
	}

	function tearDown()
	{
		if (!addon_installed('community_billboard')) return;

		if (in_safe_mode())
		{
			$this->assertTrue(false,'Cannot work in safe mode');
			return;
		}

		delete_community_billboard_message($this->flag_id);
		parent::tearDown();
	}
}
