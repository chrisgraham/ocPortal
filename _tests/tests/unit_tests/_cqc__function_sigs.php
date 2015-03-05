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
class _cqc__function_sigs_test_set extends ocp_test_case
{
	function testAdminZone()
	{
		if (function_exists('set_time_limit')) @set_time_limit(0);
		$result=http_download_file(get_base_url().'/_tests/codechecker/phpdoc_parser.php',NULL,true,false,'ocPortal',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,10000.0);
		foreach (explode('<br />',$result) as $line)
			$this->assertTrue((trim($line)=='' || substr($line,0,4)=='Done' || substr($line,0,6)=='FINAL ' || strpos($line,'TODO')!==false || strpos($line,'HACKHACK')!==false),$line);
	}
}
