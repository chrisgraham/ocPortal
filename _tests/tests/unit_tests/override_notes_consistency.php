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
class override_notes_consistency_test_set extends ocp_test_case
{
	function testUnusedGlobals()
	{
		require_code('files');
		require_code('files2');
		$files=get_directory_contents(get_file_base(),'',true);
		foreach ($files as $file)
		{
			if (substr($file,-4)!='.php') continue;

			if (should_ignore_file($file,IGNORE_NONBUNDLED_SCATTERED | IGNORE_CUSTOM_DIR_CONTENTS)) continue;

			if (file_exists(dirname($file).'/index.php')) continue; // Zone directory, no override support

			$contents=file_get_contents(get_file_base().'/'.$file);

			if (strpos($contents,'CQC: No check')!==false) continue;

			if (strpos($file,'_custom/')===false)
			{
				$this->assertTrue(strpos($contents,'NOTE TO PROGRAMMERS:')!==false,'Missing "NOTE TO PROGRAMMERS:" in '.$file);
			} else
			{
				$this->assertFalse(strpos($contents,'NOTE TO PROGRAMMERS:')!==false,'Undesirable "NOTE TO PROGRAMMERS:" in '.$file);
			}
		}
	}
}
