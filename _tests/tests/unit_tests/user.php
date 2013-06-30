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
class user_test_set extends ocp_test_case
{
	var $member_id;
	var $access_mapping;

	function setUp()
	{
		parent::setUp();

		require_code('ocf_members_action');
		require_code('ocf_members_action2');
		require_lang('ocf');

		$this->member_id=ocf_make_member('testmember','123456','test@test.com',array(),10,1,1980,array(),NULL,NULL,1,NULL,NULL,'',NULL,'',0,0,1,'','','',1,1,NULL,1,1,NULL,'',true,NULL,'',1,NULL,NULL,0,'*','');

		// Test the forum was actually created
		$this->assertTrue('testmember'==$GLOBALS['FORUM_DB']->query_select_value('f_members','m_username',array('id'=>$this->member_id)));
	}

	function testEdituser()
	{
		// Test the forum edits
		ocf_edit_member($this->member_id,'testing@test.com',0,25,12,1975,NULL,NULL,array(),'',0,0,0,NULL,1,1,NULL,NULL,NULL,1,NULL,'*','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,false);

		// Test the forum was actually created
		$this->assertTrue('testing@test.com'==$GLOBALS['FORUM_DB']->query_select_value('f_members','m_email_address',array('id'=>$this->member_id)));
	}

	function tearDown()
	{
		ocf_delete_member($this->member_id);
		parent::tearDown();
	}
}
