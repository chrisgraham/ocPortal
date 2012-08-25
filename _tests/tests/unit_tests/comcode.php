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
 - bar"=>"<ul><li>foo</li><li>bar</li></ul>"," - foo - bar"=>" - foo - bar",""=>" "," -foo"=>"-foo","-foo"=>"-foo","--foo"=>"--foo","[b]bar[/b]"=>"<strongclass=\"comcode_bold\">bar</strong>");

		foreach ($expectations as $comcode=>$html)
		{
			$actual=comcode_to_tempcode($comcode,NULL,false,60,NULL,NULL,false,false,false,false,false,NULL,NULL);

			$matches=preg_replace('#\s#','',$html)==str_replace("&nbsp;","",preg_replace('#\s#','',$actual->evaluate()));

//			if (!$matches)
//				exit(preg_replace('#\s#','',$html).' vs '.str_replace("&nbsp;","",preg_replace('#\s#','',$actual->evaluate())));

  			$this->assertTrue($matches);
		}
	}

	function testComcodeXML()
	{
		$comcode_xml=trim('
			<comcode>Please leave us some product feedback.<br /><br /><block>main_contact_us<blockParam key="param" value="product_feedback" /></block></comcode>
		');
		$comcode_text=trim('
Please leave us some product feedback.

[block="product_feedback"]main_contact_us[/block]
		');
		$_comcode_xml=static_evaluate_tempcode(comcode_to_tempcode($comcode_xml,NULL,false,60,NULL,NULL,false,false,false,false,false,NULL,NULL));
		$_comcode_text=static_evaluate_tempcode(comcode_to_tempcode($comcode_text,NULL,false,60,NULL,NULL,false,false,false,false,false,NULL,NULL));
		$this->assertTrue($_comcode_xml==$_comcode_text);

		require_code('comcode_conversion');
		$comcode_xml_backconv=comcode_text__to__comcode_xml($comcode_text);
		$this->assertTrue(preg_replace('#\s#','',$comcode_xml)==preg_replace('#\s#','',$comcode_xml_backconv));
	}

	function tearDown()
	{
		parent::tearDown();
	}
}
