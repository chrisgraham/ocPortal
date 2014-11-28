<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

restrictify();
safe_ini_set('ocproducts.xss_detect','0');

$_title=get_screen_title('ocPortal addon building tool',false);
$_title->evaluate_echo();

echo '<p>This has built all the addons into <kbd>exports/addons</kbd>. The make_release script you probably came from gives details on how to get these live on ocPortal.com.</p>';

echo '<p>What follows is details if you are republishing addons and want to easily put out "This is updated" messages into the comment topics. It\'s not necessary because just uploading the TARs will make the inbuilt ocPortal check script see the addon is updated compared to when a user installed it. However, it is nice to keep users updated if you have time.</p>';

echo '<hr />';

require_code('addons');
require_code('version');
require_code('version2');
require_code('dump_addons');

if (!file_exists(get_file_base().'/data_custom/addon_files.txt'))
{
	exit("File missing : <br />".get_file_base().'/data_custom/addon_files.txt');
}
if (!file_exists(get_file_base().'/data_custom/addon_details.csv'))
{
	exit("File missing : <br />".get_file_base().'/data_custom/addon_details.csv');
}

if (function_exists('set_time_limit')) @set_time_limit(0);

$only=get_param('only',NULL);

if (get_param_integer('export_bundled_addons',0)==1) // We are not normally concerned about these, but maybe it is useful sometimes
{
	$addons=find_all_hooks('systems','addon_registry');
	foreach (array_keys($addons) as $name)
	{
		if (($only!==NULL) && ($only!==$name)) continue;

		$addon_row=read_addon_info($name);

		// Archive it off to exports/addons
		if (file_exists(get_file_base().'/sources/hooks/systems/addon_registry/'.$name.'.php')) // New ocProducts style (assumes maintained by ocProducts if it's done like this)
		{
			$file=preg_replace('#^[\_\.\-]#','x',preg_replace('#[^\w\.\-]#','_',$name)).'.tar';
		} else // Traditional ocPortal style
		{
			$file=preg_replace('#^[\_\.\-]#','x',preg_replace('#[^\w\.\-]#','_',$name)).date('-dmY-Hm',time()).'.tar';
		}

		$new_addon_files=array();
		foreach ($addon_row['addon_files'] as $_file)
		{
			if (substr($_file,-9)!='.editfrom') // This would have been added back in automatically
				$new_addon_files[]=$_file;
		}

		create_addon($file,$new_addon_files,$addon_row['addon_name'],implode(',',$addon_row['addon_incompatibilities']),implode(',',$addon_row['addon_dependencies']),$addon_row['addon_author'],$addon_row['addon_organisation'],$addon_row['addon_version'],$addon_row['addon_description'],'exports/addons');
	}
	if ($only!==NULL) echo "<p>All bundled addons have been exported to 'export/addons/'</p>\n";
}

if (get_param_integer('export_addons',1)==1)
{
	$file_list=get_file_list_of_addons();
	$addon_list=get_details_of_addons();

	$_addon_limit=get_param('addon_limit','');
	$addon_limit=mixed();
	if ($_addon_limit!='')
	{
		$addon_limit=explode(',',$_addon_limit);
	}

	$version=ocp_version_number();

	foreach ($file_list as $addon_codename=>$files)
	{
		if ((!is_null($addon_limit)) && (!in_array($addon_codename,$addon_limit))) continue;

		if (($only!==NULL) && ($only!==$addon_codename)) continue;

		$file=$addon_codename.'-'.get_version_branch().'.tar';

		$name=titleify($addon_list[$addon_codename]['Addon name']);
		$author=$addon_list[$addon_codename]['Author'];
		$description=$addon_list[$addon_codename]['Help'];
		$dependencies=$addon_list[$addon_codename]['Requirements / Dependencies'];
		$incompatibilities=$addon_list[$addon_codename]['Incompatible with'];
		$category=$addon_list[$addon_codename]['Category'];
		$license=$addon_list[$addon_codename]['License'];
		$attribute=$addon_list[$addon_codename]['Attribute'];

		// Formalise dependencies
		$vs=explode(',',$dependencies);
		$dependencies='';
		foreach ($vs as $_v)
		{
			if ((!addon_installed($_v)) || (array_key_exists($_v,$addon_list)) || (!file_exists(get_file_base().'/exports/addons/'.$_v.'.tar')) || (!file_exists(get_file_base().'/imports/addons/'.$_v.'.tar')))
			{
				if ($dependencies!='') $dependencies.=',';
				$dependencies.=$_v;
			}
		}

		create_addon($file,$files,$name,$incompatibilities,$dependencies,$author,'ocProducts Ltd',float_to_raw_string($version,2,true),$description,'exports/addons');

		echo nl2br(escape_html(show_updated_comments_code($file,$name)));
	}
	if ($only!==NULL) echo "<p>All non-bundled addons have been exported to 'export/addons/'</p>\n";
}

