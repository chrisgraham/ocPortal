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
class occle_fs_test_set extends ocp_test_case
{
	function setUp()
	{
		$GLOBALS['NO_QUERY_LIMIT']=true;

		require_code('occle_fs');

		disable_php_memory_limit();

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
			$_path=get_file_base().'/'.$dir.'/hooks/systems/occle_fs/'.$occlefs_hook.'.php';
			$contents=file_get_contents($_path);
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

		// Check folder property editing works
		$path=array('var','banners','untitled','_folder.'.RESOURCEFS_DEFAULT_EXTENSION);
		$data1=$ob->read_file($path);
		$ob->write_file($path,$data1);
		$data2=$ob->read_file($path);
		$this->assertTrue($data1==$data2);
	}

	function testVarPorting()
	{
		// Test exporting something
		$out=remap_resource_id_as_portable('group','1');
		$this->assertTrue($out['label']=='Guests');
		$this->assertTrue($out['subpath']=='');
		$this->assertTrue($out['id']==db_get_first_id());

		// Test importing to something - binding to something that exists
		$in=remap_portable_as_resource_id('group',$out);
		$this->assertTrue(intval($in)==db_get_first_id());

		// Test importing to something - something that does not exist
		$ob=get_resource_occlefs_object('download');
		$port=array(
			'guid'=>'a-b-c-d-e-f',
			'label'=>'My Test Download',
			'subpath'=>'Downloads home/Some Deep/Path',
		);
		$in=remap_portable_as_resource_id('download',$port);
		$guid=find_guid_via_id('download',$in);
		$filename=$ob->convert_id_to_filename('download',$in);
		$this->assertTrue($guid==$port['guid']); // Tests it imported with the same GUID
		$subpath=$ob->search('download',$in,true);
		$this->assertTrue(strpos($subpath,'/')!==false); // Test it imported with a deep path

		// Tidy up, delete it
		$ob->file_delete($filename,$subpath);
	}

	function testFullVarCoverage()
	{
		$cma_hooks=find_all_hooks('systems','content_meta_aware')+find_all_hooks('systems','resource_meta_aware');
		$occlefs_hooks=find_all_hooks('systems','occle_fs');

		$referenced_in_cma=array();

		foreach (array_keys($cma_hooks) as $cma_hook)
		{
			$ob=get_content_object($cma_hook);
			$info=$ob->info();
			if (!is_null($info))
			{
				$fs_hook=$info['occle_filesystem_hook'];
				if (!is_null($fs_hook))
				{
					$this->assertTrue(array_key_exists($fs_hook,$occlefs_hooks),'OcCLE-FS hook with broken Resource-FS reference: '.$fs_hook);
					$referenced_in_cma[$fs_hook]=true;
				}
			}
		}

		foreach ($occlefs_hooks as $occlefs_hook=>$dir)
		{
			$path=get_file_base().'/'.$dir.'/hooks/systems/occle_fs/'.$occlefs_hook.'.php';
			$contents=file_get_contents($path);
			if (strpos($contents,' extends resource_fs_base')!==false)
			{
				$this->assertTrue(array_key_exists($occlefs_hook,$referenced_in_cma),'Resource-FS hook not referenced: '.$occlefs_hook);
			}
		}
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
