<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/en/licence.txt for full licencing information.

*/

global $ocPortal_path;

error_reporting(E_ALL);
ini_set('display_errors','1');

require_once('lib.php');
$type=isset($_GET['type'])?$_GET['type']:'0';

echo do_header('ocPortal bug fix deployment tool');

global $git_path;
$git_path='git';
$git_result=shell_exec($git_path.' --help 2>&1');
if (strpos($git_result,'git: command not found')!==false)
{
	if (file_exists('/usr/local/git/bin/git')) $git_path='/usr/local/git/bin/git';
	elseif (file_exists('C:\\Program Files (x86)\\Git\\bin\\git.exe')) $git_path='"C:\\Program Files (x86)\\Git\\bin\\git.exe"';
}

// Actualisation
// =============

if (strtoupper($_SERVER['REQUEST_METHOD'])=='POST')
{
	$git_commit_id=$_POST['git_commit_id'];

	$done=array();
	$version=$_POST['version'];
	$title=$_POST['title'];
	$notes=$_POST['notes'];
	$affects=$_POST['affects'];
	if (isset($_POST['fixed_files']))
	{
		$fixed_files=$_POST['fixed_files'];
	} else
	{
		$fixed_files=array();
		chdir($ocPortal_path);
		$git_command=$git_path.' show --pretty="format:" --name-only '.$git_commit_id;
		$git_result=shell_exec($git_command.' 2>&1');
		$_fixed_files=explode(chr(10),$git_result);
		$fixed_files=array();
		foreach ($_fixed_files as $file)
		{
			if ($file!='') $fixed_files[]=$file;
		}
	}

	// Find what addons are involved with this
	$is_addon=false;
	$addons_involved=array();
	foreach ($fixed_files as $file)
	{
		if (strpos($file,'_custom')!==false)
		{
			$is_addon=true;
			$addon_files=explode(chr(10),file_get_contents($ocPortal_path.'/data_custom/addon_files.txt'));
			$current_addon='';
			foreach ($addon_files as $line)
			{
				if ($line=='') continue;
				if (($line[0]=='#') || ($line[0]=='-')) continue;
				if (substr($line,0,3)!=' - ')
				{
					$current_addon=$line;
				} else
				{
					if ($line==' - '.$file) $addons_involved[]=$current_addon;
				}
			}
		}
	}

	$submit_to=$_POST['submit_to'];
	global $remote_base_url;

	$remote_base_url=($submit_to=='live')?('http://ocportal.com'):('http://'.$_SERVER['HTTP_HOST'].dirname(dirname($_SERVER['REQUEST_URI'])).'/our-website/dev');

	// If no tracker issue number was given, one is made
	$tracker_id=intval($_POST['tracker_id']);
	$tracker_title=$title;
	$tracker_message=$notes;
	$tracker_additional='';
	if ($affects!='') $tracker_additional='Affects: '.$affects;
	if ($tracker_id==0)
	{
		// Make tracker issue
		$tracker_id=create_tracker_issue($version,$tracker_title,$tracker_message,$tracker_additional);
	} else
	{
		// Make tracker comment
		$tracker_comment_message='Automated response: '.$tracker_title."\n\n".$tracker_message."\n\n".$tracker_additional;
		create_tracker_post($tracker_id,$tracker_comment_message);
	}
	$tracker_url=$remote_base_url.'/tracker/view.php?id='.strval($tracker_id);

	// A git commit and push happens on the changed files, with the ID number of the tracker issue in it
	if ($git_commit_id=='')
	{
		$git_commit_message='Commited fix to issue #'.strval($tracker_id).' ('.$tracker_url.'). ['.$title.']';
		if ($submit_to=='live')
		{
			$git_commit_id=do_git_commit($git_commit_message,$fixed_files);
		} else
		{
			$git_commit_id='justtesting';
		}
	}
	if ($git_commit_id!==NULL)
	{
		$git_url='https://github.com/chrisgraham/ocPortal/commit/'.$git_commit_id;
		if ($_POST['git_commit_id']=='') $done['Commited to git']=$git_url;
	} else
	{
		$git_url=NULL;
	}

	// Make tracker comment with fix link
	$tracker_comment_message='';
	if ($git_commit_id!==NULL)
		$tracker_comment_message.='Fixed in git commit '.htmlentities($git_commit_id).' ('.htmlentities($git_url).' - link will become active once code pushed)'."\n\n";
	$tracker_comment_message.='A hotfix (a TAR of files to upload) have been uploaded to this issue. These files are made to the latest intra-version state (i.e. may roll in earlier fixes too if made to the same files) - so only upload files newer than what you have already. Always take backups of files you are replacing or keep a copy of the manual installer for your version, and only apply fixes you need. These hotfixes are not necessarily reliable or well supported. Not sure how to extract TAR files to your Windows computer? Try 7-zip (http://www.7-zip.org/).';
	create_tracker_post($tracker_id,$tracker_comment_message);
	// A tar of fixed files is uploaded to the tracker issue (correct relative file paths intact)
	upload_to_tracker_issue($tracker_id,create_hotfix_tar($tracker_id,$fixed_files));
	// The tracker issue gets closed
	close_tracker_issue($tracker_id);
	$done[($_POST['tracker_id']=='')?'Created new tracker issue':'Responded to existing tracker issue']=$tracker_url;

	// A bug is posted in the bugs catalogue, linking to the tracker
	$post_to_bug_catalogue=isset($_POST['post_to_bug_catalogue']);
	if ($post_to_bug_catalogue)
	{
		$ce_title=$title;
		$ce_description=$notes;
		$ce_affects=$affects;
		$ce_fix='This issue is properly filed (and managed) on the tracker. See issue [url="#'.strval($tracker_id).'"]'.$tracker_url.'[/url].';
		$entry_id=post_in_bugs_catalogue($version,$ce_title,$ce_description,$ce_affects,$ce_fix);
		$ce_url=$remote_base_url.'/site/catalogues/entry/'.strval($entry_id).'.htm';
		$done['Added to bugs catalogue']=$ce_url;
	}

	// If a forum post ID was given, an automatic reply is given pointing to the tracker issue
	$post_id=intval($_POST['post_id']);
	if ($post_id!=0)
	{
		$post_reply_title='Automated fix message';
		$post_reply_message='This issue has been filed on the tracker '.(($_POST['tracker_id']=='')?'as':'in').' issue [url="#'.strval($tracker_id).'"]'.$tracker_url.'[/url], with a fix.';
		$post_important=1;
		$reply_id=create_forum_post($post_id,$post_reply_title,$post_reply_message,$post_important);
		$reply_url=$remote_base_url.'/forum/topicview/findpost/'.strval($reply_id).'.htm';
		$done['Posted reply']=$reply_url;
	}

	// Problem solution system
	$recog_error_substring=$_POST['recog_error_substring'];
	if ($recog_error_substring!='')
	{
		$recog_post='Your error seems to match a known and fixed bug in ocPortal ('.$title.').'.chr(10).chr(10).'[title="2"]How did this happen?[/title]'.chr(10).chr(10).'The bug description is as follows...'.chr(10).chr(10).$notes.chr(10).chr(10).'[title="2"]How do I fix it?[/title]'.chr(10).chr(10).'A hotfix is available under issue [url="#'.strval($tracker_id).'"]'.$tracker_url.'[/url].';
		$recog_topic_id=create_forum_topic($forum_id,$recog_error_substring,$recog_post);
		$recog_topic_url=$remote_base_url.'/forum/topicview/misc/'.strval($recog_topic_id).'.htm';
		$done['Posted recognition signature']=$recog_topic_url;
	}

	// Show progress
	echo '<ol>';
	foreach ($done as $done_title=>$done_url)
	{
		echo '<li><a href="'.htmlentities($done_url).'">'.htmlentities($done_title).'</a></li>';
	}
	echo '</ol>';

	if (($is_addon) && (count($addons_involved)!=0))
	{
		echo '<p><strong>This was for an addon.</strong> Remember to run <kbd>data_custom/build_addons.php?addon_limit='.htmlentities(urlencode(implode(',',$addons_involved))).'</kbd> out of the repository URL, and then upload the appropriate addon TARs and post the has-updated comments.</p>';
	}

	echo do_footer();
	exit();
}

