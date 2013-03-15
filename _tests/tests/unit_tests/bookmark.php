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
class bookmark_test_set extends ocp_test_case
{
	var $bookmark_id;

	function setUp()
	{
		parent::setUp();
		require_code('bookmarks');
		$this->bookmark_id=add_bookmark(4,"xyz","abc","www.xyz.com");
		// Test the forum was actually created
		$this->assertTrue('abc'==$GLOBALS['SITE_DB']->query_value('bookmarks','b_title ',array('id'=>$this->bookmark_id)));
	}

	function testEditBookmark()
	{
		// Test the forum edits
		edit_bookmark($this->bookmark_id,4,"nnnnn","www.xyz.com");
		// Test the forum was actually created
		$this->assertTrue('nnnnn'==$GLOBALS['SITE_DB']->query_value('bookmarks','b_title ',array('id'=>$this->bookmark_id)));
	}


	function tearDown()
	{
		delete_bookmark($this->bookmark_id,4);
		parent::tearDown();
	}
}
