<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license    http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright  ocProducts Ltd
 * @package    ocportal_tutorials
 */

/**
 * Block class.
 */
class Block_main_tutorials_carousel
{
    /**
     * Find details of the block.
     *
     * @return ?array                   Map of block info (null: block is disabled).
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
        $info['parameters'] = array();
        return $info;
    }

    /**
     * Uninstall the block.
     */
    public function uninstall()
    {
        $GLOBALS['SITE_DB']->drop_table_if_exists('tutorials_external');
        $GLOBALS['SITE_DB']->drop_table_if_exists('tutorials_tags');
        $GLOBALS['SITE_DB']->drop_table_if_exists('tutorials_internal');
    }

    /**
     * Install the block.
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
            't_add_date' => 'TIME',
        ));
    }

    /**
     * Find cacheing details for the block.
     *
     * @return ?array                   Map of cache details (cache_on and ttl) (null: block is disabled).
     */
    function cacheing_environment()
    {
        $info=array();
        $info['cache_on']='$map';
        $info['ttl']=60;
        return $info;
    }


    /**
     * Execute the block.
     *
     * @param  array                    $map A map of parameters.
     * @return tempcode                 The result of execution.
     */
    public function run($map)
    {
        i_solemnly_declare(I_UNDERSTAND_SQL_INJECTION | I_UNDERSTAND_XSS | I_UNDERSTAND_PATH_INJECTION);

        TODO
    }
}