// UI
// ==

require_once($ocPortal_path.'/sources/version.php');
$on_disk_release=strval(ocp_version());
if (ocp_version_minor()!='') $on_disk_release.='.'.ocp_version_minor();

chdir($ocPortal_path);
$git_command=$git_path.' status';
$git_result=shell_exec($git_command.' 2>&1');
$lines=explode(chr(10),$git_result);
$git_found=array();
foreach ($lines as $line)
{
	$matches=array();
	if (preg_match('#\tmodified:\s+(.*)$#',$line,$matches)!=0)
	{
		if (($matches[1]!='data/files.dat') && ($matches[1]!='ocportal-git.clpprj') && ($matches[1]!='data_custom/execute_temp.php'))
			$git_found[$ocPortal_path.$matches[1]]=true;
	}
}
$files=(@$_GET['full_scan']=='1')?do_dir($ocPortal_path,$git_found):array_keys($git_found);

if (count($files)==0)
{
	echo '<p><em>Found no changed files so you will need to enter a git commit ID!</em> Pass <kbd>full_scan=1</kbd> if you want to do a filesystem scan (rather than relying on git).</p>';
	$git_status='required="required"';
	$git_status_2='';
	$git_status_3='<strong>Git commit ID</strong>';
} else
{
	$git_status='placeholder="optional"';
	$git_status_2=' <span style="font-size: 0.8em">(if not entered a new one will be made)</span>';
	$git_status_3='Git commit ID';
}

