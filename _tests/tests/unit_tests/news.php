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
class news_test_set extends ocp_test_case
{
    public $news_id;

    public function setUp()
    {
        parent::setUp();
        require_code('news2');

        $this->news_id = add_news('Today', 'hiiiiiiiiiii', 'rolly', 1, 1, 1, 1, '', 'test article', 5, null, 1262671781, null, 0, null, null, '');
        // Test the forum was actually created
        $this->assertTrue('Today' == get_translated_text($GLOBALS['SITE_DB']->query_select_value('news', 'title', array('id' => $this->news_id))));
    }

    public function testEditNews()
    {
        // Test the forum edits
        edit_news($this->news_id, 'Politics', 'teheyehehj ', 'rolly', 1, 1, 1, 1, 'yedd', 'test article 22222222', 5, null, '', '', '');

        // Test the forum was actually created
        $this->assertTrue('Politics' == get_translated_text($GLOBALS['SITE_DB']->query_select_value('news', 'title', array('id' => $this->news_id))));
    }


    public function tearDown()
    {
        delete_news($this->news_id);
        parent::tearDown();
    }
}
