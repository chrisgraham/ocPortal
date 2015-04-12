<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		unit_testing
 */

/*
Search for language entries that are used for both HTML and non-HTML contexts
Pass find_html_no_go=1 if to find a full list, otherwise it will just find bugs where HTML-symbols (<>"& -- but not ' because that's almost safe) have already been used in both contexts
Note that this script can't find everything due to dynamicness of ocPortal language calls. As a general rule, don't use HTML or HTML-sensitive-symbols where not needed, and consider it carefully before doing so
*/

/**
 * ocPortal test case class (unit testing).
 */
class html_safe_lang_test_set extends ocp_test_case
{
	function setUp()
	{
		parent::setUp();

		disable_php_memory_limit();
	}

	function testHtmlSafeLang()
	{
 		if (function_exists('set_time_limit')) @set_time_limit(0);

		global $LANGUAGE_STRINGS,$LANGUAGE_HTML,$LANGUAGE_LITERAL,$LANGUAGE_CURRENT,$FILE,$FIND_NO_GO_HTML_SPOTS;
		$FIND_NO_GO_HTML_SPOTS=(@$_GET['find_html_no_go']=='1');

		//echo '<h2>Pre-Processing&hellip;</h2>';
		$LANGUAGE_STRINGS=array();
		if (($dh=opendir(get_file_base().'/lang/EN'))!==false)
		{
			while (($FILE=readdir($dh))!==false)
			{
				if ($FILE[0]!='.')
				{
					//echo htmlentities($FILE).', ';

					$map=better_parse_ini_file(get_file_base().'/lang/EN/'.$FILE);
					foreach ($map as $string=>$val)
					{
						if ((trim($string)!='') && ($string[0]!='['))
						{
							if (preg_match('/[<>&]/',$val)!=0)
							{
								$LANGUAGE_STRINGS[$string]=$FILE;
							}
						}
					}
				}
			}
			closedir($dh);
		}

		//echo '<h2>Processing for plain-usages&hellip;</h2>';
		$LANGUAGE_CURRENT=array();
		$forms=array(
			'#do_lang\(\'(.+?)\'(,|\))#ims',
			'#do_lang\(\\\\\'(.+?)\\\\\'(,|\))#ims',
			'#log_it\(\'(.+?)\'(\,|\))#ims',
		);
		foreach ($forms as $php)
		{
			$this->do_dir(get_file_base(),$php,'php');
		}
		$LANGUAGE_LITERAL=$LANGUAGE_CURRENT;

		//echo '<h2>Processing for HTML-usages&hellip;</h2>';
		$LANGUAGE_CURRENT=array();
		$forms=array(
			'#do_lang_tempcode\(\'(.+?)\'(,|\))#ims',
			'#do_lang_tempcode\(\\\\\'(.+?)\\\\\'(,|\))#ims',
			'#get_page_title\(\'(.+?)\'(\,|\))#ims',
		);
		foreach ($forms as $php)
		{
			$this->do_dir(get_file_base(),$php,'php');
		}
		$tpl='#\{!(\w+?)(\}|,)#ims';
		$this->do_dir(get_file_base().'/themes/default/templates',$tpl,'tpl');
		$LANGUAGE_HTML=$LANGUAGE_CURRENT;

		//echo '<h2>Apparent conflicts between usage as HTML and plain text&hellip;</h2>';

		$whitelist=array( // Checked are ok manually already
			'PERMISSION_CELL',
			'_MISSING_RESOURCE',
			'TUTORIAL_ON_THIS',
			'NO_PHP_FTP',
			'NA_EM',
			'QUERY_FAILED',
			'HTTP_DOWNLOAD_NO_SERVER',
			'_USER_NO_EXIST',
			'EMAIL_ADDRESS_IN_USE',
			'ALREADY_EXISTS',
			'CONFLICTING_EMOTICON_CODE',
			'REDIRECT_PAGE_TO',
			'WRITE_ERROR_CREATE',
			'WRITE_ERROR',
		);

		$result=array_keys(array_intersect_key($LANGUAGE_LITERAL,$LANGUAGE_HTML));
		$cnt=0;
		foreach ($result as $r)
		{
			if (in_array($r,$whitelist)) continue;

			$_a=$LANGUAGE_LITERAL[$r][0];
			$a=str_replace(get_file_base().'/','',$_a);
			$_b=$LANGUAGE_HTML[$r][0];
			$b=str_replace(get_file_base().'/','',$_b);
			$this->assertTrue(false,$r.': '.$a.' vs '.$b);
			//echo '<p>'.htmlentities($r).' (<a href="txmt://open?url=file://'.htmlentities($_a).'">'.htmlentities($a).'</a> and <a href="txmt://open?url=file://'.htmlentities($_b).'">'.htmlentities($b).')</a></p>';

			$cnt++;
		}
		//if ($cnt==0) echo '<p><em>None</em></p>';
	}

	function do_dir($dir,$exp,$ext)
	{
		global $FILE2;
		if (($dh=opendir($dir))!==false)
		{
			while (($file=readdir($dh))!==false)
			{
				if (($file[0]!='.') && ($file!='exports'))
				{
					if (is_file($dir.'/'.$file))
					{
						if (substr($file,-4,4)=='.'.$ext)
						{
							$FILE2=$dir.'/'.$file;
							//echo htmlentities($file).', ';
							$this->do_file($exp);
						}
					} elseif (is_dir($dir.'/'.$file))
					{
						$this->do_dir($dir.'/'.$file,$exp,$ext);
					}
				}
			}
		}
	}

	function do_file($exp)
	{
		global $FILE2;
		preg_replace_callback($exp,array($this,'find_php_use_match'),file_get_contents($FILE2));
	}

	function find_php_use_match($matches)
	{
		global $LANGUAGE_CURRENT,$FILE2,$LANGUAGE_STRINGS,$FIND_NO_GO_HTML_SPOTS;
		if ((!$FIND_NO_GO_HTML_SPOTS) && (!isset($LANGUAGE_STRINGS[$matches[1]]))) return;
		if (!isset($LANGUAGE_CURRENT[$matches[1]])) $LANGUAGE_CURRENT[$matches[1]]=array();
		$LANGUAGE_CURRENT[$matches[1]][]=$FILE2;
	}

}

