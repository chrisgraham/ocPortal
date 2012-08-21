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
class overused_globals_test_set extends ocp_test_case
{
	function testUnusedGlobals()
	{
		$matches=array();
		$found_globals=array();

		require_code('files2');
		$files=get_directory_contents(get_file_base());
		foreach ($files as $file)
		{
			if ((substr($file,-4)=='.php') && (!should_ignore_file($file,IGNORE_NONBUNDLED_SCATTERED | IGNORE_CUSTOM_DIR_CONTENTS)))
			{
				$done_for_file=array();

				$contents=file_get_contents(get_file_base().'/'.$file);

				$num_matches=preg_match_all('#^\s*global ([^;]*);#m',$contents,$matches);
				for ($i=0;$i<$num_matches;$i++)
				{
					$vars=explode(',',$matches[1][$i]);
					foreach ($vars as $var)
					{
						$global=ltrim($var,'$');

						if (isset($done_for_file[$global])) continue;

						if (!isset($found_globals[$global])) $found_globals[$global]=0;
						$found_globals[$global]++;

						$done_for_file[$global]=true;
					}
				}

				$num_matches=preg_match_all('#\$GLOBALS\[\'(\w+)\'\]#',$contents,$matches);
				for ($i=0;$i<$num_matches;$i++)
				{
					$global=$matches[1][$i];

					if (isset($done_for_file[$global])) continue;

					if (!isset($found_globals[$global])) $found_globals[$global]=0;
					$found_globals[$global]++;

					$done_for_file[$global]=true;
				}
			}
		}

		foreach ($found_globals as $global=>$count)
		{
			if (in_array($global,array('SITE_DB','FORUM_DB','FORUM_DRIVER','SITE_INFO'))) continue;

			$this->assertTrue($count<5,'It is sloppy to make global variables that are commonly accessed ('.$global.', '.integer_format($count).' uses).');
		}
	}
}
