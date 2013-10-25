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
 * @package		ocf_post_templates
 */

class Hook_addon_registry_ocf_post_templates
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
		return 'Post templates for the OCF forum.';
	}

	/**
	 * Get a list of tutorials that apply to this addon
	 *
	 * @return array			List of tutorials
	 */
	function get_applicable_tutorials()
	{
		return array(
			'tut_forum_helpdesk',
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
				'ocf_forum'
			),
			'recommends'=>array(),
			'conflicts_with'=>array()
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
			'sources/hooks/systems/resource_meta_aware/post_template.php',
			'sources/hooks/systems/occle_fs/post_templates.php',
			'sources/hooks/systems/addon_registry/ocf_post_templates.php',
			'OCF_POST_TEMPLATE_SELECT.tpl',
			'adminzone/pages/modules/admin_ocf_post_templates.php',
			'themes/default/images/bigicons/posttemplates.png',
			'themes/default/images/pagepics/posttemplates.png',
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
			'OCF_POST_TEMPLATE_SELECT.tpl'=>'ocf_post_template_select'
		);
	}

	/**
	 * Get a preview(s) of a (group of) template(s), as a full standalone piece of HTML in Tempcode format.
	 * Uses sources/lorem.php functions to place appropriate stock-text. Should not hard-code things, as the code is intended to be declaritive.
	 * Assumptions: You can assume all Lang/CSS/Javascript files in this addon have been pre-required.
	 *
	 * @return array			Array of previews, each is Tempcode. Normally we have just one preview, but occasionally it is good to test templates are flexible (e.g. if they use IF_EMPTY, we can test with and without blank data).
	 */
	function tpl_preview__ocf_post_template_select()
	{
		require_lang('ocf');
		require_css('ocf');

		$list=new ocp_tempcode();
		foreach (placeholder_array() as $key=>$value)
		{
			$list->attach(do_lorem_template('FORM_SCREEN_INPUT_LIST_ENTRY', array(
				'SELECTED'=>false,
				'DISABLED'=>false,
				'CLASS'=>'',
				'NAME'=>lorem_word().strval($key),
				'TEXT'=>lorem_phrase()
			)));
		}

		$input=do_lorem_template('OCF_POST_TEMPLATE_SELECT', array(
			'TABINDEX'=>placeholder_number(),
			'LIST'=>$list
		));

		$fields=new ocp_tempcode();
		$fields->attach(do_lorem_template('FORM_SCREEN_FIELD', array(
			'REQUIRED'=>true,
			'SKIP_LABEL'=>false,
			'PRETTY_NAME'=>lorem_word(),
			'NAME'=>'post_template',
			'DESCRIPTION'=>lorem_sentence_html(),
			'DESCRIPTION_SIDE'=>'',
			'INPUT'=>$input,
			'COMCODE'=>''
		)));

		return array(
			lorem_globalise(do_lorem_template('FORM_SCREEN', array(
				'SKIP_VALIDATION'=>true,
				'HIDDEN'=>'',
				'TITLE'=>lorem_title(),
				'URL'=>placeholder_url(),
				'FIELDS'=>$fields,
				'SUBMIT_NAME'=>lorem_phrase(),
				'TEXT'=>lorem_sentence_html()
			)), NULL, '', true)
		);
	}

}
