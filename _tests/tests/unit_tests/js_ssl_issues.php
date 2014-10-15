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
class js_ssl_issues_test_set extends ocp_test_case
{
    public function setUp()
    {
        parent::setUp();
    }

    public function testSSLIssues()
    {
        $templates = array();
        $path = get_file_base() . '/themes/default/templates';
        $dh = opendir($path);
        while (($f = readdir($dh)) !== false) {
            if ((strtolower(substr($f,-4)) == '.tpl') && (substr($f,0,10) == 'JAVASCRIPT')) {
                $file = file_get_contents($path . '/' . $f);

                $matches = array();
                $num_matches = preg_match_all('#\{\$IMG[;\*]+,(\w+)\}(?!.*protocol.*$)(.*)$#m',$file,$matches);
                for ($i = 0;$i<$num_matches;$i++) {
                    $this->assertTrue(false,$f . '/' . $matches[1][$i] . ' not prepared for SSL');
                }
            }
        }
    }

    public function tearDown()
    {
        parent::tearDown();
    }
}
