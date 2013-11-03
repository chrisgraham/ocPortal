<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		oc_super_shout
 */

class Hook_addon_registry_oc_super_shout
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
		return 'Two new features to your shout box. Shake makes all the current visitors to your website\'s browser screen shake. The second makes any new messages within the shout box appear like an apparition and fly towards the current users of the site.

After installing this addon your shout box will essentially be treated as an embedded copy of the chat room linked to it. Enter/leave room messages will be saved into the room when a member goes somewhere it is shown. For that reason you may want to associate it to a chat room that isn\'t used independently to avoid that room being cluttered with these messages (the messages don\'t show in the shout box itself, as they are filtered out there). Alternatively you can blank out the language strings that provide the enter/leave room messages - ocPortal will recognise this and turn the feature off.';
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
				'Javascript enabled',
				'chat',
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
			'sources_custom/hooks/systems/addon_registry/oc_super_shout.php',
			'data_custom/messages.php',
			'themes/default/templates_custom/JAVASCRIPT_SHAKE.tpl',
			'themes/default/templates_custom/JAVASCRIPT_SHOUTBOX.tpl',
			'themes/default/templates_custom/JAVASCRIPT_TEXT_GHOSTS.tpl',
			'sources_custom/blocks/side_shoutbox.php',
			'themes/default/templates_custom/BLOCK_SIDE_SHOUTBOX.tpl',
		);
	}
}