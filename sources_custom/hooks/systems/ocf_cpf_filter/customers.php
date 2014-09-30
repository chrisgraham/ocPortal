<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		ocportalcom_support_credits
 */

class Hook_ocf_cpf_filter_customers
{

	/**
	 * Find which special CPFs to enable.
	 *
	 * @return array			A list of CPFs to enable
	 */
	function to_enable()
	{
		require_lang('customers');

		$cpf=array();
		$cpf['ftp_host']=1;
		$cpf['ftp_path']=1;
		$cpf['ftp_username']=1;
		$cpf['ftp_password']=1;
		$cpf['profession']=1;
		$cpf['support_credits']=1;
		$cpf['currency']=1;
		return $cpf;
	}

}
