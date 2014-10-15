<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license    http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright  ocProducts Ltd
 * @package    testing_platform
 */

/**
 * ocPortal test case class (unit testing).
 */
class post_template_test_set extends ocp_test_case
{
    public $post_id;

    public function setUp()
    {
        parent::setUp();
        require_code('ocf_general_action');
        require_code('ocf_general_action2');

        $this->post_id = ocf_make_post_template('Test Post','Testing','Code',0);

        // Test the forum was actually created
        $this->assertTrue('Test Post' == $GLOBALS['FORUM_DB']->query_select_value('f_post_templates','t_title',array('id' => $this->post_id)));
    }

    public function testEditpost_template()
    {
        // Test the forum edits
        ocf_edit_post_template($this->post_id,'Tested Post','Hello','Nothing',1);

        // Test the forum was actually created
        $this->assertTrue('Tested Post' == $GLOBALS['FORUM_DB']->query_select_value('f_post_templates','t_title',array('id' => $this->post_id)));
    }


    public function tearDown()
    {
        ocf_delete_post_template($this->post_id);
        parent::tearDown();
    }
}
