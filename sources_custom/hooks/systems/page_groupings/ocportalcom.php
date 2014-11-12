<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license    http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright  ocProducts Ltd
 * @package    ocportalcom
 */

/**
 * Hook class.
 */
class Hook_page_groupings_ocportalcom
{
    /**
     * Run function for do_next_menu hooks. They find links to put on standard navigation menus of the system.
     *
     * @param  ?MEMBER                  Member ID to run as (NULL: current member)
     * @param  boolean                  Whether to use extensive documentation tooltips, rather than short summaries
     * @return array                    List of tuple of links (page grouping, icon, do-next-style linking data), label, help (optional) and/or nulls
     */
    public function run($member_id = null, $extensive_docs = false)
    {
        return array(
            array('tools', 'menu/_generic_admin/tool', array('admin_ocpusers', array(), get_module_zone('admin_ocpusers')), make_string_tempcode('ocPortal.com: Table of ocP users')),
            array('pages', 'menu/_generic_spare/page', array('sites', array('type' => 'misc'), get_module_zone('sites')), make_string_tempcode('ocPortal.com')),
        );
    }
}
