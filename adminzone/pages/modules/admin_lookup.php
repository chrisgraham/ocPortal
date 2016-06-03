<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.


 NOTE TO PROGRAMMERS:
   Do not edit this file. If you need to make changes, save your changed file to the appropriate *_custom folder
   **** If you ignore this advice, then your website upgrades (e.g. for bug fixes) will likely kill your changes ****

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		core
 */

/**
 * Module page class.
 */
class Module_admin_lookup
{

	/**
	 * Standard modular info function.
	 *
	 * @return ?array	Map of module info (NULL: module is disabled).
	 */
	function info()
	{
		$info=array();
		$info['author']='Chris Graham';
		$info['organisation']='ocProducts';
		$info['hacked_by']=NULL;
		$info['hack_version']=NULL;
		$info['version']=2;
		$info['locked']=false;
		return $info;
	}

	/**
	 * Standard modular entry-point finder function.
	 *
	 * @return ?array	A map of entry points (type-code=>language-code) (NULL: disabled).
	 */
	function get_entry_points()
	{
		return array('!'=>'INVESTIGATE_USER');
	}

	/**
	 * Standard modular run function.
	 *
	 * @return tempcode	The result of execution.
	 */
	function run()
	{
		$GLOBALS['HELPER_PANEL_PIC']='pagepics/investigateuser';
		$GLOBALS['HELPER_PANEL_TUTORIAL']='tut_trace';

		require_lang('submitban');
		require_lang('security');
		require_code('lookup');

		if (addon_installed('securitylogging'))
		{
			$ip_ban_url=build_url(array('page'=>'admin_ipban'),get_module_zone('admin_ipban'));
			$GLOBALS['HELPER_PANEL_TEXT']=comcode_to_tempcode(do_lang('DOC_ACTIONLOG_BAN_HELP',$ip_ban_url->evaluate()));
		}

		$param=get_param('param',get_param('id',''));

		if ($param=='')
		{
			breadcrumb_set_parents(array(array('_SEARCH:admin_ocf_join:menu',do_lang_tempcode('MEMBERS'))));

			$title=get_page_title('INVESTIGATE_USER');

			require_code('form_templates');
			$submit_name=do_lang_tempcode('INVESTIGATE_USER');
			$post_url=build_url(array('page'=>'_SELF'),'_SELF',NULL,false,true);
			$fields=form_input_line(do_lang_tempcode('DETAILS'),do_lang_tempcode('DESCRIPTION_INVESTIGATE'),'param','',false);

			breadcrumb_set_self(do_lang_tempcode('SEARCH'));

			return do_template('FORM_SCREEN',array('_GUID'=>'9cc407037ec01a8f3483746a22889471','GET'=>true,'SKIP_VALIDATION'=>true,'HIDDEN'=>'','TITLE'=>$title,'TEXT'=>'','SUBMIT_NAME'=>$submit_name,'FIELDS'=>$fields,'URL'=>$post_url));

		} else
		{
			if (is_numeric($param))
			{
				$title=get_page_title('INVESTIGATE_USER_BY_MEMBER_ID');
			}
			elseif (strpos($param,'.')!==false)
			{
				$title=get_page_title('INVESTIGATE_USER_BY_IP');
			} else
			{
				$title=get_page_title('INVESTIGATE_USER_BY_USERNAME');
			}

			$test=explode(' ',get_param('sort','date_and_time DESC'),2);
			if (count($test)==1) $test[1]='DESC';
			list($sortable,$sort_order)=$test;
			$name=mixed();
			$id=mixed();
			$ip=mixed();
			$rows=lookup_member_page($param,$name,$id,$ip);
			if (is_null($name))
			{
				$name=do_lang('UNKNOWN');
			}
			if (is_null($id)) $id=$GLOBALS['FORUM_DRIVER']->get_guest_id();
			if (is_null($ip)) $ip='';

			if (addon_installed('securitylogging'))
				$all_banned=collapse_1d_complexity('ip',$GLOBALS['SITE_DB']->query_select('usersubmitban_ip',array('ip')));
			else
				$all_banned=array();

			$ip_list=new ocp_tempcode();
			$groups=array();
			foreach ($rows as $row)
			{
				if (strpos($row['ip'],':')!==false)
				{
					$bits=explode(':',$row['ip']);
					$bits[count($bits)-1]='*';
					$ip_masked=implode(':',$bits);
				} else
				{
					$bits=explode('.',$row['ip']);
					$bits[count($bits)-1]='*';
					$ip_masked=implode('.',$bits);
				}
				if (!array_key_exists($ip_masked,$groups)) $groups[$ip_masked]=array();
				$groups[$ip_masked][]=$row;
			}
			$all_ips=array();
			foreach ($groups as $mask=>$group)
			{
				foreach ($group as $row)
				{
					$all_ips[]=$row['ip'];
				}
				$all_ips[]=$mask;
			}
			if (strtolower(ocp_srv('REQUEST_METHOD'))=='post')
			{
				if (!array_key_exists('banned',$_POST)) $_POST['banned']=array();

				require_code('failure');
				$all_banned_filtered=array();
				foreach ($all_ips as $bip)
				{
					if (addon_installed('securitylogging'))
					{
						if (in_array($bip,$_POST['banned']))
						{
							add_ip_ban($bip);
							$all_banned_filtered[]=$bip;
						} else
						{
							remove_ip_ban($bip);
						}
					}
				}
				$all_banned=$all_banned_filtered;
			}
			foreach ($groups as $mask=>$group)
			{
				$inner_ip_list=new ocp_tempcode();
				$one_sub_is_banned=false;
				foreach ($group as $row)
				{
					$date=get_timezoned_date($row['date_and_time']);
					$lookup_url=build_url(array('page'=>'_SELF','param'=>$row['ip']),'_SELF');
					$inner_ip_list->attach(do_template('LOOKUP_IP_LIST_ENTRY',array('_GUID'=>'94a133f5f711bbf09100346661e3f7c9','UNIQID'=>uniqid('',true),'LOOKUP_URL'=>$lookup_url,'DATE'=>$date,'_DATE'=>strval($row['date_and_time']),'IP'=>$row['ip'],'BANNED'=>in_array($row['ip'],$all_banned))));
					if (in_array($row['ip'],$all_banned)) $one_sub_is_banned=true;
				}
				$ip_list->attach(do_template('LOOKUP_IP_LIST_GROUP',array('OPEN_DEFAULT'=>$one_sub_is_banned,'UNIQID'=>uniqid('',true),'BANNED'=>in_array($mask,$all_banned),'MASK'=>$mask,'GROUP'=>$inner_ip_list)));
			}

			$stats=get_stats_track($id,$ip,get_param_integer('start',0),get_param_integer('max',10),$sortable,$sort_order);

			$points_url=addon_installed('points')?build_url(array('page'=>'points','type'=>'member','id'=>$id),get_module_zone('points')):NULL;
			if (addon_installed('authors'))
			{
				$author_url=($name==do_lang('UNKNOWN'))?NULL:build_url(array('page'=>'authors','author'=>$name),get_module_zone('authors'));
			} else
			{
				$author_url=NULL;
			}
			if (addon_installed('search'))
			{
				$search_url=($name==do_lang('UNKNOWN'))?NULL:build_url(array('page'=>'search','type'=>'results','content'=>'','author'=>$name,'days'=>'-1','sort'=>'add_date','direction'=>'DESC'),get_module_zone('search'));
			} else $search_url=NULL;
			$profile_url=(is_guest($id))?NULL:$GLOBALS['FORUM_DRIVER']->member_profile_url($id,false,true);
			if (addon_installed('actionlog'))
			{
				$action_log_url=(is_guest($id))?NULL:build_url(array('page'=>'admin_actionlog','type'=>'list','id'=>$id),get_module_zone('admin_actionlog'));
			} else $action_log_url=NULL;

			$alerts=($ip=='')?new ocp_tempcode():find_security_alerts(array('ip'=>$ip));

			$member_banned=$GLOBALS['FORUM_DRIVER']->is_banned($id);
			$ip_banned=($ip!='') && (addon_installed('securitylogging')) && (!is_null($GLOBALS['SITE_DB']->query_value_null_ok('usersubmitban_ip','ip',array('ip'=>$ip))));
			$banned_test_2=$GLOBALS['SITE_DB']->query_value_null_ok('usersubmitban_member','the_member',array('the_member'=>$id));
			$submitter_banned=!is_null($banned_test_2);

			$member_ban_link=NULL;
			$ip_ban_link=NULL;
			$submitter_ban_link=NULL;
			if (addon_installed('securitylogging'))
			{
				if (((get_forum_type()=='ocf') && (!is_guest($id))) && ($id!=get_member()))
				{
					$member_ban_link=do_template('ACTION_LOGS_TOGGLE_LINK',array('URL'=>build_url(array('page'=>'admin_actionlog','type'=>'toggle_member_ban','id'=>$id,'redirect'=>get_self_url(true)),get_module_zone('admin_actionlog'))));
				}
				if (($ip!='') && ($ip!=get_ip_address()))
				{
					$ip_ban_link=do_template('ACTION_LOGS_TOGGLE_LINK',array('URL'=>build_url(array('page'=>'admin_actionlog','type'=>'toggle_ip_ban','id'=>$ip),get_module_zone('admin_actionlog'))));
				}
				if ((!is_guest($id)) && ($id!=get_member()))
				{
					$submitter_ban_link=do_template('ACTION_LOGS_TOGGLE_LINK',array('URL'=>build_url(array('page'=>'admin_actionlog','type'=>'toggle_submitter_ban','id'=>$id,'redirect'=>get_self_url(true)),get_module_zone('admin_actionlog'))));
				}
			}

			breadcrumb_set_parents(array(array('_SEARCH:admin_ocf_join:menu',do_lang_tempcode('MEMBERS')),array('_SELF:_SELF:misc',do_lang_tempcode('SEARCH'))));
			breadcrumb_set_self(do_lang_tempcode('RESULT'));

			return do_template('LOOKUP_SCREEN',array('_GUID'=>'dc6effaa043949940b809f6aa5a1f944','TITLE'=>$title,'ALERTS'=>$alerts,'STATS'=>$stats,'IP_LIST'=>$ip_list,'IP_BANNED'=>$ip_banned?do_lang_tempcode('YES'):do_lang_tempcode('NO'),'SUBMITTER_BANNED'=>$submitter_banned?do_lang_tempcode('YES'):do_lang_tempcode('NO'),'MEMBER_BANNED'=>$member_banned?do_lang_tempcode('YES'):do_lang_tempcode('NO'),'MEMBER_BAN_LINK'=>$member_ban_link,'SUBMITTER_BAN_LINK'=>$submitter_ban_link,'IP_BAN_LINK'=>$ip_ban_link,'ID'=>strval($id),'IP'=>$ip,'NAME'=>$name,'SEARCH_URL'=>$search_url,'AUTHOR_URL'=>$author_url,'POINTS_URL'=>$points_url,'PROFILE_URL'=>$profile_url,'ACTION_LOG_URL'=>$action_log_url));
		}
	}

}


