<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license    http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright  ocProducts Ltd
 * @package    oc_gifts
 */

require_code('crud_module');

/**
 * Module page class.
 */
class Module_admin_ocgifts extends standard_crud_module
{
    public $lang_type = 'GIFT';
    public $select_name = 'NAME';
    public $content_type = 'group';
    public $possibly_some_kind_of_upload = true;
    public $output_of_action_is_confirmation = true;
    public $menu_label = 'OCGIFTS_TITLE';
    public $do_preview = null;
    public $view_entry_point = '_SEARCH:admin_ocgifts:view:_ID';

    /**
     * Find details of the module.
     *
     * @return ?array                   Map of module info (NULL: module is disabled).
     */
    public function info()
    {
        $info = array();
        $info['author'] = 'Chris Graham';
        $info['organisation'] = 'ocProducts';
        $info['hacked_by'] = null;
        $info['hack_version'] = null;
        $info['version'] = 4;
        $info['update_require_upgrade'] = 1;
        $info['locked'] = false;
        return $info;
    }

    /**
     * Install the module.
     *
     * @param  ?integer                 What version we're upgrading from (NULL: new install)
     * @param  ?integer                 What hack version we're upgrading from (NULL: new-install/not-upgrading-from-a-hacked-version)
     */
    public function install($upgrade_from = null,$upgrade_from_hack = null)
    {
        if (is_null($upgrade_from)) {
            $GLOBALS['SITE_DB']->create_table('ocgifts',array(
                'id' => '*AUTO',
                'name' => 'SHORT_TEXT',
                'image' => 'SHORT_TEXT',
                'price' => 'INTEGER',
                'enabled' => 'BINARY',
                'category' => 'SHORT_TEXT',
            ));

            $default_gifts = array();
            $default_gifts[] = array('name' => 'A Bouquet of Flowers','image' => 'uploads/ocgifts_addon/bouquet_of_flowers.gif','price' => 10,'enabled' => 1);
            $default_gifts[] = array('name' => 'A bag of Money!','image' => 'uploads/ocgifts_addon/Money_Bag_Icon.gif','price' => 10,'enabled' => 1);
            $default_gifts[] = array('name' => 'A glass of Beer','image' => 'uploads/ocgifts_addon/glass_of_beer.gif','price' => 10,'enabled' => 1);
            $default_gifts[] = array('name' => 'A Birthday Cake, Happy Birthday!!','image' => 'uploads/ocgifts_addon/Birthday_cake.gif','price' => 10,'enabled' => 1);
            $default_gifts[] = array('name' => 'A Football','image' => 'uploads/ocgifts_addon/3Football_%28soccer%29.gif','price' => 10,'enabled' => 1);
            $default_gifts[] = array('name' => 'Some Party Streamers, Lets Celebrate!!','image' => 'uploads/ocgifts_addon/ghirlande_festa.gif','price' => 10,'enabled' => 1);
            $default_gifts[] = array('name' => 'A Love Heart','image' => 'uploads/ocgifts_addon/love_heart.gif','price' => 10,'enabled' => 1);
            $default_gifts[] = array('name' => 'A Cocktail','image' => 'uploads/ocgifts_addon/hrum_cocktail.gif','price' => 10,'enabled' => 1);
            $default_gifts[] = array('name' => 'Some Balloons','image' => 'uploads/ocgifts_addon/jean_victor_balin_balloons.gif','price' => 10,'enabled' => 1);
            $default_gifts[] = array('name' => 'A four leaf Clover, Good Luck!','image' => 'uploads/ocgifts_addon/liftarn_Four_leaf_clover.gif','price' => 10,'enabled' => 1);
            $default_gifts[] = array('name' => 'A Green hat','image' => 'uploads/ocgifts_addon/liftarn_Green_hat.gif','price' => 10,'enabled' => 1);
            $default_gifts[] = array('name' => 'A Glass of Wine','image' => 'uploads/ocgifts_addon/2Muga_Glass_of_red_wine.png','price' => 10,'enabled' => 1);
            $default_gifts[] = array('name' => 'A Valentine\'s day Kiss','image' => 'uploads/ocgifts_addon/reporter_Happy_Valentine.gif','price' => 10,'enabled' => 1);
            $default_gifts[] = array('name' => 'A Drum kit','image' => 'uploads/ocgifts_addon/Drum_Kit_3.jpg','price' => 10,'enabled' => 1);
            $default_gifts[] = array('name' => 'An Electric Guitar','image' => 'uploads/ocgifts_addon/electric_guitar.jpg','price' => 10,'enabled' => 1);
            $default_gifts[] = array('name' => 'A Piano','image' => 'uploads/ocgifts_addon/piano.jpg','price' => 10,'enabled' => 1);
            $default_gifts[] = array('name' => 'A single red Rose','image' => 'uploads/ocgifts_addon/red-rose.jpg','price' => 10,'enabled' => 1);
            $default_gifts[] = array('name' => 'Some Champagne','image' => 'uploads/ocgifts_addon/Champagne.jpg','price' => 10,'enabled' => 1);
            $default_gifts[] = array('name' => 'A Kiss','image' => 'uploads/ocgifts_addon/2a%20kiss.jpg','price' => 10,'enabled' => 1);
            $default_gifts[] = array('name' => 'A Love note','image' => 'uploads/ocgifts_addon/love%20note.jpg','price' => 10,'enabled' => 1);
            $default_gifts[] = array('name' => 'A Santa hat','image' => 'uploads/ocgifts_addon/Santa_Hat.jpg','price' => 10,'enabled' => 1);
            foreach ($default_gifts as $dg) {
                $GLOBALS['SITE_DB']->query_insert('ocgifts',$dg+array('category' => do_lang('DEFAULT')));
            }

            $GLOBALS['SITE_DB']->create_table('members_gifts',array(
                'id' => '*AUTO',
                'to_member_id' => 'MEMBER',
                'from_member_id' => 'MEMBER',
                'gift_id' => 'AUTO_LINK',
                'add_time' => 'TIME',
                'is_anonymous' => 'BINARY',
                'gift_message' => 'LONG_TEXT',
            ));
        }

        if ((!is_null($upgrade_from)) && ($upgrade_from<3)) {
            $GLOBALS['SITE_DB']->add_table_field('ocgifts','category','SHORT_TEXT',do_lang('GENERAL'));

            $GLOBALS['SITE_DB']->alter_table_field('members_gifts','annonymous','BINARY','is_anonymous');
            $GLOBALS['SITE_DB']->alter_table_field('members_gifts','topic_id','?AUTO_LINK');
        }

        if ((!is_null($upgrade_from)) && ($upgrade_from<4)) {
            $GLOBALS['SITE_DB']->delete_table_field('members_gifts','topic_id');
            $GLOBALS['SITE_DB']->alter_table_field('members_gifts','from_user_id','MEMBER','from_member_id');
            $GLOBALS['SITE_DB']->alter_table_field('members_gifts','to_user_id','MEMBER','to_member_id');
        }
    }

