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
 * @package		newsletter
 */

/**
 * Add to the newsletter, in the simplest way.
 *
 * @param  EMAIL				The email address of the subscriber
 * @param  integer			The interest level
 * @range  1 4
 * @param  ?LANGUAGE_NAME	The language (NULL: users)
 * @param  boolean			Whether to require a confirmation mail
 * @param  ?AUTO_LINK		The newsletter to join (NULL: the first)
 * @param  string				Subscribers forename
 * @param  string				Subscribers surname
 * @return string				Newsletter password
 */
function basic_newsletter_join($email,$interest_level=4,$lang=NULL,$get_confirm_mail=false,$newsletter_id=NULL,$forename='',$surname='')
{
	if (is_null($lang)) $lang=user_lang();
	if (is_null($newsletter_id)) $newsletter_id=db_get_first_id();

	$password=get_rand_password();
	$code_confirm=$get_confirm_mail?mt_rand(1,9999999):0;
	$test=$GLOBALS['SITE_DB']->query_value_null_ok('newsletter_subscribe','the_level',array('newsletter_id'=>$newsletter_id,'email'=>$email));
	if ($test===0)
	{
		$GLOBALS['SITE_DB']->query_delete('newsletter_subscribe',array('newsletter_id'=>$newsletter_id,'email'=>$email),'',1);
		$test=NULL;
	}
	if (is_null($test))
	{
		require_lang('newsletter');

		$test=$GLOBALS['SITE_DB']->query_value_null_ok('newsletter','email',array('email'=>$email));
		if (is_null($test))
		{
			$salt=produce_salt();
			$GLOBALS['SITE_DB']->query_insert('newsletter',array('n_forename'=>$forename,'n_surname'=>$surname,'join_time'=>time(),'email'=>$email,'code_confirm'=>$code_confirm,'pass_salt'=>$salt,'the_password'=>md5($password.$salt),'language'=>$lang),false,true); // race condition

			if ($get_confirm_mail)
			{
				$_url=build_url(array('page'=>'newsletter','type'=>'confirm','email'=>$email,'confirm'=>$code_confirm),get_module_zone('newsletter'));
				$url=$_url->evaluate();
				$message=do_lang('NEWSLETTER_SIGNUP_TEXT',comcode_escape($url),comcode_escape($password),array($forename,$surname,$email,get_site_name()),$lang);
				require_code('mail');
				mail_wrap(do_lang('NEWSLETTER_SIGNUP',NULL,NULL,NULL,$lang),$message,array($email));
			}
		} else
		{
			$GLOBALS['SITE_DB']->query_update('newsletter',array('join_time'=>time()),array('email'=>$email),'',1);
			$password='';
		}
		$GLOBALS['SITE_DB']->query_insert('newsletter_subscribe',array('newsletter_id'=>$newsletter_id,'the_level'=>$interest_level,'email'=>$email),false,true); // race condition

		return $password;
	}

	return do_lang('NA');
}

/**
 * Send out the newsletter.
 *
 * @param  LONG_TEXT			The newsletter message
 * @param  SHORT_TEXT		The newsletter subject
 * @param  LANGUAGE_NAME	The language
 * @param  array				A map describing what newsletters and newsletter levels the newsletter is being sent to
 * @param  BINARY				Whether to only send in HTML format
 * @param  string				Override the email address the mail is sent from (blank: staff address)
 * @param  string				Override the name the mail is sent from (blank: site name)
 * @param  integer			The message priority (1=urgent, 3=normal, 5=low)
 * @range  1 5
 * @param  string				CSV data of extra subscribers (blank: none). This is in the same ocPortal newsletter CSV format that we export elsewhere.
 * @param  ID_TEXT			The template used to show the email
 */
