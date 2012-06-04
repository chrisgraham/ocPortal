<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 */

class Block_main_ebay
{
	/**
	 * Standard modular info function.
	 *
	 * @return ?array	Map of module info (NULL: module is disabled).
	 */
	function info()
	{
		$info=array();
		$info['author']='Babu';
		$info['organisation']='ocProducts';
		$info['hacked_by']=NULL;
		$info['hack_version']=NULL;
		$info['version']=2;
		$info['locked']=false;
		$info['parameters']=array('type','seller','query','domain','lang');
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
		$info['cache_on']='array(array_key_exists(\'type\',$map)?$map[\'type\']:\'\',array_key_exists(\'seller\',$map)?$map[\'seller\']:\'\',array_key_exists(\'query\',$map)?$map[\'query\']:\'\',array_key_exists(\'lang\',$map)?$map[\'lang\']:\'\')';
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
		require_lang('ebay');

		if (!array_key_exists('seller',$map)) return do_lang_tempcode('NO_PARAMETER_SENT','seller');

		$height=(isset($map['height']) && intval($map['height'])>0)?$map['height']:'350';
		$width=(isset($map['width']) && intval($map['width'])>0)?$map['width']:'350';
		$domain=(isset($map['domain']) && $map['domain']!='')?$map['domain']:'com';
		$title=(isset($map['title']) && $map['title']!='')?$map['title']:do_lang_tempcode('BLOCK_EBAY_TITLE');
		$lang=(isset($map['lang']) && $map['lang']!='')?('&lang='.$map['lang']):'';


		$type = (isset($map['type']) && strlen($map['type'])>0)?$map['type']:'store';
		$seller = $map['seller'];//'yourrightchoice';//ecomelectronics
		$query = (isset($map['query']) && strlen($map['query'])>0)?preg_replace('#\s#','+',$map['query']):''; //i.e. Gadgets

		$out='';

		if($type == 'seller')
		{
			//ebay seller: yourrightchoice
			$out.='<object width="'.$width.'" height="'.$height.'"><param name="movie" value="http://togo.ebay.'.$domain.'/togo/seller.swf" /><param name="flashvars" value="base=http://togo.ebay.'.$domain.'/togo/'.$lang.'&seller='.$seller.'" /><embed src="http://togo.ebay.'.$domain.'/togo/seller.swf" type="application/x-shockwave-flash" width="'.$width.'" height="'.$height.'" flashvars="base=http://togo.ebay.'.$domain.'/togo/'.$lang.'&seller='.$seller.'"></embed></object>';
		}
		else
		{
			//e-bay store code using i.e. seller id = ecomelectronics :
			$out.='<object width="'.$width.'" height="'.$height.'"><param name="movie" value="http://togo.ebay.'.$domain.'/togo/store.swf" /><param name="flashvars" value="base=http://togo.ebay.'.$domain.'/togo/'.$lang.'&seller='.$seller.'&query='.$query.'" /><embed src="http://togo.ebay.'.$domain.'/togo/store.swf" type="application/x-shockwave-flash" width="'.$width.'" height="'.$height.'" flashvars="base=http://togo.ebay.'.$domain.'/togo/'.$lang.'&seller='.$seller.'&query='.$query.'"></embed></object>';
		}

		return do_template('BLOCK_MAIN_EBAY',array('TITLE'=>$title,'CONTENT'=>($out)));

	}
}


