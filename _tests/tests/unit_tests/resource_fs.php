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

/*
These tests test all var hooks. Some general Resource-FS tests are in the occle_fs test set.
*/

/**
 * ocPortal test case class (unit testing).
 */
class resource_fs_test_set extends ocp_test_case
{
    public $resourcefs_obs;
    public $paths = null;

    public function setUp()
    {
        parent::setUp();

        $GLOBALS['NO_QUERY_LIMIT'] = true;

        require_code('content');
        require_code('resource_fs');

        if ($this->paths === NULL) {
            $this->paths = array();
        }

        $this->resourcefs_obs = array();
        $occlefs_hooks = find_all_hooks('systems','occle_fs');
        foreach ($occlefs_hooks as $occlefs_hook => $dir) {
            $path = get_file_base() . '/' . $dir . '/hooks/systems/occle_fs/' . $occlefs_hook . '.php';
            $contents = file_get_contents($path);
            if (strpos($contents,' extends resource_fs_base') !== false) {
                require_code('hooks/systems/occle_fs/' . $occlefs_hook);
                $ob = object_factory('Hook_occle_fs_' . $occlefs_hook);
                $this->resourcefs_obs[$occlefs_hook] = $ob;
            }
        }
    }

    public function testAdd()
    {
        foreach ($this->resourcefs_obs as $occlefs_hook => $ob) {
            $path = '';
            if (!is_null($ob->folder_resource_type)) {
                $result = $ob->folder_add('test_a',$path,array());
                $this->assertTrue($result !== false,'Failed to folder_add ' . $occlefs_hook);
                $folder_resource_type_1 = is_array($ob->folder_resource_type)?$ob->folder_resource_type[0]:$ob->folder_resource_type;
                $path = $ob->folder_convert_id_to_filename($folder_resource_type_1,$result);
                $result = $ob->folder_add('test_b',$path,array());
                if ($result !== false) {
                    $folder_resource_type_2 = is_array($ob->folder_resource_type)?$ob->folder_resource_type[1]:$ob->folder_resource_type;
                    $path .= '/' . $ob->folder_convert_id_to_filename($folder_resource_type_2,$result);
                }
            }
            $result = $ob->file_add('test_content.' . RESOURCEFS_DEFAULT_EXTENSION,$path,array());
            destrictify();
            $this->assertTrue($result !== false,'Failed to file_add ' . $occlefs_hook);
            $this->paths[$occlefs_hook] = $path;
        }
    }

    public function testCount()
    {
        $occle_fs = new occle_fs();

        foreach ($this->resourcefs_obs as $occlefs_hook => $ob) {
            $count = 0;
            if (!is_null($ob->folder_resource_type)) {
                foreach (is_array($ob->folder_resource_type)?$ob->folder_resource_type:array($ob->folder_resource_type) as $resource_type) {
                    $count += $ob->get_resources_count($resource_type);
                    $this->assertTrue($ob->find_resource_by_label($resource_type,uniqid('',true)) == array()); // Search for a unique random ID should find nothing
                }
            }
            foreach (is_array($ob->file_resource_type)?$ob->file_resource_type:array($ob->file_resource_type) as $resource_type) {
                $count += $ob->get_resources_count($resource_type);
                $this->assertTrue($ob->find_resource_by_label($resource_type,uniqid('',true)) == array()); // Search for a unique random ID should find nothing
            }

            $listing = $this->_recursive_listing($ob,array(),array('var',$occlefs_hook),$occle_fs);
            $this->assertTrue($count == count($listing),'File/folder count mismatch for ' . $occlefs_hook);
            //if ($count!=count($listing)){@var_dump($listing);@exit('!'.$count.'!'.$occlefs_hook);} Useful for debugging
        }
    }

    public function _recursive_listing($ob,$meta_dir,$meta_root_node,$occle_fs)
    {
        $listing = $ob->listing($meta_dir,$meta_root_node,$occle_fs);
        foreach ($listing as $f) {
            if ($f[1] == OCCLEFS_DIR) {
                $sub_listing = $this->_recursive_listing($ob,array_merge($meta_dir,array($f[0])),$meta_root_node,$occle_fs);
                foreach ($sub_listing as $s_f) {
                    $suffix = '.' . RESOURCEFS_DEFAULT_EXTENSION;
                    if (($s_f[0] != '_folder' . $suffix) && (($s_f[1] == OCCLEFS_DIR) || (substr($s_f[0],-strlen($suffix)) == $suffix))) {
                        $s_f[0] = $f[0] . '/' . $s_f[0];
                        $listing[] = $s_f;
                    }
                }
            }
        }
        return $listing;
    }

