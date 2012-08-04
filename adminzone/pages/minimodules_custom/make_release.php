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

/*
This code is the frontend to make ocPortal builds.

If running on Windows, you need to install the following commands in your path...
 - Infozip's zip.exe and unzip.exe
 - gunzip.exe, gzip.exe, and tar.exe
*/

disable_php_memory_limit();

$type=get_param('type','0');

$title=get_screen_title('ocPortal release assistance tool - step '.strval(intval($type)+1).'/3',false);
$title->evaluate_echo();

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
	$skip_check=(get_param_integer('skip',0)==1)?'checked="checked"':'';

	require_code('version2');
	$on_disk_version=get_version_dotted();

	if (strpos($on_disk_version,'alpha')!==false)
		$release_description='This version is an alpha release of the next major version of ocPortal';
	elseif (strpos($on_disk_version,'beta')!==false)
		$release_description='This version is a beta release of the next major version of ocPortal';
	elseif (strpos($on_disk_version,'RC')!==false)
		$release_description='This version is a release candidate for the next major version of ocPortal';
	elseif (substr_count($on_disk_version,'.')<2)
		$release_description='This version is the gold release of the next version of ocPortal';
	else
		$release_description='This version is a patch release that introduces a number of bug fixes since the last release';

	$changes='All reported bugs since the last release have been fixed';
	if (strpos($release_description,'patch release')!==false)
		$changes.=' (for a full list, see the [page="site:catalogues:index:bugs"]bugs catalogue[/page]).';
	if (strpos($release_description,'gold')!==false) $changes='TODO';

	$post_url=static_evaluate_tempcode(get_self_url(false,false,array('type'=>'1')));

	echo '
	<p>Have you run a code quality check on the non-module files (at the very least?). I am assuming that any non-trivial fixes have been tested.</p>

	<form method="post" action="'.escape_html($post_url).'">
		<p>I am going to ask you some questions which will allow you to quickly make the decisions needed to get the whole release out without any additional thought. If you don\'t like these questions (such as finding them personally intrusive), I don\'t care&hellip; I am merely a machine, a device, working against a precomputed script. Now that is out of the way&hellip;</p>
		<hr />
		<fieldset>
			<legend>Version number</legend>
			<label for="version">What is the full version number (no bloody A, B, C, or D)?</label>
			<input maxlength="14" size="14" readonly="readonly" type="text" name="version" id="version" value="'.escape_html($on_disk_version).'" />
		</fieldset>
		<br />
		<fieldset>
			<legend>Description</legend>
			<label for="descrip">Release description.</label>
			<input type="text" size="100" name="descrip" id="descrip" value="'.escape_html($release_description).'" />
		</fieldset>
		<br />
		<fieldset>
			<legend>Changes</legend>
			<label for="changes">What are the changes in this release? You might find the <a href="http://ocportal.com/site/pg/catalogues/index/bugs">bug report database</a> handy, as well as git diffs and sweet-smelling roses.</label>
			<textarea name="changes" id="changes" style="width: 100%" cols="40" rows="20">'.escape_html($changes).'</textarea>
			</fieldset>
			<fieldset>
			<legend>Upgrade necessity</legend>
			<p>Upgrading is&hellip;</p>
			<input type="radio" name="needed" id="unrecommended" '.((strpos($release_description,'patch release')===false)?'checked="checked" ':'').'value="not recommended for live sites" /><label for="unrecommended">&hellip;not recommended for live sites&hellip;</label><br />
			<input type="radio" name="needed" id="not_needed" value="not necessary" /><label for="not_needed">&hellip;not necessary&hellip;</label><br />
			<input type="radio" name="needed" id="suggested" value="suggested" /><label for="suggested">&hellip;suggested&hellip;</label><br />
			<input type="radio" name="needed" id="advised" '.((strpos($release_description,'patch release')!==false)?'checked="checked" ':'').'value="strongly advised" /><label for="advised">&hellip;strongly advised&hellip;</label><br />
			<label for="justification">&hellip;due to</label><input type="text" name="justification" id="justification" value="" />
		</fieldset>
		<br />
		<fieldset>
			<legend style="display: none;">Submit</legend>
			<input type="checkbox" name="skip" id="skip" value="1" '.$skip_check.' /><label for="skip">Installer already compiled</label>
			<input type="checkbox" name="bleeding_edge" '.(((strpos($release_description,'patch release')===false) && (strpos($release_description,'gold')===false))?'checked="checked" ':'').'id="bleeding_edge" value="1" /><label for="bleeding_edge">Bleeding-edge release</label>
			<p><input type="submit" class="button_page" value="Shake it baby" /></p>
		</fieldset>
	</form>
	';
}

