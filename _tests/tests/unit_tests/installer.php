<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		testing_platform
 */

/**
 * ocPortal test case class (unit testing).
 */
class installer_test_set extends ocp_test_case
{
	function testQuickInstaller()
	{
		$_GET['skip_quick']='0';
		$_GET['skip_manual']='0';
		$_GET['skip_bundled']='0';
		$_GET['skip_mszip']='0';
		$_GET['skip_debian']='0';

		require_code('version2');
		require_code('make_release');

		$builds_path=get_builds_path();
		$version_dotted=get_version_dotted();
		$install_path=$builds_path.'/builds/'.$version_dotted.'/install.php';

		$url=get_custom_base_url().'/exports/builds/'.$version_dotted.'/install.php';

		if (!is_file($install_path))
		{
			make_installers();
		}

		http_download_file($url);

		$this->assertTrue($GLOBALS['HTTP_MESSAGE']=='200');
	}

	function testDoesNotFullycrash()
	{
		$test=http_download_file(get_base_url().'/install.php',NULL,false);
		$this->assertTrue($GLOBALS['HTTP_MESSAGE']=='200');
		$this->assertTrue(strpos($test,'type="submit"')!==false); // Has start button: meaning something worked
	}

	function testFullInstall()
	{
		// Assumes we're using a blank root password, which is typically the case on development)

		// Cleanup old install
		$tables=$GLOBALS['SITE_DB']->query('SHOW TABLES FROM test');
		foreach ($tables as $table)
		{
			if (substr($table['Tables_in_test'],0,14)=='ocp_unit_test_')
			{
				$GLOBALS['SITE_DB']->query('DROP TABLE test.'.$table['Tables_in_test']);
			}
		}

		for ($i=0;$i<2;$i++) // 1st trial is clean DB, 2nd trial is dirty DB
		{
			rename(get_file_base().'/_config.php',get_file_base().'/_config.php.bak');

			$settings=array(
				'default_lang'=>'EN',
				'db_type'=>get_db_type(),
				'forum_type'=>'ocf',
				'board_path'=>get_file_base().'/forums',
				'domain'=>'localhost',
				'base_url'=>get_base_url(),
				'table_prefix'=>'ocp_unit_test_',
				'admin_password'=>'',
				'admin_password_confirm'=>'',
				'allow_reports_default'=>'1',
				'admin_username'=>'admin',
				'ocf_admin_password'=>'',
				'ocf_admin_password_confirm'=>'',
				'clear_existing_forums_on_install'=>'yes',
				'db_site'=>'test',
				'db_site_host'=>'127.0.0.1',
				'db_site_user'=>'root',
				'db_site_password'=>'',
				'user_cookie'=>'ocp_member_id',
				'pass_cookie'=>'ocp_member_hash',
				'cookie_domain'=>'',
				'cookie_path'=>'/',
				'cookie_days'=>'120',
				'db_forums'=>'test',
				'db_forums_host'=>'127.0.0.1',
				'db_forums_user'=>'root',
				'db_forums_password'=>'',
				'ocf_table_prefix'=>'ocp_unit_test_',
				'confirm'=>'1',
			);

			$stages=array(
				array(
					array(
					),
					array(
					),
				),

				array(
					array(
						'step'=>'2',
					),
					array(
						'max'=>'1000',
						'default_lang'=>'EN',
					),
				),

				array(
					array(
						'step'=>'3',
					),
					array(
						'max'=>'1000',
						'default_lang'=>'EN',
						'email'=>'E-mail address',
						'interest_level'=>'3',
						'advertise_on'=>'0',
					),
				),

				array(
					array(
						'step'=>'4',
					),
					array(
						'max'=>'1000',
						'default_lang'=>'EN',
						'email'=>'E-mail address',
						'interest_level'=>'3',
						'advertise_on'=>'0',
						'forum'=>'ocf',
						'forum_type'=>'ocf',
						'board_path'=>get_file_base().'/forums',
						'use_multi_db'=>'0',
						'use_msn'=>'0',
						'db_type'=>get_db_type(),
					),
				),

				array(
					array(
						'step'=>'5',
					),
					$settings,
				),

				array(
					array(
						'step'=>'6',
					),
					$settings,
				),

				array(
					array(
						'step'=>'7',
					),
					$settings,
				),

				array(
					array(
						'step'=>'8',
					),
					$settings,
				),

				array(
					array(
						'step'=>'9',
					),
					$settings,
				),

				array(
					array(
						'step'=>'10',
					),
					$settings,
				),
			);

			foreach ($stages as $stage)
			{
				list($get,$post)=$stage;
				$url=get_base_url().'/install.php?';
				foreach ($get as $key=>$val)
				{
					$url.='&'.urlencode($key).'='.urlencode($val);
				}
				/*echo */http_download_file($url,NULL,true,false,'ocPortal',$post);
				$this->assertTrue($GLOBALS['HTTP_MESSAGE']=='200');
				if ($GLOBALS['HTTP_MESSAGE']!='200') break; // Don't keep installing if there's an error
			}

			unlink(get_file_base().'/_config.php');
			rename(get_file_base().'/_config.php.bak',get_file_base().'/_config.php');

			if ($GLOBALS['HTTP_MESSAGE']!='200') break; // Don't do further trials if there's an error
		}
	}
}
