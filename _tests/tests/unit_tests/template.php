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
class template_test_set extends ocp_test_case
{
	var $template_id;

	function setUp()
	{
		parent::setUp();
		require_code('ocf_general_action');
		require_code('ocf_general_action2');
		$this->template_id=ocf_make_post_template('test_template','test','+1',1);
		$this->assertTrue('test_template'==$GLOBALS['FORUM_DB']->query_value('f_post_templates','t_title ',array('id'=>$this->template_id)));
	}

	function testEditPostTemplate()
	{
		ocf_edit_post_template($this->template_id,'test_template2','test','+1',1);
		$this->assertTrue('test_template2'==$GLOBALS['FORUM_DB']->query_value('f_post_templates','t_title ',array('id'=>$this->template_id)));
	}


	function tearDown()
	{
		ocf_delete_post_template($this->template_id);
		parent::tearDown();
	}
}
