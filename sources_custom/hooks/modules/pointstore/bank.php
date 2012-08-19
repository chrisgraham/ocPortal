<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		pointstore
 */

class Hook_pointstore_bank
{

	/**
	 * Standard pointstore item initialisation function.
	 */
	function init()
	{
		require_lang('bank');
	}

	/**
	 * Standard pointstore item initialisation function.
	 *
	 * @return array			The "shop fronts"
	 */
	function info()
	{
		$class=str_replace('hook_pointstore_','',strtolower(get_class($this)));

		$next_url=build_url(array('page'=>'_SELF','type'=>'action','id'=>$class),'_SELF');
		return array(do_template('POINTSTORE_'.strtoupper($class),array('NEXT_URL'=>$next_url)));
	}

	/**
	 * Standard interface stage of pointstore item purchase.
	 *
	 * @return tempcode		The UI
	 */
	function action()
	{
		require_code('database_action');
		$class=str_replace('hook_pointstore_','',strtolower(get_class($this)));

		if (!$GLOBALS['SITE_DB']->table_exists('bank'))
		{
			$GLOBALS['SITE_DB']->create_table('bank',array(
				'id'=>'*AUTO',
				'user_id'=>'INTEGER',
				'amount'=>'INTEGER',
				'dividend'=>'INTEGER',
				'add_time'=>'?TIME',
		   ));
		}

		$_bank_dividend=get_option('bank_dividend',true);
		if (is_null($_bank_dividend))
		{
			// Add option and default value
			add_config_option('BANK_DIVIDEND','bank_dividend','integer','return \'40\';','POINTSTORE','BANKING');
			// IDEA: Make 30 days a config option too, or even have multiple products?
			// IDEA: Send email saying bank returned money?
			// IDEA: Have the bank do marketing to people? http://ocportal.com/forum/topicview/misc/addons/ocbank_4.htm?redirected=1#post_87711
			$bank_dividend=4;
		} else
		{
			$bank_dividend=intval($_bank_dividend);
		}

		$title=get_screen_title('BANKING');

		$points_left=available_points(get_member());
		$next_url=build_url(array('page'=>'_SELF','type'=>'action_done','id'=>$class),'_SELF');

		// Check points
		if (($points_left<0) && (!has_privilege(get_member(),'give_points_self')))
		{
			return warn_screen($title,do_lang_tempcode('_CANT_AFFORD_BANK'));
		}

		require_code('form_templates');
		$fields=new ocp_tempcode();

		$fields->attach(form_input_integer(do_lang_tempcode('AMOUNT'),do_lang_tempcode('DESCRIPTION_BANK_AMOUNT',integer_format($points_left)),'amount',$points_left,true));

		$text=do_lang_tempcode('BANK_A',integer_format($points_left));

		return do_template('FORM_SCREEN',array('_GUID'=>'f58cd830101bd4b440d42a8b8d4e39aa','TITLE'=>$title,'TEXT'=>$text,'URL'=>$next_url,'FIELDS'=>$fields,'HIDDEN'=>'','SUBMIT_NAME'=>do_lang_tempcode('PROCEED')));
	}

	/**
	 * Standard actualisation stage of pointstore item purchase.
	 *
	 * @return tempcode		The UI
	 */
	function action_done()
	{
		$class=str_replace('hook_pointstore_','',strtolower(get_class($this)));

		$amount=post_param_integer('amount',0);

		$bank_dividend=intval(get_option('bank_dividend'));

		$title=get_screen_title('BANKING');


		// Check points
		$points_left=available_points(get_member());

		if (!has_privilege(get_member(),'give_points_self'))
		{
			if ($points_left<$amount)
			{
				return warn_screen($title,do_lang_tempcode('_CANT_AFFORD_BANK'));
			}
		}

		// Actuate
		require_code('points2');
		charge_member(get_member(),$amount,do_lang('BANKING'));
		$GLOBALS['SITE_DB']->query_insert('bank',array('add_time'=>time(),'user_id'=>get_member(),'amount'=>strval($amount),'dividend'=>$bank_dividend));

		// Show message
		$result=do_lang_tempcode('BANKING_CONGRATULATIONS',integer_format($amount),integer_format($bank_dividend));


		$url=build_url(array('page'=>'_SELF','type'=>'misc'),'_SELF');
		return redirect_screen($title,$url,$result);
	}

}