function actual_send_newsletter($message,$subject,$lang,$send_details,$html_only=0,$from_email='',$from_name='',$priority=3,$csv_data='',$mail_template='MAIL')
{
	require_lang('newsletter');

	// Put in archive
	$GLOBALS['SITE_DB']->query_insert('newsletter_archive',array('date_and_time'=>time(),'subject'=>$subject,'newsletter'=>$message,'language'=>$lang,'importance_level'=>1));

	// Mark as done
	log_it('NEWSLETTER_SEND',$subject);
	set_value('newsletter_send_time',strval(time()));

	// Schedule the background send
	require_code('mail');
	if (function_exists('set_time_limit')) @set_time_limit(0);

	global $NEWSLETTER_SUBJECT,$NEWSLETTER_MESSAGE,$NEWSLETTER_HTML_ONLY,$NEWSLETTER_FROM_EMAIL,$NEWSLETTER_FROM_NAME,$NEWSLETTER_PRIORITY,$NEWSLETTER_SEND_DETAILS,$NEWSLETTER_LANGUAGE,$NEWSLETTER_MAIL_TEMPLATE,$CSV_DATA;
	$NEWSLETTER_SUBJECT=$subject;
	$NEWSLETTER_MESSAGE=$message;
	$NEWSLETTER_HTML_ONLY=$html_only;
	$NEWSLETTER_FROM_EMAIL=$from_email;
	$NEWSLETTER_FROM_NAME=$from_name;
	$NEWSLETTER_PRIORITY=$priority;
	$NEWSLETTER_SEND_DETAILS=$send_details;
	$NEWSLETTER_LANGUAGE=$lang;
	$NEWSLETTER_MAIL_TEMPLATE=$mail_template;
	$CSV_DATA=$csv_data;

	if (get_param_integer('keep_send_immediately',0)==1) newsletter_shutdown_function(); else register_shutdown_function('newsletter_shutdown_function');
}

/**
 * Find a group of members the newsletter will go to.
 *
 * @param  array				A map describing what newsletters and newsletter levels the newsletter is being sent to
 * @param  LANGUAGE_NAME	The language
 * @param  integer			Start position in result set (results are returned in parallel for each category of result)
 * @param  integer			Maximum records to return from each category
 * @param  boolean			Whether to get raw rows rather than mailer-ready correspondance lists
 * @param  string				Serialized CSV data to also consider
 * @return array				Returns a tuple of corresponding detail lists, emails,hashes,usernames,forenames,surnames,ids, and a record count for levels (depending on requests: csv, 1, <newsletterID>, g<groupID>) [record counts not returned if $start is not zero, for performance reasons]
 */
