<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 */

class Block_side_google_search
{
	/**
	 * Standard modular info function.
	 *
	 * @return ?array	Map of module info (NULL: module is disabled).
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
		$info['parameters']=array('user_search_id','page_id');
		return $info;
	}

	/**
	 * Standard modular cache function.
	 *
	 * @return ?array	Map of cache details (cache_on and ttl) (NULL: module is disabled).
	 */
	function cacheing_environment()
	{
		$info=array();
		$info['cache_on']='array(array_key_exists(\'user_search_id\',$map)?$map[\'user_search_id\']:\'\',array_key_exists(\'page_id\',$map)?$map[\'page_id\']:\'google_search\')';
		$info['ttl']=15;
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
		require_lang('google_search');

		$user_search_id=!empty($map['user_search_id'])?$map['user_search_id']:'';
		$page_id=!empty($map['page_id'])?$map['page_id']:'google_search';


		$out = new ocp_tempcode();

		return do_template('BLOCK_SIDE_GOOGLE_SEARCH',array('TITLE'=>do_lang_tempcode('BLOCK_GOOGLE_TITLE'),'CONTENT'=>$out,'USER_SEARCH_ID'=>$user_search_id,'PAGE_ID'=>$page_id));
	}

}


