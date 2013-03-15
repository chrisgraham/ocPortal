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
class calendarevent_test_set extends ocp_test_case
{
	var $event_id;

	function setUp()
	{
		parent::setUp();
		require_code('calendar2');
		$this->event_id=add_calendar_event(8,'1',NULL,0,'test_event','',3,1,2010,1,10,'day_of_month',10,15,NULL,NULL,NULL,'day_of_month',NULL,NULL,NULL,1,1,1,1,1,'',NULL,0,NULL,NULL,NULL);
		// Test the forum was actually created
		$this->assertTrue('test_event'==get_translated_text($GLOBALS['SITE_DB']->query_value('calendar_events','e_title ',array('id'=>$this->event_id))));
	}

	function testEditCalendarEvent()
	{
		// Test the forum edits
		edit_calendar_event($this->event_id,8,'2',NULL,0,'test_event1','',3,1,2010,1,10,'day_of_month',10,15,NULL,NULL,NULL,'day_of_month',NULL,NULL,get_users_timezone(),1,'','',1,1,1,1,'');
		// Test the forum was actually created
		$this->assertTrue('test_event1'==get_translated_text($GLOBALS['SITE_DB']->query_value('calendar_events','e_title ',array('id'=>$this->event_id))));
	}


	function tearDown()
	{
		delete_calendar_event($this->event_id);
		parent::tearDown();
	}
}
