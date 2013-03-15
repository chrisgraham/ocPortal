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
class bump_member_group_timeout_test_set extends ocp_test_case
{
	function setUp()
	{
		parent::setUp();

		$GLOBALS['FORUM_DB']->query_delete('f_group_member_timeouts');

		require_code('group_member_timeouts');
	}

	function testMemberGroupTimeoutSecondary()
	{
		$member_id=3;
		$group_id=4;

		bump_member_group_timeout($member_id,$group_id,-10,false);

		$this->assertTrue(in_array($group_id,$GLOBALS['FORUM_DRIVER']->get_members_groups($member_id)));

		cleanup_member_timeouts();

		$this->assertFalse(in_array($group_id,$GLOBALS['FORUM_DRIVER']->get_members_groups($member_id)));
	}

	function testMemberGroupTimeoutPrimary()
	{
		$member_id=3;
		$group_id=4;

		bump_member_group_timeout($member_id,$group_id,-10,true);

		$this->assertTrue(in_array($group_id,$GLOBALS['FORUM_DRIVER']->get_members_groups($member_id)));

		cleanup_member_timeouts();

		$this->assertFalse(in_array($group_id,$GLOBALS['FORUM_DRIVER']->get_members_groups($member_id)));
	}

	function testMemberGroupTimeoutKickout()
	{
		$member_id=3;
		$group_id=4;

		bump_member_group_timeout($member_id,$group_id,10,false);
		cleanup_member_timeouts();
		$this->assertTrue(in_array($group_id,$GLOBALS['FORUM_DRIVER']->get_members_groups($member_id)));

		bump_member_group_timeout($member_id,$group_id,-30,false);
		cleanup_member_timeouts();

		$this->assertFalse(in_array($group_id,$GLOBALS['FORUM_DRIVER']->get_members_groups($member_id)));
	}

	function testMemberGroupTimeoutTimeAddition()
	{
		$member_id=3;
		$group_id=4;

		bump_member_group_timeout($member_id,$group_id,-10,false);
		bump_member_group_timeout($member_id,$group_id,30,false);
		cleanup_member_timeouts();
		$this->assertTrue(in_array($group_id,$GLOBALS['FORUM_DRIVER']->get_members_groups($member_id)));

		bump_member_group_timeout($member_id,$group_id,-30,false);
		cleanup_member_timeouts();
		$this->assertFalse(in_array($group_id,$GLOBALS['FORUM_DRIVER']->get_members_groups($member_id)));
	}

	function testMemberGroupTimeoutTimeSubtraction()
	{
		$member_id=3;
		$group_id=4;

		bump_member_group_timeout($member_id,$group_id,10,false);
		bump_member_group_timeout($member_id,$group_id,-30,false);
		cleanup_member_timeouts();
		$this->assertFalse(in_array($group_id,$GLOBALS['FORUM_DRIVER']->get_members_groups($member_id)));
	}

	function testMemberGroupTimeoutDouble()
	{
		$group_id=4;

		$member_id=3;
		bump_member_group_timeout($member_id,$group_id,-10,false);
		$this->assertTrue(in_array($group_id,$GLOBALS['FORUM_DRIVER']->get_members_groups($member_id)));

		$member_id=4;
		bump_member_group_timeout($member_id,$group_id,-10,false);
		$this->assertTrue(in_array($group_id,$GLOBALS['FORUM_DRIVER']->get_members_groups($member_id)));

		cleanup_member_timeouts();

		$this->assertFalse(in_array($group_id,$GLOBALS['FORUM_DRIVER']->get_members_groups(3)));
		$this->assertFalse(in_array($group_id,$GLOBALS['FORUM_DRIVER']->get_members_groups(4)));
	}

	function tearDown()
	{
		parent::tearDown();
	}
}
