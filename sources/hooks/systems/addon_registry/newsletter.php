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
 * @package		newsletter
 */

class Hook_addon_registry_newsletter
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
		return 'Support for users to join newsletters, and for the staff to send out newsletters to subscribers, and to specific usergroups.';
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
			'sources/hooks/modules/admin_setupwizard/newsletter.php',
			'sources/hooks/systems/config_default/interest_levels.php',
			'sources/hooks/systems/config_default/newsletter_text.php',
			'sources/hooks/systems/config_default/newsletter_title.php',
			'sources/hooks/systems/addon_registry/newsletter.php',
			'sources/hooks/systems/cron/newsletter_drip_send.php',
			'sources/hooks/systems/cron/newsletter_periodic.php',
			'sources/hooks/modules/admin_import_types/newsletter.php',
			'NEWSLETTER_AUTOMATED_FCOMCODE.tpl',
			'NEWSLETTER_AUTOMATE_SECTION_FCOMCODE.tpl',
			'NEWSLETTER_CONFIRM_WRAP.tpl',
			'NEWSLETTER_SUBSCRIBER.tpl',
			'NEWSLETTER_SUBSCRIBERS_SCREEN.tpl',
			'NEWSLETTER_NEW_RESOURCE_FCOMCODE.tpl',
			'adminzone/pages/modules/admin_newsletter.php',
			'themes/default/images/bigicons/newsletters.png',
			'themes/default/images/bigicons/newsletter_email_bounce.png',
			'themes/default/images/bigicons/import_subscribers.png',
			'themes/default/images/bigicons/newsletter_from_changes.png',
			'themes/default/images/pagepics/newsletter.png',
			'themes/default/images/pagepics/newsletter_from_changes.png',
			'lang/EN/newsletter.ini',
			'site/pages/modules/newsletter.php',
			'sources/blocks/main_newsletter_signup.php',
			'sources/hooks/modules/admin_import/newsletter_subscribers.php',
			'sources/hooks/blocks/main_staff_checklist/newsletter.php',
			'sources/hooks/modules/admin_newsletter/.htaccess',
			'sources/hooks/systems/do_next_menus/newsletter.php',
			'sources/newsletter.php',
			'themes/default/images/bigicons/subscribers.png',
			'sources/hooks/modules/admin_newsletter/index.html',
			'BLOCK_MAIN_NEWSLETTER_SIGNUP.tpl',
			'BLOCK_MAIN_NEWSLETTER_SIGNUP_DONE.tpl',
			'PERIODIC_NEWSLETTER_REMOVE.tpl',
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
			'NEWSLETTER_AUTOMATE_SECTION_FCOMCODE.tpl'=>'newsletter_automated_fcomcode',
			'NEWSLETTER_AUTOMATED_FCOMCODE.tpl'=>'newsletter_automated_fcomcode',
			'NEWSLETTER_SUBSCRIBER.tpl'=>'administrative__newsletter_subscribers_screen',
			'NEWSLETTER_SUBSCRIBERS_SCREEN.tpl'=>'administrative__newsletter_subscribers_screen',
			'NEWSLETTER_DEFAULT_FCOMCODE.tpl'=>'newsletter_default',
			'NEWSLETTER_CONFIRM_WRAP.tpl'=>'administrative__newsletter_confirm_wrap',
			'BLOCK_MAIN_NEWSLETTER_SIGNUP_DONE.tpl'=>'block_main_newsletter_signup_done',
			'BLOCK_MAIN_NEWSLETTER_SIGNUP.tpl'=>'block_main_newsletter_signup',
			'NEWSLETTER_NEW_RESOURCE_FCOMCODE.tpl'=>'newsletter_new_resource_fcomcode',
			'PERIODIC_NEWSLETTER_REMOVE.tpl'=>'periodic_newsletter_remove',
		);
	}

	/**
	 * Get a preview(s) of a (group of) template(s), as a full standalone piece of HTML in Tempcode format.
	 * Uses sources/lorem.php functions to place appropriate stock-text. Should not hard-code things, as the code is intended to be declaritive.
	 * Assumptions: You can assume all Lang/CSS/Javascript files in this addon have been pre-required.
	 *
	 * @return array			Array of previews, each is Tempcode. Normally we have just one preview, but occasionally it is good to test templates are flexible (e.g. if they use IF_EMPTY, we can test with and without blank data).
	 */
	function tpl_preview__newsletter_automated_fcomcode()
	{
		$automatic=array();
		foreach (placeholder_array() as $k=>$v)
		{
			$tmp=do_lorem_template('NEWSLETTER_AUTOMATE_SECTION_FCOMCODE', array(
				'I'=>lorem_word(),
				'TITLE'=>lorem_phrase(),
				'CONTENT'=>lorem_sentence()
			));
			$automatic[]=$tmp->evaluate(placeholder_number());
		}

		$content='';
		foreach ($automatic as $tp)
		{
			$content.=$tp;
		}

		return array(
			lorem_globalise(do_lorem_template('NEWSLETTER_AUTOMATED_FCOMCODE', array(
				'CONTENT'=>$content
			)), NULL, '', true)
		);
	}

	/**
	 * Get a preview(s) of a (group of) template(s), as a full standalone piece of HTML in Tempcode format.
	 * Uses sources/lorem.php functions to place appropriate stock-text. Should not hard-code things, as the code is intended to be declaritive.
	 * Assumptions: You can assume all Lang/CSS/Javascript files in this addon have been pre-required.
	 *
	 * @return array			Array of previews, each is Tempcode. Normally we have just one preview, but occasionally it is good to test templates are flexible (e.g. if they use IF_EMPTY, we can test with and without blank data).
	 */
	function tpl_preview__administrative__newsletter_subscribers_screen()
	{
		$out=new ocp_tempcode();
		foreach (placeholder_array() as $k=>$v)
		{
			$out->attach(do_lorem_template('NEWSLETTER_SUBSCRIBER', array(
				'EMAIL'=>lorem_word(),
				'FORENAME'=>lorem_word(),
				'SURNAME'=>lorem_word(),
				'NAME'=>lorem_word(),
				'NEWSLETTER_SEND_ID'=>placeholder_id(),
				'NEWSLETTER_HASH'=>lorem_word()
			)));
		}

		$outs=array();
		$outs[]=array(
			'SUB'=>$out,
			'TEXT'=>lorem_phrase()
		);

		return array(
			lorem_globalise(do_lorem_template('NEWSLETTER_SUBSCRIBERS_SCREEN', array(
				'SUBSCRIBERS'=>$outs,
				'PAGINATION'=>'',
				'TITLE'=>lorem_title(),
				'DOMAINS'=>placeholder_array()
			)), NULL, '', true)
		);
	}

	/**
	 * Get a preview(s) of a (group of) template(s), as a full standalone piece of HTML in Tempcode format.
	 * Uses sources/lorem.php functions to place appropriate stock-text. Should not hard-code things, as the code is intended to be declaritive.
	 * Assumptions: You can assume all Lang/CSS/Javascript files in this addon have been pre-required.
	 *
	 * @return array			Array of previews, each is Tempcode. Normally we have just one preview, but occasionally it is good to test templates are flexible (e.g. if they use IF_EMPTY, we can test with and without blank data).
	 */
	function tpl_preview__newsletter_default()
	{
		return array(
			lorem_globalise(do_lorem_template('NEWSLETTER_DEFAULT_FCOMCODE', array(
				'CONTENT'=>lorem_phrase(),
				'LANG'=>fallback_lang(),
				'SUBJECT'=>lorem_phrase(),
			)), NULL, '', true)
		);
	}

	/**
	 * Get a preview(s) of a (group of) template(s), as a full standalone piece of HTML in Tempcode format.
	 * Uses sources/lorem.php functions to place appropriate stock-text. Should not hard-code things, as the code is intended to be declaritive.
	 * Assumptions: You can assume all Lang/CSS/Javascript files in this addon have been pre-required.
	 *
	 * @return array			Array of previews, each is Tempcode. Normally we have just one preview, but occasionally it is good to test templates are flexible (e.g. if they use IF_EMPTY, we can test with and without blank data).
	 */
	function tpl_preview__administrative__newsletter_confirm_wrap()
	{
		$preview=do_lorem_template('NEWSLETTER_CONFIRM_WRAP', array(
			'TEXT_PREVIEW'=>lorem_sentence(),
			'PREVIEW'=>lorem_phrase(),
			'SUBJECT'=>lorem_phrase()
		));

		return array(
			lorem_globalise(do_lorem_template('CONFIRM_SCREEN', array(
				'URL'=>placeholder_url(),
				'BACK_URL'=>placeholder_url(),
				'PREVIEW'=>$preview,
				'FIELDS'=>new ocp_tempcode(),
				'TITLE'=>lorem_title()
			)), NULL, '', true)
		);
	}

	/**
	 * Get a preview(s) of a (group of) template(s), as a full standalone piece of HTML in Tempcode format.
	 * Uses sources/lorem.php functions to place appropriate stock-text. Should not hard-code things, as the code is intended to be declaritive.
	 * Assumptions: You can assume all Lang/CSS/Javascript files in this addon have been pre-required.
	 *
	 * @return array			Array of previews, each is Tempcode. Normally we have just one preview, but occasionally it is good to test templates are flexible (e.g. if they use IF_EMPTY, we can test with and without blank data).
	 */
	function tpl_preview__block_main_newsletter_signup_done()
	{
		return array(
			lorem_globalise(do_lorem_template('BLOCK_MAIN_NEWSLETTER_SIGNUP_DONE', array(
				'PASSWORD'=>lorem_phrase(),
				'NEWSLETTER_TITLE'=>lorem_word()
			)), NULL, '', true)
		);
	}

	/**
	 * Get a preview(s) of a (group of) template(s), as a full standalone piece of HTML in Tempcode format.
	 * Uses sources/lorem.php functions to place appropriate stock-text. Should not hard-code things, as the code is intended to be declaritive.
	 * Assumptions: You can assume all Lang/CSS/Javascript files in this addon have been pre-required.
	 *
	 * @return array			Array of previews, each is Tempcode. Normally we have just one preview, but occasionally it is good to test templates are flexible (e.g. if they use IF_EMPTY, we can test with and without blank data).
	 */
	function tpl_preview__block_main_newsletter_signup()
	{
		require_lang('javascript');
		return array(
			lorem_globalise(do_lorem_template('BLOCK_MAIN_NEWSLETTER_SIGNUP', array(
				'URL'=>placeholder_url(),
				'NEWSLETTER_TITLE'=>lorem_word(),
				'PATH_EXISTS' => true,
				'NID'=>placeholder_id()
			)), NULL, '', true)
		);
	}

	/**
	 * Get a preview(s) of a (group of) template(s), as a full standalone piece of HTML in Tempcode format.
	 * Uses sources/lorem.php functions to place appropriate stock-text. Should not hard-code things, as the code is intended to be declaritive.
	 * Assumptions: You can assume all Lang/CSS/Javascript files in this addon have been pre-required.
	 *
	 * @return array			Array of previews, each is Tempcode. Normally we have just one preview, but occasionally it is good to test templates are flexible (e.g. if they use IF_EMPTY, we can test with and without blank data).
	 */
	function tpl_preview__newsletter_new_resource_fcomcode()
	{
		return array(
			lorem_globalise(do_lorem_template('NEWSLETTER_NEW_RESOURCE_FCOMCODE', array(
				'MEMBER_ID'=>placeholder_id(),
				'URL'=>placeholder_url(),
				'NAME'=>lorem_word(),
				'DESCRIPTION'=>lorem_paragraph()
			)), NULL, '', true)
		);
	}

	/**
	 * Get a preview(s) of a (group of) template(s), as a full standalone piece of HTML in Tempcode format.
	 * Uses sources/lorem.php functions to place appropriate stock-text. Should not hard-code things, as the code is intended to be declaritive.
	 * Assumptions: You can assume all Lang/CSS/Javascript files in this addon have been pre-required.
	 *
	 * @return array			Array of previews, each is Tempcode. Normally we have just one preview, but occasionally it is good to test templates are flexible (e.g. if they use IF_EMPTY, we can test with and without blank data).
	 */
	function tpl_preview__periodic_newsletter_remove()
	{
		return array(
			lorem_globalise(do_lorem_template('PERIODIC_NEWSLETTER_REMOVE', array(
				'TITLE'=>lorem_title(),
				'URL'=>placeholder_url(),
			)), NULL, '', true)
		);
	}
}
