<?php /**
* THIRD PARTY CODE
* <external entry point>
* SpellChecker backend, Heavily modified for ocPortal
*
* @package core_form_interfaces
* @author Yermo Lamers http://www.formvista.com/contact.html
* @copyright DTLink, LLC 2005
*/

/*EXTRA FUNCTIONS: (pspell\_.+|shell_exec)*/

/*	$x=fopen(get_custom_file_base().'/data_custom/spelling/write.log','wt');
	fwrite($x,serialize($_GET+$_POST));
	fclose($x);*/


if (strpos($_SERVER['PHP_SELF'],'spell-check-logic.php')!==false)
	spellchecklogic();

/**
 * Start the spellcheck process
 *
 * @param  ?string		The type of operation (NULL: look from params)
 * @param  ?string		The text to check (NULL: look from params)
 * @param  ?array			A list of words to skip checking of (NULL: none)
 * @param  boolean		Whether to return data, instead of output
 * @return array			A map, possibly mispelled words, to suggestions
 */
function spellchecklogic($type=NULL,$text=NULL,$words_skip=NULL,$ret=false)
{
	error_reporting(E_ALL);

	if (!function_exists('get_file_base'))
	{
		/**
		 * Get the file base for your installation of ocPortal
		 *
		 * @return PATH			The file base, without a trailing slash
		 */
		function get_file_base()
		{
			$file_base=realpath(__FILE__);
			$file_base=str_replace('\\','/',str_replace('\\\\','\\',$file_base));
			$bits=explode('/',$file_base);
			array_pop($bits);
			array_pop($bits);
			array_pop($bits);
			array_pop($bits);
			array_pop($bits);
			return implode(DIRECTORY_SEPARATOR,$bits).DIRECTORY_SEPARATOR;
		}
	}

	if (!function_exists('get_custom_file_base'))
	{
		/**
		 * Find the path to where WYSIWYG data is stored.
		 *
		 * @return string			Relative path
		 */
		function get_custom_file_base()
		{
			global $SITE_INFO;
			return isset($SITE_INFO['custom_file_base'])?$SITE_INFO['custom_file_base']:get_file_base();
		}
	}

	if (!function_exists('_filter_naughty_harsh'))
	{
		/**
		 * This function is similar to filter_naughty, except it requires the parameter to be strictly alphanumeric. It is intended for use on text that will be put into an eval.
		 *
		 * @param  string			String to test
		 * @return string			Same as input string
		 */
		function _filter_naughty_harsh($in)
		{
			if (preg_match('#^[a-zA-Z0-9_-]*$#',$in)!=0) return $in;
			exit();
			return ''; // trick to make Zend happy
		}
	}

	if (!function_exists('mixed'))
	{
		/**
		 * Assign this to explicitly declare that a variable may be of mixed type, and initialise to NULL.
		 *
		 * @return ?mixed	Of mixed type (NULL: default)
		 */
		function mixed()
		{
			return NULL;
		}
	}

	list($aspelldictionaries,$aspellcommand,$tempnam,$lang)=aspell_init();

	if (is_null($type)) $type=array_key_exists('type',$_REQUEST)?$_REQUEST['type']:((array_key_exists('to_p_dict',$_REQUEST)?'save':'check'));
	if (is_null($text))
	{
		$text=$_REQUEST['content'];
		if (get_magic_quotes_gpc()) $text=stripslashes($text);
	}

	switch ($type)
	{
		case 'check':
			return aspell_check($aspelldictionaries,$aspellcommand,$tempnam,$lang,$text,$words_skip,$ret);
		case 'save':
			aspell_save($aspellcommand,$tempnam);
			break;
	}
	if (!is_null($tempnam)) unlink($tempnam);
	return array(array(),array());
}

/**
 * Execute aSpell, via piping to an output log (Windows PHP doesn't seem to allow direct output getting).
 *
 * @param  string				The command line
 * @return ~string			The output (false: error)
 */
