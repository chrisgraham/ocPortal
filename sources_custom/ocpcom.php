<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		ocportalcom
 */

function init__ocpcom()
{
	define('MYOCP_DEMO_LAST_DAYS',30);
}

function server__public__demo_reset()
{
	require_lang('sites');

	set_value('last_demo_set_time',strval(time()));
	
	require_lang('ocpcom');

	$servers=find_all_servers();
	$server=array_shift($servers);
	$codename='shareddemo';
	$password='demo123';
	$email_address='';
	myocp_add_site_raw($server,$codename,$email_address,$password);
}

function server__public__get_tracker_categories()
{
	$categories=collapse_1d_complexity('name',$GLOBALS['SITE_DB']->query('SELECT DISTINCT name FROM mantis_category_table WHERE status=0'));
	echo serialize($categories);
}

function server__create_tracker_issue($version_dotted,$tracker_title,$tracker_message,$tracker_additional)
{
	require_code('mantis');
	echo strval(create_tracker_issue($version_dotted,$tracker_title,$tracker_message,$tracker_additional));
}

function server__create_tracker_post($tracker_id,$tracker_comment_message)
{
	require_code('mantis');
	echo strval(create_tracker_post(intval($tracker_id),$tracker_comment_message));
}

function server__close_tracker_issue($tracker_id)
{
	require_code('mantis');
	close_tracker_issue(intval($tracker_id));
}

function server__post_in_bugs_catalogue($version_pretty,$ce_title,$ce_description,$ce_affects,$ce_fix)
{
	require_code('catalogues2');

	$bug_category_id=get_bug_category_id($version_pretty);

	$map=array(
		// HACKHACK: Hard-coded IDs
		35=>$ce_title,
		36=>$ce_description,
		32=>$ce_affects,
		34=>$ce_fix,
	);

	$entry_id=actual_add_catalogue_entry($bug_category_id,1,'',0,0,0,$map);

	echo strval($entry_id);
}

function get_bug_category_id($version_pretty)
{
	require_code('catalogues');
	require_code('catalogues2');

	if (is_null($GLOBALS['SITE_DB']->query_value_null_ok('catalogues','c_name',array('c_name'=>'bugs'))))
	{
		actual_add_catalogue('bugs','Bugs','',C_DT_MAPS,0,'',0);
		$fields=array(
			array('Title','short_trans',1,1,1),
			array('Description','long_trans',0,1,0),
			array('Fix','long_trans',0,0,0),
		);
		foreach ($fields as $i=>$field)
			actual_add_catalogue_field('projects',$field[0],'',$field[1],$i,$field[2],1,1,'',$field[3],$field[4]);
		foreach (array_keys($groups) as $group_id)
			$GLOBALS['SITE_DB']->query_insert('group_category_access',array('module_the_name'=>'catalogues_catalogue','category_name'=>'bugs','group_id'=>$group_id));
	}

	$bug_category_id=$GLOBALS['SITE_DB']->query_value_null_ok('catalogue_categories c JOIN '.get_table_prefix().'translate t ON t.id=c.cc_title','c.id',array('text_original'=>strval($version_pretty)));
	if (is_null($bug_category_id))
	{
		$bug_category_id=actual_add_catalogue_category('bugs',strval($version_pretty),'','',NULL);
		$groups=$GLOBALS['FORUM_DRIVER']->get_usergroup_list(false,true);
		foreach (array_keys($groups) as $group_id)
			$GLOBALS['SITE_DB']->query_insert('group_category_access',array('module_the_name'=>'catalogues_category','category_name'=>strval($bug_category_id),'group_id'=>$group_id));
	}

	return $bug_category_id;
}

