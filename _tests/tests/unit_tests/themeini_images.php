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
class themeini_images_test_set extends ocp_test_case
{
	function testThemeImageThere()
	{
		$ini_file=parse_ini_file(get_file_base().'/themes/default/theme.ini');
		foreach (explode(',',$ini_file['theme_wizard_images']) as $theme_image)
		{
			if (strpos($theme_image,'*')===false)
			{
				$this->assertTrue(find_theme_image($theme_image,true)!='','Missing but referenced in theme.ini: '.$theme_image);
			} else // This code branch is assumptive (that the '*' goes on the end), but it works with the current theme.ini...
			{
				$x=str_replace('/*','',$theme_image);
				$there=is_dir(get_file_base().'/themes/default/images/'.$x) || is_dir(get_file_base().'/themes/default/images/EN/'.$x);
				$this->assertTrue($there,'Possible error on this theme.ini image wildcard: '.$theme_image);
			}
		}
	}
}
