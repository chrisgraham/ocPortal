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
class news_test_set extends ocp_test_case
{
	var $news_id;

	function setUp()
	{
		parent::setUp();
		require_code('news');
		$this->news_id=add_news($title='Today',$news="hiiiiiiiiiii",$author='rolly',$validated=1,$allow_rating=1,$allow_comments=1,$allow_trackbacks=1,$notes='',$news_article='test article',$main_news_category=5,$news_category=NULL,$time='1262671781',$submitter=NULL,$views=0,$edit_date=NULL,$id=NULL,$image='');
		$this->assertTrue('Today'==get_translated_text($GLOBALS['SITE_DB']->query_value('news','title ',array('id'=>$this->news_id))));
	}

	function testEditNews()
	{
		edit_news($id=$this->news_id,$title="Politics",$news="teheyehehj ",$author="rolly",$validated=1,$allow_rating=1,$allow_comments=1,$allow_trackbacks=1,$notes="yedd",$news_article="test article 22222222",$main_news_category=5,$news_category=NULL,$meta_keywords="",$meta_description="",$image="");

		$this->assertTrue('Politics'==get_translated_text($GLOBALS['SITE_DB']->query_value('news','title ',array('id'=>$this->news_id))));
	}


	function tearDown()
	{
		delete_news($this->news_id);
		parent::tearDown();
	}
}
