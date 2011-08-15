<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2011

 See text/EN/licence.txt for full licencing information.

*/

class upon_query_banner_points
{
	function run($ob,$query,$max,$start,$fail_ok,$get_insert_id,$ret)
	{
		if (strpos($query,'INTO '.get_table_prefix().'banner_clicks')!==false)
		{
			load_user_stuff();
			if (method_exists($GLOBALS['FORUM_DRIVER'],'forum_layer_initialise')) $GLOBALS['FORUM_DRIVER']->forum_layer_initialise();
			global $FORCE_INVISIBLE_GUEST,$MEMBER_CACHED;
			$FORCE_INVISIBLE_GUEST=false;
			$MEMBER_CACHED=NULL;

			if (!is_guest())
			{
				require_code('comcode');
				require_code('permissions');
				
				$member_id=get_member();
				
				$dest=get_param('dest','');

				$cnt=$GLOBALS['SITE_DB']->query_value('banner_clicks','COUNT(*)',array(
					'c_member_id'=>$member_id,
					'c_banner_id'=>$dest,
				));
				if ($cnt==0)
				{
					require_code('points');
					require_code('points2');
					system_gift_transfer('Clicking a banner',1,$member_id);
				}
			}
		}
	}
}
