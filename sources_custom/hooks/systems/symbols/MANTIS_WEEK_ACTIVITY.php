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

class Hook_symbol_MANTIS_WEEK_ACTIVITY
{
	function run($param)
	{
		$cnt_in_last_week=$GLOBALS['SITE_DB']->query_value_null_ok_full('SELECT COUNT(*) FROM mantis_bug_table WHERE last_updated>'.strval(time()-60*60*24*7));
		return strval($cnt_in_last_week);
	}
}