function wrap_exec($cmd)
{
	//echo htmlentities($cmd.' > '.get_custom_file_base().'/data_custom/spelling/output.log').'<br />';
	if (shell_exec($cmd.' > '.get_custom_file_base().'/data_custom/spelling/output.log')===false)
	{
		return false;
	}

	$ret=rtrim(file_get_contents(get_custom_file_base().'/data_custom/spelling/output.log'));

	return $ret;
}

/**
 * Initialise our aSpell calling environment.
 *
 * @return array			A tuple of environmental details (dictionary list,aspell call command,temporary file name,language being used)
 */
function aspell_init()
{
	// Find the language
	if ((!isset($_REQUEST['dictionary'])) || (strlen(trim($_REQUEST['dictionary']))<1))
	{
		$lang=function_exists('do_lang')?do_lang('dictionary'):'en_GB'; // Default to UK English (as per ocPortal)
	} else
	{
		$lang=$_REQUEST['dictionary'];
	}

	$aspellcommand=mixed();

	$force_shell=false;
	if ((!function_exists('pspell_check')) || ($force_shell))
	{
		if (str_replace(array('on','true','yes'),array('1','1','1'),strtolower(ini_get('safe_mode')))=='1') exit('Spell Checker does not work with safe mode systems that do not have direct pspell support into PHP');
		if (strpos(@ini_get('disable_functions'),'shell_exec')!==false) exit('Spell Checker does not work on systems with shell_exec disabled that do not have direct pspell support into PHP');

		// Our temporary spell check file
		$tempnam=tempnam((((str_replace(array('on','true','yes'),array('1','1','1'),strtolower(ini_get('safe_mode')))=='1') || ((@strval(ini_get('open_basedir'))!='') && (preg_match('#(^|:|;)/tmp($|:|;|/)#',ini_get('open_basedir'))==0)))?get_custom_file_base().'/safe_mode_temp/':'/tmp/'),'spell_');
		if (($tempnam===false) || ($tempnam=='')/*Should not be blank, but seen in the wild*/)
			$tempnam=tempnam(get_custom_file_base().'/safe_mode_temp/','spell_');

		// Find aspell
		$aspell='aspell';
		$aspell_args='-a --lang='._filter_naughty_harsh($lang);
		if (DIRECTORY_SEPARATOR=='\\') // Windows
		{
			// See if there is a local install of aspell here
			if (file_exists(dirname(__FILE__).'\\aspell\\bin\\aspell.exe'))
			{
				$aspell=dirname(__FILE__).'\\aspell\\bin\\aspell.exe';
				if (file_exists(dirname(__FILE__).'\\aspell\\bin\\aspell_wrap.exe'))
					$aspell=dirname(__FILE__).'\\aspell\\bin\\aspell_wrap.exe '.dirname(__FILE__).'\\aspell\\bin\\';

				//$dic_dir=wrap_exec($aspell.' config dict-dir');
				//$dicfil=preg_replace('/^.*\/lib\/(aspell\S*)\n.*/s','$1',$dic_dir);
				//$aspell_args.=' --dict-dir='.$dicfil;
			} else
			{
				$aspell='C:\Progra~1\Aspell\bin\aspell.exe';
			}

			if (!file_exists($aspell)) exit('ASpell not installed in default locations.');

			$aspell_version=wrap_exec($aspell.' version');

		} else // Linux
		{
			// See if there is a local install of aspell here
			if (file_exists(dirname(__FILE__).'/aspell/bin/aspell'))
			{
				putenv('PATH='.dirname(__FILE__).'/aspell/bin:'.getenv('PATH'));
				putenv('LD_LIBRARY_PATH='.dirname(__FILE__).'/aspell/lib:'.getenv('LD_LIBRARY_PATH'));
				//$dic_dir=wrap_exec($aspell.' config dict-dir');
				//$dicfil=dirname(__FILE__).'/aspell/lib/'.preg_replace('/^.*\/lib\/(aspell\S*)\n.*/s','$1',$dic_dir);
				//$aspell_args.=' --dict-dir='.$dicfil.' --add-filter-path='.$dicfil;
			}

			$aspell_version=wrap_exec($aspell.' version');
		}

		if ($aspell_version===false) exit('ASpell would not execute. It is most likely not installed, or a security measure is in place, or file permissions are not correctly set. If on Windows, you may need to give windows\\system32\\cmd.exe execute permissions to the web user.');

		// Old aspell doesn't know about encoding, which means that unicode will be broke, but we should at least let it try.

		$a_ver=array();
		preg_match('/really [aA]spell ([0-9]+)\.([0-9]+)(?:\.([0-9]+))?/i',$aspell_version,$a_ver);
		if (!array_key_exists(1,$a_ver)) $a_ver[1]='1';
		if (!array_key_exists(2,$a_ver)) $a_ver[2]='0';
		if (!array_key_exists(3,$a_ver)) $a_ver[3]='0';

		$a_ver=array('major'=>(integer)$a_ver[1],'minor'=>(integer)$a_ver[2],'release'=>(integer)$a_ver[3]);
		if (($a_ver['major']>=0) && ($a_ver['minor']>=60))
		{
			$aspell_args.=' -H --encoding=utf-8';
		}
		elseif (preg_match('/--encoding/',wrap_exec($aspell.' 2>&1'))!=0)
		{
			$aspell_args.=' --mode=none --add-filter=sgml --encoding=utf-8';
		} else
		{
			$aspell_args.=' --mode=none --add-filter=sgml';
		}

		$aspelldictionaries=$aspell.' dump dicts';
		$aspellcommand=$aspell.' '.$aspell_args.' < '.$tempnam;
	} else
	{
		//list($lang,$spelling)=explode('_',$lang);
		$spelling='';
		$tempnam=NULL;
		$aspelldictionaries=NULL;
	}

	// Personal dictionaries
	global $SITE_INFO;
	if (!isset($SITE_INFO))
		require_once('../../../../info.php');
	$cookie_member_id=$SITE_INFO['user_cookie'];
	$p_dicts_name=(array_key_exists($cookie_member_id,$_COOKIE))?_filter_naughty_harsh($_COOKIE[$cookie_member_id]):'guest';
	$p_dict_path=get_custom_file_base().'/data_custom/spelling/personal_dicts'.DIRECTORY_SEPARATOR.$p_dicts_name;
	if (!file_exists($p_dict_path))
	{
		mkdir($p_dict_path,02770);
	}

	if (is_null($tempnam))
	{
		list($lang_stub,)=explode('_',$lang);

		$charset=str_replace('ISO-','iso',str_replace('iso-','iso',do_lang('charset')));
		if (DIRECTORY_SEPARATOR=='\\') // Windows pSpell is buggy, so we can't use the replacement-pairs feature. Also need to replace data dir with special one.
		{
			$aspellcommand=@pspell_new_personal($p_dict_path.'/'.$lang_stub.'.pws',$lang,$spelling,'',$charset);
			if ($aspellcommand===false) $aspellcommand=pspell_new_personal($p_dict_path.'/'.$lang_stub.'.pws',$lang,$spelling,'',$charset);
		} else
		{
			$aspellconfig=@pspell_config_create($lang,$spelling,'',$charset);
			if ($aspellconfig===false) $aspellconfig=pspell_config_create('en',$spelling,'',$charset);
			pspell_config_personal($aspellconfig,$p_dict_path.'/'.$lang_stub.'.pws');
			pspell_config_repl($aspellconfig,$p_dict_path.'/'.$lang_stub.'.prepl');
			$aspellcommand=@pspell_new_config($aspellconfig);
			if (($aspellcommand===false) && ($lang!='en')) // Might be that we had a late fail on initialising that language
			{
				$aspellconfig=pspell_config_create('en',$spelling,'',$charset);
				pspell_config_personal($aspellconfig,$p_dict_path.'/'.$lang_stub.'.pws');
				pspell_config_repl($aspellconfig,$p_dict_path.'/'.$lang_stub.'.prepl');
				$aspellcommand=pspell_new_config($aspellconfig);
			}
		}

		if ($aspellcommand===false) warn_exit('Cannot initialise pspell. Make sure the server has the \''.$lang.'\''.(($lang=='en')?'':' or \'en\'').' spelling pack installed.');
	}

	return array($aspelldictionaries,$aspellcommand,$tempnam,$lang);
}

