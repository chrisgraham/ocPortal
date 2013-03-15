<?php

$title=get_screen_title('Generate an upgrade',false);

$auto_probe=array();
$default_cutoff_days=intval(ceil((time()-filemtime(get_file_base().'/sources/version.php'))/60/60/24));
if ($default_cutoff_days<=1) $default_cutoff_days=100;
$cutoff_days=post_param_integer('cutoff_days',$default_cutoff_days);

$type=get_param('type','misc');

if ($type!='go')
{
	$title->evaluate_echo();

	echo '
		<p>This system will generate a TAR archive to upgrade a site to the files in this ocPortal installation. You choose which addons to include (both bundled and non-bundled are supported), and the date to get changed files from (both may be auto-detected from the install location).</p>
	';
}

$addons=get_addon_structure();

$manual_changes=array();
$manual_changes['maybe_delete']=array();
$manual_changes['css_diff']=array();
$manual_changes['install_diff']=array();

if ($type=='auto_probe')
{
	$probe_dir=post_param('probe_dir');

	require_code('files2');
	require_code('diff');
	$path=$probe_dir.'/sources/hooks/systems/addon_registry';
	if (file_exists($path))
	{
		// Via addon_registry hooks (bundled ones)
		$files=array();
		$files=array_merge($files,get_directory_contents($path,'',false,false));
		if (file_exists(str_replace('/sources/','/sources_custom/',$path)))
			$files=array_merge($files,get_directory_contents(str_replace('/sources/','/sources_custom/',$path),'',false,false));
		foreach ($files as $file)
		{
			if (substr($file,-4)=='.php') $auto_probe[]=basename($file,'.php');
		}

		// Via addons table (non-bundled ones)
		global $SITE_INFO;
		$backup=$SITE_INFO;
		require_once($probe_dir.'/info.php');
		$linked_db=new database_driver(get_db_site(),get_db_site_host(),get_db_site_user(),get_db_site_password(),get_table_prefix());
		$auto_probe+=collapse_1d_complexity('addon_name',$linked_db->query_select('addons',array('addon_name')));
		$SITE_INFO=$backup;

		// Via filesystem (non-bundled ones)
		$has_openid=in_array('openid',$auto_probe);
		foreach ($addons['non_bundled'] as $addon=>$files)
		{
			if ($addon=='utf8' || $addon=='simplified_emails') continue; // Two common false positives

			foreach ($files as $file)
			{
				if (file_exists($probe_dir.'/'.$file))
				{
					$auto_probe[]=$addon;
				}
			}
		}
		if ((!$has_openid) && (in_array('openid',$auto_probe)) && (in_array('facebook',$auto_probe))) // OpenID and Facebook shared files, probably they only wanted Facebook!
			unset($auto_probe[array_search('openid',$auto_probe)]);

		$auto_probe=array_unique($auto_probe);

		// Find oldest modified file that has been modified since
		$cutoff_days=0;
		$files=get_directory_contents($probe_dir);
		foreach ($files as $file)
		{
			$time=filemtime($probe_dir.'/'.$file);
			$latest_time=@filemtime(get_file_base().'/'.$file);
			if ($latest_time!==false)
			{
				if ($time!=$latest_time)
				{
					$old=file_get_contents($probe_dir.'/'.$file);
					$new=file_get_contents(get_file_base().'/'.$file);

					if ($old!=$new)
					{
						if ($time<$latest_time)
						{
							$days_diff=intval(ceil(($latest_time-$time)/60/60/24));
							if ($days_diff>$cutoff_days)
							{
								$cutoff_days=$days_diff;
							}
						}

						if (preg_match('#^themes/default/(css/[^/]*\.css|templates/[^/]*\.tpl)$#',$file)!=0)
						{
							// Looks for themes which may override
							$themes=get_directory_contents($probe_dir.'/themes','',false,false);
							foreach ($themes as $theme)
							{
								if ($theme=='map.ini') continue;
								if ($theme=='index.html') continue;

								$override_file=str_replace(
									array('themes/default/templates/','themes/default/css/'),
									array('themes/'.$theme.'/templates_custom/','themes/'.$theme.'/css_custom/'),
									$file
								).'.editfrom';

								if (file_exists($probe_dir.'/'.$override_file))
								{
									$theme_old=file_get_contents($probe_dir.'/'.$override_file);
									$theme_new=$new;
									$theme_old=preg_replace('#/\*.*\*/#sU','',$theme_old);
									$theme_new=preg_replace('#/\*.*\*/#sU','',$theme_new);
									if ($theme_new!=$theme_old)
									{
										$manual_changes['css_diff'][basename($override_file,'editfrom')]=diff_simple_2($theme_old,$theme_new,true);
									}
								}
							}
						}

						if (substr($file,-4)=='.php')
						{
							$matches=array();
							if (preg_match('#\n(\t*)function install(\_ocf)?\([^\n]*\)\n\\1\{\n(.*)\n\\1\}#sU',$old,$matches)!=0)
							{
								$old_install_code=$matches[3];
								$new_install_code='';
								if (preg_match('#\n(\t*)function install(\_ocf)?\([^\n]*\)\n\\1\{\n(.*)\n\\1\}#sU',$new,$matches)!=0)
								{
									$new_install_code=$matches[3];
								}
								if ($new_install_code!=$old_install_code)
								{
									$manual_changes['install_diff'][$file]=diff_simple_2($old_install_code,$new_install_code,true);
								}
							}
						}
					}
				}
			} else
			{
				if (!should_ignore_file($file,IGNORE_CUSTOM_DIR_CONTENTS | IGNORE_HIDDEN_FILES | IGNORE_CUSTOM_THEMES | IGNORE_CUSTOM_ZONES | IGNORE_REVISION_FILES | IGNORE_EDITFROM_FILES | IGNORE_BUNDLED_VOLATILE))
					$manual_changes['maybe_delete'][$file]=NULL;
			}
		}

		echo '
			<h2>Advice</h2>
		';
		foreach (
			array(
				'maybe_delete'=>'The following files might need deleting',
				'css_diff'=>'The following CSS/tpl changes have happened (diff; may need applying to overridden templates)',
				'install_diff'=>'The following install code changes have happened (diff) &ndash; isolate to <kbd>data_custom/execute_temp.php</kbd> to make an adhoc upgrader'
			) as $d=>$message)
		{
			echo '
				<p>
					'.$message.'&hellip;
				</p>
			';
			if (count($manual_changes[$d])!=0)
			{
				echo '<ul>';
				foreach ($manual_changes[$d] as $file=>$caption)
				{
					echo '<li>';
					echo '<kbd>'.escape_html($file).'</kbd>';
					if (!is_null($caption))
					{
						echo ':<br /><br />';
						/*require_code('geshi');
						$geshi=new GeSHi($caption,'diff');
						$geshi->set_header_type(GESHI_HEADER_DIV);
						echo $geshi->parse_code();*/
						echo '<div style="overflow: auto; width: 100%; white-space: pre">'.($caption).'</div>';
					}
					echo '</li>';
				}
				echo '</ul>';
			} else
			{
				echo '
					<p class="nothing_here">
						None
					</p>
				';
			}
		}

		attach_message('Settings have been auto-probed.','inform');
	} else
	{
		attach_message('This was not an ocPortal directory.','warn');
	}
}