function newsletter_who_send_to($send_details,$lang,$start,$max,$get_raw_rows=false,$csv_data='')
{
	// Find who to send to
	$level=0;
	$usernames=array();
	$forenames=array();
	$surnames=array();
	$emails=array();
	$ids=array();
	$hashes=array();
	$total=array();
	$raw_rows=array();

	// Standard newsletter subscribers
	$newsletters=$GLOBALS['SITE_DB']->query_select('newsletters',array('*'));
	foreach ($newsletters as $newsletter)
	{
		$this_level=array_key_exists(strval($newsletter['id']),$send_details)?$send_details[strval($newsletter['id'])]:0;
		if ($this_level!=0)
		{
			$where_lang=multi_lang()?(db_string_equal_to('language',$lang).' AND '):'';
			$query=' FROM '.get_table_prefix().'newsletter_subscribe s LEFT JOIN '.get_table_prefix().'newsletter n ON n.email=s.email WHERE '.$where_lang.'code_confirm=0 AND s.newsletter_id='.strval($newsletter['id']).' AND the_level>='.strval((integer)$this_level);
			$temp=$GLOBALS['SITE_DB']->query('SELECT n.id,n.email,the_password,n_forename,n_surname'.$query,$max,$start);
			if ($start==0)
			{
				$test=$GLOBALS['SITE_DB']->query_value_null_ok_full('SELECT COUNT(*) FROM '.get_table_prefix().'newsletter_subscribe WHERE newsletter_id='.strval($newsletter['id']).' AND the_level>='.strval((integer)$this_level));
				if ($test>10000) // Inaccurace, for performance reasons
				{
					$total[strval($newsletter['id'])]=$test;
				} else
				{
					$total[strval($newsletter['id'])]=$GLOBALS['SITE_DB']->query_value_null_ok_full('SELECT COUNT(*)'.$query);
				}
			}
			foreach ($temp as $_temp)
			{
				if (!in_array($_temp['email'],$emails)) // If not already added
				{
					if (!$get_raw_rows)
					{
						$emails[]=$_temp['email'];
						$forenames[]=$_temp['n_forename'];
						$surnames[]=$_temp['n_surname'];
						$username=trim($_temp['n_forename'].' '.$_temp['n_surname']);
						if ($username=='') $username=do_lang('NEWSLETTER_SUBSCRIBER',get_site_name());
						$usernames[]=$username;
						$ids[]='n'.strval($_temp['id']);
						$hashes[]=best_hash($_temp['the_password'],'xunsub');
					} else
					{
						$raw_rows[]=$_temp;
					}
				}
			}
		}
		$level=max($level,$this_level);
	}

	// OCF imports
	if (get_forum_type()=='ocf')
	{
		$where_lang=multi_lang()?('('.db_string_equal_to('m_language',$lang).' OR '.db_string_equal_to('m_language','').') AND '):'';

		// Usergroups
		$groups=$GLOBALS['FORUM_DRIVER']->get_usergroup_list();
		foreach ($send_details as $_id=>$is_on)
		{
			if ((is_string($_id)) && (substr($_id,0,1)=='g') && ($is_on==1))
			{
				$id=intval(substr($_id,1));
				global $SITE_INFO;
				if (((isset($SITE_INFO['mysql_old'])) && ($SITE_INFO['mysql_old']=='1')) || ((!isset($SITE_INFO['mysql_old'])) && (is_file(get_file_base().'/mysql_old'))))
				{
					$query='SELECT xxxxx FROM '.$GLOBALS['FORUM_DB']->get_table_prefix().'f_members m LEFT JOIN '.$GLOBALS['FORUM_DB']->get_table_prefix().'f_group_members g ON m.id=g.gm_member_id AND g.gm_validated=1 WHERE '.db_string_not_equal_to('m_email_address','').' AND '.$where_lang.'m_validated=1 AND (gm_group_id='.strval($id).' OR m_primary_group='.strval($id).')';
					if (get_option('allow_email_from_staff_disable')=='1') $query.=' AND m_allow_emails=1';
					$query.=' AND m_is_perm_banned=0';
				} else
				{
					$query='SELECT xxxxx  FROM '.$GLOBALS['FORUM_DB']->get_table_prefix().'f_members m LEFT JOIN '.$GLOBALS['FORUM_DB']->get_table_prefix().'f_group_members g ON m.id=g.gm_member_id AND g.gm_validated=1 WHERE '.db_string_not_equal_to('m_email_address','').' AND '.$where_lang.'m_validated=1 AND gm_group_id='.strval($id);
					if (get_option('allow_email_from_staff_disable')=='1') $query.=' AND m_allow_emails=1';
					$query.=' AND m_is_perm_banned=0';
					$query.=' UNION SELECT xxxxx FROM '.$GLOBALS['FORUM_DB']->get_table_prefix().'f_members m WHERE '.db_string_not_equal_to('m_email_address','').' AND '.$where_lang.'m_validated=1 AND m_primary_group='.strval($id);
					if (get_option('allow_email_from_staff_disable')=='1') $query.=' AND m_allow_emails=1';
					$query.=' AND m_is_perm_banned=0';
				}
				$_rows=$GLOBALS['FORUM_DB']->query(str_replace('xxxxx','m.id,m.m_email_address,m.m_username',$query),$max,$start,false,true);
				if ($start==0)
					$total['g'.strval($id)]=$GLOBALS['FORUM_DB']->query_value_null_ok_full('SELECT ('.str_replace(' UNION ',') + (',str_replace('xxxxx','COUNT(*)',$query)).')',false,true);

				foreach ($_rows as $row) // For each member
				{
					if (!in_array($row['m_email_address'],$emails)) // If not already added
					{
						if (!$get_raw_rows)
						{
							$emails[]=$row['m_email_address'];
							$forenames[]='';
							$surnames[]='';
							$usernames[]=$row['m_username'];
							$ids[]='m'.strval($row['id']);
							$hashes[]='';
						} else
						{
							$raw_rows[]=$row;
						}
					}
				}
			}
		}

		// *All* OCF members (we could have chosen all usergroups, but for legacy reasons we still have this option)
		if (array_key_exists('-1',$send_details)?$send_details['-1']:0==1)
		{
			$query=' FROM '.$GLOBALS['FORUM_DB']->get_table_prefix().'f_members WHERE '.db_string_not_equal_to('m_email_address','').' AND '.$where_lang.'m_validated=1';
			if (get_option('allow_email_from_staff_disable')=='1') $query.=' AND m_allow_emails=1';
			$query.=' AND m_is_perm_banned=0';
			$_rows=$GLOBALS['FORUM_DB']->query('SELECT id,m_email_address,m_username'.$query,$max,$start);
			if ($start==0)
				$total['-1']=$GLOBALS['FORUM_DB']->query_value_null_ok_full('SELECT COUNT(*)'.$query);
			foreach ($_rows as $_temp)
			{
				if (!in_array($_temp['m_email_address'],$emails)) // If not already added
				{
					if (!$get_raw_rows)
					{
						$emails[]=$_temp['m_email_address'];
						$forenames[]='';
						$surnames[]='';
						$usernames[]=$_temp['m_username'];
						$ids[]='m'.strval($_temp['id']);
						$hashes[]='';
					} else
					{
						$raw_rows[]=$_temp;
					}
				}
			}
		}
	}

	// From CSV
	if ($csv_data!='')
	{
		secure_serialized_data($csv_data,array());
		$_csv_data=unserialize($csv_data);

		$email_index=0;
		$forename_index=1;
		$surname_index=2;
		$username_index=3;
		$id_index=4;
		$hash_index=5;

		if ($start==0)
			$total['csv']=0;

		$pos=0;
		foreach ($_csv_data as $i=>$csv_line)
		{
			if (($i<=1) && (count($csv_line)>=1) && (isset($csv_line[0])) && (strpos($csv_line[0],'@')===false) && (isset($csv_line[1])) && (strpos($csv_line[1],'@')===false))
			{
				foreach ($csv_line as $j=>$val)
				{
					if (in_array(strtolower($val),array('e-mail','email','email address','e-mail address'))) $email_index=$j;
					if (in_array(strtolower($val),array('forename','forenames','first name'))) $forename_index=$j;
					if (in_array(strtolower($val),array('surname','surnames','last name'))) $surname_index=$j;
					if (in_array(strtolower($val),array('username'))) $username_index=$j;
					if (in_array(strtolower($val),array('id','identifier'))) $id_index=$j;
					if (in_array(strtolower($val),array('hash','password','pass','code','secret'))) $hash_index=$j;
				}
				continue;
			}

			if ((count($csv_line)>=1) && (!is_null($csv_line[$email_index])) && (strpos($csv_line[$email_index],'@')!==false))
			{
				if (($pos>=$start) && ($pos-$start<$max))
				{
					if (!$get_raw_rows)
					{
						$emails[]=$csv_line[$email_index];
						$forenames[]=array_key_exists($forename_index,$csv_line)?$csv_line[$forename_index]:'';
						$surnames[]=array_key_exists($surname_index,$csv_line)?$csv_line[$surname_index]:'';
						$usernames[]=array_key_exists($username_index,$csv_line)?$csv_line[$username_index]:'';
						$ids[]=array_key_exists($id_index,$csv_line)?$csv_line[$id_index]:'';
						$hashes[]=array_key_exists($hash_index,$csv_line)?$csv_line[$hash_index]:'';
					} else
					{
						$raw_rows[]=$csv_line;
					}
				}
				if ($start==0)
					$total['csv']++;

				$pos++;
			}
		}
	}
	return array($emails,$hashes,$usernames,$forenames,$surnames,$ids,$total,$raw_rows);
}

