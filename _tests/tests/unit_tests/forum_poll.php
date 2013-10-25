<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

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
class forum_poll_test_set extends ocp_test_case
{
	var $poll_id;
	var $topic_id;

	function setUp()
	{
		parent::setUp();

		require_code('ocf_polls_action');
		require_code('ocf_polls_action2');
		require_code('ocf_topics_action');
		require_code('ocf_topics_action2');
		require_code('ocf_topics');
		require_code('ocf_forums');

		$this->establish_admin_session();

		$this->topic_id=ocf_make_topic(db_get_first_id(),'Test');

		$this->poll_id=ocf_make_poll($this->topic_id,'Who are you ?',0,0,2,4,0,array('a','b','c'),true);

		// Test the forum was actually created
		$this->assertTrue('Who are you ?'==$GLOBALS['FORUM_DB']->query_select_value('f_polls','po_question',array('id'=>$this->poll_id)));
	}

	function testEditPoll()
	{
		// Test the forum edits
		ocf_edit_poll($this->poll_id,'Who am I?',1,1,1,4,1,array(1,2,3),'nothing');

		// Test the forum was actually created
		$this->assertTrue('Who am I?'==$GLOBALS['FORUM_DB']->query_select_value('f_polls','po_question',array('id'=>$this->poll_id)));
	}

	function tearDown()
	{
		ocf_delete_poll($this->poll_id,'Simple');
		ocf_delete_topic($this->topic_id);
		parent::tearDown();
	}
}

