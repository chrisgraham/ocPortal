<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license    http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright  ocProducts Ltd
 * @package    oc_best_buddy
 */

/**
 * Hook class.
 */
class Hook_config_mentor_usergroup
{
    /**
     * Gets the details relating to the config option.
     *
     * @return ?array                   The details (NULL: disabled)
     */
    public function get_details()
    {
        return array(
            'human_name' => 'MENTOR_USERGROUP',
            'type' => 'usergroup',
            'category' => 'USERS',
            'group' => 'JOINING',
            'explanation' => 'CONFIG_OPTION_mentor_usergroup',
            'shared_hosting_restricted' => '0',
            'list_options' => '',
            'required' => true,

            'addon' => 'oc_best_buddy',
        );
    }

    /**
     * Gets the default value for the config option.
     *
     * @return ?string                  The default value (NULL: option is disabled)
     */
    public function get_default()
    {
        return do_lang('SUPER_MEMBERS');
    }
}
