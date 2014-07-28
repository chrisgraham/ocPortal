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
class warning_test_set extends ocp_test_case
{
	var $warn_id;
	function setUp()
	{
		parent::setUp();
		require_code('ocf_moderation');
		require_code('ocf_moderation_action');
		require_code('ocf_moderation_action2');

		$this->establish_admin_session();

		$this->warn_id=ocf_make_warning(1,'nothing',NULL,NULL,1,NULL,NULL,0,'',0,0,NULL);

		// Test the forum was actually created
		$this->assertTrue('nothing'==$GLOBALS['FORUM_DB']->query_select_value('f_warnings','w_explanation',array('id'=>$this->warn_id)));
	}

	function testEditWarning()
	{
		// Test the forum edits
		ocf_edit_warning($this->warn_id,'something',1);

		// Test the forum was actually created
		$this->assertTrue('something'==$GLOBALS['FORUM_DB']->query_select_value('f_warnings','w_explanation',array('id'=>$this->warn_id)));
	}

	function tearDown()
	{
		ocf_delete_warning($this->warn_id);
		parent::tearDown();
	}
}
