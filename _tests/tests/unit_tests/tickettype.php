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
class tickettype_test_set extends ocp_test_case
{
	var $tickettype_id;

	function setUp()
	{
		parent::setUp();
		require_code('tickets2');
		add_ticket_type("platinum",0,0);
		$this->tickettype_id=$GLOBALS['SITE_DB']->query_value_null_ok('translate','id',array('text_original'=>"platinum"));
		$this->assertTrue('platinum'==get_translated_text($this->tickettype_id));
	}

	function testEditTicketType()
	{
		$this->tickettype_id=$GLOBALS['SITE_DB']->query_value_null_ok('translate','id',array('text_original'=>"platinum"));
		edit_ticket_type($this->tickettype_id,"gold",0,0);
		$this->assertTrue('gold'==get_translated_text($this->tickettype_id));;
	}


	function tearDown()
	{
		delete_ticket_type($this->tickettype_id);
		parent::tearDown();
	}
}
