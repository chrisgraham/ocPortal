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
 * @package		custom_comcode
 */

class Hook_Preview_custom_comcode
{

	/**
	 * Find whether this preview hook applies.
	 *
	 * @return array			Triplet: Whether it applies, the attachment ID type, whether the forum DB is used [optional]
	 */
	function applies()
	{
		$applies=get_param('page','')=='admin_custom_comcode';
		return array($applies,NULL,false);
	}

	/**
	 * Standard modular run function for preview hooks.
	 *
	 * @return array			A pair: The preview, the updated post Comcode
	 */
	function run()
	{
		require_code('comcode_compiler');

		$tag=post_param('tag');

		$replace=post_param('replace');
		$parameters=explode(',',post_param('parameters'));
		$example=post_param('example');
		$content=do_lang_tempcode('EXAMPLE');
		$matches=array();
		if (preg_match('#\](.*)\[#',$example,$matches)!=0)
		{
			$content=make_string_tempcode($matches[1]);
		}
		$binding=array('CONTENT'=>$content);
		foreach ($parameters as $parameter)
		{
			$parameter=trim($parameter);
			$parts=explode('=',$parameter);
			if (count($parts)==1) $parts[]='';
			if (count($parts)!=2) continue;
			list($parameter,$default)=$parts;
			$binding[strtoupper($parameter)]=$default;
			$replace=str_replace('{'.$parameter.'}','{'.strtoupper($parameter).'*}',$replace);
		}
		require_code('tempcode_compiler');
		$replace=str_replace('{content}',array_key_exists($tag,$GLOBALS['TEXTUAL_TAGS'])?'{CONTENT}':'{CONTENT*}',$replace);
		$temp_tpl=template_to_tempcode($replace);
		$temp_tpl=$temp_tpl->bind($binding,'(custom comcode: '.$tag.')');

		return array($temp_tpl,NULL);
	}

}
