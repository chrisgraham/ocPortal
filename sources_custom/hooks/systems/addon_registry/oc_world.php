<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		oc_world
 */

class Hook_addon_registry_oc_world
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
        return 'Fun and Games';
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
        return array(
            'Clip art from "Madlantern Arts Clipart" used with permission.',
        );
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
        return 'ocWorld -- A world of fun.

A \"multi user dungeon\" (MUD) environment where members (players) may interact with each other and construct virtual worlds. The system includes an economy based on points.

There is a very carefully selected feature-set that allows interesting world interactions; quests, adventures, simulations, and other things may all be created by clever use of this feature-set.

ocWorld is a full zone addon for ocPortal.';
    }

    /**
	 * Get a list of tutorials that apply to this addon
	 *
	 * @return array			List of tutorials
	 */
    public function get_applicable_tutorials()
    {
        return array(
            'tut_ocworld',
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
                'points',
                'pointstore',
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
        return 'themes/default/images_custom/icons/48x48/menu/ocworld.png';
    }

    /**
	 * Get a list of files that belong to this addon
	 *
	 * @return array			List of files
	 */
    public function get_file_list()
    {
        return array(
            'themes/default/images_custom/icons/24x24/menu/ocworld.png',
            'themes/default/images_custom/icons/48x48/menu/ocworld.png',
            'sources_custom/hooks/systems/addon_registry/oc_world.php',
            'data_custom/modules/ocworld/index.html',
            'sources_custom/hooks/modules/admin_themewizard/ocworld.php',
            'sources_custom/ocworld.php',
            'themes/default/templates_custom/W_MAIN_PEOPLE_SEP.tpl',
            'themes/default/templates_custom/W_CONFIRM_SCREEN.tpl',
            'themes/default/templates_custom/W_INVENTORY_SCREEN.tpl',
            'themes/default/templates_custom/W_INVENTORY_ITEM.tpl',
            'themes/default/templates_custom/W_ITEMCOPY_SCREEN.tpl',
            'themes/default/templates_custom/W_ITEM_SCREEN.tpl',
            'themes/default/templates_custom/W_MAIN_SCREEN.tpl',
            'themes/default/templates_custom/W_MAIN_ITEM.tpl',
            'themes/default/templates_custom/W_MAIN_ITEMS_HELD.tpl',
            'themes/default/templates_custom/W_MAIN_ITEMS_OWNED.tpl',
            'themes/default/templates_custom/W_MAIN_ITEM_OWNED.tpl',
            'themes/default/templates_custom/W_MAIN_ITEM_OWNED_SEP.tpl',
            'themes/default/templates_custom/W_MAIN_MEMBER.tpl',
            'themes/default/templates_custom/W_MAIN_PEOPLE_HERE.tpl',
            'themes/default/templates_custom/W_MAIN_PERSON_HERE.tpl',
            'themes/default/templates_custom/W_MAIN_PORTAL.tpl',
            'themes/default/templates_custom/W_MESSAGES_HTML_WRAP.tpl',
            'themes/default/templates_custom/W_MESSAGE_ALL.tpl',
            'themes/default/templates_custom/W_MESSAGE_TO.tpl',
            'themes/default/templates_custom/W_PORTAL_SCREEN.tpl',
            'themes/default/templates_custom/W_QUESTION_SCREEN.tpl',
            'themes/default/templates_custom/W_REALLOCATE.tpl',
            'themes/default/templates_custom/W_REALM_LIST_ENTRY.tpl',
            'themes/default/templates_custom/W_REALM_SCREEN.tpl',
            'themes/default/templates_custom/W_REALM_SCREEN_QUESTION.tpl',
            'themes/default/templates_custom/W_ROOM_SCREEN.tpl',
            'themes/default/templates_custom/W_TROLL.tpl',
            'themes/default/templates_custom/W_TROLL_QUESTION.tpl',
            'sources_custom/ocworld_action.php',
            'sources_custom/ocworld_screens.php',
            'sources_custom/ocworld_scripts.php',
            'ocworld/index.php',
            'ocworld/map.php',
            'ocworld/wmessages.php',
            'ocworld/pages/comcode/.htaccess',
            'ocworld/pages/comcode/EN/.htaccess',
            'ocworld/pages/comcode_custom/EN/docs.txt',
            'ocworld/pages/comcode/EN/index.html',
            'ocworld/pages/comcode_custom/EN/rules.txt',
            'ocworld/pages/comcode/EN/start.txt',
            'ocworld/pages/comcode/index.html',
            'ocworld/pages/comcode_custom/.htaccess',
            'ocworld/pages/comcode_custom/EN/.htaccess',
            'ocworld/pages/comcode_custom/EN/index.html',
            'ocworld/pages/comcode_custom/index.html',
            'ocworld/pages/html/.htaccess',
            'ocworld/pages/html/EN/.htaccess',
            'ocworld/pages/html/EN/index.html',
            'ocworld/pages/html/index.html',
            'ocworld/pages/html_custom/index.html',
            'ocworld/pages/html_custom/EN/.htaccess',
            'ocworld/pages/html_custom/EN/index.html',
            'ocworld/pages/index.html',
            'ocworld/pages/minimodules/.htaccess',
            'ocworld/pages/minimodules/index.html',
            'ocworld/pages/minimodules_custom/.htaccess',
            'ocworld/pages/minimodules_custom/index.html',
            'ocworld/pages/modules/.htaccess',
            'ocworld/pages/modules/index.html',
            'ocworld/pages/modules_custom/ocworld.php',
            'ocworld/pages/modules_custom/.htaccess',
            'ocworld/pages/modules_custom/index.html',
            'lang_custom/EN/ocworld.ini',
            'themes/default/images_custom/ocworld/additem.png',
            'themes/default/images_custom/ocworld/additemcopy.png',
            'themes/default/images_custom/ocworld/addportal.png',
            'themes/default/images_custom/ocworld/addroom.png',
            'themes/default/images_custom/ocworld/delrealm.png',
            'themes/default/images_custom/ocworld/delroom.png',
            'themes/default/images_custom/ocworld/emergencyteleport.png',
            'themes/default/images_custom/ocworld/help.png',
            'themes/default/images_custom/ocworld/index.html',
            'themes/default/images_custom/ocworld/inventory.png',
            'themes/default/images_custom/ocworld/map.png',
            'themes/default/images_custom/ocworld/realms.png',
            'themes/default/images_custom/ocworld/refresh.png',
            'themes/default/images_custom/ocworld/rules.png',
            'themes/default/css_custom/ocworld.css',
            'sources_custom/hooks/modules/members/ocworld.php',
            'sources_custom/hooks/modules/topicview/ocworld.php',
            'sources_custom/hooks/systems/page_groupings/ocworld.php',
            'uploads/ocworld/index.html',
            'data_custom/modules/ocworld/docs/basics2.0.png',
            'data_custom/modules/ocworld/docs/basics2.1.png',
            'data_custom/modules/ocworld/docs/basics2.2.png',
            'data_custom/modules/ocworld/docs/basics2.3.0.png',
            'data_custom/modules/ocworld/docs/basics2.3.1.png',
            'data_custom/modules/ocworld/docs/basics2.3.2.png',
            'data_custom/modules/ocworld/docs/basics2.4.png',
            'data_custom/modules/ocworld/docs/basics2.5.0.png',
            'data_custom/modules/ocworld/docs/index.html',
            'data_custom/modules/ocworld/docs/port0.0.png',
            'data_custom/modules/ocworld/docs/port0.1.png',
            'data_custom/modules/ocworld/docs/port0.2.png',
            'data_custom/modules/ocworld/docs/port0.3.png',
            'data_custom/modules/ocworld/docs/port0.4.png',
            'data_custom/modules/ocworld/docs/port0.5.png',
            'data_custom/modules/ocworld/docs/realm1.1.png',
            'data_custom/modules/ocworld/docs/realm1.2.png',
            'data_custom/modules/ocworld/docs/realm1.3.png',
            'data_custom/modules/ocworld/docs/realm1.4.png',
            'data_custom/modules/ocworld/docs/room1.0.png',
            'data_custom/modules/ocworld/docs/room1.1.png',
            'data_custom/modules/ocworld/docs/room1.2.png',
            'data_custom/modules/ocworld/docs/room1.3.png',
            'data_custom/modules/ocworld/docs/roompw1.0.png',
            'data_custom/modules/ocworld/docs/roompw1.1.png',
            'data_custom/modules/ocworld/docs//modules/ocworld/index.html',
        );
    }
}
