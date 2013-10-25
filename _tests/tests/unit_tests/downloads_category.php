<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

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
class downloads_category_test_set extends ocp_test_case
{
	var $dwn_cat_id;

	function setUp()
	{
		parent::setUp();

		require_code('downloads');
		require_code('downloads2');

		$this->dwn_cat_id=add_download_category('test',1,'test','test','',NULL);

		$this->assertTrue('test'==$GLOBALS['SITE_DB']->query_select_value('download_categories','notes',array('id'=>$this->dwn_cat_id)));
	}

	function testEditDownloads_category()
	{
		edit_download_category($this->dwn_cat_id,'test',1,'test','edit_test','','','');

		$this->assertTrue('edit_test'==$GLOBALS['SITE_DB']->query_select_value('download_categories','notes',array('id'=>$this->dwn_cat_id)));
	}

	function tearDown()
	{
		delete_download_category($this->dwn_cat_id);
		parent::tearDown();
	}
}
