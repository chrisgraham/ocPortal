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
class comcode_test_set extends ocp_test_case
{
    public function setUp()
    {
        parent::setUp();
        require_code('comcode');
    }

    public function testComcode()
    {
        $expectations = array(" - foo  " => "<ul><li>foo</li></ul>"," - foo
 - bar" => "<ul><li>foo</li><li>bar</li></ul>"," - foo - bar" => " - foo - bar","" => " "," -foo" => "-foo","-foo" => "-foo","--foo" => "--foo","[b]bar[/b]" => "<strongclass=\"comcode_bold\">bar</strong>");

        foreach ($expectations as $comcode => $html) {
            $actual = comcode_to_tempcode($comcode,null,false,60,null,null,false,false,false,false,false,null,null);

            $matches = preg_replace('#\s#','',$html) == str_replace("&nbsp;","",preg_replace('#\s#','',$actual->evaluate()));

//       if (!$matches)
//          exit(preg_replace('#\s#','',$html).' vs '.str_replace("&nbsp;","",preg_replace('#\s#','',$actual->evaluate())));

            $this->assertTrue($matches);
        }
    }

    public function tearDown()
    {
        parent::tearDown();
    }
}
