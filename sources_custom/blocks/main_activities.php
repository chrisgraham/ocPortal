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
		$info['parameters']=array('max','param','member','mode','grow');
		return $info;
	}

	/**
	 * Standard modular uninstall function.
	 */
	function uninstall()
	{
		$GLOBALS['SITE_DB']->drop_if_exists('activities');

		delete_specific_permission('syndicate_site_activity');
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
			'a_member_id'=>'*USER',
			'a_also_involving'=>'?USER',
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

		add_specific_permission('SUBMISSION','syndicate_site_activity',false);
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

		if (!array_key_exists('max',$map))
		{
			$map['max']='10';
		}

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

		global $NON_CANONICAL_PARAMS;
		$NON_CANONICAL_PARAMS[]='act_start';

		$start=get_param_integer('act_start',0);
		$max=get_param_integer('act_max',intval($map['max']));

		if ($proceed_selection===true)
		{
			$max_rows=$GLOBALS['SITE_DB']->query_value_null_ok_full('SELECT COUNT(*) FROM '.get_table_prefix().'activities WHERE '.$whereville);

			require_code('templates_pagination');
			$pagination=pagination(do_lang('ACTIVITIES_TITLE'),NULL,$start,'act_start',$max,'act_max',$max_rows,NULL,NULL,true,false,7,NULL,'tab__activities');

			$activities=$GLOBALS['SITE_DB']->query('SELECT * FROM '.get_table_prefix().'activities WHERE '.$whereville.' ORDER BY a_time DESC',$max,$start);

			if (!is_null($activities) && (count($activities)>0))
			{
				foreach ($activities as $row)
				{
					list($message,$memberpic,$datetime,$member_url,$lang_string)=render_activity($row);
					$content[]=array('LANG_STRING'=>$lang_string,'ADDON_ICON'=>find_addon_icon($row['a_addon']),'BITS'=>$message,'MEMPIC'=>$memberpic,'USERNAME'=>$GLOBALS['FORUM_DRIVER']->get_username($row['a_member_id']),'DATETIME'=>strval($datetime),'MEMBER_URL'=>$member_url,'LIID'=>strval($row['id']),'ALLOW_REMOVE'=>(($row['a_member_id']==$viewer_id) || $can_remove_others)?'1':'0');
				}
			}
		} else
		{
			$pagination=new ocp_tempcode();
		}

		// No entries
		return do_template('BLOCK_MAIN_ACTIVITIES',array(
			'TITLE'=>$title,
			'MODE'=>$mode,
			'MEMBER_IDS'=>implode(',',$member_ids),
			'CONTENT'=>$content,
			'GROW'=>(array_key_exists('grow',$map)? $map['grow']=='1' : true),
			'PAGINATION'=>$pagination,
			'MAX'=>($start==0)?strval($max):NULL,
		));
	}

}