echo <<<END
<p>This script will push individual bug fixes to all the right places. Run it after you've developed a fix, and tell it how to link the fix in and what the fix is.</p>

<style>
label {
	float: left;
	width: 430px;
}
</style>

<form action="#" method="post">
	<fieldset>
		<legend>Classification</legend>

		<div>
			<label for="version">Version</label>
			<input step="0.1" required="required" name="version" id="version" type="text" value="{$on_disk_release}" />
		</div>

		<div>
			<label for="title">Bug summary</label>
			<input size="60" required="required" name="title" id="title" type="text" value="" />
		</div>

		<div>
			<label for="notes">Notes / Description</label>
			<textarea cols="40" rows="7" required="required" name="notes" id="notes"></textarea>
		</div>

		<div>
			<label for="affects">Affects</label>
			<input size="40" name="affects" id="affects" type="text" value="" placeholder="optional" />
		</div>
	</fieldset>

	<fieldset>
		<legend>Recognition signature <em>(optional)</em></legend>

		<div>
			<label for="recog_error_substring">Error message substring <span style="font-size: 0.8em">(use <kbd>xxx</kbd> to make a wild-card)</span></label>
			<input size="40" name="recog_error_substring" id="recog_error_substring" type="text" value="" placeholder="optional" />
		</div>
	</fieldset>

	<fieldset>
		<legend>Post to</legend>

		<div>
			<label for="post_id">Forum post ID to reply to</label>
			<input name="post_id" id="post_id" type="number" value="" placeholder="optional" />
		</div>

		<div>
			<label for="tracker_id">Tracker ID to attach to <span style="font-size: 0.8em">(if not entered a new one will be made)</span></label>
			<input onchange="this.form.elements['post_to_bug_catalogue'].checked=false;" name="tracker_id" id="tracker_id" type="number" value="" placeholder="optional" />
		</div>

		<div>
			<label for="post_to_bug_catalogue">Post to bug catalogue <span style="font-size: 0.8em">(if hotfix is worth advertising and issue is new)</span></label>
			<input checked="checked" type="checkbox" id="post_to_bug_catalogue" name="post_to_bug_catalogue" />
		</div>

		<div>
			<label for="git_commit_id">{$git_status_3}{$git_status_2}</label>
			<input name="git_commit_id" id="git_commit_id" type="text" value="" {$git_status} />
		</div>
	</fieldset>
