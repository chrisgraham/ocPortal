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
class downloads_test_set extends ocp_test_case
{
	var $dwn_id;

	function setUp()
	{
		parent::setUp();

		$GLOBALS['NO_QUERY_LIMIT']=true;

		require_code('downloads');
		require_code('downloads2');

		$this->dwn_id=add_download(db_get_first_id(),'111','http://www.google.com','Testing download','sujith','',0,1,1,1,0,'','apple.jpeg',110,0,0,NULL,NULL,0,0,NULL,NULL,NULL);

		$this->assertTrue('http://www.google.com'==$GLOBALS['SITE_DB']->query_select_value('download_downloads','url',array('id'=>$this->dwn_id)));
	}

	function testEditDownloads()
	{
		edit_download($this->dwn_id,db_get_first_id(),'222','http://www.yahoo.com','edited download','sujith','',0,0,1,1,1,0,'','fruit.jpeg',210,0,0,NULL,'','');

		$this->assertTrue('http://www.yahoo.com'==$GLOBALS['SITE_DB']->query_select_value('download_downloads','url',array('id'=>$this->dwn_id)));
	}

	function tearDown()
	{
		delete_download($this->dwn_id,false);
		parent::tearDown();
	}
}
