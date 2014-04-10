<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		installer
 */

if (!function_exists('preg_match'))
{
	header('Content-type: text/plain');
	exit('The PHP preg support may not be disabled');
}
$functions=array('fopen');
foreach ($functions as $function)
{
	if (preg_match('#[^,\s]'.$function.'[$,\s]#',@ini_get('disable_functions'))!=0)
	{
		header('Content-type: text/plain');
		exit('The '.$function.' function appears to have been manually disabled in your PHP installation. This is a basic and necessary function, required for ocPortal.');
	}
}

if ((!array_key_exists('type',$_GET)) && (file_exists('install_locked')))
{
	header('Content-type: text/plain');
	exit('Installer is locked for security reasons (delete the \'install_locked\' file to return to the installer)');
}

global $IN_MINIKERNEL_VERSION;
$IN_MINIKERNEL_VERSION=true;

// Find ocPortal base directory, and chdir into it
global $FILE_BASE,$RELATIVE_PATH;
$FILE_BASE=(strpos(__FILE__,'./')===false)?__FILE__:realpath(__FILE__);
$FILE_BASE=dirname($FILE_BASE);
$RELATIVE_PATH='';
@chdir($FILE_BASE);

error_reporting(E_ALL);

@ini_set('display_errors','1');
@ini_set('assert.active','0');

global $DEFAULT_FORUM;
$DEFAULT_FORUM='ocf';

global $REQUIRED_BEFORE;
$REQUIRED_BEFORE=array();

global $SITE_INFO;
$SITE_INFO=array();

global $CURRENT_SHARE_USER;
$CURRENT_SHARE_USER=NULL;

$GLOBALS['DEV_MODE']=false;
$GLOBALS['SEMI_DEV_MODE']=true;

@ob_end_clean(); // Reset to have no output buffering by default (we'll use it internally, taking complete control)

// Are we in a special version of PHP?
define('HIPHOP_PHP',strpos(PHP_VERSION,'hiphop')!==false);
define('GOOGLE_APPENGINE',isset($_SERVER['APPLICATION_ID']));

if (!array_key_exists('type',$_GET))
{
	if (count($_GET)==0)
		header('Content-type: text/html');

	echo '<!DOCTYPE html>'."\n";
	if (count($_GET)==0) // Special code to skip checks if need-be. The XHTML here is invalid but unfortunately it does need to be.
	{
		echo '<script>// <![CDATA[
			window.setTimeout(function() { if (!document.getElementsByTagName("div")[0]) window.location+="?skip_disk_checks=1"; }, 30000);
			window.setInterval(function() { if ((!document.getElementsByTagName("div")[0]) && (document.body) && (document.body.innerHTML) && (document.body.innerHTML.indexOf("Maximum execution time")!=-1)) window.location+="?skip_disk_checks=1"; }, 500);
		//]]></script>';
	}
}

$shl=@ini_get('suhosin.memory_limit');
if (($shl===false) || ($shl=='') || ($shl=='0'))
{
	@ini_set('memory_limit','-1');
} else
{
	if (is_numeric($shl)) $shl.='M'; // Units are in MB for this, while PHP's memory limit setting has it in bytes
	@ini_set('memory_limit',$shl);
}

// Tunnel into some ocPortal code we can use
require_code('critical_errors');
require_code('permissions');
require_code('minikernel');
require_code('inst_special');
require_code('forum_stub');
require_code('global3');
require_code('temporal');
$GLOBALS['PERSISTENT_CACHE']=NULL;
require_code('files');
require_code('lang');
require_code('tempcode');
require_code('templates');
require_code('version');
require_code('urls');
if ((!array_key_exists('step',$_GET)) || (intval($_GET['step'])!=5))
{
	require_code('zones');
	require_code('comcode');
	require_code('themes');
}

global $CACHE_TEMPLATES;
if (is_writable(get_file_base().'/themes/default/templates_cached/'.user_lang())) $CACHE_TEMPLATES=true;

// Set up some globals
global $INSTALL_LANG,$VERSION_BEING_INSTALLED,$CHMOD_ARRAY,$USER_LANG_CACHED;
$INSTALL_LANG=fallback_lang();
if (array_key_exists('default_lang',$_GET)) $INSTALL_LANG=$_GET['default_lang'];
if (array_key_exists('default_lang',$_POST)) $INSTALL_LANG=$_POST['default_lang'];
$USER_LANG_CACHED=$INSTALL_LANG;

// Languages we can use
require_lang('global');
require_lang('critical_error');
require_lang('installer');
require_lang('version');

// If we are referencing this file in order to extract dependant url's from a pack
handle_self_referencing_embedment();

// Requirements check
$phpv=PHP_VERSION;
if ((substr($phpv,0,2)=='3.') || (substr($phpv,0,2)=='4.') || (substr($phpv,0,4)=='5.0.')) exit(do_lang('PHP_OLD'));

// Set up some globals
$minor=ocp_version_minor();
$VERSION_BEING_INSTALLED=strval(ocp_version());
if ($minor!='') $VERSION_BEING_INSTALLED.=(is_numeric($minor[0])?'.':'-').$minor;
$CHMOD_ARRAY=get_chmod_array($INSTALL_LANG);

$password_prompt=new ocp_tempcode();

if (!array_key_exists('step',$_GET))
{
	$_GET['step']='1';
}

if (intval($_GET['step'])==1) // Language
{
	$content=step_1();
}

if (intval($_GET['step'])==2) // Licence
{
	$content=step_2();
}

if (intval($_GET['step'])==3) // Welcome
{
	$content=step_3();
}

if (intval($_GET['step'])==4) // Define settings
{
	$content=step_4();
	$forum_type=get_param('forum_type','');
	if ($forum_type=='none') $username='admin';
	$password_prompt=do_lang_tempcode('CONFIRM_MASTER_PASSWORD');
}

if (intval($_GET['step'])==5)
{
	$content=step_5();
}

if (intval($_GET['step'])==6)
{
	$content=step_6();
}

if (intval($_GET['step'])==7)
{
	$content=step_7();
}

if (intval($_GET['step'])==8)
{
	$content=step_8();
}

if (intval($_GET['step'])==9)
{
	$content=step_9();
}

if (intval($_GET['step'])==10)
{
	$content=step_10();
}

$css_url='install.php?type=css';
$css_url_2='install.php?type=css_2';
$logo_url='install.php?type=logo';
if (is_null($DEFAULT_FORUM)) $DEFAULT_FORUM='ocf'; // Shouldn't happen, but who knows
require_code('tempcode_compiler');
$css_nocache=_do_template('default','/css/','no_cache','no_cache','EN','.css');
$out_final=do_template('INSTALLER_HTML_WRAP',array(
	'_GUID'=>'29aa056c05fa360b72dbb01c46608c4b',
	'CSS_NOCACHE'=>$css_nocache,
	'DEFAULT_FORUM'=>$DEFAULT_FORUM,
	'PASSWORD_PROMPT'=>$password_prompt,
	'CSS_URL'=>$css_url,
	'CSS_URL_2'=>$css_url_2,
	'LOGO_URL'=>$logo_url,
	'STEP'=>integer_format(intval($_GET['step'])),
	'CONTENT'=>$content,
	'VERSION'=>$VERSION_BEING_INSTALLED,
));
unset($css_nocache);
unset($content);
$out_final->evaluate_echo();

global $DATADOTOCP_FILE;
if (@is_resource($DATADOTOCP_FILE))
{
	if ((intval($_GET['step'])==10) && (!is_suexec_like()))
	{
		$conn=false;
		$domain=trim(post_param('ftp_domain'));
		$port=21;
		if (strpos($domain,':')!==false)
		{
			list($domain,$_port)=explode(':',$domain,2);
			$port=intval($_port);
		}
		if (function_exists('ftp_ssl_connect')) $conn=@ftp_ssl_connect($domain,$port);
		$ssl=($conn!==false);
		$username=trim(post_param('ftp_username'));
		$password=trim(post_param('ftp_password'));
		if (($ssl) && (!@ftp_login($conn,$username,$password)))
		{
			$conn=false;
			$ssl=false;
		}
		if ($conn===false) $conn=ftp_connect($domain,$port);
		if (!$ssl) ftp_login($conn,$username,$password);
		$ftp_folder=trim(post_param('ftp_folder'));
		if (substr($ftp_folder,-1)!='/') $ftp_folder.='/';
		ftp_chdir($conn,$ftp_folder);
		if (file_exists('ocp_inst_tmp'))
		{
			$tmp=fopen(get_file_base().'/ocp_inst_tmp/tmp','wb');
			fwrite($tmp,'');
			fclose($tmp);
			ftp_put($conn,'install_locked',get_file_base().'/ocp_inst_tmp/tmp',FTP_BINARY);
			ftp_put($conn,'install_ok',get_file_base().'/ocp_inst_tmp/tmp',FTP_BINARY);
			@unlink(get_file_base().'/ocp_inst_tmp/tmp'); // Might not be able to unlink on a Windows server, if has permission to create but not delete
			@unlink(get_file_base().'/ocp_inst_tmp');
			@ftp_rmdir($conn,'ocp_inst_tmp');
			if (function_exists('ftp_close'))
			{
				ftp_close($conn);
			}
		}
	}
}

// ========================================
// Installation steps
// ========================================

/**
 * First installation step.
 *
 * @return tempcode		Progress report / UI
 */
function step_1()
{
	// To stop previous installs interfering
	require_code('caches3');
	erase_cached_templates();
	erase_cached_language();

	// Integrity check
	$warnings=new ocp_tempcode();
	global $DATADOTOCP_FILE;
	if (!@is_resource($DATADOTOCP_FILE)) // Do an integrity check - missing corrupt files
	{
		if ((array_key_exists('skip_disk_checks',$_GET)) || (file_exists(get_file_base().'/.git')))
		{
			if (!file_exists(get_file_base().'/.git'))
				$warnings->attach(do_template('INSTALLER_WARNING',array('MESSAGE'=>do_lang_tempcode('INSTALL_SLOW_SERVER'))));
		} else
		{
			$files=@unserialize(file_get_contents(get_file_base().'/data/files.dat'));
			if (($files!==false) && (!file_exists(get_file_base().'/.svn')))
			{
				$missing=array();
				$corrupt=array();

				foreach ($files as $file=>$file_info)
				{
					// Volatile files (see also list in make_release.php)
					if ($file=='data_custom/errorlog.php') continue;
					if ($file=='data_custom/execute_temp.php') continue;
					if ($file=='ocp_sitemap.xml') continue;
					if ($file=='ocp_news_sitemap.xml') continue;
					if ($file=='_config.php') continue;
					if ($file=='themes/map.ini') continue;
					if ($file=='sources/version.php') continue;
					if ($file=='data_custom/functions.dat') continue;
					if ($file=='data/files.dat') continue;
					if ($file=='data/files_previous.dat') continue;
					if ($file=='data/modules/admin_stats/IP_Country.txt') continue;
					if ($file=='data/spelling/aspell/bin/aspell-15.dll') continue;
					if ($file=='data/spelling/aspell/bin/en-only.rws') continue;
					if (substr($file,-4)=='.ttf') continue;

					$contents=@file_get_contents(get_file_base().'/'.$file);
					if (!file_exists(get_file_base().'/'.$file))
					{
						$missing[]=$file;
					}
					elseif (($contents!==false) && (sprintf('%u',crc32(preg_replace('#[\r\n\t ]#','',$contents)))!=$file_info[0]))
					{
						$corrupt[]=$file;
					}
				}

				if (count($missing)>4)
				{
					$warnings->attach(do_template('INSTALLER_WARNING_LONG',array('_GUID'=>'515c2f26a5415224f3c09b2429a78a5f','FILES'=>$missing,'MESSAGE'=>do_lang_tempcode('_MISSING_INSTALLATION_FILE',integer_format(count($missing))))));
				} else
				{
					foreach ($missing as $file)
					{
						$warnings->attach(do_template('INSTALLER_WARNING',array('MESSAGE'=>do_lang_tempcode('MISSING_INSTALLATION_FILE',$file))));
					}
				}
				if (count($corrupt)>4)
				{
					$warnings->attach(do_template('INSTALLER_WARNING_LONG',array('_GUID'=>'f8958458d76bd4f6d146d3fe59132a02','FILES'=>$corrupt,'MESSAGE'=>do_lang_tempcode('_CORRUPT_INSTALLATION_FILE',integer_format(count($corrupt))))));
				} else
				{
					foreach ($corrupt as $file)
					{
						$warnings->attach(do_template('INSTALLER_WARNING',array('MESSAGE'=>do_lang_tempcode('CORRUPT_INSTALLATION_FILE',$file))));
					}
				}
			}
		}
	}

	// Various checks
	$hooks=find_all_hooks('systems','checks');
	foreach (array_keys($hooks) as $hook)
	{
		require_code('hooks/systems/checks/'.filter_naughty($hook));
		$ob=object_factory('Hook_check_'.$hook);
		$warning=$ob->run();
		foreach ($warning as $_warning)
		{
			$warnings->attach(do_template('INSTALLER_WARNING',array('MESSAGE'=>$_warning)));
		}
	}

	// Some checks relating to installation permissions
	global $FILE_ARRAY;
	if (!@is_array($FILE_ARRAY)) // Talk about manual permission setting a bit
	{
		if ((function_exists('posix_getuid')) && (strpos(@ini_get('disable_functions'),'posix_getuid')===false) && (!isset($_SERVER['HTTP_X_MOSSO_DT'])) && (@posix_getuid()==@fileowner(get_file_base().'/install.php'))) // NB: Could also be that files are owned by 'apache'/'nobody'. In these cases the users have consciously done something special and know what they're doing (they have open_basedir at least hopefully!) so we'll still consider this 'suexec'. It's too much an obscure situation.
			$warnings->attach(do_template('INSTALLER_NOTICE',array('MESSAGE'=>do_lang_tempcode('SUEXEC_SERVER'))));
		elseif (is_writable_wrap(get_file_base().'/install.php'))
			$warnings->attach(do_template('INSTALLER_NOTICE',array('MESSAGE'=>do_lang_tempcode('RECURSIVE_SERVER'))));
	}
	if ((file_exists(get_file_base().'/_config.php')) && (!is_writable_wrap(get_file_base().'/_config.php')) && (!function_exists('posix_getuid')) && ((strpos(PHP_OS,'WIN')!==false)))
		$warnings->attach(do_template('INSTALLER_WARNING',array('MESSAGE'=>do_lang_tempcode('TROUBLESOME_WINDOWS_SERVER',escape_html(get_tutorial_url('tut_adv_installation'))))));

	// Some sanity checks
	if (!@is_array($FILE_ARRAY)) // Secondary to the file-by-file check. Aims to give more specific information
	{
		if ((file_exists(get_file_base().'/themes/default/templates/ANCHOR.tpl')) && (!file_exists(get_file_base().'/themes/default/templates/COMCODE_REAL_TABLE_CELL.tpl')))
			warn_exit(do_lang_tempcode('CORRUPT_FILES_CROP'));
		if ((!file_exists(get_file_base().'/themes/default/templates/ANCHOR.tpl')) && (file_exists(get_file_base().'/themes/default/templates/anchor.tpl')))
			warn_exit(do_lang_tempcode('CORRUPT_FILES_LOWERCASE'));
	}

	if (file_exists('lang_custom/langs.ini')) $lookup=better_parse_ini_file(get_custom_file_base().'/lang_custom/langs.ini');
		else $lookup=better_parse_ini_file(get_file_base().'/lang/langs.ini');

	$lang_count=array();
	$langs1=get_dir_contents('lang');
	foreach (array_keys($langs1) as $lang)
	{
		if (array_key_exists($lang,$lookup))
		{
			if (!array_key_exists($lang,$lang_count)) $lang_count[$lang]=0;

			$files=get_dir_contents('lang/'.$lang);
			foreach (array_keys($files) as $file)
				if (substr($file,-4)=='.ini')
					$lang_count[$lang]+=count(better_parse_ini_file(get_file_base().'/lang/'.$lang.'/'.$file));
		}
	}
	$langs2=get_dir_contents('lang_custom');
	foreach (array_keys($langs2) as $lang)
	{
		if (array_key_exists($lang,$lookup))
		{
			if (!array_key_exists($lang,$lang_count)) $lang_count[$lang]=0;

			$files=get_dir_contents('lang_custom/'.$lang);
			foreach (array_keys($files) as $file)
				if (substr($file,-4)=='.ini')
					$lang_count[$lang]+=count(better_parse_ini_file(get_custom_file_base().'/lang_custom/'.$lang.'/'.$file));
		}
	}
	$langs=array_merge($langs1,$langs2);
	ksort($langs);
	unset($langs['EN']);
	$langs=array_merge(array('EN'=>'lang'),$langs);
	$tlanguages=new ocp_tempcode();
	foreach (array_keys($langs) as $lang)
	{
		if (array_key_exists($lang,$lookup))
		{
			$stub=($lang=='EN')?'':(' (unofficial, '.strval(intval(round(100.0*$lang_count[$lang]/$lang_count['EN']))).'% changed)');
			$entry=do_template('FORM_SCREEN_INPUT_LIST_ENTRY',array('SELECTED'=>$lang==user_lang(),'DISABLED'=>false,'NAME'=>$lang,'CLASS'=>'','TEXT'=>$lookup[$lang].$stub));
			$tlanguages->attach($entry);
		}
	}

	$url='install.php?step=2';
	if (in_safe_mode()) $url.='&keep_safe_mode=1';

	$hidden=build_keep_post_fields();
	$max=strval(get_param_integer('max',1000));
	$hidden->attach(form_input_hidden('max',$max));
	return do_template('INSTALLER_STEP_1',array('_GUID'=>'83f0ca881b9f63ab9378264c6ff507a3','URL'=>$url,'WARNINGS'=>$warnings,'HIDDEN'=>$hidden,'LANGUAGES'=>$tlanguages));
}

