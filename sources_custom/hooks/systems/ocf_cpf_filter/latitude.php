<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		core_ocf
 */

class Hook_ocf_cpf_filter_latitude
{

	/**
	 * Find which special CPF's to enable.
	 *
	 * @return array			A list of CPF's to enable
	 */
	function to_enable()
	{
		require_lang('main_google_map_users');
		$cpf=array();
		$cpf['latitude']=1;
		$cpf['longitude']=1;
		return $cpf;
	}

}


