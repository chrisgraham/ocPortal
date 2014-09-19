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
 * @package		supermember_directory
 */

class Hook_addon_registry_supermember_directory
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
		return 'Show a list of all members in the configured "Super member" usergroup. Useful for communities that need to provide a list of VIPs.';
	}

	/**
	 * Get a list of tutorials that apply to this addon
	 *
	 * @return array			List of tutorials
	 */
	function get_applicable_tutorials()
	{
		return array(
			'tut_collaboration',
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
				'collaboration_zone'
			),
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
		return 'themes/default/images/icons/48x48/menu/collaboration/supermembers.png';
	}

	/**
	 * Get a list of files that belong to this addon
	 *
	 * @return array			List of files
	 */
	function get_file_list()
	{
		return array(
			'themes/default/images/icons/24x24/menu/collaboration/supermembers.png',
			'themes/default/images/icons/48x48/menu/collaboration/supermembers.png',
			'sources/hooks/systems/config/supermembers_text.php',
			'sources/hooks/systems/addon_registry/supermember_directory.php',
			'lang/EN/supermembers.ini',
			'themes/default/templates/SUPERMEMBERS_SCREEN.tpl',
			'themes/default/templates/SUPERMEMBERS_SCREEN_GROUP.tpl',
			'collaboration/pages/modules/supermembers.php',
			'sources/hooks/systems/page_groupings/supermember_directory.php',
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
			'SUPERMEMBERS_SCREEN_GROUP.tpl'=>'supermembers_screen',
			'SUPERMEMBERS_SCREEN.tpl'=>'supermembers_screen'
		);
	}

	/**
	 * Get a preview(s) of a (group of) template(s), as a full standalone piece of HTML in Tempcode format.
	 * Uses sources/lorem.php functions to place appropriate stock-text. Should not hard-code things, as the code is intended to be declaritive.
	 * Assumptions: You can assume all Lang/CSS/JavaScript files in this addon have been pre-required.
	 *
	 * @return array						Array of previews, each is Tempcode. Normally we have just one preview, but occasionally it is good to test templates are flexible (e.g. if they use IF_EMPTY, we can test with and without blank data).
	 */
	function tpl_preview__supermembers_screen()
	{
		require_lang('authors');
		require_lang('points');

		$groups=do_lorem_template('SUPERMEMBERS_SCREEN_GROUP',array(
			'ENTRIES'=>array(
				array(
					'USERNAME'=>lorem_phrase(),
					'DAYS'=>placeholder_number(),
					'PROFILE_URL'=>placeholder_url(),
					'AUTHOR_URL'=>placeholder_url(),
					'POINTS_URL'=>placeholder_url(),
					'PM_URL'=>placeholder_url(),
					'SKILLS'=>lorem_phrase(),
				),
			),
			'GROUP_NAME'=>lorem_phrase(),
		));

		return array(
			lorem_globalise(do_lorem_template('SUPERMEMBERS_SCREEN',array(
				'TITLE'=>lorem_title(),
				'GROUPS'=>$groups,
				'TEXT'=>lorem_sentence_html(),
			)),NULL,'',true)
		);
	}
}
