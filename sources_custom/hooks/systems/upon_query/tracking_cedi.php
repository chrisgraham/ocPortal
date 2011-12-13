<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2010

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		cedi
 */

class upon_query_tracking_cedi
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

		// New/edited posts
		$type='cedi';
		$view_page_name='cedi';
		$view_type='misc';
		if (((preg_match('#^(UPDATE|INSERT INTO) '.$ob->get_table_prefix().'seedy_posts#',$query)!=0) && (strpos($query,'edit_date')!==false)) || ((preg_match('#^UPDATE '.$ob->get_table_prefix().'seedy_pages#',$query)!=0) && (strpos($query,'views')===false)))
		{
			require_code('cedi');
			list($cat,)=get_param_cedi_chain('id','');
			if ($cat=='') return;

			require_code('tracking');
			$user_list=tracking_users($type,$cat);

			if(is_array($user_list) && count($user_list)>0)
			{
				// Sending the Email and SMS alert to user
				$page_title=get_translated_text($ob->query_value('seedy_pages','title',array('id'=>$cat)),$ob);
				send_alert($type,$user_list,build_url(array('page'=>$view_page_name,'type'=>$view_type,'id'=>$cat),get_module_zone($view_page_name),NULL,false,false,true),$page_title,preg_replace('#\[attachment[^\[\]]*\][^\[\]]*\[/attachment\]#','',post_param('post','')));
			}
		}

		// New/edited children, so update tracking for people tracking the parents
		$table='seedy_children';
		$type='cedi';
		$matches=array();
		if (preg_match('#^INSERT INTO '.$ob->get_table_prefix().$table.' \(parent_id, child_id, the_order, title\) VALUES \((\d+), (\d+), #',$query,$matches)!=0)
		{
			$parent_cat=intval($matches[1]);
			$cat=intval($matches[2]);

			if ($ob->query_value_null_ok('seedy_pages','add_date',array('id'=>$cat))===time())
			{
				require_code('tracking');
				$user_list=tracking_users($type,$parent_cat);

				foreach ($user_list as $user)
				{
					$user2=$user;
					$user2['t_type']=$type;
					$user2['t_category_id']=$cat;
					$user2['t_tracked_at']=time();

					$GLOBALS['SITE_DB']->query_insert('tracking_info',$user2);
				}
			}
		}
	}
}