function server__create_forum_post($_replying_to_post,$post_reply_title,$post_reply_message,$_post_important)
{
	$replying_to_post=intval($_replying_to_post);
	$post_important=intval($_post_important);

	$topic_id=$GLOBALS['FORUM_DB']->query_value('f_posts','p_topic_id',array('id'=>$replying_to_post));

	require_code('ocf_posts_action');
	require_code('mantis'); // Defines LEAD_DEVELOPER_MEMBER_ID
	$post_id=ocf_make_post($topic_id,$post_reply_title,$post_reply_message,0,false,1,$post_important,NULL,NULL,NULL,LEAD_DEVELOPER_MEMBER_ID,NULL,NULL,NULL,false,true,NULL,false,'',0,NULL,false,false,false,false,$replying_to_post);

	echo strval($post_id);
}

function server__create_forum_topic($forum_id,$topic_title,$post)
{
	require_code('ocf_topics_action');
	require_code('ocf_posts_action');
	require_code('mantis'); // Defines LEAD_DEVELOPER_MEMBER_ID
	$topic_id=ocf_make_topic($forum_id,'','',1,1,0,0,0,NULL,NULL,false);

	$post_id=ocf_make_post($topic_id,$topic_title,$post,0,true,1,0,NULL,NULL,NULL,LEAD_DEVELOPER_MEMBER_ID,NULL,NULL,NULL,false);

	echo strval($topic_id);
}

function server__upload_to_tracker_issue($tracker_id)
{
	require_code('mantis');
	upload_to_tracker_issue(intval($tracker_id),$_FILES['upload']);
}

function myocp_add_site($codename,$name,$email_address,$password,$description,$category,$show_in_directory)
{
	if (strlen($name)>200) warn_exit(do_lang_tempcode('INTERNAL_ERROR'));

	// Check named site valid
	if ((strlen($codename)<3) || (strlen($codename)>20) || (preg_match('#^[\w\d-]*$#',$codename)==0))
	{
		warn_exit(do_lang_tempcode('MO_BAD_NAME'));
	}

	// Check named site available
	$test=$GLOBALS['SITE_DB']->query_value_null_ok('sites','s_server',array('s_codename'=>$codename));
	if (!is_null($test))
	{
		// Did it fail adding before? It's useful to not have to fiddle around manually cleaning up when debugging
		$definitely_failed=false;//(strpos(file_get_contents(special_myocp_dir().'/rcpthosts'),chr(10).$codename.'.myocp.com'.chr(10))===false);
		$probably_failed=!file_exists(special_myocp_dir().'/alias/.qmail-myocp_'.$codename.'_staff');
		if (($definitely_failed) || ((($probably_failed) || (get_param_integer('keep_force',0)==1)) && ($GLOBALS['FORUM_DRIVER']->is_staff(get_member()))))
		{
			myocp_delete_site($test,$codename);
			$test=NULL;
		}
	}
	if ((!is_null($test)) || (in_array($codename,array('ssh','ftp','ns1','ns2','ns3','ns4','private','staff','webmail','imap','smtp','mail','ns','com','net','www','sites','chris','test','example','ocproducts','ocportal','ocp'))) || (strpos($codename,'myocp')!==false))
	{
		warn_exit(do_lang_tempcode('MO_NOT_AVAILABLE'));
	}

	$server=choose_available_server();

	$GLOBALS['SITE_DB']->query_insert('sites',array(
		's_codename'=>$codename,
		's_name'=>$name,
		's_description'=>$description,
		's_category'=>$category,
		's_domain_name'=>'',
		's_server'=>$server,
		's_member_id'=>get_member(),
		's_add_time'=>time(),
		's_last_backup_time'=>NULL,
		's_subscribed'=>0,
		's_show_in_directory'=>$show_in_directory,
		's_sponsored_in_category'=>0,
		's_sent_expire_message'=>0,
	));

	myocp_add_site_raw($server,$codename,$email_address,$password);

	// Aliases
	$GLOBALS['SITE_DB']->query_insert('sites_email',array(
		's_codename'=>$codename,
		's_email_from'=>'staff',
		's_email_to'=>$email_address,
	),false,true);
	reset_aliases();

	// Info.php
	reset_info_php($server);

	// Welcome email
	require_lang('sites');
	require_code('mail');
	$subject=do_lang('MO_EMAIL_SUBJECT');
	$message=do_lang('MO_EMAIL_BODY',comcode_escape($codename),comcode_escape($password));
	mail_wrap($subject,$message,array($email_address));
}

