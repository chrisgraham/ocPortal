<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2009

 See text/en/licence.txt for full licencing information.

*/

require_once('lib.php');
global $ocPortal_path;

global $FOUND_GUID;
$FOUND_GUID=array();
global $GUID_LANDSCAPE;
$GUID_LANDSCAPE=array();
global $FILENAME,$IN;

@ob_end_clean();

$limit_file=isset($_GET['file'])?$_GET['file']:'';
if ($limit_file=='') $files=do_dir($ocPortal_path); else $files=array($limit_file);
foreach ($files as $i=>$file)
{
	$FILENAME=substr($file,strlen($ocPortal_path)+1);

	echo 'Doing '.$file.'<br />';

	$IN=file_get_contents($file);

	$out=preg_replace_callback("#do_template\('([^']*)',array\('([^']+)'=>('[^\']+')#",'callback',$IN);
	$out=preg_replace_callback("#do_template\('([^']*)',array\('([^']+)'=>(\\$[\w\d]+,)#",'callback',$out);
	$out=preg_replace_callback("#do_template\('([^']*)',array\('([^']+)'=>(\\$[\w\d]+\[\d+\],)#",'callback',$out);
	$out=preg_replace_callback("#do_template\('([^']*)',array\('([^']+)'=>(\\$[\w\d]+\))#",'callback',$out);
	$out=preg_replace_callback("#do_template\('([^']*)',array\('([^']+)'=>(\\$[\w\d]+\[\d+\]\))#",'callback',$out);

	if ($IN!=$out)
	{
		echo 'Done '.$file.'<br />';
		$myfile=fopen($file,'wb');
		fwrite($myfile,$out);
		fclose($myfile);

		flush();
	}
}
echo 'Finished!';

if ($limit_file=='')
{
	$guid_file=fopen($ocPortal_path.'/data/guids.dat','wb');
	fwrite($guid_file,serialize($GUID_LANDSCAPE));
	fclose($guid_file);
}

function callback($match)
{
//echo $match[0].'<br />';
//return $match[0];
	global $GUID_LANDSCAPE,$FILENAME,$IN;
	$new_guid=md5(uniqid(''));
	if (!array_key_exists($match[1],$GUID_LANDSCAPE)) $GUID_LANDSCAPE[$match[1]]=array();
	$line=substr_count(substr($IN,0,strpos($IN,$match[0])),chr(10))+1;
	if ($match[2]!='_GUID')
	{
		echo 'Inserted for '.$match[1].'<br />';
		$GUID_LANDSCAPE[$match[1]][]=array($FILENAME,$line,$new_guid);
		return "do_template('".$match[1]."',array('_GUID'=>'".$new_guid."','".$match[2].'\'=>'.$match[3];
	}
	global $FOUND_GUID;
	$guid_value=str_replace('\'','',$match[3]);
	if (array_key_exists($guid_value,$FOUND_GUID))
	{
		echo 'Repaired for '.$match[1].'<br />';
		$GUID_LANDSCAPE[$match[1]][]=array($FILENAME,$line,$new_guid);
		return "do_template('".$match[1]."',array('_GUID'=>'".$new_guid."'";
	}
	$FOUND_GUID[$guid_value]=1;
	$GUID_LANDSCAPE[$match[1]][]=array($FILENAME,$line,$guid_value);
	return $match[0];
}

function do_dir($dir,$no_custom=false)
{
	$out=array();
	$_dir=($dir=='')?'.':$dir;
	$dh=opendir($_dir);
	if ($dh)
	{
		while (($file=readdir($dh))!==false)
		{
			if ((strpos($file,'_custom')!==false) && ($no_custom)) continue;

			if ($file{0}!='.')
			{
				if (is_file($_dir.DIRECTORY_SEPARATOR.$file))
				{
					if (substr($file,-4,4)=='.php')
					{
						$path=$dir.(($dir!='')?DIRECTORY_SEPARATOR:'').$file;
						$alt=str_replace('modules/','modules_custom/',str_replace('sources/','sources_custom/',$path));
						if (($alt==$path) || (!file_exists($alt)))
							$out[]=$path;
					}
				} elseif (is_dir($_dir.DIRECTORY_SEPARATOR.$file))
				{
					$out=array_merge($out,do_dir($dir.(($dir!='')?DIRECTORY_SEPARATOR:'').$file));
				}
			}
		}
	}
	return $out;
}


