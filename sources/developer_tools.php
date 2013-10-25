<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.


 NOTE TO PROGRAMMERS:
   Do not edit this file. If you need to make changes, save your changed file to the appropriate *_custom folder
   **** If you ignore this advice, then your website upgrades (e.g. for bug fixes) will likely kill your changes ****

*/

/*EXTRA FUNCTIONS: (var_export)|(debug_print_backtrace)|(memory_get_usage)*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		core
 */

/**
 * Standard code module initialisation function.
 */
function init__developer_tools()
{
	global $MEMORY_PROFILING_POINTS;
	$MEMORY_PROFILING_POINTS=array();
}

/**
 * Run some routines needed for semi-dev-mode, during startup.
 */
function semi_dev_mode_startup()
{
	global $SEMI_DEV_MODE,$DEV_MODE;
	if ($SEMI_DEV_MODE)
	{
		/*if ((mt_rand(0,2)==1) && ($DEV_MODE) && (running_script('index')))	We know this works now, so let's stop messing up our development speed
		{
			require_code('caches3');
			erase_cached_templates(true); // Stop anything trying to read a template cache item (E.g. CSS, JS) that might not exist!
		}*/

		if ((strpos(ocp_srv('HTTP_REFERER'),ocp_srv('HTTP_HOST'))!==false) && (strpos(ocp_srv('HTTP_REFERER'),'keep_devtest')!==false) && (!running_script('attachment')) && (!running_script('upgrader')) && (strpos(ocp_srv('HTTP_REFERER'),'login')===false) && (is_null(get_param('keep_devtest',NULL))))
		{
			$_GET['keep_devtest']='1';
			fatal_exit('URL not constructed properly: development mode in use but keep_devtest was not specified. This indicates that links have been made without build_url (in PHP) or keep_stub (in Javascript). Whilst not fatal this time, failure to use these functions can cause problems when your site goes live. See the ocPortal codebook for more details.');
		} else $_GET['keep_devtest']='1';
	}

	global $_CREATED_FILES;
	if (isset($_CREATED_FILES)) // Comes from ocProducts custom PHP version
	{
		/**
		 * Run after-tests for debug mode, to make sure coding standards are met.
		 */
		function dev_mode_aftertests()
		{
			global $_CREATED_FILES,$_MODIFIED_FILES;

			// Use the info from ocProduct's custom PHP version to make sure that all files that were created/modified got synched as they should have been.
			foreach ($_CREATED_FILES as $file)
			{
				if ((substr($file,0,strlen(get_file_base()))==get_file_base()) && (substr($file,-4)!='.tmp') && (substr($file,-4)!='.log') && (basename($file)!='permissioncheckslog.php'))
					@exit(escape_html('File not permission-synched: '.$file));
			}
			foreach ($_MODIFIED_FILES as $file)
			{
				if ((strpos($file,'cache')===false) && (substr($file,0,strlen(get_file_base()))==get_file_base()) && (strpos($file,'/incoming/')===false) && (substr($file,-4)!='.tmp') && (substr($file,-4)!='.log') && (basename($file)!='permissioncheckslog.php'))
					@exit(escape_html('File not change-synched: '.$file));
			}

			global $TITLE_CALLED,$SCREEN_TEMPLATE_CALLED,$EXITING;
			if ((is_null($SCREEN_TEMPLATE_CALLED)) && ($EXITING==0) && (running_script('index'))) @exit(escape_html('No screen template called.'));
			if ((!$TITLE_CALLED) && ((is_null($SCREEN_TEMPLATE_CALLED)) || ($SCREEN_TEMPLATE_CALLED!='')) && ($EXITING==0) && (strpos(ocp_srv('SCRIPT_NAME'),'index.php')!==false)) @exit(escape_html('No title used on screen.'));
		}

		register_shutdown_function('dev_mode_aftertests');
	}

	if ((ocp_srv('SCRIPT_NAME')!='') && ($DEV_MODE) && (strpos(ocp_srv('SCRIPT_NAME'),'data_custom')===false))
	{
		if (@strlen(file_get_contents(ocp_srv('SCRIPT_NAME')))>4500)
		{
			fatal_exit('Entry scripts (front controllers) should not be shoved full of code.');
		}
	}
}

/**
 * Remove ocPortal's strictness, to help integration of third-party code.
 *
 * @param  boolean		Whether to also set the content type to plain-HTML
 * @param  boolean		Whether to destrictify MySQL commands over the ocPortal database driver
 */
function destrictify($change_content_type=true,$mysql_too=false)
{
	// Turn off strictness
	if ((!headers_sent()) && ($change_content_type))
		@header('Content-type: text/html; charset='.get_charset());
	$GLOBALS['SCREEN_TEMPLATE_CALLED']='';
	$GLOBALS['TITLE_CALLED']=true;
	error_reporting(E_ALL ^ E_NOTICE);
	if (function_exists('set_time_limit')) @set_time_limit(200);
	if ((get_forum_type()=='ocf') && ($mysql_too)) $GLOBALS['SITE_DB']->query('SET sql_mode=\'\'',NULL,NULL,true);
	@ini_set('ocproducts.type_strictness','0');
	@ini_set('ocproducts.xss_detect','0');
	$include_path=ini_get('include_path');
	$include_path.=PATH_SEPARATOR.'./';
	$include_path.=PATH_SEPARATOR.get_file_base().'/';
	$include_path.=PATH_SEPARATOR.get_file_base().'/sources_custom/';
	$include_path.=PATH_SEPARATOR.get_file_base().'/uploads/website_specific/';
	if (function_exists('get_zone_name'))
	{
		if (get_zone_name()!='') $include_path.=PATH_SEPARATOR.get_file_base().'/'.get_zone_name().'/';
		@ini_set('include_path',$include_path);
	}
	//disable_php_memory_limit();	Don't do this, recipe for disaster
	@ini_set('suhosin.executor.disable_emodifier','0');
	@ini_set('suhosin.executor.multiheader','0');
	$GLOBALS['NO_DB_SCOPE_CHECK']=true;
	$GLOBALS['NO_QUERY_LIMIT']=true;
}

