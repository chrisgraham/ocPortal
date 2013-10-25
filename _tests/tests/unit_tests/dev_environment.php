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
class dev_environment_test_set extends ocp_test_case
{
	function testDevMode()
	{
		$this->assertTrue($GLOBALS['DEV_MODE'],'Not running out of git or development mode disabled, therefore not all run-time checks enabled');
	}

	function testocpPHP()
	{
		$this->assertTrue(function_exists('ocp_mark_as_escaped'),'Not running ocProducts PHP so XSS and type strictness errors won\'t be detected');
	}
}
