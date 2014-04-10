<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.


 NOTE TO PROGRAMMERS:
   Do not edit this file. If you need to make changes, save your changed file to the appropriate *_custom folder
   **** If you ignore this advice, then your website upgrades (e.g. for bug fixes) will likely kill your changes ****

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		core
 */

class Hook_check_max_input_vars
{
	/**
	 * Check various input var restrictions.
	 *
	 * @return	array		List of warnings
	 */
	function run()
	{
		$warning=array();
		foreach (array('max_input_vars','suhosin.post.max_vars','suhosin.request.max_vars') as $setting)
		{
			if ((is_numeric(ini_get($setting))) && (intval(ini_get($setting))>10))
			{
				$this_setting_value=intval(ini_get($setting));
				if ($this_setting_value<1000)
				{
					$warning[]=do_lang_tempcode('__SUHOSIN_MAX_VARS_TOO_LOW',escape_html($setting));
				}
			}
		}
		return $warning;
	}
}