/**
 * Second installation step.
 *
 * @return tempcode		Progress report / UI
 */
function step_2()
{
	if (!array_key_exists('default_lang',$_POST)) $_POST['default_lang']='EN';
	global $FILE_ARRAY;
	if (@is_array($FILE_ARRAY))
	{
		$licence=file_array_get('text/'.$_POST['default_lang'].'/licence.txt');
		if (is_null($licence)) $licence=file_array_get('text/EN/licence.txt');
	}
	else
	{
		$licence=@file_get_contents(get_file_base().'/text/'.$_POST['default_lang'].'/licence.txt');
		if ($licence=='') $licence=file_get_contents(get_file_base().'/text/EN/licence.txt');
	}

	$url='install.php?step=3';
	if (in_safe_mode()) $url.='&keep_safe_mode=1';

	$hidden=build_keep_post_fields();
	return do_template('INSTALLER_STEP_2',array('_GUID'=>'b08b0268784c9a0f44863ae3aece6789','URL'=>$url,'HIDDEN'=>$hidden,'LICENCE'=>$licence));
}

/**
 * Third installation step.
 *
 * @return tempcode		Progress report / UI
 */
function step_3()
{
	if (count($_POST)==0) exit(do_lang('INST_POST_ERROR'));

	global $INSTALL_LANG;

	// Call home, if they asked to
	$advertise_on=post_param_integer('advertise_on',0);
	$email=$_POST['email'];
	if ($email==do_lang('EMAIL_ADDRESS')) $email=''; // In case was left as the label
	if (($email!='') || ($advertise_on==1))
	{
		require_code('files');
		http_download_file('http://ocportal.com/uploads/website_specific/ocportal.com/scripts/newsletter_join.php?url='.urlencode('http://'.ocp_srv('HTTP_HOST').ocp_srv('SCRIPT_NAME')).'&email='.urlencode($email).'&interest_level='.$_POST['interest_level'].'&advertise_on='.strval($advertise_on).'&lang='.$INSTALL_LANG,NULL,false);
	}

	// Forum chooser
	$forums=get_dir_contents('sources/forum',true);
	unset($forums['none']);
	ksort($forums);
	$forums=array_merge(array('none'=>1),$forums);
	$forum_info=better_parse_ini_file(get_file_base().'/sources/forum/forums.ini');
	$tforums=new ocp_tempcode();
	$classes=array();
	foreach (array_keys($forums) as $forum)
	{
		$class=array_key_exists($forum.'_class',$forum_info)?$forum_info[$forum.'_class']:'general';
		$classes[$class][]=$forum;
	}
	global $DEFAULT_FORUM;
	if ((file_exists(get_file_base().'/_config.php')) && (filesize(get_file_base().'/_config.php')!=0))
	{
		require_once(get_file_base().'/_config.php');
		global $SITE_INFO;
		if (array_key_exists('forum_type',$SITE_INFO)) $DEFAULT_FORUM=$SITE_INFO['forum_type'];
	}
	$default_version=new ocp_tempcode();
	$simple_forums=new ocp_tempcode(); // For is JS is off, this is a simple flat list of all versions (rather than a two level list - with first level being $tforums and the second level being filtered using CSS 'display' from $versions)

	foreach ($classes as $class=>$forums)
	{
		if (trim($class)=='') continue;

		$mapped_name=do_lang('FORUM_CLASS_'.$class,NULL,NULL,NULL,NULL,false);
		if (is_null($mapped_name)) $mapped_name=ucwords($class);
		$versions=new ocp_tempcode();
		$first=true;
		$forums=array_reverse($forums);
		$rec=in_array($DEFAULT_FORUM,$forums);
		foreach ($forums as $forum)
		{
			if (!GOOGLE_APPENGINE)
			{
				if ($forum!='ocf')
					continue;
			}

			if ($class=='general')
			{
				$version=$forum;
			} else
			{
				$version=array_key_exists($forum.'_version',$forum_info)?do_lang('VERSION_NUM',$forum_info[$forum.'_version']):do_lang('NA');
			}
			$extra2='';//(($first && !$rec) || $rec)?'checked="checked"':'';
			$versions->attach(do_template('INSTALLER_FORUM_CHOICE_VERSION',array('_GUID'=>'159a5a7cd1397620ef34e98c3b06cd7f','IS_DEFAULT'=>($DEFAULT_FORUM==$forum) || ($first && !$rec),'CLASS'=>$class,'NAME'=>$forum,'VERSION'=>$version,'EXTRA'=>$extra2)));
			$first=false;

			$simple_forums->attach(do_template('INSTALLER_FORUM_CHOICE_VERSION',array('_GUID'=>'c4c0e7accab56ae45e8e1a4ff777c42b','IS_DEFAULT'=>($DEFAULT_FORUM==$forum) || ($first && !$rec),'CLASS'=>$class,'NAME'=>$forum,'VERSION'=>$mapped_name.' '.$version,'EXTRA'=>'')));
		}
		if ($rec) $default_version=$versions;
		$extra=($rec)?'checked="checked"':'';
		$tforums->attach(do_template('INSTALLER_FORUM_CHOICE',array('_GUID'=>'a5460829e86c9da3637f8e566cfca63c','CLASS'=>$class,'REC'=>$rec,'TEXT'=>$mapped_name,'VERSIONS'=>$versions,'EXTRA'=>$extra)));
	}

	// Database chooser
	$databases=array_merge(get_dir_contents('sources/database',true),get_dir_contents('sources_custom/database',true));
	ksort($databases);
	$database_names=better_parse_ini_file(get_file_base().'/sources/database/database.ini');
	$tdatabase=new ocp_tempcode();
	$dbs_found=0;
	foreach (array_keys($databases) as $database)
	{
		if (!GOOGLE_APPENGINE)
		{
			if ($database!='mysql')
				continue;
		}

		if ((count($databases)==1) && ($database=='xml')) continue; // If they only have experimental XML option, they'll choose it - we don't want that - we want them to get the error

		if (($database=='mysqli') && (!function_exists('mysqli_connect'))) continue;
		if (($database=='mysql_dbx') && (!function_exists('dbx_connect'))) continue;
		if (($database=='mysql') && (!function_exists('mysql_connect'))) continue;
		if (($database=='access') && (!function_exists('odbc_connect'))) continue;
		if (($database=='ibm') && (!function_exists('odbc_connect'))) continue;
		if (($database=='oracle') && (!function_exists('ocilogon'))) continue;
		if (($database=='postgresql') && (!function_exists('pg_connect'))) continue;
		if (($database=='sqlite') && (!function_exists('sqlite_popen'))) continue;
		if (($database=='sqlserver') && (!function_exists('mssql_connect')) && (!function_exists('sqlsrv_connect'))) continue;

		if (array_key_exists($database,$database_names)) $mapped_name=$database_names[$database]; else $mapped_name=$database;
		$tdatabase->attach(do_template('FORM_SCREEN_INPUT_LIST_ENTRY',array('SELECTED'=>$database=='mysql','DISABLED'=>false,'NAME'=>$database,'CLASS'=>'','TEXT'=>$mapped_name)));

		if ($database!='xml') $dbs_found++;
	}
	if ($tdatabase->is_empty() || $dbs_found==0/* Better to provide no option, than just the XML option - confuses users*/)
		warn_exit(do_lang_tempcode('NO_PHP_DB'));

	$js=do_template('JAVASCRIPT');
	$js->attach("\n");
	$js->attach(do_template('JAVASCRIPT_AJAX'));

	$url='install.php?step=4';
	if (in_safe_mode()) $url.='&keep_safe_mode=1';

	$hidden=build_keep_post_fields();
	return do_template('INSTALLER_STEP_3',array(
		'_GUID'=>'af52ecea73e9a8e2a92c12adbabbf4ab',
		'URL'=>$url,
		'JS'=>$js,
		'HIDDEN'=>$hidden,
		'SIMPLE_FORUMS'=>$simple_forums,
		'FORUM_PATH_DEFAULT'=>get_file_base().DIRECTORY_SEPARATOR.'forums',
		'FORUMS'=>$tforums,
		'DATABASES'=>$tdatabase,
		'VERSION'=>$default_version,
		'IS_QUICK'=>@is_array($GLOBALS['FILE_ARRAY']),
	));
}

/**
 * Fourth installation step.
 *
 * @return tempcode		Progress report / UI
 */