function myocp_add_site_raw($server,$codename,$email_address,$password)
{
	// Create database, set title and description and domain
	$master_conn=new database_driver(get_db_site(),'localhost'/*$server*/,'root',$GLOBALS['SITE_INFO']['mysql_root_password'],'ocp_');
	$master_conn->query('DROP DATABASE `myocp_site_'.$codename.'`',NULL,NULL,true);
	$master_conn->query('CREATE DATABASE `myocp_site_'.$codename.'`',NULL,NULL,true);
	$user=substr(md5('myocp_site_'.$codename),0,16);
	$master_conn->query('GRANT ALL ON `myocp_site_'.$codename.'`.* TO \''.$user.'\'@\'%\' IDENTIFIED BY \''.db_escape_string($GLOBALS['SITE_INFO']['mysql_myocp_password']).'\''); // tcp/ip
	$master_conn->query('GRANT ALL ON `myocp_site_'.$codename.'`.* TO \''.$user.'\'@\'localhost\' IDENTIFIED BY \''.db_escape_string($GLOBALS['SITE_INFO']['mysql_myocp_password']).'\''); // local socket
	$cmd='mysql -h'./*$server*/'localhost'.' -Dmyocp_site_'.$codename.' -u'.$user.' -p'.$GLOBALS['SITE_INFO']['mysql_myocp_password'].' < '.special_myocp_dir().'/template.sql';
	if (get_member()==6) attach_message($cmd,'inform');
	shell_exec($cmd);
	$db_conn=new database_driver('myocp_site_'.$codename,'localhost'/*$server*/,$user,$GLOBALS['SITE_INFO']['mysql_myocp_password'],'ocp_');
	$db_conn->query_update('config',array('config_value'=>$email_address),array('the_name'=>'staff_address'),'',1);
	$pass=md5($password);
	$salt='';
	$compat='md5';
	$db_conn->query_update('f_members',array('m_email_address'=>$email_address,'m_pass_hash_salted'=>$pass,'m_pass_salt'=>$salt,'m_password_compat_scheme'=>$compat),array('m_username'=>'admin'),'',1);

	// Create default file structure
	$path=special_myocp_dir().'/servers/'.filter_naughty($server).'/sites/'.filter_naughty($codename);
	if (file_exists($path))
	{
		deldir_contents($path);
	} else
	{
		@mkdir(dirname($path),0775);
		mkdir($path,0775);
	}
	chmod($path,0775);
	require_code('tar');
	$tar=tar_open(special_myocp_dir().'/template.tar','rb');
	$path_short=substr($path,strlen(get_custom_file_base().'/'));
	tar_extract_to_folder($tar,$path_short);
	tar_close($tar);
	require_code('files2');
	$contents=get_directory_contents($path,$path,true,true,true);
	foreach ($contents as $c)
	{
		chmod($c,0664);
	}
	$contents=get_directory_contents($path,$path,true,true,false);
	foreach ($contents as $c)
	{
		chmod($c,0775);
	}
}

/**
 * Get the relative path to the special directory that holds NFS links to servers, etc.
 *
 * @return string	  Server path.
 */
function special_myocp_dir()
{
	return get_custom_file_base().'/uploads/website_specific/ocportal.com/myocp';
}

/**
 * Get a list of categories that sites may be in.
 *
 * @return tempcode	 The result of execution.
 */
function get_site_categories()
{
	$cats=array('Entertainment','Computers','Sport','Art','Music','Television/Movies','Businesses','Other','Informative/Factual','Political','Humour','Geographical/Regional','Games','Personal/Family','Hobbies','Culture/Community','Religious','Health');
	sort($cats);
	return $cats;
}

/**
 * Get a form field list of site categories.
 *
 * @param  string			The default selected item
 * @return tempcode		 List
 */
