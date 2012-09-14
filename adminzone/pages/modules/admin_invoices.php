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
 * @package		ecommerce
 */

/**
 * Module page class.
 */
class Module_admin_invoices
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
		return array('misc'=>'OUTSTANDING_INVOICES','undelivered'=>'UNDELIVERED_INVOICES','ad'=>'CREATE_INVOICE');
	}

	/**
	 * Standard modular run function.
	 *
	 * @return tempcode	The result of execution.
	 */
	function run()
	{
		require_lang('ecommerce');
		require_code('ecommerce');

		$type=get_param('type','ad');

		set_helper_panel_pic('pagepics/invoices');
		set_helper_panel_tutorial('tut_ecommerce');

		if ($type=='misc') return $this->misc();
		if ($type=='ad') return $this->ad();
		if ($type=='_ad') return $this->_ad();
		if ($type=='outstanding') return $this->outstanding();
		if ($type=='undelivered') return $this->undelivered();
		if ($type=='delete') return $this->delete();
		if ($type=='deliver') return $this->deliver();
		return new ocp_tempcode();
	}

	/**
	 * The do-next manager for before invoice management.
	 *
	 * @return tempcode		The UI
	 */
	function misc()
	{
		breadcrumb_set_self(do_lang_tempcode('INVOICES'));
		breadcrumb_set_parents(array(array('_SEARCH:admin_ecommerce:ecom_usage',do_lang_tempcode('ECOMMERCE'))));

		require_code('templates_donext');
		return do_next_manager(get_screen_title('INVOICES'),comcode_lang_string('DOC_ECOMMERCE'),
					array(
						/*	 type							  page	 params													 zone	  */
						array('add_one',array('_SELF',array('type'=>'ad'),'_SELF'),do_lang('CREATE_INVOICE')),
						array('securitylog',array('_SELF',array('type'=>'outstanding'),'_SELF'),do_lang('OUTSTANDING_INVOICES')),
						array('edit_one',array('_SELF',array('type'=>'undelivered'),'_SELF'),do_lang('UNDELIVERED_INVOICES')),
					),
					do_lang('INVOICES')
		);
	}

	/**
	 * UI to add an invoice.
	 *
	 * @return tempcode	The interface.
	 */
	function ad()
	{
		$title=get_screen_title('CREATE_INVOICE');

		breadcrumb_set_parents(array(array('_SEARCH:admin_ecommerce:ecom_usage',do_lang_tempcode('ECOMMERCE')),array('_SELF:_SELF:misc',do_lang_tempcode('INVOICES'))));

		require_code('form_templates');

		$to=get_param('to','');

		$products=find_all_products();
		$list=new ocp_tempcode();
		foreach ($products as $product=>$details)
		{
			if ($details[0]==PRODUCT_INVOICE)
			{
				$text=do_lang_tempcode('CUSTOM_PRODUCT_'.$product);
				if ($details[1]!='?') $text->attach(escape_html(' ('.$details[1].' '.get_option('currency').')'));
				$list->attach(form_input_list_entry($product,false,$text));
			}
		}
		if ($list->is_empty()) inform_exit(do_lang_tempcode('NOTHING_TO_INVOICE_FOR'));
		$fields=new ocp_tempcode();
		$fields->attach(form_input_list(do_lang_tempcode('PRODUCT'),'','product',$list));
		$fields->attach(form_input_username(do_lang_tempcode('USERNAME'),do_lang_tempcode('DESCRIPTION_INVOICE_FOR'),'to',$to,true));
		$fields->attach(form_input_float(do_lang_tempcode('AMOUNT'),do_lang_tempcode('INVOICE_AMOUNT_TEXT',escape_html(get_option('currency'))),'amount',NULL,false));
		$fields->attach(form_input_line(do_lang_tempcode('INVOICE_SPECIAL'),do_lang_tempcode('DESCRIPTION_INVOICE_SPECIAL'),'special','',false));
		$fields->attach(form_input_text(do_lang_tempcode('INVOICE_NOTE'),do_lang_tempcode('DESCRIPTION_INVOICE_NOTE'),'note','',false));

		$post_url=build_url(array('page'=>'_SELF','type'=>'_ad'),'_SELF');
		$submit_name=do_lang_tempcode('CREATE_INVOICE');

		return do_template('FORM_SCREEN',array('_GUID'=>'b8a08145bd1262c277e00a1151d6383e','HIDDEN'=>'','TITLE'=>$title,'URL'=>$post_url,'FIELDS'=>$fields,'SUBMIT_NAME'=>$submit_name,'TEXT'=>do_lang_tempcode('DESCRIPTION_INVOICE_PAGE')));
	}

	/**
	 * Actualiser to add an invoice.
	 *
	 * @return tempcode	The interface.
	 */
	function _ad()
	{
		$title=get_screen_title('CREATE_INVOICE');

		breadcrumb_set_self(do_lang_tempcode('DONE'));
		breadcrumb_set_parents(array(array('_SEARCH:admin_ecommerce:ecom_usage',do_lang_tempcode('ECOMMERCE')),array('_SELF:_SELF:misc',do_lang_tempcode('INVOICES')),array('_SELF:_SELF:ad',do_lang_tempcode('CREATE_INVOICE'))));

		$product=post_param('product');
		$object=find_product($product);

		$amount=post_param('amount','');
		if ($amount=='')
		{
			$products=$object->get_products(false,$product);
			$amount=$products[$product][1];
			if ($amount=='?') warn_exit(do_lang_tempcode('INVOICE_REQURIRED_AMOUNT'));
		}

		$to=post_param('to');
		$member_id=$GLOBALS['FORUM_DRIVER']->get_member_from_username($to);
		if (is_null($member_id)) warn_exit(do_lang_tempcode('_MEMBER_NO_EXIST',$to));

		$id=$GLOBALS['SITE_DB']->query_insert('invoices',array(
			'i_type_code'=>$product,
			'i_member_id'=>$member_id,
			'i_state'=>'new',
			'i_amount'=>$amount,
			'i_special'=>post_param('special'),
			'i_time'=>time(),
			'i_note'=>post_param('note')
		),true);

		log_it('CREATE_INVOICE',strval($id),$product);

		send_invoice_mail($member_id,$id);

		$url=build_url(array('page'=>'_SELF','type'=>'outstanding'),'_SELF');
		return redirect_screen($title,$url,do_lang_tempcode('SUCCESS'));
	}

	/**
	 * Show outstanding invoices.
	 *
	 * @return tempcode	The interface.
	 */
	function outstanding()
	{
		$title=get_screen_title('OUTSTANDING_INVOICES');

		breadcrumb_set_parents(array(array('_SEARCH:admin_ecommerce:ecom_usage',do_lang_tempcode('ECOMMERCE')),array('_SELF:_SELF:misc',do_lang_tempcode('INVOICES'))));

		$invoices=array();
		$rows=$GLOBALS['SITE_DB']->query_select('invoices',array('*'),array('i_state'=>'new'));
		foreach ($rows as $row)
		{
			$invoice_title=do_lang('CUSTOM_PRODUCT_'.$row['i_type_code']);
			$time=get_timezoned_date($row['i_time']);
			$username=$GLOBALS['FORUM_DRIVER']->get_username($row['i_member_id']);
			$profile_url=$GLOBALS['FORUM_DRIVER']->member_profile_url($row['i_member_id'],false,true);
			$invoices[]=array('INVOICE_TITLE'=>$invoice_title,'PROFILE_URL'=>$profile_url,'USERNAME'=>$username,'ID'=>strval($row['id']),'STATE'=>$row['i_state'],'AMOUNT'=>$row['i_amount'],'TIME'=>$time,'NOTE'=>$row['i_note'],'TYPE_CODE'=>$row['i_type_code']);
		}
		if (count($invoices)==0) inform_exit(do_lang_tempcode('NO_ENTRIES'));

		return do_template('ECOM_OUTSTANDING_INVOICES_SCREEN',array('_GUID'=>'fab0fa7dbcd9d6484fa1861ce170717a','TITLE'=>$title,'FROM'=>'outstanding','INVOICES'=>$invoices));
	}

	/**
	 * Show undelivered invoices.
	 *
	 * @return tempcode	The interface.
	 */
	function undelivered()
	{
		$title=get_screen_title('UNDELIVERED_INVOICES');

		breadcrumb_set_parents(array(array('_SEARCH:admin_ecommerce:ecom_usage',do_lang_tempcode('ECOMMERCE')),array('_SELF:_SELF:misc',do_lang_tempcode('INVOICES'))));

		$invoices=array();
		$rows=$GLOBALS['SITE_DB']->query_select('invoices',array('*'),array('i_state'=>'paid'));
		foreach ($rows as $row)
		{
			$invoice_title=do_lang('CUSTOM_PRODUCT_'.$row['i_type_code']);
			$time=get_timezoned_date($row['i_time']);
			$username=$GLOBALS['FORUM_DRIVER']->get_username($row['i_member_id']);
			$profile_url=$GLOBALS['FORUM_DRIVER']->member_profile_url($row['i_member_id'],false,true);
			$invoices[]=array('INVOICE_TITLE'=>$invoice_title,'PROFILE_URL'=>$profile_url,'USERNAME'=>$username,'ID'=>strval($row['id']),'STATE'=>$row['i_state'],'AMOUNT'=>$row['i_amount'],'TIME'=>$time,'NOTE'=>$row['i_note'],'TYPE_CODE'=>$row['i_type_code']);
		}
		if (count($invoices)==0) inform_exit(do_lang_tempcode('NO_ENTRIES'));

		return do_template('ECOM_OUTSTANDING_INVOICES_SCREEN',array('_GUID'=>'672e41d8cbe06f046a47762ff75c8337','TITLE'=>$title,'FROM'=>'undelivered','INVOICES'=>$invoices));
	}

	/**
	 * Actualiser to delete an invoice.
	 *
	 * @return tempcode	The result.
	 */
	function delete()
	{
		$title=get_screen_title('DELETE_INVOICE');

		breadcrumb_set_parents(array(array('_SEARCH:admin_ecommerce:ecom_usage',do_lang_tempcode('ECOMMERCE')),array('_SELF:_SELF:misc',do_lang_tempcode('INVOICES')),array('_SELF:_SELF:undelivered',do_lang_tempcode('UNDELIVERED_INVOICES'))));

		if (post_param_integer('confirmed',0)!=1)
		{
			$url=get_self_url();
			$text=do_lang_tempcode('DELETE_INVOICE');

			breadcrumb_set_self(do_lang_tempcode('CONFIRM'));

			$hidden=build_keep_post_fields();
			$hidden->attach(form_input_hidden('confirmed','1'));
			$hidden->attach(form_input_hidden('from',get_param('from','misc')));

			return do_template('CONFIRM_SCREEN',array('_GUID'=>'45707062c00588c33726b256e8f9ba40','TITLE'=>$title,'FIELDS'=>$hidden,'PREVIEW'=>$text,'URL'=>$url));
		}

		breadcrumb_set_self(do_lang_tempcode('DONE'));

		$GLOBALS['SITE_DB']->query_delete('invoices',array('id'=>get_param_integer('id')),'',1);

		$url=build_url(array('page'=>'_SELF','type'=>post_param('from','misc')),'_SELF');
		return redirect_screen($title,$url,do_lang_tempcode('SUCCESS'));
	}

	/**
	 * Actualiser to deliver an invoice.
	 *
	 * @return tempcode	The result.
	 */
	function deliver()
	{
		$title=get_screen_title('MARK_AS_DELIVERED');

		breadcrumb_set_self(do_lang_tempcode('DONE'));
		breadcrumb_set_parents(array(array('_SEARCH:admin_ecommerce:ecom_usage',do_lang_tempcode('ECOMMERCE')),array('_SELF:_SELF:misc',do_lang_tempcode('INVOICES')),array('_SELF:_SELF:undelivered',do_lang_tempcode('UNDELIVERED_INVOICES'))));

		$GLOBALS['SITE_DB']->query_update('invoices',array('i_state'=>'delivered'),array('id'=>get_param_integer('id')),'',1);

		$url=build_url(array('page'=>'_SELF','type'=>'undelivered'),'_SELF');
		return redirect_screen($title,$url,do_lang_tempcode('SUCCESS'));
	}

}


