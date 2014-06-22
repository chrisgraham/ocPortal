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
class tracker_categories_test_set extends ocp_test_case
{
	function testHasAddons()
	{
		$post=array();
		$categories=unserialize(http_download_file(get_brand_base_url().'/data_custom/ocportalcom_web_service.php?call=get_tracker_categories',NULL,true,false,'ocPortal Test Platform',$post));
		$addons=find_all_hooks('systems','addon_registry');
		foreach ($addons as $addon=>$place)
		{
			if ($place=='sources')
				$this->assertTrue(in_array($addon,$categories),$addon);
		}
	}

	function testNoUnknownAddons()
	{
		$post=array();
		$categories=unserialize(http_download_file(get_brand_base_url().'/data_custom/ocportalcom_web_service.php?call=get_tracker_categories',NULL,true,false,'ocPortal Test Platform',$post));
		$addons=find_all_hooks('systems','addon_registry');
		foreach ($categories as $category)
		{
			if (strtolower($category)!=$category) continue; // Only lower case must correspond to addons
			if (strpos($category,'(old)')!==false) continue;

			$this->assertTrue(array_key_exists($category,$addons),$category);
		}
	}
}
