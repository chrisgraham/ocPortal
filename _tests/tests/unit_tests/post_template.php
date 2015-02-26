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
class post_template_test_set extends ocp_test_case
{
	var $post_id;

	function setUp()
	{
		parent::setUp();
		require_code('ocf_general_action');
		require_code('ocf_general_action2');

		$this->post_id=ocf_make_post_template('Test Post','Testing','Code',0);

		$this->assertTrue('Test Post'==$GLOBALS['FORUM_DB']->query_value('f_post_templates','t_title ',array('id'=>$this->post_id)));
	}

	function testEditpost_template()
	{
		ocf_edit_post_template($this->post_id,'Tested Post','Hello','Nothing',1);

		$this->assertTrue('Tested Post'==$GLOBALS['FORUM_DB']->query_value('f_post_templates','t_title ',array('id'=>$this->post_id)));
	}


	function tearDown()
	{
		ocf_delete_post_template($this->post_id);
		parent::tearDown();
	}
}
