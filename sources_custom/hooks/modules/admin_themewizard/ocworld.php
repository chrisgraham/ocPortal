<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		ocworld
 */

class Hook_admin_themewizard_ocworld
{
	/**
	 * Find details of images to include/exclude in the Theme Wizard.
	 *
	 * @return array	A pair: List of theme image patterns to include, List of theme image patterns to exclude
	 */
	function run()
	{
		return array(array('logo/ocworld-logo',),array());
	}
}


