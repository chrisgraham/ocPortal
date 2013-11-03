<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		oc_bank
 */

class Hook_addon_registry_oc_bank
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
		return 'Kamen Blaginov';
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
		return 'Members can deposit some of their hard earned points (but not the gift points) into a \"bank account\" and extract them again only after a month. The administrator can set the interest rate, that users will get with their points back at the end of the account term. To set the Interest rate go to Admin Zone > Setup > Manage point-store inventory and click \"edit your point-store configuration\" and change the interest rate to the level you would like. To deposit points go to the point store and click on the bank option and choose how much you would like to deposit for a month. The interest paid out will be at the level it was at when the points were deposited.';
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
				'Cron',
				'pointstore',
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
			'sources_custom/hooks/systems/addon_registry/oc_bank.php',
			'sources_custom/hooks/modules/pointstore/bank.php',
			'lang_custom/EN/bank.ini',
			'sources_custom/hooks/systems/cron/bank.php',
			'themes/default/templates_custom/POINTSTORE_BANK.tpl',
			'sources_custom/hooks/systems/config/bank_dividend.php',
		);
	}

	/**
	 * Standard modular uninstall function.
	 */
	function uninstall()
	{
		$GLOBALS['SITE_DB']->drop_table_if_exists('bank');
	}

	/**
	 * Standard modular install function.
	 *
	 * @param  ?integer	What version we're upgrading from (NULL: new install)
	 */
	function install($upgrade_from=NULL)
	{
		if (is_null($upgrade_from))
		{
			$GLOBALS['SITE_DB']->create_table('bank',array(
				'id'=>'*AUTO',
				'member_id'=>'MEMBER',
				'amount'=>'INTEGER',
				'dividend'=>'INTEGER',
				'add_time'=>'?TIME',
			));
		}
	}
}