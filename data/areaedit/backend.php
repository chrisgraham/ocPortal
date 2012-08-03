<?php /*
 THIRD PARTY CODE
*/

// [NOSTRIP
// -----------------------------------------------------------------
// Copyright (C) DTLink, LLC. 
// http://www.dtlink.com and http://www.formvista.com
// -----------------------------------------------------------------
// This code is distributed under the the sames terms as Xinha
// itself. (HTMLArea license based on the BSD license) 
// 
// Please read license.txt in this package for details.
//
// All software distributed under the Licenses is provided strictly on
// an "AS IS" basis, WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESS OR
// IMPLIED, AND DTLINK LLC HEREBY DISCLAIMS ALL SUCH
// WARRANTIES, INCLUDING WITHOUT LIMITATION, ANY WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, QUIET ENJOYMENT,
// OR NON-INFRINGEMENT. 
// ------------------------------------------------------------------
// NOSTRIP]

/**
* backend.php plugin request router.
*
* Unified backend single point of entry for the PHP backend.
*
* For each plugin identified by a __plugin argument, route the
* request to the corresponding backend.php in that plugins
* directory.
*
* @package core_form_interfaces
* @author Yermo Lamers http://www.formvista.com/contact.html
* @copyright DTLink, LLC 2005
*/

// ----------------------------------------------------------------

// Find ocPortal base directory, and chdir into it
global $FILE_BASE,$RELATIVE_PATH;
$FILE_BASE=(strpos(__FILE__,'./')===false)?__FILE__:realpath(__FILE__);
$FILE_BASE=dirname($FILE_BASE);
if (!is_file($FILE_BASE.'/sources/global.php')) // Need to navigate up a level further perhaps?
{
	$RELATIVE_PATH=basename($FILE_BASE);
	$FILE_BASE=dirname($FILE_BASE);
} else
{
	$RELATIVE_PATH='';
}
@chdir($FILE_BASE);

define("AREAEDIT_INSTALL_ROOT",$FILE_BASE.'/data/areaedit');
require($FILE_BASE.'/info.php');
global $SITE_INFO;
define("AREAEDIT_BACKEND_URL",AREAEDIT_INSTALL_ROOT."/backend.php" );
require_once(AREAEDIT_INSTALL_ROOT."/ddt/ddt.php" );

/**
 * Find the path to where WYSIWYG data is stored.
 *
 * @return string			Relative path
 */
function get_custom_file_base()
{
	global $SITE_INFO;
	return isset($SITE_INFO['custom_file_base'])?$SITE_INFO['custom_file_base']:$GLOBALS['FILE_BASE'];
}

// get the request variables.

$form_vars=empty($_POST)?$_GET:$_POST;

$plugin=@$form_vars["__plugin"];

// if there is no __plugin variable we have an error.

if (is_null($plugin))
{
	exit("No __plugin variable");
}

// some sanity checking on the plugin name. Only alphanumeric characters
// and underscores allowed.

if (preg_match("/^[a-zA-Z0-9_]+\$/",$plugin)===0)
{
	exit("No");
}

// based on the __plugin variable we pass the buck to the plugin
// specific backend.php script, if one exists. 
//
// AREAEDIT_INSTALL_ROOT comes from the backends/backend_conf.php file.

$backend_path=AREAEDIT_INSTALL_ROOT."/plugins/".$plugin."/backend.php";

if (!file_exists($backend_path))
{
	exit("No backend for plugin '".$plugin."'");
}

// plugin backends assume the plugin directory itself is the current working
// directory

$plugin_dir=AREAEDIT_INSTALL_ROOT."/plugins/".$plugin;

chdir( $plugin_dir );

include_once($backend_path);

// to allow for multiple backends to be pulled in simultaneously (in some future version)
// form a plugin-unique callback name.

$callback_name=$plugin."_callback";

call_user_func_array($callback_name,array($form_vars));