function nice_get_site_categories($cat)
{
	$cat_list=new ocp_tempcode();
	$categories=get_site_categories();
	foreach ($categories as $_cat)
	{
		$cat_list->attach(form_input_list_entry($_cat,$_cat==$cat));
	}
	return $cat_list;
}

/**
 * Get a form field list of servers.
 *
 * @param  string			The default selected item
 * @return tempcode		 List
 */
function nice_get_servers($server)
{
	$server_list=new ocp_tempcode();
	$servers=find_all_servers();
	foreach ($servers as $_server)
	{
		$server_list->attach(form_input_list_entry($_server,$_server==$server));
	}
	return $server_list;
}

/**
 * Find all the servers for our shared hosting.
 *
 * @return array	  A list of servers.
 */
function find_all_servers()
{
	if (!file_exists(special_myocp_dir().'/servers')) return array('');
	
	$d=opendir(special_myocp_dir().'/servers');
	$servers=array();
	while (($e=readdir($d))!==false)
	{
		if ($e[0]!='.')
		//if (substr_count($e,'.')==4)
		{
			$servers[]=$e;
		}
	}
	closedir($d);
	return $servers;
}

/**
 * Cause the info.php file to be rebuilt.
 *
 * @param  ID_TEXT	The server.
 */
function reset_info_php($server)
{
	$path=special_myocp_dir().'/servers/'.filter_naughty($server).'/info.php';
	$myfile=fopen($path,'at');
	flock($myfile,LOCK_EX);
	ftruncate($myfile,0);
	$contents="<"."?php
global \$SITE_INFO;
\$SITE_INFO['default_lang']='EN';
\$SITE_INFO['db_type']='mysql';
\$SITE_INFO['forum_type']='ocf';
\$SITE_INFO['domain']=\$_SERVER['HTTP_HOST'];
\$SITE_INFO['base_url']='http://'.\$_SERVER['HTTP_HOST'];
\$SITE_INFO['table_prefix']='ocp_';
\$SITE_INFO['use_msn']='1';
\$SITE_INFO['db_forums']='myocp_site';
\$SITE_INFO['db_forums_host']='localhost';
\$SITE_INFO['db_forums_user']='myocp_site';
\$SITE_INFO['db_forums_password']='".$GLOBALS['SITE_INFO']['mysql_myocp_password']."';
\$SITE_INFO['ocf_table_prefix']='ocp_';
\$SITE_INFO['db_site']='myocp_site';
\$SITE_INFO['db_site_host']='localhost';
\$SITE_INFO['db_site_user']='myocp_site';
\$SITE_INFO['db_site_password']='".$GLOBALS['SITE_INFO']['mysql_myocp_password']."';
\$SITE_INFO['user_cookie']='myocp_member_id';
\$SITE_INFO['pass_cookie']='myocp_member_hash';
\$SITE_INFO['cookie_domain']='';
\$SITE_INFO['cookie_path']='/';
\$SITE_INFO['cookie_days']='120';

/*\$SITE_INFO['throttle_space_complementary']=100;
\$SITE_INFO['throttle_space_views_per_meg']=10;
\$SITE_INFO['throttle_bandwidth_complementary']=500;
\$SITE_INFO['throttle_bandwidth_views_per_meg']=1;*/

\$SITE_INFO['custom_base_url_stub']='http://'.\$_SERVER['HTTP_HOST'].'/sites';
\$SITE_INFO['custom_file_base_stub']='".special_myocp_dir()."/servers/myocp.com/sites';
\$SITE_INFO['custom_share_domain']='myocp.com';
\$SITE_INFO['custom_share_path']='sites';
";
	$rows=$GLOBALS['SITE_DB']->query_select('sites',array('s_codename','s_domain_name'),array('s_server'=>$server));
	foreach ($rows as $row)
	{
		if ($row['s_domain_name']!='')
		{
			$contents.="
\$SITE_INFO['custom_domain_".db_escape_string($row['s_domain_name'])."']='".db_escape_string($row['s_codename'])."';
";
		}
		$contents.="
\$SITE_INFO['custom_user_".db_escape_string($row['s_codename'])."']=1;
";
	}
	$contents.="?".">";
	fwrite($myfile,$contents);
	flock($myfile,LOCK_UN);
	fclose($myfile);
}

