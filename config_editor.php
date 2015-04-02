<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		core
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
		if (is_array($val))
		{
			$_POST[$key]=array_map('stripslashes',$val);
		} else
		{
			$_POST[$key]=stripslashes($val);
		}
	}
	foreach ($_GET as $key=>$val)
	{
		$_GET[$key]=stripslashes($val);
	}
}

/*if (file_exists($FILE_BASE.'/use_comp_name'))
	require_once($FILE_BASE.'/'.(array_key_exists('COMPUTERNAME',$_ENV)?$_ENV['COMPUTERNAME']:$_SERVER['SERVER_NAME']).'.php');
else */require_once($FILE_BASE.'/info.php');

if (!is_writable($FILE_BASE.'/info.php'))
{
	ce_do_header();
	echo('<em>info.php is not writeable, so the config editor cannot edit it. Please either edit the file manually or change it\'s permissions appropriately.</em>');
	ce_do_footer();
	exit();
}

ce_do_header();
if ((array_key_exists('given_password',$_POST)))
{
	$given_password=$_POST['given_password'];
	if (co_check_master_password($given_password))
	{
		if (count($_POST)==1) do_access($given_password); else do_set();
	} else ce_do_login();
} else
{
	ce_do_login();
}
ce_do_footer();

/**
 * Output the config editors page header.
 */
