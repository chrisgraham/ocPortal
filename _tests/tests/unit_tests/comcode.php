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
class comcode_test_set extends ocp_test_case
{
	function setUp()
	{
		parent::setUp();
		require_code('comcode');
	}

	function testComcode()
	{
		$expectations=array(" - foo  "=>"<ul><li>foo</li></ul>"," - foo
 - bar"=>"<ul><li>foo</li><li>bar</li></ul>"," - foo - bar"=>" - foo - bar",""=>" "," -foo"=>"-foo","-foo"=>"-foo","--foo"=>"&ndash;foo","[b]bar[/b]"=>"<strongclass=\"comcode_bold\">bar</strong>");

		foreach ($expectations as $comcode=>$html)
		{
			$actual=comcode_to_tempcode($comcode,NULL,false,60,NULL,NULL,false,false,false,false,false,NULL,NULL);

			$actual_altered=str_replace("&nbsp;","",preg_replace('#\s#','',$actual->evaluate()));

			$matches=preg_replace('#\s#','',$html)==$actual_altered;

//			if (!$matches)
//				exit(preg_replace('#\s#','',$html).' vs '.str_replace("&nbsp;","",preg_replace('#\s#','',$actual->evaluate())));

  			$this->assertTrue($matches,'"'.$comcode.'" produced instead of "'.$actual_altered.'" "'.$html.'"');
		}
	}

	function tearDown()
	{
		parent::tearDown();
	}
}
