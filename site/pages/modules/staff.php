<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2014

 See text/EN/licence.txt for full licencing information.


 NOTE TO PROGRAMMERS:
   Do not edit this file. If you need to make changes, save your changed file to the appropriate *_custom folder
   **** If you ignore this advice, then your website upgrades (e.g. for bug fixes) will likely kill your changes ****

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		staff
 */

/**
 * Module page class.
 */
class Module_staff
{
	/**
	 * Find details of the module.
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
	 * Find entry-points available within this module.
	 *
	 * @param  boolean	Whether to check permissions.
	 * @param  ?MEMBER	The member to check permissions as (NULL: current user).
	 * @param  boolean	Whether to allow cross links to other modules (identifiable via a full-page-link rather than a screen-name).
	 * @param  boolean	Whether to avoid any entry-point (or even return NULL to disable the page in the Sitemap) if we know another module, or page_group, is going to link to that entry-point. Note that "!" and "misc" entry points are automatically merged with container page nodes (likely called by page-groupings) as appropriate.
	 * @return ?array		A map of entry points (screen-name=>language-code/string or screen-name=>[language-code/string, icon-theme-image]) (NULL: disabled).
	 */
	function get_entry_points($check_perms=true,$member_id=NULL,$support_crosslinks=true,$be_deferential=false)
	{
		return array(
			'misc'=>array('STAFF','menu/site_meta/staff'),
		);
	}

	/**
	 * Uninstall the module.
	 */
	function uninstall()
	{
		$GLOBALS['FORUM_DRIVER']->install_delete_custom_field('sites');
		$GLOBALS['FORUM_DRIVER']->install_delete_custom_field('role');
		$GLOBALS['FORUM_DRIVER']->install_delete_custom_field('fullname');
	}

	/**
	 * Install the module.
	 *
	 * @param  ?integer	What version we're upgrading from (NULL: new install)
	 * @param  ?integer	What hack version we're upgrading from (NULL: new-install/not-upgrading-from-a-hacked-version)
	 */
	function install($upgrade_from=NULL,$upgrade_from_hack=NULL)
	{
		$GLOBALS['FORUM_DRIVER']->install_create_custom_field('sites',100,1,0,0,0,'','short_text');
		$GLOBALS['FORUM_DRIVER']->install_create_custom_field('role',100,1,0,1,0,'','short_text');
		$GLOBALS['FORUM_DRIVER']->install_create_custom_field('fullname',100,1,0,1,0,'','short_text');
	}

	var $title;

	/**
	 * Module pre-run function. Allows us to know meta-data for <head> before we start streaming output.
	 *
	 * @return ?tempcode		Tempcode indicating some kind of exceptional output (NULL: none).
	 */
	function pre_run()
	{
		$type=get_param('type','misc');

		require_lang('staff');

		if ($type=='misc')
		{
			$this->title=get_screen_title('STAFF_TITLE',true,array(escape_html(get_site_name())));
		}

		if ($type=='view')
		{
			breadcrumb_set_parents(array(array('_SELF:_SELF:misc',do_lang_tempcode('STAFF_TITLE',escape_html(get_site_name())))));

			$username=get_param('id');
			$this->title=get_screen_title('_STAFF',true,array(escape_html($username)));
		}

		return NULL;
	}

	/**
	 * Execute the module.
	 *
	 * @return tempcode	The result of execution.
	 */
	function run()
	{
		$type=get_param('type','misc');

		if ($type=='misc') return $this->do_all_staff();
		if ($type=='view') return $this->do_staff_member();

		return new ocp_tempcode();
	}