function ce_do_header()
{
	echo '
<!DOCTYPE html>
<html lang="EN">
<head>
	<title>ocPortal Installation Options editor</title>
	<link rel="icon" href="http://ocportal.com/favicon.ico" type="image/x-icon" />
	<style type="text/css">
';
@print(preg_replace('#/\*\s*\*/\s*#','',str_replace('url(\'\')','none',str_replace('url("")','none',preg_replace('#\{\$[^\}]*\}#','',file_get_contents($GLOBALS['FILE_BASE'].'/themes/default/css/global.css'))))));
echo '
		.screen_title { text-decoration: underline; display: block; background: url(\'themes/default/images/bigicons/ocp-logo.png\') top left no-repeat; min-height: 42px; padding: 3px 0 0 60px; }
		a[target="_blank"], a[onclick$="window.open"] { padding-right: 0; }
	</style>

	<meta name="robots" content="noindex, nofollow" />
</head>
<body class="website_body" style="margin: 1em"><div class="global_middle">
	<h1 class="screen_title">ocPortal Installation Options editor</h1>
	<p>This is an editor kept as simple as possible, to allow fixing of configuration problems when ocPortal is not in a workable state. It is provided in English only, and only modifies the configuration file, not the database.</p>
	<form action="config_editor.php" method="post">
';
}

/**
 * Output the config editors page footer.
 */
function ce_do_footer()
{
	echo <<<END
		</form>
END;
global $SITE_INFO;
if (array_key_exists('base_url',$SITE_INFO))
{
$_base_url=htmlentities($SITE_INFO['base_url']);
echo <<<END
		<hr />
		<ul class="actions_list" role="navigation">
			<li><a href="{$_base_url}/adminzone/index.php">Go to Admin Zone</a></li>
		</ul>
END;
}
echo <<<END
	</div></body>
</html>
END;
}

/**
 * Output a login page.
 */
function ce_do_login()
{
	if (@$_POST['given_password']) echo '<p><strong>Invalid password</strong></p>';
	echo <<<END
		<label for="given_password">Master Password: <input type="password" name="given_password" id="given_password" /></label>
		<p><input type="submit" value="Login" /></p>
END;
}

/**
 * Output the editing page.
 *
 * @param  string	The password given to get here (so we don't need to re-enter it each edit).
 */
function do_access($given_password)
{
	global $SITE_INFO;
echo <<<END
	<table class="results_table">
END;
	if (!array_key_exists('block_mod_rewrite',$SITE_INFO)) $SITE_INFO['block_mod_rewrite']='0';
	if (!array_key_exists('use_mem_cache',$SITE_INFO)) $SITE_INFO['use_mem_cache']='1';
	foreach ($SITE_INFO as $key=>$val)
	{
		if (is_array($val))
		{
			foreach ($val as $val2)
			{
				echo '<input type="hidden" name="'.htmlentities($key).'[]" value="'.htmlentities($val2).'" />';
			}
			continue;
		}

		$notes='';
		switch ($key)
		{
/*
custom_base_url_stub
custom_share_domain
custom_share_path
custom_user_XXX
custom_domain_XXX
throttle_bandwidth_registered
throttle_bandwidth_complementary
throttle_space_registered
throttle_space_complementary
vb_unique_id
stronghold_cookies
vb_version
*/
			case 'use_mem_cache':
				$notes='Set this to \'1\' if persistent memory cacheing is to be used (caches data in memory between requests using whatever appropriate PHP extensions are available). You should only do this if you have a well-configured PHP extension installed for this (e.g. APC), otherwise an inefficient filesystem cache will be used which may cause intermittent problems and higher memory usage.';
				break;
			case 'fast_spider_cache':
				$notes='The number of hours that the spider/bot cache lasts for (this sets both HTTP cacheing, and server retention of cached screens).';
				break;
			case 'any_guest_cached_too':
				$notes='Set to \'1\' if Guests are cached with the spider cache time too.';
				break;
			case 'default_lang':
				$notes='The default language used on the site (language code form, of subdirectory under lang/).';
				break;
			case 'db_type':
				$notes='The database driver to use (code of PHP file in sources[_custom]/database/). Only mySQL supported officially.';
				break;
			case 'forum_type':
				$notes='The forum driver to use. Note that it is unwise to change this unless expert, as member-IDs and usergroup-IDs form a binding between portal and forum, and would need remapping. To convert to OCF, the forum importers can handle all of this automatically.';
				break;
			case 'board_prefix':
				$notes='This is the base-URL for the forums. If it is not correct, various links, such as links to topics, will not function correctly.';
				break;
			case 'domain':
				$notes='The domain that e-mail addresses are registered on. This applies only to the Point Store and may be ignored by most.';
				break;
			case 'base_url':
				$notes='A critical option, that defines the URL of the site (no trailing slash). If the URL changes, the base URL must be changed to reflect it. If you change this option you will need to empty your template and image caches (in the Cleanup Tools or Upgrader), else you may get strange error messages, broken images, and an ocPortal warning about an inconsistency.';
				break;
			case 'db_forums':
				$notes='The database name for the forum driver to tie in to.';
				break;
			case 'db_forums_host':
				$notes='The database hosting computer name (usually localhost) for the forum driver to tie in to.';
				break;
			case 'db_forums_user':
				$notes='The database username for the forum driver to connect to the forum database with.';
				break;
			case 'db_forums_password':
				$notes='The password for the forum database username.';
				break;
			case 'table_prefix':
				$notes='The table prefix for ocPortals database tables.';
				break;
			case 'db_site':
				$notes='The database name of the ocPortal database.';
				break;
			case 'db_site_host':
				$notes='The database hosting computer name (usually localhost) for the ocPortal database.';
				break;
			case 'db_site_user':
				$notes='The database username for ocPortal to connect to the ocPortal database with.';
				break;
			case 'db_site_password':
				$notes='The password for the ocPortal database username.';
				break;
			case 'use_persistent':
				$notes='Whether to use persistent database connections (most shared webhosts do not like these to be used).';
				break;
			case 'user_cookie':
				$notes='The name of the cookie used to hold usernames/ids for each user. Dependant on the forum system involved, and may use a special serialisation notation involving a colon (there is no special notation for OCF).';
				break;
			case 'pass_cookie':
				$notes='The name of the cookie used to hold passwords for each user.';
				break;
			case 'cookie_domain':
				$notes='The domain name the cookies are tied to. Only URLs with this domain, or a subdomain there-of, may access the cookies. You probably want to leave it blank. Use blank if running ocPortal off the DNS system (e.g. localhost), or if you want the active-domain to be used (i.e. autodetection). <strong>It\'s best not to change this setting once your community is active, as it can cause logging-out problems.</strong>';
				break;
			case 'cookie_path':
				$notes='The URL path the cookeis are tied to. Only URLs branching from this may access the cookies. Either set it to the path portion of the base-URL, or a shortened path if cookies need to work with something elsewhere on the domain, or leave blank for auto-detection. <strong>It\'s best not to change this setting once your community is active, as it can cause logging-out problems.</strong>';
				break;
			case 'block_mod_rewrite':
				$notes='Whether to block the short-URL (mod_rewrite) option. Set this to 1 if you turned on short-URLs and find your site no longer works.';
				break;
			case 'admin_username':
				$val='';
				$notes='The username used for the administrator when ocPortal is installed to not use a forum.';
				break;
			case 'admin_password':
				$val='';
				$notes='If you wish the password to be changed, enter a new password here. Otherwise leave blank.';
				break;
			case 'database_charset':
				$notes='The MySQL character set for the connection. Usually you can just leave this blank, but if MySQL\'s character set for your database has been overridden away from the server-default then you will need to set this to be equal to that same character set.';
				break;
			case 'on_msn':
				$notes='Whether this is a site on an OCF multi-site-network (set to 1 to trigger URLs to avatars and photos to be absolute).';
				break;
			case 'disable_smart_decaching':
				$notes='Don\'t check file times to check caches aren\'t stale.';
				break;
			case 'no_disk_sanity_checks':
				$notes='Assume that there are no missing language directories, or other configured directories; things may crash horribly if they are missing and this is enabled.';
				break;
			case 'hardcode_common_module_zones':
				$notes='Don\'t search for common modules, assume they are in default positions.';
				break;
			case 'prefer_direct_code_call':
				$notes='Assume a good opcode cache is present, so load up full code files via this rather than trying to save RAM by loading up small parts of files on occasion.';
				break;
			case 'backdoor_ip':
				$notes='Always allow users accessing from this IP address in, automatically logged in as the oldest admin of the site.';
				break;
			case 'full_ips':
				$notes='Whether to match sessions to the full IP addresses. Set this to 1 if you are sure users don\'t jump around IP addresses on the same 255.255.255.0 subnet (e.g. due to proxy server randomisation). This increases security.';
				break;
			case 'failover_mode':
				$notes='The failover mode. Either \'off\' or \'on\' or \'auto_off\' or \'auto_on\'. Usually it will be left to \'off\', meaning there is no active failover mode. The next most common setting will be \'auto_off\', which means the failover_script.php script is allowed to set it to \'auto_on\' if it detects the site is failing (and back to \'auto_off\' again when things are okay again). Setting it to \'on\' is manually declaring the site has failed and you want to keep it in failover mode.';
				break;
		}
		if (strpos($key,'_table_prefix')!==false)
		{
			$notes='';
		}
		$type='TEXT';
		if (strpos($key,'password')!==false) $type='password';
		$_key=htmlentities($key);
		$_val=htmlentities($val);
		echo <<<END
		<tr>
			<th>
				{$_key}
			</th>
			<td>
				<input type="{$type}" name="{$_key}" value="{$_val}" size="50" />
			</td>
			<td>
				{$notes}
			</td>
		</tr>
END;
		if ($key=='admin_password')
		{
		echo <<<END
		<tr>
			<th>
				&raquo; Confirm password
			</th>
			<td>
				<input type="{$type}" name="confirm_admin_password" value="{$_val}" size="50" />
			</td>
			<td>
			</td>
		</tr>
END;
		}
	}
	$_given_password=htmlentities($given_password);
	echo <<<END
	</table>
	<p class="proceed_button">
		<input type="submit" value="Edit" />
	</p>
	<input type="hidden" name="given_password" value="{$_given_password}" />
END;
}

/**
 * Do the editing.
 */
function do_set()
{
	$given_password=$_POST['given_password'];

	$new=array();
	foreach ($_POST as $key=>$val)
	{
		if ($key!='given_password')
		{
			if (($key=='admin_password') || ($key=='confirm_admin_password'))
			{
				if ($val=='')
				{
					$new[$key]='!'.md5($given_password.'ocp');
				} else $new[$key]='!'.md5($val.'ocp');
			} else $new[$key]=$val;
		}
	}
	if ($new['confirm_admin_password']!=$new['admin_password'])
	{
		echo '<hr /><p><strong>Your passwords do not match up.</strong></p>';
		return;
	}
	unset($new['confirm_admin_password']);

	// Test cookie settings. BASED ON CODE FROM INSTALL.PHP
	$base_url=$new['base_url'];
	$cookie_domain=$new['cookie_domain'];
	$cookie_path=$new['cookie_path'];
	$url_parts=parse_url($base_url);
	if (!array_key_exists('host',$url_parts)) $url_parts['host']='localhost';
	if (!array_key_exists('path',$url_parts)) $url_parts['path']='';
	if (substr($url_parts['path'],-1)!='/') $url_parts['path'].='/';
	if (substr($cookie_path,-1)=='/') $cookie_path=substr($cookie_path,0,strlen($cookie_path)-1);
	if (($cookie_path!='') && (substr($url_parts['path'],0,strlen($cookie_path)+1)!=$cookie_path.'/'))
	{
		echo '<hr /><p><strong>The cookie path must either be blank or correspond with some or all of the path in the base URL (which is <kbd>'.htmlentities($url_parts['path']).'</kbd>).</strong></p>';
		return;
	}
	if ($cookie_domain!='')
	{
		if (strpos($url_parts['host'],'.')===false)
		{
			echo '<hr /><p><strong>You are using a non-DNS domain in your base URL, which means you will need to leave your cookie domain blank (otherwise it won\'t work).</strong></p>';
			return;
		}
		if (substr($cookie_domain,0,1)!='.')
		{
			echo '<hr /><p><strong>The cookie domain must either be blank or start with a dot.</strong></p>';
			return;
		}
		elseif (substr($url_parts['host'],1-strlen($cookie_domain))!=substr($cookie_domain,1))
		{
			echo '<hr /><p><strong>The cookie domain must either be blank or correspond to some or all of the domain in the base URL (which is <kbd>'.htmlentities($url_parts['host']).'</kbd>). It must also start with a dot, so a valid example is <kbd>.'.htmlentities($url_parts['host']).'</kbd>.</strong></p>';
			return;
		}
	}

	// Delete old cookies, if our settings changed- to stop user getting confused by overrides
	global $SITE_INFO;
	if ((@$new['cookie_domain']!==@$SITE_INFO['cookie_domain']) || (@$new['cookie_path']!==@$SITE_INFO['cookie_path'])/* || (@$new['user_cookie']!==@$SITE_INFO['user_cookie']) || (@$new['pass_cookie']!==@$SITE_INFO['pass_cookie'])*/)
	{
		$cookie_path=array_key_exists('cookie_path',$SITE_INFO)?$SITE_INFO['cookie_path']:'/';
		if ($cookie_path=='') $cookie_path=NULL;
		$cookie_domain=array_key_exists('cookie_domain',$SITE_INFO)?$SITE_INFO['cookie_domain']:NULL;
		if ($cookie_domain=='') $cookie_domain=NULL;

		foreach (array_keys($_COOKIE) as $cookie)
		{
			@setcookie($cookie,'',time()-100000,$cookie_path,$cookie_domain);
		}

		/*$user_cookie=$SITE_INFO['user_cookie'];
		if (strpos($user_cookie,':')!==false) $user_cookie=substr($user_cookie,$colon_pos+1);
		@setcookie($user_cookie,'',time()-100000,$cookie_path,$cookie_domain);
		$pass_cookie=$SITE_INFO['pass_cookie'];
		if (strpos($pass_cookie,':')!==false) $pass_cookie=substr($pass_cookie,$colon_pos+1);
		@setcookie($pass_cookie,'',time()-100000,$cookie_path,$cookie_domain);*/

		echo '<p><strong>You have changed your cookie settings. Your old login cookies have been deleted, and the software will try and delete all cookie variations from your member\'s computers when they log out. However there is a chance you may need to let some members know that they need to delete their old cookies manually.</strong></p>';
	}

	// info.php
	global $FILE_BASE;
	$info_file=((file_exists('use_comp_name'))?(array_key_exists('COMPUTERNAME',$_ENV)?$_ENV['COMPUTERNAME']:$_SERVER['SERVER_NAME']):'info').'.php';
	$path=$FILE_BASE.'/exports/file_backups/'.$info_file.'.'.strval(time());
	$copied_ok=@copy($FILE_BASE.'/'.$info_file,$path);
	if ($copied_ok!==false) co_sync_file($path);
	$info=fopen($FILE_BASE.'/'.$info_file,'at');
	if ($info===false) exit();
	flock($info,LOCK_EX);
	ftruncate($info,0);
	fwrite($info,"<"."?php\n");
	foreach ($new as $key=>$val)
	{
		if (is_array($val))
		{
			foreach ($val as $val2)
			{
				$_val=str_replace('\\','\\\\',$val2);
				if (fwrite($info,'$SITE_INFO[\''.$key.'\'][]=\''.$_val."';\n")===false)
				{
					echo '<strong>Could not save to file. Out of disk space?<strong>';
				}
			}
		} else
		{
			$_val=str_replace('\\','\\\\',$val);
			if (fwrite($info,'$SITE_INFO[\''.$key.'\']=\''.$_val."';\n")===false)
			{
				echo '<strong>Could not save to file. Out of disk space?<strong>';
			}
		}
	}
	flock($info,LOCK_UN);
	fclose($info);
	co_sync_file($info_file);

	echo '<hr /><p>Edited configuration. If you wish to continue editing you must <a href="config_editor.php">login again.</a></p>';
	echo '<hr /><p>The info.php file was backed up at '.htmlentities($path).'</p>';
}

/**
 * Provides a hook for file synchronisation between mirrored servers.
 *
 * @param  PATH				File/directory name to sync on (may be full or relative path)
 */
function co_sync_file($filename)
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
function co_sync_file_move($old,$new)
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
function co_check_master_password($password_given)
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

