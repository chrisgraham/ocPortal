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
class cedi_test_set extends ocp_test_case
{
	var $id;

	function setUp()
	{
		parent::setUp();

		require_code('cedi');
	}

	function testAddcedipage()
	{
		require_code('permissions2');
		$this->id=cedi_add_page('test page','test description','test notes',0);
		set_category_permissions_from_environment('seedy_page',strval($this->id),'cms_cedi');

		//Check the page was actully created
		$this->assertTrue('test notes'==$GLOBALS['FORUM_DB']->query_value('seedy_pages','notes',array('id'=>$this->id)));
	}

	function testEditCediPage()
	{
		require_code('permissions2');
		set_category_permissions_from_environment('seedy_page',strval($this->id),'cms_cedi');
		cedi_edit_page($this->id,'title-edited','test description','notes_edited',0,'','');

		//Check the page was edited
		$this->assertTrue('notes_edited'==$GLOBALS['FORUM_DB']->query_value('seedy_pages','notes',array('id'=>$this->id)));
	}

	function testDeleteCedipage()
	{
		//Delete cedit page
		cedi_delete_page($this->id);
	}

	function tearDown()
	{		
		parent::tearDown();
	}
}
