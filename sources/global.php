<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.


 NOTE TO PROGRAMMERS:
   Do not edit this file. If you need to make changes, save your changed file to the appropriate *_custom folder
   **** If you ignore this advice, then your website upgrades (e.g. for bug fixes) will likely kill your changes ****

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		core
 */

// Quick JS loader
if ((array_key_exists('js_cache',$_GET)) && ($_GET['js_cache']=='1'))
{
	@ini_set('zlib.output_compression','On');

	header("Pragma: public");
	$time=400*60*60*24;
	header('Cache-Control: maxage='.strval(time()+$time));
	header('Expires: '.gmdate('D, d M Y H:i:s',time()+$time).' GMT');
	header('Last-Modified: '.gmdate('D, d M Y H:i:s',time()-$time).' GMT');

	$since=isset($_SERVER['HTTP_IF_MODIFIED_SINCE'])?$_SERVER['HTTP_IF_MODIFIED_SINCE']:'';
	if ($since!='')
	{
		header('HTTP/1.0 304 Not Modified');
		exit();
	}

	global $FILE_BASE,$SITE_INFO;

	$domain=$_SERVER['HTTP_HOST'];
	$colon_pos=strpos($domain,':');
	if ($colon_pos!==false) $domain=substr($domain,0,$colon_pos);
	$port=$_SERVER['SERVER_PORT'];
	if (($port=='') || ($port=='80') || ($port=='443'))
	{
		$base_url='http://'.$domain.str_replace('%2F','/',rawurlencode(preg_replace('#/'.preg_quote($GLOBALS['RELATIVE_PATH'],'#').'$#','',dirname($_SERVER['PHP_SELF']))));
	} else
	{
		@include($FILE_BASE.'/_config.php');
		if (array_key_exists('base_url',$SITE_INFO))
		{
			$base_url=$SITE_INFO['base_url'];
		} else
		{
			$base_url='http://'.$domain.':'.$port.str_replace('%2F','/',rawurlencode(preg_replace('#/'.preg_quote($GLOBALS['RELATIVE_PATH'],'#').'$#','',dirname($_SERVER['PHP_SELF']))));
		}
	}

	header('Content-type: text/html');
	@ini_set('ocproducts.xss_detect','0');
	exit(str_replace(array('{$BASE_URL}'),array($base_url),file_get_contents($FILE_BASE.'/themes/default/templates/QUICK_JS_LOADER.tpl')));
}

if ((strpos($_SERVER['PHP_SELF'],'/sources/')!==false) || (strpos($_SERVER['PHP_SELF'],'/sources_custom/')!==false)) exit('May not be included directly');

/**
 * This function is a very important one when coding. It allows you to include a source code file (from root/sources/ or root/sources_custom/) through the proper channels.
 * You should remember this function, and not substitute anything else for it, as that will likely make your code unstable.
 * It is key to source code modularity in ocPortal.
 *
 * @param  string			The codename for the source module to load (or a full relative path, ending with .php; if custom checking is needed, this must be the custom version)
 * @param  boolean		Whether to cleanly fail when a source file is missing
 */
