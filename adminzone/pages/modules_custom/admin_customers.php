<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2013

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		ocportalcom_support_credits
 */

/**
 * Module page class.
 */
class Module_admin_customers
{

	/**
	 * Standard modular info function.
	 *
	 * @return ?array	Map of module info (NULL: module is disabled).
	 */
	function info()
	{
		$info=array();
		$info['author']='Philip Withnall';
		$info['organisation']='ocProducts';
		$info['hacked_by']=NULL;
		$info['hack_version']=NULL;
		$info['version']=1;
		$info['locked']=false;
		return $info;
	}

	/**
	 * Standard modular uninstall function.
	 */
	function uninstall()
	{
		/* NB: Does not delete CPFs and multi-mods. But that doesn't actually matter */
		delete_config_option('support_credit_value');
		$GLOBALS['SITE_DB']->drop_table_if_exists('credit_purchases');
	}

	/**
	 * Standard modular install function.
	 *
	 * @param  ?integer	What version we're upgrading from (NULL: new install)
	 * @param  ?integer	What hack version we're upgrading from (NULL: new-install/not-upgrading-from-a-hacked-version)
	 */
	function install($upgrade_from=NULL,$upgrade_from_hack=NULL)
	{
		require_lang('customers');

		if (get_forum_type()!='ocf') return;

		/* CPFs */
		require_code('ocf_members_action');
		ocf_make_custom_field('ocp_support_credits',1,'','',0,0,0,0,'integer');
		ocf_make_custom_field('ocp_ftp_host',1,do_lang('ENCRYPTED_TO_WEBSITE'),'',0,1,1,1,'short_text');
		ocf_make_custom_field('ocp_ftp_path',1,do_lang('ENCRYPTED_TO_WEBSITE'),'',0,1,1,1,'short_text');
		ocf_make_custom_field('ocp_ftp_username',1,do_lang('ENCRYPTED_TO_WEBSITE'),'',0,1,1,1,'short_text');
		ocf_make_custom_field('ocp_ftp_password',1,do_lang('ENCRYPTED_TO_WEBSITE'),'',0,1,1,1,'short_text');
		ocf_make_custom_field('ocp_profession',1,'',do_lang('CUSTOMER_PROFESSION_CPF_LIST'),0,1,1,0,'list');

		add_config_option('SUPPORT_CREDIT_VALUE','support_credit_value','float','return \'5.5\';','FEATURE','SECTION_CUSTOMERS');

		$GLOBALS['SITE_DB']->create_table('credit_purchases',array(
			'purchase_id'=>'*AUTO',
			'member_id'=>'AUTO_LINK',
			'num_credits'=>'INTEGER',
			'date_and_time'=>'TIME',
			'purchase_validated'=>'BINARY',
			'is_manual'=>'BINARY'
		));

		/* Multi-mods */
		require_code('ocf_moderation_action');

		ocf_make_multi_moderation(do_lang('TICKET_MM_TAKE_OWNERSHIP'),do_lang('TICKET_MM_TAKE_OWNERSHIP_POST'),NULL,NULL,NULL,NULL,'*');
		ocf_make_multi_moderation(do_lang('TICKET_MM_QUOTE'),do_lang('TICKET_MM_QUOTE_POST'),NULL,NULL,NULL,NULL,'*');
		ocf_make_multi_moderation(do_lang('TICKET_MM_PRICE'),do_lang('TICKET_MM_PRICE_POST'),NULL,NULL,NULL,NULL,'*');
		ocf_make_multi_moderation(do_lang('TICKET_MM_CLOSE'),do_lang('TICKET_MM_CLOSE_POST'),NULL,NULL,NULL,NULL,'*');
		ocf_make_multi_moderation(do_lang('TICKET_MM_CHARGED'),do_lang('TICKET_MM_CHARGED_POST'),NULL,NULL,NULL,NULL,'*');
		ocf_make_multi_moderation(do_lang('TICKET_MM_NOT_FOR_FREE'),do_lang('TICKET_MM_NOT_FOR_FREE_POST'),NULL,NULL,NULL,NULL,'*');
		ocf_make_multi_moderation(do_lang('TICKET_MM_FREE_WORK'),do_lang('TICKET_MM_FREE_WORK_POST'),NULL,NULL,NULL,NULL,'*');
		ocf_make_multi_moderation(do_lang('TICKET_MM_FREE_CREDITS'),do_lang('TICKET_MM_FREE_CREDITS_POST'),NULL,NULL,NULL,NULL,'*');
	}

