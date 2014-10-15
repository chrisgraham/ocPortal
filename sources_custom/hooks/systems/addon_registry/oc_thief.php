<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license    http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright  ocProducts Ltd
 * @package    oc_thief
 */

class Hook_addon_registry_oc_thief
{
    /**
     * Get a list of file permissions to set
     *
     * @return array                    File permissions to set
     */
    public function get_chmod_array()
    {
        return array();
    }

    /**
     * Get the version of ocPortal this addon is for
     *
     * @return float                    Version number
     */
    public function get_version()
    {
        return ocp_version_number();
    }

    /**
     * Get the addon category
     *
     * @return string                   The category
     */
    public function get_category()
    {
        return 'Fun and Games';
    }

    /**
     * Get the addon author
     *
     * @return string                   The author
     */
    public function get_author()
    {
        return 'Kamen Blaginov';
    }

    /**
     * Find other authors
     *
     * @return array                    A list of co-authors that should be attributed
     */
    public function get_copyright_attribution()
    {
        return array();
    }

    /**
     * Get the addon licence (one-line summary only)
     *
     * @return string                   The licence
     */
    public function get_licence()
    {
        return 'Licensed on the same terms as ocPortal';
    }

    /**
     * Get the description of the addon
     *
     * @return string                   Description of the addon
     */
    public function get_description()
    {
        return 'Add some random dynamic chaos to your website and has a number of options you can configure such as who you want points to be automatically stolen from.
        
There are four options:
 - \"Members that are inactive, but have a lot of points\"
 - \"Members that are rich\"
 - \"Members that are random\" (random member(-s) selection
 - \"Members that are in a certain usergroup\"

You can also decide how many users/victims ocThief will steal from and how much to steal.

After stealing the points from the \"unlucky\" members and giving them to \"lucky\" members it creates a Private Topics between them to explain what happened.

To configure ocThief go to Admin Zone > Setup > Configuration > Point store options, and scroll down to the ocThief options.';
    }

    /**
     * Get a list of tutorials that apply to this addon
     *
     * @return array                    List of tutorials
     */
    public function get_applicable_tutorials()
    {
        return array(
        );
    }

    /**
     * Get a mapping of dependency types
     *
     * @return array                    File permissions to set
     */
    public function get_dependencies()
    {
        return array(
            'requires' => array(
                'Cron',
                'OCF',
            ),
            'recommends' => array(
            ),
            'conflicts_with' => array(
            )
        );
    }

    /**
     * Get a list of files that belong to this addon
     *
     * @return array                    List of files
     */
    public function get_file_list()
    {
        return array(
            'sources_custom/hooks/systems/addon_registry/oc_thief.php',
            'lang_custom/EN/octhief.ini',
            'sources_custom/hooks/systems/cron/octhief.php',
            'sources_custom/hooks/systems/config/octhief_group.php',
            'sources_custom/hooks/systems/config/octhief_number.php',
            'sources_custom/hooks/systems/config/octhief_points.php',
            'sources_custom/hooks/systems/config/octhief_type.php',
        );
    }
}
