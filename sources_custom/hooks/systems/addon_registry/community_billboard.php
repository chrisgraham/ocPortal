<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		community_billboard
 */

class Hook_addon_registry_community_billboard
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
		return 'Community billboard messages, designed to work with the pointstore to allow members to buy community billboard advertising on the website.';
	}

	/**
	 * Get a list of tutorials that apply to this addon
	 *
	 * @return array			List of tutorials
	 */
	function get_applicable_tutorials()
	{
		return array(
			'tut_points',
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
				'pointstore',
			),
			'recommends'=>array(
			),
			'conflicts_with'=>array(
			)
		);
	}

	/**
	 * Explicitly say which icon should be used
	 *
	 * @return URLPATH		Icon
	 */
	function get_default_icon()
	{
		return 'themes/default/images_custom/icons/48x48/menu/adminzone/audit/community_billboard.png';
	}

	/**
	 * Get a list of files that belong to this addon
	 *
	 * @return array			List of files
	 */
	function get_file_list()
	{
		return array(
			'themes/default/images_custom/icons/24x24/menu/adminzone/audit/community_billboard.png',
			'themes/default/images_custom/icons/48x48/menu/adminzone/audit/community_billboard.png',
			'themes/default/templates_custom/COMMUNITY_BILLBOARD_DETAILS.tpl',
			'themes/default/templates_custom/COMMUNITY_BILLBOARD_STORE_LIST_LINE.tpl',
			'themes/default/templates_custom/POINTSTORE_COMMUNITY_BILLBOARD_SCREEN.tpl',
			'themes/default/templates_custom/POINTSTORE_COMMUNITY_BILLBOARD_2.tpl',
			'adminzone/pages/modules_custom/admin_community_billboard.php',
			'lang_custom/EN/community_billboard.ini',
			'sources_custom/hooks/systems/config/system_community_billboard.php',
			'sources_custom/hooks/systems/addon_registry/community_billboard.php',
			'sources_custom/hooks/modules/admin_import_types/community_billboard.php',
			'sources_custom/hooks/systems/symbols/COMMUNITY_BILLBOARD.php',
			'sources_custom/community_billboard.php',
			'sources_custom/hooks/blocks/main_staff_checklist/community_billboard.php',
			'sources_custom/hooks/modules/pointstore/community_billboard.php',
			'sources_custom/hooks/systems/config/community_billboard.php',
			'sources_custom/hooks/systems/config/is_on_community_billboard_buy.php',
			'sources_custom/hooks/systems/notifications/pointstore_request_community_billboard.php',
			'sources_custom/hooks/systems/page_groupings/community_billboard.php',
			'themes/default/css_custom/community_billboard.css',
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
			'COMMUNITY_BILLBOARD_DETAILS.tpl'=>'administrative__community_billboard_manage_screen',
			'COMMUNITY_BILLBOARD_STORE_LIST_LINE.tpl'=>'administrative__community_billboard_manage_screen',
			'POINTSTORE_COMMUNITY_BILLBOARD_2.tpl'=>'pointstore_community_billboard_2',
			'POINTSTORE_COMMUNITY_BILLBOARD_SCREEN.tpl'=>'pointstore_community_billboard_screen',
		);
	}

	/**
	 * Get a preview(s) of a (group of) template(s), as a full standalone piece of HTML in Tempcode format.
	 * Uses sources/lorem.php functions to place appropriate stock-text. Should not hard-code things, as the code is intended to be declaritive.
	 * Assumptions: You can assume all Lang/CSS/JavaScript files in this addon have been pre-required.
	 *
	 * @return array			Array of previews, each is Tempcode. Normally we have just one preview, but occasionally it is good to test templates are flexible (e.g. if they use IF_EMPTY, we can test with and without blank data).
	 */
	function tpl_preview__pointstore_community_billboard_2()
	{
		return array(
			lorem_globalise(
				do_lorem_template('POINTSTORE_COMMUNITY_BILLBOARD_2',array(
					'TEXT_URL'=>placeholder_url(),
				)
			),NULL,'',true),
		);
	}

	/**
	 * Get a preview(s) of a (group of) template(s), as a full standalone piece of HTML in Tempcode format.
	 * Uses sources/lorem.php functions to place appropriate stock-text. Should not hard-code things, as the code is intended to be declaritive.
	 * Assumptions: You can assume all Lang/CSS/JavaScript files in this addon have been pre-required.
	 *
	 * @return array			Array of previews, each is Tempcode. Normally we have just one preview, but occasionally it is good to test templates are flexible (e.g. if they use IF_EMPTY, we can test with and without blank data).
	 */
	function tpl_preview__pointstore_community_billboard_screen()
	{
		return array(
			lorem_globalise(
				do_lorem_template('POINTSTORE_COMMUNITY_BILLBOARD_SCREEN',array(
					'TITLE'=>lorem_title(),
					'TEXT_URL'=>placeholder_url(),
					'QUEUE'=>placeholder_number(),
					'COST'=>placeholder_number(),
				)
			),NULL,'',true),
		);
	}

	/**
	 * Get a preview(s) of a (group of) template(s), as a full standalone piece of HTML in Tempcode format.
	 * Uses sources/lorem.php functions to place appropriate stock-text. Should not hard-code things, as the code is intended to be declaritive.
	 * Assumptions: You can assume all Lang/CSS/JavaScript files in this addon have been pre-required.
	 *
	 * @return array			Array of previews, each is Tempcode. Normally we have just one preview, but occasionally it is good to test templates are flexible (e.g. if they use IF_EMPTY, we can test with and without blank data).
	 */
	function tpl_preview__administrative__community_billboard_manage_screen()
	{
		require_css('forms');

		$about_current=do_lorem_template('COMMUNITY_BILLBOARD_DETAILS',array(
			'USERNAME'=>lorem_word_html(),
			'DAYS_ORDERED'=>lorem_phrase(),
			'DATE_RAW'=>placeholder_time(),
			'DATE'=>placeholder_time(),
		));

		$out=new ocp_tempcode();
		foreach (placeholder_array() as $key=>$value)
		{
			$text=do_lorem_template('COMMUNITY_BILLBOARD_STORE_LIST_LINE',array(
				'MESSAGE'=>$value,
				'STATUS'=>do_lang('NEW')
			));
			$out->attach(do_lorem_template('FORM_SCREEN_INPUT_LIST_ENTRY',array(
				'SELECTED'=>false,
				'DISABLED'=>false,
				'CLASS'=>'',
				'NAME'=>strval($key),
				'TEXT'=>$text->evaluate(),
			)));
		}

		$input=do_lorem_template('FORM_SCREEN_INPUT_LIST',array(
			'TABINDEX'=>'5',
			'REQUIRED'=>'_required',
			'NAME'=>lorem_word(),
			'CONTENT'=>$out,
			'INLINE_LIST'=>true,
		));
		$fields=do_lorem_template('FORM_SCREEN_FIELD',array(
			'REQUIRED'=>true,
			'SKIP_LABEL'=>false,
			'PRETTY_NAME'=>lorem_word(),
			'NAME'=>lorem_word(),
			'DESCRIPTION'=>lorem_sentence_html(),
			'DESCRIPTION_SIDE'=>'',
			'INPUT'=>$input,
			'COMCODE'=>'',
		));

		return array(
			lorem_globalise(do_lorem_template('FORM_SCREEN',array(
				'TITLE'=>lorem_title(),
				'TEXT'=>$about_current,
				'HIDDEN'=>'',
				'URL'=>placeholder_url(),
				'GET'=>true,
				'FIELDS'=>$fields,
				'SUBMIT_ICON'=>'buttons__proceed',
				'SUBMIT_NAME'=>lorem_word(),
			)),NULL,'',true)
		);
	}
}
