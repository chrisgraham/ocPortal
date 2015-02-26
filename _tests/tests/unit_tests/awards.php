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
class awards_test_set extends ocp_test_case
{
	var $award_id;

	function setUp()
	{
		parent::setUp();

		require_code('awards');

		$this->award_id=add_award_type('test','test',1,'download',0,250);

		$this->assertTrue('download'==$GLOBALS['SITE_DB']->query_value('award_types','a_content_type',array('id'=>$this->award_id)));
	}

	function testEditawards()
	{
		edit_award_type($this->award_id,'test','test',2,'songs',0,194);

		$this->assertTrue('songs'==$GLOBALS['SITE_DB']->query_value('award_types','a_content_type',array('id'=>$this->award_id)));
	}

	function tearDown()
	{
		delete_award_type($this->award_id);
		parent::tearDown();
	}
}
