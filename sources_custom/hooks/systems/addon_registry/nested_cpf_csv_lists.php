<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		nested_cpf_csv_lists
 */

class Hook_addon_registry_nested_cpf_csv_lists
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
		return 'Development';
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
		return 'Common Public Attribution License';
	}

	/**
	 * Get the description of the addon
	 *
	 * @return string			Description of the addon
	 */
	function get_description()
	{
		return 'Allows complex chained dropdown choices of custom profile fields.

Set Custom Profile Field list fields to have a default value like [tt]countries.csv|country[/tt] to source list options from CSV files under [tt]/private_data[/tt]. You can set up chained list fields (e.g. chain a state field to a country field), via a syntax like [tt]countries.csv|state|countries.csv|country[/tt]. You can use this with multiple CSV files to essentially use CSV files like normalised database tables (hence why countries.csv is repeated twice in the example). The first line in the CSV file is for the header names (which [tt]country[/tt] and [tt]state[/tt] reference in these examples).';
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
				'PHP5.2',
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
			'sources_custom/hooks/systems/addon_registry/nested_cpf_csv_lists.php',
			'sources_custom/hooks/systems/fields/list.php',
			'sources_custom/hooks/systems/fields/multilist.php',
			'sources_custom/miniblocks/nested_csv_lists_javascript.php',
			'sources_custom/nested_csv.php',
			'themes/default/templates_custom/JAVASCRIPT_CUSTOM_GLOBALS.tpl',
			'lang_custom/EN/nested_csv.ini',
		);
	}
}