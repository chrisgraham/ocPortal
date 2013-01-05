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

// ocPortal can install basically from the real final code, except for...
//	-- global.php
//	-- global2.php
//	-- users.php
//	--  things that depend on functionality of those that hasn't been emulated here
// This file emulates cut-down versions of the code in those files, for the most part.
// Once ocPortal is installed, this file is never used.

/**
 * Standard code module initialisation function.
 */
function init__minikernel()
{
	if ((!array_key_exists('REQUEST_URI',$_SERVER)) && (!array_key_exists('REQUEST_URI',$_ENV)))
	{
		$_SERVER['REQUEST_URI']=$_SERVER['PHP_SELF'];
		$first=true;
		foreach ($_GET as $key=>$val)
		{
			$_SERVER['REQUEST_URI'].=$first?'?':'&';
			$_SERVER['REQUEST_URI'].=urlencode($key).'='.urlencode($val);
			$first=false;
		}
	}

	global $EXITING;
	$EXITING=NULL;

	global $MICRO_BOOTUP;
	$MICRO_BOOTUP=0;

	global $XSS_DETECT,$LAX_COMCODE;
	$XSS_DETECT=false;
	$LAX_COMCODE=false;

	set_error_handler('ocportal_error_handler');
	if (function_exists('error_get_last')) register_shutdown_function('catch_fatal_errors');
	@ini_set('track_errors','1');
	$GLOBALS['SUPPRESS_ERROR_DEATH']=false;

	@ini_set('ocproducts.type_strictness','1');

	@ini_set('date.timezone','Greenwich');

	@header('Expires: Mon, 20 Dec 1998 01:00:00 GMT');
	@header('Last-Modified: '.gmdate('D, d M Y H:i:s').' GMT');
	//@header('Cache-Control: no-cache, must-revalidate'); // DISABLED AS MAKES IE RELOAD ON 'BACK' AND LOSE FORM CONTENTS
	@header('Pragma: no-cache'); // for proxies, and also IE
}

/**
 * Provides a hook for file synchronisation between mirrored servers. Called after any file creation, deletion or edit.
 *
 * @param  PATH				File/directory name to sync on (full path)
 */
function sync_file($filename)
{
}

/**
 * Return a debugging back-trace of the current execution stack. Use this for debugging purposes.
 *
 * @return tempcode		Debugging backtrace
 */
function get_html_trace()
{
	$x=@ob_get_contents(); @ob_end_clean(); if (is_string($x)) @print($x);
	$GLOBALS['SUPPRESS_ERROR_DEATH']=true;
	$_trace=debug_backtrace();
	$trace=new ocp_tempcode();
	foreach ($_trace as $i=>$stage)
	{
		$traces=new ocp_tempcode();
//		if (in_array($stage['function'],array('get_html_trace','ocportal_error_handler','fatal_exit'))) continue;
		$file='';
		$line='';
		$__value=mixed();
		foreach ($stage as $key=>$__value)
		{
			if ($key=='file') $file=str_replace('\'','',$__value);
			elseif ($key=='line') $line=strval($__value);
			if ($key=='args')
			{
				$_value=new ocp_tempcode();
				foreach ($__value as $param)
				{
					if (!((is_array($param)) && (array_key_exists('GLOBALS',$param)))) // Some versions of PHP give the full environment as parameters. This will cause a recursive issue when outputting due to GLOBALS->ENV chaining.
					{
						if ((is_object($param) && (is_a($param,'ocp_tempcode'))) || (is_null($param)))
						{
							$__value=gettype($param);
						} else
						{
							@ob_start();
							var_export($param);
							$__value=ob_get_clean();
						}
						if (strlen($__value)<3000)
						{
							$_value->attach(paragraph(escape_html($__value)));
						} else
						{
							$_value=make_string_tempcode(escape_html('...'));
						}
					}
				}
			} else
			{
				$value=mixed();
				if (is_float($__value))
					$value=float_format($__value);
				elseif (is_integer($__value))
					$value=integer_format($__value);
				else $value=$__value;

				if ((is_object($value) && (is_a($value,'ocp_tempcode'))) || (is_array($value) && (strlen(serialize($value))>100)))
				{
					$_value=make_string_tempcode(escape_html(gettype($value)));
				} else
				{
					@ob_start();
					var_export($value);
					$_value=make_string_tempcode(escape_html(ob_get_contents()));
					ob_end_clean();
				}
			}
			$traces->attach(do_template('STACK_TRACE_LINE',array('_GUID'=>'a3bdbe9f0980b425f6aeac5d00fe4f96','LINE'=>$line,'FILE'=>$file,'KEY'=>ucfirst($key),'VALUE'=>$_value)));
		}
		$trace->attach(do_template('STACK_TRACE_WRAP',array('_GUID'=>'748860b0c83ea19d56de594fdc04fe12','TRACES'=>$traces)));
	}
	$GLOBALS['SUPPRESS_ERROR_DEATH']=false;

	return do_template('STACK_TRACE_HYPER_WRAP',array('_GUID'=>'da6c0ef0d8d793807d22e51555d73929','CONTENT'=>$trace,'POST'=>''));
}