if ($type=='go')
{
	$cutoff_point=time()-$cutoff_days*60*60*24;

	require_code('tar');
	$generate_filename='upgrade-to-git--'.get_timezoned_date(time(),false,false,false,true).'.tar';
	$gpath=get_custom_file_base().'/exports/addons/'.$generate_filename;
	$tar=tar_open($gpath,'wb');

	$probe_dir=post_param('probe_dir','');

	$done=array();

	foreach ($addons['non_bundled']+$addons['bundled'] as $addon=>$files)
	{
		if (post_param_integer('addon_'.$addon,0)==1)
		{
			foreach ($files as $file)
			{
				if (preg_match('#^(data\_custom/|ocp_sitemap.xml$|info.php$)#',$file)==0)
				{
					if (filemtime(get_file_base().'/'.$file)>$cutoff_point)
					{
						if (($probe_dir=='') || (@file_get_contents($probe_dir.'/'.$file)!==file_get_contents(get_file_base().'/'.$file)))
						{
							$new_filename=$file;
							if ((preg_match('#^(lang)\_custom/#',$file)!=0) && (($probe_dir=='') || (file_exists($probe_dir.'/'.$file))))
								$new_filename.='.quarantine';
							if (!isset($done[$new_filename]))
							{
								tar_add_file($tar,$new_filename,get_file_base().'/'.$file,fileperms(get_file_base().'/'.$file),filemtime(get_file_base().'/'.$file),true);
								$done[$new_filename]=true;
							}
						}
					}
				}
			}
		}
	}

	tar_close($tar);

	require_code('mime_types');
	header('Content-Type: '.get_mime_type('tar').'; authoritative=true;');
	header('Content-Disposition: filename="'.str_replace(chr(13),'',str_replace(chr(10),'',addslashes($generate_filename))).'"');
	$myfile=fopen($gpath,'rb');
	fpassthru($myfile);
	fclose($myfile);
	exit();
}