/**
 * Finds the ASCII value of a utf-8 character (I think!)
 *
 * @param  string			Character
 * @return integer		ASCII value
 */
function utf8_ord($chr)
{
	switch(strlen($chr))
	{
		case 1:
			return ord($chr);

		case 2:
			$ord=ord($chr[1])&63;
			$ord=$ord|((ord($chr[0])&31)<<6);
			return $ord;

		case 3:
			$ord=ord($chr[2])&63;
			$ord=$ord|((ord($chr[1])&63)<<6);
			$ord=$ord|((ord($chr[0])&15)<<12);
			return $ord;

		case 4:
			$ord=ord($chr[3])&63;
			$ord=$ord|((ord($chr[2])&63)<<6);
			$ord=$ord|((ord($chr[1])&63)<<12);
			$ord=$ord|((ord($chr[0])&7)<<18);
			return $ord;

		default :
			trigger_error('Character not utf-8',E_USER_ERROR);
	}
}

/**
 * Do aSpell spelling check
 *
 * @param  string			aSpell command to get dictionaries
 * @param  mixed			aSpell call command
 * @param  PATH			Temporary file name
 * @param  string			Language being used
 * @param  ?string		The text to check (NULL: look from params)
 * @param  ?array			Words to skip (NULL: none)
 * @param  boolean		Whether to return data, instead of output
 * @return array			A map, possibly mispelled words, to suggestions
 */
