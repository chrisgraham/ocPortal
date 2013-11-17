<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		iotds
 */

class Hook_admin_import_types_iotds
{
	/**
	 * Standard modular run function.
	 *
	 * @return array		Results
	 */
	function run()
	{
		return array(
			'iotds'=>'IOTD_ARCHIVE',
		);
	}
}


