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
class poll_test_set extends ocp_test_case
{
	var $poll_id;
	var $topic_id;

	function setUp()
	{
		parent::setUp();

		require_code('polls');
		require_code('polls2');

		$this->poll_id=add_poll('Who are you ?','a','b','c');

		// Test the forum was actually created
		$this->assertTrue('Who are you ?'==get_translated_text($GLOBALS['FORUM_DB']->query_select_value('poll','question ',array('id'=>$this->poll_id))));
	}

	function testPollVote()
	{
		vote_in_poll($this->poll_id,2);

		$poll_details=$GLOBALS['SITE_DB']->query_select('poll',array('*'),array('id'=>$this->poll_id),'',1);
		$this->assertTrue(array_key_exists(0,$poll_details));

		$this->assertTrue($poll_details[0]['votes2']==1);
	}

	function testEditPoll()
	{
		// Test the forum edits
		edit_poll($this->poll_id,'Who am I?','a','b','c','','','','','','','',3,1,1,1,'');

		// Test the forum was actually created
		$this->assertTrue('Who am I?'==get_translated_text($GLOBALS['FORUM_DB']->query_select_value('poll','question ',array('id'=>$this->poll_id))));
	}

	function tearDown()
	{
		delete_poll($this->poll_id);
		parent::tearDown();
	}
}

