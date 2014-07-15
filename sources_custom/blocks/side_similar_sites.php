<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 */

class Block_side_similar_sites
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
		$info['parameters']=array('criteria','max');
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
		$info['cache_on']='array(array_key_exists(\'criteria\',$map)?$map[\'criteria\']:\'\',array_key_exists(\'max\',$map)?$map[\'max\']:3)';
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
		require_lang('similar_sites');

		$criteria=array_key_exists('criteria',$map)?$map['criteria']:get_option('site_scope');
		$max=(isset($map['max']) && intval($map['max'])>0)?intval($map['max']):3;

		$setSearchTerms="";
		$setSearchURL="related:".$criteria;

		$searchResultsArray=$this->retrieveGoogleSearch($setSearchTerms,$setSearchURL);

		$out='<ul>';
		$links_count=0;
		foreach($searchResultsArray as $result)
		{
			//more details in output - page content and short url - if we need more details, i.e. for the main block we could use this
			//$out .= '<li><strong><a href="'.$result["url"].'">'.$result["title"].'</a></strong> '.  $result["content"].' <em>'.$result["visibleUrl"].'</em></li>';
			$links_count++;
			if($links_count<=$max)
				$out .= '<li><a href="'.$result["url"].'" target="_blank">'.$result["title"].'</a></li>';
		}

		$out .= '</ul>';

		return do_template('BLOCK_SIDE_SIMILAR_SITES',array('TITLE'=>do_lang_tempcode('BLOCK_SIMILAR_SITES_TITLE'),'CONTENT'=>$out,'CRITERIA'=>$criteria));
	}

	function retrieveGoogleSearch($searchTerms="ocportal",$searchURL="related:ocportal.com")
	{
		require_code('files');
		$googleBaseUrl="http://ajax.googleapis.com/ajax/services/search/web";
		$googleBaseQuery="?v=1.0&rsz=large&q=";
		$googleFullUrl=$googleBaseUrl . $googleBaseQuery . $searchURL . "%20" . $searchTerms;

		$returnGoogleSearch=http_download_file($googleFullUrl);

		$returnGoogleSearch=json_decode($returnGoogleSearch,true);

		return $returnGoogleSearch["responseData"]["results"];
	}


}