function require_code($codename,$light_exit=false)
{
	$hphp=defined('HIPHOP_PHP');

	if ($hphp)
	{
		if ($codename=='tempcode')
			$codename='tempcode__runtime';
		if ($codename=='tempcode_compiler')
			$codename='tempcode_compiler__runtime';
	}

	global $REQUIRED_CODE,$FILE_BASE,$SITE_INFO;
	if (isset($REQUIRED_CODE[$codename])) return;
	$REQUIRED_CODE[$codename]=1;

	$shorthand=(strpos($codename,'.php')===false);
	if (!$shorthand)
	{
		$non_custom_codename=str_replace('_custom/','/',$codename);
		$REQUIRED_CODE[$non_custom_codename]=1;
	}

	$codename=filter_naughty($codename);

	static $mue=NULL;
	if ($mue===NULL) $mue=function_exists('memory_get_usage');
	if (($mue) && (isset($_GET['keep_show_loading'])) && ($_GET['keep_show_loading']=='1'))
	{
		if (function_exists('memory_get_usage')) // Repeated, for code quality checker; done previously, for optimisation
		{
			$before=memory_get_usage();
		}
	}

	$worked=false;

	$path_a=$FILE_BASE.'/'.($shorthand?('sources_custom/'.$codename.'.php'):$codename);
	$path_b=$FILE_BASE.'/'.($shorthand?('sources/'.$codename.'.php'):$non_custom_codename);

	$has_original=NULL;
	if (isset($GLOBALS['MEM_CACHE']))
	{
		global $CODE_OVERRIDES;
		if (!isset($CODE_OVERRIDES))
		{
			$CODE_OVERRIDES=persistent_cache_get('CODE_OVERRIDES');
			if ($CODE_OVERRIDES===NULL) $CODE_OVERRIDES=array();
		}
		if (isset($CODE_OVERRIDES[$codename]))
		{
			$has_override=$CODE_OVERRIDES[$codename];
			$has_original=$CODE_OVERRIDES['!'.$codename];
		} else
		{
			$has_override=is_file($path_a);
			$has_original=is_file($path_b);
			$CODE_OVERRIDES[$codename]=$has_override;
			$CODE_OVERRIDES['!'.$codename]=$has_original;
			persistent_cache_set('CODE_OVERRIDES',$CODE_OVERRIDES,true);
		}
	} else
	{
		$has_override=is_file($path_a);
	}

	if ((isset($SITE_INFO['safe_mode'])) && ($SITE_INFO['safe_mode']=='1')) $has_override=false;

	if (($has_override) && ((!function_exists('in_safe_mode')) || (!in_safe_mode()) || (!is_file($path_b))))
	{
		$done_init=false;
		$init_func='init__'.str_replace('/','__',str_replace('.php','',$codename));

		if (!isset($has_original)) $has_original=is_file($path_b);
		if (($path_a!=$path_b) && ($has_original))
		{
			$orig=str_replace(array('?'.'>','<'.'?php'),array('',''),file_get_contents($path_b));
			$a=file_get_contents($path_a);

			if (((strpos($codename,'.php')===false) || (strpos($a,'class Mx_')===false)) && ((function_exists('quercus_version')) || (!$hphp)))
			{
				$functions_before=get_defined_functions();
				$classes_before=get_declared_classes();
				include($path_a); // Include our overrride
				$functions_after=get_defined_functions();
				$classes_after=get_declared_classes();
				$functions_diff=array_diff($functions_after['user'],$functions_before['user']); // Our override defined these functions
				$classes_diff=array_diff($classes_after,$classes_before);

				$pure=true; // We will set this to false if it does not have all functions the main one has. If it does have all functions we know we should not run the original init, as it will almost certainly just have been the same code copy&pasted through.
				$overlaps=false;
				foreach ($functions_diff as $function) // Go through override's functions and make sure original doesn't have them: rename original's to non_overridden__ equivs.
				{
					if (strpos($orig,'function '.$function.'(')!==false) // NB: If this fails, it may be that "function\t" is in the file (you can't tell with a three-width proper tab)
					{
						$orig=str_replace('function '.$function.'(','function non_overridden__'.$function.'(',$orig);
						$overlaps=true;
					} else
					{
						$pure=false;
					}
				}
				foreach ($classes_diff as $class)
				{
					if (substr(strtolower($class),0,6)=='module') $class=ucfirst($class);
					if (substr(strtolower($class),0,4)=='hook') $class=ucfirst($class);

					if (strpos($orig,'class '.$class)!==false)
					{
						$orig=str_replace('class '.$class,'class non_overridden__'.$class,$orig);
						$overlaps=true;
					} else
					{
						$pure=false;
					}
				}

				// See if we can get away with loading init function early. If we can we do a special version of it that supports fancy code modification. Our override isn't allowed to call the non-overridden init function as it won't have been loaded up by PHP in time. Instead though we will call it ourselves if it still exists (hasn't been removed by our own init function) because it likely serves a different purpose to our code-modification init function and copy&paste coding is bad.
				$doing_code_modifier_init=function_exists($init_func);
				if ($doing_code_modifier_init)
				{
					$test=call_user_func_array($init_func,array($orig));
					if (is_string($test)) $orig=$test;
					$done_init=true;
				}

				if (!$doing_code_modifier_init && !$overlaps) // To make stack traces more helpful and help with opcode caching
				{
					include($path_b);
				} else
				{
					eval($orig); // Load up modified original
				}

				if ((!$pure) && ($doing_code_modifier_init) && (function_exists('non_overridden__init__'.str_replace('/','__',str_replace('.php','',$codename)))))
				{
					call_user_func('non_overridden__init__'.str_replace('/','__',str_replace('.php','',$codename)));
				}
			} else
			{
				// Note we load the original and then the override. This is so function_exists can be used in the overrides (as we can't support the re-definition) OR in the case of Mx_ class derivation, so that the base class is loaded first.

				if ((isset($_GET['keep_show_parse_errors'])) && ((function_exists('quercus_version')) || (!$hphp)))
				{
					@ini_set('display_errors','0');
					$orig=str_replace('?'.'>','',str_replace('<'.'?php','',file_get_contents($path_b)));
					if (eval($orig)===false)
					{
						if ((!function_exists('fatal_exit')) || ($codename=='failure')) critical_error('PASSON',@strval($php_errormsg).' [sources/'.$codename.'.php]');
						fatal_exit(@strval($php_errormsg).' [sources/'.$codename.'.php]');
					}
				} else
				{
					include($path_b);
				}
				if ((isset($_GET['keep_show_parse_errors'])) && ((function_exists('quercus_version')) || (!$hphp)))
				{
					@ini_set('display_errors','0');
					$orig=str_replace('?'.'>','',str_replace('<'.'?php','',file_get_contents($path_a)));
					if (eval($orig)===false)
					{
						if ((!function_exists('fatal_exit')) || ($codename=='failure')) critical_error('PASSON',@strval($php_errormsg).' [sources_custom/'.$codename.'.php]');
						fatal_exit(@strval($php_errormsg).' [sources_custom/'.$codename.'.php]');
					}
				} else
				{
					include($path_a);
				}
			}
		} else
		{
			if ((isset($_GET['keep_show_parse_errors'])) && ((function_exists('quercus_version')) || (!$hphp)))
			{
				@ini_set('display_errors','0');
				$orig=str_replace('?'.'>','',str_replace('<'.'?php','',file_get_contents($path_a)));
				if (eval($orig)===false)
				{
					if ((!function_exists('fatal_exit')) || ($codename=='failure')) critical_error('PASSON',@strval($php_errormsg).' [sources_custom/'.$codename.'.php]');
					fatal_exit(@strval($php_errormsg).' [sources_custom/'.$codename.'.php]');
				}
			} else
			{
				include($path_a);
			}
		}

		if (($mue) && (isset($_GET['keep_show_loading'])) && ($_GET['keep_show_loading']=='1'))
		{
			if (function_exists('memory_get_usage')) // Repeated, for code quality checker; done previously, for optimisation
			{
				print('<!-- require_code: '.htmlentities($codename).' ('.number_format(memory_get_usage()-$before).' bytes used, now at '.number_format(memory_get_usage()).') -->'."\n");
				flush();
			}
		}

		if (!$done_init)
			if (function_exists($init_func)) call_user_func($init_func);

		$worked=true;
	} else
	{
		if ((isset($_GET['keep_show_parse_errors'])) && ((function_exists('quercus_version')) || (!$hphp)))
		{
			$contents=@file_get_contents($path_b);
			if ($contents!==false)
			{
				@ini_set('display_errors','0');
				$orig=str_replace(array('?'.'>','<'.'?php'),array('',''),$contents);

				if (eval($orig)===false)
				{
					if ((!function_exists('fatal_exit')) || ($codename=='failure')) critical_error('PASSON',@strval($php_errormsg).' [sources/'.$codename.'.php]');
					fatal_exit(@strval($php_errormsg).' [sources/'.$codename.'.php]');
				}

				$worked=true;
			}
		} else
		{
			$php_errormsg='';
			@include($path_b);
			if ($php_errormsg=='') $worked=true;
		}

		if ($worked)
		{
			if (($mue) && (isset($_GET['keep_show_loading'])) && ($_GET['keep_show_loading']=='1'))
			{
				if (function_exists('memory_get_usage')) // Repeated, for code quality checker; done previously, for optimisation
				{
					print('<!-- require_code: '.htmlentities($codename).' ('.number_format(memory_get_usage()-$before).' bytes used, now at '.number_format(memory_get_usage()).') -->'."\n");
					flush();
				}
			}

			$init_func='init__'.str_replace(array('/','.php'),array('__',''),$codename);
			if (function_exists($init_func)) call_user_func($init_func);
		}
	}

	if ($worked) return;

	if ($light_exit)
	{
		warn_exit(do_lang_tempcode('MISSING_SOURCE_FILE',escape_html($codename),escape_html($path_b)));
	}
	if (!function_exists('do_lang'))
	{
		if ($codename=='critical_errors')
		{
			exit('<!DOCTYPE html>'.chr(10).'<html lang="EN"><head><title>Critical startup error</title></head><body><h1>ocPortal startup error</h1><p>The ocPortal critical error message file, sources/critical_errors.php, could not be located. This is almost always due to an incomplete upload of the ocPortal system, so please check all files are uploaded correctly.</p><p>Once all ocPortal files are in place, ocPortal must actually be installed by running the installer. You must be seeing this message either because your system has become corrupt since installation, or because you have uploaded some but not all files from our manual installer package: the quick installer is easier, so you might consider using that instead.</p><p>ocProducts maintains full documentation for all procedures and tools, especially those for installation. These may be found on the <a href="http://ocportal.com">ocPortal website</a>. If you are unable to easily solve this problem, we may be contacted from our website and can help resolve it for you.</p><hr /><p style="font-size: 0.8em">ocPortal is a website engine created by ocProducts.</p></body></html>'); require($GLOBALS['FILE_BASE'].'/sources/global.php');
		}
		critical_error('MISSING_SOURCE',$codename);
	}
	fatal_exit(do_lang_tempcode('MISSING_SOURCE_FILE',escape_html($codename),escape_html($path_b)));
}

