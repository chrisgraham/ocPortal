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
class quiz_test_set extends ocp_test_case
{
	var $quiz_id;

	function setUp()
	{
		parent::setUp();

		require_code('quiz');

		$this->quiz_id=add_quiz('Quiz1',15,'Begin','End','','somethng',60,time(),NULL,1,0,'TEST',1,'Questions',NULL,0,NULL);

		$this->assertTrue('Quiz1'==get_translated_text($GLOBALS['FORUM_DB']->query_value('quizzes','q_name',array('id'=>$this->quiz_id))));
	}

	function testEditQuiz()
	{
		edit_quiz($this->quiz_id,'Quiz2',10,'Go','Stop','','Nothing',50,time(),NULL,3,0,'TEST',1,'Questions','Nothing','',0,NULL);

		$this->assertTrue('Quiz2'==get_translated_text($GLOBALS['FORUM_DB']->query_value('quizzes','q_name',array('id'=>$this->quiz_id))));
	}

	function tearDown()
	{
		delete_quiz($this->quiz_id);
		parent::tearDown();
	}
}
