<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		random_quotes
 */

class Block_main_ocprocks
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
		$info['parameters']=array('param');
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
		$info['cache_on']='array(has_actual_page_access(get_member(),\'quotes\',\'adminzone\'),array_key_exists(\'param\',$map)?$map[\'param\']:\'ocprocks\')';
		$info['ttl']=5;
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
		$file=array_key_exists('param',$map)?$map['param']:'ocprocks';

		require_css('random_quotes');

		require_code('textfiles');
		require_lang('ocprocks');

		$place=_find_text_file_path($file,'');

		if (!file_exists($place)) warn_exit(do_lang_tempcode('DIRECTORY_NOT_FOUND',escape_html($place)));
		$edit_url=new ocp_tempcode();

		return do_template('BLOCK_MAIN_OCPROCKS',array('_GUID'=>'7ac5b9318cde812966dae9a8cca5daf1','FILE'=>$file,'CONTENT'=>apply_emoticons($this->get_random_line($place))));
	}

	/**
	 * Get a random line from a file.
	 *
	 * @param  PATH			The filename
	 * @return string			The random line
	 */
	function get_random_line($filename)
	{
		$myfile=@fopen(filter_naughty($filename,true),'rt');
		if ($myfile===false) return '';
		$i=0;
		$line=array();
		while (true)
		{
			$line[$i]=fgets($myfile,1024);
			if (($line[$i]===false) || (is_null($line[$i]))) break;
			$i++;
		}
		$r=mt_rand(0,$i-1);
		fclose($myfile);
		return trim($line[$r]);
	}

}


