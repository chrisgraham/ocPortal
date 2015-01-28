<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		code_quality
 */

ini_set('memory_limit','-1');
error_reporting (E_ALL);
set_time_limit(1000);
global $OCPORTAL_PATH;
$OCPORTAL_PATH=dirname(dirname(dirname(__FILE__)));

function parse_file($to_use,$verbose=false,$very_verbose=false,$i=NULL,$count=NULL)
{
	global $tokens,$TEXT,$FILENAME,$OCPORTAL_PATH;
	$FILENAME=$to_use;

	if (($OCPORTAL_PATH!='') && (substr($FILENAME,0,strlen($OCPORTAL_PATH))==$OCPORTAL_PATH))
	{
		$FILENAME=substr($FILENAME,strlen($OCPORTAL_PATH));
		if (substr($FILENAME,0,1)==DIRECTORY_SEPARATOR) $FILENAME=substr($FILENAME,1);
		if (substr($FILENAME,0,1)==DIRECTORY_SEPARATOR) $FILENAME=substr($FILENAME,1);
	}
	$TEXT=str_replace(chr(13),'',file_get_contents($to_use));

	if ($verbose) echo '<hr /><p>DOING '.$to_use.'</p>';
	if ($verbose) echo '<pre>';
	if ($very_verbose) echo '0000000000111111111122222222223333333333444444444455555555556666666666777777777788888888889999999999'."\n";
	if ($very_verbose) echo '0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789'."\n";
	if ($very_verbose) echo '<b>Our code...</b>'."\n";
	if ($very_verbose) echo htmlentities($TEXT);
	if ($verbose) echo "\n\n".'<b>Starting lexing...</b>'."\n";
	$tokens=lex();
	if ($very_verbose) print_r($tokens);
	if ($very_verbose) echo count($tokens).' tokens';
	if ($verbose) echo "\n\n".'<b>Starting parsing...</b>'."\n";
	$structure=parse();
	if ($very_verbose) print_r($structure);
	if ($verbose) echo '</pre>';
	echo 'DONE '.$FILENAME;
	if (!is_null($i)) echo ' - '.$i.' of '.$count;
	echo cnl();

	return $structure;
}

function cnl()
{
	$cli=(php_sapi_name()=='cli' && empty($_SERVER['REMOTE_ADDR']));
	return $cli?"\n":'<br />';
}

function get_custom_file_base()
{
	global $OCPORTAL_PATH;
	return $OCPORTAL_PATH;
}

function get_file_base()
{
	global $OCPORTAL_PATH;
	return $OCPORTAL_PATH;
}

function unixify_line_format($in)
{
	$in=str_replace(chr(13).chr(10),chr(10),$in);
	return str_replace(chr(13),chr(10),$in);
}

function get_charset()
{
	return 'utf-8';
}

function do_dir($dir,$no_custom=false,$orig_priority=false,$avoid=NULL)
{
	global $OCPORTAL_PATH;
	require_once($OCPORTAL_PATH.'/sources/files.php');
	init__files();

	$out=array();
	$_dir=($dir=='')?'.':$dir;
	$dh=opendir($_dir);
	if ($dh)
	{
		while (($file=readdir($dh))!==false)
		{
			if ((!is_null($avoid)) && (in_array($file,$avoid))) continue;
			if (((strpos($file,'_custom')!==false) || ($file=='exports') || ($file=='_old') || ($file=='_tests') || ($file=='ocworld')) && ($no_custom)) continue;

			if (should_ignore_file(preg_replace('#^'.preg_quote($OCPORTAL_PATH.'/','#').'#','',$dir.'/').$file,IGNORE_NONBUNDLED_SCATTERED | IGNORE_CUSTOM_DIR_CONTENTS | IGNORE_CUSTOM_ZONES | IGNORE_CUSTOM_THEMES | IGNORE_NON_EN_SCATTERED_LANGS | IGNORE_BUNDLED_UNSHIPPED_VOLATILE,0))
				continue;

			if ($file[0]!='.')
			{
				if (is_file($_dir.'/'.$file))
				{
					if (substr($file,-4,4)=='.php')
					{
						$path=$dir.(($dir!='')?'/':'').$file;
						if ($orig_priority)
						{
							$alt=str_replace('_custom','',$path);
						} else
						{
							$alt=str_replace('modules/','modules_custom/',str_replace('sources/','sources_custom/',$path));
						}
						if (($alt==$path) || (!file_exists($alt)))
							$out[]=$path;
					}
				} elseif (is_dir($_dir.'/'.$file))
				{
					$out=array_merge($out,do_dir($dir.(($dir!='')?'/':'').$file,$no_custom,$orig_priority));
				}
			}
		}
	}
	return $out;
}

function check_parameters()
{
	return true;
}

function die_error($system,$pos,$line,$message)
{
	global $FILENAME;
	echo 'ERROR "'.$FILENAME.'" '.$line.' '.$pos.' '.'PHP: '.$message.cnl();
	die();
}

function warn_error($system,$pos,$line,$message)
{
	global $FILENAME;
	echo 'WARNING "'.$FILENAME.'" '.$line.' '.$pos.' '.'PHP: '.$message.cnl();
}

function die_html_trace($message)
{
	echo $message.'<br /><br />';

	@ob_end_clean(); // We can't be doing output buffering at this point
	$_trace=debug_backtrace();
	$trace='';
	foreach ($_trace as $stage)
	{
		$traces='';
		foreach ($stage as $key=>$value)
		{
			if ($key=='file') continue;
			$_value=var_export($value,true);
			$traces.=ucfirst($key).' -> '.htmlentities($_value).'<br />';
		}
		$trace.='<p>'.$traces.'</p>';
	}

	die('<span style="color: blue">'.$trace.'</span>');
}

function pos_to_line_details($i,$absolute=false)
{
	global $TEXT,$tokens;
	if ((!$absolute) && (!isset($tokens[$i]))) $i=-1;
	if ($i==-1) return array(0,0,'');
	$j=$absolute?$i:$tokens[$i][count($tokens[$i])-1];
	$line=substr_count(substr($TEXT,0,$j),chr(10))+1;
	$pos=$j-strrpos(substr($TEXT,0,$j),chr(10));
	$l_s=strrpos(substr($TEXT,0,$j+1),chr(10))+1;
	if ($l_s==1) $l_s=0;
	$full_line=@strval(htmlentities(substr($TEXT,$l_s,strpos($TEXT,chr(10),$j)-1-$l_s)));

	return array($pos,$line,$full_line);
}

function log_warning($warning,$i=-1,$absolute=false)
{
	global $TEXT,$FILENAME,$START_TIME,$myfile_WARNINGS;

	if (($i==-1) && (isset($GLOBALS['i']))) $i=$GLOBALS['i'];
	list($pos,$line,$full_line)=pos_to_line_details($i,$absolute);

	echo 'WARNING "'.$FILENAME.'" '.$line.' '.$pos.' '.'PHP: '.$warning.cnl();
//	if (!isset($myfile_WARNINGS)) $myfile_WARNINGS=fopen('warnings_'.$START_TIME.'.log','at');
//	fwrite($myfile_WARNINGS,$FILENAME.': '.$warning.' (at line '.$line.', position '.$pos.')  ['.$full_line.']'."\n");
	//fclose($myfile_WARNINGS);
}

function log_special($type,$value)
{
	global $START_TIME;

	if (!isset($GLOBALS[$$type])) $GLOBALS[$$type]=fopen('special_'.$START_TIME.'_'.$type.'.log','at');
	fwrite($GLOBALS[$$type],$value."\n");
	//fclose($GLOBALS[$$type]);
}