    /**
     * Uninstall the module.
     */
    public function uninstall()
    {
        $GLOBALS['SITE_DB']->drop_table_if_exists('ocgifts');
        $GLOBALS['SITE_DB']->drop_table_if_exists('members_gifts');

        //require_code('files');
        //deldir_contents(get_custom_file_base().'/uploads/ocgifts_addon',true);
    }

    /**
     * Find entry-points available within this module.
     *
     * @param  boolean                  Whether to check permissions.
     * @param  ?MEMBER                  The member to check permissions as (NULL: current user).
     * @param  boolean                  Whether to allow cross links to other modules (identifiable via a full-page-link rather than a screen-name).
     * @param  boolean                  Whether to avoid any entry-point (or even return NULL to disable the page in the Sitemap) if we know another module, or page_group, is going to link to that entry-point. Note that "!" and "misc" entry points are automatically merged with container page nodes (likely called by page-groupings) as appropriate.
     * @return ?array                   A map of entry points (screen-name=>language-code/string or screen-name=>[language-code/string, icon-theme-image]) (NULL: disabled).
     */
    public function get_entry_points($check_perms = true,$member_id = null,$support_crosslinks = true,$be_deferential = false)
    {
        return array(
            'misc' => array('MANAGE_GIFTS','menu/ocgifts'),
        )+parent::get_entry_points();
    }

    public $title;

