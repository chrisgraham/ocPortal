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
class google_appengine_test_set extends ocp_test_case
{
	function testPregConstraint()
	{
		require_code('files');
		require_code('files2');
		$files=get_directory_contents(get_file_base(),'',true);
		foreach ($files as $file)
		{
			if ((substr($file,-4)=='.php') && (!should_ignore_file($file,IGNORE_BUNDLED_VOLATILE | IGNORE_NONBUNDLED_SCATTERED | IGNORE_CUSTOM_DIR_CONTENTS)))
			{
				$contents=file_get_contents(get_file_base().'/'.$file);
				if (preg_match('#preg_(replace|replace_callback|match|match_all|grep|split)\(\'(.)[^\']*(?<!\\\\)\\2[^\']*e#',$contents)!=0)
				{
					$this->assertTrue(false,'regexp /e not allowed (in '.$file.')');
				}
			}
		}
	}
}