/**
 * Cause the E-mail server to reload it's database.
 */
function reset_aliases()
{
	return; // Needs customising for each deployment; myOCP personal demos currently not supporting email hosting

	// Rebuild virtualdomains
	$vds=explode(chr(10),file_get_contents(special_myocp_dir().'/virtualdomains'));
	$text='';
	foreach ($vds as $vd)
	{
		if ((strpos($vd,':alias-myocp_')===false) && (trim($vd)!=''))
			$text.=$vd.chr(10);
	}
	$sites=$GLOBALS['SITE_DB']->query_select('sites',array('s_codename','s_domain_name'));
	foreach ($sites as $site)
	{
		$text.=$site['s_codename'].'.myocp.com:'.'alias-myocp_'.$site['s_codename'].chr(10);
		if ($site['s_domain_name']!='') $text.=$site['s_domain_name'].':'.'alias-myocp_'.$site['s_codename'].chr(10);
	}
	$myfile=fopen(special_myocp_dir().'/virtualdomains','at');
	flock($myfile,LOCK_EX);
	ftruncate($myfile,0);
	fwrite($myfile,$text);
	flock($myfile,LOCK_UN);
	fclose($myfile);

	// Rebuild rcpthosts
	$vds=explode(chr(10),file_get_contents(special_myocp_dir().'/rcpthosts'));
	$hosts=array();
	foreach ($vds as $vd)
	{
		if (trim($vd)!='') $hosts[$vd]=1;
	}
	$sites=$GLOBALS['SITE_DB']->query_select('sites',array('s_codename','s_domain_name'));
	foreach ($sites as $site)
	{
		$hosts[$site['s_codename'].'.myocp.com']=1;
		if ($site['s_domain_name']!='')
			$hosts[$site['s_domain_name']]=1;
	}
	$myfile=fopen(special_myocp_dir().'/rcpthosts','at');
	flock($myfile,LOCK_EX);
	ftruncate($myfile,0);
	fwrite($myfile,implode(chr(10),array_keys($hosts)).chr(10));
	flock($myfile,LOCK_UN);
	fclose($myfile);

	// Go through aliases directory and remove myOCP aliases
	$a_path=special_myocp_dir().'/alias';
	$d=opendir($a_path.'/');
	while (($e=readdir($d))!==false)
	{
		if (substr($e,0,13)=='.qmail-myocp_')
		{
			unlink($a_path.'/'.$e);
		}
	}
	closedir($d);

	// Rebuild alias files
	$emails=$GLOBALS['SITE_DB']->query_select('sites_email',array('*'));
	foreach ($emails as $email)
	{
		$myfile=fopen($a_path.'/.qmail-myocp_'.filter_naughty($email['s_codename']).'_'.filter_naughty(str_replace('.',':',$email['s_email_from'])),'at');
		flock($myfile,LOCK_EX);
		ftruncate($myfile,0);
		fwrite($myfile,'&'.$email['s_email_to']);
		flock($myfile,LOCK_UN);
		fclose($myfile);
	}

	shell_exec(special_myocp_dir().'/reset_aliases');
}

/**
 * Find the size of a directory.
 *
 * @param  PATH			  The pathname to the directory
 * @return integer		  The size in bytes
 */
function find_dir_size($dir)
{
	$amount=0;

	$current_dir=@opendir($dir);
	if ($current_dir!==false)
	{
		while (false!==($entryname=readdir($current_dir)))
		{
			if (($entryname=='.') || ($entryname=='..')) continue;

			if (is_dir($dir.'/'.$entryname))
			{
				$amount+=find_dir_size($dir.'/'.$entryname);
			} else
			{
				$amount+=filesize($dir.'/'.$entryname);
			}
		}
		closedir($current_dir);
	}
	
	return $amount;
}

