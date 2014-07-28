<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/en/licence.txt for full licencing information.

*/

restrictify();
@ini_set('ocproducts.xss_detect','0');

define('SOLUTION_FORUM',283); // The forum ID on ocPortal.com for problem solution posts

$_title=get_screen_title('ocPortal bugfix tool',false);
$_title->evaluate_echo();

$type=isset($_GET['type'])?$_GET['type']:'0';

require_code('version2');

global $GIT_PATH;
$GIT_PATH='git';
$git_result=shell_exec($GIT_PATH.' --help 2>&1');
if (strpos($git_result,'git: command not found')!==false)
{
	if (file_exists('/usr/local/git/bin/git')) $GIT_PATH='/usr/local/git/bin/git';
	elseif (file_exists('C:\\Program Files (x86)\\Git\\bin\\git.exe')) $GIT_PATH='"C:\\Program Files (x86)\\Git\\bin\\git.exe"';
}

// Actualisation
// =============

if (strtoupper(ocp_srv('REQUEST_METHOD'))=='POST')
{
	$git_commit_id=post_param('git_commit_id','');

	$done=array();
	$version_dotted=post_param('version');
	$title=post_param('title');
	$notes=post_param('notes','');
	$affects=post_param('affects','');
	if (!is_null(post_param('fixed_files',NULL)))
	{
		$fixed_files=explode(',',post_param('fixed_files'));
	} else
	{
		$fixed_files=array();
		$git_command=$GIT_PATH.' show --pretty="format:" --name-only '.$git_commit_id;
		$git_result=shell_exec($git_command.' 2>&1');
		$_fixed_files=explode("\n",$git_result);
		$fixed_files=array();
		foreach ($_fixed_files as $file)
		{
			if ($file!='') $fixed_files[]=$file;
		}
	}

	// Find what addons are involved with this
	require_code('addons2');
	$addons_involved=array();
	$hooks=find_all_hooks('systems','addon_registry');
	foreach ($fixed_files as $file)
	{
		foreach ($hooks as $addon=>$place)
		{
			if ($place=='sources_custom')
			{
				$addon_info=read_addon_info($addon);
				if (in_array($file,$addon_info['files']))
				{
					$addons_involved[]=$addon;
				}
			}
		}
	}

	$submit_to=post_param('submit_to');
	global $REMOTE_BASE_URL;

	$REMOTE_BASE_URL=($submit_to=='live')?(get_brand_base_url()):(get_base_url());

	// If no tracker issue number was given, one is made
	$tracker_id=post_param_integer('tracker_id',NULL);
	$tracker_title=$title;
	$tracker_message=$notes;
	$tracker_additional='';
	if ($affects!='') $tracker_additional='Affects: '.$affects;
	if ($tracker_id===NULL)
	{
		// Make tracker issue
		$tracker_id=create_tracker_issue($version_dotted,$tracker_title,$tracker_message,$tracker_additional);
	} else
	{
		// Make tracker comment
		$tracker_comment_message='Automated response: '.$tracker_title."\n\n".$tracker_message."\n\n".$tracker_additional;
		create_tracker_post($tracker_id,$tracker_comment_message);
	}
	$tracker_url=$REMOTE_BASE_URL.'/tracker/view.php?id='.strval($tracker_id);

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
		if (post_param('git_commit_id','')=='') $done['Commited to git']=$git_url;
	} else
	{
		$git_url=NULL;
	}

	// Make tracker comment with fix link
	$tracker_comment_message='';
	if ($git_commit_id!==NULL)
		$tracker_comment_message.='Fixed in git commit '.escape_html($git_commit_id).' ('.escape_html($git_url).' - link will become active once code pushed)'."\n\n";
	$tracker_comment_message.='A hotfix (a TAR of files to upload) have been uploaded to this issue. These files are made to the latest intra-version state (i.e. may roll in earlier fixes too if made to the same files) - so only upload files newer than what you have already. Always take backups of files you are replacing or keep a copy of the manual installer for your version, and only apply fixes you need. These hotfixes are not necessarily reliable or well supported. Not sure how to extract TAR files to your Windows computer? Try 7-zip (http://www.7-zip.org/).';
	create_tracker_post($tracker_id,$tracker_comment_message);
	// A tar of fixed files is uploaded to the tracker issue (correct relative file paths intact)
	upload_to_tracker_issue($tracker_id,create_hotfix_tar($tracker_id,$fixed_files));
	// The tracker issue gets closed
	close_tracker_issue($tracker_id);
	$done[(post_param('tracker_id','')=='')?'Created new tracker issue':'Responded to existing tracker issue']=$tracker_url;

	// A bug is posted in the bugs catalogue, linking to the tracker
	$post_to_bug_catalogue=!is_null(post_param('post_to_bug_catalogue',NULL));
	if ($post_to_bug_catalogue)
	{
		$ce_title=$title;
		$ce_description=$notes;
		$ce_affects=$affects;
		$ce_fix='This issue is properly filed (and managed) on the tracker. See issue [url="#'.strval($tracker_id).'"]'.$tracker_url.'[/url].';
		$entry_id=post_in_bugs_catalogue(get_version_pretty__from_dotted($version_dotted),$ce_title,$ce_description,$ce_affects,$ce_fix);
		$ce_url=$REMOTE_BASE_URL.'/site/catalogues/entry/'.strval($entry_id).'.htm';
		$done['Added to bugs catalogue']=$ce_url;
	}

	// If a forum post ID was given, an automatic reply is given pointing to the tracker issue
	$post_id=post_param_integer('post_id',NULL);
	if ($post_id!==NULL)
	{
		$post_reply_title='Automated fix message';
		$post_reply_message='This issue has been filed on the tracker '.((post_param('tracker_id','')=='')?'as':'in').' issue [url="#'.strval($tracker_id).'"]'.$tracker_url.'[/url], with a fix.';
		$post_important=1;
		$reply_id=create_forum_post($post_id,$post_reply_title,$post_reply_message,$post_important);
		$reply_url=$REMOTE_BASE_URL.'/forum/topicview/findpost/'.strval($reply_id).'.htm';
		$done['Posted reply']=$reply_url;
	}

	// Problem solution system
	$recog_error_substring=post_param('recog_error_substring','');
	if ($recog_error_substring!='')
	{
		$recog_post='Your error seems to match a known and fixed bug in ocPortal ('.$title.').'."\n\n".'[title="2"]How did this happen?[/title]'."\n\n".'The bug description is as follows...'."\n\n".$notes."\n\n".'[title="2"]How do I fix it?[/title]'."\n\n".'A hotfix is available under issue [url="#'.strval($tracker_id).'"]'.$tracker_url.'[/url].';
		$recog_topic_id=create_forum_topic(SOLUTION_FORUM,$recog_error_substring,$recog_post);
		$recog_topic_url=$REMOTE_BASE_URL.'/forum/topicview/misc/'.strval($recog_topic_id).'.htm';
		$done['Posted recognition signature']=$recog_topic_url;
	}

	// Show progress
	echo '<ol>';
	foreach ($done as $done_title=>$done_url)
	{
		echo '<li><a href="'.escape_html($done_url).'">'.escape_html($done_title).'</a></li>';
	}
	echo '</ol>';

	if (count($addons_involved)!=0)
	{
		$addons_involved=array_unique($addons_involved);
		echo '<p><strong>This was for a non-bundled addon.</strong> Remember to run <a href="'.escape_html(get_base_url()).'/adminzone/index.php?page=build_addons&amp;addon_limit='.escape_html(urlencode(implode(',',$addons_involved))).'">the addon update script</a>, and then upload the appropriate addon TARs and post the has-updated comments.</p>';
	}

	return;
}

