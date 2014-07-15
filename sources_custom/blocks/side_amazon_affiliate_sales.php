<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 */

class Block_side_amazon_affiliate_sales
{
	/**
	 * Standard modular info function.
	 *
	 * @return ?array	Map of module info (NULL: module is disabled).
	 */
	function info()
	{
		$info=array();
		$info['author']='Kamen Blaginov';
		$info['organisation']='ocProducts';
		$info['hacked_by']=NULL;
		$info['hack_version']=NULL;
		$info['version']=2;
		$info['locked']=false;
		$info['parameters']=array('associates_id','product_line','subject_keywords','items_number');
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
		$info['cache_on']='array(array_key_exists(\'associates_id\',$map)?$map[\'associates_id\']:\'\',array_key_exists(\'product_line\',$map)?$map[\'product_line\']:\'\',array_key_exists(\'subject_keywords\',$map)?$map[\'subject_keywords\']:\'\',array_key_exists(\'items_number\',$map)?$map[\'items_number\']:\'\')';
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
		require_lang('amazon');

		if (!array_key_exists('associates_id',$map)) return do_lang_tempcode('NO_PARAMETER_SENT','associates_id');
		if (!array_key_exists('product_line',$map)) return do_lang_tempcode('NO_PARAMETER_SENT','product_line');
		if (!array_key_exists('subject_keywords',$map)) return do_lang_tempcode('NO_PARAMETER_SENT','subject_keywords');
		if (!array_key_exists('items_number',$map)) return do_lang_tempcode('NO_PARAMETER_SENT','items_number');

		$associates_id=$map['associates_id'];//'we4u-20';//
		$product_line=$map['product_line'];
		$subject_keywords=preg_replace('#\s#','+',$map['subject_keywords']);
		$n=(isset($map['items_number']) && intval($map['items_number'])>0)?$map['items_number']:3;

		$out='';

		for($i=0; $i<$n; $i++)
			$out.='<iframe src="http://rcm.amazon.com/e/cm?lt1=_blank&t='.escape_html($associates_id).'&o=1&p=8&l=st1&mode='.escape_html($product_line).'&search='.$subject_keywords.'&t1=_blank&lc1=00FFFF&bg1=FFFFFF&f=ifr" marginwidth="0" marginheight="0" width="120px" height="240" border="0" frameborder="0" style="width: 120px; border:none;" scrolling="no"></iframe><br /><br />';

		return do_template('BLOCK_SIDE_AMAZON_AFFILIATES',array('TITLE'=>do_lang_tempcode('BLOCK_AMAZON_AFFILIATE_SALES_TITLE'),'CONTENT'=>$out,'ASSOCIATES_ID'=>$associates_id,'PRODUCT_LINE'=>$product_line,'SUBJECT_KEYWORDS'=>$subject_keywords));

	}
}