/**
 * Require code, but without looking for sources_custom overrides
 *
 * @param  string			The codename for the source module to load
 */
function require_code_no_override($codename)
{
	global $REQUIRED_CODE;
	if (array_key_exists($codename,$REQUIRED_CODE)) return;
	$REQUIRED_CODE[$codename]=1;
	require_once(get_file_base().'/sources/'.filter_naughty($codename).'.php');
	if (function_exists('init__'.str_replace('/','__',$codename))) call_user_func('init__'.str_replace('/','__',$codename));
}

/**
 * Make an object of the given class
 *
 * @param  string			The class name
 * @param  boolean		Whether to return NULL if there is no such class
 * @return ?object		The object (NULL: no such class)
 */
function object_factory($class,$null_ok=false)
{
	if (!class_exists($class))
	{
		if ($null_ok) return NULL;
		fatal_exit(escape_html('Missing class: '.$class));
	}
	return new $class;
}

/**
 * Get the file base for your installation of ocPortal
 *
 * @return PATH			The file base, without a trailing slash
 */
function get_file_base()
{
	global $FILE_BASE;
	return $FILE_BASE;
}

/**
 * Get the file base for your installation of ocPortal.  For a shared install only, this is different to the base-url.
 *
 * @return PATH			The file base, without a trailing slash
 */
