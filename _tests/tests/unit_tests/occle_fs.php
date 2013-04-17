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
class occle_fs_test_set extends ocp_test_case
{
	function setUp()
	{
		$GLOBALS['NO_QUERY_LIMIT']=true;

		require_code('occle_fs');

		parent::setUp();
	}

	function testVar()
	{
		$ob=new occle_fs();

		// Check top-level 'var' works
		$var_files=$ob->listing(array('var'));
		$cnt=0;
		$occlefs_hooks=find_all_hooks('systems','occle_fs');
		foreach ($occlefs_hooks as $occlefs_hook=>$dir)
		{
			$path=get_file_base().'/'.$dir.'/hooks/systems/occle_fs/'.$occlefs_hook.'.php';
			$contents=file_get_contents($path);
			if (strpos($contents,' extends resource_fs_base')!==false)
			{
				$cnt++;
			}
		}
		$this->assertTrue(count($var_files[0])==$cnt);

		// Check one of the repository-FS filesystems works
		$files=$ob->listing(array('var','banners'));
		$this->assertTrue(count($files[0])!=0);
		$files=$ob->listing(array('var','banners','untitled'));
		$this->assertTrue(count($files[0])==0);
		$this->assertTrue(count($files[1])!=0);
		$path=array('var','banners','untitled','advertise_here.'.RESOURCEFS_DEFAULT_EXTENSION);
		$data1=$ob->read_file($path);
		$ob->write_file($path,$data1);
		$data2=$ob->read_file($path);
		$this->assertTrue($data1==$data2);
	}

	// This test will test the occle_fs_extended_config hooks are working properly, as well as the config option read/write in general.
	function testEtcDir()
	{
		$ob=new occle_fs();
		$files=$ob->listing(array('etc'));
		foreach ($files[1] as $file)
		{
			if (strpos($file[0],'.'.RESOURCEFS_DEFAULT_EXTENSION)!==false)
			{
				$path=array('etc',$file[0]);
				$data1=$ob->read_file($path);
				$ob->write_file($path,$data1);
				$data2=$ob->read_file($path);
				$this->assertTrue($data1==$data2);
			}
		}
	}

	function tearDown()
	{
		parent::tearDown();
	}
}
