<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 */

class Block_main_facebook_comments
{

	/**
	 * Standard modular info function.
	 *
	 * @return ?array	Map of module info (NULL: module is disabled).
	 */
	function info()
	{
		$info=array();
		$info['author']='Naveen';
		$info['organisation']='ocProducts';
		$info['hacked_by']=NULL;
		$info['hack_version']=NULL;
		$info['version']=2;
		$info['locked']=false;
		$info['parameters']=array();
		return $info;
	}

	/**
	 * Standard modular run function.
	 *
	 * @param  array		A map of parameters.
	 * @return tempcode	The result of execution.
	 */
	function run($map)
	{
		unset($map);

		require_code('facebook_connect');

		$appid=get_option('facebook_appid',true);
		if ((is_null($appid)) || ($appid=='')) return new ocp_tempcode();
		return do_template('BLOCK_MAIN_FACEBOOK_COMMENTS',array('_GUID'=>'99de0fd4bc8b3f57d4f9238b798bfcbf','URL'=>'http://developers.facebook.com/docs/reference/plugins/like-box'));
	}

}


