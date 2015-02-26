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
class moderation_test_set extends ocp_test_case
{
	var $mod_id;
	function setUp()
	{
		parent::setUp();
		require_code('ocf_moderation_action');
		require_code('ocf_moderation_action2');

		$this->mod_id=ocf_make_multi_moderation('Test Moderation','Test',NULL,0,0,0,'*','Nothing');

		$this->assertTrue('Test Moderation'==get_translated_text($GLOBALS['FORUM_DB']->query_value('f_multi_moderations','mm_name',array('id'=>$this->mod_id)),$GLOBALS['FORUM_DB']));
	}

	function testEditModeration()
	{
		ocf_edit_multi_moderation($this->mod_id,'Tested','Something',NULL,0,0,0,'*','Hello');

		$this->assertTrue('Tested'==get_translated_text($GLOBALS['FORUM_DB']->query_value('f_multi_moderations','mm_name',array('id'=>$this->mod_id)),$GLOBALS['FORUM_DB']));
	}


	function tearDown()
	{
		ocf_delete_multi_moderation($this->mod_id);
		parent::tearDown();
	}
}
