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
 * @package		backup
 */

class Hook_addon_registry_backup
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
		return 'Perform incremental or full backups of files and the database. Supports scheduling.';
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

			'sources/hooks/systems/notifications/backup_finished.php',
			'sources/hooks/systems/config_default/backup_overwrite.php',
			'sources/hooks/systems/config_default/backup_server_hostname.php',
			'sources/hooks/systems/config_default/backup_server_password.php',
			'sources/hooks/systems/config_default/backup_server_path.php',
			'sources/hooks/systems/config_default/backup_server_port.php',
			'sources/hooks/systems/config_default/backup_server_user.php',
			'sources/hooks/systems/config_default/backup_time.php',
			'data/modules/admin_backup/.htaccess',
			'data_custom/modules/admin_backup/.htaccess',
			'sources/hooks/systems/addon_registry/backup.php',
			'RESTORE_WRAP.tpl',
			'exports/backups/index.html',
			'BACKUP_LAUNCH_SCREEN.tpl',
			'adminzone/pages/modules/admin_backup.php',
			'themes/default/images/bigicons/backups.png',
			'themes/default/images/pagepics/backups.png',
			'data/modules/admin_backup/index.html',
			'data/modules/admin_backup/restore.php.pre',
			'data_custom/modules/admin_backup/index.html',
			'lang/EN/backups.ini',
			'sources/backup.php',
			'sources/hooks/blocks/main_staff_checklist/backup.php',
			'sources/hooks/systems/cron/backups.php',
			'sources/hooks/systems/do_next_menus/backup.php',
			'sources/hooks/systems/snippets/backup_size.php',
			'exports/backups/.htaccess',
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
				'RESTORE_WRAP.tpl'=>'administrative__restore_wrap',
				'BACKUP_LAUNCH_SCREEN.tpl'=>'administrative__backup_launch_screen',
				);
	}

	/**
	 * Get a preview(s) of a (group of) template(s), as a full standalone piece of HTML in Tempcode format.
	 * Uses sources/lorem.php functions to place appropriate stock-text. Should not hard-code things, as the code is intended to be declaritive.
	 * Assumptions: You can assume all Lang/CSS/Javascript files in this addon have been pre-required.
	 *
	 * @return array			Array of previews, each is Tempcode. Normally we have just one preview, but occasionally it is good to test templates are flexible (e.g. if they use IF_EMPTY, we can test with and without blank data).
	 */
	function tpl_preview__administrative__backup_launch_screen()
	{
		return array(
			lorem_globalise(
				do_lorem_template('BACKUP_LAUNCH_SCREEN',array(
					'TITLE'=>lorem_title(),
					'TEXT'=>lorem_sentence(),
					'RESULTS'=>lorem_phrase(),
					'FORM'=>placeholder_form_with_field('submit_button'),
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
	function tpl_preview__administrative__restore_wrap()
	{
		return array(
			lorem_globalise(
				do_lorem_template('RESTORE_WRAP',array(
					'MESSAGE'=>lorem_sentence_html(),
					'CSS_NOCACHE'=>'',
					'SUCCESS'=>'1',
						)
			),NULL,'',true),
		);
	}

}