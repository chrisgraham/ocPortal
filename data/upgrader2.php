<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		core_upgrader
 */

/* Standalone script to extract a tar file */

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

if (str_replace(array('on','true','yes'),array('1','1','1'),strtolower(ini_get('register_globals')))=='1') // Unregister globals
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

if (!function_exists('file_get_contents'))
{
	/**
	 * Get the contents of a file.
	 *
	 * @param  SHORT_TEXT	The file name.
	 * @return ~LONG_TEXT	The file contents (false: error).
	 */
	function file_get_contents($filename)
	{
		$data='';
		$file=@fopen($filename,'rb');
		if ($file)
		{
			while (!feof($file)) $data.=fread($file,1024);
			fclose($file);
		}
		return $data;
	}
}

$hashed_password=$_GET['hashed_password'];
global $SITE_INFO;
require_once($FILE_BASE.'/info.php');
if (!upgrader2_check_master_password($hashed_password)) exit('Access Denied');

// Open TAR file
$tmp_path=$_GET['tmp_path'];
if (!file_exists($tmp_path))
{
	header('Content-type: text/plain');
	exit('Temp file has disappeared ('.$tmp_path.')');
}
$tmp_path=dirname(dirname(__FILE__)).'/data_custom/upgrader.tar.tmp'; // Actually for security, we will not allow it to be configurable
$myfile=fopen($tmp_path,'rb');

$file_offset=intval($_GET['file_offset']);

$tmp_data_path=$_GET['tmp_data_path'];
if (!file_exists($tmp_data_path))
{
	header('Content-type: text/plain');
	exit('2nd temp file has disappeared ('.$tmp_data_path.')');
}
$data=unserialize(file_get_contents($tmp_data_path));
asort($data);

// Work out what we're doing
$todo=$data['todo'];

// Do the extraction
foreach ($todo as $i=>$_target_file)
{
	list($target_file,,$offset,$length,)=$_target_file;

	if ($_target_file=='data/upgrader2.php')
	{
		if ($file_offset+20<count($todo)) continue; // Only extract on last step, to avoid possible transitionary bugs between versions of this file (this is the file running and refreshing now, i.e this file!)
	} else
	{
		if ($i<$file_offset) continue;
		if ($i>$file_offset+20) break;
	}

	// Make any needed directories
	$build_up=$FILE_BASE;
	$parts=explode('/',dirname($target_file));
	foreach ($parts as $part)
	{
		$build_up.='/'.$part;
		@mkdir($build_up,0755);
	}

	// Copy in the data
	fseek($myfile,$offset);
	$myfile2=@fopen($FILE_BASE.'/'.$target_file,'wb');
	if ($myfile2===false)
	{
		header('Content-type: text/plain');
		exit('Filesystem permission error when trying to extract '.$target_file.'. Maybe you needed to give FTP details when logging in?');
	}
	while ($length>0)
	{
		$amount_to_read=min(1024,$length);
		$data_read=fread($myfile,$amount_to_read);
		fwrite($myfile2,$data_read);
		$length-=$amount_to_read;
	}
	fclose($myfile2);
	@chmod($FILE_BASE.'/'.$target_file,0644);
}
fclose($myfile);

// Show HTML
$next_offset_url='';
if ($file_offset+20<count($todo))
{
	$next_offset_url='upgrader2.php?';
	foreach ($_GET as $key=>$val)
	{
		if (get_magic_quotes_gpc()) $val=stripslashes($val);

		if ($key!='file_offset')
			$next_offset_url.=urlencode($key).'='.urlencode($val).'&';
	}
	$next_offset_url.='file_offset='.urlencode(strval($file_offset+20));
	$next_offset_url.='#progress';
}
up2_do_header($next_offset_url);
if ($next_offset_url=='')
{
	echo '<p><strong>'.htmlentities($_GET['done']).'!</strong></p>';
	unlink($tmp_path);
	unlink($tmp_data_path);
}
else
{
	echo '<p><img alt="" src="../themes/default/images/loading.gif" /></p>';
}
echo '<ol>';
foreach ($todo as $i=>$target_file)
{
	echo '<li>';
	echo '<input id="file_'.strval($i).'" name="file_'.strval($i).'" type="checkbox" value="1" disabled="disabled"'.(($i<$file_offset+20)?' checked="checked"':'').' /> <label for="file_'.strval($i).'">'.htmlentities($target_file[0]).'</label>';
	if ($i==$file_offset) echo '<a id="progress"></a>';
	echo '</li>';
}
echo '</ol>';
echo '<script type="text/javascript">// <![CDATA[
	window.scrollTo(0,document.getElementById("file_'.strval($file_offset).'").offsetTop-100);
//]]></script>';
if ($next_offset_url=='')
{
	echo '<p><strong>'.htmlentities($_GET['done']).'!</strong></p>';
} else
{
	echo '<hr /><p>Continuing in 3 seconds. If you have meta-refresh disabled, <a href="'.htmlentities($next_offset_url).'">force continue</a>.</p>';
}
up2_do_footer();

/**
 * Output the upgrader page header.
 *
 * @param URLPATH   URL to go to next (blank: done)
 */
function up2_do_header($refresh_url='')
{
	$_refresh_url=htmlentities($refresh_url);
	echo <<<END
<!DOCTYPE html>
	<html lang="EN">
	<head>
		<title>Extracting files</title>
		<link rel="icon" href="http://ocportal.com/favicon.ico" type="image/x-icon" />
END;
	if ($refresh_url!='') echo <<<END
		<meta http-equiv="refresh" content="3;url={$_refresh_url}" />
END;
	echo <<<END
		<style type="text/css">/*<![CDATA[*/
END;
global $FILE_BASE;
@print(preg_replace('#/\*\s*\*/\s*#','',str_replace('url(\'\')','none',str_replace('url("")','none',preg_replace('#\{\$[^\}]*\}#','',file_get_contents($FILE_BASE.'/themes/default/css/global.css'))))));
echo <<<END
			.screen_title { text-decoration: underline; display: block; background: url('../themes/default/images/bigicons/ocp-logo.png') top left no-repeat; min-height: 42px; padding: 3px 0 0 60px; }
			a[target="_blank"], a[onclick$="window.open"] { padding-right: 0; }
		/*]]>*/</style>

		<meta name="robots" content="noindex, nofollow" />
	</head>
	<body class="website_body"><div class="global_middle">
END;
}

/**
 * Output the upgrader page footer.
 */
function up2_do_footer()
{
	echo <<<END
	</div></body>
</html>
END;
}

/**
 * Check the given master password is valid.
 *
 * @param  SHORT_TEXT	Given master password
 * @return boolean		Whether it is valid
 */
function upgrader2_check_master_password($password_given_hashed)
{
	global $SITE_INFO;
	$actual_password_hashed=$SITE_INFO['admin_password'];

	if ($password_given_hashed==md5($actual_password_hashed)) return true; // LEGACY: Upgrade from v7 where hashed input password given even if plain-text password is in use

	return ($password_given_hashed==$actual_password_hashed);
}
