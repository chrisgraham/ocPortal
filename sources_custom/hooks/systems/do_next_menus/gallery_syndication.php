<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		gallery_syndication
 */

class Hook_do_next_menus_gallery_syndication
{

	/**
	 * Standard modular run function for do_next_menu hooks. They find links to put on standard navigation menus of the system.
	 *
	 * @return array			Array of links and where to show
	 */
	function run()
	{
		require_lang('gallery_syndication');
		require_lang('oauth');

		$menu_items=array();

		$hooks=find_all_hooks('modules','video_syndication');

		foreach (array_keys($hooks) as $hook)
		{
			require_code('hooks/modules/video_syndication/'.filter_naughty($hook));
			$ob=object_factory('video_syndication_'.filter_naughty($hook));

			$service_title=$ob->get_service_title();

			$menu_items[]=array(
				'setup',
				'galleries',
				array($hook.'_oauth',array(),'adminzone'),
				do_lang_tempcode('OAUTH_TITLE',escape_html($service_title)),
				comcode_to_tempcode(do_lang('DOC_OAUTH_SETUP',$service_title))
			);
		}

		return $menu_items;
	}

}


