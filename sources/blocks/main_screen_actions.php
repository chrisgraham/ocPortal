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
 * @package		recommend
 */

class Block_main_screen_actions
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
		$info['parameters']=array('title','url');
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
		require_css('screen_actions');

		require_lang('recommend');

		$from=isset($map['url'])?$map['url']:'';
		if ($from=='')
			$from=get_self_url(true);

		$_map=array('page'=>'recommend','from'=>$from);
		if (array_key_exists('title',$map)) $_map['title']=$map['title'];
		$recommend_url=build_url($_map,'_SEARCH');

		return do_template('BLOCK_MAIN_SCREEN_ACTIONS',array(
			'_GUID'=>'2f5ceee4e1cc3d31c184c62e0710b1c3',
			'PRINT_URL'=>get_self_url(true,false,array('wide_print'=>1)),
			'RECOMMEND_URL'=>$recommend_url,
			'EASY_SELF_URL'=>str_replace("'",'',urlencode(get_self_url(true))),
			'TITLE'=>array_key_exists('title',$map)?$map['title']:'',
		));
	}

}


