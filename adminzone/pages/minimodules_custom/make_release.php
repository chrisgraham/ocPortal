<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		ocportal_release_build
 */

<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/en/licence.txt for full licencing information.

*/

require_once('lib.php');
$type=isset($_GET['type'])?$_GET['type']:'0';

echo do_header('ocPortal release assistance tool');

switch ($type)
{
	case '0':
		phase_0();
		break;
	case '1':
		phase_1();
		break;
	case '2':
		phase_2();
		break;
}

// Gather details
function phase_0()
{

	$skip=isset($_GET['skip'])?'1':'0';
	if ($skip=='1') $skip_check='checked="checked"'; else $skip_check='';

	echo <<<END
	<p>Have you run a code quality check on the non-module files (at the very least?). I am assuming that any non-trivial fixes have been tested.</p>
	<p>If this is a major release: have you done <a href="http://ocportal.com/forum/pg/topicview/findpost/16849#post_16849">all the post-dev prep work</a>? (there is also some post-release work not mentioned in this tool listed at that link)</p>
	<form method="post" action="make_release.php?type=1">
		<p>I am going to ask you some questions which will allow you to quickly make the decisions needed to get the whole release out without any additional thought. If you don't like these questions (such as finding them personally intrusive), I don't care&hellip; I am merely a machine, a device, working against a precomputed script. Now that is out of the way&hellip;</p>
		<hr />
		<fieldset>
			<legend>Version number</legend>
			<label for="version">What is the full version number (no bloody A, B, C, or D)?</label>
			<input maxlength="14" size="14" type="text" name="version" id="version" value="x.x.x" />
		</fieldset>
		<fieldset>
			<legend>Description</legend>
			<label for="descrip">Release description.</label>
			<input type="text" size="100" name="descrip" id="descrip" value="This version is a patch release that introduces a number of bug fixes since the last release" />
		</fieldset>
		<fieldset>
			<legend>Changes</legend>
			<label for="changes">What are the changes in this release? You might find the <a href="http://ocportal.com/site/pg/catalogues/index/bugs">bug report database</a> handy, as well as SVN diffs and sweet-smelling roses.</label>
			<textarea name="changes" id="changes" style="width: 100%" cols="40" rows="20">All reported bugs since the last release have been fixed (for a full list, see the [page="site:catalogues:index:bugs"]bugs catalogue[/page]).</textarea>
			</fieldset>
			<fieldset>
				<legend>Upgrade necessity</legend>
			<p>Upgrading is&hellip;</p>
			<input type="radio" name="needed" id="unrecommended" value="not recommended for live sites" /><label for="unrecommended">&hellip;not recommended for live sites&hellip;</label><br />
			<input type="radio" name="needed" id="not_needed" value="not necessary" /><label for="not_needed">&hellip;not necessary&hellip;</label><br />
			<input type="radio" name="needed" id="suggested" value="suggested" /><label for="suggested">&hellip;suggested&hellip;</label><br />
			<input type="radio" name="needed" id="advised" checked="checked" value="strongly advised" /><label for="advised">&hellip;strongly advised&hellip;</label><br />
			<label for="justification">&hellip;due to</label><input type="text" name="justification" id="justification" value="" />
		</fieldset>
		<fieldset>
			<legend>Repository details</legend>
			<label for="repos">The repository being compiled is&hellip;</label>
			<input type="text" name="repos" id="repos" value="{$_GET['repos']}" />
			<label for="root">and the repositories are located at&hellip;</label>
			<input type="text" size="100" name="root" id="root" value="{$_GET['root']}" />
		</fieldset>
		<fieldset>
			<legend style="display: none;">Submit</legend>
			<!--<p><strong>READ THIS&hellip;</strong> If you are making a new major release then you need to extract the first release of the last major version to <tt>builds/base/<strong>the-repos-codename-for-this-release</strong></tt>. If you are making a patch release then that directory should contain the first release of the major release we are updating (if this is the second update, it probably does already).</p>-->
			<input type="checkbox" name="skip" id="skip" value="1" {$skip_check} /><label for="skip">Installer<!--/Upgrader--> already compiled</label>
			<input type="checkbox" name="bleeding_edge" id="bleeding_edge" value="1" /><label for="bleeding_edge">Bleeding-edge release</label>
			<input type="submit" value="Shake it baby" />
		</fieldset>
	</form>
END;
}

