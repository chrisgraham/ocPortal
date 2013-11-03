<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		oc_whitelist
 */

class Hook_addon_registry_oc_whitelist
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
		return 'Admin Utilities';
	}

	/**
	 * Get the addon author
	 *
	 * @return string			The author
	 */
	function get_author()
	{
		return 'Chris Graham';
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
		return 'Fine-grained control over Comcode permissions.

Normally there is a set of Comcode tags that regular users simply cannot use. However, with the ocWhitelist addon you can define a list of special cases, portions of Comcode that are allowed regardless of the limitation on the tag itself. Put each sequence of Comcode on it\'s own line, and make sure that each line starts and ends with the open/close for the tag that is being whitelisted on. i.e. each line should look like [code=\"Comcode\"][tag...]...[/tag][/code]

Alternatively you can also use regular expressions (explained here: http://php.net/manual/en/book.pcre.php), if you surround with slashes and encode things appropriately.';
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
			'sources_custom/hooks/systems/addon_registry/oc_whitelist.php',
			'adminzone/pages/comcode_custom/EN/comcode_whitelist.txt',
			'sources_custom/comcode_renderer.php',
			'sources_custom/comcode_compiler.php',
			'sources_custom/hooks/systems/do_next_menus/comcode_whitelist.php',
			'text_custom/comcode_whitelist.txt',
		);
	}
}