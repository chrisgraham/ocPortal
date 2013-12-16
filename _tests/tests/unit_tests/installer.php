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
class installer_test_set extends ocp_test_case
{
	function testDoesNotFullycrash()
	{
		$test=http_download_file(get_base_url().'/install.php',NULL,false);
		$this->assertTrue(strpos($test,'type="submit"')!==false); // Has start button: meaning something worked
	}
}
