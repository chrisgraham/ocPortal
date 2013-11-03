<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		ocportal_release_build
 */

class Hook_addon_registry_ocportal_release_build
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
		return 'Licensed on the same terms as ocPortal';
	}

	/**
	 * Get the description of the addon
	 *
	 * @return string			Description of the addon
	 */
	function get_description()
	{
		return 'The ocPortal release build platform.';
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
			'sources_custom/hooks/systems/addon_registry/ocportal_release_build.php',
			'data_custom/build_rewrite_rules.php',
			'sources_custom/make_release.php',
			'adminzone/pages/minimodules_custom/make_release.php',
			'sources_custom/hooks/systems/do_next_menus/make_release.php',
			'adminzone/pages/minimodules_custom/push_bugfix.php',
			'adminzone/pages/minimodules_custom/plug_guid.php',
			'exports/builds/index.html',
			'data_custom/builds',
			'data_custom/builds/.DS_Store',
			'data_custom/builds/debian',
			'data_custom/builds/debian/.DS_Store',
			'data_custom/builds/debian/apache.conf',
			'data_custom/builds/debian/changelog',
			'data_custom/builds/debian/compat',
			'data_custom/builds/debian/control',
			'data_custom/builds/debian/copyright',
			'data_custom/builds/debian/docs',
			'data_custom/builds/debian/files',
			'data_custom/builds/debian/index.html',
			'data_custom/builds/debian/install',
			'data_custom/builds/debian/install.save',
			'data_custom/builds/debian/mysql',
			'data_custom/builds/debian/ocportal.debhelper.log',
			'data_custom/builds/debian/ocportal.examples',
			'data_custom/builds/debian/ocportal.substvars',
			'data_custom/builds/debian/Oxygen_Icons-24112010-0011.tar',
			'data_custom/builds/debian/patches',
			'data_custom/builds/debian/patches/index.html',
			'data_custom/builds/debian/postinst',
			'data_custom/builds/debian/postrm',
			'data_custom/builds/debian/preinst',
			'data_custom/builds/debian/prerm',
			'data_custom/builds/debian/README.Debian',
			'data_custom/builds/debian/rules',
			'data_custom/builds/debian/source',
			'data_custom/builds/debian/source/format',
			'data_custom/builds/debian/source/include-binaries',
			'data_custom/builds/debian/source/index.html',
			'data_custom/builds/debian/stamp-patched',
			'data_custom/builds/index.html',
			'data_custom/builds/readme.txt',
		);
	}
}