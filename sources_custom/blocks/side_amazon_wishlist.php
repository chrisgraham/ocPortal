<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 */

class Block_side_amazon_wishlist
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
		$info['parameters']=array('wishlist_id','access_key','secret_key','domain','title');
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
		$info['cache_on']='array(array_key_exists(\'wishlist_id\',$map)?$map[\'wishlist_id\']:\'\',array_key_exists(\'access_key\',$map)?$map[\'access_key\']:\'\',array_key_exists(\'secret_key\',$map)?$map[\'secret_key\']:\'\',array_key_exists(\'domain\',$map)?$map[\'domain\']:\'\',array_key_exists(\'title\',$map)?$map[\'title\']:\'\')';
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

		global $secret_key;
		$title=(isset($map['title']) && strlen($map['title'])>0)?$map['title']:do_lang_tempcode('BLOCK_AMAZON_WISHLIST_TITLE');
		if (!array_key_exists('wishlist_id',$map)) return do_lang_tempcode('NO_PARAMETER_SENT','wishlist_id');
		if (!array_key_exists('access_key',$map)) return do_lang_tempcode('NO_PARAMETER_SENT','access_key');
		if (!array_key_exists('secret_key',$map)) return do_lang_tempcode('NO_PARAMETER_SENT','secret_key');
		$wishlist_id=$map['wishlist_id'];//"2VAUC2FYIEUZ5";//"3U62ZPEQ2G0GO";
		$access_key=$map['access_key'];//"AKIAJXSQP4CES2F37GWQ";//"AKIAIZCU6XMIQYEDWU6A";
		$secret_key=$map['secret_key'];//"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";//"kzKVLbT9+GufjsGPwwprdxCeLfE6Zyl/o94msNKO";
		$domain=$map['domain'];//'com';//coulb be also 'co.uk'

		//$out=new ocp_tempcode();
		$out='';

		require_code('files');
		require_css('amazon_wishlist');

		$i=0;
		do
		{
			$i++;

			$url=$this->createSignature("http://webservices.amazon.".$domain."/onca/xml?AWSAccessKeyId=".$access_key."&ListId=".strval($wishlist_id)."&ListType=WishList&Operation=ListLookup&ProductPage=".$i."&ResponseGroup=Request,ListFull&Service=AWSECommerceService&Timestamp=".gmdate("Y-m-d\TH:i:s\Z")."&Version=2008-09-17");//2");

			$xml_url=http_download_file($url);
			$items=simplexml_load_string($xml_url);

			if (!empty($items->Lists->List->ListItem))
			{
				foreach ($items->Lists->List->ListItem as $item)
				{
					if ($item->QuantityReceived=="0")
					{
						$url=$this->createSignature("http://webservices.amazon.".$domain."/onca/xml?Service=AWSECommerceService&AWSAccessKeyId=".$access_key."&Operation=ItemLookup&IdType=ASIN&ItemId=".$item->Item->ASIN."&MerchantId=All&ResponseGroup=Medium&Timestamp=".gmdate("Y-m-d\TH:i:s\Z")."&Version=2007-07-16");//2");

						$xml_url=http_download_file($url);
						$itemDetails=simplexml_load_string($xml_url);

						$out.='<div class="amazon_wishlist"><img src="' . $itemDetails->Items->Item->SmallImage->URL . '" width="22"  /> <a href="' . $itemDetails->Items->Item->DetailPageURL . '" title="' . htmlspecialchars($item->Item->ItemAttributes->Title) . '">' . $item->Item->ItemAttributes->Title . '</a></div><br />';
					}
				}
			}
		}
		while($items->Lists->List->TotalPages>$i);


		return do_template('BLOCK_SIDE_AMAZON_WISHLIST',array('_GUID'=>'3c5da7ade6aca4c30a3842e00d686d90','TITLE'=>$title,'CONTENT'=>$out));
	}

	/**
	 * Function to create the signature for amazon web service.
	 *
	 * @param  SHORT_TEXT Amazon web service URL
	 * @param  LONG_TEXT additional url params
	 * @return SHORT_TEXT Amazon web service URL with signature
	 */
	function createSignature($url,$params='')
	{
		global $secret_key;
		$url_parts=parse_url($url);
		$query=array();
		parse_str($url_parts['query'],$query);
		uksort($query,"strcasecmp");
		foreach ($query as $key => $value)
		{
			$params .= $key."=".str_replace(array(":",","),array("%3A","%2C"),$value)."&";
		}
		$signature=base64_encode(hash_hmac('sha256',"GET\n".$url_parts['host']."\n".$url_parts['path']."\n".substr($params,0,-1),$secret_key,true));
		$return="http://".$url_parts['host'].$url_parts['path']."?".$params."Signature=".str_replace(array("+","="),array("%2B","%3D"),$signature);

		return $return;
	}

}


