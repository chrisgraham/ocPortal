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
class usergroup_test_set extends ocp_test_case
{
	var $usr_grp_id;

	function setUp()
	{
		parent::setUp();
		require_code('ecommerce2');

		$this->usr_grp_id=add_usergroup_subscription('test','test','123',12,'y',1,1,1,1,' ',' ',' ',array());

		// Test the forum was actually created
		$this->assertTrue(12==$GLOBALS['FORUM_DB']->query_select_value('f_usergroup_subs','s_length',array('id'=>$this->usr_grp_id)));
	}

	function testEditusergroup()
	{
		// Test the forum edits
		edit_usergroup_subscription($this->usr_grp_id,'Edit usergroup subscription','new edit','122',3,'y',1,0,1,1,' ',' ',' ',array());

		// Test the forum was actually created
		$this->assertTrue(3==$GLOBALS['FORUM_DB']->query_select_value('f_usergroup_subs','s_length',array('id'=>$this->usr_grp_id)));
	}

	function tearDown()
	{
		delete_usergroup_subscription($this->usr_grp_id,'test@test.com');
		parent::tearDown();
	}
}
