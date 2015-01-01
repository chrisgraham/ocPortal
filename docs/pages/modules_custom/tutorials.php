<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2015

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license    http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright  ocProducts Ltd
 * @package    ocportal_tutorials
 */

/**
 * Module page class.
 */
class Module_tutorials
{
    /**
     * Find details of the module.
     *
     * @return ?array                   Map of module info (null: module is disabled).
     */
    public function info()
    {
        $info = array();
        $info['author'] = 'Chris Graham';
        $info['organisation'] = 'ocProducts';
        $info['hacked_by'] = null;
        $info['hack_version'] = null;
        $info['version'] = 1;
        $info['locked'] = false;
        return $info;
    }

    /**
     * Uninstall the module.
     */
    public function uninstall()
    {
        $GLOBALS['SITE_DB']->drop_table_if_exists('tutorials_external');
        $GLOBALS['SITE_DB']->drop_table_if_exists('tutorials_tags');
        $GLOBALS['SITE_DB']->drop_table_if_exists('tutorials_internal');
    }

    /**
     * Install the module.
     *
     * @param  ?integer                 $upgrade_from What version we're upgrading from (null: new install)
     * @param  ?integer                 $upgrade_from_hack What hack version we're upgrading from (null: new-install/not-upgrading-from-a-hacked-version)
     */
    public function install($upgrade_from = null, $upgrade_from_hack = null)
    {
        $GLOBALS['SITE_DB']->create_table('tutorials_external', array(
            'id' => '*AUTO',
            't_url' => 'URLPATH',
            't_title' => 'SHORT_TEXT',
            't_summary' => 'LONG_TEXT',
            't_icon' => 'URLPATH',
            't_media_type' => 'ID_TEXT', // document|video|audio|slideshow
            't_difficulty_level' => 'ID_TEXT', // novice|regular|expert
            't_pinned' => 'BINARY',
            't_author' => 'ID_TEXT',
            't_submitter' => 'MEMBER',
            't_views' => 'INTEGER',
            't_add_date' => 'TIME',
            't_edit_date' => 'TIME',
        ));

        $GLOBALS['SITE_DB']->create_table('tutorials_external_tags', array(
            't_id' => '*AUTO_LINK',
            't_tag' => '*ID_TEXT',
        ));

        $GLOBALS['SITE_DB']->create_table('tutorials_internal', array(
            't_page_name' => '*ID_TEXT',
            't_views' => 'INTEGER',
        ));

        // TODO: Write code to bootstrap existing external tutorials...
        //  Arvixe
        //  Ones on Youtube
        //  (we have some more videos to add to Youtube too)
    }

    /**
     * Find entry-points available within this module.
     *
     * @param  boolean                  $check_perms Whether to check permissions.
     * @param  ?MEMBER                  $member_id The member to check permissions as (null: current user).
     * @param  boolean                  $support_crosslinks Whether to allow cross links to other modules (identifiable via a full-page-link rather than a screen-name).
     * @param  boolean                  $be_deferential Whether to avoid any entry-point (or even return NULL to disable the page in the Sitemap) if we know another module, or page_group, is going to link to that entry-point. Note that "!" and "browse" entry points are automatically merged with container page nodes (likely called by page-groupings) as appropriate.
     * @return ?array                   A map of entry points (screen-name=>language-code/string or screen-name=>[language-code/string, icon-theme-image]) (null: disabled).
     */
    public function get_entry_points($check_perms = true, $member_id = null, $support_crosslinks = true, $be_deferential = false)
    {
        return array(
            'browse' => array('tutorials:TUTORIALS', 'menu/pages/help'),
        );
    }

    /**
     * Execute the module.
     *
     * @return tempcode                 The result of execution.
     */
    public function run()
    {
        require_code('tutorials');

        $title = get_screen_title('Tutorials &ndash; Learning ocPortal', false);

        $tag = get_param('type', 'Installation');

        $tags = list_tutorial_tags(true, ($tag == '' || $tag == 'browse') ? null : $tag);

        $tutorials = list_tutorials_by('title', ($tag == '') ? null : $tag);
        $_tutorials = templatify_tutorial_list($tutorials);

        return do_template('TUTORIAL_INDEX_SCREEN', array(
            'TITLE' => $title,
            'TAGS' => $tags,
            'SELECTED_TAG' => $tag,
            'TUTORIALS' => $_tutorials,
        ));
    }
}
