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
class forum_category_test_set extends ocp_test_case
{
	var $forum_cat_id;
	var $access_mapping;

	function setUp()
	{
		parent::setUp();

		require_code('ocf_forums_action');
		require_code('ocf_forums_action2');
		require_lang('ocf');

		$this->forum_cat_id=ocf_make_category('Test_cat','nothing',1);

		$this->assertTrue('Test_cat'==$GLOBALS['FORUM_DB']->query_value('f_categories','c_title',array('id'=>$this->forum_cat_id)));
	}

	function testEditForum_category()
	{
		ocf_edit_category($this->forum_cat_id,'New_title','somthing',1);

		$this->assertTrue('New_title'==$GLOBALS['FORUM_DB']->query_value('f_categories','c_title',array('id'=>$this->forum_cat_id)));
	}

	function tearDown()
	{
		ocf_delete_category($this->forum_cat_id,0);

		parent::tearDown();
	}
}
