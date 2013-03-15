<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

disable_php_memory_limit();
if (function_exists('set_time_limit')) @set_time_limit(0);
$GLOBALS['NO_DB_SCOPE_CHECK']=true;

require_code('tar');
require_code('files');
require_code('files2');
require_code('config2');

if (!addon_installed('staff_messaging'))
{
	warn_exit('Staff Messaging addon must be installed.');
}

if ((get_option('htm_short_urls')!='1') || (get_option('mod_rewrite')!='1'))
{
	set_option('htm_short_urls','1');
	set_option('mod_rewrite','1');
	warn_exit('New-style short URLs must be enabled before te export can happen, as this is the tidy scheme we export to. It is now enabled - just refresh the browser.');
}

if (get_option('show_inline_stats')=='1')
{
	set_option('show_inline_stats','0');
	warn_exit('Inline stats must be disabled. It is now disabled - just refresh the browser.');
}

if (get_option('site_closed')=='1')
{
	set_option('site_closed','0');
	warn_exit('Site must not be closed. It is now open - just refresh the browser.');
}

if ((get_option('is_on_comments')=='1') || (get_option('is_on_trackbacks')=='1') || (get_option('is_on_rating')=='1'))
{
	set_option('is_on_comments','0');
	set_option('is_on_trackbacks','0');
	set_option('is_on_rating','0');
	warn_exit('Comments/trackbacks/rating must not be enabled. It is now all disabled - just refresh the browser.');
}

if (get_option('enable_previews')=='1')
{
	set_option('enable_previews','0');
	warn_exit('Previews must be disabled. It is now disabled - just refresh the browser.');
}

set_value('no_frames','1');

$filename='static-'.get_site_name().'.'.date('Y-m-d').'.tar';

if ((get_param_integer('do__headers',1)==1) && (get_param_integer('dir',0)==0))
{
	@ob_end_clean();
	@ob_end_clean();

	header('Content-Type: application/octet-stream'.'; authoritative=true;');
	if (strstr(ocp_srv('HTTP_USER_AGENT'),'MSIE')!==false)
		header('Content-Disposition: filename="'.str_replace(chr(13),'',str_replace(chr(10),'',addslashes($filename))).'"');
	else
		header('Content-Disposition: attachment; filename="'.str_replace(chr(13),'',str_replace(chr(10),'',addslashes($filename))).'"');
}

global $STATIC_EXPORT_TAR,$STATIC_EXPORT_WARNINGS;
$STATIC_EXPORT_WARNINGS=array();
if (get_forum_type()!='none') $STATIC_EXPORT_WARNINGS[]='Not on \'none\' forum driver, you may possibly still have some bundled login links etc to remove';
$tar_path=mixed();
if (get_param_integer('dir',0)==0)
{
	$tar_path=NULL;
} else
{
	$tar_path=ocp_tempnam('');
}
$STATIC_EXPORT_TAR=tar_open($tar_path,'wb');

$GLOBALS['NO_QUERY_LIMIT']=true;

// The content in the sitemap
require_code('sitemap');
require_code('static_export');
if (get_param_integer('save__pages',1)==1)
{
	spawn_page_crawl('_pagelink_to_static',$GLOBALS['FORUM_DRIVER']->get_guest_id(),NULL,DEPTH__ENTRIES);
}

// Other media
if (get_param_integer('save__uploads',1)==1)
{
	$subpaths=array();
	foreach (get_directory_contents(get_custom_file_base().'/uploads','',false,false,false) as $subpath)
	{
		if (($subpath!='downloads') && ($subpath!='attachments') && ($subpath!='attachments_thumbs'))
			$subpaths=array_merge($subpaths,array('uploads/'.$subpath));
	}
	$subpaths=array_merge($subpaths,array('themes/default/templates_cached','themes/default/images','themes/default/images_custom'));
	$theme=$GLOBALS['FORUM_DRIVER']->get_theme('');
	if ($theme!='default')
		$subpaths=array_merge($subpaths,array('themes/'.$theme.'/templates_cached','themes/'.$theme.'/images','themes/'.$theme.'/images_custom'));
	foreach ($subpaths as $subpath)
	{
		if (substr($subpath,-strlen('/templates_cached'))=='/templates_cached')
		{
			foreach (get_directory_contents(get_custom_file_base().'/'.$subpath,'') as $file)
			{
				if ((substr($file,-4)=='.css') || (substr($file,-3)=='.js'))
					tar_add_file($STATIC_EXPORT_TAR,$subpath.'/'.$file,get_custom_file_base().'/'.$subpath.'/'.$file,0644,time(),true);
			}
		} else
		{
			tar_add_folder($STATIC_EXPORT_TAR,NULL,get_file_base(),NULL,$subpath,NULL,NULL,false,false);
		}
	}
}