/**
 * Sub in newsletter variables.
 *
 * @param  string				The original newsletter message
 * @param  SHORT_TEXT		The newsletter subject
 * @param  SHORT_TEXT		Subscribers forename (blank: unknown)
 * @param  SHORT_TEXT		Subscribers surname (blank: unknown)
 * @param  SHORT_TEXT		Subscribers name (or username)
 * @param  EMAIL				Subscribers email address
 * @param  ID_TEXT			Specially encoded ID of subscriber (begins either 'n' for newsletter subscriber, or 'm' for member - then has normal subscriber/member ID following)
 * @param  SHORT_TEXT		Double encoded password hash of subscriber (blank: can not unsubscribe by URL)
 * @return string				The new newsletter message
 */
function newsletter_variable_substitution($message,$subject,$forename,$surname,$name,$email_address,$sendid,$hash)
{
	if ($hash=='')
	{
		$unsub_url=build_url(array('page'=>'members','type'=>'view'),get_module_zone('members'),NULL,false,false,true,'tab__edit');
	} else
	{
		$unsub_url=build_url(array('page'=>'newsletter','type'=>'unsub','id'=>substr($sendid,1),'hash'=>$hash),get_module_zone('newsletter'),NULL,false,false,true);
	}

	$member_id=$GLOBALS['FORUM_DRIVER']->get_member_from_username($name);

	$vars=array(
		'title'=>$subject,
		'forename'=>$forename,
		'surname'=>$surname,
		'name'=>$name,
		'member_id'=>is_null($member_id)?'':strval($member_id),
		'email_address'=>$email_address,
		'sendid'=>$sendid,
		'unsub_url'=>$unsub_url,
	);

	foreach ($vars as $var=>$sub)
	{
		$message=str_replace('{'.$var.'}',is_object($sub)?$sub->evaluate():$sub,$message);
		$message=str_replace('{'.$var.'*}',escape_html(is_object($sub)?$sub->evaluate():$sub),$message);
	}

	return $message;
}

