<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2013

 See text/EN/licence.txt for full licencing information.


 NOTE TO PROGRAMMERS:
   Do not edit this file. If you need to make changes, save your changed file to the appropriate *_custom folder
   **** If you ignore this advice, then your website upgrades (e.g. for bug fixes) will likely kill your changes ****

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		galleries
 */

class Block_main_personal_galleries_list
{

	/**
	 * Standard modular info function.
	 *
	 * @return ?array	Map of module info (NULL: module is disabled).
	 */
	function info()
	{
		if (get_forum_type()!='ocf') return NULL;

		$info=array();
		$info['author']='Chris Graham';
		$info['organisation']='ocProducts';
		$info['hacked_by']=NULL;
		$info['hack_version']=NULL;
		$info['version']=2;
		$info['locked']=false;
		$info['parameters']=array('member_id','max','start');
		return $info;
	}

	/**
	 * Standard modular run function.
	 *
	 * @param  array		A map of parameters.
	 * @return tempcode	The result of execution.
	 */
	function run($map)
	{
		$block_id=get_block_id($map);

		$member_id=array_key_exists('member_id',$map)?intval($map['member_id']):get_member();
		$member_id_viewing=get_member();

		$max=get_param_integer($block_id.'_max',array_key_exists('max',$map)?intval($map['max']):12);
		$start=get_param_integer($block_id.'_start',array_key_exists('start',$map)?intval($map['start']):0);

		$text_id=do_lang_tempcode('GALLERIES');

		require_code('galleries');
		require_css('galleries');

		// Find galleries
		$galleries=new ocp_tempcode();
		$query=' FROM '.get_table_prefix().'galleries';
		$query.=' WHERE name LIKE \''.db_encode_like('member\_'.strval($member_id).'\_%').'\' OR g_owner='.strval($member_id);
		$rows=$GLOBALS['SITE_DB']->query('SELECT *'.$query,$max,$start,false,true);
		$max_rows=$GLOBALS['SITE_DB']->query_value_if_there('SELECT COUNT(*)'.$query,false,true);

		// Render galleries
		foreach ($rows as $i=>$row)
		{
			$galleries->attach(render_gallery_box($row,'root',false,get_module_zone('galleries'),false,false,false,false));
			$this->attach_gallery_subgalleries($row['name'],$galleries,$member_id,$member_id_viewing);
		}

		// Management links
		$add_gallery_url=new ocp_tempcode();
		$add_image_url=new ocp_tempcode();
		$add_video_url=new ocp_tempcode();
		if ($member_id==get_member())
		{
			if (count($rows)==0) // No gallery yet, so create via implication
			{
				$test=$GLOBALS['SITE_DB']->query_select('galleries',array('accept_images','accept_videos','name'),array('is_member_synched'=>1));
				if (array_key_exists(0,$test))
				{
					if ($test[0]['accept_images']==1)
					{
						$add_image_url=build_url(array('page'=>'cms_galleries','type'=>'ad','cat'=>'member_'.strval($member_id).'_'.$test[0]['name']),get_module_zone('cms_galleries'));
					}
					if ($test[0]['accept_videos']==1)
					{
						$add_video_url=build_url(array('page'=>'cms_galleries','type'=>'av','cat'=>'member_'.strval($member_id).'_'.$test[0]['name']),get_module_zone('cms_galleries'));
					}
				}
			} else // Or invite them to explicitly add a gallery (they can add images/videos from their existing gallery now)
			{
				if ((has_actual_page_access(NULL,'cms_galleries',NULL,NULL)) && (has_submit_permission('cat_mid',get_member(),get_ip_address(),'cms_galleries')))
				{
					$add_gallery_url=build_url(array('page'=>'cms_galleries','type'=>'ac','cat'=>$rows[0]['name']),get_module_zone('cms_galleries'));
				}
				if (count($rows)==1)
				{
					if ($rows[0]['accept_images']==1)
					{
						$add_image_url=build_url(array('page'=>'cms_galleries','type'=>'ad','cat'=>$rows[0]['name']),get_module_zone('cms_galleries'));
					}
					if ($rows[0]['accept_videos']==1)
					{
						$add_video_url=build_url(array('page'=>'cms_galleries','type'=>'av','cat'=>$rows[0]['name']),get_module_zone('cms_galleries'));
					}
				}
			}
		}

		require_code('templates_pagination');
		$pagination=pagination($text_id,$start,$block_id.'_start',$max,$block_id.'_max',$max_rows);

		return do_template('BLOCK_MAIN_PERSONAL_GALLERIES_LIST',array(
			'_GUID'=>'90b11d3c01ff551be42a0472d27dd207',
			'BLOCK_PARAMS'=>block_params_arr_to_str($map),
			'GALLERIES'=>$galleries,
			'PAGINATION'=>$pagination,
			'MEMBER_ID'=>strval($member_id),
			'ADD_GALLERY_URL'=>$add_gallery_url,
			'ADD_IMAGE_URL'=>$add_image_url,
			'ADD_VIDEO_URL'=>$add_video_url,

			'START'=>strval($start),
			'MAX'=>strval($max),
			'START_PARAM'=>$block_id.'_start',
			'MAX_PARAM'=>$block_id.'_max',
		));
	}

	/**
	 * Show subgalleries belonging to member.
	 *
	 * @param  ID_TEXT		Gallery name
	 * @param  tempcode		The output goes in here (passed by reference)
	 * @param  MEMBER			The ID of the member who is being viewed
	 * @param  MEMBER			The ID of the member who is doing the viewing
	 */
	function attach_gallery_subgalleries($gallery_name,&$galleries,$member_id,$member_id_viewing)
	{
		// Not done via main_multi_content block due to need to custom query
		$rows=$GLOBALS['SITE_DB']->query_select('galleries',array('*'),array('parent_id'=>$gallery_name),'ORDER BY add_date DESC');
		foreach ($rows as $i=>$row)
		{
			$galleries->attach(render_gallery_box($row,'root',false,get_module_zone('galleries'),true,false,false,false));
			$this->attach_gallery_subgalleries($row['name'],$galleries,$member_id,$member_id_viewing);
		}
	}

}