// UI
// ==

require_code('version2');
$on_disk_version=get_version_dotted();

chdir(get_file_base());
$git_command=$GIT_PATH.' status';
$git_result=shell_exec($git_command.' 2>&1');
$lines=explode("\n",$git_result);
$git_found=array();
foreach ($lines as $line)
{
	$matches=array();
	if (preg_match('#\t(both )?modified:\s+(.*)$#',$line,$matches)!=0)
	{
		if (($matches[2]!='data/files.dat') && ($matches[2]!='ocportal-git.clpprj') && ($matches[2]!='data_custom/execute_temp.php'))
			$git_found[get_file_base().'/'.$matches[2]]=true;
	}
}
$files=(@$_GET['full_scan']=='1')?push_bugfix_do_dir(get_file_base(),$git_found):array_keys($git_found);

$git_status='placeholder="optional"';
$git_status_2=' <span style="font-size: 0.8em">(if not entered a new one will be made)</span>';
$git_status_3='Git commit ID';
$choose_files_label='Choose files';

if (count($files)==0)
{
	echo '<p><em>Found no changed files so done a full filesystem scan (rather than relying on git). You can enter a git ID or select files.</p>';
	$files=do_dir(get_file_base(),$git_found);
	/*$git_status='required="required"';
	$git_status_2='';*/
	$git_status_3='<strong>Git commit ID</strong>';
	$choose_files_label='<strong>Choose files</strong>';
}

