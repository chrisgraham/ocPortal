<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		ocportalcom
 */

/**
 * Module page class.
 */
class Module_admin_sites
{

	/**
	 * Standard modular info function.
	 *
	 * @return ?array	 Map of module info (NULL: module is disabled).
	 */
	function info()
	{
		$info=array();
		$info['author']='Chris Graham';
		$info['organisation']='ocProducts'; 
		$info['hacked_by']=NULL; 
		$info['hack_version']=NULL;
		$info['version']=2;
		$info['locked']=false;
		return $info;
	}

	/**
	 * Standard modular uninstall function.
	 */
	function uninstall()
	{
		$GLOBALS['SITE_DB']->drop_if_exists('sites');
		$GLOBALS['SITE_DB']->drop_if_exists('sites_email');
	}

	/**
	 * Standard modular install function.
	 *
	 * @param  ?integer	 What version we're upgrading from (NULL: new install)
	 * @param  ?integer	 What hack version we're upgrading from (NULL: new-install/not-upgrading-from-a-hacked-version)
	 */
	function install($upgrade_from=NULL,$upgrade_from_hack=NULL)
	{
		$GLOBALS['SITE_DB']->create_table('sites',array(
			's_codename'=>'*ID_TEXT',
			's_name'=>'SHORT_TEXT',
			's_description'=>'LONG_TEXT',
			's_category'=>'SHORT_TEXT', // Entertainment, Computers, Sport, Art, Music, Television/Movies, Businesses, Other, Informative/Factual, Political, Humour, Geographical/Regional, Games, Personal/Family, Hobbies, Culture/Community, Religeous, Health
			's_domain_name'=>'SHORT_TEXT',
			's_server'=>'IP',
			's_member_id'=>'USER',
			's_add_time'=>'TIME',
			's_last_backup_time'=>'?TIME',
			's_subscribed'=>'BINARY',
			's_show_in_directory'=>'BINARY',
			's_sponsored_in_category'=>'BINARY'
		));

		$GLOBALS['SITE_DB']->create_index('sites','#search',array('s_description','s_name','s_codename'));

		$GLOBALS['SITE_DB']->create_table('sites_email',array(
			's_codename'=>'*ID_TEXT',
			's_email_from'=>'ID_TEXT',
			's_email_to'=>'SHORT_TEXT',
		));
	}

	/**
	 * Standard modular entry-point finder function.
	 *
	 * @return ?array	 A map of entry points (type-code=>language-code) (NULL: disabled).
	 */
	function get_entry_points()
	{
		return array();
	}

	/**
	 * Standard modular run function.
	 *
	 * @return tempcode	 The result of execution.
	 */
	function run()
	{
		return new ocp_tempcode();
	}

}