function phase_1_pre()
{
$year=date('Y');
echo <<<END
As this is a substantial new release make sure you have done the following:
<ul>
	<li>Run the <a href="plug_guid.php" target="_blank">plug_guid.php</a> script to build needed GUIDs into the PHP.</li>
	<li>Update copyright dates in PHP code for the current year ({$year}).</li>
	<li>Build install.sql (taking into account it must run on different PHP versions- make sure the CREATE TABLE code is equivalent to the old version of the file, i.e. <tt> DEFAULT CHARSET=utf8</tt> is stripped).</li>
	<li>Build install*.sql by cutting up install.sql to the same boundaries as was used in the old versions of the files.</li>
	<li>Run the unit tests, with debug mode on, on the custom ocPortal PHP version.</li>
	<li>Run a HipHop PHP compile and looking at <kbd>hphp/CodeError.js</kbd> and make sure distributed code has no expected warnings</li>
	<li>Run a PHPStorm Code Inspection and see if any warning stands out as a bug</li>
	<li>Write custom theme upgrading code into sources/upgrade.php. Make sure all ocProducts themes are up-to-date (CSS changes, template changes, theme image changes).</li>
</ul>
END;

echo <<<END
	<form action="make_release.php?type=1" method="post">
		<input type="hidden" name="intermediary_tasks" value="1" />
END;
foreach ($_POST as $key=>$val)
{
	$_val=htmlentities($val);
echo <<<END
	<input type="hidden" name="{$key}" value="{$_val}" />
END;
}
echo <<<END
		<input type="submit" value="Okay, I've done these" />
	</form>
END;
}

// Build release files
function phase_1()
{
	$version=stripslashes($_POST['version']);
	$is_bleeding_edge=((isset($_POST['bleeding_edge'])) && ($_POST['bleeding_edge']=='1'));
	$is_substantial=(substr($version,-2)=='.0') || (strpos(strtolower($version),'beta1')!==false) || (strpos(strtolower($version),'rc1')!==false);

	if ((!isset($_POST['intermediary_tasks'])) && ($is_substantial) && (!$is_bleeding_edge))
	{
		phase_1_pre();
		return;
	}

	require_once('make_files.php');

	if(!isset($_POST['repos']))
	{
		do_output('<p class="error">Please specify a repository from which to build using the <var>$_POST</var> variable <var>repos</var>!</p>'.do_footer());
		flush_output();
	}

	if(!isset($_POST['root']))
	{
		do_output('<p class="error">Please specify the root path (<strong>including</strong> trailing slash) to use when building the installer using the <var>$_POST</var> variable <var>root</var>!</p>'.do_footer());
		flush_output();
	}

	if (($_POST['root']{strlen($_POST['root'])-1}!='/') && ($_POST['root']{strlen($_POST['root'])-1}!='\\')) $_POST['root'].='/';

	$repos=stripslashes($_POST['repos']);
	$root=stripslashes($_POST['root']);
	require_once($root.'/'.$repos.'/sources/version.php');
	$on_disk_release=strval(ocp_version());
	if (ocp_version_minor()!='') $on_disk_release.='.'.ocp_version_minor();
	if ($on_disk_release!=$version)
	{
		echo "<p>Hi monkey boy&hellip; you forgot to update <tt>sources/version.php</tt> with the correct version (or you gave me the wrong version). [{$on_disk_release} vs. {$version}]</p>";
	} else
	{
		$needed=htmlentities(stripslashes($_POST['needed']));
		$justification=htmlentities(stripslashes($_POST['justification']));
		$version=htmlentities(stripslashes($_POST['version']));
		$changes=htmlentities(stripslashes($_POST['changes']));
		$descrip=htmlentities(stripslashes($_POST['descrip']));
		if (substr($descrip,-1)=='.') $descrip=substr($descrip,0,strlen($descrip)-1);
		$bleeding_edge=htmlentities(isset($_POST['bleeding_edge'])?$_POST['bleeding_edge']:'0');

		if ((!array_key_exists('skip',$_POST)) || ($_POST['skip']!='1')) echo <<<END
		<p>I like you, so I'll make your life very easy. I'm opening the install maker <!--and upgrade makers--> in iframe<!--s-->.</p>
		<hr />
		<p>All your installs are belong to us&hellip;</p>
		<iframe src="make_installer.php?root={$root}&amp;repos={$repos}" style="width: 100%; height: 400px">Peek-a-boo</iframe>
		<!--<p>In soviet russia, upgraders make you&hellip;</p>
		<iframe src="make_upgrader.php?root={$root}&amp;repos={$repos}" style="width: 100%; height: 400px">Peek-a-boo</iframe>-->
		<hr />
		<p>I hope that worked. If it did, you must test the quick installer unless only very-minor non-install-related changes have been made!</p>
END;
echo <<<END
		<form action="make_release.php?type=2&amp;root={$root}&amp;repos={$repos}" method="post">
			<input type="hidden" name="needed" value="{$needed}" />
			<input type="hidden" name="justification" value="{$justification}" />
			<input type="hidden" name="version" value="{$version}" />
			<input type="hidden" name="bleeding_edge" value="{$bleeding_edge}" />
			<input type="hidden" name="changes" value="{$changes}" />
			<input type="hidden" name="descrip" value="{$descrip}" />
			<input type="submit" value="Move on to instructions about how to release this" />
		</form>
END;
	}
}

