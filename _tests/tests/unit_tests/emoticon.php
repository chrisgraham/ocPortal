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
class emoticon_test_set extends ocp_test_case
{

	function setUp()
	{
		parent::setUp();
		require_code('ocf_general_action');
		require_code('ocf_general_action2');

		ocf_make_emoticon($code='X:)',$theme_img_code='image/em.jpg',$relevance_level=1,$use_topics=1,$is_special=0);

		$this->assertTrue('X:)'==$GLOBALS['FORUM_DB']->query_value('f_emoticons','e_code ',array('e_code'=>'X:)')));
	}

	function testEditemoticon()
	{
		ocf_edit_emoticon($old_code='X:)',$code='Z:D',$theme_img_code='images/smile.jpg',$relevance_level=2,$use_topics=0,$is_special=0);

		$this->assertTrue('Z:D'==$GLOBALS['FORUM_DB']->query_value('f_emoticons','e_code ',array('e_code'=>'Z:D')));
	}


	function tearDown()
	{
		ocf_delete_emoticon('Z:D');
		parent::tearDown();
	}
}
