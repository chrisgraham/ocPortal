<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		oc_thief
 */

class Hook_config_octhief_number
{
    /**
	 * Gets the details relating to the config option.
	 *
	 * @return ?array		The details (NULL: disabled)
	 */
    public function get_details()
    {
        return array(
            'human_name' => 'OCTHIEF_NUMBER',
            'type' => 'integer',
            'category' => 'POINTSTORE',
            'group' => 'OCTHIEF_TITLE',
            'explanation' => 'CONFIG_OPTION_octhief_number',
            'shared_hosting_restricted' => '0',
            'list_options' => '',
            'required' => true,

            'addon' => 'oc_thief',
        );
    }

    /**
	 * Gets the default value for the config option.
	 *
	 * @return ?string		The default value (NULL: option is disabled)
	 */
    public function get_default()
    {
        return '1';
    }
}
