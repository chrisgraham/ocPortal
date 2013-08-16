<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

class upon_query_user_export
{
	function run_pre($ob,$query,$max,$start,$fail_ok,$get_insert_id)
	{
		$prefix=preg_quote(get_table_prefix(),'#');

		$matches=array();
		if (
			(preg_match('#^DELETE FROM '.$prefix.'f_members .*WHERE id=(\d+)#',$query,$matches)!=0)
		)
		{
			require_code('user_export');
			do_user_export__single_ipc(intval($matches[1]),true);
			return;
		}
	}

	function run($ob,$query,$max,$start,$fail_ok,$get_insert_id,$ret)
	{
		if (!isset($GLOBALS['FORUM_DB'])) return;

		$prefix=preg_quote($GLOBALS['FORUM_DB']->get_table_prefix(),'#');

		$matches=array();
		if (
			(preg_match('#^UPDATE '.$prefix.'f_members .*WHERE \(?id=(\d+)\)?#',$query,$matches)!=0) || 
			(preg_match('#^UPDATE '.$prefix.'f_member_custom_fields .*WHERE \(?mf_member_id=(\d+)\)?#',$query,$matches)!=0)
		)
		{
			if (strpos($query,'m_email_address')!==false)
			{
				require_code('user_export');
				do_user_export__single_ipc(intval($matches[1]));
			}
			return;
		}

		$matches=array();
		if (
			(preg_match('#^INSERT INTO '.$prefix.'f_members #',$query,$matches)!=0)
		)
		{
			require_code('user_export');
			do_user_export__single_ipc($ret);
			return;
		}

		$matches=array();
		if (
			(preg_match('#^INSERT INTO '.$prefix.'f_member_custom_fields .*\((\d+),#U',$query,$matches)!=0)
		)
		{
			require_code('user_export');
			do_user_export__single_ipc(intval($matches[1]));
			return;
		}
	}
}