    /**
     * Module pre-run function. Allows us to know meta-data for <head> before we start streaming output.
     *
     * @param  boolean                  Whether this is running at the top level, prior to having sub-objects called.
     * @param  ?ID_TEXT                 The screen type to consider for meta-data purposes (NULL: read from environment).
     * @return ?tempcode                Tempcode indicating some kind of exceptional output (NULL: none).
     */
    public function pre_run($top_level = true,$type = null)
    {
        $type = get_param('type','misc');

        require_lang('ocgifts');

        set_helper_panel_tutorial('tut_subcom');

        if ($type == 'view') {
            breadcrumb_set_parents(array(array('_SELF:_SELF:misc',do_lang_tempcode('OCGIFTS_TITLE'))));
            breadcrumb_set_self(do_lang_tempcode('VIEW_GIFT'));
        }

        return parent::pre_run($top_level);
    }

    /**
     * Standard crud_module run_start.
     *
     * @param  ID_TEXT                  The type of module execution
     * @return tempcode                 The output of the run
     */
    public function run_start($type)
    {
        if (get_forum_type() != 'ocf') {
            warn_exit(do_lang_tempcode('NO_OCF'));
        } else {
            ocf_require_all_forum_stuff();
        }
        require_code('ocf_groups_action');
        require_code('ocf_forums_action');
        require_code('ocf_groups_action2');
        require_code('ocf_forums_action2');

        if ($type == 'misc') {
            return $this->misc();
        }
        if ($type == 'view') {
            return $this->view();
        }
        return new ocp_tempcode();
    }

    /**
     * The do-next manager for before content management.
     *
     * @return tempcode                 The UI
     */
    public function misc()
    {
        require_code('templates_donext');

        return do_next_manager(get_screen_title('OCGIFTS_TITLE'),comcode_lang_string('DOC_OCGIFTS'),
            array(
                array('menu/_generic_admin/add_one',array('_SELF',array('type' => 'ad'),'_SELF'),do_lang('ADD_GIFT')),
                array('menu/_generic_admin/edit_one',array('_SELF',array('type' => 'ed'),'_SELF'),do_lang('EDIT_GIFT')),
            ),
            do_lang('OCGIFTS_TITLE')
        );
    }

    /**
     * The UI to view details of a gift.
     *
     * @return tempcode                 The UI
     */
    public function view()
    {
        $id = null;
        $name = '';
        $image = '';
        $price = 0;
        $category = '';
        $enabled = do_lang_tempcode('GIFT_DISABLED');

        $id = get_param_integer('id',null);
        if ($id !== NULL) {
            $rows = $GLOBALS['SITE_DB']->query_select('ocgifts',array('*'),array('id' => $id));

            if (isset($rows[0]['id']) && $rows[0]['id']>0) {
                $id = $rows[0]['id'];
                $name = $rows[0]['name'];
                $image = $rows[0]['image'];
                $price = $rows[0]['price'];
                $category = $rows[0]['category'];
                $enabled = ($rows[0]['enabled'] == 1)?do_lang_tempcode('GIFT_ENABLED'):do_lang_tempcode('GIFT_DISABLED');
            }
        }

        require_code('templates_map_table');
        return map_table(get_screen_title('VIEW_GIFT'),array('NAME' => $name,'IMAGE' => $image,'PRICE' => integer_format($price),'CATEGORY' => $category,'ENABLED' => $enabled));
    }

    public function get_form_fields($id = null,$name = '',$category = '',$image = '',$price = 10,$enabled = 1)
    {
        $fields = new ocp_tempcode();
        $hidden = new ocp_tempcode();

        require_code('form_templates');

        $fields->attach(form_input_line(do_lang_tempcode('GIFT'),do_lang_tempcode('DESCRIPTION_GIFT'),'name',$name,true));

        $fields->attach(form_input_line(do_lang_tempcode('CATEGORY'),do_lang_tempcode('DESCRIPTION_GIFT_CATEGORY'),'category',$category,true));

        $set_name = 'image';
        $required = true;
        $set_title = do_lang_tempcode('IMAGE');
        $field_set = alternate_fields_set__start($set_name);

        $field_set->attach(form_input_upload(do_lang_tempcode('UPLOAD'),'','image',false,null,null,true,str_replace(' ','',get_option('valid_images'))));

        $field_set->attach(form_input_url(do_lang_tempcode('URL'),'','url',$image,false));

        $fields->attach(alternate_fields_set__end($set_name,$set_title,'',$field_set,$required,$image));

        handle_max_file_size($hidden,'image');

        $fields->attach(form_input_integer(do_lang_tempcode('PRICE'),'','price',$price,true));

        $fields->attach(form_input_tick(do_lang_tempcode('GIFT_ENABLED'),do_lang_tempcode('DESCRIPTION_GIFT_ENABLED'),'enabled',$enabled == 1));

        return array($fields,$hidden);
    }

