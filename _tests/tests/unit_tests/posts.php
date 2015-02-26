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

		$this->post_id=ocf_make_post($this->topic_id,$title='welcome',$post='welcome to the posts',$skip_sig=0,$is_starter=false,$validated=NULL,$is_emphasised=0,$poster_name_if_guest=NULL,$ip_address=NULL,$time=NULL,$poster=NULL,$intended_solely_for=NULL,$last_edit_time=NULL,$last_edit_by=NULL,$check_permissions=true,$update_cacheing=true,$forum_id=NULL,$support_attachments=true,$topic_title='',$sunk=0,$id=NULL,$anonymous=false,$skip_post_checks=false,$is_pt=false);

		$this->assertTrue('welcome'==$GLOBALS['FORUM_DB']->query_value('f_posts','p_title ',array('id'=>$this->post_id)));
	}

	function testEditPosts()
	{
		$this->establish_admin_session();

		ocf_edit_post($post_id=$this->post_id,$validated=1,$title='take care',$post='the post editing',$skip_sig=0,$is_emphasised=0,$intended_solely_for=NULL,$show_as_edited=1,$mark_as_unread=0,$reason='Nothing');

		$this->assertTrue('take care'==$GLOBALS['FORUM_DB']->query_value('f_posts','p_title ',array('id'=>$this->post_id)));
	}

	function tearDown()
	{
		if (!ocf_delete_posts_topic($topic_id=$this->topic_id,$posts=array($this->post_id),$reason='Nothing'))
			ocf_delete_topic($this->topic_id);
		parent::tearDown();
	}
}