// .htaccess
$data='';
$data.='ErrorDocument 404 /sitemap.htm'.chr(10).chr(10);
$data.='RewriteEngine on'.chr(10);
$data.=chr(10);
$data.=chr(10);
$data.='RewriteRule ^$ start.htm [R,L]'.chr(10);
$data.=chr(10);
$data.=chr(10);
$directory=$STATIC_EXPORT_TAR['directory'];
$langs=find_all_langs();
$done_non_spec=array();
foreach ($directory as $entry) // Rewrite non-specific pages to 'misc' files
{
	$dir_name=preg_replace('#^[A-Z][A-Z]/#','',dirname($entry['path']));
	if (isset($done_non_spec[$dir_name])) continue;
	$done_non_spec[$dir_name]=1;
	if (($dir_name!='') && (basename($entry['path'])=='misc.htm'))
	{
		$data.='RewriteRule ^'.$dir_name.'\.htm(.*) '.$dir_name.'/misc.htm$1 [R,L]'.chr(10);

		// If .htaccess not supported let it redirect via simple stub file instead
		if (get_param_integer('save__redirects',1)==1)
		{
			$datax='<meta http-equiv="refresh" content="0;'.escape_html(basename($dir_name)).'/misc.htm" />';
			foreach (array_keys($langs) as $lang)
			{
				if (($lang!=fallback_lang()) && (count(get_directory_contents(get_custom_file_base().'/lang_custom/'.$lang,'',true,false,true))<5)) continue; // Probably this is just the utf8 addon

				tar_add_file($STATIC_EXPORT_TAR,((count($langs)!=1)?($lang.'/'):'').$dir_name.'.htm',$datax,0644,time(),false);
			}
		}
	}
}
$data.=chr(10);
$data.=chr(10);
if (count($langs)!=1) // Handling language detection
{
	// Recognise when language explicitly called
	foreach (array_keys($langs) as $lang)
	{
		if (($lang!=fallback_lang()) && (count(get_directory_contents(get_custom_file_base().'/lang_custom/'.$lang,'',true,false,true))<5)) continue; // Probably this is just the utf8 addon

		$data.='RewriteRule '.$lang.' - [L]'.chr(10); // This stops it looping; [L] ends an iteration for a directory level but doesn't stop inter-level recursions
		$data.='RewriteCond %{QUERY_STRING} keep_lang='.$lang.chr(10);
		$data.='RewriteRule (^.*\.htm.*$) '.$lang.'/$1 [L]'.chr(10);

		$data.=chr(10);
	}

	// Recognise when language supported by browser
	if (get_option('detect_lang_browser')=='1')
	{
		foreach (array_keys($langs) as $lang)
		{
			if (($lang!=fallback_lang()) && (count(get_directory_contents(get_custom_file_base().'/lang_custom/'.$lang,'',true,false,true))<5)) continue; // Probably this is just the utf8 addon

			$data.='RewriteCond %{HTTP:Accept-Language} (^'.strtolower($lang).') [NC]'.chr(10);
			$data.='RewriteRule (^.*\.htm.*$) '.$lang.'/$1 [L]'.chr(10);

			$data.=chr(10);
		}
	}

	// And default to English
	$data.=chr(10);
	$data.='RewriteRule (^.*\.htm.*$) EN/$1 [L]'.chr(10);

	$data.=chr(10);
}
if (get_param_integer('save__htaccess',1)==1)
{
	tar_add_file($STATIC_EXPORT_TAR,'.htaccess',$data,0644,time(),false);
}

require_code('mail');
require_lang('messaging');

