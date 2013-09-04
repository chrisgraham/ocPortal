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

/**
 * Standard code module initialisation function.
 */
function init__media_renderer()
{
	define('MEDIA_RECOG_PRECEDENCE_SUPER',15);
	define('MEDIA_RECOG_PRECEDENCE_HIGH',10);
	define('MEDIA_RECOG_PRECEDENCE_MEDIUM',5);
	define('MEDIA_RECOG_PRECEDENCE_LOW',1);
	define('MEDIA_RECOG_PRECEDENCE_NONE',0);

	define('MEDIA_TYPE_IMAGE',1);
	define('MEDIA_TYPE_VIDEO',2);
	define('MEDIA_TYPE_AUDIO',4);
	define('MEDIA_TYPE_OTHER',8);
}

/**
 * Find a media renderer hook for a URL.
 *
 * @param  URLPATH		The URL
 * @param  boolean		Whether there are admin privileges, to render dangerous media types
 * @param  integer		Bitmask of media that we will support
 * @param  ?ID_TEXT		Limit to a media rendering hook (NULL: no limit)
 * @return ?array			The hooks (NULL: cannot find one)
 */
function find_media_renderers($url,$as_admin,$acceptable_media,$limit_to=NULL)
{
	$hooks=array_keys(find_all_hooks('systems','media_rendering'));
	$obs=array();
	foreach ($hooks as $hook)
	{
		if (($limit_to!==NULL) && ($limit_to!=$hook)) continue;

		require_code('systems/media_rendering/'.$hook);
		$obs[$hook]=object_factory('Hook_media_rendering_'.$hook);
	}

	$found=array();
	$matches=array();
	if (preg_match('#\.(\w+)$#',$url,$matches)!=0)
	{
		// Find via extension
		require_code('mime_types');
		$mime_type=get_mime_type($matches[1],$as_admin);
		if ($mime_type!='application/octet-stream')
		{
			foreach ($hooks as $hook)
			{
				if ((method_exists($obs[$hook],'recognises_mime_type')) && (($acceptable_media & $obs[$hook]->get_media_type()) != 0))
				{
					$result=$obs[$hook]->recognises_mime_type($mime_type);
					if ($result!=0)
						$found[$hook]=$result;
				}
			}
		}
	}

	// Find via URL recognition
	foreach ($hooks as $hook)
	{
		if ((method_exists($obs[$hook],'recognises_url')) && (($acceptable_media & $obs[$hook]->get_media_type()) != 0))
		{
			$result=$obs[$hook]->recognises_url($url);
			if ($result!=0)
				$found[$hook]=$result;
		}
	}
	if (count($found)!=0)
	{
		arsort($found);
		return $found;
	}

	// Find via download (oEmbed / mime-type) - last resort, as it is more 'costly' to do
	$media_signature=get_url_media_signature($url);
	if ($media_signature!==NULL)
	{
		$mime_type=$media_signature['m_mime_type'];
		foreach ($hooks as $hook)
		{
			if ((method_exists($obs[$hook],'recognises_mime_type')) && (($acceptable_media & $obs[$hook]->get_media_type()) != 0))
			{
				$result=$obs[$hook]->recognises_mime_type($mime_type,$media_signature);
				if ($result!=0)
					$found[$hook]=$result;
			}
		}
		if (count($found)!=0)
		{
			arsort($found);
			return $found;
		}
	}

	return NULL;
}

/**
 * Get the media signature of a URL.
 *
 * @param  URLPATH		The URL
 * @return ?array			A map of collected signature details (NULL: none)
 */
function get_url_media_signature($url)
{
	// Check cache
	$url_media_signatures=$GLOBALS['SITE_DB']->query_select('url_media_signatures',array('*'),array('m_url'=>$url),'',1);
	if (array_key_exists(0,$url_media_signatures)) return $url_media_signatures[0];

	// Lookup
	$data=http_download_file($url,4096,false);
	if ($data!==NULL)
	{
		global $HTTP_DOWNLOAD_MIME_TYPE;

		$json_discovery='';
		$xml_discovery='';

		$matches=array();
		$num_matches=preg_match_all('#<link\s+[^<>]*>#i',$data,$matches);
		for ($i=0;$i<$num_matches;$i+)
		{
			$line=$matches[0][$i];
			$matches2=array();
			if ((preg_match('#\srel=["\']?alternate["\']?#i',$line)!=0) && (preg_match('#\shref=["\']?([^"\']+)["\']?#i',$line,$matches2)!=0))
			{
				if (preg_match('#\stype=["\']?application/json+oembed["\']?#i',$line)!=0)
				{
					$json_discovery=$matches[1];;
				}
				if (preg_match('#\stype=["\']?application/xml+oembed["\']?#i',$line)!=0)
				{
					$xml_discovery=$matches[1];;
				}
			}
		}

		// Save in cache
		$map=array(
			'm_url'=>$url,
			'm_mime_type'=>$HTTP_DOWNLOAD_MIME_TYPE,
			'm_json_discovery'=>$json_discovery,
			'm_xml_discovery'=>$xml_discovery,
		);
		$GLOBALS['SITE_DB']->query_insert('url_media_signatures',$map);

		return $map;
	}

	return NULL;
}

/**
 * Render a media URL in the best way we can.
 *
 * @param  URLPATH		The URL
 * @param  array			Attributes (e.g. width, height, length)
 * @param  boolean		Whether there are admin privileges, to render dangerous media types
 * @param  integer		Bitmask of media that we will support
 * @param  ?ID_TEXT		Limit to a media rendering hook (NULL: no limit)
 * @return ?tempcode		The rendered version (NULL: cannot render)
 */
function render_media_url($url,$attributes,$as_admin=false,$acceptable_media=15,$limit_to=NULL)
{
	$hooks=find_media_renderers($url,$as_admin,$acceptable_media,$limit_to=NULL);
	if (is_null($hooks)) return NULL;
	$hook=reset($hooks);
	$ob=object_factory('Hook_media_rendering_'.$hook);
	return $ob->render($url,$attributes);
}
