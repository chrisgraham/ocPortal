<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2013

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
class clean_reinstall_test_set extends ocp_test_case
{
	function testOptions()
	{
		require_code('files2');
		$files=get_directory_contents(get_file_base());

		@ini_set('memory_limit','-1');

		foreach ($files as $i=>$file)
		{
			if (substr($file,-4)=='.php')
			{
				$file_contents=file_get_contents($file);
				$files[$i]=$file_contents;
			} else
			{
				$file_contents=NULL;
			}
		}

		$options=$GLOBALS['SITE_DB']->query_select('config',array('the_name'));
		foreach ($options as $option)
		{
			foreach ($files as $file_contents)
			{
				if ($file_contents===NULL) continue;

				if (strpos($file_contents,'delete_config_option(\''.$option['the_name'].'\');')!==false)
				{
					continue 2;
				}
			}

			$c=file_get_contents(get_file_base().'/adminzone/pages/modules/admin_config.php');
			$is_listed=(strpos(substr($c,0,strpos($c,'delete_config_option($option);')),'\''.$option['the_name'].'\'')!==false);
			$this->assertTrue($is_listed,'Could not find uninstall for option: '.$option['the_name']);
		}

		$privileges=$GLOBALS['SITE_DB']->query_select('privilege_list',array('the_name'));
		foreach ($privileges as $privilege)
		{
			foreach ($files as $file_contents)
			{
				if ($file_contents===NULL) continue;

				if (strpos($file_contents,'delete_privilege(\''.$privilege['the_name'].'\');')!==false)
				{
					continue 2;
				}
			}

			$c1=file_get_contents(get_file_base().'/sources/database_action.php');
			$c2=file_get_contents(get_file_base().'/sources/ocf_install.php');
			$_c2=substr($c2,0,strpos($c2,'Uninstall OCF'));
			$is_listed=(strpos($c1,'\''.$privilege['the_name'].'\'')!==false) || (strpos($_c2,'\''.$privilege['the_name'].'\'')!==false);
			$this->assertTrue($is_listed,'Could not find uninstall for privilege: '.$privilege['the_name']);
		}

		$tables=$GLOBALS['SITE_DB']->query_select('db_meta',array('DISTINCT m_table'));
		foreach ($tables as $table)
		{
			foreach ($files as $file_contents)
			{
				if ($file_contents===NULL) continue;

				if (strpos($file_contents,'drop_table_if_exists(\''.$table['m_table'].'\');')!==false)
				{
					continue 2;
				}
			}

			$is_installer=(strpos(file_get_contents(get_file_base().'/install.php'),'\''.$table['m_table'].'\'')!==false);
			$this->assertTrue($is_installer,'Could not find uninstall for table: '.$table['m_table']);
		}
	}
}
