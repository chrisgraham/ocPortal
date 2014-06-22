<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		testing_platform
 */

/**
 * ocPortal test case class (unit testing).
 */
class ticket_type_test_set extends ocp_test_case
{
	var $ticket_type_id;

	function setUp()
	{
		parent::setUp();
		require_code('tickets2');
		add_ticket_type("platinum",0,0);
		// Test the forum was actually created
		$this->ticket_type_id=$GLOBALS['SITE_DB']->query_select_value_if_there('translate','id',array('text_original'=>"platinum"));
		$this->assertTrue('platinum'==get_translated_text($this->ticket_type_id));
	}

	function testEditTicketType()
	{
		// Test the forum edits
		$this->ticket_type_id=$GLOBALS['SITE_DB']->query_select_value_if_there('translate','id',array('text_original'=>"platinum"));
		edit_ticket_type($this->ticket_type_id,"gold",0,0);
		// Test the forum was actually created
		$this->assertTrue('gold'==get_translated_text($this->ticket_type_id));;
	}

	function tearDown()
	{
		delete_ticket_type($this->ticket_type_id);
		parent::tearDown();
	}
}
