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
class resource_fs_test_set extends ocp_test_case
{
	var $resourcefs_obs;
	var $paths=NULL;

	function setUp()
	{
		parent::setUp();

		$GLOBALS['NO_QUERY_LIMIT']=true;

		require_code('content');
		require_code('resource_fs');

		if ($this->paths===NULL) $this->paths=array();

		$this->resourcefs_obs=array();
		$occlefs_hooks=find_all_hooks('systems','occle_fs');
		foreach ($occlefs_hooks as $occlefs_hook=>$dir)
		{
			$path=get_file_base().'/'.$dir.'/hooks/systems/occle_fs/'.$occlefs_hook.'.php';
			$contents=file_get_contents($path);
			if (strpos($contents,' extends resource_fs_base')!==false)
			{
				require_code('hooks/systems/occle_fs/'.$occlefs_hook);
				$ob=object_factory('Hook_occle_fs_'.$occlefs_hook);
				$this->resourcefs_obs[$occlefs_hook]=$ob;
			}
		}
	}

	function testFullCoverage()
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
					$this->assertTrue(array_key_exists($fs_hook,$occlefs_hooks),'OcCLE-FS hook with broke Resource-FS reference: '.$fs_hook);
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

	function testAdd()
	{
		foreach ($this->resourcefs_obs as $occlefs_hook=>$ob)
		{
			$path='';
			if (!is_null($ob->folder_resource_type))
			{
				$result=$ob->folder_add('test_a',$path,array());
				$this->assertTrue($result!==false,'Failed to folder_add '.$occlefs_hook);
				$path='test_a';
				if ($ob->folder_add('test_b',$path,array())!==false)
				{
					$path='test_a/test_b';
				}
			}
			$result=$ob->file_add('test_content.xml',$path,array());
			destrictify();
			$this->assertTrue($result!==false,'Failed to file_add '.$occlefs_hook);

			$this->paths[$occlefs_hook]=$path;
		}
	}

	function testLoad()
	{
		foreach ($this->resourcefs_obs as $occlefs_hook=>$ob)
		{
			$path=$this->paths[$occlefs_hook];

			if ($path!='')
			{
				$result=$ob->folder_load(basename($path),dirname($path));
				$this->assertTrue($result!==false,'Failed to folder_load '.$occlefs_hook);
			}

			$result=$ob->file_load('test_content.xml',$path);
			$this->assertTrue($result!==false,'Failed to file_load '.$occlefs_hook);
		}
	}

	function testEdit()
	{
		foreach ($this->resourcefs_obs as $occlefs_hook=>$ob)
		{
			$path=$this->paths[$occlefs_hook];

			if ($path!='')
			{
				$result=$ob->folder_edit(basename($path),dirname($path),array('label'=>basename($path)));
				$this->assertTrue($result!==false,'Failed to folder_edit '.$occlefs_hook);
			}

			$result=$ob->file_edit('test_content.xml',$path,array('label'=>'test_content'));
			$this->assertTrue($result!==false,'Failed to file_edit '.$occlefs_hook);
		}
	}

	function testDelete()
	{
		foreach ($this->resourcefs_obs as $occlefs_hook=>$ob)
		{
			$path=$this->paths[$occlefs_hook];

			if ($path!='')
			{
				$result=$ob->folder_delete(basename($path),dirname($path));
				$this->assertTrue($result!==false,'Failed to folder_delete '.$occlefs_hook);
			}

			$result=$ob->file_delete('test_content.xml',$path);
			$this->assertTrue($result!==false,'Failed to file_delete '.$occlefs_hook);
		}
	}

	function tearDown()
	{
		parent::tearDown();
	}
}
