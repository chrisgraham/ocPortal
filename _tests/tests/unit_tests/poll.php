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
class poll_test_set extends ocp_test_case
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

		$this->poll_id=ocf_make_poll($this->topic_id,$question='Who are you ?',$is_private=0,$is_open=0,$minimum_selections=2,$maximum_selections=4,$requires_reply=0,$answers=array('a','b','c'),$check_permissions=true);

		$this->assertTrue('Who are you ?'==$GLOBALS['FORUM_DB']->query_value('f_polls','po_question ',array('id'=>$this->poll_id)));
	}

	/*function testPollVote()		Wrong poll type
	{
		$_POST['cast_'.strval($this->poll_id)]='2';
		$_GET['show_poll_results_'.strval($this->poll_id)]='1';
		poll_script(true,$this->poll_id);

		$poll_details=$GLOBALS['SITE_DB']->query_select('poll',array('*'),array('id'=>$this->poll_id),'',1);
		$this->assertTrue(array_key_exists(0,$poll_details));

		$this->assertTrue($poll_details[0]['votes2']==1);
	}*/

	function testEditPoll()
	{
		ocf_edit_poll($poll_id=$this->poll_id,$question='Who am I?',$is_private=1,$is_open=1,$minimum_selections=1,$maximum_selections=4,$requires_reply=1,$answers=array(1,2,3),$reason='nothing');

		$this->assertTrue('Who am I?'==$GLOBALS['FORUM_DB']->query_value('f_polls','po_question ',array('id'=>$this->poll_id)));
	}

	function tearDown()
	{
		ocf_delete_poll($poll_id=$this->poll_id,$reason='Simple');
		ocf_delete_topic($this->topic_id);
		parent::tearDown();
	}
}