/**
 * Add ocPortal's strictness, after finishing with third-party code. To be run optionally at some point after destrictify().
 */
function restrictify()
{
	global $_CREATED_FILES,$_MODIFIED_FILES;

	// Reset functions
	if (isset($_CREATED_FILES)) $_CREATED_FILES=array();
	if (isset($_MODIFIED_FILES)) $_MODIFIED_FILES=array();

	// Put back strictness
	error_reporting(E_ALL);
	if (function_exists('set_time_limit')) @set_time_limit(25);
	if (get_forum_type()=='ocf') $GLOBALS['SITE_DB']->query('SET sql_mode=STRICT_ALL_TABLES',NULL,NULL,true);
	if (($GLOBALS['DEV_MODE']) && (strpos(ocp_srv('SCRIPT_NAME'),'_tests')===false))
	{
		@ini_set('ocproducts.type_strictness','1');
		@ini_set('ocproducts.xss_detect','1');
	}
	if (!GOOGLE_APPENGINE)
	{
		@ini_set('include_path','');
	}
	@ini_set('suhosin.executor.disable_emodifier','1');
	@ini_set('suhosin.executor.multiheader','1');
	$GLOBALS['NO_DB_SCOPE_CHECK']=false;
	//$GLOBALS['NO_QUERY_LIMIT']=false;	Leave off, may have been set elsewhere than destrictify();
}

/**
 * Output whatever arguments are given for debugging. If possible it'll output with plain text, but if output has already started it will attach messages.
 */
function inspect()
{
	$args=func_get_args();

	_inspect($args,false);
}

/**
 * Output whatever arguments are given for debugging as text and exit. If possible it'll output with plain text, but if output has already started it will attach messages.
 */
function inspect_plain()
{
	$args=func_get_args();

	_inspect($args,true);
}

/**
 * Output whatever arguments are given for debugging. If possible it'll output with plain text, but if output has already started it will attach messages.
 *
 * @param  array			Arguments to output
 * @param  boolean		Whether to force text output
 */
function _inspect($args,$force_plain=false)
{
	$plain=headers_sent() || $force_plain || !running_script('index');

	if ($plain)
	{
		@ini_set('ocproducts.xss_detect','0');

		$GLOBALS['SCREEN_TEMPLATE_CALLED']='';

		if (!headers_sent())
		{
			header('Content-type: text/plain; charset='.get_charset());
			header('Content-Disposition: inline'); // Override what might have been set
		}

		echo 'DEBUGGING. INSPECTING VARIABLES...'."\n";
	} else
	{
		header('Content-type: text/html; charset='.get_charset());
		header('Content-Disposition: inline'); // Override what might have been set
	}

	foreach ($args as $arg_name=>$arg_value)
	{
		if (!is_string($arg_name)) $arg_name=strval($arg_name+1);

		if ($plain)
		{
			echo "\n\n".$arg_name.' is...'."\n";
			if ((is_object($arg_value) && (is_a($arg_value,'ocp_tempcode'))))
			{
				echo 'Tempcode: '.$arg_value->evaluate().' (';
				var_dump($arg_value);
				echo ')';
			} else
			{
				var_dump($arg_value);
			}
		} else
		{
			if ((is_object($arg_value) && (is_a($arg_value,'ocp_tempcode'))))
			{
				attach_message($arg_name.' is...'."\n".'Tempcode: '.$arg_value->evaluate());
			} else
			{
				attach_message($arg_name.' is...'."\n".var_export($arg_value,true));
			}
		}
	}

	if ($plain)
	{
		echo "\n\n".'--------------------'."\n\n".'STACK TRACE FOLLOWS...'."\n\n";

		debug_print_backtrace();
		exit();
	}
}

/**
 * Record the memory usage at this point.
 *
 * @param  ?string		The name of the memory point (NULL: use a simple counter)
 */
function memory_trace_point($name=NULL)
{
	global $MEMORY_PROFILING_POINTS;
	if (is_null($name)) $name='#'.integer_format(count($MEMORY_PROFILING_POINTS)+1);
	$MEMORY_PROFILING_POINTS[]=array(memory_get_usage(),$name);
}

/**
 * Output whatever memory points we collected up.
 */
function show_memory_points()
{
	@header('Content-type: text/plain; charset='.get_charset());

	@ini_set('ocproducts.xss_detect','0');

	$GLOBALS['SCREEN_TEMPLATE_CALLED']='';

	global $MEMORY_PROFILING_POINTS;
	$before=mixed();
	foreach ($MEMORY_PROFILING_POINTS as $point)
	{
		list($memory,$name)=$point;
		echo 'Memory at '.$name.' is'."\t".integer_format($memory).' (growth of '.(is_null($before)?'N/A':integer_format($memory-$before)).')'."\n";
		$before=$memory;
	}
	exit();
}

/*!*
 * Finds if a function is being run underneath another function, and exit if there is a death message to output. This function should only be used when coding.
 *
 * @param  string			The function to check running underneath
 * @param  ?string		The message to exit with (NULL: return, do not exit)
 * @return boolean		Whether we are
 */
/*function debug_running_underneath($function,$death_message=NULL)
{
	$stack=debug_backtrace();
	foreach ($stack as $level)
	{
		if (in_array($function,$level))
		{
			if (!is_null($death_message)) fatal_exit($death_message);
			return true;
		}
	}
	return false;
}*/

