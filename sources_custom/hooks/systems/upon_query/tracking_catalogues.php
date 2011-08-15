<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2010

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		catalogues
 */

class upon_query_tracking_catalogues
{
	/**
	 * Standard query hook
	 *
	 * @param  object		The query object
	 * @param  string		The query
	 * @param  integer	Maximum returned results
	 * @param  integer	Start position of results
	 * @param  boolean	Whether the query was allowed to fail
	 * @param  boolean	Whether the auto-insert ID will be retrieved
	 * @param  ?mixed		Results / Auto-insert ID (NULL: was an edit)
	*/
	function run($ob,$query,$max,$start,$fail_ok,$id,$ret)
	{
		if (running_script('stress_test_loader')) return;
		if (get_page_name()=='admin_import') return;
		
		$table='catalogue_entries';
		$type='catalogues';
		$view_page_name='catalogues';
		$view_type='entry';
		if (preg_match('#^(UPDATE|INSERT INTO) '.$ob->get_table_prefix().$table.'#',$query)!=0)
		{
			$cat=post_param('category_id','');
			if ($cat=='') return;

			require_code('tracking');
			$user_list=tracking_users($type,$cat);

			if(is_array($user_list) && count($user_list)>0)
			{
				if (!is_integer($id))
				{
					$matches=array();
					if (preg_match('# WHERE \(?id=(\d+)#',$query,$matches)!=0)
					{
						$id=intval($matches[1]);
					} else return;
				}
				
				// Sending the Email and SMS alert to user
				send_alert($type,$user_list,build_url(array('page'=>$view_page_name,'type'=>$view_type,'id'=>$id),get_module_zone($view_page_name),NULL,false,false,true));
			}
		}
	}
}
