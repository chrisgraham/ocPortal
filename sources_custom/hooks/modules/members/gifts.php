<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 */

class Hook_members_gifts
{

	/**
	 * Standard modular run function.
	 *
	 * @param  MEMBER		The ID of the member we are getting link hooks for
	 * @return array		List of tuples for results. Each tuple is: type,title,url
	 */
	function run($member_id)
	{
		require_lang('ocgifts');

		if (is_guest()) return array();
		if (!has_actual_page_access(get_member(),'pointstore',get_module_zone('pointstore'))) return array();
		if ($member_id==get_member()) return array();

		return array(array('contact',do_lang_tempcode('GIFT_GIFT'),build_url(array('page'=>'pointstore','type'=>'action','id'=>'ocgifts','username'=>$GLOBALS['FORUM_DRIVER']->get_username($member_id)),get_module_zone('pointstore'))));
	}

	/**
	 * Standard modular run function.
	 *
	 * @param  MEMBER		The ID of the member we are getting link hooks for
	 * @return array		List of tuples for results. Each tuple is: type,title,url
	 */
	function get_sections($member_id)
	{
		require_lang('ocgifts');
		$rows=$GLOBALS['SITE_DB']->query_select('members_gifts',array('*'),array('to_user_id'=>$member_id),'',NULL,0,true);
		if (is_null($rows)) return array();
		
		$gifts=array();
		
		foreach($rows as $gift)
		{
			$gift_info=$GLOBALS['SITE_DB']->query_select('ocgifts',array('*'),array('id'=>$gift['gift_id']));
			if (strlen($gift_info[0]['name'])>0)
			{
				$gift_url='';
				
				if ($gift['is_anonymous']==0)
				{
					$sender_name=$GLOBALS['FORUM_DRIVER']->get_username($gift['from_user_id']);
					$sender_link=$GLOBALS['FORUM_DRIVER']->member_profile_url($gift['from_user_id']);
					$gift_explanation=do_lang('GIFT_EXPLANATION1',$sender_name,$gift_info[0]['name'],$sender_link);
				} else
				{
					$gift_explanation=do_lang('GIFT_EXPLANATION2',$gift_info[0]['name']);
				}

				$image_url='';
				if (is_file(get_file_base().'/'.$gift_info[0]['image']))
				{
					$image_url=get_base_url().'/'.$gift_info[0]['image'];
				}

				$gifts[]=array(
					'GIFT_URL'=>$gift_url,
					'GIFT_EXPLANATION'=>$gift_explanation,
					'IMAGE_URL'=>$image_url,
				);
			}
		}

		$gifts_block=do_template('OCF_MEMBER_SCREEN_GIFTS_WRAP',array('GIFTS'=>$gifts));
		return array($gifts_block);
	}
}
