<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2013

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
class git_conflicts_test_set extends ocp_test_case
{
	function testValidCode()
	{
		if (function_exists('set_time_limit')) @set_time_limit(0);

		require_code('files2');
		$php_path=find_php_path();
		$contents=get_directory_contents(get_file_base());
		foreach ($contents as $c)
		{
			if ((substr($c,-4)=='.php') && (basename($c)!='errorlog.php') && (basename($c)!='phpstub.php') && (basename($c)!='permissioncheckslog.php'))
			{
				$this->assertTrue(strpos(file_get_contents($c),'<<<'.'<')===false,$c);
			}
		}
	}
}
