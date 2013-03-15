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
class usergroup_test_set extends ocp_test_case
{
	var $usr_grp_id;

	function setUp()
	{
		parent::setUp();
		require_code('ecommerce');

		$this->usr_grp_id=add_usergroup_subscription('test','test','123',12,'2',1,1,1,' ',' ',' ');

		// Test the forum was actually created
		$this->assertTrue(12==$GLOBALS['FORUM_DB']->query_value('f_usergroup_subs','s_length',array('id'=>$this->usr_grp_id)));
	}

	function testEditusergroup()
	{
		// Test the forum edits
		edit_usergroup_subscription($this->usr_grp_id,'Edit_group','new edit','122',3,'12',0,1,1,' ',' ',' ');

		// Test the forum was actually created
		$this->assertTrue(3==$GLOBALS['FORUM_DB']->query_value('f_usergroup_subs','s_length',array('id'=>$this->usr_grp_id)));
	}

	function tearDown()
	{
		delete_usergroup_subscription($this->usr_grp_id,'test@test.com');
		parent::tearDown();
	}
}
