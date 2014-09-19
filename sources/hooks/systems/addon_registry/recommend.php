<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.


 NOTE TO PROGRAMMERS:
   Do not edit this file. If you need to make changes, save your changed file to the appropriate *_custom folder
   **** If you ignore this advice, then your website upgrades (e.g. for bug fixes) will likely kill your changes ****

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		recommend
 */

class Hook_addon_registry_recommend
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
	 * Get the description of the addon
	 *
	 * @return string			Description of the addon
	 */
	function get_description()
	{
		return 'Allow members to easily recommend the website to others.';
	}

	/**
	 * Get a list of tutorials that apply to this addon
	 *
	 * @return array			List of tutorials
	 */
	function get_applicable_tutorials()
	{
		return array(
			'tut_members',
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
			'requires'=>array(),
			'recommends'=>array(),
			'conflicts_with'=>array(),
		);
	}

	/**
	 * Explicitly say which icon should be used
	 *
	 * @return URLPATH		Icon
	 */
	function get_default_icon()
	{
		return 'themes/default/images/icons/48x48/menu/site_meta/recommend.png';
	}

	/**
	 * Get a list of files that belong to this addon
	 *
	 * @return array			List of files
	 */
	function get_file_list()
	{
		return array(
			'themes/default/images/icons/24x24/menu/site_meta/recommend.png',
			'themes/default/images/icons/48x48/menu/site_meta/recommend.png',
			'themes/default/images/icons/24x24/links/digg.png',
			'themes/default/images/icons/24x24/links/facebook.png',
			'themes/default/images/icons/24x24/links/stumbleupon.png',
			'themes/default/images/icons/24x24/links/twitter.png',
			'themes/default/images/icons/24x24/links/favorites.png',
			'themes/default/images/icons/48x48/links/digg.png',
			'themes/default/images/icons/48x48/links/facebook.png',
			'themes/default/images/icons/48x48/links/stumbleupon.png',
			'themes/default/images/icons/48x48/links/twitter.png',
			'themes/default/images/icons/48x48/links/favorites.png',
			'sources/hooks/systems/config/points_RECOMMEND_SITE.php',
			'sources/hooks/systems/realtime_rain/recommend.php',
			'sources/hooks/systems/addon_registry/recommend.php',
			'lang/EN/recommend.ini',
			'pages/modules/recommend.php',
			'pages/comcode/EN/recommend_help.txt',
			'sources/recommend.php',
			'sources/blocks/main_screen_actions.php',
			'themes/default/css/screen_actions.css',
			'themes/default/templates/BLOCK_MAIN_SCREEN_ACTIONS.tpl',
			'sources/hooks/systems/config/enable_csv_recommend.php',
			'sources/hooks/systems/page_groupings/recommend.php',
			'themes/default/css/recommend.css',
		);
	}


	/**
	 * Get mapping between template names and the method of this class that can render a preview of them
	 *
	 * @return array						The mapping
	 */
	function tpl_previews()
	{
		return array(
			'BLOCK_MAIN_SCREEN_ACTIONS.tpl'=>'block_main_screen_actions'
		);
	}

	/**
	 * Get a preview(s) of a (group of) template(s), as a full standalone piece of HTML in Tempcode format.
	 * Uses sources/lorem.php functions to place appropriate stock-text. Should not hard-code things, as the code is intended to be declaritive.
	 * Assumptions: You can assume all Lang/CSS/JavaScript files in this addon have been pre-required.
	 *
	 * @return array						Array of previews, each is Tempcode. Normally we have just one preview, but occasionally it is good to test templates are flexible (e.g. if they use IF_EMPTY, we can test with and without blank data).
	 */
	function tpl_preview__block_main_screen_actions()
	{
		return array(
			lorem_globalise(do_lorem_template('BLOCK_MAIN_SCREEN_ACTIONS',array(
				'PRINT_URL'=>placeholder_url(),
				'RECOMMEND_URL'=>placeholder_url(),
				'EASY_SELF_URL'=>placeholder_url(),
				'TITLE'=>lorem_phrase(),
			)),NULL,'',true)
		);
	}
}