function step_4()
{
	global $INSTALL_LANG;

	if (count($_POST)==0) exit(do_lang('INST_POST_ERROR'));

	$js=do_template('JAVASCRIPT');
	$js->attach("\n");
	$js->attach(do_template('JAVASCRIPT_AJAX'));

	require_code('database/'.post_param('db_type'));
	$GLOBALS['DB_STATIC_OBJECT']=object_factory('Database_Static_'.post_param('db_type'));

	// Probing

	$base_url=post_param('base_url','http://'.ocp_srv('HTTP_HOST').dirname(ocp_srv('SCRIPT_NAME')));

	// Our forum is
	$forum_type=post_param('forum_type');
	require_code('forum/'.$forum_type);
	$GLOBALS['FORUM_DRIVER']=object_factory('forum_driver_'.filter_naughty_harsh($forum_type));
	$GLOBALS['FORUM_DRIVER']->MEMBER_ROWS_CACHED=array();

	// Try and grab ourselves forum details
	global $PROBED_FORUM_CONFIG;
	/** When forum drivers are asked to probe configuration from a potentially existing forum, it gets stored in here.
	 * @global array $PROBED_FORUM_CONFIG
	 */
	$PROBED_FORUM_CONFIG=array();
	$PROBED_FORUM_CONFIG['sql_database']='';
	$PROBED_FORUM_CONFIG['sql_user']='';
	$PROBED_FORUM_CONFIG['sql_pass']='';
	$board_path=post_param('board_path','');
	find_forum_path($board_path);

	if ((!array_key_exists('board_url',$PROBED_FORUM_CONFIG)) || (!(strlen($PROBED_FORUM_CONFIG['board_url'])>0)))
	{
		$file_base=get_file_base();
		for ($i=0;$i<strlen($board_path);$i++)
		{
			if ($i>=strlen($file_base)) break;
			if ($board_path[$i]!=$file_base[$i]) break;
		}

		$append=str_replace('\\','/',substr($board_path,$i));
		$PROBED_FORUM_CONFIG['board_url']=(strlen($append)<15)?(substr($base_url,0,strlen($base_url)-($i-strlen($board_path))).((((strlen($append)>0) && ($append[0]=='/')))?'':'/').$append):($base_url.'/forums');
	}

	if (!array_key_exists('cookie_member_id',$PROBED_FORUM_CONFIG)) $PROBED_FORUM_CONFIG['cookie_member_id']='ocp_member_id';
	if (!array_key_exists('cookie_member_hash',$PROBED_FORUM_CONFIG)) $PROBED_FORUM_CONFIG['cookie_member_hash']='ocp_member_hash';

	$cookie_domain='';//(($domain=='localhost') || (strpos($domain,'.')===false))?'':('.'.$domain);
	$cookie_path='/';
	$cookie_days='120';
	$use_persistent=false;
	require_code('version');
	$table_prefix='ocp_';
	if (strpos(strtoupper(PHP_OS),'WIN')!==false)
	{
		$db_site_host='127.0.0.1';
	} else
	{
		$db_site_host='localhost';
	}
	$db_site_user=$PROBED_FORUM_CONFIG['sql_user'];
	$db_site_password=$PROBED_FORUM_CONFIG['sql_pass'];
	$db_site=$PROBED_FORUM_CONFIG['sql_database'];
	$db_forums_host=$db_site_host;
	$db_forums_user=$db_site_user;
	$db_forums_password=$db_site_password;
	$db_forums=$db_site;
	$board_prefix=$PROBED_FORUM_CONFIG['board_url'];
	$member_cookie=$PROBED_FORUM_CONFIG['cookie_member_id'];
	$pass_cookie=$PROBED_FORUM_CONFIG['cookie_member_hash'];

	$specifics=$GLOBALS['FORUM_DRIVER']->install_specifics();

	// Now we've gone through all the work of detecting it, lets grab from _config.php to see what we had last time we installed
	global $SITE_INFO;
	if ((file_exists(get_file_base().'/_config.php')) && (filesize(get_file_base().'/_config.php')!=0))
	{
		require_once(get_file_base().'/_config.php');
		if ($PROBED_FORUM_CONFIG['sql_database']!='')
		{
			if ((!array_key_exists('forum_type',$SITE_INFO)) || ($SITE_INFO['forum_type']!=$forum_type)) // Don't want to throw detected versions of these away
			{
				unset($SITE_INFO['user_cookie']);
				unset($SITE_INFO['pass_cookie']);
			}
			foreach ($specifics as $specific)
			{
				if (array_key_exists($specific['name'],$SITE_INFO)) unset($SITE_INFO[$specific['name']]);
			}
			unset($SITE_INFO['db_forums_host']);
			unset($SITE_INFO['db_forums_user']);
			unset($SITE_INFO['db_forums_password']);
			unset($SITE_INFO['db_forums']);
			unset($SITE_INFO['db_site_host']);
			unset($SITE_INFO['db_site_user']);
			unset($SITE_INFO['db_site_password']);
			unset($SITE_INFO['db_site']);
		}
		unset($SITE_INFO['base_url']);
	}

	$sections=new ocp_tempcode();

	// Detect FTP settings

	if ((function_exists('posix_getpwuid')) && (strpos(@ini_get('disable_functions'),'posix_getpwuid')===false))
	{
		$u_info=posix_getpwuid(fileowner(get_file_base().'/install.php'));
		if ($u_info!==false) $ftp_username=$u_info['name']; else $ftp_username='';
	} else $ftp_username='';
	if (is_null($ftp_username)) $ftp_username='';
	$dr=array_key_exists('DOCUMENT_ROOT',$_SERVER)?$_SERVER['DOCUMENT_ROOT']:(array_key_exists('DOCUMENT_ROOT',$_ENV)?$_ENV['DOCUMENT_ROOT']:'');
	if (strpos($dr,'/')!==false) $dr_parts=explode('/',$dr); else $dr_parts=explode('\\',$dr);
	$webdir_stub=$dr_parts[count($dr_parts)-1];

	// If we have a host where the FTP is two+ levels down (often when we have one FTP covering multiple virtual hosts), then this "last component" rule would be insufficient; do a search through for critical strings to try and make a better guess
	$special_root_dirs=array('public_html','www','webroot','httpdocs','wwwroot');
	$webdir_stub=$dr_parts[count($dr_parts)-1];
	foreach ($dr_parts as $i=>$part)
	{
		if (in_array($part,$special_root_dirs))
		{
			$webdir_stub=implode('/',array_slice($dr_parts,$i));
		}
	}

	$domain=preg_replace('#:.*#','',ocp_srv('HTTP_HOST'));
	$ftp_folder='/'.$webdir_stub.basename(ocp_srv('SCRIPT_NAME'));
	$ftp_domain=$domain;

	// Is this autoinstaller? FTP settings

	global $FILE_ARRAY;
	if ((@is_array($FILE_ARRAY)) && (!is_suexec_like()))
	{
		$title=protect_from_escaping(escape_html('FTP'));
		$text=do_lang_tempcode('AUTO_INSTALL');
		$hidden=new ocp_tempcode();
		$options=new ocp_tempcode();
		$options->attach(make_option(do_lang_tempcode('FTP_DOMAIN'),new ocp_tempcode(),'ftp_domain',post_param('ftp_domain',$ftp_domain),false,true));
		$options->attach(make_option(do_lang_tempcode('FTP_USERNAME'),new ocp_tempcode(),'ftp_username',post_param('ftp_username',$ftp_username),false,true));
		$options->attach(make_option(do_lang_tempcode('FTP_PASSWORD'),new ocp_tempcode(),'ftp_password',post_param('ftp_password',''),true));
		$options->attach(make_option(do_lang_tempcode('FTP_DIRECTORY'),do_lang_tempcode('FTP_FOLDER'),'ftp_folder',post_param('ftp_folder',$ftp_folder)));
		$options->attach(make_option(do_lang_tempcode('FTP_FILES_PER_GO'),do_lang_tempcode('DESCRIPTION_FTP_FILES_PER_GO'),'max',post_param('max','1000')));
		$sections->attach(do_template('INSTALLER_STEP_4_SECTION',array('_GUID'=>'50fcb00f4d1da1813e94d86529ea0862','HIDDEN'=>$hidden,'TITLE'=>$title,'TEXT'=>$text,'OPTIONS'=>$options)));
	}

	// General settings

	$title=do_lang_tempcode('GENERAL_SETTINGS');
	$text=new ocp_tempcode();
	$options=new ocp_tempcode();
	$hidden=new ocp_tempcode();
	if (!GOOGLE_APPENGINE)
	{
		$options->attach(make_option(do_lang_tempcode('DOMAIN'),example('DOMAIN_EXAMPLE'),'domain',$domain,false,true));
		$options->attach(make_option(do_lang_tempcode('BASE_URL'),example('BASE_URL_TEXT'),'base_url',$base_url,false,true));
	} else
	{
		$options->attach(make_option(do_lang_tempcode('GAE_APPLICATION'),do_lang_tempcode('DESCRIPTION_GAE_APPLICATION'),'gae_application',preg_replace('#^.*~#','',$_SERVER['APPLICATION_ID']),false,true));
		$hidden->attach(form_input_hidden('domain',$domain));
		$hidden->attach(form_input_hidden('base_url',$base_url));
		$options->attach(make_option(do_lang_tempcode('GAE_BUCKET_NAME'),do_lang_tempcode('DESCRIPTION_GAE_BUCKET_NAME'),'gae_bucket_name','<application>',false,true));
	}
	$master_password='';
	$options->attach(make_option(do_lang_tempcode('MASTER_PASSWORD'),example('','CHOOSE_MASTER_PASSWORD'),'master_password',$master_password,true));
	require_lang('config');
	$options->attach(make_tick(do_lang_tempcode('SEND_ERROR_EMAILS_OCPRODUCTS'),example('','CONFIG_OPTION_send_error_emails_ocproducts'),'allow_reports_default',1));
	$sections->attach(do_template('INSTALLER_STEP_4_SECTION',array('_GUID'=>'f051465e86a7a53ec078e0d9de773993','HIDDEN'=>$hidden,'TITLE'=>$title,'TEXT'=>$text,'OPTIONS'=>$options)));

	// Database settings for forum (if applicable)

	$hidden=new ocp_tempcode();
	$forum_text=new ocp_tempcode();
	if (($forum_type=='ocf') || ($forum_type=='none'))
	{
		$forum_title=do_lang_tempcode('MEMBER_SETTINGS');
	} else
	{
		$_forum_type=do_lang('FORUM_CLASS_'.preg_replace('#\d+$#','',$forum_type),NULL,NULL,NULL,NULL,false);
		if (is_null($_forum_type)) $_forum_type=ucwords($forum_type);
		$forum_title=do_lang_tempcode('_FORUM_SETTINGS',escape_html($_forum_type));
	}
	$forum_options=new ocp_tempcode();
	$use_msn=post_param_integer('use_msn',0);
	if ($use_msn==0) $use_msn=post_param_integer('use_multi_db',0);
	$forum_type=post_param('forum_type');
	if ($forum_type!='none')
	{
		if ($use_msn==1)
		{
			if ($forum_type!='ocf') $forum_text=do_lang_tempcode('AUTODETECT');
			$forum_options->attach(make_option(do_lang_tempcode('DATABASE_NAME'),new ocp_tempcode(),'db_forums',$db_forums,false,true));
			if (!$GLOBALS['DB_STATIC_OBJECT']->db_is_flat_file_simple())
			{
				$forum_options->attach(make_option(do_lang_tempcode('DATABASE_HOST'),example('','DATABASE_HOST_TEXT'),'db_forums_host',$db_forums_host,false,true));
				$forum_options->attach(make_option(do_lang_tempcode('DATABASE_USERNAME'),new ocp_tempcode(),'db_forums_user',$db_forums_user,false,true));
				$forum_options->attach(make_option(do_lang_tempcode('DATABASE_PASSWORD'),new ocp_tempcode(),'db_forums_password',$db_forums_password,true));
			} else
			{
				$hidden->attach(form_input_hidden('db_forums_host','localhost'));
				$hidden->attach(form_input_hidden('db_forums_user',''));
				$hidden->attach(form_input_hidden('db_forums_password',''));
			}
			$hidden->attach(form_input_hidden('use_msn',strval($use_msn)));
		}
		if (($forum_type!='ocf') || ($use_msn==1))
			$forum_options->attach(make_option(do_lang_tempcode('BASE_URL'),example('FORUM_BASE_URL_EXAMPLE','BASE_URL_TEXT_FORUM'),'board_prefix',$board_prefix,false,true));
	}
	foreach ($specifics as $specific)
	{
		if ($specific['name']=='clear_existing_forums_on_install')
		{
			$hidden->attach(form_input_hidden('clear_existing_forums_on_install','yes'));
		}
		elseif (($specific['name']!='ocf_table_prefix') || ($use_msn==1))
		{
			$forum_options->attach(make_option(is_object($specific['title'])?$specific['title']:make_string_tempcode($specific['title']),is_object($specific['description'])?$specific['description']:make_string_tempcode($specific['description']),$specific['name'],array_key_exists($specific['name'],$SITE_INFO)?$SITE_INFO[$specific['name']]:$specific['default'],strpos($specific['name'],'password')!==false));
		}
	}

	// Database settings for site

	$text=($use_msn==1)?do_lang_tempcode(($forum_type=='ocf')?'DUPLICATE_OCF':'DUPLICATE'):new ocp_tempcode();
	$options=make_option(do_lang_tempcode('DATABASE_NAME'),new ocp_tempcode(),'db_site',$db_site,false,true);
	if (!$GLOBALS['DB_STATIC_OBJECT']->db_is_flat_file_simple())
	{
		$options->attach(make_option(do_lang_tempcode('DATABASE_HOST'),example('','DATABASE_HOST_TEXT'),'db_site_host',$db_site_host,false,true));
		$options->attach(make_option(do_lang_tempcode('DATABASE_USERNAME'),new ocp_tempcode(),'db_site_user',$db_site_user,false,true));
		$options->attach(make_option(do_lang_tempcode('DATABASE_PASSWORD'),new ocp_tempcode(),'db_site_password',$db_site_password,true));
	} else
	{
		$hidden->attach(form_input_hidden('db_site_host','localhost'));
		$hidden->attach(form_input_hidden('db_site_user',''));
		$hidden->attach(form_input_hidden('db_site_password',''));
	}
	if (post_param('db_type')!='xml')
		$options->attach(make_option(do_lang_tempcode('TABLE_PREFIX'),example('TABLE_PREFIX_TEXT'),'table_prefix',$table_prefix));
	else
		$hidden->attach(form_input_hidden('table_prefix',$table_prefix));
	/*if (!GOOGLE_APPENGINE)	Excessive, let user tune later
	{
		$options->attach(make_tick(do_lang_tempcode('USE_PERSISTENT'),example('','USE_PERSISTENT_TEXT'),'use_persistent',$use_persistent?1:0));
	}*/

	if (($use_msn==0) && ($forum_type!='ocf')) // Merge into one set of options
	{
		$forum_options->attach($options);
		$sections->attach(do_template('INSTALLER_STEP_4_SECTION',array('_GUID'=>'48a122b54d68d9893533ece7237ea5e0','HIDDEN'=>$hidden,'TITLE'=>$forum_title,'TEXT'=>$forum_text,'OPTIONS'=>$forum_options)));
	} else
	{
		if (GOOGLE_APPENGINE)
		{
			$title=do_lang_tempcode('DEV_DATABASE_SETTINGS');
			$text=do_lang_tempcode('DEV_DATABASE_SETTINGS_HELP');
			$sections->attach(do_template('INSTALLER_STEP_4_SECTION',array('HIDDEN'=>$hidden,'TITLE'=>$title,'TEXT'=>$text,'OPTIONS'=>$options)));

			$title=do_lang_tempcode('LIVE_DATABASE_SETTINGS');
			$text=do_lang_tempcode('LIVE_DATABASE_SETTINGS_HELP');
			$options=new ocp_tempcode();
			$options->attach(make_option(do_lang_tempcode('DATABASE_HOST'),new ocp_tempcode(),'gae_live_db_site_host',':/cloudsql/<application>:<application>',false,true));
			$options->attach(make_option(do_lang_tempcode('DATABASE_NAME'),new ocp_tempcode(),'gae_live_db_site','<application>',false,true));
			$options->attach(make_option(do_lang_tempcode('DATABASE_USERNAME'),new ocp_tempcode(),'gae_live_db_site_user','root',false,true));
			$options->attach(make_option(do_lang_tempcode('DATABASE_PASSWORD'),new ocp_tempcode(),'gae_live_db_site_password','',true));
			$sections->attach(do_template('INSTALLER_STEP_4_SECTION',array('HIDDEN'=>'','TITLE'=>$title,'TEXT'=>$text,'OPTIONS'=>$options)));

			$js->attach('
				var gae_application=document.getElementById(\'gae_application\');
				gae_application.onchange=function() {
					var gae_live_db_site=document.getElementById(\'gae_live_db_site\');
					gae_live_db_site.value=gae_live_db_site.value.replace(/(<application>|ocportal)/g,gae_application.value);
					var gae_live_db_site_host=document.getElementById(\'gae_live_db_site_host\');
					gae_live_db_site_host.value=gae_live_db_site_host.value.replace(/(<application>|ocportal)/g,gae_application.value);
					var gae_bucket_name=document.getElementById(\'gae_bucket_name\');
					gae_bucket_name.value=gae_bucket_name.value.replace(/(<application>|ocportal)/g,gae_application.value);
				};
				gae_application.onchange();
			');
		} else
		{
			$title=do_lang_tempcode((($forum_type=='ocf' || $forum_type=='none') && $use_msn==0)?'DATABASE_SETTINGS':'OCPORTAL_SETTINGS');
			if (!$forum_options->is_empty()) $sections->attach(do_template('INSTALLER_STEP_4_SECTION',array('_GUID'=>'232b69a995f384275c1cd9269a42c3b8','HIDDEN'=>'','TITLE'=>$forum_title,'TEXT'=>$forum_text,'OPTIONS'=>$forum_options)));
			$sections->attach(do_template('INSTALLER_STEP_4_SECTION',array('_GUID'=>'15e0f275f78414b6c4fe7775a1cacb23','HIDDEN'=>$hidden,'TITLE'=>$title,'TEXT'=>$text,'OPTIONS'=>$options)));
		}
	}

	// Cookie settings

	if (!GOOGLE_APPENGINE)
	{
		$title=do_lang_tempcode('COOKIE_SETTINGS');
		$text=new ocp_tempcode();
		$options=new ocp_tempcode();
		$hidden=new ocp_tempcode();
		$options->attach(make_option(do_lang_tempcode('COOKIE'),example('COOKIE_EXAMPLE','COOKIE_TEXT'),'user_cookie',$member_cookie,false,true));
		$options->attach(make_option(do_lang_tempcode('COOKIE_PASSWORD'),example('COOKIE_PASSWORD_EXAMPLE','COOKIE_PASSWORD_TEXT'),'pass_cookie',$pass_cookie,false,true));
		$options->attach(make_option(do_lang_tempcode('COOKIE_DOMAIN'),example('COOKIE_DOMAIN_EXAMPLE','COOKIE_DOMAIN_TEXT'),'cookie_domain',$cookie_domain));
		$options->attach(make_option(do_lang_tempcode('COOKIE_PATH'),example('COOKIE_PATH_EXAMPLE','COOKIE_PATH_TEXT'),'cookie_path',$cookie_path));
		$options->attach(make_option(do_lang_tempcode('COOKIE_DAYS'),example('COOKIE_DAYS_EXAMPLE','COOKIE_DAYS_TEXT'),'cookie_days',$cookie_days,false,true));
		$temp=do_template('INSTALLER_STEP_4_SECTION',array('_GUID'=>'3b9ea022164801f4b60780a4a966006f','HIDDEN'=>$hidden,'TITLE'=>$title,'TEXT'=>$text,'OPTIONS'=>$options));
		$sections->attach(do_template('INSTALLER_STEP_4_SECTION_HIDE',array('_GUID'=>'42eb3d44bcf8ef99987b6daa9e6530aa','TITLE'=>$title,'CONTENT'=>$temp)));
	}

	// ----

	$message=paragraph(do_lang_tempcode('BASIC_CONFIG'));
	if (($forum_type!='none') && ($forum_type!='ocf'))
		$message->attach(paragraph(do_lang_tempcode('FORUM_DRIVER_NATIVE_LOGIN')));

	$url='install.php?step=5';
	if (in_safe_mode()) $url.='&keep_safe_mode=1';

	$hidden=build_keep_post_fields();
	return do_template('INSTALLER_STEP_4',array(
		'_GUID'=>'73c3ac0a7108709b74b2e89cae30be12',
		'URL'=>$url,
		'JS'=>$js,
		'HIDDEN'=>$hidden,
		'MESSAGE'=>$message,
		'LANG'=>$INSTALL_LANG,
		'DB_TYPE'=>post_param('db_type'),
		'FORUM_TYPE'=>$forum_type,
		'BOARD_PATH'=>$board_path,
		'SECTIONS'=>$sections,
		'MAX'=>strval(post_param_integer('max',1000)),
	));
}

/**
 * Fifth installation step.
 *
 * @return tempcode		Progress report / UI
 */
function step_5()
{
	if (count($_POST)==0) exit(do_lang('INST_POST_ERROR'));

	if (function_exists('set_time_limit')) @set_time_limit(180);

	$url='install.php?step=6';
	if (in_safe_mode()) $url.='&keep_safe_mode=1';

	$use_msn=post_param_integer('use_msn',0);
	if ($use_msn==0) $use_msn=post_param_integer('use_multi_db',0);
	if ($use_msn==0) // If not on a multi-site-network, forum access is the same as site access.
	{
		$_POST['db_forums']=$_POST['db_site'];
		$_POST['db_forums_host']=$_POST['db_site_host'];
		$_POST['db_forums_user']=$_POST['db_site_user'];
		$_POST['db_forums_password']=$_POST['db_site_password'];
		$_POST['ocf_table_prefix']=array_key_exists('table_prefix',$_POST)?$_POST['table_prefix']:'ocp_';
	}

	// Check cookie settings. IF THIS CODE IS CHANGED ALSO CHANGE COPY&PASTED CODE IN CONFIG_EDITOR.PHP
	$cookie_path=post_param('cookie_path');
	$cookie_domain=trim(post_param('cookie_domain'));
	$base_url=post_param('base_url');
	if (strpos($base_url,'://')===false) $base_url='http://'.$base_url;
	if (substr($base_url,-1)=='/') $base_url=substr($base_url,0,strlen($base_url)-1);
	$url_parts=parse_url($base_url);
	if (!array_key_exists('host',$url_parts)) $url_parts['host']='localhost';
	if (!array_key_exists('path',$url_parts)) $url_parts['path']='';
	if (substr($url_parts['path'],-1)!='/') $url_parts['path'].='/';
	if (substr($cookie_path,-1)=='/') $cookie_path=substr($cookie_path,0,strlen($cookie_path)-1);
	if (($cookie_path!='') && (substr($url_parts['path'],0,strlen($cookie_path)+1)!=$cookie_path.'/'))
	{
		warn_exit(do_lang_tempcode('COOKIE_PATH_MUST_MATCH',escape_html($url_parts['path'])));
	}
	if ($cookie_domain!='')
	{
		if (strpos($url_parts['host'],'.')===false)
		{
			warn_exit(do_lang_tempcode('COOKIE_DOMAIN_CANT_USE'));
		}
		if (substr($cookie_domain,0,1)!='.')
		{
			warn_exit(do_lang_tempcode('COOKIE_DOMAIN_MUST_START_DOT'));
		}
		elseif (substr($url_parts['host'],1-strlen($cookie_domain))!=substr($cookie_domain,1))
		{
			warn_exit(do_lang_tempcode('COOKIE_DOMAIN_MUST_MATCH',escape_html($url_parts['host'])));
		}
	}

	$table_prefix=post_param('table_prefix');

	// Read in a temporary SITE_INFO, but only so this step has something to run with (the _config.php write doesn't use this data)
	global $SITE_INFO;
	foreach ($_POST as $key=>$val)
	{
		if (in_array($key,array(
			'ftp_password',
			'ftp_password_confirm',
			'master_password_confirm',
			'ocf_admin_password',
			'ocf_admin_password_confirm',
		))) continue;

		if (get_magic_quotes_gpc()) $val=stripslashes($val);
		if ($key=='master_password') $val='!'.md5($val.'ocp');
		$SITE_INFO[$key]=trim($val);
	}

	// Give warning if database contains data
	require_code('database');
	if (post_param_integer('confirm',0)==0)
	{
		$tmp=new database_driver(trim(post_param('db_site')),trim(post_param('db_site_host')),trim(post_param('db_site_user')),trim(post_param('db_site_password')),$table_prefix);
		$test=$tmp->query_select_value_if_there('config','c_value',array('c_name'=>'is_on_block_cache'),'',true);
		unset($tmp);
		if (!is_null($test))
		{
			global $INSTALL_LANG;
			$sections=build_keep_post_fields(array('forum_type','db_type','board_path','default_lang'));
			$sections->attach(form_input_hidden('confirm','1'));

			$url='install.php?step=5';
			if (in_safe_mode()) $url.='&keep_safe_mode=1';

			$hidden=build_keep_post_fields();
			return do_template('INSTALLER_STEP_4',array(
				'_GUID'=>'aaf0386966dd4b75c8027a6b1f7454c6',
				'URL'=>$url,
				'HIDDEN'=>$hidden,
				'MESSAGE'=>do_lang_tempcode('WARNING_DB_OVERWRITE',escape_html(get_tutorial_url('tut_upgrade'))),
				'LANG'=>$INSTALL_LANG,
				'DB_TYPE'=>post_param('db_type'),
				'FORUM_TYPE'=>post_param('forum_type'),
				'BOARD_PATH'=>post_param('board_path'),
				'SECTIONS'=>$sections,
			));
		}
	}

	// Give warning if setting up a multi-site-network to a bad database
	if (($_POST['db_forums']!=$_POST['db_site']) && (get_forum_type()=='ocf'))
	{
		$tmp=new database_driver(trim(post_param('db_forums')),trim(post_param('db_forums_host')),trim(post_param('db_forums_user')),trim(post_param('db_forums_password')),$table_prefix);
		if (is_null($tmp->query_select_value_if_there('db_meta','COUNT(*)',NULL,'',true))) warn_exit(do_lang_tempcode('MSN_FORUM_DB_NOT_OCF_ALREADY'));
	}

	// FTP uploads if we're in the quick installer
	global $FILE_ARRAY;
	$still_ftp=false;
	$log=new ocp_tempcode();
	if (@is_array($FILE_ARRAY))
	{
		$ftp_status=step_5_ftp();
		$log->attach($ftp_status[0]);
		if ($ftp_status[1]!=-1)
		{
			$url='install.php?step=5&start_from='.strval($ftp_status[1]);
			if (in_safe_mode()) $url.='&keep_safe_mode=1';
			$still_ftp=true;
		}
	}

	// If done with FTP, do the main stuff for this step
	if (!$still_ftp)
	{
		require_code('zones');
		require_code('comcode');
		require_code('themes');

		$log->attach(step_5_checks());
		$log->attach(step_5_write_config());
		$log->attach(step_5_uninstall());
		$log->attach(step_5_core());
		include_ocf();
		$log->attach(step_5_core_2());
	}

	return do_template('INSTALLER_STEP_LOG',array('_GUID'=>'83ed0405bc32fdf2cc499662bfa51bc9','PREVIOUS_STEP'=>'4','URL'=>$url,'LOG'=>$log,'HIDDEN'=>build_keep_post_fields()));
}

/**
 * Jerry-rig a site tied OCF, for basic installation, and prepping incase we switch to it.
 */
function include_ocf()
{
	require_code('forum/ocf');
	global $SITE_INFO; // We will be installing OCF to our OCP DB, regardless. It's pretty complex - at install time, we install locally - at run time, it could be over an MSN to another install
	$SITE_INFO['db_forums']=$SITE_INFO['db_site'];
	$SITE_INFO['db_forums_host']=$SITE_INFO['db_site_host'];
	$SITE_INFO['db_forums_user']=$SITE_INFO['db_site_user'];
	$SITE_INFO['db_forums_password']=$SITE_INFO['db_site_password'];
	$SITE_INFO['ocf_table_prefix']=array_key_exists('table_prefix',$SITE_INFO)?$SITE_INFO['table_prefix']:'ocp_';
	$GLOBALS['FORUM_DRIVER']=object_factory('forum_driver_ocf');
	$GLOBALS['FORUM_DB']=$GLOBALS['SITE_DB'];
	$GLOBALS['FORUM_DRIVER']->connection=$GLOBALS['SITE_DB'];
	$GLOBALS['FORUM_DRIVER']->MEMBER_ROWS_CACHED=array();
	$GLOBALS['OCF_DRIVER']=$GLOBALS['FORUM_DRIVER'];
}

/**
 * Fifth installation step: FTP upload (not used for manual installer).
 *
 * @return array		A pair: progress report/ui, and number of files uploaded so far (or -1 meaning all uploaded)
 */
function step_5_ftp()
{
	global $FILE_ARRAY,$DIR_ARRAY;

	if (count($_POST)==0) exit(do_lang('INST_POST_ERROR'));

	if (!is_suexec_like())
	{
		if (!function_exists('ftp_connect')) warn_exit(do_lang_tempcode('NO_PHP_FTP'));

		$ftp_domain=trim(post_param('ftp_domain'));
		if (strpos($ftp_domain,'ftp://')!==false)
		{
			warn_exit(do_lang_tempcode('FTP_DOMAIN_NOT_LIKE_THIS'));
		}
		$port=21;
		if (strpos($ftp_domain,':')!==false)
		{
			list($ftp_domain,$_port)=explode(':',$ftp_domain,2);
			$port=intval($_port);
		}

		$conn=false;
		if (function_exists('ftp_ssl_connect')) $conn=@ftp_ssl_connect($ftp_domain,$port);
		$ssl=($conn!==false);

		$username=trim(post_param('ftp_username'));
		$password=trim(post_param('ftp_password'));

		if (($ssl) && (@ftp_login($conn,$username,$password)===false))
		{
			$conn=false;
			$ssl=false;
		}
		if ($conn===false) $conn=ftp_connect($ftp_domain,$port);
		if ($conn===false) warn_exit(do_lang_tempcode('NO_FTP_CONNECT'));

		if ((!$ssl) && (!@ftp_login($conn,$username,$password))) warn_exit(do_lang_tempcode('NO_FTP_LOGIN',@strval($php_errormsg)));

		$ftp_folder=post_param('ftp_folder');
		if (substr($ftp_folder,-1)!='/') $ftp_folder.='/';
		if (!@ftp_chdir($conn,$ftp_folder)) warn_exit(do_lang_tempcode('NO_FTP_DIR',@strval($php_errormsg),'1'));
		$files=@ftp_nlist($conn,'.');
		if ($files===false) // :(. Weird bug on some systems
		{
			$files=array();
			if (@ftp_rename($conn,'install.php','install.php')) $files=array('install.php','data.ocp');
		}
		if (!in_array('install.php',$files)) warn_exit(do_lang_tempcode('NO_FTP_DIR',@strval($php_errormsg),'2'));

		$overwrite_ok=!file_exists(get_file_base().'/ocp_inst_tmp/tmp'); // Because if the file doesn't exist, the step completed in full - we DON'T want to overwrite if it didn't, because the step probably timed out and by refreshing we complete the step in pieces

		if (!file_exists('ocp_inst_tmp')) // If it hasn't been here before
		{
			// Make temporary directory
			if ((!in_array('ocp_inst_tmp',$files)) && (!is_string(@ftp_mkdir($conn,'ocp_inst_tmp'))))
				warn_exit(do_lang_tempcode('NO_FTP_ACCESS'));
			@ftp_site($conn,'CHMOD 0777 ocp_inst_tmp');
		}
		if (!is_writable_wrap('ocp_inst_tmp')) warn_exit(do_lang_tempcode('MANUAL_CHMOD_TMP_FILE'));

		// Test tmp file isn't currently being used by another iteration of process (race issue, causing horrible corruption)
		$file_size_before=@filesize(get_file_base().'/ocp_inst_tmp/tmp');
		sleep(1);
		$file_size_after=@filesize(get_file_base().'/ocp_inst_tmp/tmp');
		if ($file_size_before!==$file_size_after) warn_exit(do_lang_tempcode('DATA_FILE_CONFLICT'));

		// Test tmp file isn't currently being used by another iteration of process (race issue, causing horrible corruption)
		$lock_myfile=fopen(get_file_base().'/ocp_inst_tmp/tmp','ab');
		if (!flock($lock_myfile,LOCK_EX)) warn_exit(do_lang_tempcode('DATA_FILE_CONFLICT'));
		$file_size_before=@filesize(get_file_base().'/ocp_inst_tmp/tmp');
		sleep(1);
		$file_size_after=@filesize(get_file_base().'/ocp_inst_tmp/tmp');
		if ($file_size_before!==$file_size_after) warn_exit(do_lang_tempcode('DATA_FILE_CONFLICT'));
		@flock($lock_myfile,LOCK_UN);
		fclose($lock_myfile);
	} else
	{
		$overwrite_ok=true;
		$files=array();
		if (file_exists(get_file_base().'/_config.php')) $files[]='_config.php';
	}

	// Make folders
	$langs1=get_dir_contents('lang');
	$langs2=get_dir_contents('lang_custom');
	$langs=array_merge($langs1,$langs2);
	foreach ($DIR_ARRAY as $dir)
	{
		if (strpos($dir,'/'.fallback_lang())!==false)
		{
			foreach (array_keys($langs) as $lang)
			{
				if (($lang==fallback_lang()) || (strpos($lang,'.')!==false)) continue;

				if (is_suexec_like())
				{
					@mkdir(get_file_base().'/'.str_replace('/'.fallback_lang(),'/'.$lang,$dir),0777);
					fix_permissions(get_file_base().'/'.str_replace('/'.fallback_lang(),'/'.$lang,$dir),0777);
				} else
				{
					@ftp_mkdir($conn,str_replace('/'.fallback_lang(),'/'.$lang,$dir));
					@ftp_site($conn,'CHMOD 755 '.str_replace('/'.fallback_lang(),'/'.$lang,$dir));
				}
			}
		}
		if (is_suexec_like())
		{
			@mkdir(get_file_base().'/'.$dir,0777);
			fix_permissions(get_file_base().'/'.$dir,0777);
		} else
		{
			@ftp_mkdir($conn,$dir);
			if (($dir=='exports/addons') && (!is_suexec_like()))
			{
				@ftp_site($conn,'CHMOD 777 '.$dir);
			} else
			{
				@ftp_site($conn,'CHMOD 755 '.$dir);
			}
		}
	}

	// Upload files
	$count=file_array_count();
	$php_perms=fileperms(get_file_base().'/install.php');
	$start_pos=get_param_integer('start_from',0);
	$done_all=false;
	$time_start=time();
	$max_time=intval(round(floatval(ini_get('max_execution_time'))/1.5));
	$max=post_param_integer('max',is_suexec_like()?5000:1000);
	for ($i=$start_pos;$i<$start_pos+$max;$i++)
	{
		list($filename,$contents)=file_array_get_at($i);
		if (is_string($contents))
		{
			$file_size=strlen($contents);
		} else
		{
			list($file_size,$dump_myfile,$dump_offset)=$contents;
		}

		if (($filename!='_config.php') || (!in_array('_config.php',$files)))
		{
			if (
				(($overwrite_ok) || (!file_exists(get_file_base().'/'.$filename)) || (/*@ for possible race condition reported in #53910*/@filemtime(get_file_base().'/'.$filename)<filemtime(get_file_base().'/install.php')) || (filesize(get_file_base().'/'.$filename)!=$file_size))
				&&
				(($filename!='forum/index.php') || (!file_exists(get_file_base().'/'.$filename)))
				)
			{
				if ((strpos($filename,'/'.fallback_lang().'/')!==false) && (is_string($contents)))
				{
					foreach (array_keys($langs) as $lang) // Write out all the files under language directories (as we only packed them into our installer under EN)
					{
						if (($lang==fallback_lang()) || (strpos($lang,'.')!==false)) continue;

						if (is_suexec_like())
						{
							$myfile=fopen(get_file_base().'/'.str_replace('/'.fallback_lang().'/','/'.$lang.'/',$filename),'wb');
							fwrite($myfile,$contents);
							fclose($myfile);
							fix_permissions(get_file_base().'/'.str_replace('/'.fallback_lang().'/','/'.$lang.'/',$filename),0666);
						} else
						{
							@ftp_delete($conn,str_replace('/'.fallback_lang().'/','/'.$lang.'/',$filename));
							$tmp=fopen(get_file_base().'/ocp_inst_tmp/tmp','wb');
							fwrite($tmp,$contents);
							fclose($tmp);
							ftp_put($conn,str_replace('/'.fallback_lang().'/','/'.$lang.'/',$filename),get_file_base().'/ocp_inst_tmp/tmp',FTP_BINARY);
							$mask=0;
							if (get_file_extension($filename)=='php')
							{
								if (($php_perms & 0100)==0100) // If PHP files need to be marked user executable
								{
									$mask=$mask | 0100;
								}
								if (($php_perms & 0010)==0010) // If PHP files need to be marked group executable
								{
									$mask=$mask | 0010;
								}
								if (($php_perms & 0001)==0001) // If PHP files need to be marked other executable
								{
									$mask=$mask | 0001;
								}
							}
							@ftp_site($conn,'CHMOD 0'.decoct(0644 | $mask).' '.str_replace('/'.fallback_lang().'/','/'.$lang.'/',$filename));
						}
					}
				}
				if (is_suexec_like())
				{
					$myfile=fopen(get_file_base().'/'.$filename,'wb');
					if (is_string($contents))
					{
						fwrite($myfile,$contents);
					} else
					{
						fseek($dump_myfile,$dump_offset,SEEK_SET);
						$amount_read=0;
						while ($amount_read<$file_size)
						{
							$read_amount=min(4096,$file_size-$amount_read);
							$shuttle_contents=fread($dump_myfile,$read_amount);
							fwrite($myfile,$shuttle_contents);
							$amount_read+=strlen($shuttle_contents);
						}
					}
					fclose($myfile);
					fix_permissions(get_file_base().'/'.$filename,0666);
				} else
				{
					@ftp_delete($conn,$filename);
					$tmp=fopen(get_file_base().'/ocp_inst_tmp/tmp','wb');
					if (is_string($contents))
					{
						fwrite($tmp,$contents);
					} else
					{
						fseek($dump_myfile,$dump_offset,SEEK_SET);
						$amount_read=0;
						while ($amount_read<$file_size)
						{
							$read_amount=min(4096,$file_size-$amount_read);
							$shuttle_contents=fread($dump_myfile,$read_amount);
							fwrite($tmp,$shuttle_contents);
							$amount_read+=strlen($shuttle_contents);
						}
					}
					fclose($tmp);
					if (!@ftp_put($conn,$filename,get_file_base().'/ocp_inst_tmp/tmp',FTP_BINARY))
					{
						if (strpos(@strval($php_errormsg),'bind() failed')!==false)
							warn_exit(do_lang_tempcode('FTP_FIREWALL_ERROR'));
						else
							warn_exit(@strval($php_errormsg));
					}
					$mask=0;
					if (get_file_extension($filename)=='php')
					{
						if (($php_perms & 0100)==0100) // If PHP files need to be marked user executable
						{
							$mask=$mask | 0100;
						}
						if (($php_perms & 0010)==0010) // If PHP files need to be marked group executable
						{
							$mask=$mask | 0010;
						}
						if (($php_perms & 0001)==0001) // If PHP files need to be marked other executable
						{
							$mask=$mask | 0001;
						}
					}
					@ftp_site($conn,'CHMOD '.decoct(0644 | $mask).' '.$filename);
				}
			}
		}

		if (($max_time>0) && ((time()-$time_start)>=$max_time)) break;

		if ($i+1==$count)
		{
			$done_all=true;
			break; // That's them all
		}
	}
	if (!is_suexec_like())
	{
		if (!file_exists(get_file_base().'/ocp_inst_tmp/tmp')) warn_exit(do_lang_tempcode('DOUBLE_INSTALL_DO'));
		@unlink(get_file_base().'/ocp_inst_tmp/tmp');
	}

	test_htaccess(is_suexec_like()?NULL:$conn);

	$log=new ocp_tempcode();
	if ($done_all)
	{
		// If the file user is different to the FTP user, we need to make it world writeable
		if (!is_suexec_like())
		{
			// Chmod
			global $CHMOD_ARRAY;
			$no_chmod=false;
			foreach ($CHMOD_ARRAY as $chmod)
			{
				if ((file_exists($chmod)) && (!@ftp_site($conn,'CHMOD 0777 '.$chmod))) $no_chmod=true;
			}
			$log->attach(do_template('INSTALLER_DONE_SOMETHING',array('_GUID'=>'2e4ccdd5a0b034125ee62403d5a48319','SOMETHING'=>do_lang_tempcode((!$no_chmod)?'CHMOD_PASS':'CHMOD_FAIL'))));
		}
	}

	if (!is_suexec_like())
	{
		if (function_exists('ftp_close'))
		{
			ftp_close($conn);
		}
	}
	$log->attach(do_template('INSTALLER_DONE_SOMETHING',array('_GUID'=>'1b447cee9e9aa3ad8e24530d4dceb03f','SOMETHING'=>do_lang_tempcode('FILES_TRANSFERRED',strval($i+1),strval($count)))));
	return array($log,$done_all?-1:$i);
}

/**
 * Fifth installation step: sanity checks.
 *
 * @return tempcode		Progress report / UI
 */
function step_5_checks()
{
	$log=new ocp_tempcode();

	if (count($_POST)==0) exit(do_lang('INST_POST_ERROR'));

	// Check domain
	$domain=trim(post_param('domain',''));
	if ((strstr($domain,'/')!==false) || (strstr($domain,':')!==false))
		warn_exit(do_lang_tempcode('INVALID_DOMAIN'));

	// Check path
	if (!file_exists(get_file_base().'/sources/global.php'))
		warn_exit(do_lang_tempcode('BAD_PATH'));

	$log->attach(do_template('INSTALLER_DONE_SOMETHING',array('_GUID'=>'48b15e3e8486e5654563a7c3b5e6af58','SOMETHING'=>do_lang_tempcode('GOOD_PATH'))));

	// Check permissions
	global $CHMOD_ARRAY;
	if (!file_exists(get_file_base().'/_config.php'))
	{
		$myfile=@fopen(get_file_base().'/_config.php',GOOGLE_APPENGINE?'wb':'wt');
		@fclose($myfile);
	}
	foreach ($CHMOD_ARRAY as $chmod)
	{
		test_writable($chmod);
	}

	$log->attach(do_template('INSTALLER_DONE_SOMETHING',array('_GUID'=>'e2daeaa9060623786decb008289068da','SOMETHING'=>do_lang_tempcode('FILE_PERM_GOOD'))));

	return $log;
}

/**
 * Fifth installation step: writing of configuration.
 *
 * @return tempcode		Progress report / UI
 */
function step_5_write_config()
{
	$log=new ocp_tempcode();

	$base_url=post_param('base_url');
	if (substr($base_url,-1)=='/') $base_url=substr($base_url,0,strlen($base_url)-1);

	// Open up _config.php
	$config_file='_config.php';
	$config_file_handle=fopen(get_file_base().'/'.$config_file,GOOGLE_APPENGINE?'wb':'wt');
	fwrite($config_file_handle,"<"."?php\nglobal \$SITE_INFO;\n");
	if ($config_file_handle===false)
		warn_exit(do_lang_tempcode('INSTALL_WRITE_ERROR',escape_html($config_file)));

	// Write in inputted settings
	foreach ($_POST as $key=>$val)
	{
		if (in_array($key,array(
			'ftp_password',
			'ftp_password_confirm',
			'master_password_confirm',
			'ocf_admin_password',
			'ocf_admin_password_confirm',

			'clear_existing_forums_on_install',
			'allow_reports_default',
			'board_path',
			'confirm',
			'email',
			'interest_level',
			'advertise_on',
			'forum',
			'max',
			'use_msn',
			'use_multi_db',

			'gae_live_db_site',
			'gae_live_db_site_host',
			'gae_live_db_site_user',
			'gae_live_db_site_password',
		))) continue;

		if (($key=='admin_username') && (post_param('forum_type')!='none'))
			continue;

		if ((GOOGLE_APPENGINE) && (($key=='domain') || ($key=='base_url') || (substr($key,0,9)=='db_forums')))
			continue;

		if (get_magic_quotes_gpc()) $val=stripslashes($val);
		if ($key=='master_password') $val='!'.md5($val.'ocp');
		if ($key=='base_url') $val=$base_url;
		$_val=addslashes(trim($val));
		fwrite($config_file_handle,'$SITE_INFO[\''.$key.'\']=\''.$_val."';\n");
	}

	// Derive a random session cookie name, to stop conflicts between sites
	fwrite($config_file_handle,'$SITE_INFO[\'session_cookie\']=\'ocp_session__'.preg_replace('#[^\w\d]#','',uniqid('',true))."';\n");

	// On the live GAE, we need to switch in different settings to the local dev server
	if (GOOGLE_APPENGINE)
	{
		$gae_live_code="
			if (appengine_is_live())
			{
				\$SITE_INFO['db_site']='".addslashes(post_param('gae_live_db_site'))."';
				\$SITE_INFO['db_site_host']='".addslashes(post_param('gae_live_db_site_host'))."';
				\$SITE_INFO['db_site_user']='".addslashes(post_param('gae_live_db_site_user'))."';
				\$SITE_INFO['db_site_password']='".addslashes(post_param('gae_live_db_site_password'))."';
				\$SITE_INFO['custom_file_base']='".addslashes('gs://'.post_param('gae_bucket_name'))."';
				if ((strpos(\$_SERVER['HTTP_HOST'],'.appspot.com')!==false) || (!tacit_https()))
				{
					\$SITE_INFO['custom_base_url']='".addslashes((tacit_https()?'https://':'http://').post_param('gae_bucket_name').'.storage.googleapis.com')."';
				} else // Assumes a storage.<domain> CNAME has been created
				{
					\$SITE_INFO['custom_base_url']='".addslashes((tacit_https()?'https://':'http://').'storage.')."'.\$_SERVER['HTTP_HOST'];
				}
				\$SITE_INFO['no_extra_logs']='1';
				\$SITE_INFO['no_disk_sanity_checks']='1';
				\$SITE_INFO['no_installer_checks']='1';
				\$SITE_INFO['disable_smart_decaching']='1';
			} else
			{
				\$SITE_INFO['custom_file_base']='".addslashes(get_file_base().'/data_custom/modules/google_appengine')."';
				\$SITE_INFO['custom_base_url']='".addslashes(get_base_url().'/data_custom/modules/google_appengine')."';

				// Or this for more accurate (but slower) testing (assumes app name matches bucket name)...
				//\$SITE_INFO['custom_file_base']='gs://".addslashes(post_param('gae_application'))."';
				//\$SITE_INFO['custom_base_url']='http://localhost:8080/data/modules/google_appengine/cloud_storage_proxy.php?';
			}
			\$SITE_INFO['use_mem_cache']='1';
			\$SITE_INFO['charset']='utf-8';
";
		fwrite($config_file_handle,preg_replace('#^\t\t\t#m','',$gae_live_code));
	}

	fwrite($config_file_handle,'

/**
 * Find the git branch name. This is useful for making this config file context-adaptive (i.e. dev settings vs production settings).
 *
 * @return ?ID_TEXT	Branch name (NULL: not in git)
 */
function git_repos()
{
	$path=dirname(__FILE__).\'/.git/HEAD\';
	if (!is_file($path)) return \'\';
	$lines=file($path);
	$parts=explode(\'/\',$lines[0]);
	return trim(end($parts));
}
');

	// ---

	fclose($config_file_handle);
	require_once(get_file_base().'/'.$config_file);

	global $FILE_ARRAY,$DIR_ARRAY;
	if ((@is_array($FILE_ARRAY)) && (!is_suexec_like()))
	{
		$conn=false;
		$domain=trim(post_param('ftp_domain'));
		$port=21;
		if (strpos($domain,':')!==false)
		{
			list($domain,$_port)=explode(':',$domain,2);
			$port=intval($_port);
		}
		if (function_exists('ftp_ssl_connect')) $conn=@ftp_ssl_connect($domain,$port);
		$ssl=($conn!==false);

		$username=trim(post_param('ftp_username'));
		$password=trim(post_param('ftp_password'));

		if (($ssl) && (!@ftp_login($conn,$username,$password)))
		{
			$conn=false;
			$ssl=false;
		}
		if ($conn===false) $conn=ftp_connect($domain,$port);
		if (!$ssl) ftp_login($conn,$username,$password);
		$ftp_folder=post_param('ftp_folder');
		if (substr($ftp_folder,-1)!='/') $ftp_folder.='/';
		ftp_chdir($conn,$ftp_folder);
		if (!is_suexec_like())
		{
			@ftp_site($conn,'CHMOD 666 _config.php'); // Can't be 644, because it might have been uploaded (thus not nobodies)
		}
		if (function_exists('ftp_close'))
		{
			ftp_close($conn);
		}
	}

	if (GOOGLE_APPENGINE)
	{
		// Copy in default php.ini file
		@unlink(get_file_base().'/php.ini');
		copy(get_file_base().'/data/modules/google_appengine/php.ini',get_file_base().'/php.ini');

		// Customise php.ini file
		$php_ini=file_get_contents(get_file_base().'/php.ini');
		$php_ini=str_replace('<application>',post_param('gae_application'),$php_ini);
		file_put_contents(get_file_base().'/php.ini',$php_ini);

		// Copy in default YAML files
		$dh=opendir(get_file_base().'/data/modules/google_appengine');
		while (($f=readdir($dh))!==false)
		{
			if (substr($f,-5)=='.yaml')
			{
				@unlink(get_file_base().'/'.$f);
				copy(get_file_base().'/data/modules/google_appengine/'.$f,get_file_base().'/'.$f);
			}
		}

		// Customise app.yaml file
		$app_yaml=file_get_contents(get_file_base().'/app.yaml');
		$app_yaml=preg_replace('#^application: .*$#m','application: '.post_param('gae_application'),$app_yaml);
		file_put_contents(get_file_base().'/app.yaml',$app_yaml);
	}

	$log->attach(do_template('INSTALLER_DONE_SOMETHING',array('_GUID'=>'261a1eb80baed15cbbce1a684d4a354d','SOMETHING'=>do_lang_tempcode('WROTE_CONFIGURATION'))));
	return $log;
}

/**
 * Fifth installation step: uninstallation of old install.
 *
 * @return tempcode		Progress report / UI
 */
function step_5_uninstall()
{
	$log=new ocp_tempcode();
	require_code('database_action');
	require_code('config');

	if (post_param('forum_type')!='none')
	{
		$tmp=new database_driver(get_db_forums(),get_db_forums_host(),get_db_forums_user(),get_db_forums_password(),'');
		unset($tmp);
	}

	$log->attach(do_template('INSTALLER_DONE_SOMETHING',array('_GUID'=>'dae0677246aa2f1394b90c3739490ff7','SOMETHING'=>do_lang_tempcode('DATABASE_VALID','ocPortal'))));

	// UNINSTALL STUFF

	// Delete directories
	require_code('files');
	deldir_contents('uploads/attachments',true);
	deldir_contents('uploads/attachments_thumbs',true);

	return $log;
}

/**
 * Fifth installation step: core tables.
 *
 * @return tempcode		Progress report / UI
 */
function step_5_core()
{
	$GLOBALS['SITE_DB']->drop_table_if_exists('db_meta');
	$GLOBALS['SITE_DB']->create_table('db_meta',array(
		'm_table'=>'*ID_TEXT',
		'm_name'=>'*ID_TEXT',
		'm_type'=>'ID_TEXT'
	));
	$GLOBALS['SITE_DB']->create_index('db_meta','findtransfields',array('m_type'));

	$GLOBALS['SITE_DB']->drop_table_if_exists('db_meta_indices');
	$GLOBALS['SITE_DB']->create_table('db_meta_indices',array(
		'i_table'=>'*ID_TEXT',
		'i_name'=>'*ID_TEXT',
		'i_fields'=>'*ID_TEXT',
	));

	$GLOBALS['SITE_DB']->drop_table_if_exists('translate');
	$GLOBALS['SITE_DB']->create_table('translate',array(
		'id'=>'*AUTO',
		'language'=>'*LANGUAGE_NAME',
		'importance_level'=>'SHORT_INTEGER',
		'text_original'=>'LONG_TEXT',
		'text_parsed'=>'LONG_TEXT',
		'broken'=>'BINARY',
		'source_user'=>'MEMBER'
	));
	$GLOBALS['SITE_DB']->create_index('translate','#search',array('text_original'));
	$GLOBALS['SITE_DB']->create_index('translate','importance_level',array('importance_level'));
	if (substr(get_db_type(),0,5)=='mysql')
	{
		$GLOBALS['SITE_DB']->create_index('translate','equiv_lang',array('text_original(4)'));
		$GLOBALS['SITE_DB']->create_index('translate','decache',array('text_parsed(2)'));
	}

	$GLOBALS['SITE_DB']->drop_table_if_exists('values');
	$GLOBALS['SITE_DB']->create_table('values',array(
		'the_name'=>'*ID_TEXT',
		'the_value'=>'SHORT_TEXT',
		'date_and_time'=>'TIME'
	));
	$GLOBALS['SITE_DB']->create_index('values','date_and_time',array('date_and_time'));

	$GLOBALS['SITE_DB']->drop_table_if_exists('config');
	$GLOBALS['SITE_DB']->create_table('config',array(
		'c_name'=>'*ID_TEXT',
		'c_set'=>'BINARY',
		'c_value'=>'LONG_TEXT',
		'c_needs_dereference'=>'BINARY'
	));

	// Privileges
	$GLOBALS['SITE_DB']->drop_table_if_exists('group_privileges');
	$GLOBALS['SITE_DB']->create_table('group_privileges',array(
		'group_id'=>'*INTEGER',
		'privilege'=>'*ID_TEXT',
		'the_page'=>'*ID_TEXT',
		'module_the_name'=>'*ID_TEXT',
		'category_name'=>'*ID_TEXT',
		'the_value'=>'BINARY'
	));
	$GLOBALS['SITE_DB']->create_index('group_privileges','group_id',array('group_id'));

	$GLOBALS['SITE_DB']->drop_table_if_exists('privilege_list');
	$GLOBALS['SITE_DB']->create_table('privilege_list',array(
		'p_section'=>'ID_TEXT',
		'the_name'=>'*ID_TEXT',
		'the_default'=>'*BINARY'
	));

	$GLOBALS['SITE_DB']->drop_table_if_exists('attachments');
	$GLOBALS['SITE_DB']->create_table('attachments',array(
		'id'=>'*AUTO',
		'a_member_id'=>'MEMBER',
		'a_file_size'=>'?INTEGER', // NULL means non-local. Doesn't count to quota
		'a_url'=>'SHORT_TEXT',
		'a_description'=>'SHORT_TEXT',
		'a_thumb_url'=>'SHORT_TEXT',
		'a_original_filename'=>'SHORT_TEXT',
		'a_num_downloads'=>'INTEGER',
		'a_last_downloaded_time'=>'?INTEGER',
		'a_add_time'=>'INTEGER'
	));

	$GLOBALS['SITE_DB']->drop_table_if_exists('attachment_refs');
	$GLOBALS['SITE_DB']->create_table('attachment_refs',array(
		'id'=>'*AUTO',
		'r_referer_type'=>'ID_TEXT',
		'r_referer_id'=>'ID_TEXT',
		'a_id'=>'AUTO_LINK'
	));
	$GLOBALS['SITE_DB']->create_index('attachments','ownedattachments',array('a_member_id'));
	$GLOBALS['SITE_DB']->create_index('attachments','attachmentlimitcheck',array('a_add_time'));

	return do_template('INSTALLER_DONE_SOMETHING',array('_GUID'=>'c6b6d92c670b7f1b223798ace54102f9','SOMETHING'=>do_lang_tempcode('PRIMARY_CORE_INSTALLED')));
}

/**
 * Fifth installation step: more core tables.
 *
 * @return tempcode		Progress report / UI
 */
function step_5_core_2()
{
	global $INSTALL_LANG;

	$GLOBALS['SITE_DB']->drop_table_if_exists('zones');
	$GLOBALS['SITE_DB']->create_table('zones',array(
		'zone_name'=>'*ID_TEXT',
		'zone_title'=>'SHORT_TRANS',
		'zone_default_page'=>'ID_TEXT',
		'zone_header_text'=>'SHORT_TRANS',
		'zone_theme'=>'ID_TEXT',
		'zone_require_session'=>'BINARY'
	));

	// Create default zones
	require_lang('zones');
	$trans1=insert_lang(do_lang('A_SITE_ABOUT','???'),1,NULL,false,NULL,$INSTALL_LANG);
	$trans2=insert_lang(do_lang('HEADER_TEXT_ADMINZONE'),1,NULL,false,NULL,$INSTALL_LANG);
	if (file_exists(get_file_base().'/collaboration')) $trans3=insert_lang(do_lang('HEADER_TEXT_collaboration'),1,NULL,false,NULL,$INSTALL_LANG);
	$trans4=insert_lang(do_lang('A_SITE_ABOUT','???'),1,NULL,false,NULL,$INSTALL_LANG);
	$trans6=insert_lang(do_lang('CMS'),1,NULL,false,NULL,$INSTALL_LANG);
	$GLOBALS['SITE_DB']->query_insert('zones',array('zone_name'=>'','zone_title'=>insert_lang(do_lang('_WELCOME'),1),'zone_default_page'=>'start','zone_header_text'=>$trans1,'zone_theme'=>'-1','zone_require_session'=>0));
	$GLOBALS['SITE_DB']->query_insert('zones',array('zone_name'=>'adminzone','zone_title'=>insert_lang(do_lang('ADMIN_ZONE'),1),'zone_default_page'=>'start','zone_header_text'=>$trans2,'zone_theme'=>'admin','zone_require_session'=>1));
	$GLOBALS['SITE_DB']->query_insert('zones',array('zone_name'=>'site','zone_title'=>insert_lang(do_lang('SITE'),1),'zone_default_page'=>'start','zone_header_text'=>$trans4,'zone_theme'=>'-1','zone_require_session'=>0));
	if (file_exists(get_file_base().'/collaboration')) $GLOBALS['SITE_DB']->query_insert('zones',array('zone_name'=>'collaboration','zone_title'=>insert_lang(do_lang('COLLABORATION'),1),'zone_default_page'=>'start','zone_header_text'=>$trans3,'zone_theme'=>'-1','zone_require_session'=>0));
	$GLOBALS['SITE_DB']->query_insert('zones',array('zone_name'=>'cms','zone_title'=>insert_lang(do_lang('CMS'),1),'zone_default_page'=>'cms','zone_header_text'=>$trans6,'zone_theme'=>'admin','zone_require_session'=>1));

	// Forums
	$forum_type=post_param('forum_type');
	if ($forum_type=='ocf')
	{
		$trans5=insert_lang(do_lang('FORUM'),1,NULL,false,NULL,$INSTALL_LANG);
		$GLOBALS['SITE_DB']->query_insert('zones',array('zone_name'=>'forum','zone_title'=>insert_lang(do_lang('SECTION_FORUMS'),1),'zone_default_page'=>'forumview','zone_header_text'=>$trans5,'zone_theme'=>'-1','zone_require_session'=>0));
	}

	$GLOBALS['SITE_DB']->drop_table_if_exists('modules');
	$GLOBALS['SITE_DB']->create_table('modules',array(
		'module_the_name'=>'*ID_TEXT',
		'module_author'=>'ID_TEXT',
		'module_organisation'=>'ID_TEXT',
		'module_hacked_by'=>'ID_TEXT',
		'module_hack_version'=>'?INTEGER',
		'module_version'=>'INTEGER'
	));

	$GLOBALS['SITE_DB']->drop_table_if_exists('blocks');
	$GLOBALS['SITE_DB']->create_table('blocks',array(
		'block_name'=>'*ID_TEXT',
		'block_author'=>'ID_TEXT',
		'block_organisation'=>'ID_TEXT',
		'block_hacked_by'=>'ID_TEXT',
		'block_hack_version'=>'?INTEGER',
		'block_version'=>'INTEGER'
	));

	$GLOBALS['SITE_DB']->drop_table_if_exists('sessions');
	$GLOBALS['SITE_DB']->create_table('sessions',array(
		'the_session'=>'*INTEGER',
		'last_activity'=>'TIME',
		'member_id'=>'MEMBER',
		'ip'=>'IP',
		'session_confirmed'=>'BINARY',
		'session_invisible'=>'BINARY',
		'cache_username'=>'SHORT_TEXT',
		'the_zone'=>'ID_TEXT',
		'the_page'=>'ID_TEXT',
		'the_type'=>'ID_TEXT',
		'the_id'=>'ID_TEXT',
		'the_title'=>'SHORT_TEXT'
	));
	$GLOBALS['SITE_DB']->create_index('sessions','delete_old',array('last_activity'));
	$GLOBALS['SITE_DB']->create_index('sessions','member_id',array('member_id'));
	$GLOBALS['SITE_DB']->create_index('sessions','userat',array('the_zone','the_page','the_type','the_id'));

	$GLOBALS['SITE_DB']->drop_table_if_exists('https_pages');
	$GLOBALS['SITE_DB']->create_table('https_pages',array(
		'https_page_name'=>'*ID_TEXT'
	));

	// What usergroups may view this category
	$GLOBALS['SITE_DB']->drop_table_if_exists('group_category_access');
	$GLOBALS['SITE_DB']->create_table('group_category_access',array(
		'module_the_name'=>'*ID_TEXT',
		'category_name'=>'*ID_TEXT',
		'group_id'=>'*GROUP'
	));

	$GLOBALS['SITE_DB']->drop_table_if_exists('seo_meta');
	$GLOBALS['SITE_DB']->create_table('seo_meta',array(
		'id'=>'*AUTO',
		'meta_for_type'=>'ID_TEXT',
		'meta_for_id'=>'ID_TEXT',
		'meta_keywords'=>'LONG_TRANS',
		'meta_description'=>'LONG_TRANS'
	));
	$GLOBALS['SITE_DB']->create_index('seo_meta','alt_key',array('meta_for_type','meta_for_id'));
	$GLOBALS['SITE_DB']->create_index('seo_meta','ftjoin_dmeta_keywords',array('meta_keywords'));
	$GLOBALS['SITE_DB']->create_index('seo_meta','ftjoin_dmeta_description',array('meta_description'));

	return do_template('INSTALLER_DONE_SOMETHING',array('_GUID'=>'685ebf53cf9fc3f728168fed2f01a5a1','SOMETHING'=>do_lang_tempcode('SECONDARY_CORE_INSTALLED')));
}

/**
 * Sixth installation step.
 *
 * @return tempcode		Progress report / UI
 */
function step_6()
{
	if (function_exists('set_time_limit')) @set_time_limit(180);

	if (count($_POST)==0) exit(do_lang('INST_POST_ERROR'));

	$url='install.php?step=7';
	if (in_safe_mode()) $url.='&keep_safe_mode=1';

	$log=new ocp_tempcode();

	$config_file='_config.php';
	require_once(get_file_base().'/'.$config_file);
	require_code('database');
	require_code('database_action');
   require_code('menus2');
	require_code('config');
	include_ocf();

	require_code('ocf_install');
	install_ocf();
	$log->attach(do_template('INSTALLER_DONE_SOMETHING',array('_GUID'=>'f268a7e03ca5b06ed9f62b29b1357d25','SOMETHING'=>do_lang_tempcode('INSTALLED_OCF'))));

	return do_template('INSTALLER_STEP_LOG',array('_GUID'=>'450f62a4664c67b6780228781218a8f2','PREVIOUS_STEP'=>'5','URL'=>$url,'LOG'=>$log,'HIDDEN'=>build_keep_post_fields()));
}

/**
 * Parts common to any modular installation step.
 */
function big_installation_common()
{
	if (function_exists('set_time_limit')) @set_time_limit(180);

	if (count($_POST)==0) exit(do_lang('INST_POST_ERROR'));

	$config_file='_config.php';
	require_once(get_file_base().'/'.$config_file);

	require_code('database');
	$forum_type=get_forum_type();
	require_code('forum/'.$forum_type);
	$GLOBALS['FORUM_DRIVER']=object_factory('forum_driver_'.filter_naughty_harsh($forum_type));
	if ($forum_type!='none') $GLOBALS['FORUM_DRIVER']->connection=new database_driver(get_db_forums(),get_db_forums_host(),get_db_forums_user(),get_db_forums_password(),$GLOBALS['FORUM_DRIVER']->get_drivered_table_prefix());
	$GLOBALS['FORUM_DRIVER']->MEMBER_ROWS_CACHED=array();
	$GLOBALS['FORUM_DB']=&$GLOBALS['FORUM_DRIVER']->connection;

	if (method_exists($GLOBALS['FORUM_DRIVER'],'check_db'))
	{
		if (!$GLOBALS['FORUM_DRIVER']->check_db()) warn_exit(do_lang_tempcode('INVALID_FORUM_DATABASE'));
	}

	require_code('database_action');
   require_code('menus2');
	require_code('config');
	require_code('zones2');
}

/**
 * Seventh installation step.
 *
 * @return tempcode		Progress report / UI
 */
function step_7()
{
	big_installation_common();

	$log=new ocp_tempcode();

	if (method_exists($GLOBALS['FORUM_DRIVER'],'forum_install_as_needed')) $GLOBALS['FORUM_DRIVER']->forum_install_as_needed();

	// We must install this module first
	if (reinstall_module('adminzone','admin_version'))
		$log->attach(do_template('INSTALLER_DONE_SOMETHING',array('_GUID'=>'da46e6eb9069c8f700636ab61f76f895','SOMETHING'=>do_lang_tempcode('INSTALL_MODULE','admin_version'))));
	if (reinstall_module('adminzone','admin_permissions'))
		$log->attach(do_template('INSTALLER_DONE_SOMETHING',array('_GUID'=>'11de3814d6a00a0e015466a0277fa7a1','SOMETHING'=>do_lang_tempcode('INSTALL_MODULE','admin_permissions'))));

	$modules=find_all_modules('adminzone');
	foreach ($modules as $module=>$type)
	{
		if (($module!='admin_version') && ($module!='admin_permissions'))
		{
			//echo '<!-- Installing '.escape_html($module).' -->';
			if (reinstall_module('adminzone',$module))
				$log->attach(do_template('INSTALLER_DONE_SOMETHING',array('_GUID'=>'9fafb3dd014d589fcc057bba54fc4ab3','SOMETHING'=>do_lang_tempcode('INSTALL_MODULE',escape_html($module)))));
		}
	}

	require_code('addons2');
	$addons=find_all_hooks('systems','addon_registry');
	foreach ($addons as $addon=>$place)
	{
		if ($place=='sources_custom') continue;

		reinstall_addon_soft($addon);
		$log->attach(do_template('INSTALLER_DONE_SOMETHING',array('_GUID'=>'9fafb3dd014d589fcc057bba54fc4ag3','SOMETHING'=>do_lang_tempcode('INSTALL_ADDON',escape_html($addon)))));
	}

	$url='install.php?step=8';
	if (in_safe_mode()) $url.='&keep_safe_mode=1';

	return do_template('INSTALLER_STEP_LOG',array('_GUID'=>'c016b2a364d20cf711af7e14c60a7921','PREVIOUS_STEP'=>'6','URL'=>$url,'LOG'=>$log,'HIDDEN'=>build_keep_post_fields()));
}

/**
 * Eighth installation step.
 *
 * @return tempcode		Progress report / UI
 */
function step_8()
{
	big_installation_common();

	$log=new ocp_tempcode();

	$modules=find_all_modules('site');
	foreach ($modules as $module=>$type)
	{
		if (reinstall_module('site',$module))
			$log->attach(do_template('INSTALLER_DONE_SOMETHING',array('_GUID'=>'9b3c23369e8ca719256ae44b3d42fd4c','SOMETHING'=>do_lang_tempcode('INSTALL_MODULE',escape_html($module)))));
	}

	$url='install.php?step=9';
	if (in_safe_mode()) $url.='&keep_safe_mode=1';

	return do_template('INSTALLER_STEP_LOG',array('_GUID'=>'27fad5aa7f96d26a51e6afb6b7e5c7b1','PREVIOUS_STEP'=>'7','URL'=>$url,'LOG'=>$log,'HIDDEN'=>build_keep_post_fields()));
}

/**
 * Ninth installation step.
 *
 * @return tempcode		Progress report / UI
 */
function step_9()
{
	big_installation_common();

	$log=new ocp_tempcode();

	$modules=find_all_modules('forum');
	foreach ($modules as $module=>$type)
	{
		if (reinstall_module('forum',$module))
			$log->attach(do_template('INSTALLER_DONE_SOMETHING',array('_GUID'=>'c1d95b9713006acb491b44ff6c79099c','SOMETHING'=>do_lang_tempcode('INSTALL_MODULE',escape_html($module)))));
	}
	$modules=find_all_modules('cms');
	foreach ($modules as $module=>$type)
	{
		if (reinstall_module('cms',$module))
			$log->attach(do_template('INSTALLER_DONE_SOMETHING',array('_GUID'=>'8fdbc968cae73c47d9faf3b4148ac7e1','SOMETHING'=>do_lang_tempcode('INSTALL_MODULE',escape_html($module)))));
	}

	$blocks=find_all_blocks();
	foreach ($blocks as $block=>$type)
	{
		echo '<!-- Installing block: '.$block.' -->'."\n";
		if (reinstall_block($block))
			$log->attach(do_template('INSTALLER_DONE_SOMETHING',array('_GUID'=>'dc9f833239d501f77729778b5c6681b6','SOMETHING'=>do_lang_tempcode('INSTALL_BLOCK',escape_html($block)))));
	}

	$url='install.php?step=10';
	if (in_safe_mode()) $url.='&keep_safe_mode=1';

	return do_template('INSTALLER_STEP_LOG',array('_GUID'=>'b20121b8f4f84dd8e625e3b821c753b3','PREVIOUS_STEP'=>'8','URL'=>$url,'LOG'=>$log,'HIDDEN'=>build_keep_post_fields()));
}

/**
 * Tenth installation step: wrapper and special interface.
 *
 * @return tempcode		Progress report / UI
 */
function step_10()
{
	big_installation_common();

	$log=new ocp_tempcode();
	$log->attach(step_10_populate_database());
	$log->attach(step_10_forum_stuff());

	$final=do_lang_tempcode('FINAL_INSTRUCTIONS_A');
	global $FILE_ARRAY;
	if (!@is_array($FILE_ARRAY))
	{
		$final->attach(' ');
		$final->attach(do_lang_tempcode('FINAL_INSTRUCTIONS_A_SUP'));
	}

	// Empty persistent cache
	$path=get_custom_file_base().'/caches/persistent/';
	$_dir=@opendir($path);
	if ($_dir!==false)
	{
		while (false!==($file=readdir($_dir)))
		{
			if (substr($file,-4)=='.gcd')
			{
				@unlink($path.$file);
			}
		}
		closedir($_dir);
	}

	return do_template('INSTALLER_STEP_10',array('_GUID'=>'0e50bc1b9934c32fb62fb865a3971a9b','PREVIOUS_STEP'=>'9','FINAL'=>$final,'LOG'=>$log));
}

/**
 * Tenth installation step: main.
 *
 * @return tempcode		Progress report / UI
 */
function step_10_populate_database()
{
	$log=new ocp_tempcode();

	// Make sure that any menu items here come after what we have already
	global $ADD_MENU_COUNTER;
	$ADD_MENU_COUNTER=100;

	$zones=find_all_zones();
	foreach ($zones as $zone)
	{
		if (($zone!='site') && ($zone!='adminzone') && ($zone!='forum') && ($zone!='cms'))
		{
			$modules=find_all_modules($zone);
			foreach (array_keys($modules) as $module)
			{
				if (reinstall_module($zone,$module))
					$log->attach(do_template('INSTALLER_DONE_SOMETHING',array('_GUID'=>'25eb1c88fe122ec5a817f334d5f6bc5e','SOMETHING'=>do_lang_tempcode('INSTALL_MODULE',escape_html($module)))));
			}
		}
	}
//	$log->attach(do_template('INSTALLER_DONE_SOMETHING',array('_GUID'=>'6a160da6fd9031e90b37a40aea149137','SOMETHING'=>do_lang('TABLES_CREATED','ocPortal'))));

	return $log;
}

/**
 * Tenth installation step: forum part.
 *
 * @return tempcode		Progress report / UI
 */
function step_10_forum_stuff()
{
	$log=new ocp_tempcode();

	$forum_type=post_param('forum_type');

	if ($forum_type!='none')
	{
		require_lang('ocf');
		$GLOBALS['FORUM_DRIVER']->install_create_custom_field('mobile_phone_number',20,1,0,1,0,do_lang('SPECIAL_CPF__ocp_mobile_phone_number_DESCRIPTION'),'short_text');

		$log->attach(do_template('INSTALLER_DONE_SOMETHING',array('_GUID'=>'efdbb0cbc46520fe767c6292465751a1','SOMETHING'=>do_lang_tempcode('CREATED_CUSTOM_PROFILE_FIELDS'))));
	}

	$log->attach(do_template('INSTALLER_DONE_SOMETHING',array('_GUID'=>'53facf1a7e666433d663fee2974cd02b','SOMETHING'=>do_lang_tempcode('INSTALL_COMPLETE'))));

	return $log;
}

/**
 * This function is a very important one when coding. It allows you to include a source code file (from root/sources/ or root/sources_custom/) through the proper channels.
 * You should remember this function, and not substitute anything else for it, as that will likely make your code unstable.
 * It is key to source code modularity in ocPortal.
 *
 * @param  string			The codename for the source module to load
 */
function require_code($codename)
{
	if ($codename=='mail') return;

	global $FILE_ARRAY,$REQUIRED_BEFORE;
	if (array_key_exists($codename,$REQUIRED_BEFORE)) return;

	if (!array_key_exists('type',$_GET))
	{
		if (function_exists('memory_get_usage'))
		{
			$prior=memory_get_usage();
			echo '<!-- Memory: '.number_format(memory_get_usage()).' -->'."\n";
		}
		echo '<!-- Loading code file: '.$codename.' -->'."\n";
		flush();
	}

	global $FILE_BASE;

	$path=$FILE_BASE.((strpos($codename,'.php')===false)?('/sources/'.$codename.'.php'):('/'.preg_replace('#(sources|modules|minimodules)_custom#','${1}',$codename)));
	if (!file_exists($path))
		$path=$FILE_BASE.((strpos($codename,'.php')===false)?('/sources_custom/'.$codename.'.php'):('/'.$codename));

	$REQUIRED_BEFORE[$codename]=1;
	if ((@is_array($FILE_ARRAY)) && ((!isset($_GET['keep_quick_hybrid'])) || (!file_exists($path))))
	{
		$file=file_array_get('sources/'.$codename.'.php');
		$file=str_replace('<'.'?php','',$file);
		$file=str_replace('?'.'>','',$file);
		eval($file);
		if (function_exists('init__'.str_replace('/','__',$codename))) call_user_func('init__'.str_replace('/','__',$codename));
	}
	else
	{
		if (!file_exists($path))
		{
			exit('<!DOCTYPE html>'."\n".'<html lang="EN"><head><title>Critical startup error</title></head><body><h1>ocPortal installer startup error</h1><p>A required installation file, sources/'.$codename.'.php, could not be located. This is almost always due to an incomplete upload of the ocPortal manual installation package, so please check all files are uploaded correctly.</p><p>Only once all ocPortal files are in place can the installer can function. Please note that we have a quick installer package which requires uploading only two files, so you might consider using that instead.</p><p>ocProducts maintains full documentation for all procedures and tools, especially those for installation. These may be found on the <a href="http://ocportal.com">ocPortal website</a>. If you are unable to easily solve this problem, we may be contacted from our website and can help resolve it for you.</p><hr /><p style="font-size: 0.8em">ocPortal is a website engine created by ocProducts.</p></body></html>');
		}

		require_once($path);
		if (function_exists('init__'.str_replace('/','__',$codename))) call_user_func('init__'.str_replace('/','__',$codename));
	}

	/*if (!array_key_exists('type',$_GET))	Memory usage debugging. Not safe, as can mess up Tempcode generation (mixed echos)
	{
		if (function_exists('memory_get_usage'))
		{
			echo '<!-- Memory diff for '.$codename.' was: '.number_format(memory_get_usage()-$prior).' -->'."\n";
		}
	}*/
}

/**
 * Make an object of the given class
 *
 * @param  string			The class name
 * @return object			The object
 */
function object_factory($class)
{
	return new $class;
}

/**
 * Handle GET URLs requesting embedded media files.
 */
function handle_self_referencing_embedment()
{
	// If this is self-referring to CSS or logo
	if (array_key_exists('type',$_GET))
	{
		$type=$_GET['type'];

		if ($type=='ajax_ftp_details')
		{
			header('Content-Type: text/plain');

			if (!function_exists('ftp_connect'))
			{
				echo do_lang('NO_PHP_FTP');
				exit();
			}
			$conn=false;
			$domain=trim(get_param('ftp_domain'));
			$port=21;
			if (strpos($domain,':')!==false)
			{
				list($domain,$_port)=explode(':',$domain,2);
				$port=intval($_port);
			}
			if (function_exists('ftp_ssl_connect')) $conn=@ftp_ssl_connect($domain,$port);
			$ssl=($conn!==false);
			$username=get_param('ftp_username');
			$password=get_param('ftp_password');
			$ssl=($conn!==false);
			if (($ssl) && (!@ftp_login($conn,$username,$password)))
			{
				$conn=false;
				$ssl=false;
			}
			if ($conn===false) $conn=ftp_connect($domain,$port);
			if ($conn===false)
			{
				echo do_lang('NO_FTP_CONNECT');
				exit();
			}
			if ((!$ssl) && (!@ftp_login($conn,$username,$password)))
			{
				echo do_lang('NO_FTP_LOGIN',@strval($php_errormsg));
				ftp_close($conn);
				exit();
			}
			$ftp_folder=get_param('ftp_folder');
			if (substr($ftp_folder,-1)!='/') $ftp_folder.='/';
			if (!@ftp_chdir($conn,$ftp_folder))
			{
				echo do_lang('NO_FTP_DIR',@strval($php_errormsg),'1');
				ftp_close($conn);
				exit();
			}
			$files=@ftp_nlist($conn,'.');
			if ($files===false) // :(. Weird bug on some systems
			{
				$files=array();
				if (@ftp_rename($conn,'install.php','install.php')) $files=array('install.php','data.ocp');
			}
			if (!in_array('install.php',$files)) echo do_lang('NO_FTP_DIR',@strval($php_errormsg),'2');
			ftp_close($conn);

			exit();
		}
		if ($type=='ajax_db_details')
		{
			header('Content-Type: text/plain');
			global $SITE_INFO;
			if (!isset($SITE_INFO)) $SITE_INFO=array();
			$SITE_INFO['db_type']=get_param('db_type');
			require_code('database');
			if (get_param('db_site')=='')
			{
				$db=new database_driver(get_param('db_forums'),get_param('db_forums_host'),get_param('db_forums_user'),get_param('db_forums_password'),'',true);
			} else
			{
				$db=new database_driver(get_param('db_site'),get_param('db_site_host'),get_param('db_site_user'),get_param('db_site_password'),'',true);
			}
			$connection=&$db->connection_write;
			if (count($connection)>4) // Okay, we can't be lazy anymore
			{
				call_user_func_array(array($db->static_ob,'db_get_connection'),$connection);
			}

			exit();
		}
		if ($type=='logo')
		{
			header('Content-type: image/png');
			if (!file_exists(get_file_base().'/themes/default/images/'.get_site_default_lang().'/logo/standalone_logo.png'))
			{
				$out=file_array_get('themes/default/images/'.get_site_default_lang().'/logo/standalone_logo.png');
				echo $out;
			} else
			{
				print(file_get_contents(get_file_base().'/themes/default/images/'.get_site_default_lang().'/logo/standalone_logo.png'));
				exit();
			}

			exit();
		}
		if ($type=='contract')
		{
			header('Content-type: image/png');
			if (!file_exists(get_file_base().'/themes/default/images/1x/trays/contract.png'))
			{
				$out=file_array_get('themes/default/images/1x/trays/contract.png');
				echo $out;
			} else
			{
				print(file_get_contents(get_file_base().'/themes/default/images/1x/trays/contract.png'));
				exit();
			}

			exit();
		}
		if ($type=='expand')
		{
			header('Content-type: image/png');
			if (!file_exists(get_file_base().'/themes/default/images/1x/trays/expand.png'))
			{
				$out=file_array_get('themes/default/images/1x/trays/expand.png');
				echo $out;
			} else
			{
				print(file_get_contents(get_file_base().'/themes/default/images/1x/trays/expand.png'));
				exit();
			}

			exit();
		}
		if (substr($type,0,15)=='themes/default/')
		{
			header('Content-type: image/png');
			if (!file_exists(get_file_base().'/'.$type))
			{
				$out=file_array_get($type);
				echo $out;
			} else
			{
				print(file_get_contents(get_file_base().'/'.filter_naughty($type)));
				exit();
			}

			exit();
		}
		if (($type=='css') || ($type=='css_2')/*So colours are parsed initially*/)
		{
			header('Content-Type: text/css');

			$output='';

			$css_files=array('global','forms');
			foreach ($css_files as $css_file)
			{
				if (!file_exists(get_file_base().'/themes/default/css/'.$css_file.'.css'))
				{
					$file=file_array_get('themes/default/css/'.$css_file.'.css');
				} else $file=file_get_contents(get_file_base().'/themes/default/css/'.$css_file.'.css');
				$file=preg_replace('#\{\$IMG;?\,([^,\}\']+)\}#','install.php?type=themes/default/images/${1}.png',$file);

				require_code('tempcode_compiler');
				$css=template_to_tempcode($file,0,false,'');
				$output.=$css->evaluate();
			}

			if ($type=='css')
			{
				print($output);
				exit();
			}
		}
		if ($type=='css_2')
		{
			header('Content-Type: text/css');
			if (!file_exists(get_file_base().'/themes/default/css/install.css'))
			{
				$file=file_array_get('themes/default/css/install.css');
			} else $file=file_get_contents(get_file_base().'/themes/default/css/install.css');
			$file=preg_replace('#\{\$IMG\,([^,\}\']+)\}#','themes/default/images/${1}.png',$file);

			require_code('tempcode_compiler');
			$css=template_to_tempcode($file,0,false,'');
			$output=$css->evaluate();

			print($output);
			exit();
		}

		exit();
	}
}

/**
 * Make the UI for an installer textual option.
 *
 * @param  tempcode		The human readable name for the option
 * @param  tempcode		A description of the option
 * @param  ID_TEXT		The name of the option
 * @param  string			The default/current value of the option
 * @param  boolean		Whether the options value should be kept star'red out (e.g. it is a password)
 * @param  boolean		Whether the option is required
 * @return tempcode		The option
 */
function make_option($nice_name,$description,$name,$value,$hidden=false,$required=false)
{
	if (is_null($value)) $value='';

	$_required=$required;

	if ($hidden)
	{
		$input1=do_template('INSTALLER_INPUT_PASSWORD',array('_GUID'=>'373b85cea71837a30d146df387dc2a42','REQUIRED'=>$_required,'NAME'=>$name,'VALUE'=>$value));
		$a=do_template('INSTALLER_STEP_4_SECTION_OPTION',array('_GUID'=>'455b0f61e6ce2eaf2acce2844fdd5e7a','NAME'=>$name,'INPUT'=>$input1,'NICE_NAME'=>$nice_name,'DESCRIPTION'=>$description));
		if ((substr($name,0,3)!='db_') && (substr($name,0,12)!='gae_live_db_') && ($name!='ftp_password'))
		{
			$input2=do_template('INSTALLER_INPUT_PASSWORD',array('_GUID'=>'0f15bfe5b58f3ca7830a48791f1a6a6d','REQUIRED'=>$_required,'NAME'=>$name.'_confirm','VALUE'=>$value));
			$nice_name_2=do_lang_tempcode('RELATED_FIELD',$nice_name);
			$b=do_template('INSTALLER_STEP_4_SECTION_OPTION',array('_GUID'=>'c99e7339b7ffe81318ae84953e3c03a3','NAME'=>$name,'INPUT'=>$input2,'NICE_NAME'=>$nice_name_2,'DESCRIPTION'=>do_lang_tempcode('CONFIRM_PASSWORD')));
			$a->attach($b);
		}
		return $a;
	}
	$input=do_template('INSTALLER_INPUT_LINE',array('_GUID'=>'31cdfb760d7c61de65656c5256bf2e88','REQUIRED'=>$_required,'NAME'=>$name,'VALUE'=>$value));
	return do_template('INSTALLER_STEP_4_SECTION_OPTION',array('_GUID'=>'a13131994a22b6f646e517c54a7c41d5','NAME'=>$name,'INPUT'=>$input,'NICE_NAME'=>$nice_name,'DESCRIPTION'=>$description));
}

/**
 * Make the UI for an installer tick option.
 *
 * @param  tempcode		The human readable name for the option
 * @param  tempcode		A description of the option
 * @param  ID_TEXT		The name of the option
 * @param  BINARY			The default/current value of the option
 * @return tempcode		The list of usergroups
 */
function make_tick($nice_name,$description,$name,$value)
{
	$input=do_template('INSTALLER_INPUT_TICK',array('CHECKED'=>$value==1,'NAME'=>$name));
	return do_template('INSTALLER_STEP_4_SECTION_OPTION',array('_GUID'=>'0723f86908f66da7f67ebc4cd07bff2e','NAME'=>$name,'INPUT'=>$input,'NICE_NAME'=>$nice_name,'DESCRIPTION'=>$description));
}

/**
 * Get an example string for the installer UI (abstraction).
 *
 * @param  string			The name of the example text language string (blank: none)
 * @param  string			The name of the example description language string (blank: none)
 * @return tempcode		The text
 */
function example($example,$description='')
{
	if ($example=='') return do_lang_tempcode($description);
	$it=new ocp_tempcode();
	if ($description!='')
	{
		$it->attach(do_lang_tempcode($description));
		$it->attach('<br />');
	}
	$it->attach(do_lang_tempcode('FOR_EXAMPLE',do_lang_tempcode($example)));
	return $it;
}

/**
 * Test whether a file exists and is writable.
 *
 * @param  PATH			The file path
 */
function test_writable($file)
{
	if ((!is_writable_wrap($file)) && (file_exists($file))) intelligent_write_error($file);
}

/**
 * Using the current forum driver, find the forum path.
 *
 * @param  string			What the user manually gave as the forum path (may be blank)
 * @return ?URLPATH		The answer (NULL: could not find the forum)
 */
function find_forum_path($given)
{
	$filebase=getcwd();
	$paths=$GLOBALS['FORUM_DRIVER']->install_get_path_search_list();
	if (!$GLOBALS['FORUM_DRIVER']->install_test_load_from($given))
	{
		foreach ($paths as $path)
		{
			$result=$GLOBALS['FORUM_DRIVER']->install_test_load_from($filebase.'/'.$path);
			if ($result) return $filebase.'/'.$path;
		}
	}
	return NULL;
}

/**
 * Get the contents of a directory, with support for searching the installation archive.
 *
 * @param  PATH			The directory to get the contents of
 * @param  boolean		Whether just to get .php files
 * @return array			A map of the contents (file=>dir)
 */
function get_dir_contents($dir,$php=false)
{
	$out=array();

	global $DIR_ARRAY,$FILE_ARRAY;
	if (@is_array($DIR_ARRAY))
	{
		if (!$php)
		{
			foreach ($DIR_ARRAY as $dir2)
			{
				if (strlen($dir)>=strlen($dir2)) continue;

				$stub=substr($dir2,0,strlen($dir)+1);
				if ($dir.'/'==$stub)
				{
					$extra=substr($dir2,strlen($dir)+1);

					$a=strpos($dir2,'/',strlen($dir)+1);
					if ($a===false)
					{
						$out[$extra]=$dir;
					}
				}
			}
			foreach ($FILE_ARRAY as $dir2)
			{
				if (strlen($dir)>=strlen($dir2)) continue;

				$stub=substr($dir2,0,strlen($dir)+1);
				if ($dir.'/'==$stub)
				{
					$extra=substr($dir2,strlen($dir)+1);

					$a=strpos($dir2,'/',strlen($dir)+1);
					if ($a===false)
					{
						$out[$extra]=$dir;
					}
				}
			}
		} else
		{
			$count=file_array_count();
			for ($i=0;$i<$count;$i++)
			{
				$file=$FILE_ARRAY[$i];

				if (strlen($dir)>=strlen($file)) continue;

				$stub=substr($file,0,strlen($dir)+1);
				$extra=substr($file,strlen($dir)+1);
				if (($dir.'/'==$stub) && (substr($extra,-4)=='.php'))
				{
					$a=strpos($file,'/',strlen($dir)+1);
					if ($a===false)
					{
						$out[substr($extra,0,strlen($extra)-4)]=$dir;
					}
				}
			}
		}

//		return $out;
	}

	$_dir=@opendir($dir);
	if ($_dir!==false)
	{
		while (false!==($file=readdir($_dir)))
		{
			if (($file!='index.php') && ($file!='.htaccess') && ($file!='.') && ($file!='..'))
			{
				if ($php)
				{
					if (strtolower(substr($file,-4,4))=='.php')
					{
						$file2=substr($file,0,strlen($file)-4);
						$out[$file2]=$dir;
					}
				} else $out[$file]=$dir;
			}
		}
		closedir($_dir);
	}

	return $out;
}

/**
 * Return decompressed version of the input (at time of writing, no compression being used for quick installer archiving).
 *
 * @param  string			The file in raw compressed form
 * @return string			The decompressed file
 */
function compress_filter($input)
{
	//return bzdecompress($input);
	return $input;
}

/**
 * Try and get a good .htaccess file built.
 * @param  resource		FTP connection to server
 */
function test_htaccess($conn)
{
	$clauses=array();

$clauses[]=<<<END
# Disable inaccurate security scanning (ocPortal has it's own)
<IfModule mod_security.c>
SecFilterEngine Off
SecFilterScanPOST Off
</IfModule>
END;

$php_value_ok=(substr(ocp_srv('SERVER_SOFTWARE'),0,10)!='LightSpeed');

if ($php_value_ok) $clauses[]=<<<END
# ocPortal needs uploads; many hosts leave these low
php_value post_max_size "16M"
php_value upload_max_filesize "16M"
END;

if ($php_value_ok) $clauses[]=<<<END
# Turn insecure things off
php_flag allow_url_fopen off
END;

if ($php_value_ok) $clauses[]=<<<END
php_flag register_globals off
END;

if ($php_value_ok) $clauses[]=<<<END
php_value max_input_vars "2000"
php_value mbstring.func_overload "0"
# Suhosin can cause problems on configuration and Catalogue forms, which use a lot of fields
php_value suhosin.post.max_vars "2000"
php_value suhosin.request.max_vars "2000"
php_value suhosin.cookie.max_vars "400"
php_value suhosin.cookie.max_name_length "150"
php_value suhosin.post.max_value_length "100000000"
php_value suhosin.request.max_value_length "100000000"
php_value suhosin.post.max_totalname_length "10000"
php_value suhosin.request.max_totalname_length "10000"
php_flag suhosin.cookie.encrypt off
php_flag suhosin.sql.union off
END;

if ($php_value_ok) $clauses[]=<<<END
# Put some limits up. ocPortal is stable enough not to cause problems- it'll only use higher limits when it really needs them
php_value memory_limit "128M"
END;

if ($php_value_ok) $clauses[]=<<<END
php_value max_input_time "60"
END;

/*// NB: This'll only work in PHP6+   Bad idea, will miss temp directory
$file_base=$GLOBALS['FILE_BASE'];
$clauses[]=<<<END
# Sandbox ocPortal to it's own directory
php_value open_basedir "{$file_base}"
END;
*/

$clauses[]=<<<END
<IfModule mod_deflate.c>
AddOutputFilterByType DEFLATE text/html text/plain text/xml text/css application/javascript
</IfModule>
END;

/*REWRITE RULES START*/$clauses[]=<<<END

# Needed for mod_rewrite. Disable this line if your server does not have AllowOverride permission (can be one cause of Internal Server Errors)
Options +FollowSymLinks

RewriteEngine on

# If rewrites are directing to bogus URLs, try adding a "RewriteBase /" line, or a "RewriteBase /subdir" line if you're in a subdirectory. Requirements vary from server to server.

# Anything that would point to a real file should actually be allowed to do so. If you have a "RewriteBase /subdir" command, you may need to change to "%{DOCUMENT_ROOT}/subdir/$1".
RewriteCond %{DOCUMENT_ROOT}/$1 -f [OR]
RewriteCond %{DOCUMENT_ROOT}/$1 -l [OR]
RewriteCond %{DOCUMENT_ROOT}/$1 -d
RewriteRule (.*) - [L]

# Redirect away from modules called directly by URL. Helpful as it allows you to "run" a module file in a debugger and still see it running.
RewriteRule ^([^=]*)pages/(modules|modules\_custom)/([^/]*)\.php$ $1index.php\?page=$3 [L,QSA,R]

# PG STYLE: These have a specially reduced form (no need to make it too explicit that these are Wiki+). We shouldn't shorten them too much, or the actual zone or base url might conflict
RewriteRule ^([^=]*)pg/s/([^\&\?]*)/index\.php$ $1index.php\?page=wiki&id=$2 [L,QSA]

# PG STYLE: These are standard patterns
RewriteRule ^([^=]*)pg/([^/\&\?]*)/([^/\&\?]*)/([^\&\?]*)/index\.php(.*)$ $1index.php\?page=$2&type=$3&id=$4$5 [L,QSA]
RewriteRule ^([^=]*)pg/([^/\&\?]*)/([^/\&\?]*)/index\.php(.*)$ $1index.php\?page=$2&type=$3$4 [L,QSA]
RewriteRule ^([^=]*)pg/([^/\&\?]*)/index\.php(.*)$ $1index.php\?page=$2$3 [L,QSA]
RewriteRule ^([^=]*)pg/index\.php(.*)$ $1index.php\?page=$3 [L,QSA]

# PG STYLE: Now the same as the above sets, but without any additional parameters (and thus no index.php)
RewriteRule ^([^=]*)pg/s/([^\&\?]*)$ $1index.php\?page=wiki&id=$2 [L,QSA]
RewriteRule ^([^=]*)pg/([^/\&\?]*)/([^/\&\?]*)/([^\&\?]*)/$ $1index.php\?page=$2&type=$3&id=$4 [L,QSA]
RewriteRule ^([^=]*)pg/([^/\&\?]*)/([^/\&\?]*)/([^\&\?]*)$ $1index.php\?page=$2&type=$3&id=$4 [L,QSA]
RewriteRule ^([^=]*)pg/([^/\&\?]*)/([^/\&\?]*)$ $1index.php\?page=$2&type=$3 [L,QSA]
RewriteRule ^([^=]*)pg/([^/\&\?]*)$ $1index.php\?page=$2 [L,QSA]

# PG STYLE: And these for those nasty situations where index.php was missing and we couldn't do anything about it (usually due to keep_session creeping into a semi-cached URL)
RewriteRule ^([^=]*)pg/s/([^\&\?\.]*)&(.*)$ $1index.php\?$3&page=wiki&id=$2 [L,QSA]
RewriteRule ^([^=]*)pg/([^/\&\?\.]*)/([^/\&\?\.]*)/([^/\&\?\.]*)&(.*)$ $1index.php\?$5&page=$2&type=$3&id=$4 [L,QSA]
RewriteRule ^([^=]*)pg/([^/\&\?\.]*)/([^/\&\?\.]*)&(.*)$ $1index.php\?$4&page=$2&type=$3 [L,QSA]
RewriteRule ^([^=]*)pg/([^/\&\?\.]*)&(.*)$ $1index.php\?$3&page=$2 [L,QSA]

# HTM STYLE: These have a specially reduced form (no need to make it too explicit that these are Wiki+). We shouldn't shorten them too much, or the actual zone or base url might conflict
RewriteRule ^(site|forum|adminzone|cms|collaboration)/s/([^\&\?]*)\.htm$ $1/index.php\?page=wiki&id=$2 [L,QSA]
RewriteRule ^s/([^\&\?]*)\.htm$ index\.php\?page=wiki&id=$1 [L,QSA]

# HTM STYLE: These are standard patterns
RewriteRule ^(site|forum|adminzone|cms|collaboration)/([^/\&\?]+)/([^/\&\?]*)/([^\&\?]*)\.htm$ $1/index.php\?page=$2&type=$3&id=$4 [L,QSA]
RewriteRule ^(site|forum|adminzone|cms|collaboration)/([^/\&\?]+)/([^/\&\?]*)\.htm$ $1/index.php\?page=$2&type=$3 [L,QSA]
RewriteRule ^(site|forum|adminzone|cms|collaboration)/([^/\&\?]+)\.htm$ $1/index.php\?page=$2 [L,QSA]
RewriteRule ^([^/\&\?]+)/([^/\&\?]*)/([^\&\?]*)\.htm$ index.php\?page=$1&type=$2&id=$3 [L,QSA]
RewriteRule ^([^/\&\?]+)/([^/\&\?]*)\.htm$ index.php\?page=$1&type=$2 [L,QSA]
RewriteRule ^([^/\&\?]+)\.htm$ index.php\?page=$1 [L,QSA]

# SIMPLE STYLE: These have a specially reduced form (no need to make it too explicit that these are Wiki+). We shouldn't shorten them too much, or the actual zone or base url might conflict
#RewriteRule ^(site|forum|adminzone|cms|collaboration)/s/([^\&\?]*)$ $1/index.php\?page=wiki&id=$2 [L,QSA]
#RewriteRule ^s/([^\&\?]*)$ index\.php\?page=wiki&id=$1 [L,QSA]

# SIMPLE STYLE: These are standard patterns
#RewriteRule ^(site|forum|adminzone|cms|collaboration)/([^/\&\?]+)/([^/\&\?]*)/([^\&\?]*)$ $1/index.php\?page=$2&type=$3&id=$4 [L,QSA]
#RewriteRule ^(site|forum|adminzone|cms|collaboration)/([^/\&\?]+)/([^/\&\?]*)$ $1/index.php\?page=$2&type=$3 [L,QSA]
#RewriteRule ^(site|forum|adminzone|cms|collaboration)/([^/\&\?]+)$ $1/index.php\?page=$2 [L,QSA]
#RewriteRule ^([^/\&\?]+)/([^/\&\?]*)/([^\&\?]*)$ index.php\?page=$1&type=$2&id=$3 [L,QSA]
#RewriteRule ^([^/\&\?]+)/([^/\&\?]*)$ index.php\?page=$1&type=$2 [L,QSA]
#RewriteRule ^([^/\&\?]+)$ index.php\?page=$1 [L,QSA]
/*REWRITE RULES END*/
END;

$clauses[]=<<<END
order allow,deny
# IP bans go here (leave this comment here! If this file is writeable, ocPortal will write in IP bans below, in sync with it's own DB-based banning - this makes DOS/hack attack prevention stronger)
# deny from xxx.xx.x.x (leave this comment here!)
allow from all
END;

$base=dirname(ocp_srv('SCRIPT_NAME'));
$clauses[]=<<<END
<FilesMatch !"\.(jpg|jpeg|gif|png|ico)$">
ErrorDocument 404 {$base}/index.php?page=404
</FilesMatch>
END;

	if ((is_writable_wrap(get_file_base().'/exports/addons')) && ((!file_exists(get_file_base().DIRECTORY_SEPARATOR.'.htaccess')) || (trim(file_get_contents(get_file_base().DIRECTORY_SEPARATOR.'.htaccess'))=='')))
	{
		global $HTTP_MESSAGE;

		$base_url=post_param('base_url','http://'.ocp_srv('HTTP_HOST').dirname(ocp_srv('SCRIPT_NAME')));

		foreach ($clauses as $i=>$clause)
		{
			$myfile=fopen(get_file_base().'/exports/addons/index.php',GOOGLE_APPENGINE?'wb':'wt');
			fwrite($myfile,"<"."?php
			@header('Expires: Mon, 20 Dec 1998 01:00:00 GMT');
			@header('Last-Modified: '.gmdate('D, d M Y H:i:s').' GMT');
			@header('Pragma: no-cache'); // for proxies, and also IE
			");
			fclose($myfile);

			$myfile=fopen(get_file_base().'/exports/addons'.DIRECTORY_SEPARATOR.'.htaccess',GOOGLE_APPENGINE?'wb':'wt');
			fwrite($myfile,$clause);
			fclose($myfile);
			$HTTP_MESSAGE='';
			http_download_file($base_url.'/exports/addons/index.php',NULL,false);
			if ($HTTP_MESSAGE!='200') $clauses[$i]=NULL;
			unlink(get_file_base().'/exports/addons'.DIRECTORY_SEPARATOR.'.htaccess');
		}

		$out='';
		foreach ($clauses as $i=>$clause)
		{
			if (!is_null($clause)) $out.=$clause."\n\n";
		}
		if (is_suexec_like())
		{
			@unlink(get_file_base().DIRECTORY_SEPARATOR.'.htaccess');
			$tmp=fopen(get_file_base().DIRECTORY_SEPARATOR.'.htaccess','wb');
			fwrite($tmp,$out);
			fclose($tmp);
		} else
		{
			@ftp_delete($conn,'.htaccess');
			$tmp=fopen(get_file_base().'/ocp_inst_tmp/tmp','wb');
			fwrite($tmp,$out);
			fclose($tmp);
			@ftp_put($conn,'.htaccess',get_file_base().'/ocp_inst_tmp/tmp',FTP_TEXT);
			@ftp_site($conn,'CHMOD 644 .htaccess');
		}
	}
}