/**
 * Find the load of a server.
 *
 * @param  ID_TEXT	The server to check load for.
 * @return ?float	 The load (NULL: out of action).
 */
function find_server_load($server)
{
	return 1; // Not currently supported, needs customising per-server

	//	$stats=http_download_file('http://'.$server.'/data_custom/stats.php?html=1');
	$stats=shell_exec('php /home/myocp/public_html/data_custom/stats.php 1');
	$matches=array();
	preg_match('#Memory%: (.*)<br />Swap%: (.*)<br />15-min-load: load average: (.*)<br />5-min-load: (.*)<br />1-min-load: (.*)<br />CPU-user%: (.*)<br />CPU-idle%: (.*)<br />Free-space: (.*)#',$stats,$matches);
	list(,$mempercent,$swappercent,$load_15,$load_5,$load_1,$cpu_usage,$cpu_idle,$freespace)=$matches;
	if (intval($freespace)<1024*1024*1024) return NULL;
	$av_load=(floatval($load_15)+floatval($load_5)+floatval($load_1))/3.0;
	return $av_load;
}

/**
 * Find the best server.
 *
 * @return ID_TEXT	 The best server.
 */
function choose_available_server()
{
	$servers=find_all_servers();
	$lowest_load=NULL;
	$lowest_for=NULL;
	foreach ($servers as $server)
	{
		$server_load=find_server_load($server);
		if (is_null($server_load)) continue;
		if ((is_null($lowest_load)) || ($server_load<$lowest_load))
		{
			$lowest_load=$server_load;
			$lowest_for=$server;
		}
	}
	return $lowest_for;
}

/**
 * Do a backup.
 */
function do_backup_script()
{
	require_lang('myocp');

	$id=get_param('id');
	$sites=$GLOBALS['SITE_DB']->query_select('sites',array('s_member_id','s_server'),array('s_codename'=>$id),'',1);
	if (!array_key_exists(0,$sites)) warn_exit(do_lang_tempcode('MISSING_RESOURCE'));
	$member_id=$sites[0]['s_member_id'];
	if ($member_id!=get_member()) access_denied('I_ERROR');
	$server=$sites[0]['s_server'];

	// Create data
	require_code('zip');
	$file_array=zip_scan_folder(special_myocp_dir().'/servers/'.filter_naughty($server).'/sites/'.filter_naughty($id));
	$tmp_path=tempnam((((str_replace(array('on','true','yes'),array('1','1','1'),strtolower(ini_get('safe_mode')))=='1') || ((ini_get('open_basedir')!='') && (strpos(ini_get('open_basedir'),'/tmp')===false)))?get_custom_file_base().'/uploads/attachments/':'/tmp/'),'');
	$user=substr(md5('myocp_site_'.$id),0,16);
	shell_exec('mysqldump -h'./*$server*/'localhost'.' -u'.$user.' -p'.$GLOBALS['SITE_INFO']['mysql_myocp_password'].' myocp_site_'.$id.' --skip-opt > '.$tmp_path);
	$file_array[]=array('full_path'=>$tmp_path,'name'=>'database.sql','time'=>time());
	$data=create_zip_file($file_array);
	unlink($tmp_path);

	// Send header
	header('Content-Type: application/octet-stream');
	header('Content-Disposition: attachment; filename="backup-'.date('Y-m-d').'.zip"');
	header('Content-Transfer-Encoding: binary');
	header('Accept-Ranges: bytes');

	// Default to no resume
	$from=0;
	$new_length=strlen($data);

	// They're trying to resume (so update our range)
	$httprange=ocp_srv('HTTP_RANGE');
	if (strlen($httprange)>0)
	{
		$_range=explode('=',ocp_srv('HTTP_RANGE'));
		if (count($_range)==2)
		{
			if (strpos($_range[0],'-')===false) $_range=array_reverse($_range);
			$range=$_range[0];
			if (substr($range,-1,1)=='-') $range.=strval($new_length-1);
			$bits=explode('-',$range);
			if (count($bits)==2)
			{
				header('Content-Range: '.$range.'/'.strval($new_length));
				list($from,$to)=$bits;
				$new_length=$to-$from+1;
			}
		}
	}
	header('Content-Length: '.strval($new_length));
	@set_time_limit(0);
	error_reporting(0);

	// Send actual data
	echo substr($data,$from,$new_length);
}

