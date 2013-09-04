<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2013

 See text/EN/licence.txt for full licencing information.


 NOTE TO PROGRAMMERS:
   Do not edit this file. If you need to make changes, save your changed file to the appropriate *_custom folder
   **** If you ignore this advice, then your website upgrades (e.g. for bug fixes) will likely kill your changes ****

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		core_rich_media
 */

class Block_main_emoticon_codes
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
		$info['parameters']=array();
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
		$info['cache_on']='array(has_privilege(get_member(),\'use_special_emoticons\'))';
		$info['ttl']=(get_value('no_block_timeout')==='1')?60*60*24*365*5/*5 year timeout*/:60*2;
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
		require_code('comcode_compiler');

		$smilies=$GLOBALS['FORUM_DRIVER']->find_emoticons(get_member());

		$entries=new ocp_tempcode();
		global $EMOTICON_LEVELS;
		foreach ($smilies as $code=>$imgcode)
		{
			if ((is_null($EMOTICON_LEVELS)) || ($EMOTICON_LEVELS[$code]<3))
			{
				$entries->attach(do_template('BLOCK_MAIN_EMOTICON_CODES_ENTRY',array('_GUID'=>'9d723c17133313b327a9485aeb23aa8c','CODE'=>$code,'TPL'=>do_emoticon($imgcode))));
			}
		}

		return do_template('BLOCK_MAIN_EMOTICON_CODES',array('_GUID'=>'56c12281d7e3662b13a7ad7d9958a65c','ENTRIES'=>$entries));
	}

}


