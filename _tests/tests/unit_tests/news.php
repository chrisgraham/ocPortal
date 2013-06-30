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
class news_test_set extends ocp_test_case
{
	var $news_id;

	function setUp()
	{
		parent::setUp();
		require_code('news2');

		$this->news_id=add_news('Today','hiiiiiiiiiii','rolly',1,1,1,1,'','test article',5,NULL,1262671781,NULL,0,NULL,NULL,'');
		// Test the forum was actually created
		$this->assertTrue('Today'==get_translated_text($GLOBALS['SITE_DB']->query_select_value('news','title',array('id'=>$this->news_id))));
	}

	function testEditNews()
	{
		// Test the forum edits
		edit_news($this->news_id,'Politics','teheyehehj ','rolly',1,1,1,1,'yedd','test article 22222222',5,NULL,'','','');

		// Test the forum was actually created
		$this->assertTrue('Politics'==get_translated_text($GLOBALS['SITE_DB']->query_select_value('news','title',array('id'=>$this->news_id))));
	}


	function tearDown()
	{
		delete_news($this->news_id);
		parent::tearDown();
	}
}