/**
 * Do a clean exit, echo the header (if possible) and an error message, followed by a debugging back-trace.
 * It also adds an entry to the error log, for reference.
 *
 * @param  mixed			The error message
 */
function fatal_exit($text)
{
//	if (is_object($text)) $text=$text->evaluate();

	// To break any looping of errors
	global $EXITING;
	if ((!is_null($EXITING)) || (!class_exists('ocp_tempcode')))
	{
		if ((get_domain()=='localhost') || ((function_exists('get_member')) && (has_privilege(get_member(),'see_stack_dump'))))
		{
			die_html_trace($text);
		} else
		{
			critical_error('RELAY',is_object($text)?$text->evaluate():escape_html($text));
		}
	}
	$EXITING=1;

	$title=get_screen_title('ERROR_OCCURRED');

	$trace=get_html_trace();
	$echo=new ocp_tempcode();
	$echo->attach(do_template('FATAL_SCREEN',array('_GUID'=>'95877d427cf4e785b2f16cc71381e7eb','TITLE'=>$title,'MESSAGE'=>$text,'TRACE'=>$trace)));
	$css_url='install.php?type=css';
	$css_url_2='install.php?type=css_2';
	$logo_url='install.php?type=logo';
	$version=strval(ocp_version());
	$version.=(is_numeric(ocp_version_minor())?'.':' ').ocp_version_minor();
	if (!array_key_exists('step',$_GET))
	{
		$_GET['step']=1;
	}
	require_code('tempcode_compiler');
	$css_nocache=_do_template('default','/css/','no_cache','no_cache','EN','.css');
	$out_final=do_template('INSTALLER_HTML_WRAP',array(
		'_GUID'=>'990e78523cee0b6782e1e09d73a700a7',
		'CSS_NOCACHE'=>$css_nocache,
		'DEFAULT_FORUM'=>'',
		'PASSWORD_PROMPT'=>'',
		'CSS_URL'=>$css_url,
		'CSS_URL_2'=>$css_url_2,
		'LOGO_URL'=>$logo_url,
		'STEP'=>integer_format(intval($_GET['step'])),
		'CONTENT'=>$echo,
		'VERSION'=>$version,
	));
	$out_final->evaluate_echo();

	exit();
}

/**
 * ocPortal error catcher for fatal versions. This is hooked in only on PHP5.2 as error_get_last() only works on these versions.
 */
function catch_fatal_errors()
{
	if (!function_exists('error_get_last')) return;

	$error=error_get_last();

	if (!is_null($error))
	{
		if (substr($error['message'],0,26)=='Maximum execution time of ')
		{
			if (function_exists('i_force_refresh'))
			{
				i_force_refresh();
			}
		}

		switch($error['type'])
		{
			case E_ERROR:
			case E_CORE_ERROR:
			case E_COMPILE_ERROR:
			case E_USER_ERROR:
				$GLOBALS['SUPPRESS_ERROR_DEATH']=false; // We can't recover as we've lost our execution track. Force a nice death rather than trying to display a recoverable error.
				$GLOBALS['DYING_BADLY']=true; // Does not actually work unfortunately. @'d calls never get here at all.
				ocportal_error_handler($error['type'],$error['message'],$error['file'],$error['line']);
		}
	}
}

