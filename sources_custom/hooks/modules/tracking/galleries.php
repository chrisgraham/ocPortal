<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2008

 See text/en/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		galleries
 */

class Hook_tracking_galleries
{
	/**
	 * Standard function to create the tree of the galleries in the tracking screen
	 *
	 * @param  string		The ID of the gallery
	 * @param  boolean	Whether to preselect the specified gallery
	 * @return string 	HTML of the tree
	*/
	function create_tree($id,$select_root=false)
	{
		require_code('galleries');
		require_lang('galleries');
		require_css('galleries');

		$pagelinks=get_gallery_tree($id,'',NULL,true,'only_conventional_galleries',false,false,true,false,NULL,NULL,false,true);

		return make_tree('galleries',$pagelinks,$select_root);
	}

	/**
	 * Standard function to get the child count of the gallery
	 *
	 * @param string		The ID of the gallery
	 * @return integer 	The child count of the gallery
	 */
	function get_children($id)
	{
		require_code('galleries');
		require_lang('galleries');
		require_css('galleries');

		$child=1;
		$pagelinks=get_gallery_tree($id,'',NULL,true,'only_conventional_galleries',false,false,true,false,NULL,NULL,false,true);

		$child=0;
		if(count($pagelinks)>0)
		{
			for($i=0;$i<count($pagelinks);$i++)
			{
				if($pagelinks[$i]['id']==$id)
				{
					$child=$pagelinks[$i]['child_count'];
				}
			}
		}

		return $child;
	}

	/**
	 * Standard function to set tracking
	 *
	 * @param  string		The ID of the category
	 * @param  BINARY 	The child tracking flag of the gallery
	 * @param  string		Comma-separated list of nodes to track
	 * @param  BINARY		The flag for the email tracking option
	 * @param  BINARY		The flag for the sms tracking option
	 */
	function mark_tracking($id,$child_flag,$tracking_tree,$email,$sms)
	{
		require_code('galleries');
		require_lang('galleries');
		require_css('galleries');

		$member_id=get_member();
		$time=time();

		$pagelinks=get_gallery_tree($id,'',NULL,true,'only_conventional_galleries',false,false,false,false,NULL,NULL,false);

		for($i=0;$i<count($pagelinks);$i++)
		{
			$GLOBALS['SITE_DB']->query_delete('tracking_info',array('t_type'=>'galleries','t_category_id'=>$pagelinks[$i]['id'],'t_member_id'=>$member_id));
		}

		if(!empty($tracking_tree))
		{
			$nodes=explode(",",$tracking_tree);
			
			for($i=0;$i<count($nodes);$i++)
			{
				$GLOBALS['SITE_DB']->query_insert('tracking_info',array('t_type'=>'galleries','t_category_id'=>$nodes[$i],'t_member_id'=>$member_id,'t_tracked_at'=>$time,'t_use_email'=>$email,'t_use_sms'=>$sms));
			}
		}
	}

	/**
	 * Standard function to untrack the galleries
	 *
	 * @param string	The ID of the galleries
	 */
	function unmark_tracking($id)
	{
		require_code('galleries');
		require_lang('galleries');
		require_css('galleries');

		$member_id=get_member();

		$pagelinks=get_gallery_tree($id,'',NULL,true,'only_conventional_galleries',false,false,false,false,NULL,NULL,false);

		for($i=0;$i<count($pagelinks);$i++)
		{
			$GLOBALS['SITE_DB']->query_delete('tracking_info',array('t_type'=>'galleries','t_category_id'=>$pagelinks[$i]['id'],'t_member_id'=>$member_id));
		}
	}
}