$post_url=escape_html(static_evaluate_tempcode(get_self_url()));

echo <<<END
<p>This script will push individual bug fixes to all the right places. Run it after you've developed a fix, and tell it how to link the fix in and what the fix is.</p>

<style>
#bugfix_form label {
	float: left;
	width: 430px;
}
</style>

<form action="{$post_url}" method="post" id="bugfix_form">
	<fieldset>
		<legend>Classification</legend>

		<div>
			<label for="version">Version</label>
			<input step="0.1" required="required" name="version" id="version" type="text" value="{$on_disk_version}" />
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
			<input onchange="document.getElementById('fixed_files').required=(this.value=='');" name="git_commit_id" id="git_commit_id" type="text" value="" {$git_status} />
		</div>
	</fieldset>
END;

if (count($files)!=0)
{
echo <<<END
	<fieldset>
		<legend>Fix</legend>

		<label for="fixed_files">{$choose_files_label}</label>
		<select size="15" required="required" multiple="multiple" name="fixed_files[]" id="fixed_files">
END;
		foreach ($files as $file)
		{
			$git_dirty=isset($git_found[$file]);
			$file=preg_replace('#^'.preg_quote(get_file_base().'/','#').'#','',$file);
			echo '<option'.($git_dirty?' selected="selected"':'').'>'.escape_html($file).'</option>';
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
		<input class="buttons__proceed button_screen" type="submit" value="Submit fix" />
	</p>

	<p>
		<em>Once submitted, fixes to the fix should be handled using this tool again, to submit to the tracker ID that had been auto-created the first time.</em>
	</p>
</form>
END;

// API
// ===

function create_tracker_issue($version_dotted,$tracker_title,$tracker_message,$tracker_additional)
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
	global $GIT_PATH;

	chdir(get_file_base());

	$cmd=$GIT_PATH.' commit';
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
		$cmd=$GIT_PATH.' push origin master';
		echo '<!--'.shell_exec($cmd.' 2>&1').'-->';

		return $matches[1];
	}

	// Error
	echo '<p>Failed to make a git commit: '.escape_html($result).'</p><p>Command was: '.escape_html($cmd).'</p>';
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
	require_code('make_release');
	$builds_path=get_builds_path();
	if (!file_exists($builds_path.'/builds/hotfixes'))
	{
		mkdir($builds_path.'/builds/hotfixes',0777);
		fix_permissions($builds_path.'/builds/hotfixes',0777);
	}
	chdir($builds_path.'/builds/hotfixes');
	$tar=((DIRECTORY_SEPARATOR=='\\')?('tar'):'COPYFILE_DISABLE=1 tar');
	$tar_path=$builds_path.'/builds/hotfixes/hotfix-'.strval($tracker_id).', '.date('Y-m-d ga').'.tar';
	$cmd=$tar.' cvf '.escapeshellarg(basename($tar_path)).' -C '.escapeshellarg(get_file_base()); // Windows doesn't allow absolute path for 'f' option so we need to use 'f' & 'C' to do it
	foreach ($files as $file)
	{
		$cmd.=' '.escapeshellarg($file);
	}
	echo '<!--'.shell_exec($cmd.' 2>&1').'-->';
	return $tar_path;
}

