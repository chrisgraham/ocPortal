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

/**
 * Rebuild the manifest.
 */
function make_files_manifest()
{
	$files=scan_for_files($ocPortal_path);
	$myfile=fopen($ocPortal_path.'/data/files.dat','wb');
	fwrite($myfile,serialize($files));
	fclose($myfile);
}

/**
 * Find all files we will have.
 *
 * @param  SHORT_TEXT	The directory we are scanning relative to
 * @param  array			List of files
 */
function scan_for_files($dir,$rela='',$pretend_dir='')
{
	//removed-assert

	$files=array();

	$dh=opendir($dir);
	while (($file=readdir($dh))!==false)
	{
		$is_dir=is_dir($dir.$file);
		if (must_skip($is_dir,$file,$pretend_dir)) continue;

		if (($is_dir) && (is_readable($dir.$file)))
		{
			if ($file!='sites')
			{
				$files=array_merge($files,scan_for_files($dir.$file.'/',$rela.$file.'/',$pretend_dir.$file.'/'));
			} else
			{
				$files=array_merge($files,scan_for_files($dir.$file.'/',$rela.$file.'/',$pretend_dir));
			}
		} else
		{
			$contents=file_get_contents($dir.$file,FILE_BINARY);
			if ($file=='version.php') $contents=preg_replace('/\d{10}/','',$contents);
			$files[$pretend_dir.$file]=(strpos($dir,'3.0.x')===false)?array(sprintf('%u',crc32(preg_replace('#[\r\n\t ]#','',$contents)))):1;
		}
	}
	return $files;
}

