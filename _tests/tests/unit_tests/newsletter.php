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
class newsletter_test_set extends ocp_test_case
{
	var $news_id;

	function setUp()
	{
		parent::setUp();
		require_code('newsletter');

		$this->news_id=add_newsletter('New Offer','The new offer of the week.');

		// Test the forum was actually created
		$this->assertTrue('New Offer'==get_translated_text($GLOBALS['SITE_DB']->query_select_value('newsletters','title',array('id'=>$this->news_id))));
	}

	function testEditNewsletter()
	{
		// Test the forum edits
		edit_newsletter($this->news_id,'Thanks','Thank you');

		// Test the forum was actually created
		$this->assertTrue('Thanks'==get_translated_text($GLOBALS['SITE_DB']->query_select_value('newsletters','title',array('id'=>$this->news_id))));
	}

	function tearDown()
	{
		delete_newsletter($this->news_id);
		parent::tearDown();
	}
}