/**
 * ocPortal error handler (hooked into PHP error system).
 *
 * @param  integer		The error code-number
 * @param  PATH			The error message
 * @param  string			The file the error occurred in
 * @param  integer		The line the error occurred on
 * @return boolean		Always false
 */
function ocportal_error_handler($errno,$errstr,$errfile,$errline)
{
	if (error_reporting()==0) return false; // This actually tells if @ was used oddly enough. You wouldn't figure from the PHP docs.

	if ($errno==E_USER_ERROR) $errno=E_ERROR;
	if ($errno==E_PARSE) $errno=E_ERROR;
	if ($errno==E_CORE_ERROR) $errno=E_ERROR;
	if ($errno==E_COMPILE_ERROR) $errno=E_ERROR;
	if ($errno==E_CORE_WARNING) $errno=E_WARNING;
	if ($errno==E_COMPILE_WARNING) $errno=E_WARNING;
	if ($errno==E_USER_WARNING) $errno=E_WARNING;
	if ($errno==E_USER_NOTICE) $errno=E_NOTICE;

	switch ($errno)
	{
		case E_ERROR:
		case E_WARNING:
		case E_NOTICE:
			@ob_end_clean(); // We can't be doing output buffering at this point
			if (!$GLOBALS['SUPPRESS_ERROR_DEATH'])
			{
				fatal_exit('PHP ['.strval($errno).'] '.$errstr);
			} else
			{
				attach_message(protect_from_escaping($errstr),'warn');
			}
	}

	return false;
}

/**
 * Find whether the current member is a guest.
 *
 * @param  ?MEMBER		Member ID to check (NULL: current user)
 * @return boolean		Whether the current member is a guest
 */
function is_guest($member_id=NULL)
{
	return true;
}

/**
 * Find whether we are running in safe mode.
 *
 * @return boolean		Whether we are in safe mode
 */
function in_safe_mode()
{
	return get_param_integer('keep_safe_mode',0)==1;
}

/**
 * Find whether a certain script is being run to get here.
 *
 * @param  string				Script filename (canonically we want NO .php file type suffix)
 * @return boolean			Whether the script is running
 */
function running_script($is_this_running)
{
	if (substr($is_this_running,-4)!='.php') $is_this_running.='.php';
	$stripped_current_url=preg_replace('#^.*/#','',function_exists('ocp_srv')?ocp_srv('PHP_SELF'):$_SERVER['PHP_SELF']);
	return (substr($stripped_current_url,0,strlen($is_this_running))==$is_this_running);
}

/**
 * Get the character set to use. We try and be clever to allow AJAX scripts to avoid loading up language
 *
 * @return string			The character set
 */
function get_charset()
{
	if (function_exists('do_lang')) return do_lang('charset');
	global $SITE_INFO;
	$lang=array_key_exists('default_lang',$SITE_INFO)?$SITE_INFO['default_lang']:'EN';
	$path=get_file_base().'/lang_custom/'.$lang.'/global.ini';
	if (!file_exists($path)) $path=get_file_base().'/lang/'.$lang.'/global.ini';
	$file=fopen($path,'rt');
	$contents=unixify_line_format(fread($file,100));
	fclose($file);
	$matches=array();
	if (preg_match('#charset=([\w\-]+)\n#',$contents,$matches)!=0)
	{
		return strtolower($matches[1]);
	}
	return strtolower('utf-8');
}

/**
 * Echo an error message, and a debug back-trace of the current execution stack. Use this for debugging purposes.
 *
 * @param  string			An error message
 */
function die_html_trace($message)
{
	if (is_object($message)) $message=$message->evaluate();
	critical_error('PASSON',$message);
}

/**
 * This is a less-revealing alternative to fatal_exit, that is used for user-errors/common-corruption-scenarios
 *
 * @param  mixed			The error message
 */
function inform_exit($text)
{
	warn_exit($text);
}

/**
 * This is a less-revealing alternative to fatal_exit, that is used for user-errors/common-corruption-scenarios
 *
 * @param  mixed			The error message
 */