// Mailer
$robots_data='';
foreach (array_keys($langs) as $lang)
{
if (($lang!=fallback_lang()) && (count(get_directory_contents(get_custom_file_base().'/lang_custom/'.$lang,'',true,false,true))<5)) continue; // Probably this is just the utf8 addon
$mailer_script='
<'.'?php
function post_param($key,$default)
{
	return isset($_POST[$key])?$_POST[$key]:$default;
}

function titleify($boring)
{
	return ucwords(str_replace("_"," ",$boring));
}

if (!isset($_COOKIE["js_on"])) exit("Error: cookies must be enabled, for anti-spam reasons.");

$title=post_param("title","'.do_lang('UNKNOWN').'");

$to="'.get_option('staff_address').'";

$email=post_param("email",$to);
$name=post_param("name","'.do_lang('UNKNOWN').'");

$post=post_param("post","");

$fields=array();
foreach (array_diff(array_keys($_POST),array("MAX_FILE_SIZE","perform_validation","_validated","posting_ref_id","f_face","f_colour","f_size","x","y","name","subject","email","to_members_email","to_written_name","redirect","http_referer")) as $key)
{
	$is_hidden=(strpos($key,"hour")!==false) || (strpos($key,"access_")!==false) || (strpos($key,"minute")!==false) || (strpos($key,"confirm")!==false) || (strpos($key,"pre_f_")!==false) || (strpos($key,"label_for__")!==false) || (strpos($key,"wysiwyg_version_of_")!==false) || (strpos($key,"is_wysiwyg")!==false) || (strpos($key,"require__")!==false) || (strpos($key,"tempcodecss__")!==false) || (strpos($key,"comcode__")!==false) || (strpos($key,"_parsed")!==false) || (substr($key,0,1)=="_") || (substr($key,0,9)=="hidFileID") || (substr($key,0,11)=="hidFileName");
	if ($is_hidden) continue;

	if (substr($key,0,1)!="_")
		$fields[$key]=post_param("label_for__".$key,titleify($key));
}
foreach ($fields as $field=>$field_title)
{
	$field_val=post_param($field,"");
	if ($field_val!="")
		$post.="\n\n".$field_title.": ".$field_val;
}

$subject=str_replace("xxx",$title,"'.addslashes(do_lang('CONTACT_US_NOTIFICATION_SUBJECT','xxx',NULL,NULL,$lang)).'");
$message=str_replace(array("aaa","bbb"),array($name,$post),"'.addslashes(comcode_to_clean_text(do_lang('CONTACT_US_NOTIFICATION_MESSAGE',get_site_name(),'aaa',array('bbb'),$lang))).'");
$headers="";
$website_email="'.addslashes(get_option('website_email')).'";
if ($website_email=="") $website_email=$email;
$headers.="From: \"".str_replace("\"","",$name)."\" <{$website_email}>\n";
$headers.="Reply-To: \"".str_replace("\"","",$name)."\" <{$email}>\n";
$random_hash=md5(date("r",time()));
$headers.="Content-type: multipart/mixed; boundary=\"PHP-mixed-{$random_hash}\"";
$mime_message="";
$mime_message.="--PHP-mixed-{$random_hash}\n";
$mime_message.="Content-Type: text/plain; charset=\"'.get_charset().'\"\n\n";
$mime_message.=$message."\n\n";
foreach ($_FILES as $f)
{
	$mime_message.="--PHP-mixed-{$random_hash}\n";
	$mime_message.="Content-Type: application/octet-stream; name=\"".addslashes($f["name"])."\"\n";
	$mime_message.="Content-Transfer-Encoding: base64\n";
	$mime_message.="Content-Disposition: attachment\n\n";
	$mime_message.=base64_encode(file_get_contents($f["tmp_name"]));
}
$mime_message.="--PHP-mixed-{$random_hash}--\n\n";
if (trim($post)!="")
{
	mail($to,$subject,$mime_message,$headers);
}
?'.'>

<p>'.do_lang('MESSAGE_SENT',NULL,NULL,NULL,$lang).'</p>
';
if (get_param_integer('save__mailer',1)==1)
{
	$mailer_path=get_custom_file_base().'/pages/html_custom/'.$lang.'/mailer_temp.htm';
	@mkdir(dirname($mailer_path),0777);
	file_put_contents($mailer_path,$mailer_script);
	$data=http_download_file(static_evaluate_tempcode(build_url(array('page'=>'mailer_temp','keep_lang'=>(count($langs)!=1)?$lang:NULL),'',NULL,false,false,true)),NULL,false,false,'ocPortal',NULL,array('ocp_session'=>12345));
	unlink($mailer_path);
	$data=preg_replace('#<title>.*</title>#','<title>'.escape_html(get_site_name()).'</title>',$data);
	$relative_root=(count($langs)!=1)?'../':'';
	tar_add_file($STATIC_EXPORT_TAR,((count($langs)!=1)?($lang.'/'):'').'mailer.php',static_remove_dynamic_references($data,$relative_root),0644,time(),false);

	$robots_data.='Deny /'.((count($langs)!=1)?($lang.'/'):'').'mailer.php'.chr(10);
}
}
tar_add_file($STATIC_EXPORT_TAR,'robots.txt','User-agent: *'.chr(10).$robots_data,0644,time(),false);

// Add warnings file
if (get_param_integer('save__warnings',1)==1)
{
	if ($STATIC_EXPORT_WARNINGS!=array())
	{
		tar_add_file($STATIC_EXPORT_TAR,'_warnings.txt',implode(chr(10),$STATIC_EXPORT_WARNINGS),0644,time(),false);
	}
}

// Sitemap, if it has been built
if (file_exists(get_custom_file_base().'/ocp_sitemap.xml'))
	tar_add_file($STATIC_EXPORT_TAR,'ocp_sitemap.xml',get_custom_file_base().'/ocp_sitemap.xml',0644,time(),true);

tar_close($STATIC_EXPORT_TAR);

if (get_param_integer('dir',0)==0)
{
	$GLOBALS['SCREEN_TEMPLATE_CALLED']='';
	exit();
}

// Extract
$myfile=tar_open($tar_path,'rb');
if (!file_exists(get_custom_file_base().'/exports/static'))
{
	mkdir(get_custom_file_base().'/exports/static',0777);
	fix_permissions(get_custom_file_base().'/exports/static',0777);
	sync_file(get_custom_file_base().'/exports/static');
}
tar_extract_to_folder($myfile,'exports/static');
unlink($tar_path);

$title=get_screen_title('Exported to static',false);
$title->evaluate_echo();
echo do_lang('SUCCESS');
