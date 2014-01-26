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
class sitemap_test_set extends ocp_test_case
{
	var $sitemap;
	var $flattened;

	function setUp()
	{
		$this->establish_admin_session();

		require_code('sitemap');

		$page_link='';
		$callback=NULL;
		$valid_node_types=NULL;
		$child_cutoff=NULL;
		$max_recurse_depth=NULL;
		$require_permission_support=false;
		$zone='_SEARCH';
		$consider_secondary_categories=true;
		$use_page_groupings=true;
		$consider_validation=false;
		$meta_gather=SITEMAP_GATHER__ALL;

		$this->sitemap=retrieve_sitemap_node($page_link,$callback,$valid_node_types,$child_cutoff,$max_recurse_depth,$require_permission_support,$zone,$use_page_groupings,$consider_secondary_categories,$consider_validation,$meta_gather);
		$this->flattened=$this->flatten_sitemap($this->sitemap);

		parent::setUp();
	}

	function flatten_sitemap($sitemap)
	{
		if ($sitemap['page_link']=='collaboration:' || $sitemap['page_link']=='forum:' || $sitemap['page_link']=='ocworld:')
			return array();

		$children=isset($sitemap['children'])?$sitemap['children']:NULL;
		unset($sitemap['children']);
		$ret=array($sitemap['page_link']=>$sitemap);

		if (!is_null($children))
		{
			foreach ($children as $c)
			{
				$_c=$this->flatten_sitemap($c);
				foreach ($_c as $k=>$__c)
				{
					if ($k!='' && $k!='site:members:misc')
					{
						//if (isset($ret[$k])) { @var_dump($ret);@exit($k); }
						$this->assertTrue(!isset($ret[$k]),'Duplicated page: '.$k);
					}

					$ret[$k]=$__c;
				}
			}
		}
		return $ret;
	}

	function testIsConclusive()
	{
		// Test we have an arbitrary entry-point, just to ensure things are still generating deeply
		$this->assertTrue(isset($this->flattened['adminzone:admin_config:base']));

		// Test we have an arbitrary resource, just to ensure things are still generating deeply
		$this->assertTrue(isset($this->flattened[get_module_zone('calendar').':calendar:misc:1']));
	}

	function testPageGroupingHelpDocsDefined()
	{
		$applicable_page_groupings=array(
			'audit',
			'security',
			'structure',
			'style',
			'setup',
			'tools',
			'cms',
			'',
		);

		require_code('site');

		$page_groupings=get_page_grouping_links();
		foreach ($page_groupings as $link)
		{
			if ($link===NULL) continue;

			if (in_array($link[0],$applicable_page_groupings))
			{
				if (($link[0]=='') && (is_array($link[2])) && (!in_array($link[2][2]['type'],$applicable_page_groupings))) continue;

				if (!is_object($link[3]))
				{
					$this->assertTrue(isset($link[4]),'Should be Tempcode for '.serialize($link));
				} else
				{
					if (!is_array($link[2])) continue;

					$test=_request_page($link[2][0],$link[2][2]);
					if ($test===false)
					{
						$this->assertTrue(true,'Cannot locate page '.$link[2][0]);
					} else
					{
						if (strpos($test[0],'_CUSTOM')===false)
							$this->assertTrue(isset($link[4]),'No help defined for '.$link[3]->evaluate());
					}
				}
			}
		}
	}

	function testHasIcons()
	{
		foreach ($this->flattened as $k=>$c)
		{
			if (preg_match('#^\w*:(\w*(:\w*)?)?$#',$k)!=0)
			{
				if (in_array($k,array(
					'site:popup_blockers',
					'site:userguide_chatcode',
					'site:userguide_comcode',
					'site:topsites',
					':recommend_help',
				))) continue;

				list($zone,$page)=explode(':',$k);
				$test=_request_page($page,$zone);
				if ($test===false) continue;

				if ((strpos($test[0],'_CUSTOM')===false) && (!in_array($k,array('adminzone:admin_config:base',':keymap'))))
					$this->assertTrue($c['extra_meta']['image']!='','Missing icon for: '.$k);
			}
		}
	}

	function testNoOrphans()
	{
		foreach ($this->flattened as $c)
		{
			$this->assertTrue(!isset($c['is_unexpected_orphan']),'Not tied in via page grouping '.serialize($c));
		}
	}

	function testNoIncompleteNodes()
	{
		$props=array(
			'title',
			'content_type',
			'content_id',
			'modifiers',
			'only_on_page',
			'page_link',
			'url',
			'extra_meta',
			'permissions',
			'has_possible_children',
			'sitemap_priority',
			'sitemap_refreshfreq',
		);
		$props_meta=array(
			'description',
			'image',
			'image_2x',
			'add_date',
			'edit_date',
			'submitter',
			'views',
			'rating',
			'meta_keywords',
			'meta_description',
			'categories',
			'validated',
			'db_row',
		);

		foreach ($this->flattened as $k=>$c)
		{
			foreach ($props as $prop)
			{
				$this->assertTrue(array_key_exists($prop,$c),'Missing property: '.$prop.' (for '.$k.')');
			}
			if (isset($c['extra_meta']))
			{
				foreach ($props_meta as $prop)
				{
					$this->assertTrue(array_key_exists($prop,$c['extra_meta']),'Missing meta property: '.$prop.' (for '.$k.')');
				}
			}
		}
	}

	function tearDown()
	{
		parent::tearDown();
	}
}