function warn_exit($text)
{
	// To break any looping of errors
	global $EXITING;
	if ((!is_null($EXITING)) || (!class_exists('ocp_tempcode')))
	{
		if ((get_domain()=='localhost') || ((function_exists('get_member')) && (has_privilege(get_member(),'see_stack_dump'))))
		{
			die_html_trace($text);
		} else
		{
			critical_error('RELAY',is_object($text)?$text->evaluate():escape_html($text));
		}
	}
	$EXITING=1;

	$title=get_screen_title('ERROR_OCCURRED');

	$echo=new ocp_tempcode();
	$echo->attach(do_template('WARN_SCREEN',array('_GUID'=>'723ede24462dfc4cd4485851819786bc','TITLE'=>$title,'TEXT'=>$text,'PROVIDE_BACK'=>false)));
	$css_url='install.php?type=css';
	$css_url_2='install.php?type=css_2';
	$logo_url='install.php?type=logo';
	$version=strval(ocp_version());
	$version.=(is_numeric(ocp_version_minor())?'.':' ').ocp_version_minor();
	if (!array_key_exists('step',$_GET))
	{
		$_GET['step']=1;
	}
	require_code('tempcode_compiler');
	$css_nocache=_do_template('default','/css/','no_cache','no_cache','EN','.css');
	$out_final=do_template('INSTALLER_HTML_WRAP',array(
		'_GUID'=>'710e7ea5c186b4c42bb3a5453dd915ed',
		'CSS_NOCACHE'=>$css_nocache,
		'DEFAULT_FORUM'=>'',
		'PASSWORD_PROMPT'=>'',
		'CSS_URL'=>$css_url,
		'CSS_URL_2'=>$css_url_2,
		'LOGO_URL'=>$logo_url,
		'STEP'=>integer_format(intval($_GET['step'])),
		'CONTENT'=>$echo,
		'VERSION'=>$version,
	));
	$out_final->evaluate_echo();

	exit();
}

/**
 * Get the major version of your installation.
 *
 * @return integer		The major version number of your installation
 */
function ocp_version()
{
	return intval(ocp_version_number());
}

/**
 * Get the full string version of ocPortal that you are running.
 *
 * @return string			The string saying the full ocPortal version number
 */
function ocp_version_pretty()
{
	return '';
}

/**
 * Get the domain the website is installed on (preferably, without any www). The domain is used for e-mail defaults amongst other things.
 *
 * @return string			The domain of the website
 */
function get_domain()
{
	global $SITE_INFO;
	if (!array_key_exists('domain',$SITE_INFO))
	{
		$SITE_INFO['domain']=ocp_srv('HTTP_HOST');
	}
	return $SITE_INFO['domain'];
}

/**
 * Get the type of forums installed.
 *
 * @return string			The type of forum installed
 */
function get_forum_type()
{
	global $SITE_INFO;
	if (!array_key_exists('forum_type',$SITE_INFO)) return 'none';
	return $SITE_INFO['forum_type'];
}

/**
 * Get the installed forum base URL.
 *
 * @return URLPATH		The installed forum base URL
 */
function get_forum_base_url()
{
	if (get_forum_type()=='none') return '';
	global $SITE_INFO;
	if (!array_key_exists('board_prefix',$SITE_INFO)) return get_base_url();
	return $SITE_INFO['board_prefix'];
}

/**
 * Get the site name.
 *
 * @return string			The name of the site
 */
function get_site_name()
{
	return '';
}

/**
 * Get the base url (the minimum fully qualified URL to our installation).
 *
 * @param  ?boolean		Whether to get the HTTPS base URL (NULL: do so only if the current page uses the HTTPS base URL)
 * @param  string			What zone this is running in
 * @return URLPATH		The base-url
 */
