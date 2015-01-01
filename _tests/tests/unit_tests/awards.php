<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2015

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
class awards_test_set extends ocp_test_case
{
    public $award_id;

    public function setUp()
    {
        parent::setUp();

        require_code('awards2');

        $this->award_id = add_award_type('test', 'test', 1, 'download', 0, 250);

        // Test the forum was actually created
        $this->assertTrue('download' == $GLOBALS['SITE_DB']->query_select_value('award_types', 'a_content_type', array('id' => $this->award_id)));
    }

    public function testEditawards()
    {
        // Test the forum edits
        edit_award_type($this->award_id, 'test', 'test', 2, 'image', 0, 194);

        // Test the forum was actually created
        $this->assertTrue('image' == $GLOBALS['SITE_DB']->query_select_value('award_types', 'a_content_type', array('id' => $this->award_id)));
    }

    public function tearDown()
    {
        delete_award_type($this->award_id);
        parent::tearDown();
    }
}
