<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2008

 See text/en/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		catalogues
 */

class Hook_tracking_catalogues
{
	/**
	 * Standard function to create the tree of the catalogue categories in the tracking screen
	 *
	 * @param  string		The ID of the catalogue category
	 * @param  boolean	Whether to preselect the specified catalogue category
	 * @return string 	HTML of the tree
	*/
	function create_tree($id,$select_root=false)
	{
		require_lang('catalogues');
		require_code('catalogues');
		require_code('catalogues2');

		$name=$GLOBALS['SITE_DB']->query_value_null_ok('catalogue_categories','c_name',array('id'=>intval($id)));

		$pagelinks=get_catalogue_entries_tree($name,NULL,NULL,NULL,NULL,NULL,false);
		return make_tree('catalogues',$pagelinks,$select_root);
	}

	/**
	 * Standard function to get the child count of the catalogue
	 *
	 * @param string		The ID of the catalogue category
	 * @return integer 	The child count of the catalogue
	 */
	function get_children($id)
	{
		require_lang('catalogues');
		require_code('catalogues');
		require_code('catalogues2');

		$child=1;

		// If the node is not a root node then get the name of the node
		$name=$GLOBALS['SITE_DB']->query_value_null_ok('catalogue_categories','c_name',array('id'=>intval($id)));

		$pagelinks=get_catalogue_entries_tree($name,NULL,NULL,NULL,NULL,NULL,false);

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
	 * @param  string		The ID of the catalogue category
	 * @param  BINARY 	The child tracking flag of the gallery
	 * @param  string		Comma-separated list of nodes to track
	 * @param  BINARY		The flag for the email tracking option
	 * @param  BINARY		The flag for the sms tracking option
	 */
	function mark_tracking($id,$child_flag,$tracking_tree,$email,$sms)
	{
		require_lang('catalogues');
		require_code('catalogues');
		require_code('catalogues2');

		$member_id=get_member();
		$time=time();

		$name=$GLOBALS['SITE_DB']->query_value_null_ok('catalogue_categories','c_name',array('id'=>intval($id)));

		$pagelinks=get_catalogue_entries_tree($name,NULL,NULL,NULL,NULL,NULL,false);

		$child=1;
		if(count($pagelinks)>0)
		{
			for($i=0;$i<count($pagelinks);$i++)
			{
				if($pagelinks[$i]['id']==intval($id))
				{
					$child=$pagelinks[$i]['child_count'];
				}
			}
		}

		// If the selected one is the root node

		for($i=0;$i<count($pagelinks);$i++)
		{
			$GLOBALS['SITE_DB']->query_delete('tracking_info',array('t_type'=>'catalogues','t_category_id'=>$pagelinks[$i]['id'],'t_member_id'=>$member_id));
		}

		if(!empty($tracking_tree))
		{
			$nodes=explode(",",$tracking_tree);
			
			for($i=0;$i<count($nodes);$i++)
			{
				$GLOBALS['SITE_DB']->query_insert('tracking_info',array('t_type'=>'catalogues','t_category_id'=>$nodes[$i],'t_member_id'=>$member_id,'t_tracked_at'=>$time,'t_use_email'=>$email,'t_use_sms'=>$sms));
			}
		}
	}

	/**
	 * Standard function to untrack the catalogue
	 *
	 * @param string	The ID of the catalogue category
	 */
	function unmark_tracking($id)
	{
		require_lang('catalogues');
		require_code('catalogues');
		require_code('catalogues2');

		$member_id=get_member();

		$name=$GLOBALS['SITE_DB']->query_value_null_ok('catalogue_categories','c_name',array('id'=>intval($id)));

		$pagelinks=get_catalogue_entries_tree($name,NULL,NULL,NULL,NULL,NULL,false);

		$child=1;
		if(count($pagelinks)>0)
		{
			for($i=0;$i<count($pagelinks);$i++)
			{
				if($pagelinks[$i]['id']==intval($id))
				{
					$child=$pagelinks[$i]['child_count'];
				}
			}
		}

		// If the selected one is the root node
		if($child==1)
		{
			$pagelinks[]=array('id'=>$id,'title'=>$name,'child_count'=>1);

			if(count($pagelinks)>0)
			{
				for($i=0;$i<count($pagelinks);$i++)
				{
					$GLOBALS['SITE_DB']->query_delete('tracking_info',array('t_type'=>'catalogues','t_category_id'=>$pagelinks[$i]['id'],'t_member_id'=>$member_id));
				}
			}
		}
		else	// If its a child node
		{
			$GLOBALS['SITE_DB']->query_delete('tracking_info',array('t_type'=>'catalogues','t_category_id'=>$id,'t_member_id'=>$member_id));
		}
	}
}