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
class wiki_test_set extends ocp_test_case
{
	var $id;

	function setUp()
	{
		parent::setUp();

		require_code('wiki');
	}

	function testAddWikipage()
	{
		require_code('permissions2');
		$this->id=wiki_add_page('test page','test description','test notes',0);
		set_category_permissions_from_environment('wiki_page',strval($this->id),'cms_wiki');

		// Check the page was actully created
		$this->assertTrue('test notes'==$GLOBALS['FORUM_DB']->query_select_value('wiki_pages','notes',array('id'=>$this->id)));
	}

	function testEditWikiPage()
	{
		require_code('permissions2');
		set_category_permissions_from_environment('wiki_page',strval($this->id),'cms_wiki');
		wiki_edit_page($this->id,'title-edited','test description','notes_edited',0,'','');

		//C heck the page was edited
		$this->assertTrue('notes_edited'==$GLOBALS['FORUM_DB']->query_select_value('wiki_pages','notes',array('id'=>$this->id)));
	}

	function testDeleteWikipage()
	{
		// Delete Wiki+ page
		wiki_delete_page($this->id);
	}

	function tearDown()
	{		
		parent::tearDown();
	}
}
