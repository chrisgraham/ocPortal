<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		oc_banter
 */

class Hook_addon_registry_oc_banter
{
	/**
	 * Get a list of file permissions to set
	 *
	 * @return array			File permissions to set
	 */
	function get_chmod_array()
	{
		return array();
	}

	/**
	 * Get the version of ocPortal this addon is for
	 *
	 * @return float			Version number
	 */
	function get_version()
	{
		return ocp_version_number();
	}

	/**
	 * Get the addon category
	 *
	 * @return string			The category
	 */
	function get_category()
	{
		return 'Fun and Games';
	}

	/**
	 * Get the addon author
	 *
	 * @return string			The author
	 */
	function get_author()
	{
		return 'Kamen Blaginov';
	}

	/**
	 * Find other authors
	 *
	 * @return array			A list of co-authors that should be attributed
	 */
	function get_copyright_attribution()
	{
		return array();
	}

	/**
	 * Get the addon licence (one-line summary only)
	 *
	 * @return string			The licence
	 */
	function get_licence()
	{
		return 'Licensed on the same terms as ocPortal';
	}

	/**
	 * Get the description of the addon
	 *
	 * @return string			Description of the addon
	 */
	function get_description()
	{
		return 'Randomly creates Private Topics between two random members with an insult inside of it (and a brief explanation).

The insult is randomly selected from a list which also includes insults-comebacks. This list is configurable in the Admin Zone under Setup (Manage insults icon). You should separate the insults from comebacks by equal sign(=) and add any new insults on a new line (the same way this is done in Random quotes section).

The insulted member has to try and make the right reply, if they succeed then they will be awarded some site points which is configurable under Setup > Configuration > Points options. The default insults are based off the classic computer game, Monkey Island.';
	}

	/**
	 * Get a list of tutorials that apply to this addon
	 *
	 * @return array			List of tutorials
	 */
	function get_applicable_tutorials()
	{
		return array(
		);
	}

	/**
	 * Get a mapping of dependency types
	 *
	 * @return array			File permissions to set
	 */
	function get_dependencies()
	{
		return array(
			'requires'=>array(
				'Cron',
				'OCF',
			),
			'recommends'=>array(
			),
			'conflicts_with'=>array(
			)
		);
	}

	/**
	 * Get a list of files that belong to this addon
	 *
	 * @return array			List of files
	 */
	function get_file_list()
	{
		return array(
			'themes/default/images_custom/icons/24x24/menu/insults.png',
			'themes/default/images_custom/icons/48x48/menu/insults.png',
			'sources_custom/hooks/systems/addon_registry/oc_banter.php',
			'adminzone/pages/comcode_custom/EN/insults.txt',
			'lang_custom/EN/insults.ini',
			'sources_custom/hooks/systems/cron/insults.php',
			'sources_custom/hooks/systems/do_next_menus/insults.php',
			'sources_custom/hooks/systems/upon_query/insults.php',
			'text_custom/EN/insults.txt',
			'sources_custom/hooks/systems/config/insult_points.php',
		);
	}
}