function post_in_bugs_catalogue($version_pretty,$ce_title,$ce_description,$ce_affects,$ce_fix)
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
	make_call('upload_to_tracker_issue',array('parameters'=>array(strval($tracker_id))),$tar_path);
}

function make_call($call,$params,$file=NULL)
{
	$data=$params;
	$data['password']=post_param('password');
	if (is_null($file))
	{
		$data_url=http_build_query($data);
		$data_len=strlen($data_url);
		$header="Content-type: application/x-www-form-urlencoded\r\nContent-Length: $data_len\r\n";
	} else
	{
		list($header,$data_url)=make_post_request_with_attached_file(basename($file),$file,$data);
	}

	$opts=array('http'=>
		array(
			'method'=>'POST',
			'header'=>$header,
			'content'=>$data_url,
		)
	);

	$context=stream_context_create($opts);

	global $REMOTE_BASE_URL;
	$call_url=$REMOTE_BASE_URL.'/data_custom/ocportalcom_web_service.php?call='.urlencode($call);

	$result=@file_get_contents($call_url,false,$context);
	if ($result===false)
	{
		echo '
			<form method="post" target="_blank" action="'.escape_html($call_url).'">
		';
		foreach ($data as $key=>$val)
		{
			if (!is_array($val))
			{
				echo '<input type="hidden" name="'.escape_html($key).'" value="'.escape_html($val).'" />';
			} else
			{
				foreach ($val as $k2=>$v2)
				{
					if (!is_string($k2)) $k2=strval($k2);
					if (!is_string($v2)) $v2=strval($v2);
					echo '<input type="hidden" name="'.escape_html($key.'['.$k2.']').'" value="'.escape_html($v2).'" />';
				}
			}
		}
		echo '
				<input class="buttons__proceed button_screen" type="submit" value="Action failed: Try manually" />
			</form>
		';
	}
	if ($result=='Access Denied')
	{
		echo '<p>Access denied</p>';
	}
	return $result;
}

function make_post_request_with_attached_file($filename,$file_path,$more_post_data)
{
	$multipart_boundary='--------------------------'.strval(microtime(true));

	$header='Content-Type: multipart/form-data; boundary='.$multipart_boundary;

	$file_contents=file_get_contents($file_path);
	
	$content="--".$multipart_boundary."\r\n".
				"Content-Disposition: form-data; name=\"upload\"; filename=\"".addslashes($filename)."\"\r\n".
				"Content-Type: application/octet-stream\r\n\r\n".
				$file_contents."\r\n";

	// add some POST fields to the request too
	foreach ($more_post_data as $key=>$val)
	{
		if (is_array($val))
		{
			foreach ($val as $val2)
			{
				if (!is_string($val2)) $val2=strval($val2);

				$content.=	"--".$multipart_boundary."\r\n".
								"Content-Disposition: form-data; name=\"".addslashes($key)."[]\"\r\n\r\n".
								$val2."\r\n";
			}
		} else
		{
			if (!is_string($val)) $val=strval($val);

			$content.=	"--".$multipart_boundary."\r\n".
							"Content-Disposition: form-data; name=\"".addslashes($key)."\"\r\n\r\n".
							$val."\r\n";
		}
	}

	// signal end of request (note the trailing "--")
	$content.="--".$multipart_boundary."--\r\n";
	return array($header,$content);
}

function push_bugfix_do_dir($dir,$git_found)
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
					$out=array_merge($out,push_bugfix_do_dir($path,$git_found));
				}
			}
		}
	}
	return $out;
}