    public function testSearch()
    {
        foreach ($this->resourcefs_obs as $occlefs_hook => $ob) {
            if (!is_null($ob->folder_resource_type)) {
                $folder_resource_type = is_array($ob->folder_resource_type)?$ob->folder_resource_type[0]:$ob->folder_resource_type;
                list(,$folder_resource_id) = $ob->folder_convert_filename_to_id('test_a',$folder_resource_type);
                $test = $ob->search($folder_resource_type,$folder_resource_id,true);
                $this->assertTrue($test !== NULL,'Could not search for ' . $folder_resource_type);
            }

            $file_resource_type = is_array($ob->file_resource_type)?$ob->file_resource_type[0]:$ob->file_resource_type;
            list(,$file_resource_id) = $ob->file_convert_filename_to_id('test_content',$file_resource_type);
            $test = $ob->search($file_resource_type,$file_resource_id,true);
            $this->assertTrue($test !== NULL,'Could not search for ' . $file_resource_type);
            if (!is_null($test)) {
                if (is_null($ob->folder_resource_type)) {
                    $this->assertTrue($test == '','Should have found in root, ' . $file_resource_type);
                } else {
                    $this->assertTrue($test != '','Should not have found in root, ' . $file_resource_type);
                }
            }
        }
    }

    public function testFindByLabel()
    {
        foreach ($this->resourcefs_obs as $occlefs_hook => $ob) {
            if (!is_null($ob->folder_resource_type)) {
                $results = array();
                foreach (is_array($ob->folder_resource_type)?$ob->folder_resource_type:array($ob->folder_resource_type) as $resource_type) {
                    $results = array_merge($results,$ob->find_resource_by_label($resource_type,'test_a'));
                    $results = array_merge($results,$ob->find_resource_by_label($resource_type,'test_b'));
                }
                $this->assertTrue(count($results)>0,'Failed to find_resource_by_label (folder) ' . $occlefs_hook);
            }
            $results = array();
            foreach (is_array($ob->file_resource_type)?$ob->file_resource_type:array($ob->file_resource_type) as $resource_type) {
                $results = array_merge($results,$ob->find_resource_by_label($resource_type,'test_content'));
            }
            $this->assertTrue(count($results)>0,'Failed to find_resource_by_label (file) ' . $occlefs_hook);
        }
    }

    public function testLoad()
    {
        foreach ($this->resourcefs_obs as $occlefs_hook => $ob) {
            $path = $this->paths[$occlefs_hook];

            if ($path != '') {
                $result = $ob->folder_load(basename($path),dirname($path));
                $this->assertTrue($result !== false,'Failed to folder_load ' . $occlefs_hook);
            }

            $result = $ob->file_load('test_content.' . RESOURCEFS_DEFAULT_EXTENSION,$path);
            $this->assertTrue($result !== false,'Failed to file_load ' . $occlefs_hook);
        }
    }

    public function testEdit()
    {
        foreach ($this->resourcefs_obs as $occlefs_hook => $ob) {
            $path = $this->paths[$occlefs_hook];

            if ($path != '') {
                $result = $ob->folder_load(basename($path),(strpos($path,'/') === false)?'':dirname($path));
                $result = $ob->folder_edit(basename($path),(strpos($path,'/') === false)?'':dirname($path),$result);
                $this->assertTrue($result !== false,'Failed to folder_edit ' . $occlefs_hook);

                if (strpos($path,'/') !== false) {
                    $_path = dirname($path);
                    $result = $ob->folder_load(basename($_path),(strpos($_path,'/') === false)?'':dirname($_path));

                    $result = $ob->folder_edit(basename($_path),(strpos($_path,'/') === false)?'':dirname($_path),$result);
                    $this->assertTrue($result !== false,'Failed to folder_edit ' . $occlefs_hook);
                }
            }

            $result = $ob->file_edit('test_content.' . RESOURCEFS_DEFAULT_EXTENSION,$path,array('label' => 'test_content'));
            $this->assertTrue($result !== false,'Failed to file_edit ' . $occlefs_hook);
        }
    }

    public function testDelete()
    {
        foreach ($this->resourcefs_obs as $occlefs_hook => $ob) {
            $path = $this->paths[$occlefs_hook];

            $result = $ob->file_delete('test_content.' . RESOURCEFS_DEFAULT_EXTENSION,$path);
            $this->assertTrue($result !== false,'Failed to file_delete ' . $occlefs_hook);

            if ($path != '') {
                $result = $ob->folder_delete(basename($path),(strpos($path,'/') === false)?'':dirname($path));
                $this->assertTrue($result !== false,'Failed to folder_delete ' . $occlefs_hook);

                if (strpos($path,'/') !== false) {
                    $_path = dirname($path);
                    $result = $ob->folder_delete(basename($_path),(strpos($_path,'/') === false)?'':dirname($_path));
                    $this->assertTrue($result !== false,'Failed to folder_delete ' . $occlefs_hook);
                }
            }
        }
    }

    public function tearDown()
    {
        parent::tearDown();
    }
}