function phase_1_pre()
{
	$year=date('Y');
	echo '
	<p>As this is a substantial new release make sure you have done the following:</p>
	<ul>
		<li>Run the <a href="'.escape_html(static_evaluate_tempcode(build_url(array('page'=>'plug_guid'),'adminzone'))).'" target="_blank">plug_guid</a> tool to build needed GUIDs into the PHP.</li>
		<li>Update copyright dates in PHP code for the current year ('.escape_html($year).').</li>
		<li>Build <kbd>install.sql</kbd> (taking into account it must run on different PHP versions<!--- make sure the CREATE TABLE code is equivalent to the old version of the file, i.e. <tt>DEFAULT CHARSET=utf8</tt> is stripped)-->.</li>
		<li>Build <kbd>install*.sql</kbd> by cutting up <kbd>install.sql</kbd> to the same boundaries as was used in the old versions of the files.</li>
		<li>Run the <a href="'.escape_html(get_base_url().'/_test').'">unit tests</a><!--, with debug mode on, on the custom ocPortal PHP version-->.</li>
		<li>Run a HipHop PHP compile and looking at <kbd>hphp/CodeError.js</kbd> and make sure distributed code has no expected warnings</li>
		<li>Run a PHPStorm Code Inspection and see if any warning stands out as a bug</li>
		<li>Write custom theme upgrading code into <kbd>sources/upgrade.php</kbd>. Make sure all ocProducts themes are up-to-date (CSS changes, template changes, theme image changes).</li>
	</ul>
	';

	if (strpos(file_get_contents(get_file_base().'/install.sql'),'DEFAULT CHARSET=')!==false)
	{
		warn_exit('install.sql is not properly stripped down.');
	}
	if (strpos(file_get_contents(get_file_base().'/install1.sql'),file_get_contents(get_file_base().'/install.sql'))===false)
	{
		warn_exit('install1.sql seems out-dated, make sure install.sql is chopped up between install*.sql properly.');
	}

	$post_url=static_evaluate_tempcode(get_self_url(false,false,array('type'=>'1')));

	echo '
		<form action="'.escape_html($post_url).'" method="post">
			<input type="hidden" name="intermediary_tasks" value="1" />
	';
	foreach ($_POST as $key=>$val)
	{
		echo '
			<input type="hidden" name="'.escape_html($key).'" value="'.escape_html($val).'" />
		';
	}
	echo '
			<input class="button_page" type="submit" value="Okay, I\'ve done these" />
		</form>
	';
}

// Build release files
function phase_1()
{
	$version_dotted=post_param('version');
	$is_bleeding_edge=(post_param_integer('bleeding_edge',0)==1);
	$is_substantial=(substr($version_dotted,-2)=='.0') || (strpos($version_dotted,'beta1')!==false) || (strpos($version_dotted,'RC1')!==false);

	if ((post_param_integer('intermediary_tasks',0)==0) && ($is_substantial) && (!$is_bleeding_edge))
	{
		phase_1_pre();
		return;
	}

	require_code('make_release');

	$needed=post_param('needed');
	$justification=post_param('justification');
	$changes=post_param('changes');
	$descrip=post_param('descrip');
	if (substr($descrip,-1)=='.') $descrip=substr($descrip,0,strlen($descrip)-1);
	$bleeding_edge=($is_bleeding_edge?'1':'0');

	if (post_param_integer('skip',0)==0)
	{
		echo make_installers();
	}

	$post_url=static_evaluate_tempcode(get_self_url(false,false,array('type'=>'2')));

	echo '
		<form action="'.escape_html($post_url).'" method="post">
			<input type="hidden" name="needed" value="'.escape_html($needed).'" />
			<input type="hidden" name="justification" value="'.escape_html($justification).'" />
			<input type="hidden" name="version" value="'.escape_html($version_dotted).'" />
			<input type="hidden" name="bleeding_edge" value="'.escape_html($bleeding_edge).'" />
			<input type="hidden" name="changes" value="'.escape_html($changes).'" />
			<input type="hidden" name="descrip" value="'.escape_html($descrip).'" />

			<input type="submit" class="button_page" value="Move on to instructions about how to release this" />
		</form>
	';
}

