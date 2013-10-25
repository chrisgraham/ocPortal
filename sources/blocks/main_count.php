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
 * @package		counting_blocks
 */

class Block_main_count
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
		$info['parameters']=array('param','start','hit_count');
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
		require_css('counting_blocks');

		// The counter we're using
		$name=array_key_exists('param',$map)?$map['param']:'';
		if ($name=='') $name=get_page_name().':'.get_param('type','misc').':'.get_param('id','');

		$start=array_key_exists('start',$map)?intval($map['start']):0;

		// Set it if it's not already
		$_current_value=get_value($name);
		if (is_null($_current_value))
		{
			set_value($name,strval($start));
			$current_value=$start;
		} else
		{
			$current_value=intval($_current_value);
			if ($start>$current_value)
			{
				$current_value=$start;
				set_value($name,strval($current_value));
			}
		}

		// Hit counter?
		$hit_count=array_key_exists('hit_count',$map)?intval($map['hit_count']):1;
		$update=mixed();
		if ($hit_count==1)
		{
			//update_stat($name,1);	Actually, use AJAX
			$update=$name;
		}

		return do_template('BLOCK_MAIN_COUNT',array('_GUID'=>'49d3ba8fb5b5544ac817f9a7d18f9d35','NAME'=>$name,'UPDATE'=>$update,'VALUE'=>strval($current_value+1)));
	}

}


