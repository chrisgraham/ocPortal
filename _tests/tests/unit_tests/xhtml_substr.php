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
class xhtml_substr_test_set extends ocp_test_case
{
	function setUp()
	{
		require_code('xhtml');
	}

	function testSimple()
	{
		$before='<div>foobar</div>';
		$after=xhtml_substr($before,0,3,false,false,0.0);
		$expected='<div>foo</div>';
		$this->assertTrue($after==$expected);
	}

	function testWords()
	{
		$before='<div>foobar</div>';
		$after=xhtml_substr($before,0,3,false,false,1.5);
		$expected='<div>foobar</div>';
		$this->assertTrue($after==$expected);
	}
}
