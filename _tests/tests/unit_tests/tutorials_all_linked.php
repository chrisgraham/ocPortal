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
class tutorials_all_linked_test_set extends ocp_test_case
{
	function testTutorialLinking()
	{
		$tutorials_index=file_get_contents(get_custom_file_base().'/docs/pages/comcode_custom/EN/tutorials.txt');
		$tutorials_summaries=file_get_contents(get_file_base().'/sources_custom/miniblocks/ocpcom_new_tutorials.php');

		$dh=opendir(get_custom_file_base().'/docs/pages/comcode_custom/EN');
		while (($f=readdir($dh))!==false)
		{
			if ((substr($f,0,4)=='tut_') && (substr($f,-4)=='.txt'))
			{
				$t=substr(basename($f,'.txt'),4);
				$this->assertTrue(strpos($tutorials_index,$t)!==false,'Tutorial not in index: '.$t);
				$this->assertTrue(strpos($tutorials_summaries,$t)!==false,'Tutorial not given a summary: '.$t);
			}
		}
		closedir($dh);
	}
}