// Provide exacting instructions for making the release
function phase_2()
{
	$justification=stripslashes($_POST['justification']);
	if (substr($justification,-1)=='.') $justification=substr($justification,0,strlen($justification)-1);
	if ($justification!='') $justification=' due to '.$justification;

	$needed=stripslashes($_POST['needed']);
	$changes=stripslashes($_POST['changes']);

	$version=stripslashes($_POST['version']);
	$is_bleeding_edge=($_POST['bleeding_edge']=='1');
	$is_substantial=(substr($version,-2)=='.0') || (strpos(strtolower($version),'beta1')!==false) || (strpos(strtolower($version),'rc1')!==false);

	$descrip=stripslashes($_POST['descrip']);

	$push_url=htmlentities('http://ocportal.com/adminzone/index.php?page=make_ocportal_release&version='.urlencode($version).'&is_bleeding_edge='.($is_bleeding_edge?'1':'0').'&descrip='.urlencode($descrip).'&needed='.urlencode($needed).'&justification='.urlencode($justification));
	$_changes=htmlentities($changes);

	echo <<<END
<p>Here's a list of things for you to do. Get to it!</p>
<ol>
END;
if (!$is_bleeding_edge)
{
echo <<<END
	<li>
		If you are fixing a security issue, follow the security process. This may mean delaying the release for around a week and sending a newsletter telling people when exactly the upgrade will come.
	</li>
END;
}
echo <<<END
	<li>
		Upload all built files to ocPortal.com server (<kbd>uploads/downloads</kbd>)
	</li>
	<li>
		Run the <form target="_blank" style="display: inline" action="{$push_url}" method="post"><input type="hidden" name="changes" value="{$_changes}" /><input type="submit" value="ocPortal.com setup script" /></form>. Note if you are re-releasing, this will still work &ndash; it will update existing entries appropriately.
	</li>
END;

	if (!$is_bleeding_edge)
	{
		global $builds_path;
		$version_stripped=preg_replace('#(\.0)?\.0$#','',$version);
		$webpi=$builds_path.'/builds/'.$version.'/ocportal-'.$version_stripped.'-webpi.zip';
		$ms_filesize=number_format(filesize($webpi)).' bytes';
		$ms_sha1=sha1_file($webpi);

echo <<<END
	<li>Go into <a href="http://installatron.com/editor">Installatron</a> and setup a new release with the new version number (Main tab), update the URL (Version Info tab), and publish.</li>
	<li>E-mail <a href="mailto:punit@softaculous.com,brijesh@softaculous.com?subject=New ocPortal release&amp;body=Hi, this is an automated notification that a new release of ocPortal has been released - regards, the ocPortal team.">Softaculous people</a></li>
	<li><a href="http://www.microsoft.com/web/gallery/appsubmit.aspx?id=460">Submit the new MS Web App Gallery file to Microsoft</a>. Change the 'Version' the 'Package Location URL' and set the shasum to <kbd>'.$ms_sha1.'</kbd></li>
	<!--Disabled for now as not ready <li>Take "debian-{$version}.tar" to a debian box with correct signing key installed and do "tar xvf debian-{$version_stripped}.tar; cd ocportal-{$version_stripped} ; dpkg-buildpackage" and send 'ocportal_{$version_stripped}-1_i386.changes' and 'ocportal_{$version_stripped}-1_i386.changes' and 'ocportal_{$version_stripped}-1_all.deb' over</li>-->
END;
	}

	if ($is_substantial && !$is_bleeding_edge)
	{
echo <<<END
	<li>Import into Launchpad (run this from the <tt>lang/EN</tt> directory: <tt>ini2po . . -P ; tar -czvf "{$version_nice}.tar.gz" --transform="s,\(.*\)\.pot,\1/\1.pot," *.pot ; rm *.pot ; mv *.gz ~/Desktop</tt>). Also set as the new active branch and the old branch as 'supported' and the prior one as 'defunct'</li>
	<li>Update MyOCP (personal demo system)</li>
END;
	}

echo <<<END
</ol>
END;

echo <<<END
Marketing/management tasks (share the workload with other people):
<ul>
END;

echo <<<END
	<li>Where applicable upgrade client/our-own sites running ocPortal to the new version (see <tt>ocProducts documents/support and support:security accounts/clients_to_upgrade.txt</tt> and <tt>ocProducts documents/support and support:security accounts/clients_to_give_security_advice_to.txt</tt>).</li>
END;

	if ($is_substantial && !$is_bleeding_edge)
	{
echo <<<END
	<li><a href="http://ocportal.com/tracker/manage_proj_edit_page.php?project_id=1">add to tracker configuration</a> and also define any new addons in tracker</li>
	<li>Generate the new addon set (build_addons script), upload them (publish_addons_as_downloads script on server), and update the community page to point to the new addon locations</li>
	<li>Upload the latest new documentation (including changing the zone structure appropriately using symlinks - docs symlink to latest docs(version) zone)</li>
	<li>Update release history details on the ocPortal.com vision page</li>
	<li>Get someone to update our release history on Wikipedia</li>
	<li>Update listing on Hotscripts</li>
	<li><a href="http://ocportal.com/forum/topicview/misc/10343.htm">Syndicate news</a> (post in <a href="http://ocportal.com/forum/forumview/misc/marketing.htm">Marketing forum</a>)</li>
	<li>Send newsletter</li>
END;
	}

	if ($is_substantial && $is_bleeding_edge)
	{
echo <<<END
	<li>Contact VIPs with sneek previews? (If this is needed, don't post as a public release&hellip;)</li>
END;
	}

echo <<<END
</ul>
END;
}

echo do_footer();
