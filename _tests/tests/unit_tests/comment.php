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
class comment_test_set extends ocp_test_case
{
	var $event_id;

	function setUp()
	{
		parent::setUp();
		require_code('calendar2');
		require_code('feedback');
		require_code('ocf_posts_action');
		require_code('ocf_forum_driver_helper');
		require_lang('lang');
		$this->event_id=add_calendar_event(8,'1',NULL,0,'test_event','',3,1,2010,1,10,'day_of_month',10,15,NULL,NULL,NULL,'day_of_month',NULL,NULL,NULL,1,1,1,1,1,'',NULL,0,NULL,NULL,NULL);
		if ('test_event'==get_translated_text($GLOBALS['SITE_DB']->query_value('calendar_events','e_title ',array('id'=>$this->event_id))))
		{
			$lang_id=insert_lang_comcode('test_comment_desc_1',4,$GLOBALS['FORUM_DB']);
			$map=array(
				'p_title'=>'test_comment1',
				'p_post'=>$lang_id,
				'p_ip_address'=>'127.0.0.1',
				'p_time'=>time(),
				'p_poster'=>0,
				'p_poster_name_if_guest'=>'',
				'p_validated'=>1,
				'p_topic_id'=>4,
				'p_is_emphasised'=>0,
				'p_cache_forum_id'=>4,
				'p_last_edit_time'=>NULL,
				'p_last_edit_by'=>NULL,
				'p_intended_solely_for'=>NULL,
				'p_skip_sig'=>0,
				'p_parent_id'=>NULL
			);
			$this->post_id=$GLOBALS['FORUM_DB']->query_insert('f_posts',$map,true);
		}
		$rows=$GLOBALS['FORUM_DB']->query('SELECT p_title FROM '.$GLOBALS['FORUM_DB']->get_table_prefix().'f_posts p LEFT JOIN '.$GLOBALS['FORUM_DB']->get_table_prefix().'translate t ON t.id=p.p_post WHERE t.text_original NOT LIKE \'%'.db_encode_like(do_lang('SPACER_POST_MATCHER','','','',get_site_default_lang()).'%').'\' AND ( p.id='.strval($this->post_id).') ORDER BY p.id');
		$title=$rows[0]['p_title'];
		$this->assertTrue('test_comment1'==$title);
	}

	function testEditComment()
	{
		edit_calendar_event($this->event_id,8,'',NULL,0,'test_event1','',3,1,2010,1,10,'day_of_month',10,15,2010,1,19,'day_of_month',0,0,get_users_timezone(),1,'','',1,1,1,1,'');
		$this->assertTrue('test_event1'==get_translated_text($GLOBALS['FORUM_DB']->query_value('calendar_events','e_title ',array('id'=>$this->event_id)),$GLOBALS['FORUM_DB']));
	}


	function tearDown()
	{
		delete_calendar_event($this->event_id);
		$GLOBALS['FORUM_DB']->query_delete('f_posts',array('id'=>$this->post_id));
		parent::tearDown();
	}
}
