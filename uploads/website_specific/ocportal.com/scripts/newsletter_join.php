<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 You may not distribute a modified version of this file, unless it is solely as an ocPortal modification.
 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		ocportalcom
 */

// Find ocPortal base directory, and chdir into it
global $FILE_BASE,$RELATIVE_PATH;
$FILE_BASE=realpath(__FILE__);
$deep='uploads/website_specific/ocportal.com/scripts/';
$FILE_BASE=str_replace($deep,'',$FILE_BASE);
$FILE_BASE=str_replace(str_replace('/','\\',$deep),'',$FILE_BASE);
if (substr($FILE_BASE,-4)=='.php')
{
	$a=strrpos($FILE_BASE,'/');
	$b=strrpos($FILE_BASE,'\\');
	$FILE_BASE=dirname($FILE_BASE);
}
$RELATIVE_PATH='';
@chdir($FILE_BASE);

global $NON_PAGE_SCRIPT;
$NON_PAGE_SCRIPT=1;
global $FORCE_INVISIBLE_GUEST;
$FORCE_INVISIBLE_GUEST=1;
if (!file_exists($FILE_BASE.'/sources/global.php')) exit('<html><head><title>Critical startup error</title></head><body><h1>ocPortal startup error</h1><p>The second most basic ocPortal startup file, sources/global.php, could not be located. This is almost always due to an incomplete upload of the ocPortal system, so please check all files are uploaded correctly.</p><p>Once all ocPortal files are in place, ocPortal must actually be installed by running the installer. You must be seeing this message either because your system has become corrupt since installation, or because you have uploaded some but not all files from our manual installer package: the quick installer is easier, so you might consider using that instead.</p><p>ocProducts maintains full documentation for all procedures and tools, especially those for installation. These may be found on the <a href="http://ocportal.com">ocPortal website</a>. If you are unable to easily solve this problem, we may be contacted from our website and can help resolve it for you.</p><hr /><p style="font-size: 0.8em">ocPortal is a website engine created by ocProducts.</p></body></html>'); require($FILE_BASE.'/sources/global.php');

$url=get_param('url');
$email=get_param('email');
$advertise_on=get_param_integer('advertise_on',0);
$interest_level=get_param_integer('interest_level');
$lang=get_param('lang');


if ($advertise_on==1) $GLOBALS['SITE_DB']->query_insert('mayfeature',array('url'=>$url));

if (($email!='dont_sign_me_up@ocportal.com') && ($email!=''))
{
	require_code('newsletter');
	basic_newsletter_join($email,$interest_level,$lang);
}