/**
 * Delete demo sites over MYOCP_DEMO_LAST_DAYS days old.
 */
function myocp_delete_old_sites()
{
	// Expire sites
	$sites=$GLOBALS['SITE_DB']->query('SELECT s_codename,s_server FROM '.get_table_prefix().'sites WHERE s_add_time<'.strval(time()-60*60*24*MYOCP_DEMO_LAST_DAYS).' AND '.db_string_not_equal_to('s_codename','shareddemo'));
	foreach ($sites as $site)
	{
		myocp_delete_site($site['s_server'],$site['s_codename'],true);
	}
	if (count($sites)!=0)
	{
		reset_aliases();
	}
	
	// Warning emails
	require_code('mail');
	$sites=$GLOBALS['SITE_DB']->query('SELECT s_codename FROM '.get_table_prefix().'sites WHERE s_add_time<'.strval(time()-60*60*24*20).' AND '.db_string_not_equal_to('s_codename','shareddemo').' AND s_sent_expire_message=0');
	foreach ($sites as $site)
	{
		$subject=do_lang('MO_EMAIL_EXPIRE_SUBJECT',$site['s_codename']);
		$message=do_lang('MO_EMAIL_EXPIRE_BODY',comcode_escape($site['s_codename']));
		$email_address=$GLOBALS['SITE_DB']->query_value_null_ok('sites_email','s_email_to',array('s_codename'=>$site['s_codename'],'s_email_from'=>'staff'));
		if (!is_null($email_address))
			mail_wrap($subject,$message,array($email_address));
		
		$GLOBALS['SITE_DB']->query_update('sites',array('s_sent_expire_message'=>1),array('s_codename'=>$site['s_codename']),'',1);
	}
}

/**
 * Delete a site from myOCP.
 *
 * @param  ID_TEXT	The server to delete from.
 * @param  ID_TEXT	The site.
 * @param  boolean	Whether this is a bulk delete (in which case we don't want to do a config file reset each time).
 */
function myocp_delete_site($server,$codename,$bulk=false)
{
	// Database
	$master_conn=new database_driver(get_db_site(),'localhost'/*$server*/,'root',$GLOBALS['SITE_INFO']['mysql_root_password'],'ocp_');
	$master_conn->query('DROP DATABASE IF EXISTS `myocp_site_'.$codename.'`');
	$user=substr(md5('myocp_site_'.$codename),0,16);
	$master_conn->query('REVOKE ALL ON `myocp_site_'.$codename.'`.* FROM \''.$user.'\'',NULL,NULL,true);
//	$master_conn->query('DROP USER \'myocp_site_'.$codename.'\'');

	$GLOBALS['SITE_DB']->query_delete('sites_deletion_codes',array('s_codename'=>$codename),'',1);
	$GLOBALS['SITE_DB']->query_update('sites_email',array('s_codename'=>$codename.'__expired_'.strval(rand(0,100))),array('s_codename'=>$codename),'',1,NULL,false,true);

	// Directory entry
	$GLOBALS['SITE_DB']->query_delete('sites',array('s_codename'=>$codename),'',1);

	// Files
	if ($codename!='')
	{
		$path=special_myocp_dir().'/servers/'.filter_naughty($server).'/sites/'.filter_naughty($codename);
		if (file_exists($path))
		{
			require_code('files2');
			deldir_contents($path);
			rmdir($path);
		}
	}

	if (!$bulk)
	{
		reset_aliases();
	}
	reset_info_php($server);

	// Special
	//$GLOBALS['SITE_DB']->query_delete('sites_email',array('s_codename'=>$codename));
}