function aspell_check($aspelldictionaries,$aspellcommand,$tempnam,$lang,$text,$words_skip=NULL,$ret=false)
{
	if (is_null($words_skip)) $words_skip=array();

	// Convert UTF-8 multi-bytes into decimal character entities.  This is because aspell isn't fully utf8-aware
	$text=@preg_replace('/([\xC0-\xDF][\x80-\xBF])/e',"'&#'.strval(utf8_ord('\$1')).';'",$text);
	$text=@preg_replace('/([\xE0-\xEF][\x80-\xBF][\x80-\xBF])/e',"'&#'.strval(utf8_ord('\$1')).';'",$text);
	$text=@preg_replace('/([\xF0-\xF7][\x80-\xBF][\x80-\xBF][\x80-\xBF])/e',"'&#'.strval(utf8_ord('\$1')).';'",$text);

	if (!$ret)
	{
		header('Content-Type: text/html; charset=utf-8');
		echo '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
		<html>
		<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link rel="stylesheet" type="text/css" media="all" href="spell-check-style.css" />';
	}

	$results=array();

	if (trim($text)!='')
	{
		$varlines='<script type="text/javascript">var suggested_words={ ';
		$infolines='var spellcheck_info={';
		$counter=0;
		$suggest_count=0;
		$textarray=array();

		if (is_string($aspellcommand))
		{
			$fd=fopen($tempnam,'wb');
			if ($fd!==false)
			{
				$textarray=explode("\n",$text);
				fwrite($fd,"!\n");
				foreach ($textarray as $value)
				{
					// adding the carat to each line prevents the use of aspell commands within the text...
					fwrite($fd,"^$value\n");
				}
				fclose($fd);
				chmod($tempnam,0777);
				//echo file_get_contents($tempnam);

				// next run aspell
				$return=wrap_exec($aspellcommand.' 2>&1');
				//exit($aspellcommand.' 2>&1 > output.log');
				//echo file_get_contents($tempnam);
				//exit($aspellcommand);
				$returnarray=explode("\n",$return);
				//$returnlines=count($returnarray);
				//print_r(htmlentities($return));
				//$textlines=count($textarray);

				$lineindex=-1;
				$poscorrect=0;
				foreach ($returnarray as $value)
				{
					// if there is a correction here, processes it, else move the $textarray pointer to the next line
					if (substr($value,0,1)=='&')
					{
						$counter++;
						$correction=explode(' ',$value);
						$word=$correction[1];
						$suggest_count+=$correction[2];
						$absposition=intval(substr($correction[3],0,-1))-1;
						$position=$absposition+$poscorrect;
						//$niceposition=strval($lineindex).','.strval($absposition);
						$suggstart=strpos($value,':')+2;
						$suggestions=substr($value,$suggstart);
						$suggestionarray=explode(', ',$suggestions);

						$results[]=array($word,$suggestionarray);

						$beforeword=substr($textarray[$lineindex],0,$position);
						$afterword=substr($textarray[$lineindex],$position+strlen($word));
						$textarray[$lineindex]=$beforeword.'<span class="HA-spellcheck-error">'.$word.'</span>'.$afterword;

						$suggestion_list='';
						foreach (array_keys($suggestionarray) as $value2)
						{
							$suggestion_list.=$value2.',';
						}
						$suggestion_list=substr($suggestion_list,0,strlen($suggestion_list)-1);
						$varlines.='"'.trim($word).'":"'.trim($suggestion_list).'",';

						$poscorrect=$poscorrect+41;
					}
					elseif (substr($value,0,1)=='#') // ?
					{
						$correction=explode(' ',$value);
						$word=$correction[1];
						$results[]=array($word,array());
						$absposition=$correction[2]-1;
						$position=$absposition+$poscorrect;
						//$niceposition=strval($lineindex).','.strval($absposition);
						$beforeword=substr($textarray[$lineindex],0,$position);
						$afterword=substr($textarray[$lineindex],$position+strlen($word));
						//$textarray[$lineindex]=$beforeword.$word.$afterword;
						$textarray[$lineindex]=$beforeword.'<span class="HA-spellcheck-error">'.$word.'</span><span class="HA-spellcheck-suggestions">'.$word.'</span>'.$afterword;
						$poscorrect=$poscorrect+88+strlen($word);
					} else
					{
						//print "Done with line $lineindex, next line...<br><br>";
						$poscorrect=0;
						$lineindex++;
					}
				}
			}
		} else
		{
			//$i=0;

			//$text=@html_entity_decode(strip_tags(str_replace('<br />',chr(10),$text)));
			//$len=strlen($text);

			// HTML tags vs text
			$p_fragments=preg_split('#(\<.*\>)|(&.*;)#mU',$text,-1,PREG_SPLIT_DELIM_CAPTURE);
			foreach ($p_fragments as $p_frag)
			{
				if ((strlen($p_frag)>0) && ($p_frag[0]!='<') && ($p_frag[0]!='&'))
				{
					// Tokenise words
					$fragments=preg_split('#([ \!\?\.,;\n\(\)\[\]\{\}\<\>"])#m',$p_frag,-1,PREG_SPLIT_DELIM_CAPTURE);
					foreach ($fragments as $word)
					{
						if (in_array($word,$words_skip)) continue;

						if ((preg_match('#[a-zA-Z\'\-]#',$word)!=0) && (!pspell_check($aspellcommand,$word)))
						{
							$counter++;

							// Handle suggestions
							$suggestions2=pspell_suggest($aspellcommand,$word);
							$results[]=array($word,$suggestions2);
							if (count($suggestions2)==0)
							{
								$textarray[]='<span class="HA-spellcheck-error">'.$word.'</span>';
							} else
							{
								$suggest_count+=count($suggestions2);
								$suggestion_list='';
								foreach ($suggestions2 as $value)
								{
									$suggestion_list.=$value.',';
								}
								$suggestion_list=substr($suggestion_list,0,strlen($suggestion_list)-1);
								$varlines.='"'.trim($word).'":"'.trim($suggestion_list).'",';

								$textarray[]='<span class="HA-spellcheck-error">'.trim($word).'</span>'; // <span class="HA-spellcheck-suggestions">'.trim($word).'</span>
							}
						} else
						{
							$textarray[]=$word;
						}
					}
				} else
				{
					$textarray[]=$p_frag;
				}
			}
		}

		$infolines.='"Language Used":"'.$lang.'",';
		$infolines.='"Mispelled words":"'.strval($counter).'",';
		$infolines.='"Total words suggested":"'.strval($suggest_count).'"';
		//$infolines.=',"Total Lines Checked":"'.strval($returnlines).'"';	Who cares?
		$infolines.='};';
		$varlines=substr($varlines,0,strlen($varlines)-1);
		if (!$ret)
		{
			echo $varlines.'};'.$infolines.'</script>';
		}

		if (!$ret)
		{
		echo '</head>
		<body onload="window.parent.finishedSpellChecking();">';
		}

		foreach ($textarray as $value)
		{
			if (!$ret)
			{
				echo $value;
			}
		}

		if (is_string($aspellcommand))
		{
			$dictionaries=str_replace(chr(10),",",wrap_exec($aspelldictionaries));
			if (!$ret)
			{
				echo '<div id="HA-spellcheck-dictionaries">'.$dictionaries.'</div>';
			}
		}

		if (!$ret)
		{
			echo '</body></html>';
			//echo '<div id="HA-spellcheck-dictionaries">en_US,es,fr</div></body></html>';
		}
	}

	return $results;
}

