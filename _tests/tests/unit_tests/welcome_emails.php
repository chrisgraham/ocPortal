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
class welcome_emails_test_set extends ocp_test_case
{
	var $email_id;

	function setUp()
	{
		parent::setUp();
		require_code('ocf_general_action');
		require_code('ocf_general_action2');
		$this->email_id=ocf_make_welcome_email('test_mail',"test subject","test content",1262671781,0);
		$this->assertTrue('test_mail'==$GLOBALS['SITE_DB']->query_value('f_welcome_emails','w_name ',array('id'=>$this->email_id)));
	}

	function testEditWelcomeEmail()
	{
		ocf_edit_welcome_email($this->email_id,"test_mail1","test_subject1","test content1",1262671781,0);
		$this->assertTrue('test_mail1'==$GLOBALS['SITE_DB']->query_value('f_welcome_emails','w_name ',array('id'=>$this->email_id)));
	}


	function tearDown()
	{
		ocf_delete_welcome_email($this->email_id);
		parent::tearDown();
	}
}
