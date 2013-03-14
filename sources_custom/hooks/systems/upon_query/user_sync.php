<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

class upon_query_user_sync
{
	function run($ob,$query,$max,$start,$fail_ok,$get_insert_id,$ret)
	{
		if ((strpos($query,'INTO '.get_table_prefix().'f_members')!==false)||(strpos($query,'INTO '.get_table_prefix().'f_member_custom_fields')!==false))
		{
			if (get_value('user_sync_enabled')==='1')
			{
				require_code('user_sync');
				sync_member(get_member());
			}
		}
	}
}