    /**
     * Standard crud_module list function.
     *
     * @return tempcode                 The selection list
     */
    public function create_selection_list_entries()
    {
        $fields = new ocp_tempcode();

        $rows = $GLOBALS['SITE_DB']->query_select('ocgifts',array('*'),null);

        foreach ($rows as $row) {
            $fields->attach(form_input_list_entry(strval($row['id']),false,$row['name']));
        }

        return $fields;
    }

    /**
     * Standard crud_module edit form filler.
     *
     * @param  ID_TEXT                  The entry being edited
     * @return array                    A pair: The input fields, Hidden fields
     */
    public function fill_in_edit_form($id)
    {
        $rows = $GLOBALS['SITE_DB']->query_select('ocgifts',array('*'),array('id' => intval($id)));
        if (!array_key_exists(0,$rows)) {
            warn_exit(do_lang_tempcode('MISSING_RESOURCE'));
        }
        $myrow = $rows[0];

        $name = $myrow['name'];
        $image = $myrow['image'];
        $price = $myrow['price'];
        $enabled = $myrow['enabled'];
        $category = $myrow['category'];

        $ret = $this->get_form_fields($id,$name,$category,$image,$price,$enabled);

        return $ret;
    }

    /**
     * Standard crud_module add actualiser.
     *
     * @return ID_TEXT                  The entry added
     */
    public function add_actualisation()
    {
        $name = post_param('name');
        $category = post_param('category');
        $price = post_param_integer('price');
        $enabled = post_param_integer('enabled',0);

        require_code('uploads');

        $urls = get_url('url','image','uploads/ocgifts_addon',0,OCP_UPLOAD_IMAGE,false,'','');

        if ($urls[0] == '') {
            warn_exit(do_lang_tempcode('IMPROPERLY_FILLED_IN_UPLOAD'));
        }

        if ((substr($urls[0],0,8) != 'uploads/') && (is_null(http_download_file($urls[0],0,false))) && (!is_null($GLOBALS['HTTP_MESSAGE_B']))) {
            attach_message($GLOBALS['HTTP_MESSAGE_B'],'warn');
        }

        $url = $urls[0];

        $id = $GLOBALS['SITE_DB']->query_insert('ocgifts',array('name' => $name,'image' => $url,'price' => $price,'enabled' => $enabled,'category' => $category),true);

        return strval($id);
    }

    /**
     * Standard crud_module edit actualiser.
     *
     * @param  ID_TEXT                  The entry being edited
     * @return ?tempcode                Confirm message (NULL: continue)
     */
    public function edit_actualisation($id)
    {
        $name = post_param('name');
        $category = post_param('category');
        $price = post_param_integer('price');
        $enabled = post_param_integer('enabled',0);

        require_code('uploads');

        $urls = get_url('url','image','uploads/ocgifts_addon',0,OCP_UPLOAD_IMAGE,false,'','');

        if ($urls[0] == '') {
            warn_exit(do_lang_tempcode('IMPROPERLY_FILLED_IN_UPLOAD'));
        }

        if ((substr($urls[0],0,8) != 'uploads/') && (is_null(http_download_file($urls[0],0,false))) && (!is_null($GLOBALS['HTTP_MESSAGE_B']))) {
            attach_message($GLOBALS['HTTP_MESSAGE_B'],'warn');
        }

        $url = $urls[0];

        $GLOBALS['SITE_DB']->query_update('ocgifts',array('name' => $name,'image' => $url,'price' => $price,'enabled' => $enabled,'category' => $category),array('id' => intval($id)),'',1);

        return NULL;
    }

    /**
     * Standard crud_module delete actualiser.
     *
     * @param  ID_TEXT                  The entry being deleted
     */
    public function delete_actualisation($id)
    {
        $GLOBALS['SITE_DB']->query_delete('ocgifts',array('id' => intval($id)),'',1);
    }
}