// Provide exacting instructions for making the release
function phase_2()
{
	$justification=post_param('justification');
	if (substr($justification,-1)=='.') $justification=substr($justification,0,strlen($justification)-1);
	if ($justification!='') $justification=' due to '.$justification;

	$needed=post_param('needed');
	$changes=post_param('changes');
	$descrip=post_param('descrip');

	$version_dotted=post_param('version');
	$is_bleeding_edge=(post_param_integer('bleeding_edge',0)==1);
	$is_substantial=(substr($version_dotted,-2)=='.0') || (strpos($version_dotted,'beta1')!==false) || (strpos($version_dotted,'RC1')!==false);

	$push_url=brand_base_url().'/adminzone/index.php?page=make_ocportal_release&version='.urlencode($version_dotted).'&is_bleeding_edge='.($is_bleeding_edge?'1':'0').'&descrip='.urlencode($descrip).'&needed='.urlencode($needed).'&justification='.urlencode($justification);

	echo '
	<p>Here\'s a list of things for you to do. Get to it!</p>
	<ol>
	';
	if (!$is_bleeding_edge)
	{
		echo '
			<li>
				If you are fixing a security issue, follow the security process. This may mean delaying the release for around a week and sending a newsletter telling people when exactly the upgrade will come.
			</li>
		';
	}
	echo '
		<li>
			Upload all built files to ocPortal.com server (<kbd>uploads/downloads</kbd>)
		</li>
		<li>
			Run the <form target="_blank" style="display: inline" action="'.escape_html($push_url).'" method="post"><input type="hidden" name="changes" value="'.escape_html($changes).'" /><input type="submit" value="ocPortal.com setup script" /></form>. Note if you are re-releasing, this will still work &ndash; it will update existing entries appropriately.
		</li>
	';

	if (!$is_bleeding_edge)
	{
		$builds_path=get_builds_path();
		$webpi=$builds_path.'/builds/'.$version_dotted.'/ocportal-'.$version_dotted.'-webpi.zip';
		$ms_filesize=number_format(filesize($webpi)).' bytes';
		$ms_sha1=sha1_file($webpi);

		echo '
			<li>Go into <a href="http://installatron.com/editor">Installatron</a> and setup a new release with the new version number (Main tab), update the URL (Version Info tab), and publish.</li>
			<li>E-mail <a href="mailto:punit@softaculous.com,brijesh@softaculous.com?subject=New ocPortal release&amp;body=Hi, this is an automated notification that a new release of ocPortal has been released - regards, the ocPortal team.">Softaculous people</a></li>
			<li><a href="http://www.microsoft.com/web/gallery/appsubmit.aspx?id=460">Submit the new MS Web App Gallery file to Microsoft</a>. Change the \'Version\' the \'Package Location URL\' and set the shasum to <kbd>'.escape_html($ms_sha1).'</kbd></li>
			<!--Disabled for now as not ready <li>Take "debian-'.escape_html($version_dotted).'.tar" to a debian box with correct signing key installed and do "tar xvf debian-'.escape_html($version_dotted).'.tar; cd ocportal-'.escape_html($version_dotted).' ; dpkg-buildpackage" and send \'ocportal_'.escape_html($version_dotted).'-1_i386.changes\' and \'ocportal_'.escape_html($version_dotted).'-1_i386.changes\' and \'ocportal_'.escape_html($version_dotted).'-1_all.deb\' over</li>-->
		';
	}

	if ($is_substantial && !$is_bleeding_edge)
	{
		echo '
			<li>Import into Launchpad (run this from the <tt>lang/EN</tt> directory: <tt>ini2po . . -P ; tar -czvf "'.escape_html($version_dotted).'.tar.gz" --transform="s,\(.*\)\.pot,\1/\1.pot," *.pot ; rm *.pot ; mv *.gz ~/Desktop</tt>). Also set as the new active branch and the old branch as \'supported\' and the prior one as \'defunct\'</li>
			<li>Update MyOCP (personal demo system)</li>
		';
	}

	echo '
	</ol>
	';

	echo '
	<p>Marketing/management tasks (share the workload with other people):</p>
	<ul>
	';

	echo '
		<li>Where applicable upgrade client/our-own sites running ocPortal to the new version (see <tt>ocProducts documents/support &amp; security accounts/clients_to_upgrade.txt</tt> and <tt>ocProducts documents/support &amp; security accounts/clients_to_give_security_advice_to.txt</tt>).</li>
	';

	if ($is_substantial && !$is_bleeding_edge)
	{
		echo '
			<li><a href="http://ocportal.com/tracker/manage_proj_edit_page.php?project_id=1">add to tracker configuration</a> and also define any new addons in tracker</li>
			<li>Generate the new addon set (build_addons minimodule), upload them (publish_addons_as_downloads minimodule on server), and update the community page to point to the new addon locations</li>
			<li>Upload the latest new documentation (including changing the zone structure appropriately using symlinks - docs symlink to latest docs(version) zone)</li>
			<li>Update release history details on the ocPortal.com vision page</li>
			<li>Get someone to update our release history on Wikipedia</li>
			<li>Update listing on Hotscripts</li>
			<li><a href="http://ocportal.com/forum/topicview/misc/10343.htm">Syndicate news</a> (post in <a href="http://ocportal.com/forum/forumview/misc/marketing.htm">Marketing forum</a>)</li>
			<li>Send newsletter</li>
		';
	}

	if ($is_substantial && $is_bleeding_edge)
	{
		echo '
			<li>Contact VIPs with sneak previews? (If this is needed, don\'t post as a public release&hellip;)</li>
		';
	}

	echo '
	</ul>
	';
}
