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
	// This test will test the occle_fs_extended_config hooks are working properly, as well as the config option read/write in general.
	function testEtcDir()
	{
		require_code('occle_fs');
		$ob=new occle_fs();
		$files=$ob->listing(array('etc'));
		foreach ($files[1] as $file)
		{
			$meta_dir=array();
			$meta_root_node='etc';
			$data1=$ob->read_file($meta_dir,$meta_root_node,$file[0],$ob);
			$ob->write_file($meta_dir,$meta_root_node,$file[0],$data1,$ob);
			$data2=$ob->read_file($meta_dir,$meta_root_node,$file[0],$ob);
			$this->assertTrue($data1==$data2);
		}
	}
}
