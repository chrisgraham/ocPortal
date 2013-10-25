<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		unit_testing
 */

/**
 * ocPortal test case class (unit testing).
 */
class specsettings_documented_test_set extends ocp_test_case
{
	function setUp()
	{
		if (function_exists('set_time_limit')) @set_time_limit(0);

		require_code('files2');

		parent::setUp();
	}

	function testSymbols()
	{
		$symbols_file=file_get_contents(get_file_base().'/sources/symbols.php');
		$directives_start_pos=strpos($symbols_file,'if ($type==TC_DIRECTIVE)');

		$tempcode_tutorial=file_get_contents(get_file_base().'/docs/pages/comcode_custom/EN/tut_tempcode.txt');

		$matches=array();
		$num_matches=preg_match_all('#^\t\t\tcase \'([\w\_]+)\':#m',$symbols_file,$matches);
		for ($i=0;$i<$num_matches;$i++)
		{
			if ((strpos($symbols_file,$matches[0][$i])<$directives_start_pos) && (strpos($symbols_file,$matches[0][$i].' // LEGACY')===false))
			{
				$symbol=$matches[1][$i];
				$this->assertTrue(strpos($tempcode_tutorial,'{$'.$symbol)!==false,'Missing documented symbol, {$'.$symbol.'}');
			}
		}
	}

	function testConfigSettings()
	{
		$config_editor_code=file_get_contents(get_file_base().'/config_editor.php');

		$found=array();

		$files=get_directory_contents(get_file_base());
		foreach ($files as $f)
		{
			if ((substr($f,-4)=='.php') && (basename($f)!='shared_installs.php') && (strpos($f,'_tests')===false) && (strpos($f,'_custom')===false) && (strpos($f,'sources/forum/')===false) && (strpos($f,'exports/')===false) && (basename($f)!='errorlog.php') && (basename($f)!='phpstub.php') && (basename($f)!='permissioncheckslog.php'))
			{
				$c=file_get_contents(get_file_base().'/'.$f);
				$matches=array();
				$num_matches=preg_match_all('#(\$SITE_INFO|\$GLOBALS\[\'SITE_INFO\'\])\[\'([^\'"]+)\'\]#',$c,$matches);
				for ($i=0;$i<$num_matches;$i++)
				{
					$var=$matches[2][$i];
					if ((/*string replace array*/$var!='reps') && (/*AFM*/strpos($var,'ftp_')===false) && (/*myocp*/strpos($var,'throttle_')===false) && (/*myocp*/strpos($var,'custom_')===false) && (/*Legacy password name*/$var!='admin_password') && (/*XML dev environment*/strpos($var,'_chain')===false))
					{
						$found[$var]=1;
					}
				}
			}
		}

		$found=array_keys($found);
		sort($found);

		foreach ($found as $var)
		{
			$this->assertTrue(strpos($config_editor_code,'\''.$var.'\'=>\'')!==false,'Missing config_editor UI for '.$var);
		}
	}

	function testValueOptions()
	{
		$codebook_text=file_get_contents(get_file_base().'/docs/pages/comcode_custom/EN/codebook_3.txt');

		$found=array();

		$files=get_directory_contents(get_file_base());
		foreach ($files as $f)
		{
			if ((substr($f,-4)=='.php') && (basename($f)!='shared_installs.php') && (strpos($f,'_tests')===false) && (strpos($f,'_custom')===false) && (strpos($f,'sources/forum/')===false) && (strpos($f,'exports/')===false) && (basename($f)!='errorlog.php') && (basename($f)!='phpstub.php') && (basename($f)!='permissioncheckslog.php'))
			{
				$c=file_get_contents(get_file_base().'/'.$f);
				$matches=array();
				$num_matches=preg_match_all('#get\_value\(\'([^\']+)\'\)#',$c,$matches);
				for ($i=0;$i<$num_matches;$i++)
				{
					$var=$matches[1][$i];
					if ((!file_exists(get_file_base().'/sources/hooks/systems/disposable_values/'.$var.'.php')) && ($var!='user_peak') && ($var!='user_peak_week') && (substr($var,0,5)!='last_') && (substr($var,0,4)!='ftp_') && ($var!='uses_ftp') && ($var!='occle_watched_chatroom') && (substr($var,0,8)!='delurk__') && (substr($var,0,7)!='backup_') && ($var!='version') && ($var!='ocf_version') && ($var!='newsletter_whatsnew') && ($var!='newsletter_send_time') && ($var!='site_salt') && ($var!='sitemap_building_in_progress') && ($var!='setupwizard_completed') && ($var!='site_bestmember') && ($var!='oracle_index_cleanup_last_time') && ($var!='timezone') && ($var!='users_online') && ($var!='ran_once')) // Quite a few are set in code
						$found[$var]=1;
				}
			}
		}

		$found=array_keys($found);
		sort($found);

		foreach ($found as $var)
		{
			$this->assertTrue(strpos($codebook_text,'[tt]'.$var.'[/tt]')!==false,'Missing Code Book listing for hidden value, '.$var);
		}
	}

	function testKeepSettings()
	{
		$codebook_text=file_get_contents(get_file_base().'/docs/pages/comcode_custom/EN/codebook_3.txt');

		$found=array();

		$files=get_directory_contents(get_file_base());
		foreach ($files as $f)
		{
			if ((substr($f,-4)=='.php') && (basename($f)!='shared_installs.php') && (strpos($f,'_tests')===false) && (strpos($f,'_custom')===false) && (strpos($f,'sources/forum/')===false) && (basename($f)!='errorlog.php') && (basename($f)!='phpstub.php') && (basename($f)!='permissioncheckslog.php'))
			{
				$c=file_get_contents($f);
				$matches=array();
				$num_matches=preg_match_all('#get\_param(\_integer)?\(\'(keep_[^\']+)\'[,\)]#',$c,$matches);
				for ($i=0;$i<$num_matches;$i++)
				{
					$var=$matches[2][$i];
					$found[$var]=1;
				}
			}
		}

		$found=array_keys($found);
		sort($found);

		foreach ($found as $var)
		{
			$this->assertTrue(strpos($codebook_text,'[tt]'.$var.'[/tt]')!==false,'Missing Code Book listing for keep setting, '.$var);
		}
	}
}
