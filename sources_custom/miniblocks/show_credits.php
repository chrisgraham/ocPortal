<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		ocportalcom_support_credits
 */

require_lang('customers');
$whats_this = '';
$guest_msg = '';
$welcome_msg = '';
$tickets_open_msg = '';
$no_credits_link = '';
$credits_message = '';
	if (get_page_name()!='commercial_support')
	{
		$commercial_support_url=build_url(array('page'=>'commercial_support'),'site');
		if (is_object($commercial_support_url)) $commercial_support_url=$commercial_support_url->evaluate();
		$whats_this = do_lang_tempcode('SHOW_CREDITS_Whats_this',$commercial_support_url);
	}
	

if (is_guest())
{
	$login_url=build_url(array('page'=>'login','redirect'=>get_self_url(true,true)),'');
	if (is_object($login_url)) $login_url=$login_url->evaluate();
	$join_url=build_url(array('page'=>'join','redirect'=>get_self_url(true,true)),'');
	if (is_object($join_url)) $join_url=$join_url->evaluate();
	$guest_msg = do_lang_tempcode('SHOW_CREDITS_NOT_LOGGED_IN_MESSAGE',$login_url,$join_url);
}

$username=$GLOBALS['FORUM_DRIVER']->get_username(get_member());

$credits_available=intval(get_ocp_cpf('support_credits'));

require_lang('tickets');
require_code('tickets');
require_code('tickets2');

$query='';
$topic_filters=array();
$restrict=strval(get_member()).'\_%';
$restrict_description=do_lang('SUPPORT_TICKET').': #'.$restrict;
$topic_filters[]='t_cache_first_title LIKE \''.db_encode_like($restrict).'\'';
$topic_filters[]='t_description LIKE \''.db_encode_like($restrict_description).'\'';
foreach ($topic_filters as $topic_filter)
{
	if ($query!='') $query.=' + ';
	$query.='(SELECT COUNT(*) FROM '.$GLOBALS['FORUM_DB']->get_table_prefix().'f_topics WHERE t_forum_id='.strval(get_ticket_forum_id(NULL,NULL,false)).' AND '.$topic_filter.' AND t_is_open=1)';
}
$tickets_open=$GLOBALS['FORUM_DB']->query_value_null_ok_full('SELECT '.$query,false,true);

$username_link=hyperlink($GLOBALS['FORUM_DRIVER']->member_profile_url(get_member()),escape_html($username));
$username_link=$username_link->evaluate();
$logout_url=build_url(array('page'=>'login','type'=>'logout','redirect'=>get_self_url(true,true)),'');
if (is_object($logout_url)) $logout_url=$logout_url->evaluate();
$welcome_msg = do_lang_tempcode('SHOW_CREDITS_WELCOME_MESSAGE',$username_link,$logout_url);
if ($credits_available==0)
{
	$no_credits_link = do_lang_tempcode('SHOW_CREDITS_No_credits_link');
	$credits_message = do_lang_tempcode('SHOW_CREDITS_No_credits');
} 
else
{
	$credits_message = do_lang_tempcode('SHOW_CREDITS_Some_credits',$credits_available);
}
$tickets_url=build_url(array('page'=>'tickets','type'=>'misc'),get_module_zone('tickets'));
if (is_object($tickets_url)) $tickets_url=$tickets_url->evaluate();
$tickets_open_msg = do_lang_tempcode('SHOW_CREDITS_Tickets_open',number_format($tickets_open),$tickets_url);
$tpl=do_template('SHOW_CREDITS_BAR',array('GUEST_MSG'=>$guest_msg,'WHATS_THIS'=>$whats_this,'WHATS_THIS_LINK'=>$no_credits_link,'WELCOME_MSG'=>$welcome_msg,'CREDITS_AVAILABLE'=>$credits_message));
$tpl->evaluate_echo();
