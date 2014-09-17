<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 */

class Block_main_unslider
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
		$info['version']=1;
		$info['locked']=false;
		$info['parameters']=array('pages','width','height','buttons','delay','speed','keypresses','slider_id','bgcolor');
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
		$info['cache_on']='array($map)';
		$info['ttl']=1000; /* Page include is going to happen within Tempcode, so caching won't affect that */
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
		require_lang('unslider');
		require_css('unslider');

		$pages=explode(',',isset($map['pages'])?$map['pages']:'slide1,slide2,slide3,slide4,slide5,slide6');
		$width=isset($map['width'])?$map['width']:'100%';
		if ($width=='100%') $width='';
		$height=isset($map['height'])?$map['height']:'';
		if (is_numeric($width)) $width.='px';
		if (is_numeric($height)) $height.='px';
		$buttons=((isset($map['buttons'])?$map['buttons']:'1')=='1');
		$delay=strval(intval(isset($map['delay'])?$map['delay']:'3000'));
		if ($delay=='0') $delay='';
		$speed=strval(intval(isset($map['speed'])?$map['speed']:'500'));
		$keypresses=((isset($map['keypresses'])?$map['keypresses']:'0')=='1');
		$slider_id=isset($map['slider_id'])?$map['slider_id']:'unslider';

		$bgcolor=isset($map['bgcolor'])?str_replace('#','',$map['bgcolor']):'';
		$bgcolors=array();
		if (strpos($bgcolor,',')===false)
		{
			for ($i=0;$i<count($pages);$i++)
			{
				$bgcolors[$pages[$i]]=$bgcolor;
			}
		} else
		{
			$_bgcolors=explode(',',$bgcolor);
			for ($i=0;$i<count($pages);$i++)
			{
				$bgcolors[$pages[$i]]=isset($_bgcolors[$i])?$_bgcolors[$i]:'';
			}
		}

		return do_template('BLOCK_MAIN_UNSLIDER',array('_GUID'=>'ae60f714ef84227c0cb958b65f7a253c','PAGES'=>$pages,
			'WIDTH'=>$width,
			'HEIGHT'=>$height,
			'FLUID'=>(substr($width,-1)=='%'),
			'BUTTONS'=>$buttons,
			'DELAY'=>$delay,
			'SPEED'=>$speed,
			'KEYPRESSES'=>$keypresses,
			'SLIDER_ID'=>$slider_id,
			'BGCOLORS'=>$bgcolors,
		));
	}
}
