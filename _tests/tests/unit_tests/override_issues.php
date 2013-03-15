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
class override_issues_test_set extends ocp_test_case
{
	function testOverrideIssues()
	{
		require_code('files2');
		$contents=get_directory_contents(get_file_base());
		foreach ($contents as $c)
		{
			if ((substr($c,-4)=='.php') && (!should_ignore_file($c,IGNORE_NONBUNDLED_SCATTERED | IGNORE_BUNDLED_VOLATILE)) && ($c!='_tests/tests/unit_tests/override_issues.php'))
			{
				$_c=file_get_contents(get_file_base().'/'.$c);
				$this->assertTrue((strpos($_c,'function  ')===false) && (strpos($_c,"function\t")===false),'Problematic function definition will cause ocPortal override system issues: '.$c);
			}
		}
	}
}
