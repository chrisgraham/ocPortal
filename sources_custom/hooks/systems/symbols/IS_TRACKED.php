<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2011

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		tracking
 */

class Hook_symbol_IS_TRACKED
{

	/**
	 * Standard modular run function for symbol hooks. Searches for tasks to perform.
    *
    * @param  array		Symbol parameters
    * @return string		Result
	 */
	function run($param)
	{
		$value='';
		if (array_key_exists(0,$param))
		{
			require_code('tracking');
			$value=is_tracked(array_key_exists(1,$param)?$param[1]:get_page_name(),$param[0])?'1':'0';
		}
		return $value;
	}

}
