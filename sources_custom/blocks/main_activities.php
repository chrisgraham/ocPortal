<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		activity_feed
 */

class Block_main_activities
{

	/**
	 * Standard modular info function.
	 *
	 * @return ?array	Map of module info (NULL: module is disabled).
	 */
	function info()
	{
		$info=array();
		$info['author']='Chris Warburton';
		$info['organisation']='ocProducts';
		$info['hacked_by']=NULL;
		$info['hack_version']=NULL;
		$info['version']=1;
		$info['update_require_upgrade']=1;
		$info['locked']=false;
		$info['parameters']=array('max','start','param','member','mode','grow');
		return $info;
	}

	/**
	 * Standard modular uninstall function.
	 */
	function uninstall()
	{
		$GLOBALS['SITE_DB']->drop_table_if_exists('activities');
	}

	/**
	 * Standard modular install function.
	 *
	 * @param  ?integer	What version we're upgrading from (NULL: new install)
	 * @param  ?integer	What hack version we're upgrading from (NULL: new-install/not-upgrading-from-a-hacked-version)
	 */
	function install($upgrade_from=NULL,$upgrade_from_hack=NULL)
	{
		$GLOBALS['SITE_DB']->create_table('activities',array(
			'id'=>'*AUTO',
			'a_member_id'=>'*MEMBER',
			'a_also_involving'=>'?MEMBER',
			'a_language_string_code'=>'*ID_TEXT',
			'a_label_1'=>'SHORT_TEXT',
			'a_label_2'=>'SHORT_TEXT',
			'a_label_3'=>'SHORT_TEXT',
			'a_pagelink_1'=>'SHORT_TEXT',
			'a_pagelink_2'=>'SHORT_TEXT',
			'a_pagelink_3'=>'SHORT_TEXT',
			'a_time'=>'TIME',
			'a_addon'=>'ID_TEXT',
			'a_is_public'=>'BINARY'
		));

		$GLOBALS['SITE_DB']->create_index('activities','a_member_id',array('a_member_id'));
		$GLOBALS['SITE_DB']->create_index('activities','a_time',array('a_time'));
		$GLOBALS['SITE_DB']->create_index('activities','a_filtered_ordered',array('a_member_id','a_time'));

		require_code('activities_submission');
		log_newest_activity(0,1000,true);

		add_privilege('SUBMISSION','syndicate_site_activity',false);
	}

	// CACHE MESSES WITH POST REMOVAL
	/**
	 * Standard modular cache function.
	 *
	 * @return ?array	Map of cache details (cache_on and ttl) (NULL: module is disabled).
	 */
	/*function cacheing_environment()
	{
		$info=array();
		$info['cache_on']='array(array_key_exists(\'param\',$map)?$map[\'param\']:do_lang(\'ACTIVITIES_TITLE\'),array_key_exists(\'mode\',$map)?$map[\'mode\']:\'all\',get_member())';
		$info['ttl']=3;
		return $info;
	}*/

	/**
	 * Standard modular run function.
	 *
	 * @param  array		A map of parameters.
	 * @return tempcode	The result of execution.
	 */
	function run($map)
	{
		require_lang('activities');
		require_css('activities');
		require_javascript('javascript_activities');
		require_javascript('javascript_jquery');
		require_javascript('javascript_base64');

		if (array_key_exists('param',$map))
			$title=$map['param'];
		else
			$title=do_lang_tempcode('ACTIVITIES_TITLE');

		// See if we're displaying for a specific member
		if (array_key_exists('member',$map))
		{
			$member_ids=array_map('intval',explode(',',$map['member']));
		}
		else
		{
			// No specific user. Use ourselves.
			$member_ids=array(get_member());
		}

		require_lang('activities');
		require_code('activities');
		require_code('addons_overview');

		$mode=(array_key_exists('mode',$map))?$map['mode']:'all';

		$viewer_id=get_member(); //We'll need this later anyway.

		$guest_id=$GLOBALS['FORUM_DRIVER']->get_guest_id();

		list($proceed_selection,$whereville)=find_activities($viewer_id,$mode,$member_ids);

		$can_remove_others=(has_zone_access($viewer_id,'adminzone'))?true:false;

		$content=array();

		$block_id=get_block_id($map);

		$max=get_param_integer($block_id.'_max',array_key_exists('max',$map)?intval($map['max']):10);
		$start=get_param_integer($block_id.'_start',array_key_exists('start',$map)?intval($map['start']):0);

		if ($proceed_selection===true)
		{
			$max_rows=$GLOBALS['SITE_DB']->query_value_if_there('SELECT COUNT(*) FROM '.get_table_prefix().'activities WHERE '.$whereville);

			require_code('templates_pagination');
			$pagination=pagination(do_lang('ACTIVITIES_TITLE'),$start,$block_id.'_start',$max,$block_id.'_max',$max_rows,false,5,NULL,'tab__activities');

			$activities=$GLOBALS['SITE_DB']->query('SELECT * FROM '.get_table_prefix().'activities WHERE '.$whereville.' ORDER BY a_time DESC',$max,$start);

			foreach ($activities as $row)
			{
				list($message,$member_avatar,$datetime,$member_url,$lang_string,$is_public)=render_activity($row);
				$content[]=array(
					'IS_PUBLIC'=>$is_public,
					'LANG_STRING'=>$lang_string,
					'ADDON'=>$row['a_addon'],
					'ADDON_ICON'=>find_addon_icon($row['a_addon']),
					'MESSAGE'=>$message,
					'AVATAR'=>$member_avatar,
					'MEMBER_ID'=>strval($row['a_member_id']),
					'USERNAME'=>$GLOBALS['FORUM_DRIVER']->get_username($row['a_member_id']),
					'MEMBER_URL'=>$member_url,
					'DATETIME'=>strval($datetime),
					'LIID'=>strval($row['id']),
					'ALLOW_REMOVE'=>(($row['a_member_id']==$viewer_id) || $can_remove_others),
				);
			}
		} else
		{
			$pagination=new ocp_tempcode();
		}

		// No entries
		return do_template('BLOCK_MAIN_ACTIVITIES',array(
			'_GUID'=>'b4de219116e1b8107553ee588717e2c9',
			'BLOCK_PARAMS'=>block_params_arr_to_str($map),
			'TITLE'=>$title,
			'MODE'=>$mode,
			'MEMBER_IDS'=>implode(',',$member_ids),
			'CONTENT'=>$content,
			'GROW'=>(array_key_exists('grow',$map)? $map['grow']=='1' : true),
			'PAGINATION'=>$pagination,

			'START'=>strval($start),
			'MAX'=>strval($max),
			'START_PARAM'=>$block_id.'_start',
			'MAX_PARAM'=>$block_id.'_max',
		));
	}

}


