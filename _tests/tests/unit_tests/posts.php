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
class posts_test_set extends ocp_test_case
{
	var $post_id;
	var $topic_id;

	function setUp()
	{
		parent::setUp();
		require_code('ocf_topics');
		require_code('ocf_posts');
		require_code('ocf_forums');
		require_code('ocf_posts_action');
		require_code('ocf_posts_action2');
		require_code('ocf_posts_action3');
		require_code('ocf_topics_action');
		require_code('ocf_topics_action2');

		$this->establish_admin_session();

		$this->topic_id=ocf_make_topic(db_get_first_id(),'Test');

		$this->post_id=ocf_make_post($this->topic_id,'welcome','welcome to the posts',0,false,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,true,true,NULL,true,'',0,NULL,false,false,false);

		// Test the forum was actually created
		$this->assertTrue('welcome'==$GLOBALS['FORUM_DB']->query_select_value('f_posts','p_title',array('id'=>$this->post_id)));
	}

	function testEditPosts()
	{
		$this->establish_admin_session();

		// Test the forum edits
		ocf_edit_post($this->post_id,1,'take care','the post editing',0,0,NULL,true,false,'Nothing');

		// Test the forum was actually created
		$this->assertTrue('take care'==$GLOBALS['FORUM_DB']->query_select_value('f_posts','p_title',array('id'=>$this->post_id)));
	}

	function tearDown()
	{
		if (!ocf_delete_posts_topic($this->topic_id,array($this->post_id),'Nothing'))
			ocf_delete_topic($this->topic_id);
		parent::tearDown();
	}
}
