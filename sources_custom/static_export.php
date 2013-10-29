<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		static_export
 */

/**
 * Callback for saving a page-link into static output.
 *
 * @param  string		The page-link.
 * @param  string		The parent page-link in the ocPortal sitemap.
 * @param  ?TIME		When the node was added (NULL: unknown).
 * @param  ?TIME 		When the node was last edited (NULL: unknown/never).
 * @param  float		The priority of this for spidering, 0.0-1.0.
 * @param  string		The title of the node.
 * @param  boolean	Whether the category is accessible by the user the sitemap is being generated for (Guest for a Sitemaps XML file).
 */
function _pagelink_to_static($pagelink,$parent_pagelink,$add_date,$edit_date,$priority,$title,$accessible=true)
{
	if (($accessible) && (strpos($pagelink,':static_export')===false))
	{
		global $STATIC_EXPORT_TAR,$STATIC_EXPORT_WARNINGS;

		$only_pagelinks=get_param('only_pagelinks',NULL);
		if (!is_null($only_pagelinks))
		{
			if (!in_array($pagelink,explode(',',$only_pagelinks))) return;
		}

		$date=time();
		if (get_param_integer('dir',0)==0) // For dir export we actually use times to represent overall change times, to benefit upload
		{
			if (get_param_integer('guess_dates',0)==1) // Bad idea actually, aggregate data can easily make the dates wrong
			{
				if (!is_null($add_date)) $date=$add_date;
				if (!is_null($edit_date)) $date=$edit_date;
			}
		}

		$langs=find_all_langs();
		foreach (array_keys($langs) as $lang)
		{
			if (($lang!=fallback_lang()) && (count(get_directory_contents(get_custom_file_base().'/lang_custom/'.$lang,'',true,false,true))<5)) continue; // Probably this is just the utf8 addon

			$url_test=static_evaluate_tempcode(symbol_tempcode('PAGE_LINK',array($pagelink,'0','1')));
			if (strpos($url_test,'?')!==false) continue;

			$extended_pagelink=$pagelink;
			if ($pagelink=='') $extended_pagelink=':'.get_zone_default_page('');
			if (count($langs)!=1)
				$extended_pagelink.=':keep_lang='.$lang.':max=10000';
			$url=static_evaluate_tempcode(symbol_tempcode('PAGE_LINK',array($extended_pagelink,'0','1')));

			$target_path=urldecode(preg_replace('#\?.*$#','',preg_replace('#^'.preg_quote(get_base_url(),'#').'/#','',$url)));

			$save_target_path=(count($langs)==1)?$target_path:($lang.'/'.$target_path);

			$directory=$STATIC_EXPORT_TAR['directory'];
			foreach ($directory as $entry) // Make sure it does not exist, due to some kind of dynamic parameter being folded out
			{
				if ($entry['path']==$save_target_path)
				{
					continue;
				}
			}

			$session_cookie_id=get_session_cookie();
			$data=http_download_file($url,NULL,false,false,'ocPortal',NULL,array($session_cookie_id=>12345));
			if (is_null($data)) continue;

			if (get_param_integer('save__deps',1)==1)
			{
				$data=preg_replace_callback('#"([^"]*/(attachment|dload)\.php\?id=(\d+)[^"]*)"#','_static_export_scriptrep_callback',$data);
				$data=preg_replace_callback('#"([^"]*/(catalogue_file)\.php\?file=([^"&]+)&amp;original_filename=([^"&]+)[^"]*)"#','_static_export_scriptrep_callback',$data);
			}

			// Redirect forms to mailer
			if (strpos($data,'<form')!==false)
			{
				$STATIC_EXPORT_WARNINGS[]='Form(s) on '.$pagelink.' redirected to mailer.php if POST, else left alone if GET. Check this is correct! If it is a sort form you might want to remove that from the templates and re-export.';

				$new_form_action=escape_html(get_base_url().((count($langs)>1)?('/'.$lang):'').'/mailer.php');
				$data=preg_replace('#(\s)action="[^"]*"([^>]*\smethod="post")#','${1}action="'.$new_form_action.'"${2}',$data);
				$data=preg_replace('#(\smethod="post"[^>]*)(\s)action="[^"]*"#','${1}action="'.$new_form_action.'"${2}',$data);

				// Set a JS session cookie for a very basic anti-spam system
				$data=str_replace('</head>','<script>document.cookie="js_on=1";</script></head>',$data);
			}

			// Change absolute paths to relative ones
			$path_bits=explode('/',$target_path);
			array_pop($path_bits);
			$relative_root='';
			foreach ($path_bits as $path_bit)
			{
				$relative_root.='../';
			}
			$data=static_remove_dynamic_references($data,$relative_root);

			// Potential warnings
			if (strpos($data,'javascript_ajax')!==false)
			{
				$STATIC_EXPORT_WARNINGS[]='AJAX being included on '.$pagelink.', likely it doesn\'t work!';
			}

			tar_add_file($STATIC_EXPORT_TAR,$save_target_path,$data,0644,$date,false);
		}
	}
}

