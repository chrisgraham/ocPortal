<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		code_editor
 */

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

if (get_magic_quotes_gpc())
{
	foreach ($_POST as $key=>$val)
	{
		$_POST[$key]=stripslashes($val);
	}
	foreach ($_GET as $key=>$val)
	{
		$_GET[$key]=stripslashes($val);
	}
}

global $HTML_ESCAPE_1_STRREP,$HTML_ESCAPE_2;
$HTML_ESCAPE_1_STRREP=array('&'/*,'�','�'*/,'"','\'','<','>'/*,'�'*/);
$HTML_ESCAPE_2=array('&amp;'/*,'&quot;','&quot;'*/,'&quot;','&#039;','&lt;','&gt;'/*,'&pound;'*/);

/**
 * Escape HTML text. Heavily optimised! Ended up with preg_replace after trying lots of things.
 *
 * @param  LONG_TEXT		The text to escape.
 * @return LONG_TEXT		The escaped result.
 */
function code_editor_escape_html($string)
{
	if ($string==='') return ''; // Optimisation

	return str_replace($GLOBALS['HTML_ESCAPE_1_STRREP'],$GLOBALS['HTML_ESCAPE_2'],$string);
}

// Cover up a hole in old PHP versions functionality
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
			while (!feof($file)) $data.=fread($file, 1024);
			fclose($file);
		}
		return $data;
	}
}

/*if (file_exists($FILE_BASE.'/use_comp_name'))
	require_once($FILE_BASE.'/'.(array_key_exists('COMPUTERNAME',$_ENV)?$_ENV['COMPUTERNAME']:$_SERVER['SERVER_NAME']).'.php');
else */require_once($FILE_BASE.'/info.php');

if ((array_key_exists('given_password',$_POST)))
{
	$given_password=$_POST['given_password'];
	if (ce_check_master_password($given_password))
	{
		if ((!array_key_exists('path',$_POST)) && (!array_key_exists('path',$_GET))) do_get_path($given_password);
		else
		{
			if (!isset($_POST['path_new'])) $_POST['path_new']='';
			$path=($_POST['path_new']!='')?$_POST['path_new']:(array_key_exists('path',$_POST)?$_POST['path']:$_GET['path']);
			do_page($given_password,$path);
		}
	} else code_editor_do_login();
} else
{
	code_editor_do_login();
}
code_editor_do_footer();

/**
 * Output the code editors page header.
 *
 * @param  ID_TEXT		The type our form clicks are.
 * @param  ID_TEXT		The target our form clicks get sent to.
 */