function get_base_url($https=NULL,$zone_for='')
{
	global $SITE_INFO;
	if (!array_key_exists('base_url',$SITE_INFO))
	{
		$domain=ocp_srv('HTTP_HOST');
		if (substr($domain,0,4)=='www.') $domain=substr($domain,4);
		$colon_pos=strpos($domain,':');
		if ($colon_pos!==false) $domain=substr($domain,0,$colon_pos);
		$pos=strpos(ocp_srv('PHP_SELF'),'install.php');
		if ($pos===false) $pos=strlen(ocp_srv('PHP_SELF')); else $pos--;
		$port=ocp_srv('SERVER_PORT');
		if (($port=='') || ($port=='80') || ($port=='443')) $port=''; else $port=':'.$port;
		$base_url=post_param('base_url','http://'.$domain.$port.substr(ocp_srv('PHP_SELF'),0,$pos));

		return $base_url.(($zone_for=='')?'':('/'.$zone_for));
	}
	return $SITE_INFO['base_url'].(($zone_for=='')?'':('/'.$zone_for));
}

/**
 * Get the base url (the minimum fully qualified URL to our personal data installation). For a shared install only, this is different to the base-url.
 *
 * @param  ?boolean		Whether to get the HTTPS base URL (NULL: do so only if the current page uses the HTTPS base URL)
 * @return URLPATH		The base-url
 */
function get_custom_base_url($https=NULL)
{
	return get_base_url($https);
}

/**
 * Log a hackattack, then displays an error message. It also attempts to send an e-mail to the staff alerting them of the hackattack.
 *
 * @param  ID_TEXT		The reason for the hack attack. This has to be a language string codename
 * @param  SHORT_TEXT	A parameter for the hack attack language string (this should be based on a unique ID, preferably)
 * @param  SHORT_TEXT	A more illustrative parameter, which may be anything (e.g. a title)
 */
function log_hack_attack_and_exit($reason,$reason_param_a='',$reason_param_b='')
{
	exit('You should not see this message. If you do, contact ocProducts and tell them a \'lhaae\' showed during installation.');
}

/**
 * Check the specified text ($a) for banned words.
 * If any are found, and the member cannot bypass the word filter, an error message is displayed.
 *
 * @param  string			The sentence to check
 * @param  ?ID_TEXT		The name of the parameter this is coming from. Certain parameters are not checked, for reasons of efficiency (avoiding loading whole word check list if not needed) (NULL: don't know param, do not check to avoid)
 * @param  boolean		Whether to avoid dying on fully blocked words (useful if importing, for instance)
 * @param  boolean		Whether to try pattern matching (this takes more resources)
 * @param  boolean		Whether to allow permission-based skipping, and length-based skipping
 * @return string			"Fixed" version
 */
function check_word_filter($a,$name=NULL,$no_die=false,$try_patterns=false,$perm_check=true)
{
	return $a;
}

/**
 * Get a value (either POST [u]or[/u] GET), or the default if neither can be found.
 *
 * @param  ID_TEXT		The name of the parameter to get
 * @param  ?string		The default value to give the parameter if the parameter value is not defined (NULL: give error on missing parameter)
 * @return ?string		The value of the parameter (NULL: not there, and default was NULL)
 */
function either_param($name,$default=NULL)
{
	$a=__param($_REQUEST,$name,$default);
	return $a;
}

/**
 * Get the value of the specified POST key, if it is found, or the default otherwise.
 *
 * @param  ID_TEXT		The name of the parameter to get
 * @param  ?string		The default value to give the parameter if the parameter value is not defined (NULL: give error on missing parameter)
 * @return ?string		The value of the parameter (NULL: not there, and default was NULL)
 */
function post_param($name,$default=NULL)
{
	$a=__param($_POST,$name,$default);
	return $a;
}

/**
 * Get the value of the specified GET key, if it is found, or the default otherwise.
 *
 * @param  ID_TEXT		The name of the parameter to get
 * @param  ?string		The default value to give the parameter if the parameter value is not defined (NULL: give error on missing parameter)
 * @return ?string		The value of the parameter (NULL: not there, and default was NULL)
 */
function get_param($name,$default=NULL)
{
	$a=__param($_GET,$name,$default);
	return $a;
}

/**
 * Helper function to load up a GET/POST parameter.
 *
 * @param  array			The array we're extracting parameters from
 * @param  ID_TEXT		The name of the parameter
 * @param  ?mixed			The default value to use for the parameter (NULL: no default)
 * @param  boolean		Whether the parameter has to be an integer
 * @param  boolean		Whether the parameter is a POST parameter
 * @return ?string		The value of the parameter (NULL: not there, and default was NULL)
 */