function get_custom_file_base()
{
	global $FILE_BASE,$SITE_INFO;
	if (isset($SITE_INFO['custom_file_base_stub']))
	{
		require_code('shared_installs');
		$u=current_share_user();
		if (!is_null($u))
			return $SITE_INFO['custom_file_base_stub'].'/'.$u;
	}
	return $FILE_BASE;
}

/**
 * Get the parameter put into it, with no changes. If it detects that the parameter is naughty (i.e malicious, and probably from a hacker), it will log the hack-attack and output an error message.
 * This function is designed to be called on parameters that will be embedded in a path, and defines malicious as trying to reach a parent directory using '..'. All file paths in ocPortal should be absolute
 *
 * @param  string			String to test
 * @param  boolean		Whether to just filter out the naughtyness
 * @return string			Same as input string
 */
function filter_naughty($in,$preg=false)
{
	if (strpos($in,'..')!==false)
	{
		if ($preg) return str_replace('.','',$in);

		$in=str_replace('...','',$in);
		if (strpos($in,'..')!==false)
			log_hack_attack_and_exit('PATH_HACK');
		warn_exit(do_lang_tempcode('INVALID_URL'));
	}
	return $in;
}

/**
 * This function is similar to filter_naughty, except it requires the parameter to be strictly alphanumeric. It is intended for use on text that will be put into an eval.
 *
 * @param  string			String to test
 * @param  boolean		Whether to just filter out the naughtyness
 * @return string			Same as input string
 */
