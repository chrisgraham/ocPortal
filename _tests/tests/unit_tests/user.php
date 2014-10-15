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
class user_test_set extends ocp_test_case
{
    public $member_id;
    public $access_mapping;

    public function setUp()
    {
        parent::setUp();

        require_code('ocf_members_action');
        require_code('ocf_members_action2');
        require_lang('ocf');

        $this->member_id = $GLOBALS['FORUM_DRIVER']->get_member_from_username('testmember');
        if (!is_null($this->member_id)) {
            ocf_delete_member($this->member_id);
        }

        $this->member_id = ocf_make_member('testmember','123456','test@test.com',array(),10,1,1980,array(),null,null,1,null,null,'',null,'',0,0,1,'','','',1,1,null,1,1,null,'',true,null,'',1,null,0,'*','');

        // Test the forum was actually created
        $this->assertTrue('testmember' == $GLOBALS['FORUM_DB']->query_select_value('f_members','m_username',array('id' => $this->member_id)));
    }

    public function testEdituser()
    {
        // Test the forum edits
        ocf_edit_member(
            $this->member_id,
            'testing@test.com',
            0,
            25,
            12,
            1975,
            null,
            null,
            array(),
            '',
            0,
            0,
            0,
            null, // language
            1, // allow_emails
            1, // allow_emails_from_staff
            NULL, // validated
            NULL, // username
            NULL, // password
            NULL, // highlighted_name
            '*', // pt_allow
            '', // pt_rules_text
            NULL, // on_probation_until
            NULL, // join_time
            NULL, // avatar_url
            NULL, // signature
            NULL, // is_perm_banned
            NULL, // photo_url
            NULL, // photo_thumb_url
            NULL, // salt
            NULL, // password_compatibility_scheme
            false // skip_checks
        );

        // Test the forum was actually created
        $this->assertTrue('testing@test.com' == $GLOBALS['FORUM_DB']->query_select_value('f_members','m_email_address',array('id' => $this->member_id)));
    }

    public function tearDown()
    {
        ocf_delete_member($this->member_id);
        parent::tearDown();
    }
}
