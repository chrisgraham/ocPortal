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
class Module_admin_referrals
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
		$info['version']=1;
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
		return array('misc'=>'REFERRALS');
	}

	/**
	 * Standard modular run function.
	 *
	 * @return tempcode	The result of execution.
	 */
	function run()
	{
		require_lang('referrals');
		require_code('referrals');

		$type=get_param('type','misc');

		if ($type=='misc') return $this->misc();
		if ($type=='adjust') return $this->adjust();
		if ($type=='_adjust') return $this->_adjust();

		return new ocp_tempcode();
	}

	/**
	 * Show a log of referrals.
	 *
	 * @return tempcode		The UI
	 */
	function misc()
	{
		require_lang('referrals');

		$title=get_screen_title('REFERRALS');

		$table=referrer_report_script(true);

		$out=new ocp_tempcode();
		$out->attach($title);
		$out->attach($table);
		return $out;
	}

	/**
	 * The UI to adjust settings for a referrer.
	 *
	 * @return tempcode		The UI
	 */
	function adjust()
	{
		$scheme=get_param('scheme');
		$ini_file=parse_ini_file(get_custom_file_base().'/text_custom/referrals.txt',true);
		$scheme_title=$ini_file[$scheme]['title'];

		$title=get_screen_title('MANUALLY_ADJUST_SCHEME_SETTINGS',true,array(escape_html($scheme_title)));

		$member_id=get_param_integer('member_id');

		require_code('form_templates');

		$post_url=build_url(array('page'=>'_SELF','type'=>'_adjust','scheme'=>$scheme,'member_id'=>$member_id),'_SELF');
		$submit_name=do_lang_tempcode('SAVE');

		list($num_total_qualified_by_referrer)=get_referral_scheme_stats_for($member_id,$scheme);

		$referrals_count=$num_total_qualified_by_referrer;
		$is_qualified=$GLOBALS['SITE_DB']->query_select_value_if_there('referrer_override','o_is_qualified',array('o_referrer'=>$member_id,'o_scheme_name'=>$scheme));

		$fields=new ocp_tempcode();
		$fields->attach(form_input_integer(do_lang_tempcode('QUALIFIED_REFERRALS_COUNT'),'','referrals_count',$referrals_count,true));
		$is_qualified_list=new ocp_tempcode();
		$is_qualified_list->attach(form_input_list_entry('',$is_qualified===NULL,do_lang_tempcode('IS_QUALIFIED_DETECT')));
		$is_qualified_list->attach(form_input_list_entry('1',$is_qualified===1,do_lang_tempcode('YES')));
		$is_qualified_list->attach(form_input_list_entry('0',$is_qualified===0,do_lang_tempcode('NO')));
		$fields->attach(form_input_list(do_lang_tempcode('IS_QUALIFIED'),'','is_qualified',$is_qualified_list,NULL,false,false));

		return do_template('FORM_SCREEN',array('TITLE'=>$title,'HIDDEN'=>'','TEXT'=>'','FIELDS'=>$fields,'SUBMIT_NAME'=>$submit_name,'URL'=>$post_url));
	}

	/**
	 * The actualiser to adjust settings for a referrer.
	 *
	 * @return tempcode		The UI
	 */
	function _adjust()
	{
		$scheme=get_param('scheme');
		$ini_file=parse_ini_file(get_custom_file_base().'/text_custom/referrals.txt',true);
		$scheme_title=$ini_file[$scheme]['title'];

		$title=get_screen_title('MANUALLY_ADJUST_SCHEME_SETTINGS',true,array(escape_html($scheme_title)));

		$member_id=get_param_integer('member_id');

		list($num_total_qualified_by_referrer)=get_referral_scheme_stats_for($member_id,$scheme,true);
		$referrals_count=post_param_integer('referrals_count');
		$referrals_dif=$referrals_count-$num_total_qualified_by_referrer;
		$is_qualified=post_param_integer('is_qualified',NULL);

		// Save
		$GLOBALS['SITE_DB']->query_delete('referrer_override',array(
			'o_referrer'=>$member_id,
			'o_scheme_name'=>$scheme,
		));
		$GLOBALS['SITE_DB']->query_insert('referrer_override',array(
			'o_referrer'=>$member_id,
			'o_scheme_name'=>$scheme,
			'o_referrals_dif'=>$referrals_dif,
			'o_is_qualified'=>$is_qualified,
		));

		// Show it worked / Refresh
		$url=build_url(array('page'=>'members','type'=>'view','id'=>$member_id),get_module_zone('members'));
		return redirect_screen($title,$url,do_lang_tempcode('SUCCESS'));
	}
}


