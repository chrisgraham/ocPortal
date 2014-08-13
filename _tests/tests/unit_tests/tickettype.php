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
		$this->tickettype_id=add_ticket_type('platinum',0,0);
		$ticket_type_name=$GLOBALS['SITE_DB']->query_value('ticket_types','ticket_type_name',array('id'=>$this->tickettype_id));
		$this->assertTrue('platinum'==get_translated_text($ticket_type_name));
	}

	function testEditTicketType()
	{
		edit_ticket_type($this->tickettype_id,'gold',0,0);
		$ticket_type_name=$GLOBALS['SITE_DB']->query_value('ticket_types','ticket_type_name',array('id'=>$this->tickettype_id));
		$this->assertTrue('gold'==get_translated_text($ticket_type_name));;
	}


	function tearDown()
	{
		delete_ticket_type($this->tickettype_id);
		parent::tearDown();
	}
}