END;

if (count($files)!=0)
{
echo <<<END
	<fieldset>
		<legend>Fix</legend>

		<label for="fixed_files">Choose files</label>
		<select size="15" required="required" multiple="multiple" name="fixed_files[]" id="fixed_files">
END;
		foreach ($files as $file)
		{
			$git_dirty=isset($git_found[$file]);
			$file=preg_replace('#^'.preg_quote($ocPortal_path,'#').'#','',$file);
			echo '<option'.($git_dirty?' selected="selected"':'').'>'.htmlentities($file).'</option>';
		}
echo <<<END
		</select>
	</fieldset>
END;
}

echo <<<END
	<fieldset>
		<legend>Submission</legend>

		<div>
			<label for="password">Master password for ocPortal.com</label>
			<input autocomplete="autocomplete" required="required" name="password" id="password" type="password" value="" />
		</div>

		<div>
			<label style="margin-left: 430px; width: 10em" for="submit_to_test">
				Submit to test site
				<!-- remove disabled if testing -->
				<input disabled="disabled" name="submit_to" id="submit_to_test" type="radio" value="test" />
			</label>

			<label style="width: 10em" for="submit_to_live">
				Submit to live site
				<input name="submit_to" id="submit_to_live" type="radio" value="live" checked="checked" />
			</label>
		</div>
	</fieldset>

	<p style="margin-left: 440px;">
		<input type="submit" value="Submit fix" />
	</p>

	<p>
		<em>Once submitted, fixes to the fix should be handled using this tool again, to submit to the tracker ID that had been auto-created the first time.</em>
	</p>
</form>
END;

echo do_footer();

// API
// ===

function create_tracker_issue($version,$tracker_title,$tracker_message,$tracker_additional)
{
	$args=func_get_args();
	return intval(make_call(__FUNCTION__,array('parameters'=>$args)));
}

function create_tracker_post($tracker_id,$tracker_comment_message)
{
	$args=func_get_args();
	make_call(__FUNCTION__,array('parameters'=>$args));
}

function do_git_commit($git_commit_message,$files)
{
	global $git_path,$ocPortal_path;

	chdir($ocPortal_path);

	$cmd=$git_path.' commit';
	foreach ($files as $file)
	{
		$cmd.=' '.escapeshellarg($file);
	}
	$cmd.=' -m '.escapeshellarg($git_commit_message);
	$result=shell_exec($cmd.' 2>&1');

	$matches=array();
	if (preg_match('# ([\da-z]+)\]#',$result,$matches)!=0)
	{
		// Success, do a push too
		$cmd=$git_path.' push origin master';
		echo '<!--'.shell_exec($cmd.' 2>&1').'-->';

		return $matches[1];
	}

	// Error
	echo '<p>Failed to make a git commit: '.htmlentities($result).'</p><p>Command was: '.htmlentities($cmd).'</p>';
	//echo do_footer();
	//exit();
	return NULL;
}

function close_tracker_issue($tracker_id)
{
	$args=func_get_args();
	make_call(__FUNCTION__,array('parameters'=>$args));
}

function create_hotfix_tar($tracker_id,$files)
{
	global $ocPortal_path,$builds_path;
	if (!file_exists($builds_path.'/builds')) mkdir($builds_path.'/builds',0777);
	if (!file_exists($builds_path.'/builds/hotfixes')) mkdir($builds_path.'/builds/hotfixes',0777);
	chdir($builds_path.'/builds/hotfixes');
	$tar=((DIRECTORY_SEPARATOR=='\\')?('"'.dirname(__FILE__).'\\tar"'):'tar');
	$tar_path=$builds_path.'/builds/hotfixes/hotfix-'.strval($tracker_id).', '.date('Y-m-d ga').'.tar';
	$cmd=$tar.' cvf '.escapeshellarg(basename($tar_path)).' -C '.escapeshellarg($ocPortal_path); // Windows doesn't allow absolute path for 'f' option so we need to use 'f' & 'C' to do it
	foreach ($files as $file)
	{
		$cmd.=' '.escapeshellarg($file);
	}
	echo '<!--'.shell_exec($cmd.' 2>&1').'-->';
	return $tar_path;
}

