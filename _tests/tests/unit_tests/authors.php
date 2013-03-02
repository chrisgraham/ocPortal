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
class authors_test_set extends ocp_test_case
{
	function setUp()
	{
		parent::setUp();

		require_code('authors');

		add_author('author1','www.google.com',3,'happy','play','','');

		add_author('author2','www.yahoo.com',3,'welcome','drama','','');

		// Test the forum was actually created
		$this->assertTrue('author1'==$GLOBALS['FORUM_DB']->query_select_value('authors','author',array('author'=>'author1')));
	}

	function testMergeauthors()
	{
		// Test the forum edits
		merge_authors('author1','author2');
	}

	function tearDown()
	{
		delete_author('author2');
		parent::tearDown();
	}
}