/**
 * Do aSpell dictionary save
 *
 * @param  mixed		aSpell call command
 * @param  string		Temporary file name
 */
function aspell_save($aspellcommand,$tempnam)
{
	$to_p_dict=isset($_REQUEST['to_p_dict'])?(is_array($_REQUEST['to_p_dict'])?$_REQUEST['to_p_dict']:explode(',',$_REQUEST['to_p_dict'])):array(); // List of words to add to personal dictionary.
	$to_r_list=isset($_REQUEST['to_r_list'])?(is_array($_REQUEST['to_r_list'])?$_REQUEST['to_r_list']:explode(',',$_REQUEST['to_r_list'])):array(); // List of words to add to replacement list.
	ob_start();
	//print_r($to_r_list);
	if ((count($to_p_dict)>0) || (count($to_r_list)>0))
	{
		if (is_string($aspellcommand))
		{
			$fh=fopen($tempnam,'wb');
			if ($fh!==false)
			{
				foreach ($to_p_dict as $personal_word)
				{
					$cmd='&'.$personal_word."\n";
					//echo $cmd;
					fwrite($fh,$cmd,strlen($cmd));
				}

				foreach ($to_r_list as $replace_pair)
				{
					$cmd='$$ra '.$replace_pair[0].' , '.$replace_pair[1]."\n";
					//echo $cmd;
					fwrite($fh,$cmd,strlen($cmd));
				}
				$cmd="#\n";

				//echo $cmd;
				fwrite($fh,$cmd,strlen($cmd));
				fclose($fh);
			} else
			{
				exit("Can't Write");
			}
			//echo $aspellcommand."\n";
			/*echo */wrap_exec($aspellcommand.' 2>&1');
		} else
		{
			foreach ($to_p_dict as $personal_word)
			{
				pspell_add_to_personal($aspellcommand,$personal_word);
			}

			foreach ($to_r_list as $replace_pair)
			{
				pspell_store_replacement($aspellcommand,$replace_pair[0],$replace_pair[1]);
			}

			pspell_save_wordlist($aspellcommand);
		}
	}
}


