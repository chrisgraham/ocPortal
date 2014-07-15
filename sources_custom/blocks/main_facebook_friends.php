<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 */

class Block_main_facebook_friends
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
		$info['parameters']=array('stream','fans','logobar','show_fanpage_link','fanpage_name');
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
		$info['cache_on']='array(array_key_exists(\'logobar\',$map)?$map[\'logobar\']:0,array_key_exists(\'stream\',$map)?$map[\'stream\']:0,array_key_exists(\'fans\',$map)?$map[\'fans\']:10,array_key_exists(\'show_fanpage_link\',$map)?$map[\'show_fanpage_link\']:1,array_key_exists(\'fanpage_name\',$map)?$map[\'fanpage_name\']:\'\')';
		$info['ttl']=60*5;
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
		require_lang('facebook_friends');
		require_code('facebook_connect');

		$appid=get_option('facebook_appid',true);
		if ((is_null($appid)) || ($appid=='')) return new ocp_tempcode();

		$stream=array_key_exists('stream',$map)?$map['stream']:'0';
		$fans=array_key_exists('fans',$map)?$map['fans']:'10';
		$logobar=array_key_exists('logobar',$map)?$map['logobar']:'0';

		$show_fanpage_link=array_key_exists('show_fanpage_link',$map)?$map['show_fanpage_link']:'0';
		$fanpage_name=(isset($map['fanpage_name']) && strlen($map['fanpage_name'])>0)?$map['fanpage_name']:get_site_name();

		$out=new ocp_tempcode();

		return do_template('BLOCK_MAIN_FACEBOOK_FRIENDS',array('TITLE'=>do_lang_tempcode('BLOCK_FACEBOOK_FRIENDS_TITLE'),'CONTENT'=>$out,'FANPAGE_NAME'=>$fanpage_name,'SHOW_FANPAGE_LINK'=>$show_fanpage_link,'LOGOBAR'=>$logobar,'FANS'=>$fans,'STREAM'=>$stream));
	}

}


