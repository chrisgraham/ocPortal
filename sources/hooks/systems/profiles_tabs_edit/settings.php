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
 * @package		core_ocf
 */

class Hook_Profiles_Tabs_Edit_settings
{

	/**
	 * Find whether this hook is active.
	 *
	 * @param  MEMBER			The ID of the member who is being viewed
	 * @param  MEMBER			The ID of the member who is doing the viewing
	 * @return boolean		Whether this hook is active
	 */
	function is_active($member_id_of,$member_id_viewing)
	{
		return (($member_id_of==$member_id_viewing) || (has_specific_permission($member_id_viewing,'assume_any_member')) || (has_specific_permission($member_id_viewing,'member_maintenance')));
	}

	/**
	 * Standard modular render function for profile tabs edit hooks.
	 *
	 * @param  MEMBER			The ID of the member who is being viewed
	 * @param  MEMBER			The ID of the member who is doing the viewing
	 * @param  boolean		Whether to leave the tab contents NULL, if tis hook supports it, so that AJAX can load it later
	 * @return ?array			A tuple: The tab title, the tab body text (may be blank), the tab fields, extra Javascript (may be blank) the suggested tab order, hidden fields (optional) (NULL: if $leave_to_ajax_if_possible was set)
	 */
	function render_tab($member_id_of,$member_id_viewing,$leave_to_ajax_if_possible=false)
	{
		$order=0;

		// Actualiser
		if (post_param('submitting_settings_tab',NULL)!==NULL)
		{
			require_code('ocf_members_action2');

			$is_ldap=ocf_is_ldap_member($member_id_of);
			$is_httpauth=ocf_is_httpauth_member($member_id_of);
			$is_remote=($GLOBALS['FORUM_DRIVER']->get_member_row_field($member_id_of,'m_password_compat_scheme')=='remote');

			if (($is_ldap) || ($is_httpauth) || ($is_remote) || (($member_id_of!=$member_id_viewing) && (!has_specific_permission($member_id_viewing,'assume_any_member'))))
			{
				$password=NULL;
			} else
			{
				$password=post_param('edit_password');
				if ($password=='') $password=NULL; else
				{
					$password_confirm=trim(post_param('password_confirm'));
					if ($password!=$password_confirm) warn_exit(make_string_tempcode(escape_html(do_lang('PASSWORD_MISMATCH'))));
				}
			}

			$custom_fields=ocf_get_all_custom_fields_match(
				$GLOBALS['FORUM_DRIVER']->get_members_groups($member_id_of), // groups
				(($member_id_of!=$member_id_viewing) && (!has_specific_permission($member_id_viewing,'view_any_profile_field')))?1:NULL, // public view
				($member_id_of!=$member_id_viewing)?NULL:1, // owner view
				($member_id_of!=$member_id_viewing)?NULL:1 // owner set
			);
			$actual_custom_fields=ocf_read_in_custom_fields($custom_fields,$member_id_of);

			$pt_allow=array_key_exists('pt_allow',$_POST)?implode(',',$_POST['pt_allow']):'';
			$tmp_groups=$GLOBALS['OCF_DRIVER']->get_usergroup_list(true,true);
			$all_pt_allow='';
			foreach (array_keys($tmp_groups) as $key)
			{
				if ($key!=db_get_first_id())
				{
					if ($all_pt_allow!='') $all_pt_allow.=',';
					$all_pt_allow.=strval($key);
				}
			}
			if ($pt_allow==$all_pt_allow) $pt_allow='*';
			$pt_rules_text=post_param('pt_rules_text',NULL);

			if (has_specific_permission($member_id_viewing,'member_maintenance'))
			{
				$validated=post_param_integer('validated',0);
				$primary_group=(($is_ldap) || (!has_specific_permission($member_id_viewing,'assume_any_member')))?NULL:post_param_integer('primary_group',NULL);
				$is_perm_banned=post_param_integer('is_perm_banned',0);
				$old_is_perm_banned=$GLOBALS['FORUM_DRIVER']->get_member_row_field($member_id_of,'m_is_perm_banned');
				if ($old_is_perm_banned!=$is_perm_banned)
				{
					if ($is_perm_banned==1) ocf_ban_member($member_id_of); else ocf_unban_member($member_id_of);
				}
				$highlighted_name=post_param_integer('highlighted_name',0);
				if (has_specific_permission($member_id_viewing,'probate_members'))
				{
	   			$on_probation_until=get_input_date('on_probation_until');

	   			$current__on_probation_until=$GLOBALS['FORUM_DRIVER']->get_member_row_field($member_id_of,'m_on_probation_until');
	   			if (((is_null($on_probation_until)) || ($on_probation_until<=time())) && ($current__on_probation_until>time()))
	   			{
	   				log_it('STOP_PROBATION',strval($member_id_of),$GLOBALS['FORUM_DRIVER']->get_username($member_id_of));
	   			}
	   			elseif ((!is_null($on_probation_until)) && ($on_probation_until>time()) && ($current__on_probation_until<=time()))
	   			{
	   				log_it('START_PROBATION',strval($member_id_of),$GLOBALS['FORUM_DRIVER']->get_username($member_id_of));
	   			}
	   			elseif ((!is_null($on_probation_until)) && ($current__on_probation_until>$on_probation_until) && ($on_probation_until>time()) && ($current__on_probation_until>time()))
	   			{
	   				log_it('REDUCE_PROBATION',strval($member_id_of),$GLOBALS['FORUM_DRIVER']->get_username($member_id_of));
	   			}
	   			elseif ((!is_null($on_probation_until)) && ($current__on_probation_until<$on_probation_until) && ($on_probation_until>time()) && ($current__on_probation_until>time()))
	   			{
	   				log_it('EXTEND_PROBATION',strval($member_id_of),$GLOBALS['FORUM_DRIVER']->get_username($member_id_of));
	   			}
				} else
				{
					$on_probation_until=NULL;
				}
			} else
			{
				$validated=NULL;
				$primary_group=NULL;
				$highlighted_name=NULL;
				$on_probation_until=NULL;
			}
			if ((has_actual_page_access($member_id_viewing,'admin_ocf_join')) || (has_specific_permission($member_id_of,'rename_self')))
			{
				$username=($is_ldap||$is_remote)?NULL:post_param('edit_username',NULL);
			} else $username=NULL;

			$email=post_param('email_address',STRING_MAGIC_NULL);
			if (!is_null($email)) $email=trim($email);

			if ($is_remote)
			{
				$preview_posts=NULL;
				$zone_wide=NULL;
				$auto_monitor_contrib_content=NULL;
				$views_signatures=NULL;
				$timezone=NULL;
				$theme=NULL;

				$dob_day=INTEGER_MAGIC_NULL;
				$dob_month=INTEGER_MAGIC_NULL;
				$dob_year=INTEGER_MAGIC_NULL;
			} else
			{
				$theme=post_param('theme',NULL);
				$preview_posts=post_param_integer('preview_posts',0);
				$zone_wide=post_param_integer('zone_wide',0);
				$auto_monitor_contrib_content=NULL;//post_param_integer('auto_monitor_contrib_content',0);	Moved to notifications tab
				$views_signatures=post_param_integer('views_signatures',0);
				$timezone=post_param('timezone',get_site_timezone());

				if (post_param('dob_day',NULL)==='' || post_param('dob_month',NULL)==='' || post_param('dob_year',NULL)==='')
				{
					$dob_day=-1;
					$dob_month=-1;
					$dob_year=-1;
				} else
				{
					$dob_day=post_param_integer('dob_day',NULL);
					$dob_month=post_param_integer('dob_month',NULL);
					$dob_year=post_param_integer('dob_year',NULL);
				}
			}

			ocf_edit_member($member_id_of,$email,$preview_posts,$dob_day,$dob_month,$dob_year,$timezone,$primary_group,$actual_custom_fields,$theme,post_param_integer('reveal_age',fractional_edit()?INTEGER_MAGIC_NULL:0),$views_signatures,$auto_monitor_contrib_content,post_param('language',fractional_edit()?STRING_MAGIC_NULL:NULL),post_param_integer('allow_emails',fractional_edit()?INTEGER_MAGIC_NULL:0),post_param_integer('allow_emails_from_staff',fractional_edit()?INTEGER_MAGIC_NULL:0),$validated,$username,$password,$zone_wide,$highlighted_name,$pt_allow,$pt_rules_text,$on_probation_until);

			// Secondary groups
			//if (array_key_exists('secondary_groups',$_POST)) Can't use this line, because deselecting all will result in it not being passed
			{
				if (!array_key_exists('secondary_groups',$_POST)) $_POST['secondary_groups']=array();

				require_code('ocf_groups_action2');
				$members_groups=$GLOBALS['OCF_DRIVER']->get_members_groups($member_id_of);
				$group_count=$GLOBALS['FORUM_DB']->query_value('f_groups','COUNT(*)');
				$groups=list_to_map('id',$GLOBALS['FORUM_DB']->query_select('f_groups',array('*'),($group_count>200)?array('g_is_private_club'=>0):NULL));
				foreach ($_POST['secondary_groups'] as $group_id)
				{
					$group=$groups[intval($group_id)];

					if (($group['g_hidden']==1) && (!in_array($group['id'],$members_groups)) && (!has_specific_permission($member_id_viewing,'see_hidden_groups'))) continue;

					if ((!in_array($group['id'],$members_groups)) && ((has_specific_permission($member_id_viewing,'assume_any_member')) || ($group['g_open_membership']==1)))
					{
						ocf_add_member_to_group($member_id_of,$group['id']);
					}
				}
				foreach ($members_groups as $group_id)
				{
					if (!in_array(strval($group_id),$_POST['secondary_groups']))
					{
						ocf_member_leave_group($group_id,$member_id_of);
					}
				}
			}

			$GLOBALS['FORUM_DB']->query('DELETE FROM '.$GLOBALS['FORUM_DB']->get_table_prefix().'f_member_known_login_ips WHERE i_member_id='.strval($member_id_of).' AND '.db_string_not_equal_to('i_val_code','')); // So any re-confirms can happen

			if (addon_installed('awards'))
			{
				require_code('awards');
				handle_award_setting('member',strval($member_id_of));
			}

			attach_message(do_lang_tempcode('SUCCESS_SAVE'),'inform');
		}

		if ($leave_to_ajax_if_possible) return NULL;

		// UI

		$title=do_lang_tempcode('SETTINGS');

		$myrow=$GLOBALS['FORUM_DRIVER']->get_member_row($member_id_of);
		if (is_null($myrow)) warn_exit(do_lang_tempcode('USER_NO_EXIST'));

		require_code('ocf_members_action2');
		list($fields,$hidden)=ocf_get_member_fields_settings(false,$member_id_of,NULL,$myrow['m_email_address'],$myrow['m_preview_posts'],$myrow['m_dob_day'],$myrow['m_dob_month'],$myrow['m_dob_year'],get_users_timezone($member_id_of),$myrow['m_theme'],$myrow['m_reveal_age'],$myrow['m_views_signatures'],$myrow['m_auto_monitor_contrib_content'],$myrow['m_language'],$myrow['m_allow_emails'],$myrow['m_allow_emails_from_staff'],$myrow['m_validated'],$myrow['m_primary_group'],$myrow['m_username'],$myrow['m_is_perm_banned'],'',$myrow['m_zone_wide'],$myrow['m_highlighted_name'],$myrow['m_pt_allow'],get_translated_text($myrow['m_pt_rules_text'],$GLOBALS['FORUM_DB']),$myrow['m_on_probation_until']);

		// Awards?
		if (addon_installed('awards'))
		{
			require_code('awards');
			$fields->attach(get_award_fields('member',strval($member_id_of)));
		}

		$redirect=get_param('redirect',NULL);
		if (!is_null($redirect))
			$hidden->attach(form_input_hidden('redirect',$redirect));

		$hidden->attach(form_input_hidden('submitting_settings_tab','1'));

		$javascript="
			var form=document.getElementById('email_address').form;
			form.prior_profile_edit_submit=form.onsubmit;
			form.onsubmit=function()
				{
					if (typeof form.elements['edit_password']!='undefined')
					{
						if ((form.elements['password_confirm']) && (form.elements['password_confirm'].value!=form.elements['edit_password'].value))
						{
							window.fauxmodal_alert('".php_addslashes(do_lang('PASSWORD_MISMATCH'))."');
							return false;
						}
					}
					if (typeof form.prior_profile_edit_submit!='undefined' && form.prior_profile_edit_submit) return form.prior_profile_edit_submit();
					return true;
				};
		";

		$text='';

		return array($title,$fields,$text,$javascript,$order,$hidden);
	}

}


