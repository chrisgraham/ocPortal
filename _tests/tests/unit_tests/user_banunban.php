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
class user_banunban_test_set extends ocp_test_case
{
	var $user_id;

	function setUp()
	{
		parent::setUp();

		require_code('ocf_members_action');
		require_code('ocf_members_action2');
		require_lang('ocf');

		ocf_ban_member(3);

		$this->assertTrue(1==$GLOBALS['FORUM_DB']->query_value('f_members','m_is_perm_banned',array('id'=>3)));
	}

	function testEdituser_banunban()
	{
		ocf_unban_member(3);

		$this->assertTrue(0==$GLOBALS['FORUM_DB']->query_value('f_members','m_is_perm_banned ',array('id'=>3)));
	}

	function tearDown()
	{
		parent::tearDown();
	}
}
