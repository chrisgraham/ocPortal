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
class forum_test_set extends ocp_test_case
{
	var $forum_id;
	var $access_mapping;

	function setUp()
	{
		parent::setUp();

		require_code('ocf_forums_action');
		require_code('ocf_forums_action2');
		require_lang('ocf');

		$this->access_mapping=array(db_get_first_id()=>4);
		$this->forum_id=ocf_make_forum('TestAdd','Test',db_get_first_id(),$this->access_mapping,db_get_first_id(),1,1,0,'','','','last_post');

		$this->assertTrue('TestAdd'==$GLOBALS['FORUM_DB']->query_value('f_forums','f_name',array('id'=>$this->forum_id)));
	}

	function testViewForum()
	{
		// Test the <title> contains "Test" which wil be in our forum name
		$this->get('forum:forumview:misc:'.strval($this->forum_id));
		$this->assertTitle(new PatternExpectation('/Test/'));
	}

	function testEditForum()
	{
		ocf_edit_forum($this->forum_id,'TestEdit','Test',db_get_first_id(),db_get_first_id(),1,1,0,'','','','last_post',0,false);
		$this->assertTrue('TestEdit'==$GLOBALS['FORUM_DB']->query_value('f_forums','f_name',array('id'=>$this->forum_id)));
	}

	function tearDown()
	{
		ocf_delete_forum($this->forum_id,$this->forum_id);

		parent::tearDown();
	}
}