if (get_param_integer('export_themes',0)==1)
{
	require_code('themes2');
	require_code('files2');
	$themes=find_all_themes();

	$page_files=get_directory_contents(get_custom_file_base().'/','');
	foreach (array_keys($themes) as $theme)
	{
		if (($only!==NULL) && ($only!==$theme)) continue;

		if ($theme=='default') continue;

		$name='';
		$description='';
		$author='ocProducts';
		$ini_file=(($theme=='default')?get_file_base():get_custom_file_base()).'/themes/'.filter_naughty($theme).'/theme.ini';
		if (file_exists($ini_file))
		{
			$details=better_parse_ini_file($ini_file);
			if (array_key_exists('title',$details)) $name=$details['title'];
			if (array_key_exists('description',$details)) $description=$details['description'];
			if ((array_key_exists('author',$details)) && ($details['author']!='admin')) $author=$details['author'];
		}

		$file='theme-'.preg_replace('#^[\_\.\-]#','x',preg_replace('#[^\w\.\-]#','_',$theme)).'-'.get_version_branch().'.tar';

		$files2=array();
		$theme_files=get_directory_contents(get_custom_file_base().'/themes/'.$theme,'themes/'.$theme);
		foreach ($theme_files as $file2)
		{
			if ((substr($file2,-4)!='.tcp') && (substr($file2,-4)!='.tcd') && (substr($file2,-9)!='.editfrom'))
				$files2[]=$file2;
		}
		foreach ($page_files as $file2)
		{
			$matches=array();
			$regexp='#^((\w+)/)?pages/comcode_custom/[^/]*/'.str_replace('#','\#',preg_quote($theme)).'\_\_([\w\_]+)\.txt$#';
			if ((preg_match($regexp,$file2,$matches)!=0) && ($matches[1]!='docs'.strval(ocp_version())))
			{
				$files2[]=dirname($file2).'/'.substr(basename($file2),strlen($theme)+2);
			}
		}
		$_GET['keep_theme_test']='1';
		$_GET['theme']=$theme;
		create_addon($file,$files2,$name,'','',$author,'ocProducts Ltd','1.0',$description,'exports/addons');

		echo escape_html(nl2br(show_updated_comments_code($file,$name)));
	}

	if ($only!==NULL) echo "<p>All themes have been exported to 'export/addons/'</p>\n";
}

echo "<hr /><p><strong>Done</strong></p>\n";

function show_updated_comments_code($file,$name)
{
return <<<END
	Paste into ocPortal.com's OcCLE if this addon is updated: {$file}...

	:require_code('feedback');
	\$id=\$GLOBALS['SITE_DB']->query_value('download_downloads','id',array('url'=>'uploads/downloads/'.rawurlencode('{$file}')));
	\$content_url=build_url(array('page'=>'downloads','type'=>'entry','id'=>\$id),get_module_zone('downloads'));
	\$_POST['title']='';
	\$_POST['post']='[i]Automated message[/i]: This addon has been updated with fixes.';
	actualise_post_comment(true,'downloads',strval(\$id),\$content_url,'{$name}');


END;
}