echo '
	<form action="'.escape_html(static_evaluate_tempcode(build_url(array('page'=>'_SELF','type'=>'auto_probe'),'_SELF'))).'" method="post">
		<h2>Auto-probe upgrade TAR settings, and give specialised advice</h2>

		<p>
			<label for="probe_dir">
				Directory
				<input size="50" type="text" name="probe_dir" id="probe_dir" value="'.dirname(get_file_base()).'/PROJECT_NAME'.'" />
			</label>
		</p>

		<p class="associated_details">
			Only run this on projects you trust - as info.php will be executed so as to connect to the project\'s database.
		</p>

		<p class="proceed_button">
			<input class="button_page" type="submit" value="Auto-probe" />
		</p>
	</form>
';

echo '
	<form action="'.escape_html(static_evaluate_tempcode(build_url(array('page'=>'_SELF','type'=>'go'),'_SELF'))).'" method="post">
		<h2>Manually customise upgrade TAR settings</h2>

		<p>
			<label for="cutoff_days">
				Files modified since (in days)
				<input style="width: 4em" max="3000" type="number" name="cutoff_days" id="cutoff_days" value="'.strval($cutoff_days).'" />
			</label>
		</p>
';

if (post_param('probe_dir','')!=='')
{
	echo '
		<input type="hidden" name="probe_dir" value="'.escape_html(post_param('probe_dir','')).'" />
	';
}

foreach (array_merge(array_keys($addons['bundled']),array_keys($addons['non_bundled'])) as $addon)
{
	$checked=(substr($addon,0,5)=='core_') || ($addon=='core') || (in_array($addon,$auto_probe));

	echo '
		<p>
			<label for="addon_'.escape_html($addon).'">
				<input '.($checked?' checked="checked"':'').'type="checkbox" value="1" name="addon_'.escape_html($addon).'" id="addon_'.escape_html($addon).'" />
				'.escape_html($addon).'
			</label>
		</p>
	';
}

echo '
		<p class="proceed_button">
			<input class="button_page" type="submit" value="Generate" />
		</p>
	</form>
';

function get_addon_structure()
{
	$struct=array('bundled'=>array(),'non_bundled'=>array());

	if (file_exists(get_file_base().'/sources_custom/dump_addons.php'))
	{
		require_code('dump_addons');
		$struct['non_bundled']=get_file_list_of_addons();
		ksort($struct['non_bundled']);
	} else
	{
		$struct['non_bundled']=array();
	}

	$hooks=find_all_hooks('systems','addon_registry');
	foreach (array_keys($hooks) as $hook)
	{
		require_code('hooks/systems/addon_registry/'.filter_naughty_harsh($hook));
		$hook_ob=object_factory('Hook_addon_registry_'.$hook,true);
		$file_list=$hook_ob->get_file_list();
		$_file_list=array();
		foreach ($file_list as $file)
		{
			if (preg_match('#^[^/]*\.tpl$#',$file)!=0)
			{
				$_file_list[]='themes/default/templates/'.$file;
			}
			elseif (preg_match('#^[^/]*\.css$#',$file)!=0)
			{
				$_file_list[]='themes/default/css/'.$file;
			} else
			{
				$_file_list[]=$file;
			}
		}
		$struct['bundled'][$hook]=$_file_list;
	}
	ksort($struct['bundled']);

	return $struct;
}
