<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license    http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright  ocProducts Ltd
 * @package    google_translate
 */

class Hook_addon_registry_google_translate
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
        return 'Translation';
    }

    /**
     * Get the addon author
     *
     * @return string                   The author
     */
    public function get_author()
    {
        return 'Chris Graham';
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
        return 'This is the ocPortal plugin for Google-based automated content translation. By adding [code=""Comcode""][block]side_language[/block][/code] to a side panel of your website, you will give your users the option to translate the content of your website into another language by using Google Translate. Note that Google Translate is a paid API, so you will need to set it up as such -- enable the API in the Google Developers console, add a key (API * auth, Credentials, Create New Key), set up quote/billing for it, and then go and configure in ocPortal (Admin Zone > Setup > Configuration > Feature options > Google Translate). At first things will be extremely slow while the gtranslate_cache table fills up with translations for all ocPortal\'s language strings (you should let it run, even if it takes half an hour), but then things will speed up. This addon is intended for users serious about translation, to give a bootstrap to getting it done.

        If you merely want dynamic on-the-fly translation, it\'s best just to embed Google\'s standard Translate widget into your site somewhere.';
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
     * @return URLPATH                  Icon
     */
    public function get_default_icon()
    {
        return 'themes/default/images/icons/48x48/menu/_generic_admin/component.png';
    }

    /**
     * Get a list of files that belong to this addon
     *
     * @return array                    List of files
     */
    public function get_file_list()
    {
        return array(
            'sources_custom/hooks/systems/addon_registry/google_translate.php',
            'lang_custom/EN/google_translate.ini',
            'lang_custom/AR/global.ini',
            'lang_custom/BG/global.ini',
            'lang_custom/CS/global.ini',
            'lang_custom/DA/global.ini',
            'lang_custom/DE/global.ini',
            'lang_custom/EL/global.ini',
            'lang_custom/ES/global.ini',
            'lang_custom/FI/global.ini',
            'lang_custom/FR/global.ini',
            'lang_custom/HI/global.ini',
            'lang_custom/HR/global.ini',
            'lang_custom/IT/global.ini',
            'lang_custom/JA/global.ini',
            'lang_custom/KO/global.ini',
            'lang_custom/NL/global.ini',
            'lang_custom/PL/global.ini',
            'lang_custom/PT/global.ini',
            'lang_custom/RO/global.ini',
            'lang_custom/RU/global.ini',
            'lang_custom/SV/global.ini',
            'lang_custom/ZH-CN/global.ini',
            'lang_custom/ZH-TW/global.ini',
            'sources_custom/lang.php',
            'sources_custom/lang_compile.php',
            'sources_custom/lang3.php',
            'sources_custom/site2.php',
            'sources_custom/GTranslate.php',
            'caches/lang/AR/.htaccess',
            'caches/lang/AR/index.html',
            'caches/lang/BG/.htaccess',
            'caches/lang/BG/index.html',
            'caches/lang/CS/.htaccess',
            'caches/lang/CS/index.html',
            'caches/lang/DA/.htaccess',
            'caches/lang/DA/index.html',
            'caches/lang/DE/.htaccess',
            'caches/lang/DE/index.html',
            'caches/lang/EL/.htaccess',
            'caches/lang/EL/index.html',
            'caches/lang/ES/.htaccess',
            'caches/lang/ES/index.html',
            'caches/lang/FI/.htaccess',
            'caches/lang/FI/index.html',
            'caches/lang/FR/.htaccess',
            'caches/lang/FR/index.html',
            'caches/lang/HI/.htaccess',
            'caches/lang/HI/index.html',
            'caches/lang/HR/.htaccess',
            'caches/lang/HR/index.html',
            'caches/lang/IT/.htaccess',
            'caches/lang/IT/index.html',
            'caches/lang/JA/.htaccess',
            'caches/lang/JA/index.html',
            'caches/lang/KO/.htaccess',
            'caches/lang/KO/index.html',
            'caches/lang/NL/.htaccess',
            'caches/lang/NL/index.html',
            'caches/lang/PL/.htaccess',
            'caches/lang/PL/index.html',
            'caches/lang/PT/.htaccess',
            'caches/lang/PT/index.html',
            'caches/lang/RO/.htaccess',
            'caches/lang/RO/index.html',
            'caches/lang/RU/.htaccess',
            'caches/lang/RU/index.html',
            'caches/lang/SV/.htaccess',
            'caches/lang/SV/index.html',
            'caches/lang/ZH-CN/.htaccess',
            'caches/lang/ZH-CN/index.html',
            'caches/lang/ZH-TW/.htaccess',
            'caches/lang/ZH-TW/index.html',
            'caches/guest_pages/AR/.htaccess',
            'caches/guest_pages/AR/index.html',
            'caches/guest_pages/BG/.htaccess',
            'caches/guest_pages/BG/index.html',
            'caches/guest_pages/CS/.htaccess',
            'caches/guest_pages/CS/index.html',
            'caches/guest_pages/DA/.htaccess',
            'caches/guest_pages/DA/index.html',
            'caches/guest_pages/DE/.htaccess',
            'caches/guest_pages/DE/index.html',
            'caches/guest_pages/EL/.htaccess',
            'caches/guest_pages/EL/index.html',
            'caches/guest_pages/ES/.htaccess',
            'caches/guest_pages/ES/index.html',
            'caches/guest_pages/FI/.htaccess',
            'caches/guest_pages/FI/index.html',
            'caches/guest_pages/FR/.htaccess',
            'caches/guest_pages/FR/index.html',
            'caches/guest_pages/HI/.htaccess',
            'caches/guest_pages/HI/index.html',
            'caches/guest_pages/HR/.htaccess',
            'caches/guest_pages/HR/index.html',
            'caches/guest_pages/IT/.htaccess',
            'caches/guest_pages/IT/index.html',
            'caches/guest_pages/JA/.htaccess',
            'caches/guest_pages/JA/index.html',
            'caches/guest_pages/KO/.htaccess',
            'caches/guest_pages/KO/index.html',
            'caches/guest_pages/NL/.htaccess',
            'caches/guest_pages/NL/index.html',
            'caches/guest_pages/PL/.htaccess',
            'caches/guest_pages/PL/index.html',
            'caches/guest_pages/PT/.htaccess',
            'caches/guest_pages/PT/index.html',
            'caches/guest_pages/RO/.htaccess',
            'caches/guest_pages/RO/index.html',
            'caches/guest_pages/RU/.htaccess',
            'caches/guest_pages/RU/index.html',
            'caches/guest_pages/SV/.htaccess',
            'caches/guest_pages/SV/index.html',
            'caches/guest_pages/ZH-CN/.htaccess',
            'caches/guest_pages/ZH-CN/index.html',
            'caches/guest_pages/ZH-TW/.htaccess',
            'caches/guest_pages/ZH-TW/index.html',
            'caches/self_learning/AR/.htaccess',
            'caches/self_learning/AR/index.html',
            'caches/self_learning/BG/.htaccess',
            'caches/self_learning/BG/index.html',
            'caches/self_learning/CS/.htaccess',
            'caches/self_learning/CS/index.html',
            'caches/self_learning/DA/.htaccess',
            'caches/self_learning/DA/index.html',
            'caches/self_learning/DE/.htaccess',
            'caches/self_learning/DE/index.html',
            'caches/self_learning/EL/.htaccess',
            'caches/self_learning/EL/index.html',
            'caches/self_learning/ES/.htaccess',
            'caches/self_learning/ES/index.html',
            'caches/self_learning/FI/.htaccess',
            'caches/self_learning/FI/index.html',
            'caches/self_learning/FR/.htaccess',
            'caches/self_learning/FR/index.html',
            'caches/self_learning/HI/.htaccess',
            'caches/self_learning/HI/index.html',
            'caches/self_learning/HR/.htaccess',
            'caches/self_learning/HR/index.html',
            'caches/self_learning/IT/.htaccess',
            'caches/self_learning/IT/index.html',
            'caches/self_learning/JA/.htaccess',
            'caches/self_learning/JA/index.html',
            'caches/self_learning/KO/.htaccess',
            'caches/self_learning/KO/index.html',
            'caches/self_learning/NL/.htaccess',
            'caches/self_learning/NL/index.html',
            'caches/self_learning/PL/.htaccess',
            'caches/self_learning/PL/index.html',
            'caches/self_learning/PT/.htaccess',
            'caches/self_learning/PT/index.html',
            'caches/self_learning/RO/.htaccess',
            'caches/self_learning/RO/index.html',
            'caches/self_learning/RU/.htaccess',
            'caches/self_learning/RU/index.html',
            'caches/self_learning/SV/.htaccess',
            'caches/self_learning/SV/index.html',
            'caches/self_learning/ZH-CN/.htaccess',
            'caches/self_learning/ZH-CN/index.html',
            'caches/self_learning/ZH-TW/.htaccess',
            'caches/self_learning/ZH-TW/index.html',
            'lang_custom/AR/.htaccess',
            'lang_custom/AR/index.html',
            'lang_custom/BG/.htaccess',
            'lang_custom/BG/index.html',
            'lang_custom/CS/.htaccess',
            'lang_custom/CS/index.html',
            'lang_custom/DA/.htaccess',
            'lang_custom/DA/index.html',
            'lang_custom/DE/.htaccess',
            'lang_custom/DE/index.html',
            'lang_custom/EL/.htaccess',
            'lang_custom/EL/index.html',
            'lang_custom/ES/.htaccess',
            'lang_custom/ES/index.html',
            'lang_custom/FI/.htaccess',
            'lang_custom/FI/index.html',
            'lang_custom/FR/.htaccess',
            'lang_custom/FR/index.html',
            'lang_custom/HI/.htaccess',
            'lang_custom/HI/index.html',
            'lang_custom/HR/.htaccess',
            'lang_custom/HR/index.html',
            'lang_custom/IT/.htaccess',
            'lang_custom/IT/index.html',
            'lang_custom/JA/.htaccess',
            'lang_custom/JA/index.html',
            'lang_custom/KO/.htaccess',
            'lang_custom/KO/index.html',
            'lang_custom/NL/.htaccess',
            'lang_custom/NL/index.html',
            'lang_custom/PL/.htaccess',
            'lang_custom/PL/index.html',
            'lang_custom/PT/.htaccess',
            'lang_custom/PT/index.html',
            'sources_custom/hooks/systems/config/enable_google_translate.php',
        );
    }
}