function make_installers()
{
	$FILE_ARRAY=array();
	$DIR_ARRAY=array();

	global $current_application;
	$current_application='make_installer';

	require_once('lib.php');

	$start_time=_microtime();
	header('Content-Type: application/xhtml+xml;');

	$skip_file_grab=(isset($_GET['skip_file_grab']) && ($_GET['skip_file_grab']=='1'));

	do_output(do_header('ocProducts automated installer creator').'<p>The ocPortal repository specified using the <var>$_GET</var> variable <var>repos</var> is being compiled and packed up into installation packages.</p>');

	global $ocPortal_path;

	if (!$skip_file_grab)
		require_once('make_files.php'); // Build up-to-date files.dat into main source code repository

	global $current_application;
	$current_application='make_installer';

	$total_files=0;
	$total_dirs=0;

	$builds_path=get_builds_path();
	if (!file_exists($builds_path.'/builds/build/'))
		mkdir($builds_path.'/builds/build/') OR exit('Could not make temporary build folder');
	if (!$skip_file_grab)
		deldir_contents($builds_path.'/builds/build/'.$_GET['repos'].'/');
	if (!file_exists($builds_path.'/builds/build/'.$_GET['repos'].'/'))
		mkdir($builds_path.'/builds/build/'.$_GET['repos'].'/') OR exit('Could not make repository build folder');

	include($ocPortal_path.'/sources/version.php');

	global $version;
	$version=ocp_version().'.'.ocp_version_minor();
	if (!file_exists($builds_path.'/builds/'.$version.'/'))
		mkdir($builds_path.'/builds/'.$version.'/') OR exit('Could not make version build folder');

	if (!$skip_file_grab)
	{
		@copy($ocPortal_path.'/install.php',$builds_path.'/builds/build/'.$_GET['repos'].'/install.php');
		if (!file_exists($ocPortal_path.'/sites'))
		{
			if (!file_exists($ocPortal_path.'/data_custom/errorlog.php'))
			{
				$myfile=fopen($ocPortal_path.'/data_custom/errorlog.php','wb');
				fwrite($myfile,"<?php return; ?'.'>\n");
				fclose($myfile);
			}
			if (!file_exists($ocPortal_path.'/data_custom/permissioncheckslog.php'))
			{
				$myfile=fopen($ocPortal_path.'/data_custom/permissioncheckslog.php','wb');
				fwrite($myfile,"<?php return; ?'.'>\n");
				fclose($myfile);
			}
		}

		// Get file data array
		do_output('<ul>');
		do_dir();
		do_output('</ul>');
	}
	global $FILE_ARRAY;

	// What we'll be building
	$bundled='ocportal-'.$version.'.tar';
	$quick_zip='ocportal_quick_installer-'.$version.'.zip';
	$manual_zip='ocportal_manualextraction_installer-'.$version.'.zip';
	$debian='debian-'.$version.'.tar';
	$mszip='ocportal-'.$version.'-webpi.zip'; // Aka msappgallery, related to webmatrix

	chdir($builds_path.'/builds/'.$version.'/');

	// Flags
	$make_quick=!isset($_GET['skip_quick']);
	$make_manual=!isset($_GET['skip_manual']);
	$make_bundled=!isset($_GET['skip_bundled']);
	$make_mszip=!isset($_GET['skip_mszip']);
	$make_debian=false;//!isset($_GET['skip_debian']);

	// Build quick installer
	if ($make_quick)
	{
		// Write out our installer data file
		$data_file=fopen($builds_path.'/builds/'.$version.'/data.ocp','wb');
		if ($_GET['repos']!='3.0.x')
		{
			require_once($ocPortal_path.'/sources/zip.php');
			$zip_file_array=array();
			foreach ($FILE_ARRAY as $filename=>$data)
			{
				$zip_file_array[]=array('time'=>filemtime($ocPortal_path.'/'.$filename),'data'=>$data,'name'=>$filename);
			}
			list($data,$offsets,$sizes)=create_zip_file($zip_file_array,false,true);
			fwrite($data_file,$data);
		} else
		{
			foreach ($FILE_ARRAY as $filename=>$data)
			{
				$offsets[$filename]=ftell($data_file);
				$sizes[$filename]=strlen($data);
				fwrite($data_file,$data);
			}
		}
		fclose($data_file);
		$archive_size=filesize($builds_path.'/builds/'.$version.'/data.ocp');
		$md5_test_path='uploads/banners/advertise_here.png';
		if (!file_exists($_GET['repos'].'/'.$md5_test_path)) $md5_test_path='data/images/advertise_here.png';
		$md5=md5(file_get_contents($builds_path.'/builds/build/'.$_GET['repos'].'/'.$md5_test_path));

		// Write out our PHP installer file
		$file_count=count($FILE_ARRAY);
		$size_list='';
		$offset_list='';
		$file_list='';
		foreach ($FILE_ARRAY as $path=>$_) // Current path->contents. We need number->path, so we can count through them without having to have the array with us. We end up with this in string form, as it goes in our file
		{
			do_file_output($path);
			$size_list.='\''.$path.'\'=>'.$sizes[$path].','."\n";
			$offset_list.='\''.$path.'\'=>'.$offsets[$path].','."\n";
			$file_list.='\''.$path.'\',';
		}

		$code=file_get_contents($ocPortal_path.'/install.php');
		$auto_installer=fopen($builds_path.'/builds/'.$version.'/install.php','wb');
		$installer_start="<?php
	global \$FILE_ARRAY,\$SIZE_ARRAY,\$OFFSET_ARRAY,\$DIR_ARRAY,\$myfile;
	\$OFFSET_ARRAY=array({$offset_list});
	\$SIZE_ARRAY=array({$size_list});
	\$FILE_ARRAY=array({$file_list});
	\$myfile=fopen('data.ocp','rb');
	if (\$myfile===false) exit('data.ocp missing / inaccessible');
	if (filesize('data.ocp')!={$archive_size}) exit('data.ocp not fully uploaded, or wrong version for this installer');
	if (md5(file_array_get('{$md5_test_path}'))!='{$md5}') exit('data.ocp corrupt. Must not be uploaded in text mode');

	function file_array_get(\$path)
	{
	global \$OFFSET_ARRAY,\$SIZE_ARRAY,\$myfile,\$FILE_BASE;

	if (substr(\$path,0,strlen(\$FILE_BASE.'/'))==\$FILE_BASE.'/')
		\$path=substr(\$path,strlen(\$FILE_BASE.'/'));

	if (!isset(\$OFFSET_ARRAY[\$path])) return;
	\$offset=\$OFFSET_ARRAY[\$path];
	\$size=\$SIZE_ARRAY[\$path];
	if (\$size==0) return '';
	fseek(\$myfile,\$offset,SEEK_SET);
	if (\$size>1024*1024)
	{
		return array(\$size,\$myfile,\$offset);
	}
	\$data=fread(\$myfile,\$size);
	return \$data;
	}

	function file_array_exists(\$path)
	{
	global \$OFFSET_ARRAY;
	return (isset(\$OFFSET_ARRAY[\$path]));
	}

	function file_array_get_at(\$i)
	{
	global \$FILE_ARRAY;
	\$name=\$FILE_ARRAY[\$i];
	return array(\$name,file_array_get(\$name));
	}

	function file_array_count()
	{
	return {$file_count};
	}
	";

		fputs($auto_installer,$installer_start);

		global $DIR_ARRAY;
		foreach ($DIR_ARRAY as $dir)
		{
			fputs($auto_installer,'$DIR_ARRAY[]=\''.$dir.'\';'."\n");
		}
		fputs($auto_installer,'?'.'>');
		fputs($auto_installer,$code);
		fclose($auto_installer);

		@unlink($quick_zip);
		$zip=((DIRECTORY_SEPARATOR=='\\')?('"'.dirname(__FILE__).'\\zip"'):'zip');
		//if (!file_exists($zip)) exit('InfoZip zip tool missing from install dir [or missing from Linux installation]');
		$cmd=$zip.' -r -9 "'.$quick_zip.'" data.ocp install.php';
		$output2=$cmd.':'."\n".shell_exec($cmd);
		$dir=getcwd();
		chdir(dirname(__FILE__));
		$cmd=$zip.' -r -9 "'.$dir.'/'.$quick_zip.'" readme.txt';
		$output2.=$cmd.':'."\n".shell_exec($cmd);
		chdir($dir);
		do_zip_output($quick_zip,$output2);
	}

/*
	The other ones are built up file-by-file
*/

	@mkdir('../build');
	@mkdir('../build/'.$_GET['repos']);
	chdir('../build/'.$_GET['repos']);

	// Build manual
	if ($make_manual)
	{
		@unlink('../'.$manual_zip);
		$zip=((DIRECTORY_SEPARATOR=='\\')?('"'.dirname(__FILE__).'\\zip"'):'zip');
		$zip=str_replace('..\\..\\','..\\..\\..\\',$zip);
		$cmd=$zip.' -r -9 "../../'.$version.'/'.$manual_zip.'" *';
		$output2=shell_exec($cmd);
		do_zip_output($manual_zip,$output2);
	}

	// Build bundled version (Installatron, Bitnami, ...)
	if ($make_bundled)
	{
		@unlink('../'.$bundled);
		@unlink('../'.$bundled.'.gz');
		copy($ocPortal_path.'/install.sql','install.sql');
		copy($ocPortal_path.'/info.php.template','info.php.template');
		$tar=((DIRECTORY_SEPARATOR=='\\')?('"'.dirname(__FILE__).'\\tar"'):'tar');
		$cmd=$tar.' -cvf "../../'.$version.'/'.$bundled.'" * --mode=a+X';
		$output2=shell_exec($cmd);
		$dir=getcwd();
		chdir(dirname(__FILE__));
		$cmd=$tar.' -rvf "'.$dir.'/../../'.$version.'/'.$bundled.'" readme.txt --mode=a+X';
		$output2.=shell_exec($cmd);
		chdir($dir);
		//$output2=do_zip($v,$output2);
		$gzip=((DIRECTORY_SEPARATOR=='\\')?('"'.dirname(__FILE__).'\\gzip"'):'gzip');
		$cmd=$gzip.' -n "../../'.$version.'/'.$bundled.'"';
		shell_exec($cmd);
		unlink('../../'.$version.'/'.$bundled);
		do_zip_output($bundled.'.gz',$output2);
	}

	// Build debian version
	if ($make_debian)
	{
		// To our correct versioned builds directory
		if (file_exists('../debian-build')) deldir_contents('../debian-build');
		@mkdir('../debian-build');
		chdir('../debian-build');

		// Take existing .tar.gz package, extract into "ocportal-<version>"
		@mkdir('ocportal-'.$version);
		copy($builds_path.'/builds/'.$version.'/ocportal-'.$version.'.tar.gz','ocportal-'.$version.'.tar.gz');
		$gunzip=((DIRECTORY_SEPARATOR=='\\')?('"'.dirname(__FILE__).'\\gunzip"'):'gunzip');
		$cmd=$gunzip.' ocportal-'.$version.'.tar.gz';
		shell_exec($cmd);
		$tar=((DIRECTORY_SEPARATOR=='\\')?('"'.dirname(__FILE__).'\\tar"'):'tar');
		@mkdir('ocportal-'.$version);
		chdir('ocportal-'.$version);
		$cmd=$tar.' xvf ../ocportal-'.$version.'.tar';
		echo shell_exec($cmd);
		chdir('..');

		// Filter out non-free stuff from "ocportal-<version>"
		unlink('ocportal-'.$version.'/sources/hooks/systems/addon_registry/jwplayer.php');
		unlink('ocportal-'.$version.'/data/flvplayer.swf');
		unlink('ocportal-'.$version.'/themes/default/templates/ATTACHMENT_FLV.tpl');
		unlink('ocportal-'.$version.'/themes/default/templates/COMCODE_FLV.tpl');
		unlink('ocportal-'.$version.'/themes/default/templates/GALLERY_VIDEO_FLV.tpl');
		unlink('ocportal-'.$version.'/themes/default/templates/JAVASCRIPT_JWPLAYER.tpl');
		unlink('ocportal-'.$version.'/sources/jsmin.php');
		unlink('ocportal-'.$version.'/themes/default/images/cedi_link.png');
		unlink('ocportal-'.$version.'/themes/default/images/calendar/birthday.png');
		unlink('ocportal-'.$version.'/themes/default/images/calendar/anniversary.png');
		unlink('ocportal-'.$version.'/themes/default/images/calendar/appointment.png');
		unlink('ocportal-'.$version.'/themes/default/images/calendar/general.png');
		unlink('ocportal-'.$version.'/themes/default/images/calendar/activity.png');
		unlink('ocportal-'.$version.'/themes/default/images/calendar/system_command.png');
		unlink('ocportal-'.$version.'/themes/default/images/calendar/duty.png');
		unlink('ocportal-'.$version.'/themes/default/images/calendar/festival.png');
		unlink('ocportal-'.$version.'/themes/default/images/calendar/commitment.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/move.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/of_catalogues.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/language.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/forums.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/chatrooms.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/view_this.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/polls.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/awards.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/set-own-profile.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/phpinfo.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/download_csv.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/ocp-logo.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/custom-comcode.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/permissionstree.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/redirect.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/orders.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/edit_one_catalogue.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/manage_images.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/top_keywords.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/ldap.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/edit_one.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/show_orders.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/xml.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/actionlog.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/multimods.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/edit_css.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/geolocate.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/bulkupload.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/ssl.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/page_views.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/newsletters.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/statistics_search.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/messaging.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/transactions.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/statistics_posting_rates.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/import_subscribers.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/security.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/cash_flow.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/usergroups.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/usergroups_temp.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/zones.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/occle.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/view_archive.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/pagewizard.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/deletelurkers.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/cms_home.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/import.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/edit_one_image.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/ipban.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/multisitenetwork.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/tickets.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/export.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/themewizard.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/findwinners.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/calendar.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/main_home.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/add_one.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/catalogues.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/addmember.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/authors.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/wordfilter.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/delete.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/cleanup.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/add_one_catalogue.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/errorlog.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/newsletter_from_changes.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/top_referrers.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/posttemplates.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/users_online.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/downloads.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/survey_results.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/import_csv.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/matchkeysecurity.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/subscribers.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/baseconfig.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/add_one_category.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/securitylog.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/backups.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/statistics.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/clear_stats.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/sitetree.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/invoices.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/news.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/admin_home.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/edit_this_catalogue.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/edit_one_video.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/comcode_page_edit.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/view_this_category.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/config.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/back.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/trackbacks.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/criticise_language.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/add_one_image.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/add_video_to_this.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/merge.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/edit_templates.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/debrand.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/edit_one_category.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/emoticons.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/statistics_demographics.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/pointslog.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/edit_this_category.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/add_image_to_this.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/zone_editor.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/profit_loss.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/add_to_catalogue.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/ecommerce.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/manage_themes.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/staff.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/pointstorelog.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/iotds.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/galleries.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/setupwizard.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/add_one_licence.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/add_one_video.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/pointstore.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/make_logo.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/addons.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/submits.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/load_times.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/undispatched.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/searchstats.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/investigateuser.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/quotes.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/banners.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/privileges.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/welcome_emails.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/realtime_rain.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/edit_one_licence.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/add_to_category.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/cedi.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/menus.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/customprofilefields.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/quiz.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/clubs.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/merge_members.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/edit_this.png');
		unlink('ocportal-'.$version.'/themes/default/images/bigicons/editmember.png');
		unlink('ocportal-'.$version.'/themes/default/images/newscats/entertainment.jpg');
		unlink('ocportal-'.$version.'/themes/default/images/newscats/art.jpg');
		unlink('ocportal-'.$version.'/themes/default/images/newscats/business.jpg');
		unlink('ocportal-'.$version.'/themes/default/images/newscats/general.jpg');
		unlink('ocportal-'.$version.'/themes/default/images/newscats/difficulties.jpg');
		unlink('ocportal-'.$version.'/themes/default/images/newscats/community.jpg');
		unlink('ocportal-'.$version.'/themes/default/images/newscats/technology.jpg');
		unlink('ocportal-'.$version.'/themes/default/images/cedi_link_hover.png');
		unlink('ocportal-'.$version.'/themes/default/images/recommend/twitter.gif');
		unlink('ocportal-'.$version.'/themes/default/images/recommend/stumbleupon.gif');
		unlink('ocportal-'.$version.'/themes/default/images/recommend/print.gif');
		unlink('ocportal-'.$version.'/themes/default/images/recommend/recommend.gif');
		unlink('ocportal-'.$version.'/themes/default/images/recommend/favorites.gif');
		unlink('ocportal-'.$version.'/themes/default/images/recommend/digg.gif');
		unlink('ocportal-'.$version.'/themes/default/images/recommend/facebook.gif');
		unlink('ocportal-'.$version.'/themes/default/images/results/dispatch.png');
		unlink('ocportal-'.$version.'/themes/default/images/results/hold.png');
		unlink('ocportal-'.$version.'/themes/default/images/results/add_note.png');
		unlink('ocportal-'.$version.'/themes/default/images/results/return.gif');
		unlink('ocportal-'.$version.'/themes/default/images/results/view.gif');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/move.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/language.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/forums.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/loadtimes.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/chatrooms.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/polls.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/awards.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/phpinfo.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/installgeolocationdata.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/unvalidated.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/ocp-logo.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/statistics_clear.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/redirect.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/ldap.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/xml.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/actionlog.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/configwizard.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/importdata.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/statistics_google.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/ssl.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/statistics_search.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/statistics_usersonline.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/messaging.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/transactions.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/cash_flow.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/usergroups.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/usergroups_temp.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/zones.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/occle.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/deletelurkers.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/ipban.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/tickets.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/export.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/themewizard.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/findwinners.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/calendar.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/catalogues.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/addmember.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/authors.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/wordfilter.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/cleanup.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/sitetreeeditor.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/errorlog.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/newsletter_from_changes.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/addpagewizard.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/posttemplates.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/ocpmainpage.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/customcomcode.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/downloads.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/survey_results.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/import_csv.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/matchkeysecurity.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/securitylog.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/backups.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/statistics.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/multimoderations.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/statistics_referrers.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/invoices.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/news.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/newsletter.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/comcode_page_edit.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/bulkuploadassistant.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/config.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/deletepage.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/trackbacks.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/criticise_language.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/setauthorprofile.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/mergemembers.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/debrand.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/emoticons.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/profit_loss.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/ecommerce.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/themes.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/staff.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/iotds.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/statistics_pageviews.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/permissiontree.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/pointstore.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/addons.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/submits.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/investigateuser.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/quotes.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/multisitenetworking.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/banners.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/privileges.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/welcome_emails.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/logowizard.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/points.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/cedi.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/menus.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/customprofilefields.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/quiz.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/flagrant.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/clubs.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/images.png');
		unlink('ocportal-'.$version.'/themes/default/images/pagepics/editmember.png');
		unlink('ocportal-'.$version.'/themes/default/images/under_construction_animated.gif');
		unlink('ocportal-'.$version.'/themes/default/images/EN/page/amend.png');
		unlink('ocportal-'.$version.'/themes/default/images/EN/page/edit.png');
		unlink('ocportal-'.$version.'/themes/default/images/EN/page/redirect.png');
		unlink('ocportal-'.$version.'/themes/default/images/EN/page/cart_empty.png');
		unlink('ocportal-'.$version.'/themes/default/images/EN/page/all2.png');
		unlink('ocportal-'.$version.'/themes/default/images/EN/page/new.png');
		unlink('ocportal-'.$version.'/themes/default/images/EN/page/no_next.png');
		unlink('ocportal-'.$version.'/themes/default/images/EN/page/search.png');
		unlink('ocportal-'.$version.'/themes/default/images/EN/page/slideshow.png');
		unlink('ocportal-'.$version.'/themes/default/images/EN/page/cart_update.png');
		unlink('ocportal-'.$version.'/themes/default/images/EN/page/cart_checkout.png');
		unlink('ocportal-'.$version.'/themes/default/images/EN/page/next.png');
		unlink('ocportal-'.$version.'/themes/default/images/EN/page/convert.png');
		unlink('ocportal-'.$version.'/themes/default/images/EN/page/cart_view.png');
		unlink('ocportal-'.$version.'/themes/default/images/EN/page/discard.png');
		unlink('ocportal-'.$version.'/themes/default/images/EN/page/shopping_buy_now.png');
		unlink('ocportal-'.$version.'/themes/default/images/EN/page/quick_reply.png');
		unlink('ocportal-'.$version.'/themes/default/images/EN/page/delete.png');
		unlink('ocportal-'.$version.'/themes/default/images/EN/page/closed.png');
		unlink('ocportal-'.$version.'/themes/default/images/EN/page/changes.png');
		unlink('ocportal-'.$version.'/themes/default/images/EN/page/new_post.png');
		unlink('ocportal-'.$version.'/themes/default/images/EN/page/add_event.png');
		unlink('ocportal-'.$version.'/themes/default/images/EN/page/simple.png');
		unlink('ocportal-'.$version.'/themes/default/images/EN/page/cart_add.png');
		unlink('ocportal-'.$version.'/themes/default/images/EN/page/no.png');
		unlink('ocportal-'.$version.'/themes/default/images/EN/page/edit_tree.png');
		unlink('ocportal-'.$version.'/themes/default/images/EN/page/close.png');
		unlink('ocportal-'.$version.'/themes/default/images/EN/page/join.png');
		unlink('ocportal-'.$version.'/themes/default/images/EN/page/mark_unread.png');
		unlink('ocportal-'.$version.'/themes/default/images/EN/page/rename.png');
		unlink('ocportal-'.$version.'/themes/default/images/EN/page/cancel.png');
		unlink('ocportal-'.$version.'/themes/default/images/EN/page/ok.png');
		unlink('ocportal-'.$version.'/themes/default/images/EN/page/reply.png');
		unlink('ocportal-'.$version.'/themes/default/images/EN/page/staff_only_reply.png');
		unlink('ocportal-'.$version.'/themes/default/images/EN/page/login.png');
		unlink('ocportal-'.$version.'/themes/default/images/EN/page/no_previous.png');
		unlink('ocportal-'.$version.'/themes/default/images/EN/page/invite_member.png');
		unlink('ocportal-'.$version.'/themes/default/images/EN/page/mark_read.png');
		unlink('ocportal-'.$version.'/themes/default/images/EN/page/new_topic.png');
		unlink('ocportal-'.$version.'/themes/default/images/EN/page/shopping_continue.png');
		unlink('ocportal-'.$version.'/themes/default/images/EN/page/advanced.png');
		unlink('ocportal-'.$version.'/themes/default/images/EN/page/all.png');
		unlink('ocportal-'.$version.'/themes/default/images/EN/page/previous.png');
		unlink('ocportal-'.$version.'/themes/default/images/EN/page/ignore.png');
		unlink('ocportal-'.$version.'/themes/default/images/background_image.png');
		unlink('ocportal-'.$version.'/themes/default/images/filetypes/page_ods.png');
		unlink('ocportal-'.$version.'/themes/default/images/filetypes/page_media.png');
		unlink('ocportal-'.$version.'/themes/default/images/filetypes/page_archive.png');
		unlink('ocportal-'.$version.'/themes/default/images/filetypes/page_odp.png');
		unlink('ocportal-'.$version.'/themes/default/images/filetypes/page_torrent.png');
		unlink('ocportal-'.$version.'/themes/default/images/filetypes/feed.png');
		unlink('ocportal-'.$version.'/themes/default/images/filetypes/page_doc.png');
		unlink('ocportal-'.$version.'/themes/default/images/filetypes/page_txt.png');
		unlink('ocportal-'.$version.'/themes/default/images/filetypes/page_odt.png');
		unlink('ocportal-'.$version.'/themes/default/images/filetypes/page_xls.png');
		unlink('ocportal-'.$version.'/themes/default/images/filetypes/page_ppt.png');
		unlink('ocportal-'.$version.'/themes/default/images/filetypes/external_link.png');
		unlink('ocportal-'.$version.'/themes/default/images/filetypes/email_link.png');
		unlink('ocportal-'.$version.'/themes/default/images/filetypes/page_pdf.png');
		unlink('ocportal-'.$version.'/themes/default/images/awarded.png');

		// Create "ocportal-<version>.orig.tar.gz" package from "ocportal-<version>"
		$tar=((DIRECTORY_SEPARATOR=='\\')?('"'.dirname(__FILE__).'\\tar"'):'tar');
		$cmd=$tar.' -cvf "ocportal-'.$version.'.tar" ocportal-'.$version.'/* --mode=a+X';
		$output2=shell_exec($cmd);
		$gzip=((DIRECTORY_SEPARATOR=='\\')?('"'.dirname(__FILE__).'\\gzip"'):'gzip');
		$cmd=$gzip.' -n "ocportal-'.$version.'.tar"';
		shell_exec($cmd);

		// Copy "debian" directory into "ocportal-<version>"
		copy_r(dirname(__FILE__).'/debian','ocportal-'.$version.'/debian');

		// Tar up "ocportal-<version>" and "ocportal-<version>.tar.gz" together into "debian-<version>.tar"
		$tar=((DIRECTORY_SEPARATOR=='\\')?('"'.dirname(__FILE__).'\\tar"'):'tar');
		$cmd=$tar.' -cvf "../../'.$version.'/'.$debian.'" ocportal-'.$version.'/* ocportal-'.$version.'.tar.gz --mode=a+X';
		$output2=shell_exec($cmd);

		do_zip_output($debian,$output2);

		chdir('../'.$_GET['repos']);
	}

	// Build Microsoft version
	if ($make_mszip)
	{
		chdir('../');

		@unlink('../'.$version.'/'.$mszip);
		copy($ocPortal_path.'/info.php.template','info.php.template');
		rename($_GET['repos'].'/info.php','info.php');
		rename($_GET['repos'].'/install.sql','install.sql');
		rename($_GET['repos'].'/install.php','install.php');
		$zip=((DIRECTORY_SEPARATOR=='\\')?('"'.dirname(__FILE__).'\\zip"'):'zip');
		copy($ocPortal_path.'/install1.sql','install1.sql');
		copy($ocPortal_path.'/install2.sql','install2.sql');
		copy($ocPortal_path.'/install3.sql','install3.sql');
		copy($ocPortal_path.'/install4.sql','install4.sql');
		copy($ocPortal_path.'/user.sql','user.sql');
		copy($ocPortal_path.'/postinstall.sql','postinstall.sql');
		copy($ocPortal_path.'/manifest.xml','manifest.xml');
		copy($ocPortal_path.'/parameters.xml','parameters.xml');
		if (file_exists($builds_path.'/builds/build/ocportal/')) deldir_contents($builds_path.'/builds/build/ocportal/');
		rename($_GET['repos'],'ocportal');
		$cmd=$zip.' -r -9 -v "../'.$version.'/'.$mszip.'" ocportal manifest.xml parameters.xml install1.sql install2.sql install3.sql install4.sql user.sql postinstall.sql';
		$output2=shell_exec($cmd);
		rename('ocportal',$_GET['repos']);
		do_zip_output($mszip,$output2);
		rename('info.php',$_GET['repos'].'/info.php');
		rename('install.sql',$_GET['repos'].'/install.sql');
		rename('install.php',$_GET['repos'].'/install.php');
	}

	$finish_time=_microtime();

	$details='';
	if ($make_quick) $details.='<li>'.$quick_zip.' file size: '.filesize('../'.$version.'/'.$quick_zip).'KB</li>';
	if ($make_manual) $details.='<li>'.$manual_zip.' file size: '.filesize('../'.$version.'/'.$manual_zip).'KB</li>';
	if ($make_debian) $details.='<li>'.$debian.' file size: '.filesize('../'.$version.'/'.$debian).'KB</li>';
	if ($make_mszip) $details.='<li>'.$mszip.' file size: '.filesize('../'.$version.'/'.$mszip).'KB</li>';
	if ($make_bundled) $details.='<li>'.$bundled.'.gz file size: '.filesize('../'.$version.'/'.$bundled.'.gz').'KB</li>';

	do_output('
		<h2>Statistics</h2>
		<ul>
			<li>Total files compiled: '.$total_files.'</li>
			<li>Total directories traversed: '.$total_dirs.'</li>
			'.$details.'
			<li>Total execution time: '.($finish_time-$start_time).' seconds</li>
		</ul>'.do_footer());
}

function do_dir($dir='',$pretend_dir='')
{
	global $FILE_ARRAY,$DIR_ARRAY,$ocPortal_path,$meta_path,$builds_path;

	$full_dir=$ocPortal_path.$dir;
	$dh=opendir($full_dir);
	while (($file=readdir($dh))!==false)
	{
		$is_dir=is_dir($ocPortal_path.'/'.$dir.$file);

		if (must_skip($is_dir,$file,$pretend_dir)) continue;

		if ($is_dir)
		{
			if ($file!='sites')
			{
				$DIR_ARRAY[]=$dir.$file;
				@mkdir($builds_path.'/builds/build/'.$_GET['repos'].'/'.$pretend_dir.$file,0777);
				do_dir($dir.$file.'/',$pretend_dir.$file.'/');
			} else
			{
				do_dir($dir.$file.'/',$pretend_dir);
			}
		}
		else
		{
			if (($pretend_dir.$file)=='info.php') $FILE_ARRAY[$pretend_dir.$file]='';
			elseif (($pretend_dir.$file)=='themes/map.ini') $FILE_ARRAY[$pretend_dir.$file]='default=default'.chr(10);
			elseif ($pretend_dir.$file=='data_custom/functions.dat') $FILE_ARRAY[$pretend_dir.$file]='';
			elseif ($pretend_dir.$file=='pages/html_custom/EN/download_tree_made.htm') $FILE_ARRAY[$pretend_dir.$file]='';
			elseif ($pretend_dir.$file=='seedy/pages/html_custom/EN/cedi_tree_made.htm') $FILE_ARRAY[$pretend_dir.$file]='';
			elseif ($pretend_dir.$file=='data_custom/spelling/output.log') $FILE_ARRAY[$pretend_dir.$file]='';
			elseif ($pretend_dir.$file=='data_custom/spelling/write.log') $FILE_ARRAY[$pretend_dir.$file]='';
			elseif ($pretend_dir.$file=='ocp_sitemap.xml') $FILE_ARRAY[$pretend_dir.$file]='';
			elseif ($pretend_dir.$file=='data_custom/errorlog.php') $FILE_ARRAY[$pretend_dir.$file]="<?php return; ?".">\n"; // So that code can't be executed
			elseif ($pretend_dir.$file=='data_custom/execute_temp.php') $FILE_ARRAY[$pretend_dir.$file]=preg_replace('#function execute_temp\(\)\n\n\{\n.*\}\n\n#s',"function execute_temp()\n\n{\n}\n\n#",file_get_contents($ocPortal_path.$dir.$file));
			else $FILE_ARRAY[$pretend_dir.$file]=file_get_contents($ocPortal_path.$dir.$file);
			if ($pretend_dir.$file=='sources/version.php') $FILE_ARRAY[$pretend_dir.$file]=preg_replace('/\d{10}/',strval(time()),$FILE_ARRAY[$pretend_dir.$file],1);
			$tmp=fopen($builds_path.'/builds/build/'.$_GET['repos'].'/'.$pretend_dir.$file,'wb');
	 		fwrite($tmp,$FILE_ARRAY[$pretend_dir.$file]);
			fclose($tmp);
		}
	}

	do_directory_output($pretend_dir);
}

function do_file_output($path)
{
	global $total_files;
	$total_files++;
	do_output('<li>File "'.htmlentities($path).'" compiled.</li>');
}

function do_directory_output($path)
{
	global $total_dirs;
	$total_dirs++;
	do_output('<li>Directory "'.htmlentities($path).'" traversed.</li>');
}

function do_zip_output($file,$new_output)
{
	global $version,$builds_path;
	do_output('
<div class="zip_surround">
<h2>Compiling ZIP file "<a href="'.htmlentities($builds_path.'/builds/'.$version.'/'.$file).'" title="Download the file.">'.htmlentities($file).'</a>"</h2>
<p>'.trim(htmlentities($new_output)).'</p>
</div>');
}

function copy_r( $path, $dest )
{
	if( is_dir($path) )
	{
		@mkdir( $dest );
		$objects = scandir($path);
		if( sizeof($objects) > 0 )
		{
			foreach( $objects as $file )
			{
				if( $file == "." || $file == ".." )
					continue;
				// go on
				if( is_dir( $path.DIRECTORY_SEPARATOR.$file ) )
				{
					copy_r( $path.DIRECTORY_SEPARATOR.$file, $dest.DIRECTORY_SEPARATOR.$file );
				}
				else
				{
					copy( $path.DIRECTORY_SEPARATOR.$file, $dest.DIRECTORY_SEPARATOR.$file );
				}
			}
		}
		return true;
	}
	elseif( is_file($path) )
	{
		return copy($path, $dest);
	}
	else
	{
		return false;
	}
}

// Similar to ocPortal's should_ignore_file function, but has to be more specific. It is both more and less judicial - has to try and match what should bundle exactly including looking into custom dirs for stuff we know we must give templates for, ignores rest. Less configurable.
function must_skip($is_dir,$file,$dir,$upgrading=false,$allow_other_addons=false)
{
	global $ocPortal_path;

	if (($file=='.') || ($file=='..')) return true;

	if (is_dir($ocPortal_path.$dir.$file))
	{
		// Wrong lang packs
		if (($dir!='lang/') && (((strlen($file)==2) && (strtoupper($file)==$file) && (strtolower($file)!=$file)) || ($file=='EN_us') || ($file=='ZH-TW') || ($file=='ZH-CN')) && ($file!='EN'))
		{
			return true;
		}
		
		// Wrong zones
		if ((file_exists($ocPortal_path.$dir.$file.'/index.php')) && (file_exists($ocPortal_path.$dir.$file.'/pages')) && (!in_array($file,array('adminzone','collaboration','cms','forum','site','personalzone'))))
		{
			return true;
		}

		if (($dir=='exports/') && ($file=='static')) return true;

		// Wrong data_custom files
		if (($dir=='data_custom/') && ($file!='fonts') && ($file!='modules') && ($file!='sifr') && ($file!='spelling')) return true;
		
		// Wrong sources_custom files
		if (($dir=='sources_custom/') && ($file!='blocks') && ($file!='database') && ($file!='hooks') && ($file!='miniblocks')) return true;
		if ($dir=='sources_custom/hooks/blocks/') return true;
		if ($dir=='sources_custom/hooks/modules/') return true;
		if ($dir=='sources_custom/hooks/systems/') return true;
		
		// Wrong images_custom files
		if ($dir=='themes/default/images_custom/') return true;
	}

	$bad_root_files=array('www.pid','hphp-static-cache','hphp','hphp.files.list','facebook_connect.php','.gitattributes','.gitignore','ocworld','transcoder','killjunk.sh','restore.php','subs.inc','nbproject','_tests','_old','info-override.php','make_files-output-log.html','manifest.xml','parameters.xml','BingSiteAuth.xml','ocportal.heap','ocportal.sch','libocportal_u.dll','gc.log','.bash_history','ocportal.fcgi','.htaccess','info.php.template','install1.sql','install2.sql','install3.sql','install4.sql','user.sql','postinstall.sql','install.sql','install.php','no_mem_cache','install_ok','install_locked','registered.php','ocp.zpj','.project');
	if (((!$allow_other_addons) && ($file=='Gibb')) || ($file=='Gibberish') || ($file=='.svn') || ($file=='.git') || ($file=='myocp') || ($file=='docsformer') || ($file=='if_hosted_service.txt') || ($file=='Thumbs.db') || ($file=='Thumbs.db:encryptable') || ($file=='.DS_Store') || (!$allow_other_addons) && (substr($file,-4)=='.tar') || (substr($file,-7)=='.clpprj') || (substr($file,-7)=='.tmproj') || (substr($file,-3)=='.gz') || (substr($file,-2)=='.o') || (substr($file,-4)=='.scm') || ($file=='php.ini') || ($file=='CVS') || ($file=='WEB-INF') || (substr($file,0,5)=='_vti_')) return true;

	if ($dir=='')
	{
		if (in_array($file,$bad_root_files)) return true;
	}
	else
	{
		if (($dir=='uploads/website_specific/') && ($file!='index.html')) return true;
		if (($dir=='uploads/') && ((strpos($file,'addon_')!==false) || (strpos($file,'_addon')!==false))) return true;
		if ($dir=='data/images/docs/') return true;
		if ($dir=='data/images/ocproducts/') return true;
		if (($file=='ocp_sitemap.xml') && ($upgrading)) return true;
		if (($dir=='data/modules/admin_stats/') && (substr($file,-4)=='.xml')) return true;
		if (
			(
				(substr($dir,0,8)=='uploads/')
				 || (substr($dir,0,8)=='exports/')
				 || (substr($dir,0,8)=='imports/')
				 || ((strpos($dir,'_custom')!==false) && ($dir!='sources/hooks/blocks/main_custom_gfx/'))
			)
			&& (!$is_dir)
			&& ($file!='index.html')
			&& ($file!='.htaccess')
			&& ($file!='functions.dat')
			&& (($file!='fields.xml') || ($upgrading))
			&& (($file!='breadcrumbs.xml') || ($upgrading))
			&& (($file!='execute_temp.php') || ($upgrading))
			&& ($file!='ecommerce.log')
			&& (($file!='errorlog.php') || ($upgrading))
			&& (($file!='ocp_sitemap.xml') || ($upgrading))
			&& (($file!='write.log') || ($upgrading))
			&& (($file!='output.log') || ($upgrading))
			&& (($file!='download_tree_made.htm') || ($upgrading))
			&& (($file!='cedi_tree_made.htm') || ($upgrading))
		)
		 return true;
		if ($dir=='data/areaedit/plugins/SpellChecker/aspell/') return true;
		if ((($dir=='themes/default/templates_cached/EN/') || ($dir=='lang_cached/EN/') || ($dir=='persistant_cache/') || ($dir=='persistent_cache/')) && ($file!='index.html') && ($file!='.htaccess')) return true;
		if ((($dir=='themes/default/templates_cached/') || ($dir=='lang_cached/')) && ($file!='index.html') && ($file!='.htaccess') && ($file!='EN')) return true;
		if (($dir=='themes/') && (!in_array($file,array('default','index.html','map.ini')))) return true;
	}

	return false;
}

/**
 * Delete all the contents of a directory, and any subdirectories of that specified directory (recursively).
 *
 * @param  PATH			  The pathname to the directory to delete
 */
if (!function_exists('deldir_contents'))
{
	function deldir_contents($dir)
	{
		$current_dir=@opendir($dir);
		if ($current_dir!==false)
		{
			while (false!==($entryname=readdir($current_dir)))
			{
				if ((is_dir($dir.'/'.$entryname)) && ($entryname!='.') && ($entryname!='..'))
				{
					deldir_contents($dir.'/'.$entryname);
					rmdir($dir.'/'.$entryname);
				}
				elseif (($entryname!='.') && ($entryname!='..') /*&& ($entryname!='index.html') && ($entryname!='.htaccess')*/)
				{
					unlink($dir.'/'.$entryname);
				}
			}
			closedir($current_dir);
		}
	}
}

function _microtime()
{
	$time=explode(' ',microtime());
	return $time[1]+$time[0];
}

function flush_output()
{
	global $output,$current_application;
	$fh=fopen('./'.$current_application.'-output-log.html','w');
	fwrite($fh,$output);
	fclose($fh);

	die();
}

function get_builds_path()
{
	$builds_path=dirname(get_file_base()).'/builds';
	if (!file_exists($builds_path.'/builds'))
	{
		mkdir($builds_path.'/builds',0777) OR exit('Could not make master build folder');
		fix_permissions($builds_path.'/builds',0777);
	}
	return $builds_path;
}
