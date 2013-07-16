<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2013

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 */

class Block_main_unslider
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
		$info['version']=1;
		$info['locked']=false;
		$info['parameters']=array('pages','width','height','buttons','delay','speed','keypresses');
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
		$info['cache_on']='array($map)';
		$info['ttl']=1000; /* Page include is going to happen within Tempcode, so caching won't affect that */
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
		require_lang('unslider');
		require_css('unslider');

		$pages=explode(',',isset($map['pages'])?$map['pages']:'slide1,slide2,slide3,slide4');
		$width=isset($map['width'])?$map['width']:'100%';
		$height=isset($map['height'])?$map['height']:'350px';
		if (is_numeric($width)) $width.='px';
		if (is_numeric($height)) $height.='px';
		$buttons=((isset($map['buttons'])?$map['buttons']:'1')=='1');
		$delay=strval(intval(isset($map['delay'])?$map['delay']:'3000'));
		$speed=strval(intval(isset($map['speed'])?$map['speed']:'500'));
		$keypresses=((isset($map['keypresses'])?$map['keypresses']:'0')=='1');

		return do_template('BLOCK_MAIN_UNSLIDER',array(
			'PAGES'=>$pages,
			'WIDTH'=>$width,
			'HEIGHT'=>$height,
			'FLUID'=>(substr($width,-1)=='%'),
			'BUTTONS'=>$buttons,
			'DELAY'=>$delay,
			'SPEED'=>$speed,
			'KEYPRESSES'=>$keypresses,
		));
	}

}
