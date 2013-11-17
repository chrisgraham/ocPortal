<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		theme_debug
 */

class Hook_page_groupings_theme_debug
{
	/**
	 * Standard modular run function for do_next_menu hooks. They find links to put on standard navigation menus of the system.
	 *
	 * @param  ?MEMBER		Member ID to run as (NULL: current member)
	 * @param  boolean		Whether to use extensive documentation tooltips, rather than short summaries
	 * @return array			List of tuple of links (page grouping, icon, do-next-style linking data), label, help (optional) and/or nulls
	 */
	function run($member_id=NULL,$extensive_docs=false)
	{
		return array(
			array('style','menu/_generic_admin/tool',array('theme_debug',array(),get_page_zone('theme_debug')),make_string_tempcode('Theme testing / fixup tools')),
			array('style','menu/_generic_admin/tool',array('fix_partial_themewizard_css',array(),get_page_zone('fix_partial_themewizard_css')),make_string_tempcode('Fixup themewizard themes')),
			array('style','menu/_generic_admin/tool',array('css_check',array(),get_page_zone('css_check')),make_string_tempcode('Look for unused CSS')),
		);
	}
}