/**
 * Actually send out the newsletter in the background.
 */
function newsletter_shutdown_function()
{
	global $NEWSLETTER_SUBJECT,$NEWSLETTER_MESSAGE,$NEWSLETTER_HTML_ONLY,$NEWSLETTER_FROM_EMAIL,$NEWSLETTER_FROM_NAME,$NEWSLETTER_PRIORITY,$NEWSLETTER_SEND_DETAILS,$NEWSLETTER_LANGUAGE,$CSV_DATA,$NEWSLETTER_MAIL_TEMPLATE;

	//mail_wrap($NEWSLETTER_SUBJECT,$NEWSLETTER_MESSAGE,$NEWSLETTER_ADDRESSES,$NEWSLETTER_USERNAMES,$NEWSLETTER_FROM_EMAIL,$NEWSLETTER_FROM_NAME,3,NULL,true,NULL,true,$NEWSLETTER_HTML_ONLY==1);  Not so easy any more as message needs tailoring per subscriber

	disable_php_memory_limit(); // As PHP can leak memory, or caches can fill, even if we do this carefully

	$last_cron=get_value('last_cron');

	$start=0;
	do
	{
		list($addresses,$hashes,$usernames,$forenames,$surnames,$ids,)=newsletter_who_send_to($NEWSLETTER_SEND_DETAILS,$NEWSLETTER_LANGUAGE,$start,100,false,$CSV_DATA);

		// Send to all
		foreach ($addresses as $i=>$email_address)
		{
			// Variable substitution in body
			$newsletter_message_substituted=newsletter_variable_substitution($NEWSLETTER_MESSAGE,$NEWSLETTER_SUBJECT,$forenames[$i],$surnames[$i],$usernames[$i],$email_address,$ids[$i],$hashes[$i]);
			$in_html=false;
			if (strpos($newsletter_message_substituted,'<html')===false)
			{
				if ($NEWSLETTER_HTML_ONLY==1)
				{
					$_m=comcode_to_tempcode($newsletter_message_substituted,get_member(),true);
					$newsletter_message_substituted=$_m->evaluate($NEWSLETTER_LANGUAGE);
					$in_html=true;
				}
			} else
			{
				require_code('tempcode_compiler');
				$_m=template_to_tempcode($newsletter_message_substituted);
				$newsletter_message_substituted=$_m->evaluate($NEWSLETTER_LANGUAGE);
				$in_html=true;
			}

			if (!is_null($last_cron))
			{
				$GLOBALS['SITE_DB']->query_insert('newsletter_drip_send',array(
					'd_inject_time'=>time(),
					'd_subject'=>$NEWSLETTER_SUBJECT,
					'd_message'=>$newsletter_message_substituted,
					'd_html_only'=>$NEWSLETTER_HTML_ONLY,
					'd_to_email'=>$email_address,
					'd_to_name'=>$usernames[$i],
					'd_from_email'=>$NEWSLETTER_FROM_EMAIL,
					'd_from_name'=>$NEWSLETTER_FROM_NAME,
					'd_priority'=>$NEWSLETTER_PRIORITY,
					'd_template'=>$NEWSLETTER_MAIL_TEMPLATE,
				));
			} else
			{
				mail_wrap($NEWSLETTER_SUBJECT,$newsletter_message_substituted,array($email_address),array($usernames[$i]),$NEWSLETTER_FROM_EMAIL,$NEWSLETTER_FROM_NAME,$NEWSLETTER_PRIORITY,NULL,true,NULL,true,$in_html,false,$NEWSLETTER_MAIL_TEMPLATE);
			}
		}
		$start+=100;
	}
	while (array_key_exists(0,$addresses));
}

