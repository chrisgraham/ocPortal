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

	function testWords_1()
	{
		$before='<div>foobar</div><div>myfoo</div>';
		$after=xhtml_substr($before,0,7,false,false,0.0);
		$expected='<div>foobar</div><div>m</div>';
		$this->assertTrue($after==$expected);

	}

 	function testImage_1()
	{
		$before='<a href="www.google.com">My</a><div>foobar<img alt = "kevin" src="http://192.168.0.251/ocportal/ocportalv10/ocPortal/themes/default/images/ocf_emoticons/cheeky.png" />afterfoo </div>';
		$after=xhtml_substr($before,0,3,false,false,0.0);	
		$expected='<a href="www.google.com">My</a><div>f</div>';
		$this->assertTrue($after==$expected);
	}
 	
 	function testImage_2()
	{
		$before='<a href="www.google.com">My</a><div>foobar<img alt = "kevin" src="http://192.168.0.251/ocportal/ocportalv10/ocPortal/themes/default/images/ocf_emoticons/cheeky.png" />afterfoo </div>';
		$after=xhtml_substr($before,0,2,false,false,0.0);
		$expected='<a href="www.google.com">My</a>';
		$this->assertTrue($after==$expected);
	}
 	
 	function testImage_3()
	{
		$before='<a href="www.google.com">My</a><div>foobar<img alt = "kevin" src="http://192.168.0.251/ocportal/ocportalv10/ocPortal/themes/default/images/ocf_emoticons/cheeky.png" />afterfoo </div>';
		$after=xhtml_substr($before,0,12,false,false,0.0);
		$expected='<a href="www.google.com">My</a><div>foobar<img alt = "kevin" src="http://192.168.0.251/ocportal/ocportalv10/ocPortal/themes/default/images/ocf_emoticons/cheeky.png" />aft</div>';
		$this->assertTrue($after==$expected);
	}
 	function testImage_4()
	{
		$before='<a href="www.google.com">My</a><div>foobar<img alt = "kevin" src="http://192.168.0.251/ocportal/ocportalv10/thumb_nail.jpg" />afterfoo </div>';
		$after=xhtml_substr($before,0,12,false,false,0.0);
		$expected='<a href="www.google.com">My</a><div>foobar<img alt = "kevin" src="http://192.168.0.251/ocportal/ocportalv10/thumb_nail.jpg" /></div>';
		$this->assertTrue($after==$expected);
	}

	function testWordss()
	{
		$before='<div>foobar</div>';
		$after=xhtml_substr($before,0,3,false,false,1.5);
		$expected='<div>foobar</div>';
		$this->assertTrue($after==$expected);
	}

}
