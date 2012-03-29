<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		core
 */

// FIX PATH
global $FILE_BASE,$RELATIVE_PATH;
$FILE_BASE=(strpos(__FILE__,'./')===false)?__FILE__:realpath(__FILE__);
$FILE_BASE=str_replace('\\\\','\\',$FILE_BASE);
if (substr($FILE_BASE,-4)=='.php')
{
	$a=strrpos($FILE_BASE,'/');
	if ($a===false) $a=0;
	$b=strrpos($FILE_BASE,'\\');
	if ($b===false) $b=0;
	$FILE_BASE=substr($FILE_BASE,0,($a>$b)?$a:$b);
}
if (!is_file($FILE_BASE.'/sources/global.php'))
{
	$a=strrpos($FILE_BASE,'/');
	if ($a===false) $a=0;
	$b=strrpos($FILE_BASE,'\\');
	if ($b===false) $b=0;
	$RELATIVE_PATH=substr($FILE_BASE,(($a>$b)?$a:$b)+1);
	$FILE_BASE=substr($FILE_BASE,0,($a>$b)?$a:$b);
} else
{
	$RELATIVE_PATH='';
}
@chdir($FILE_BASE);

global $NON_PAGE_SCRIPT;
$NON_PAGE_SCRIPT=1;
global $FORCE_INVISIBLE_GUEST;
$FORCE_INVISIBLE_GUEST=0;
if (!is_file($FILE_BASE.'/sources/global.php')) exit('<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">'.chr(10).'<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="EN" lang="EN"><head><title>Critical startup error</title></head><body><h1>ocPortal startup error</h1><p>The second most basic ocPortal startup file, sources/global.php, could not be located. This is almost always due to an incomplete upload of the ocPortal system, so please check all files are uploaded correctly.</p><p>Once all ocPortal files are in place, ocPortal must actually be installed by running the installer. You must be seeing this message either because your system has become corrupt since installation, or because you have uploaded some but not all files from our manual installer package: the quick installer is easier, so you might consider using that instead.</p><p>ocProducts maintains full documentation for all procedures and tools, especially those for installation. These may be found on the <a href="http://ocportal.com">ocPortal website</a>. If you are unable to easily solve this problem, we may be contacted from our website and can help resolve it for you.</p><hr /><p style="font-size: 0.8em">ocPortal is a website engine created by ocProducts.</p></body></html>'); require($FILE_BASE.'/sources/global.php');

// Put code that you temporarily want executed into the function. DELETE THE CODE WHEN YOU'RE DONE.
// This is useful when performing quick and dirty upgrades (e.g. adding tables to avoid a reinstall)

require_code('database_action');
require_code('config2');
require_code('menus2');
$out=execute_temp();
if (!headers_sent())
{
	header('Content-Type: text/plain');
	@ini_set('ocproducts.xss_detect','0');
	if (!is_null($out)) echo is_object($out)?$out->evaluate():(is_bool($out)?($out?'true':'false'):$out);
	echo do_lang('SUCCESS');
}

/**
 * Execute some temporary code put into this function.
 *
 * @return  mixed		Arbitrary result to output, if no text has already gone out
 */
function execute_temp()
{
	$time_now=time();
	$last_cron_time=intval(get_value('last_welcome_mail_time'));
	if ($last_cron_time==0) $last_cron_time=time()-24*60*60*7;
	set_value('last_welcome_mail_time',strval($time_now));

	require_code('mail');

	$GLOBALS['NO_DB_SCOPE_CHECK']=true;
	$mails=$GLOBALS['SITE_DB']->query_select('f_welcome_emails',array('*'));
	$GLOBALS['NO_DB_SCOPE_CHECK']=false;
	foreach ($mails as $mail)
	{
		$send_seconds_after_joining=$mail['w_send_time']*60*60;

		$newsletter_style=((get_value('welcome_nw_choice')==='1') && (!is_null($mail['w_newsletter']))) || ((get_value('welcome_nw_choice')!=='1') && (($mail['w_newsletter']==1) || (get_forum_type()!='ocf')));
		if ($newsletter_style)
		{
			if (addon_installed('newsletter'))
			{
				// Think of it like this, m_join_time (members join time) must between $last_cron_time and $time_now, but offset back by $send_seconds_after_joining
				$where=' WHERE join_time>'.strval($last_cron_time-$send_seconds_after_joining).' AND join_time<='.strval($time_now-$send_seconds_after_joining).' AND (the_level=3 OR the_level=4)';
				if (get_value('welcome_nw_choice')==='1')
				{
					$where.=' AND newsletter_id='.strval($mail['w_newsletter']);
				}
				$members=$GLOBALS['SITE_DB']->query('SELECT join_time,s.email AS m_email_address,the_password,n_forename,n_surname,n.id FROM '.get_table_prefix().'newsletter_subscribe s JOIN '.get_table_prefix().'newsletter n ON n.email=s.email '.$where.' GROUP BY s.email');
			} else
			{
				$members=array();
			}
		} else
		{
			// Think of it like this, m_join_time (members join time) must between $last_cron_time and $time_now, but offset back by $send_seconds_after_joining
			$where=' WHERE m_join_time>'.strval($last_cron_time-$send_seconds_after_joining).' AND m_join_time<='.strval($time_now-$send_seconds_after_joining);
			if (get_option('allow_email_from_staff_disable')=='1') $where.=' AND m_allow_emails=1';
			$query='SELECT m_email_address,m_username,id FROM '.get_table_prefix().'f_members'.$where;
			$members=$GLOBALS['FORUM_DB']->query($query);
		}
var_dump($members);exit('!'.strval($last_cron_time-$send_seconds_after_joining));
		foreach ($members as $member)
		{
			$subject=get_translated_text($mail['w_subject'],NULL,get_lang($member['id']));
			$text=get_translated_text($mail['w_text'],NULL,get_lang($member['id']));
			$_text=do_template('NEWSLETTER_DEFAULT',array('CONTENT'=>$text,'LANG'=>get_site_default_lang()));
			for ($i=0;$i<100;$i++)
			{
				if (strpos($text,'{{'.strval($i).'}}')!==false)
					$text=str_replace('{{'.strval($i).'}}',get_timezoned_date(time()+$i*60*60*24),$text);
			}

			if ($member['m_email_address']!='')
			{
				$message=$_text->evaluate(get_lang($member['id']));
				
				if ($newsletter_style)
				{
					$forename=$member['n_forename'];
					$surname=$member['n_surname'];
					$name=trim($forename.' '.$surname);
					require_lang('newsletter');
					if ($name=='') $name=do_lang('NEWSLETTER_SUBSCRIBER',get_site_name());
				} else
				{
					$forename='';
					$surname='';
					$name=$member['m_username'];
				}

				if (addon_installed('newsletter'))
				{
					if ($newsletter_style)
					{
						$sendid='n'.strval($member['id']);
						$hash=best_hash($member['the_password'],'xunsub');
					} else
					{
						$sendid='w'.strval('id');
						$hash='';
					}

					require_code('newsletter');
					$message=newsletter_variable_substitution($message,$subject,$forename,$surname,$name,$member['m_email_address'],$sendid,$hash);
				}
			//	mail_wrap($subject,$message,array($member['m_email_address']),$name,'','',3,NULL,false,NULL,true);
			}
		}
	}
}