	/**
	 * Standard modular entry-point finder function.
	 *
	 * @return ?array	A map of entry points (type-code=>language-code) (NULL: disabled).
	 */
	function get_entry_points()
	{
		return array('misc'=>'CHARGE_CUSTOMER');
	}

	/**
	 * Standard modular run function.
	 *
	 * @return tempcode	The result of execution.
	 */
	function run()
	{
		require_lang('customers');

		$type=get_param('type','misc');

		if ($type=='charge') return $this->charge();
		if ($type=='_charge') return $this->_charge();
		if ($type=='misc') return $this->charge();

		return new ocp_tempcode();
	}

	/**
	 * The UI to charge a customer.
	 *
	 * @return tempcode		The UI
	 */
	function charge()
	{
		$title=get_screen_title('CHARGE_CUSTOMER');
	
		require_code('form_templates');

		$post_url=build_url(array('page'=>'_SELF','type'=>'_charge'),'_SELF');
		$submit_name=do_lang_tempcode('CHARGE');

		$username=get_param('username',NULL);
		if (is_null($username))
		{
			$member_id=get_param_integer('member_id',NULL);
			if (!is_null($member_id)) $username=$GLOBALS['FORUM_DRIVER']->get_username($member_id);
			else $username='';
		} else
		{
			$member_id=$GLOBALS['FORUM_DRIVER']->get_member_from_username($username);
		}

		$fields=new ocp_tempcode();
		$fields->attach(form_input_username(do_lang_tempcode('USERNAME'),'','member_username',$username,true));
		$fields->attach(form_input_integer(do_lang_tempcode('CREDIT_AMOUNT'),do_lang_tempcode('CREDIT_AMOUNT_DESCRIPTION'),'amount',get_param_integer('amount',3),true));

		if (!is_null($member_id))
		{
			require_code('ocf_members');
			$cpfs=ocf_get_all_custom_fields_match(NULL,NULL,NULL,NULL,NULL,NULL,NULL,1);
			$cpf_id=NULL;
			foreach ($cpfs as $cpf)
			{
				if ($cpf['trans_name']=='ocp_support_credits')
				{
					$cpf_id=$cpf['id'];
					break;
				}
			}
			$num_credits=0;
			if (!is_null($cpf_id))
			{
				require_code('ocf_members_action2');
				$_fields=ocf_get_custom_field_mappings($member_id);
				$num_credits=intval($_fields['field_'.strval($cpf_id)]);
			}

			$text=do_lang_tempcode('CUSTOMER_CURRENTLY_HAS',escape_html(number_format($num_credits)));
		} else $text=new ocp_tempcode();

		return do_template('FORM_SCREEN',array('_GUID'=>'f91185ee725f47ffa652d5fef8d85c0b','TITLE'=>$title,'HIDDEN'=>'','TEXT'=>$text,'FIELDS'=>$fields,'SUBMIT_NAME'=>$submit_name,'URL'=>$post_url));
	}

	/**
	 * The actualiser to charge a customer.
	 *
	 * @return tempcode		The UI
	 */
	function _charge()
	{
		$title=get_screen_title('CHARGE_CUSTOMER');

		$username=post_param('member_username');
		$member_id=$GLOBALS['FORUM_DRIVER']->get_member_from_username($username);
		$amount=post_param_integer('amount');

		require_code('ocf_members');
		$cpfs=ocf_get_all_custom_fields_match(NULL,NULL,NULL,NULL,NULL,NULL,NULL,1);
		$cpf_id=NULL;
		foreach ($cpfs as $cpf)
		{
			if ($cpf['trans_name']=='ocp_support_credits')
			{
				$cpf_id=$cpf['id'];
				break;
			}
		}

		// Increment the number of credits this customer has
		require_code('ocf_members_action2');
		$fields=ocf_get_custom_field_mappings($member_id);

		// NB: Nothing to stop them going into overdraft
		$new_amount=$fields['field_'.strval($cpf_id)]-$amount;
		//if ($new_amount<0) $new_amount=0;

		ocf_set_custom_field($member_id,$cpf_id,$new_amount);

		// Show it worked / Refresh
		$url=build_url(array('page'=>'_SELF','type'=>'misc','username'=>$username),'_SELF');
		return redirect_screen($title,$url,do_lang_tempcode('SUCCESS'));
	}
}


