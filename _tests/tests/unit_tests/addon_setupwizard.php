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
class addon_setupwizard_test_set extends ocp_test_case
{
	function testPresenceDefinedForAllAddons()
	{
		$admin_setupwizard=file_get_contents(get_file_base().'/adminzone/pages/modules/admin_setupwizard.php');

		$hooks=find_all_hooks('systems','addon_registry');
		foreach (array_keys($hooks) as $hook)
		{
			if (substr($hook,0,5)=='core_') continue;
			$this->assertTrue(strpos($admin_setupwizard,'\''.$hook.'\'')!==false,'Addon presence not defined in Setup Wizard: '.$hook);
		}
	}
}
