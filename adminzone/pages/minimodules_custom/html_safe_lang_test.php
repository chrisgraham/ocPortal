<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2009

 See text/en/licence.txt for full licencing information.

 Meta Script:
	Search for language entries that are used for both HTML and non-HTML contexts
	Pass find_html_no_go=1 if to find a full list, otherwise it will just find bugs where HTML-symbols (<>"& -- but not ' because that's almost safe) have already been used in both contexts
	Note that this script can't find everything due to dynamicness of ocPortal language calls. As a general rule, don't use HTML or HTML-sensitive-symbols where not needed, and consider it carefully before doing so

*/

function better_parse_ini_file($filename,$file=NULL)
{
	if (is_null($file))
	{
		global $FILE_ARRAY;
		if (isset($FILE_ARRAY)) $file=file_array_get($filename);
		else $file=file_get_contents($filename);
	}

	$ini_array=array();
	$lines=explode(chr(10),$file);
	foreach($lines as $line)
	{
		$line=rtrim($line);

		if ($line=='') continue;
		if ($line{0}=='#') continue;

		$pos=strpos($line,'=');
		$property=substr($line,0,$pos);
		$value=substr($line,$pos+1);

		$ini_array[$property]=$value;
	}

	return $ini_array;
}


global $LANGUAGE,$LANGUAGE_HTML,$LANGUAGE_LITERAL,$LANGUAGE_CURRENT,$FILE,$FIND_NO_GO_HTML_SPOTS;
$FIND_NO_GO_HTML_SPOTS=(@$_GET['find_html_no_go']=='1');

require_once('lib.php');
global $ocPortal_path;
$base_dir=$ocPortal_path;

echo do_header();

echo '<h2>Pre-Processing&hellip;</h2>';
$LANGUAGE=array();
if ($dh=opendir($base_dir.'lang/EN'))
{
	while (($FILE=readdir($dh))!==false)
	{
		if ($FILE{0}!='.')
		{
			echo htmlentities($FILE).', ';

			$map=better_parse_ini_file($base_dir.'lang/EN/'.$FILE);
			foreach ($map as $string=>$val)
			{
				if ((trim($string)!='') && ($string{0}!='['))
				{
					if (preg_match('/[<>&]/',$val)!=0)
					{
						$LANGUAGE[$string]=$FILE;
					}
				}
			}
		}
	}
	closedir($dh);
}

echo '<h2>Processing for plain-usages&hellip;</h2>';
$LANGUAGE_CURRENT=array();
$forms=array(
				 '#do_lang\(\'(.+?)\'(,|\))#ims',
				 '#do_lang\(\\\\\'(.+?)\\\\\'(,|\))#ims',
				 '#log_it\(\'(.+?)\'(\,|\))#ims',
				 );
foreach ($forms as $php)
{
	do_dir($base_dir,$php,'php');
}
$LANGUAGE_LITERAL=$LANGUAGE_CURRENT;

echo '<h2>Processing for HTML-usages&hellip;</h2>';
$LANGUAGE_CURRENT=array();
$forms=array(
				 '#do_lang_tempcode\(\'(.+?)\'(,|\))#ims',
				 '#do_lang_tempcode\(\\\\\'(.+?)\\\\\'(,|\))#ims',
				 '#get_page_title\(\'(.+?)\'(\,|\))#ims',
				 );
foreach ($forms as $php)
{
	do_dir($base_dir,$php,'php');
}
$tpl='#{!(\w+?)}#ims';
do_dir($base_dir.'themes/default/templates',$tpl,'tpl');
$tpl2='#{!(\w+?),#ims';
do_dir($base_dir.'themes/default/templates',$tpl2,'tpl');
$LANGUAGE_HTML=$LANGUAGE_CURRENT;

echo '<h2>Results&hellip;</h2>';

$result=array_keys(array_intersect_assoc($LANGUAGE_LITERAL,$LANGUAGE_HTML));
foreach ($result as $r)
{
	$_a=$LANGUAGE_LITERAL[$r][0];
	$a=str_replace($ocPortal_path,'',$_a);
	$_b=$LANGUAGE_HTML[$r][0];
	$b=str_replace($ocPortal_path,'',$_b);
	echo htmlentities($r).' (<a href="txmt://open?url=file://'.htmlentities($_a).'">'.htmlentities($a).'</a> and <a href="txmt://open?url=file://'.htmlentities($_b).'">'.htmlentities($b).')</a><br />';
}

echo do_footer();

function do_dir($dir,$exp,$ext)
{
	global $FILE2;
	if ($dh=opendir($dir))
	{
		while (($file=readdir($dh))!==false)
		{
			if ($file{0}!='.')
			{
				if (is_file($dir.'/'.$file))
				{
					if (substr($file,-4,4)=='.'.$ext)
					{
						$FILE2=$dir.'/'.$file;
						echo htmlentities($file).', ';
						do_file($exp);
					}
				} else if (is_dir($dir.'/'.$file))
				{
					do_dir($dir.'/'.$file,$exp,$ext);
				}
			}
		}
	}
}

function do_file($exp)
{
	global $FILE2;
	$myfile=fopen($FILE2,'rt');
	while (!feof($myfile))
	{
		$line=fgets($myfile,4096);

		preg_replace_callback($exp,'find_php_use_match',$line);
	}
}

function find_php_use_match($matches)
{
	global $LANGUAGE_CURRENT,$FILE2,$LANGUAGE,$FIND_NO_GO_HTML_SPOTS;
	if ((!$FIND_NO_GO_HTML_SPOTS) && (!isset($LANGUAGE[$matches[1]]))) return;
	if (!isset($LANGUAGE_CURRENT[$matches[1]])) $LANGUAGE_CURRENT[$matches[1]]=array();
	$LANGUAGE_CURRENT[$matches[1]][]=$FILE2;
}