function code_editor_do_header($type,$target='_top')
{
	echo '
<!DOCTYPE html>
<html lang="EN">
<head>
	<title>ocPortal code editor</title>
	<link rel="icon" href="http://ocportal.com/favicon.ico" type="image/x-icon" />
	<style type="text/css">
';
@print(preg_replace('#/\*\s*\*/\s*#','',str_replace('url(\'\')','none',str_replace('url("")','none',preg_replace('#\{\$[^\}]*\}#','',file_get_contents($GLOBALS['FILE_BASE'].'/themes/default/css/global.css'))))));
echo '
		.screen_title { text-decoration: underline; display: block; background: url(\'themes/default/images/bigicons/ocp-logo.png\') top left no-repeat; min-height: 42px; padding: 3px 0 0 60px; }
		a[target="_blank"], a[onclick$="window.open"] { padding-right: 0; }
	</style>';
	echo '
		<script language="javascript" type="text/javascript" src="data/editarea/edit_area_full.js"></script>

		<meta name="robots" content="noindex, nofollow" />
		';
	echo '
</head>
<body class="website_body"><div class="global_middle">
<form target="'.$target.'" action="code_editor.php?type='.$type.'" method="post">
';
}

/**
 * Output the code editors page footer.
 */
function code_editor_do_footer()
{
	echo <<<END
</form>

<script type="text/javascript">// <![CDATA[
if (document.getElementById('file'))
{
	editAreaLoader.init({
		id : "file"
		,syntax: "php"
		,start_highlight: true
		,allow_resize: true
		,toolbar: "search, go_to_line, fullscreen, |, undo, redo, |, select_font,|, reset_highlight, word_wrap"
	});
}
//]]></script>

</div></body>
</html>
END;
}

/**
 * Output a login page.
 */
function code_editor_do_login()
{
	code_editor_do_header('gui');
	if (array_key_exists('path',$_GET))
	{
		echo '<input type="hidden" name="path" value="'.code_editor_escape_html($_GET['path']).'" />';
		echo '<input type="hidden" name="path_new" value="" />';
		if (array_key_exists('line',$_GET)) echo '<input type="hidden" name="line" value="'.code_editor_escape_html($_GET['line']).'" />';
	}
	global $SITE_INFO;
	$ftp_domain=array_key_exists('ftp_domain',$SITE_INFO)?$SITE_INFO['ftp_domain']:'localhost';
	if (!array_key_exists('ftp_username',$SITE_INFO))
	{
		if ((function_exists('posix_getpwuid')) && (strpos(@ini_get('disable_functions'),'posix_getpwuid')===false))
		{
			$file_owner=fileowner($GLOBALS['FILE_BASE'].'/code_editor.php');
			if ($file_owner!==false)
			{
				$u_info=posix_getpwuid($file_owner);
				if ($u_info!==false) $ftp_username=$u_info['name']; else $ftp_username='';
			} else $ftp_username='';
		} else $ftp_username='';
		if (is_null($ftp_username)) $ftp_username='';
	} else $ftp_username=$SITE_INFO['ftp_username'];
	if (!array_key_exists('ftp_folder',$SITE_INFO))
	{
		$dr=array_key_exists('DOCUMENT_ROOT',$_SERVER)?$_SERVER['DOCUMENT_ROOT']:(array_key_exists('DOCUMENT_ROOT',$_ENV)?$_ENV['DOCUMENT_ROOT']:'');
		if (strpos($dr,'/')!==false) $dr_parts=explode('/',$dr); else $dr_parts=explode('\\',$dr);
		$webdir_stub=$dr_parts[count($dr_parts)-1];
		$pos=strpos($_SERVER['PHP_SELF'],'code_editor.php');
		if ($pos===false) $pos=strlen($_SERVER['PHP_SELF']); else $pos--;
		$ftp_folder='/'.$webdir_stub.substr($_SERVER['PHP_SELF'],0,$pos);
	} else $ftp_folder=$SITE_INFO['ftp_folder'];
	echo <<<END
	<h1 class="screen_title">ocPortal Code Editor</h1>
END;
	if (@$_POST['given_password']) echo '<p><strong>Invalid password</strong></p>';
	$_ftp_domain=code_editor_escape_html($ftp_domain);
	$_ftp_folder=code_editor_escape_html($ftp_folder);
	$_ftp_username=code_editor_escape_html($ftp_username);
	echo <<<END
	<p>
		<label for="given_password">Master Password: <input type="password" name="given_password" id="given_password" /></label>
	</p>
	<hr />
	<p>If you need to edit original ocPortal files (rather than overriding or making custom ones), then you probably need to enter FTP details below. This will allow this editor to save via FTP, and if no username is given, it will try and save directly.</p>
	<table>
		<tr><th>FTP Host</th><td><input size="50" type="text" name="ftp_domain" value="{$_ftp_domain}" /></td></tr>
		<tr><th>FTP Path</th><td><input size="50" type="text" name="ftp_folder" value="{$_ftp_folder}" /></td></tr>
		<tr><th>FTP Username</th><td><input size="50" type="text" name="ftp_username" value="{$_ftp_username}" /></td></tr>
		<tr><th>FTP Password</th><td><input size="50" type="password" name="ftp_password" /></td></tr>
	</table>
	<p>
		<input type="submit" value="Login" />
	</p>
	<hr />
	<ul class="actions_list" role="navigation">
		<li><a title="ocProducts programming tutorial (this link will open in a new window)" target="_blank" href="http://ocportal.com/docs/pg/tut_programming">Read the ocProducts programming tutorial</a></li>
END;
if (array_key_exists('base_url',$SITE_INFO))
{
$_base_url=code_editor_escape_html($SITE_INFO['base_url']);
echo <<<END
		<li><a href="{$_base_url}/adminzone/index.php">Go to Admin Zone</a></li>
END;
}
echo <<<END
	</ul>
END;
}

/**
 * Search inside a directory for editable files, whilst favouring the overridden versions.
 *
 * @param  SHORT_TEXT	The directory path to search.
 * @return array			A list of the HTML elements for the list box selection.
 */
function do_dir($dir)
{
	$out=array();
	$_dir=($dir=='')?'.':$dir;
	$dh=@opendir($_dir);
	if ($dh!==false)
	{
		while (($file=readdir($dh))!==false)
		{
			if ($file[0]!='.')
			{
				if (is_file($_dir.'/'.$file))
				{
					if ((substr($file,-4,4)=='.php') || (substr($file,-4,4)=='.ini'))
					{
						$path=$dir.(($dir!='')?'/':'').$file;
						$alt=str_replace('lang/','lang_custom/',str_replace('pages/modules/','pages/modules_custom/',str_replace('sources/','sources_custom/',$path)));
						if (($alt==$path) || (!file_exists($alt)))
							$out[]='<option>'.code_editor_escape_html($path).'</option>';
					}
				} elseif (is_dir($_dir.'/'.$file))
				{
					$out=array_merge($out,do_dir($dir.(($dir!='')?'/':'').$file));
				}
			}
		}
	}
	return $out;
}

/**
 * Output the file selection page.
 *
 * @param  SHORT_TEXT	The password previously given to authorise our editing.
 */
function do_get_path($given_password)
{
	// Just to test a connection if one was requested
	$test=open_up_ftp_connection();
	if (is_string($test))
	{
		echo '<h1 class="screen_title">An FTP error occurred</h1>';
		echo '<p>'.code_editor_escape_html($test).'</p>';
		return;
	}

	code_editor_do_header('gui');
	$files=do_dir('');
	sort($files);
	$paths=implode('',$files);
foreach ($_POST as $key=>$val)
{
$_key=code_editor_escape_html($key);
$_val=code_editor_escape_html($val);
echo <<<END
<input type="hidden" name="{$_key}" value="{$_val}" />
END;
}
	echo <<<END
	<h1 class="screen_title">ocPortal Code Editor</h1>
	<p>
		New File: <input type="text" name="path_new" />
	</p>
	<p>
		OR, existing file: <select name="path">{$paths}</select>
	</p>
	<p class="proceed_button">
		<input type="submit" value="Edit file" />
	</p>
END;
}

/**
 * Ensure that the specified file/folder is writeable for the FTP user (so that it can be deleted by the system), and should be called whenever a file is uploaded/created, or a folder is made. We call this function assuming we are giving world permissions
 *
 * @param  PATH			The full pathname to the file/directory
 * @param  integer		The permissions to make (not the permissions are reduced if the function finds that the file is owned by the web user [doesn't need world permissions then])
 */
function code_editor_fix_permissions($path,$perms=0666) // We call this function assuming we are giving world permissions
{
	// If the file user is different to the FTP user, we need to make it world writeable
	if ((!function_exists('posix_getuid')) || (strpos(@ini_get('disable_functions'),'posix_getuid')!==false) || (@posix_getuid()!=@fileowner($GLOBALS['FILE_BASE'].'/index.php')))
	{
		@chmod($path,$perms);
	} else // Otherwise we do not
	{
		if ($perms==0666) @chmod($path,0644);
		elseif ($perms==0777) @chmod($path,0744);
		else @chmod($path,$perms);
	}
}

/**
 * Open up an FTP connection from POSTed details.
 *
 * @return ?mixed		Either an error screen or a connection. (NULL: not using FTP)
 */
function open_up_ftp_connection()
{
	if ((!isset($_POST['ftp_username'])) || ($_POST['ftp_username']=='')) return NULL;

	$conn=false;
	$domain=$_POST['ftp_domain'];
	$port=21;
	if (strpos($domain,':')!==false)
	{
		list($domain,$_port)=explode(':',$domain,2);
		$port=intval($_port);
	}
	if (function_exists('ftp_ssl_connect')) $conn=@ftp_ssl_connect($domain,$port);
	$ssl=($conn!==false);
	if (($ssl) && (@ftp_login($conn,$_POST['ftp_username'],$_POST['ftp_password'])===false))
	{
		$conn=false;
		$ssl=false;
	}
	if ($conn===false) $conn=@ftp_connect($domain,$port);
	if ($conn===false)
	{
		return 'Could not connection to host '.$_POST['ftp_domain'];
	}

	if ((!$ssl) && (@ftp_login($conn,$_POST['ftp_username'],$_POST['ftp_password'])===false))
	{
		return 'Could connect to the FTP server but not log in. ['.@strval($php_errormsg).']';
	}

	if (substr($_POST['ftp_folder'],-1)!='/') $_POST['ftp_folder'].='/';
	if (@ftp_chdir($conn,$_POST['ftp_folder'])===false)
	{
		return 'The FTP folder given was invalid or can not otherwise be accessed. ['.@strval($php_errormsg).']';
	}
	$files=@ftp_nlist($conn,'.');
	if ($files===false) // :(. Weird bug on some systems
	{
		$files=array();
		if (@ftp_rename($conn,'info.php','info.php')) $files=array('info.php');
	}
	if (!in_array('info.php',$files))
	{
		return 'This does not appear to be the correct FTP directory.';
	}
	return $conn;
}

/**
 * Output the editing page and do the editing.
 *
 * @param  SHORT_TEXT	The password previously given to authorise our editing.
 * @param  SHORT_TEXT	The path of the file we are editing.
 */
function do_page($given_password,$path)
{
	if ($path[0]=='/') $path=substr($path,1);
	if (strpos($path,'..')!==false) exit('Suspected hacking attempt');

	$type=array_key_exists('type',$_GET)?$_GET['type']:'gui';

	code_editor_do_header('edit','results');
	if ($type=='gui')
	{
		$save_path=convert_to_save_path($path);

		$contents=@file_get_contents($path);
		$lines=substr_count($contents,chr(10))+1;
		$line=(array_key_exists('line',$_POST)?intval($_POST['line']):(array_key_exists('line',$_POST)?intval($_POST['line']):0));
		$_path=code_editor_escape_html($path);
echo <<<END
<h1 class="screen_title">ocPortal <a onclick="window.back(); return false;" href="code_editor.php">Code Editor</a>: Editing {$_path}</h1>
<input type="hidden" name="path" value="{$_path}" />
END;
foreach ($_POST as $key=>$val)
{
if (($key!='path') && ($key!='path_new'))
{
$_key=code_editor_escape_html($key);
$_val=code_editor_escape_html($val);
echo <<<END
<input type="hidden" name="{$_key}" value="{$_val}" />
END;
}
}
echo <<<END
<textarea id="file" name="file" rows="35" cols="50" style="width: 100%;">
END;
echo code_editor_escape_html($contents).'</textarea>';
echo <<<END
<script type="text/javascript">// <![CDATA[
	var file=document.getElementById('file');
	file.scrollTop=Math.round((file.scrollHeight/{$lines})*{$line});
//]]></script>
<p>
	Jump to (line number or search phrase): <input name="jmp" type="text" value="" /> <input onclick="var val=form.elements['jmp'].value; if (!(window.parseInt(val)>0)) val=file.value.substr(0,file.value.indexOf(val)).split('\\n').length-1; file.scrollTop=Math.round((file.scrollHeight/{$lines})*window.parseInt(val)); return false;" type="submit" value="Jump" />
</p>
END;
if (strpos($path,'_custom/')!==false)
{
echo <<<END
<p><input id="delete" name="delete" type="checkbox" value="1" /><label for="delete">Delete this override/custom-file. If you choose this, nothing will be edited, only deleted.</label></p>
END;
} elseif ($save_path==$path)
{
echo <<<END
<p>This file is not overridable - it will be edited directly.</p>
END;
}
else
{
echo <<<END
<p>This file is not yet overridden. <input id="override" name="override" checked="checked" type="checkbox" value="1" /> <label for="override">Use this edit to specify the override (as opposed to saving over the original).</label></p>
END;
}
echo <<<END
<p class="proceed_button">
<input type="submit" value="Edit" />
</p>
<iframe name="results" src="" style="display: none"></iframe>
END;
	} else
	{
		$save_path=$_POST['path'];
		if (isset($_POST['override'])) $save_path=convert_to_save_path($save_path);

		$file=$_POST['file'];

		// Make backup
		if (file_exists($save_path))
		{
			$backup_path=$save_path.'.'.strval(time());
			$c_success=@copy($save_path,$backup_path);
			if ($c_success!==false) ce_sync_file($backup_path);
		}

		$conn=open_up_ftp_connection();

		// Edit
		if (!isset($_POST['delete']))
		{
			if (is_null($conn)) // Via direct access
			{
				$myfile=@fopen($save_path,'wt');
				if ($myfile===false)
				{
					echo <<<END
<script language="Javascript" type="text/javascript">
var msg='Access denied. You probably should have specified FTP details.';
if (window.alert!==null)
{
	window.alert(msg);
} else
{
	console.log(msg+' (popup blocker stopping alert)');
}
</script>
END;
					return;
				}
				if (fwrite($myfile,$file)===false)
				{
					fclose($myfile);
					echo <<<END
<script language="Javascript" type="text/javascript">
var msg='Could not write to file, out of disk space?';
if (window.alert!==null)
{
	window.alert(msg);
} else
{
	console.log(msg+' (popup blocker stopping alert)');
}
</script>
END;
					return;
				}
				fclose($myfile);
			} else // Via FTP
			{
				$path2=tempnam((((ini_get('safe_mode')=='1') || ((@strval(ini_get('open_basedir'))!='') && (preg_match('#(^|:|;)/tmp($|:|;|/)#',ini_get('open_basedir'))==0)))?get_custom_file_base().'/safe_mode_temp/':'/tmp/'),'ocpce');
				if ($path2===false)
					$path2=tempnam(get_custom_file_base().'/safe_mode_temp/','ocpce');

				$h=fopen($path2,'wt');
				if (fwrite($h,$file)===false)
				{
					fclose($h);
					echo <<<END
<script language="Javascript" type="text/javascript">
var msg='Could not write to file, out of disk space?';
if (window.alert!==null)
{
	window.alert(msg);
} else
{
	console.log(msg+' (popup blocker stopping alert)');
}
</script>
END;
					return;
				}
				fclose($h);

				$h=fopen($path2,'rt');
				$ftp_success=@ftp_fput($conn,$save_path,$h,FTP_BINARY);
				if ($ftp_success===false)
				{
					echo <<<END
<script language="Javascript" type="text/javascript">
var msg='Could not save via FTP ['.@strval($php_errormsg).'].';
if (window.alert!==null)
{
	window.alert(msg);
} else
{
	console.log(msg+' (popup blocker stopping alert)');
}
</script>
END;
					return;
				}
				fclose($h);

				unlink($path2);
			}
		} else // Delete
		{
			unlink($save_path);
		}

		code_editor_fix_permissions($save_path);
		ce_sync_file($save_path);

		// Make base-hash-thingy
		if (!isset($_POST['delete']))
		{
			if (file_exists(str_replace('_custom/','/',$save_path)))
			{
				$hash=file_get_contents(str_replace('_custom/','/',$save_path));
				if (is_null($conn)) // Via direct access
				{
					$myfile=@fopen($save_path.'.editfrom','wt');
					if ($myfile!==false)
					{
						fwrite($myfile,$hash);
						fclose($myfile);
					}
				} else // Via FTP
				{
					$path2=tempnam((((ini_get('safe_mode')=='1') || ((@strval(ini_get('open_basedir'))!='') && (preg_match('#(^|:|;)/tmp($|:|;|/)#',ini_get('open_basedir'))==0)))?get_custom_file_base().'/safe_mode_temp/':'/tmp/'),'ocpce');
					if ($path2===false)
						$path2=tempnam(get_custom_file_base().'/safe_mode_temp/','ocpce');

					$h=fopen($path2,'wt');
					fwrite($h,$hash);
					fclose($h);

					$h=fopen($path2,'rt');
					@ftp_fput($conn,$save_path.'.editfrom',$h,FTP_BINARY);
					fclose($h);

					unlink($path2);
				}
			}
		} else
		{
			@unlink($save_path.'.editfrom');
		}
		code_editor_fix_permissions($save_path.'.editfrom');
		ce_sync_file($save_path.'.editfrom');

		if (!isset($_POST['delete']))
			$message="Saved ".code_editor_escape_html($save_path)." (and if applicable, placed a backup in its directory)!";
		else
			$message="Deleted ".code_editor_escape_html($save_path).". You may edit to recreate the file if you wish however.";
		echo <<<END
<script language="Javascript" type="text/javascript">
var msg='{$message}';
if (window.alert!==null)
{
	window.alert(msg);
} else
{
	console.log(msg+' (popup blocker stopping alert)');
}
</script>
END;
	}
}

/**
 * Convert a normal path to an overriden save path.
 *
 * @param  string			The normal path
 * @return string			The overridden save path
 */
function convert_to_save_path($save_path)
{
	if (substr($save_path,0,8)=='sources/') $save_path='sources_custom/'.substr($save_path,8);
	elseif (substr($save_path,0,5)=='lang/') $save_path='lang_custom/'.substr($save_path,5);
	else $save_path=str_replace('pages/modules/','pages/modules_custom/',$save_path);
	return $save_path;
}

/**
 * Provides a hook for file synchronisation between mirrored servers.
 *
 * @param  PATH				File/directory name to sync on (may be full or relative path)
 */
function ce_sync_file($filename)
{
	global $FILE_BASE;
	if (file_exists($FILE_BASE.'/data_custom/sync_script.php'))
	{
		require_once($FILE_BASE.'/data_custom/sync_script.php');
		if (substr($filename,0,strlen($FILE_BASE))==$FILE_BASE)
		{
			$filename=substr($filename,strlen($FILE_BASE));
		}
		if (function_exists('master__sync_file')) master__sync_file($filename);
	}
}

/**
 * Provides a hook for file synchronisation between mirrored servers.
 *
 * @param  PATH				File/directory name to move from (may be full or relative path)
 * @param  PATH				File/directory name to move to (may be full or relative path)
 */
function ce_sync_file_move($old,$new)
{
	global $FILE_BASE;
	if (file_exists($FILE_BASE.'/data_custom/sync_script.php'))
	{
		require_once($FILE_BASE.'/data_custom/sync_script.php');
		if (substr($old,0,strlen($FILE_BASE))==$FILE_BASE)
		{
			$old=substr($old,strlen($FILE_BASE));
		}
		if (substr($new,0,strlen($FILE_BASE))==$FILE_BASE)
		{
			$new=substr($new,strlen($FILE_BASE));
		}
		if (function_exists('master__sync_file_move')) master__sync_file_move($old,$new);
	}
}

/**
 * Check the given master password is valid.
 *
 * @param  SHORT_TEXT	Given master password
 * @return boolean		Whether it is valid
 */
function ce_check_master_password($password_given)
{
	global $SITE_INFO;
	if (!array_key_exists('admin_password',$SITE_INFO)) exit('No master password defined in info.php currently so cannot authenticate');
	$actual_password_hashed=$SITE_INFO['admin_password'];
	$salt='';
	if ((substr($actual_password_hashed,0,1)=='!') && (strlen($actual_password_hashed)==33))
	{
		$actual_password_hashed=substr($actual_password_hashed,1);
		$salt='ocp';
	}
	return (((strlen($password_given)!=32) && ($actual_password_hashed==$password_given)) || ($actual_password_hashed==md5($password_given.$salt)));
}