/**
 * Make a newsletter.
 *
 * @param  SHORT_TEXT	The title
 * @param  LONG_TEXT		The description
 * @return AUTO_LINK		The ID
 */
function add_newsletter($title,$description)
{
	$id=$GLOBALS['SITE_DB']->query_insert('newsletters',array('title'=>insert_lang($title,2),'description'=>insert_lang($description,2)),true);
	log_it('ADD_NEWSLETTER',strval($id),$title);
	return $id;
}

/**
 * Edit a newsletter.
 *
 * @param  AUTO_LINK		The ID
 * @param  SHORT_TEXT	The title
 * @param  LONG_TEXT		The description
 */
function edit_newsletter($id,$title,$description)
{
	$_title=$GLOBALS['SITE_DB']->query_value('newsletters','title',array('id'=>$id));
	$_description=$GLOBALS['SITE_DB']->query_value('newsletters','description',array('id'=>$id));
	$GLOBALS['SITE_DB']->query_update('newsletters',array('title'=>lang_remap($_title,$title),'description'=>lang_remap($_description,$description)),array('id'=>$id),'',1);
	log_it('EDIT_NEWSLETTER',strval($id),$_title);
}

/**
 * Delete a newsletter.
 *
 * @param  AUTO_LINK		The ID
 */
function delete_newsletter($id)
{
	$_title=$GLOBALS['SITE_DB']->query_value('newsletters','title',array('id'=>$id));
	$_description=$GLOBALS['SITE_DB']->query_value('newsletters','description',array('id'=>$id));
	log_it('DELETE_NEWSLETTER',strval($id),get_translated_text($_title));
	$GLOBALS['SITE_DB']->query_delete('newsletters',array('id'=>$id),'',1);
	$GLOBALS['SITE_DB']->query_delete('newsletter_subscribe',array('newsletter_id'=>$id));
	delete_lang($_title);
	delete_lang($_description);
}


