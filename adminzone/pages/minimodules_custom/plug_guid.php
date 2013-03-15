<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

global $FOUND_GUID;
$FOUND_GUID=array();
global $GUID_LANDSCAPE;
$GUID_LANDSCAPE=array();
global $FILENAME,$IN;

require_code('files2');

$limit_file=isset($_GET['file'])?$_GET['file']:'';
if ($limit_file=='') $files=get_directory_contents(get_file_base()); else $files=array($limit_file);
foreach ($files as $i=>$file)
{
	if (substr($file,-4)!='.php') continue;
	if (strpos($file,'plug_guid')!==false) continue;

	$FILENAME=substr($file,strlen($ocPortal_path)+1);

	echo 'Doing '.escape_html($file).'<br />';

	$IN=file_get_contents($file);

	$out=preg_replace_callback("#do_template\('([^']*)',array\('([^']+)'=>('[^\']+')#",'callback',$IN);
	$out=preg_replace_callback("#do_template\('([^']*)',array\('([^']+)'=>(\\$[\w\d]+,)#",'callback',$out);
	$out=preg_replace_callback("#do_template\('([^']*)',array\('([^']+)'=>(\\$[\w\d]+\[\d+\],)#",'callback',$out);
	$out=preg_replace_callback("#do_template\('([^']*)',array\('([^']+)'=>(\\$[\w\d]+\))#",'callback',$out);
	$out=preg_replace_callback("#do_template\('([^']*)',array\('([^']+)'=>(\\$[\w\d]+\[\d+\]\))#",'callback',$out);

	if ($IN!=$out)
	{
		echo '<span style="color: orange">Re-saved '.escape_html($file).'</span><br />';

		$myfile=fopen(get_file_base().'/'.$file,'wb');
		fwrite($myfile,$out);
		fclose($myfile);
	}
}
echo 'Finished!';

if ($limit_file=='')
{
	$guid_file=fopen(get_file_base().'/data/guids.dat','wb');
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
		echo 'Insert needed for '.escape_html($match[1]).'<br />';
		$GUID_LANDSCAPE[$match[1]][]=array($FILENAME,$line,$new_guid);
		return "do_template('".$match[1]."',array('_GUID'=>'".$new_guid."','".$match[2].'\'=>'.$match[3];
	}
	global $FOUND_GUID;
	$guid_value=str_replace('\'','',$match[3]);
	if (array_key_exists($guid_value,$FOUND_GUID))
	{
		echo 'Repair needed for '.escape_html($match[1]).'<br />';
		$GUID_LANDSCAPE[$match[1]][]=array($FILENAME,$line,$new_guid);
		return "do_template('".$match[1]."',array('_GUID'=>'".$new_guid."'";
	}
	$FOUND_GUID[$guid_value]=1;
	$GUID_LANDSCAPE[$match[1]][]=array($FILENAME,$line,$guid_value);
	return $match[0];
}