function __param($array,$name,$default,$must_integer=false,$is_post=false)
{
	if (!array_key_exists($name,$array)) return $default;
	$val=trim($array[$name]);
	if (get_magic_quotes_gpc()) $val=stripslashes($val);

	return $val;
}

/**
 * This function is the integeric partner of either_param, as it returns the value as an integer.
 * You should always use integer specified versions when inputting integers, for the added security that type validation allows. If the value is of the wrong type, it indicates a hack attempt and will be logged.
 *
 * @param  ID_TEXT		The name of the parameter to get
 * @param  ?mixed			The default value to give the parameter if the parameter value is not defined (NULL: give error on missing parameter)
 * @return integer		The parameter value
 */
function either_param_integer($name,$default=NULL)
{
	$ret=__param($_REQUEST,$name,($default===false)?false:(is_null($default)?NULL:strval($default)));
	if ((is_null($default)) && (($ret==='') || (is_null($ret)))) return NULL;
	return intval($ret);
}

/**
 * This function is the integeric partner of post_param, as it returns the value as an integer.
 *
 * @param  ID_TEXT		The name of the parameter to get
 * @param  ?mixed			The default value to give the parameter if the parameter value is not defined (NULL: give error on missing parameter)
 * @return integer		The parameter value
 */
function post_param_integer($name,$default=NULL)
{
	$ret=__param($_POST,$name,($default===false)?false:(is_null($default)?NULL:strval($default)));
	if ((is_null($default)) && (($ret==='') || (is_null($ret)))) return NULL;
	return intval($ret);
}

/**
 * This function is the integeric partner of get_param, as it returns the value as an integer.
 *
 * @param  ID_TEXT		The name of the parameter to get
 * @param  ?mixed			The default value to give the parameter if the parameter value is not defined (NULL: give error on missing parameter)
 * @return integer		The parameter value
 */
function get_param_integer($name,$default=NULL)
{
	$ret=__param($_GET,$name,($default===false)?false:(is_null($default)?NULL:strval($default)));
	if ((is_null($default)) && (($ret==='') || (is_null($ret)))) return NULL;
	return intval($ret);
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
	global $FILE_BASE;
	return $FILE_BASE;
}

/**
 * Get the parameter put into it, with no changes. If it detects that the parameter is naughty (i.e malicious, and probably from a hacker), it will log the hack-attack and output an error message.
 * This function is designed to be called on parameters that will be embedded in a path, and defines malicious as trying to reach a parent directory using '..'. All file paths in ocPortal should be absolute
 *
 * @param  string			String to test
 * @return string			Same as input string
 */
function filter_naughty($in)
{
	if (strpos($in,'..')!==false) exit();
	return $in;
}

/**
 * This function is similar to filter_naughty, except it requires the parameter to be strictly alphanumeric. It is intended for use on text that will be put into an eval.
 *
 * @param  string			String to test
 * @return string			Same as input string
 */
function filter_naughty_harsh($in)
{
	if (preg_match('#^[\w0-9\-]*$#',$in)!=0) return $in;
	exit();
}

/**
 * Make sure that lines are seperated by chr(10), with no chr(13)'s there at all. For Mac data, this will be a flip scenario. For Linux data this will be a null operation. For windows data this will be change from chr(13).chr(10) to just chr(10). For a realistic scenario, data could have originated on all kinds of platforms, with some editors converting, some situations being inter-platform, and general confusion. Don't make blind assumptions - use this function to clean data, then write clean code that only considers chr(10)'s.
 *
 * @param  string			The data to clean
 * @return string			The cleaned data
 */
function unixify_line_format($in)
{
	$in=str_replace(chr(13).chr(10),chr(10),$in);
	return str_replace(chr(13),chr(10),$in);
}

/**
 * Make sure that the given CSS file is loaded up.
 *
 * @sets_output_state
 *
 * @param  ID_TEXT		The CSS file required
 */
function require_css($css)
{
}


