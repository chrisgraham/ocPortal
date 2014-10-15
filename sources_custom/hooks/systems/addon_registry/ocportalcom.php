<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		ocportalcom
 */

class Hook_addon_registry_ocportalcom
{
    /**
	 * Get a list of file permissions to set
	 *
	 * @return array			File permissions to set
	 */
    public function get_chmod_array()
    {
        return array();
    }

    /**
	 * Get the version of ocPortal this addon is for
	 *
	 * @return float			Version number
	 */
    public function get_version()
    {
        return ocp_version_number();
    }

    /**
	 * Get the addon category
	 *
	 * @return string			The category
	 */
    public function get_category()
    {
        return 'Development';
    }

    /**
	 * Get the addon author
	 *
	 * @return string			The author
	 */
    public function get_author()
    {
        return 'Chris Graham';
    }

    /**
	 * Find other authors
	 *
	 * @return array			A list of co-authors that should be attributed
	 */
    public function get_copyright_attribution()
    {
        return array();
    }

    /**
	 * Get the addon licence (one-line summary only)
	 *
	 * @return string			The licence
	 */
    public function get_licence()
    {
        return 'Licensed on the same terms as ocPortal';
    }

    /**
	 * Get the description of the addon
	 *
	 * @return string			Description of the addon
	 */
    public function get_description()
    {
        return 'The ocPortal deployment/hosting platform. The hosting side of the build addon (ocportal_release_build).';
    }

    /**
	 * Get a list of tutorials that apply to this addon
	 *
	 * @return array			List of tutorials
	 */
    public function get_applicable_tutorials()
    {
        return array(
        );
    }

    /**
	 * Get a mapping of dependency types
	 *
	 * @return array			File permissions to set
	 */
    public function get_dependencies()
    {
        return array(
            'requires' => array(
                'downloads',
            ),
            'recommends' => array(
            ),
            'conflicts_with' => array(
            )
        );
    }

    /**
	 * Explicitly say which icon should be used
	 *
	 * @return URLPATH		Icon
	 */
    public function get_default_icon()
    {
        return 'themes/default/images/icons/48x48/menu/_generic_admin/tool.png';
    }

    /**
	 * Get a list of files that belong to this addon
	 *
	 * @return array			List of files
	 */
    public function get_file_list()
    {
        return array(
            'sources_custom/hooks/systems/addon_registry/ocportalcom.php',
            'adminzone/pages/modules_custom/admin_ocpusers.php',
            'adminzone/pages/minimodules_custom/_make_release.php',
            'sources_custom/hooks/systems/page_groupings/ocportalcom.php',
            'data_custom/ocportalcom_web_service.php',
            'lang_custom/EN/sites.ini',
            'lang_custom/EN/ocportalcom.ini',
            'pages/minimodules_custom/licence.php',
            'site/pages/modules_custom/sites.php',
            'sources_custom/ocportalcom.php',
            'sources_custom/hooks/systems/cron/site_cleanup.php',
            'uploads/website_specific/ocportal.com/myocp/template.sql',
            'uploads/website_specific/ocportal.com/myocp/template.tar',
            'data_custom/myocp_upgrade.php',
            'sources_custom/ocf_forumview.php',
            'sources_custom/errorservice.php',
            'sources_custom/miniblocks/fp_animation.php',
            'sources_custom/miniblocks/ocportalcom_featuretray.php',
            'sources_custom/miniblocks/ocportalcom_make_upgrader.php',
            'sources_custom/miniblocks/ocportalcom_new_tutorials.php',
            'themes/default/templates_custom/MO_NEW_WEBSITE.tpl',
            'themes/default/templates_custom/OC_DOWNLOAD_RELEASES.tpl',
            'themes/default/templates_custom/OC_DOWNLOAD_SCREEN.tpl',
            'themes/default/templates_custom/OC_HOSTING_COPY_SUCCESS_SCREEN.tpl',
            'themes/default/templates_custom/OC_SITE.tpl',
            'themes/default/templates_custom/OC_SITES_SCREEN.tpl',
            'uploads/website_specific/ocportal.com/.htaccess',
            'uploads/website_specific/ocportal.com/logos',
            'uploads/website_specific/ocportal.com/logos/a.png',
            'uploads/website_specific/ocportal.com/logos/b.png',
            'uploads/website_specific/ocportal.com/logos/choice.php',
            'uploads/website_specific/ocportal.com/logos/default.png',
            'uploads/website_specific/ocportal.com/logos/index.html',
            'uploads/website_specific/ocportal.com/scripts/addon_manifest.php',
            'uploads/website_specific/ocportal.com/scripts/errorservice.php',
            'uploads/website_specific/ocportal.com/scripts/fetch_release_details.php',
            'uploads/website_specific/ocportal.com/scripts/newsletter_join.php',
            'uploads/website_specific/ocportal.com/scripts/user.php',
            'uploads/website_specific/ocportal.com/scripts/version.php',
            'uploads/website_specific/ocportal.com/upgrades/make_upgrader.php',
            'uploads/website_specific/ocportal.com/upgrades/tarring.log',
        );
    }
}
