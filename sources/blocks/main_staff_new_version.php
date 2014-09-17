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
 * @package		core_adminzone_dashboard
 */

class Block_main_staff_new_version
{
	/**
	 * Find details of the block.
	 *
	 * @return ?array	Map of block info (NULL: block is disabled).
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
		$info['parameters']=array();
		return $info;
	}

	/**
	 * Find cacheing details for the block.
	 *
	 * @return ?array	Map of cache details (cache_on and ttl) (NULL: block is disabled).
	 */
	function cacheing_environment()
	{
		$info=array();
		$info['cache_on']='array()';
		$info['ttl']=60*3;
		return $info;
	}

	/**
	 * Execute the block.
	 *
	 * @param  array		A map of parameters.
	 * @return tempcode	The result of execution.
	 */
	function run($map)
	{
		require_lang('version');
		require_code('version2');
		require_css('adminzone_dashboard');

		$table=get_future_version_information();

		require_code('addons2');
		$updated_addons=find_updated_addons();
		$has_updated_addons=(count($updated_addons)!=0);

		return do_template('BLOCK_MAIN_STAFF_NEW_VERSION',array('_GUID'=>'43c7b18d3d44e825247579df23a2ad9c','VERSION'=>ocp_version_pretty(),'VERSION_TABLE'=>$table,'HAS_UPDATED_ADDONS'=>$has_updated_addons));
	}
}


