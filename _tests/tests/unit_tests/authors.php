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
class authors_test_set extends ocp_test_case
{
	var $user_id;

	function setUp()
	{
		parent::setUp();

		require_code('authors');

		add_author($author='author1',$url='www.google.com',$forum_handle=3,$description='happy',$skills='play',$meta_keywords='',$meta_description='');

		add_author($author='author2',$url='www.yahoo.com',$forum_handle=3,$description='welcome',$skills='drama',$meta_keywords='',$meta_description='');

		$this->assertTrue('author1'==$GLOBALS['FORUM_DB']->query_value('authors','author',array('author'=>'author1')));
	}

	function testMergeauthors()
	{
		merge_authors($from='author1',$to='author2');
	}

	function tearDown()
	{
		delete_author($author='author2');
		parent::tearDown();
	}
}
