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
class welcome_emails_test_set extends ocp_test_case
{
    public $email_id;

    public function setUp()
    {
        parent::setUp();
        require_code('ocf_general_action');
        require_code('ocf_general_action2');
        $this->email_id = ocf_make_welcome_email('test_mail','test subject','test content',1262671781,0,null,'');
        // Test the forum was actually created
        $this->assertTrue('test_mail' == $GLOBALS['SITE_DB']->query_select_value('f_welcome_emails','w_name',array('id' => $this->email_id)));
    }

    public function testEditWelcomeEmail()
    {
        // Test the forum edits
        ocf_edit_welcome_email($this->email_id,'test_mail1','test_subject1','test content1',1262671781,0,null,'');
        // Test the forum was actually created
        $this->assertTrue('test_mail1' == $GLOBALS['SITE_DB']->query_select_value('f_welcome_emails','w_name',array('id' => $this->email_id)));
    }


    public function tearDown()
    {
        ocf_delete_welcome_email($this->email_id);
        parent::tearDown();
    }
}
