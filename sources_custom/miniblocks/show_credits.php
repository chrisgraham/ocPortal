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

if (is_guest())
{
	$login_url=build_url(array('page'=>'login','redirect'=>get_self_url(true,true)),'');
	if (is_object($login_url)) $login_url=$login_url->evaluate();
	$join_url=build_url(array('page'=>'join','redirect'=>get_self_url(true,true)),'');
	if (is_object($join_url)) $join_url=$join_url->evaluate();
	echo '<div class="gold_bar">';
	if (get_page_name()!='commercial_support')
	{
		$commercial_support_url=build_url(array('page'=>'commercial_support'),'site');
		if (is_object($commercial_support_url)) $commercial_support_url=$commercial_support_url->evaluate();
		echo '
			<div class="gb_help"><a href="'.escape_html($commercial_support_url).'">What\'s this?</a></div>
		';
	}
	echo '<div class="gb_not_logged_in">You are not currently logged in.<span class="gb_not_logged_in_note"> To use tickets please <a href="'.escape_html($login_url).'">login</a>/<a href="'.escape_html($join_url).'">join</a> (login for free &ldquo;Contact us&rdquo; tickets optional)</span>.</div>';
	echo '</div>';
	
	return;
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
$tickets_open=$GLOBALS['FORUM_DB']->query_value_if_there('SELECT '.$query,false,true);

$username_link=hyperlink($GLOBALS['FORUM_DRIVER']->member_profile_url(get_member()),escape_html($username));
$logout_url=build_url(array('page'=>'login','type'=>'logout','redirect'=>get_self_url(true,true)),'');
if (is_object($logout_url)) $logout_url=$logout_url->evaluate();
echo '
<div class="gold_bar">
	<div class="gb_welcome">Welcome, '.$username_link->evaluate().' <span class="associated_details">(<a href="'.escape_html($logout_url).'">logout</a>)</span>.</div>
';
if (get_page_name()!='commercial_support' || $credits_available==0)
{
	$commercial_support_url=build_url(array('page'=>'commercial_support'),'site');
	if (is_object($commercial_support_url)) $commercial_support_url=$commercial_support_url->evaluate();
	echo '<div class="gb_help">';
	echo '<a href="'.escape_html($commercial_support_url).'">What\'s this?</a>';
	if ($credits_available==0) echo ' and <a href="http://ocportal.com/site/news/view/chris_grahams_blog/the-ocportalocproducts.htm">why is it likely a problem?</a>';
	echo '</div>';
}
$tickets_url=build_url(array('page'=>'tickets','type'=>'misc'),get_module_zone('tickets'));
if (is_object($tickets_url)) $tickets_url=$tickets_url->evaluate();
echo '<div class="gb_credits_available">You have ';
if ($credits_available==0) echo '<span style="color: red">';
echo '<strong>'.escape_html(number_format($credits_available)).'</strong> credits available';
if ($credits_available==0) echo '</span>';
echo ', and <strong>'.escape_html(number_format($tickets_open)).'</strong> <a href="'.escape_html($tickets_url).'">tickets open</a>.</div>';
echo '</div>';