function filter_naughty_harsh($in,$preg=false)
{
	if (preg_match('#^[\w\-]*$#',$in)!=0) return $in;
	if (preg_match('#^[\w\-]*/#',$in)!=0) warn_exit(do_lang_tempcode('MISSING_RESOURCE')); // Probably a relative URL underneath an SEO URL, should not really happen

	if ($preg)
	{
		return preg_replace('#[^\w\-]#','',$in);
	}
	log_hack_attack_and_exit('EVAL_HACK',$in);
	return ''; // trick to make Zend happy
}

// Useful for basic profiling
global $PAGE_START_TIME;
$PAGE_START_TIME=microtime(false);

// Unregister globals (sanitisation)
if (ini_get('register_globals')=='1')
{
	foreach ($_GET as $key=>$_)
		if ((array_key_exists($key,$GLOBALS)) && ($GLOBALS[$key]==$_GET[$key])) $GLOBALS[$key]=NULL;
	foreach ($_POST as $key=>$_)
		if ((array_key_exists($key,$GLOBALS)) && ($GLOBALS[$key]==$_POST[$key])) $GLOBALS[$key]=NULL;
	foreach ($_COOKIE as $key=>$_)
		if ((array_key_exists($key,$GLOBALS)) && ($GLOBALS[$key]==$_COOKIE[$key])) $GLOBALS[$key]=NULL;
	foreach ($_ENV as $key=>$_)
		if ((array_key_exists($key,$GLOBALS)) && ($GLOBALS[$key]==$_ENV[$key])) $GLOBALS[$key]=NULL;
	foreach ($_SERVER as $key=>$_)
		if ((array_key_exists($key,$GLOBALS)) && ($GLOBALS[$key]==$_SERVER[$key])) $GLOBALS[$key]=NULL;
	if ((isset($_SESSION)) && (is_array($_SESSION)))
	{
		foreach ($_SESSION as $key=>$_)
			if ((array_key_exists($key,$GLOBALS)) && ($GLOBALS[$key]==$_SESSION[$key])) $GLOBALS[$key]=NULL;
	}
}

