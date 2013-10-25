<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		password_censor
 */

class Hook_symbol_DECRYPT
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

		if ((isset($param[1])) && ($param[1]!=''))
		{
			require_code('encryption');
			if (is_encryption_enabled())
			{
				$value=decrypt_data($param[0],$param[1]);
			}
		}

		return $value;
	}

}
