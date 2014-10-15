<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license    http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright  ocProducts Ltd
 * @package    image_syndication
 */

class Hook_config_photobucket_client_id
{
    /**
     * Gets the details relating to the config option.
     *
     * @return ?array                   The details (NULL: disabled)
     */
    public function get_details()
    {
        return array(
            'human_name' => 'PHOTOBUCKET_CLIENT_ID',
            'type' => 'line',
            'category' => 'FEATURE',
            'group' => 'UPLOADED_FILES',
            'explanation' => 'CONFIG_OPTION_photobucket_client_id',
            'shared_hosting_restricted' => '0',
            'list_options' => '',

            'addon' => 'image_syndication',
        );
    }

    /**
     * Gets the default value for the config option.
     *
     * @return ?string                  The default value (NULL: option is disabled)
     */
    public function get_default()
    {
        return '';
    }
}
