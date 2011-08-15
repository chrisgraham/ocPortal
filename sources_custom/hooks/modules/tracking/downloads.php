<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2008

 See text/en/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		downloads
 */

class Hook_tracking_downloads
{
	/**
	 * Standard function to create the tree of the download categories in the tracking screen
	 *
	 * @param  string		The ID of the download category
	 * @param  boolean	Whether to preselect the specified download category
	 * @return string 	HTML of the tree
	*/
	function create_tree($id,$select_root=false)
	{
		require_code('downloads');
		require_lang('downloads');
		require_css('downloads');

		$pagelinks=get_downloads_tree(NULL,$id,NULL,NULL,NULL,NULL,false);
		return make_tree('downloads',$pagelinks,$select_root);
	}

	/**
	 * Standard function to get the child count of the download category
	 *
	 * @param string		The ID of the download category
	 * @return integer 	The child count of the download category
	 */
	function get_children($id)
	{
		require_code('downloads');
		require_lang('downloads');
		require_css('downloads');

		$child=1;
		$pagelinks=get_downloads_tree(NULL,$id,NULL,NULL,NULL,NULL,false);

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
	 * @param  string		The ID of the download category
	 * @param  BINARY 	The child tracking flag of the gallery
	 * @param  string		Comma-separated list of nodes to track
	 * @param  BINARY		The flag for the email tracking option
	 * @param  BINARY		The flag for the sms tracking option
	 */
	function mark_tracking($id,$child_flag,$tracking_tree,$email,$sms)
	{
		require_code('downloads');
		require_lang('downloads');
		require_css('downloads');

		$member_id=get_member();
		$time=time();

		$pagelinks=get_downloads_tree(NULL,$id,NULL,NULL,NULL,NULL,false);

		for($i=0;$i<count($pagelinks);$i++)
		{
			$GLOBALS['SITE_DB']->query_delete('tracking_info',array('t_type'=>'downloads','t_category_id'=>$pagelinks[$i]['id'],'t_member_id'=>$member_id));
		}

		if(!empty($tracking_tree))
		{
			$nodes=explode(",",$tracking_tree);
			
			for($i=0;$i<count($nodes);$i++)
			{
				$GLOBALS['SITE_DB']->query_insert('tracking_info',array('t_type'=>'downloads','t_category_id'=>$nodes[$i],'t_member_id'=>$member_id,'t_tracked_at'=>$time,'t_use_email'=>$email,'t_use_sms'=>$sms));
			}
		}
	}

	/**
	 * Standard function to untrack the download
	 *
	 * @param string	The ID of the download category
	 */
	function unmark_tracking($id)
	{
		require_code('downloads');
		require_lang('downloads');
		require_css('downloads');

		$member_id=get_member();

		$pagelinks=get_downloads_tree(NULL,$id,NULL,NULL,NULL,NULL,false);

		if(count($pagelinks)>0)
		{
			for($i=0;$i<count($pagelinks);$i++)
			{
				$GLOBALS['SITE_DB']->query_delete('tracking_info',array('t_type'=>'downloads','t_category_id'=>$pagelinks[$i]['id'],'t_member_id'=>$member_id));
			}
		}
	}
}