/**
 * Cleanup some HTML for static use.
 *
 * @param  string		The dirty HTML.
 * @param  string		Root to replace base URL with.
 * @param  string		Cleaned up HTML.
 */
function static_remove_dynamic_references($data,$relative_root='')
{
	$data=str_replace(get_base_url().'/',$relative_root,$data);
	$data=preg_replace('#<base\s[^>]*href="[^"]*"[^>]*>#','',$data);
	$data=preg_replace('#<link rel="baseurl" href="[^"]*" />#','',$data);

	// Remove any references to other ocPortal PHP scripts (e.g. RSS script) or callbacks with dynamic parameters
	$data=preg_replace('#<meta\s[^>]*content="[^"]*\.php[^"]*"[^>]*>\s*#','',$data);
	$data=preg_replace('#<link\s[^>]*href="[^"]*\.php[^"]*"[^>]*>\s*#','',$data);
	$data=preg_replace('#<li><a href="[^"]*keep_mobile=1">.*</a></li>#U','',$data);
	$data=preg_replace('#<noscript><a href="[^"]*keep_has_js=0">.*</a></noscript>#U','',$data);
	$data=preg_replace('#<li><a href="[^"]*login[^"]*">.*</a></li>#U','',$data);
	$data=preg_replace('#\?redirect=[^&"]*&amp;#','?',$data);
	$data=preg_replace('#\?redirect=[^&"]*#','',$data);
	$data=preg_replace('#&amp;redirect=[^&"]*#','',$data);
	$data=preg_replace('#<link rel="canonical" href="[^"]*" />#','',$data);
	$data=str_replace('&amp;max=10000','',$data);
	$data=str_replace('max=10000&amp;','',$data);

	return $data;
}

/**
 * Callback for replacing dynamic script links with static ones.
 *
 * @param  array		The matches.
 * @param  string		Replaced string.
 */
function _static_export_scriptrep_callback($matches)
{
	global $STATIC_EXPORT_TAR;

	$new_url=$matches[1];

	switch ($matches[2])
	{
		case 'attachment':
			$id=intval($matches[3]);

			$thumb=(strpos($matches[1],'thumb=1')!==false);

			$field='a_url';
			if ($thumb) $field='a_thumb_url';
			$attachment=$GLOBALS['SITE_DB']->query_select('attachments',array('id',$field,'a_original_filename'),array('id'=>$id),'',1);

			if (url_is_local($attachment[0][$field]))
			{
				$prefix=($thumb?'thumbnail__':'').$attachment[0]['id'].'__';

				$attachment[0]['a_original_filename']=_static_export_make_ascii($attachment[0]['a_original_filename']);

				$new_url=get_base_url().'/media/'.$prefix.$attachment[0]['a_original_filename'];

				if (get_param_integer('save__deps_files',1)==1)
				{
					$full_path=get_custom_file_base().'/'.urldecode($attachment[0][$field]);
					tar_add_file($STATIC_EXPORT_TAR,'media/'.$prefix.$attachment[0]['a_original_filename'],$full_path,0644,filemtime($full_path),true,true);
				}
			} else
			{
				$new_url=$attachment[0][$field];
			}

			break;

		case 'catalogue_file':
			$file=urldecode($matches[3]);
			$original_filename=_static_export_make_ascii(urldecode($matches[4]));

			$new_url=get_base_url().'/catalogue_files/'.md5($file).'__'.$original_filename;

			if (get_param_integer('save__deps_files',1)==1)
			{
				$full_path=get_custom_file_base().'/uploads/catalogues/'.$file;
				tar_add_file($STATIC_EXPORT_TAR,'catalogue_files/'.md5($file).'__'.$original_filename,$full_path,0644,filemtime($full_path),true,true);
			}

			break;

		case 'dload':
			$id=intval($matches[3]);

			$field='a_url';
			$download=$GLOBALS['SITE_DB']->query_select('download_downloads',array('id','url','original_filename'),array('id'=>$id),'',1);

			if (url_is_local($download[0]['url']))
			{
				$download[0]['original_filename']=_static_export_make_ascii($download[0]['original_filename']);

				$new_url=get_base_url().'/files/'.$download[0]['id'].'__'.$download[0]['original_filename'];

				if (get_param_integer('save__deps_files',1)==1)
				{
					$full_path=get_custom_file_base().'/'.urldecode($download[0][$field]);
					tar_add_file($STATIC_EXPORT_TAR,'files/'.$download[0]['id'].'__'.$download[0]['original_filename'],$full_path,0644,filemtime($full_path),true,true);
				}
			} else
			{
				$new_url=$download[0]['url'];
			}

			break;
	}
	return '"'.$new_url.'"';
}

/**
 * Make a filename ASCII, for archive/cross-platform portability.
 *
 * @param  array		The filename.
 * @return string		The ASCII version.
 */
function _static_export_make_ascii($filename)
{
	for ($i=0;$i<strlen($filename);$i++)
	{
		if ((ord($filename[$i])<32) || (ord($filename[$i])>127))
			$filename[$i]='_';
	}

	return $filename;
}
