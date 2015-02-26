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
class newscategory_test_set extends ocp_test_case
{
	var $news_id;

	function setUp()
	{
		parent::setUp();
		require_code('news');

		$this->news_id=add_news_category('Today','news.gif','Headlines',NULL,NULL);

		$this->assertTrue('Today'==get_translated_text($GLOBALS['SITE_DB']->query_value('news_categories','nc_title ',array('id'=>$this->news_id))));
	}

	function testEditNewscategory()
	{
		edit_news_category($this->news_id,'Politics','world.jpg','Around the world',NULL);

		$this->assertTrue('Politics'==get_translated_text($GLOBALS['SITE_DB']->query_value('news_categories','nc_title ',array('id'=>$this->news_id))));
	}


	function tearDown()
	{
		delete_news_category($this->news_id);
		parent::tearDown();
	}
}
