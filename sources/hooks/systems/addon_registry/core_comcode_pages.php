<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.


 NOTE TO PROGRAMMERS:
   Do not edit this file. If you need to make changes, save your changed file to the appropriate *_custom folder
   **** If you ignore this advice, then your website upgrades (e.g. for bug fixes) will likely kill your changes ****

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		core_comcode_pages
 */

class Hook_addon_registry_core_comcode_pages
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
		return 'Manage new pages on the website, known as Comcode pages.';
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
	 * Get a list of files that belong to this addon
	 *
	 * @return array			List of files
	 */
	function get_file_list()
	{
		return array(

			'sources/hooks/systems/config_default/number_revisions_show.php',
			'sources/hooks/systems/config_default/points_COMCODE_PAGE_ADD.php',
			'sources/hooks/systems/config_default/store_revisions.php',
			'sources/hooks/systems/addon_registry/core_comcode_pages.php',
			'COMCODE_PAGE_EXPORT_SCREEN.tpl',
			'COMCODE_PAGE_EDIT_ACTIONS.tpl',
			'COMCODE_PAGE_PREVIEW.tpl',
			'sources/hooks/modules/search/comcode_pages.php',
			'sources/hooks/systems/awards/comcode_page.php',
			'sources/hooks/systems/content_meta_aware/comcode_page.php',
			'themes/default/images/bigicons/comcode_page_edit.png',
			'COMCODE_PAGE_SCREEN.tpl',
			'themes/default/images/pagepics/comcode_page_edit.png',
			'sources/hooks/systems/rss/comcode_pages.php',
			'sources/hooks/modules/admin_cleanup/comcode_pages.php',
			'cms/pages/modules/cms_comcode_pages.php',
			'sources/hooks/systems/preview/comcode_page.php',
			'sources/hooks/systems/attachments/comcode_page.php',
			'sources/hooks/modules/admin_unvalidated/comcode_pages.php',
			'sources/hooks/modules/admin_newsletter/comcode_pages.php',
		);
	}


	/**
	* Get mapping between template names and the method of this class that can render a preview of them
	*
	* @return array			The mapping
	*/
	function tpl_previews()
	{
		return array(
				'COMCODE_PAGE_EXPORT_SCREEN.tpl'=>'comcode_page_export_screen',
				'COMCODE_PAGE_SCREEN.tpl'=>'comcode_page_screen',
				'COMCODE_PAGE_EDIT_ACTIONS.tpl'=>'comcode_page_edit_actions',
				'COMCODE_PAGE_PREVIEW.tpl'=>'comcode_page_preview',
				);
	}

	/**
	 * Get a preview(s) of a (group of) template(s), as a full standalone piece of HTML in Tempcode format.
	 * Uses sources/lorem.php functions to place appropriate stock-text. Should not hard-code things, as the code is intended to be declaritive.
	 * Assumptions: You can assume all Lang/CSS/Javascript files in this addon have been pre-required.
	 *
	 * @return array			Array of previews, each is Tempcode. Normally we have just one preview, but occasionally it is good to test templates are flexible (e.g. if they use IF_EMPTY, we can test with and without blank data).
	 */
	function tpl_preview__comcode_page_edit_actions()
	{
		require_lang('zones');
		return array(
			lorem_globalise(
				do_lorem_template('COMCODE_PAGE_EDIT_ACTIONS',array(
					'EDIT_URL'=>placeholder_url(),
					'CLONE_URL'=>placeholder_url(),
						)
			),NULL,'',true),
		);
	}

	/**
	 * Get a preview(s) of a (group of) template(s), as a full standalone piece of HTML in Tempcode format.
	 * Uses sources/lorem.php functions to place appropriate stock-text. Should not hard-code things, as the code is intended to be declaritive.
	 * Assumptions: You can assume all Lang/CSS/Javascript files in this addon have been pre-required.
	 *
	 * @return array			Array of previews, each is Tempcode. Normally we have just one preview, but occasionally it is good to test templates are flexible (e.g. if they use IF_EMPTY, we can test with and without blank data).
	 */
	function tpl_preview__comcode_page_export_screen()
	{
		require_lang('zones');
		return array(
			lorem_globalise(
				do_lorem_template('COMCODE_PAGE_EXPORT_SCREEN',array(
					'TITLE'=>lorem_title(),
					'EXPORT'=>lorem_chunk(),
						)
			),NULL,'',true),
		);
	}

	/**
	 * Get a preview(s) of a (group of) template(s), as a full standalone piece of HTML in Tempcode format.
	 * Uses sources/lorem.php functions to place appropriate stock-text. Should not hard-code things, as the code is intended to be declaritive.
	 * Assumptions: You can assume all Lang/CSS/Javascript files in this addon have been pre-required.
	 *
	 * @return array			Array of previews, each is Tempcode. Normally we have just one preview, but occasionally it is good to test templates are flexible (e.g. if they use IF_EMPTY, we can test with and without blank data).
	 */
	function tpl_preview__comcode_page_screen()
	{
		return array(
			lorem_globalise(
				do_lorem_template('COMCODE_PAGE_SCREEN',array(
					'BEING_INCLUDED'=>false,
					'SUBMITTER'=>placeholder_id(),
					'TAGS'=>lorem_word_html(),
					'WARNING_DETAILS'=>'',
					'EDIT_DATE_RAW'=>placeholder_date_raw(),
					'SHOW_AS_EDIT'=>lorem_phrase(),
					'CONTENT'=>lorem_phrase(),
					'EDIT_URL'=>placeholder_url(),
					'ADD_CHILD_URL'=>placeholder_url(),
					'NAME'=>lorem_word(),
						)
			),NULL,'',true),
		);
	}

	/**
	 * Get a preview(s) of a (group of) template(s), as a full standalone piece of HTML in Tempcode format.
	 * Uses sources/lorem.php functions to place appropriate stock-text. Should not hard-code things, as the code is intended to be declaritive.
	 * Assumptions: You can assume all Lang/CSS/Javascript files in this addon have been pre-required.
	 *
	 * @return array			Array of previews, each is Tempcode. Normally we have just one preview, but occasionally it is good to test templates are flexible (e.g. if they use IF_EMPTY, we can test with and without blank data).
	 */
	function tpl_preview__comcode_page_preview()
	{
		return array(
			lorem_globalise(
				do_lorem_template('COMCODE_PAGE_PREVIEW',array(
					'PAGE'=>lorem_phrase(),
					'ZONE'=>lorem_phrase(),
					'URL'=>placeholder_url(),
					'SUMMARY'=>lorem_paragraph_html(),
						)
			),NULL,'',true),
		);
	}
}