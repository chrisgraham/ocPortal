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

/**
 * Declare that an action succeeded - delete safety autosave cookies.
 */
function clear_ocp_autosave()
{
	$or_list='';
	foreach (array_keys($_COOKIE) as $key)
	{
		if (substr($key,0,13)=='ocp_autosave_')
		{
			require_code('users_active_actions');

			if (strpos($key,'page'.get_page_name())!==false)
			{
				// Has to do both, due to inconsistencies with how PHP reads and sets cookies -- reading de-urlencodes (although not strictly needed), whilst setting does not urlencode; may differ between versions
				ocp_setcookie(urlencode($key),'0',false,false,0);
				ocp_setcookie($key,'0',false,false,0);
				if ($or_list!='') $or_list.=' OR ';
				$or_list.=db_string_equal_to('a_key',$key);
			}
		}
	}
	if ($or_list!='')
	{
		$GLOBALS['SITE_DB']->query('DELETE FROM '.$GLOBALS['SITE_DB']->get_table_prefix().'autosave WHERE a_time<'.strval(time()-60*60*24).' OR (a_member_id='.strval(intval(get_member())).' AND ('.$or_list.'))');
	}
}