function post_in_bugs_catalogue($version,$ce_title,$ce_description,$ce_affects,$ce_fix)
{
	$args=func_get_args();
	return intval(make_call(__FUNCTION__,array('parameters'=>$args)));
}

function create_forum_post($replying_to_post,$post_reply_title,$post_reply_message,$post_important)
{
	$args=func_get_args();
	return intval(make_call(__FUNCTION__,array('parameters'=>$args)));
}

function create_forum_topic($forum_id,$topic_title,$post)
{
	$args=func_get_args();
	return intval(make_call(__FUNCTION__,array('parameters'=>$args)));
}

function upload_to_tracker_issue($tracker_id,$tar_path)
{
	make_call('upload_to_tracker_issue',array('parameters'=>array($tracker_id)),$tar_path);
}

function make_call($call,$params,$file=NULL)
{
	$data=$params;
	$data['password']=$_POST['password'];
	if (is_null($file))
	{
		$data_url=http_build_query($data);
		$data_len=strlen($data_url);
		$header="Content-type: application/x-www-form-urlencoded\r\nContent-Length: $data_len\r\n";
	} else
	{
		list($header,$data_url)=make_post_request_with_attached_file($file,basename($file),$data);
	}

	$opts=array('http'=>
		array(
			'method'=>'POST',
			'header'=>$header,
			'content'=>$data_url,
		)
	);

	$context=stream_context_create($opts);

	global $remote_base_url;
	$result=file_get_contents($remote_base_url.'/data_custom/ocpcom_web_service.php?call='.urlencode($call),false,$context);
	if ($result=='Access Denied')
	{
		echo '<p>Access denied</p>';
		echo do_footer();
	}
	return $result;
}

function make_post_request_with_attached_file($filename,$file_path,$more_post_data)
{
	$multipart_boundary='--------------------------'.strval(microtime(true));

	$header='Content-Type: multipart/form-data; boundary='.$multipart_boundary;

	$file_contents=file_get_contents($file_path);
	
	$content="--".$multipart_boundary."\r\n".
				"Content-Disposition: form-data; name=\"upload\"; filename=\"".addslashes(basename($filename))."\"\r\n".
				"Content-Type: application/octet-stream\r\n\r\n".
				$file_contents."\r\n";

	// add some POST fields to the request too
	foreach ($more_post_data as $key=>$val)
	{
		if (is_array($val))
		{
			foreach ($val as $val2)
			{
				$content.=	"--".$multipart_boundary."\r\n".
								"Content-Disposition: form-data; name=\"".addslashes($key)."[]\"\r\n\r\n".
								$val2."\r\n";
			}
		} else
		{
			$content.=	"--".$multipart_boundary."\r\n".
							"Content-Disposition: form-data; name=\"".addslashes($key)."\"\r\n\r\n".
							$val."\r\n";
		}
	}

	// signal end of request (note the trailing "--")
	$content.="--".$multipart_boundary."--\r\n";
	return array($header,$content);
}

function do_dir($dir,$git_found)
{
	$out=array();
	$_dir=($dir=='')?'.':$dir;
	$dh=opendir($_dir);
	if ($dh)
	{
		while (($file=readdir($dh))!==false)
		{
			if ($file[0]!='.')
			{
				$path=$dir.((substr($dir,-1)!='/')?'/':'').$file;
				if (is_file($_dir.'/'.$file))
				{
					if ((filemtime($path)<time()-60*60*24) && (!isset($git_found[$path]))) continue;
					$out[]=$path;
				} elseif (is_dir($_dir.'/'.$file))
				{
					$out=array_merge($out,do_dir($path,$git_found));
				}
			}
		}
	}
	return $out;
}