// Sanitise the PHP environment some more
@ini_set('track_errors','1'); // so $php_errormsg is available
@ini_set('allow_url_fopen','0');
@ini_set('allow_url_fopen','0');
@ini_set('suhosin.executor.disable_emodifier','1'); // Extra security if suhosin is available
@ini_set('suhosin.executor.multiheader','1'); // Extra security if suhosin is available
@ini_set('suhosin.executor.disable_eval','0');
@ini_set('suhosin.executor.eval.whitelist','');
@ini_set('suhosin.executor.func.whitelist','');
@ini_set('auto_detect_line_endings','0');
@ini_set('include_path','');
@ini_set('default_socket_timeout','60');
if (function_exists('set_magic_quotes_runtime')) @set_magic_quotes_runtime(0); // @'d because it's deprecated and PHP 5.3 may give an error
@ini_set('html_errors','1');
@ini_set('docref_root','http://www.php.net/manual/en/');
@ini_set('docref_ext','.php');

// Get ready for some global variables
global $REQUIRED_CODE,$CURRENT_SHARE_USER,$PURE_POST,$NO_QUERY_LIMIT,$NO_QUERY_LIMIT,$IN_MINIKERNEL_VERSION;
/** Details of what code files have been loaded up.
 * @global array $REQUIRED_CODE
 */
$REQUIRED_CODE=array();
/** If running on a shared-install, this is the identifying name of the site that is being called up.
 * @global ?ID_TEXT $CURRENT_SHARE_USER
 */
if ((!isset($CURRENT_SHARE_USER)) || (isset($_SERVER['REQUEST_METHOD'])))
	$CURRENT_SHARE_USER=NULL;
/** A copy of the POST parameters, as passed initially to PHP (needed for hash checks with some IPN systems).
 * @global array $PURE_POST
 */
$PURE_POST=$_POST;
$NO_QUERY_LIMIT=false;
$IN_MINIKERNEL_VERSION=0;

// Critical error reporting system
global $FILE_BASE;
if (is_file($FILE_BASE.'/sources_custom/critical_errors.php'))
{
	require($FILE_BASE.'/sources_custom/critical_errors.php');
} else
{
	$php_errormsg='';
	@include($FILE_BASE.'/sources/critical_errors.php');
	if ($php_errormsg!='')
	{
		exit('<!DOCTYPE html>'.chr(10).'<html lang="EN"><head><title>Critical startup error</title></head><body><h1>ocPortal startup error</h1><p>The third most basic ocPortal startup file, sources/critical_errors.php, could not be located. This is almost always due to an incomplete upload of the ocPortal system, so please check all files are uploaded correctly.</p><p>Once all ocPortal files are in place, ocPortal must actually be installed by running the installer. You must be seeing this message either because your system has become corrupt since installation, or because you have uploaded some but not all files from our manual installer package: the quick installer is easier, so you might consider using that instead.</p><p>ocProducts maintains full documentation for all procedures and tools, especially those for installation. These may be found on the <a href="http://ocportal.com">ocPortal website</a>. If you are unable to easily solve this problem, we may be contacted from our website and can help resolve it for you.</p><hr /><p style="font-size: 0.8em">ocPortal is a website engine created by ocProducts.</p></body></html>');
	}
}

// Load up config file
global $SITE_INFO;
/** Site base configuration settings.
 * @global array $SITE_INFO
 */
$SITE_INFO=array();
@include($FILE_BASE.'/_config.php');
if (count($SITE_INFO)==0)
{
	if ((!is_file($FILE_BASE.'/_config.php')) || (filesize($FILE_BASE.'/_config.php')==0))
		critical_error('INFO.PHP');
	critical_error('INFO.PHP_CORRUPTED');
}

// Are we in a compiled version of PHP?
if ((strpos(PHP_VERSION,'hiphop')!==false) || (array_key_exists('ZERO_HOME',$_ENV)) || (function_exists('quercus_version')) || (defined('PHALANGER')) || (defined('ROADSEND_PHPC')) || ((array_key_exists('force_no_eval',$SITE_INFO)) && ($SITE_INFO['force_no_eval']=='1')))
	define('HIPHOP_PHP','1');

get_custom_file_base(); // Make sure $CURRENT_SHARE_USER is set if it is a shared site, so we can use CURRENT_SHARE_USER as an indicator of it being one.

// Pass on to next bootstrap level
require_code('global2');
