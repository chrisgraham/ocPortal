<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

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
class rss_test_set extends ocp_test_case
{
	var $rss_id;

	function setUp()
	{
		parent::setUp();
		require_code('rss');
		$rssfeed=get_file_base()."/_tests/tests/testrss.cms";
		$atomfeed=get_file_base()."/_tests/tests/testatom.cms";
		$rss=new rss($rssfeed,true);
		$atom=new rss($atomfeed,true);
		$rsstitle=$rss->gleamed_items[0]['title'];
		$atomtitle=$atom->gleamed_items[0]['title'];
		$this->assertTrue('Item Example'==$rsstitle);		
		$this->assertTrue('Atom-Powered Robots Run Amok'==$atomtitle);
	}

	function tearDown()
	{
		parent::tearDown();
	}
}