	/**
	 * The UI to view a staff list.
	 *
	 * @return tempcode		The UI
	 */
	function do_all_staff()
	{
		$admin_groups=array_merge($GLOBALS['FORUM_DRIVER']->get_super_admin_groups(),$GLOBALS['FORUM_DRIVER']->get_moderator_groups());
		$rows=$GLOBALS['FORUM_DRIVER']->member_group_query($admin_groups,400);
		if (count($rows)>=400)
			warn_exit(do_lang_tempcode('TOO_MANY_TO_CHOOSE_FROM'));

		$pre=do_lang_tempcode('PRE_STAFF');

		foreach ($rows as $i=>$row_staff)
		{
			$username=$GLOBALS['FORUM_DRIVER']->mrow_username($row_staff);
			$rows[$i]['username']=$username;
		}

		sort_maps_by($rows,'username');

		$content=new ocp_tempcode();
		foreach ($rows as $row_staff)
		{
			$id=$GLOBALS['FORUM_DRIVER']->mrow_id($row_staff);

			if (!$GLOBALS['FORUM_DRIVER']->is_staff($id)) continue;

			$username=$row_staff['username'];
			$url=build_url(array('page'=>'_SELF','id'=>$username,'type'=>'view'),'_SELF');
			$role=get_ocp_cpf('role',$id);
			if (is_null($role))
			{
				$description=''; // Null should not happen, but sometimes things corrupt
			} else
			{
				require_code('comcode_compiler');
				$description=apply_emoticons($role);
			}

			$content->attach(do_template('INDEX_SCREEN_FANCIER_ENTRY',array('_GUID'=>'2650660652a01ce39e6085615436f370','TITLE'=>do_lang_tempcode('STAFF'),'URL'=>$url,'NAME'=>$username,'DESCRIPTION'=>$description)));
		}

		$message=get_option('staff_text');
		if (has_actual_page_access(get_member(),'admin_config'))
		{
			if ($message!='') $message.=' [semihtml]<span class="associated_link"><a href="{$PAGE_LINK*,_SEARCH:admin_config:category:SECURITY#group_STAFF}">'.do_lang('EDIT').'</a></span>[/semihtml]'; // XHTMLXHTML: This (and similar things in other modules) should be done through a template really
		}
		$post=comcode_to_tempcode($message,NULL,true);

		return do_template('INDEX_SCREEN_FANCIER_SCREEN',array('_GUID'=>'3fb63955b3e1cb1cb4fda2e56b428d08','CONTENT'=>$content,'TITLE'=>$this->title,'POST'=>$post,'PRE'=>$pre));
	}

	/**
	 * The UI to view a staff member.
	 *
	 * @return tempcode		The UI
	 */
	function do_staff_member()
	{
		$username=get_param('id');

		require_code('obfuscate');

		$row_staff=$GLOBALS['FORUM_DRIVER']->get_mrow($username);
		if (is_null($row_staff)) warn_exit(do_lang_tempcode('MISSING_RESOURCE'));
		$id=$GLOBALS['FORUM_DRIVER']->mrow_id($row_staff);

		$_real_name=get_ocp_cpf('fullname',$id);
		if ($_real_name=='')
		{
			$real_name=do_lang_tempcode('_UNKNOWN'); // Null should not happen, but sometimes things corrupt
		} else
		{
			$real_name=protect_from_escaping(escape_html($_real_name));
		}
		$_role=get_ocp_cpf('role',$id);
		if ($_role=='')
		{
			$role=do_lang_tempcode('_UNKNOWN'); // Null should not happen, but sometimes things corrupt
		} else
		{
			require_code('comcode_compiler');
			$role=make_string_tempcode(apply_emoticons($_role));
		}
		$email_address=obfuscate_email_address($GLOBALS['FORUM_DRIVER']->mrow_email($row_staff));
		$username=$GLOBALS['FORUM_DRIVER']->mrow_username($row_staff);
		$profile_url=$GLOBALS['FORUM_DRIVER']->member_profile_url($id,false,true);

		$all_link=build_url(array('page'=>'_SELF','type'=>'misc'),'_SELF');

		return do_template('STAFF_SCREEN',array('_GUID'=>'fd149466f16722fcbcef0fba5685a895','TITLE'=>$this->title,'REAL_NAME'=>$real_name,'ROLE'=>$role,'ADDRESS'=>$email_address,'USERNAME'=>$username,'MEMBER_ID'=>strval($id),'PROFILE_URL'=>$profile_url,'ALL_STAFF_URL'=>$all_link));
	}
}


