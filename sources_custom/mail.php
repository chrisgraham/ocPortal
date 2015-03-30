<?php

/* Requires PHP5 */

/**
 * Attempt to send an e-mail to the specified recipient. The mail will be forwarding to the CC address specified in the options (if there is one, and if not specified not to cc).
 * The mail will be sent in dual HTML/text format, where the text is the unconverted comcode source: if a member does not read HTML mail, they may wish to fallback to reading that.
 *
 * @param  string			The subject of the mail in plain text
 * @param  LONG_TEXT		The message, as Comcode
 * @param  ?array			The destination (recipient) e-mail addresses [array of strings] (NULL: site staff address)
 * @param  ?mixed			The recipient name. Array or string. (NULL: site name)
 * @param  EMAIL			The from address (blank: site staff address)
 * @param  string			The from name (blank: site name)
 * @param  integer		The message priority (1=urgent, 3=normal, 5=low)
 * @range  1 5
 * @param  ?array			An list of attachments (each attachment being a map, path=>filename) (NULL: none)
 * @param  boolean		Whether to NOT CC to the CC address
 * @param  ?MEMBER		Convert comcode->tempcode as this member (a privilege thing: we don't want people being able to use admin rights by default!) (NULL: guest)
 * @param  boolean		Replace above with arbitrary admin
 * @param  boolean		HTML-only
 * @param  boolean		Whether to bypass queueing, because this code is running as a part of the queue management tools
 * @param  ID_TEXT		The template used to show the email
 * @param  boolean		Whether to bypass queueing
 * @return ?tempcode		A full page (not complete XHTML) piece of tempcode to output (NULL: it worked so no tempcode message)
 */
function mail_wrap($subject_line,$message_raw,$to_email=NULL,$to_name=NULL,$from_email='',$from_name='',$priority=3,$attachments=NULL,$no_cc=false,$as=NULL,$as_admin=false,$in_html=false,$coming_out_of_queue=false,$mail_template='MAIL',$bypass_queue=false)
{
	if (get_option('smtp_sockets_use')=='0') return non_overrided__mail_wrap($subject_line,$message_raw,$to_email,$to_name,$from_email,$from_name,$priority,$attachments,$no_cc,$as,$as_admin,$in_html,$coming_out_of_queue);

	if (running_script('stress_test_loader')) return NULL;

	if (@$GLOBALS['SITE_INFO']['no_email_output']==='1') return NULL;

	if (is_null($bypass_queue))
	{
		$bypass_queue=(($priority<3) || (strpos(serialize($attachments),'tmpfile')!==false));
	}

	global $EMAIL_ATTACHMENTS;
	$EMAIL_ATTACHMENTS=array();

	require_code('site');
	require_code('mime_types');

	if (is_null($as)) $as=$GLOBALS['FORUM_DRIVER']->get_guest_id();

	if (!$coming_out_of_queue)
	{
		if (!$GLOBALS['SITE_DB']->table_is_locked('logged_mail_messages'))
			$GLOBALS['SITE_DB']->query('DELETE FROM '.get_table_prefix().'logged_mail_messages WHERE m_date_and_time<'.strval(time()-60*60*24*14).' AND m_queued=0'); // Log it all for 2 weeks, then delete

		$through_queue=(!$bypass_queue) && ((get_option('mail_queue_debug')==='1') || ((get_option('mail_queue')==='1') && (cron_installed())));

		$GLOBALS['SITE_DB']->query_insert('logged_mail_messages',array(
			'm_subject'=>$subject_line,
			'm_message'=>$message_raw,
			'm_to_email'=>serialize($to_email),
			'm_to_name'=>serialize($to_name),
			'm_from_email'=>$from_email,
			'm_from_name'=>$from_name,
			'm_priority'=>3,
			'm_attachments'=>serialize($attachments),
			'm_no_cc'=>$no_cc?1:0,
			'm_as'=>$as,
			'm_as_admin'=>$as_admin?1:0,
			'm_in_html'=>$in_html?1:0,
			'm_date_and_time'=>time(),
			'm_member_id'=>get_member(),
			'm_url'=>get_self_url(true),
			'm_queued'=>$through_queue?1:0,
			'm_template'=>$mail_template,
		));

		if ($through_queue) return NULL;
	}

	if (count($attachments)==0) $attachments=NULL;

	global $SENDING_MAIL;
	if ($SENDING_MAIL) return NULL;
	$SENDING_MAIL=true;

	// To and from, and language
	$staff_address=get_option('staff_address');
	if (is_null($to_email)) $to_email=array($staff_address);
	$to_email_new=array();
	foreach ($to_email as $test_address)
	{
		if ($test_address!='') $to_email_new[]=$test_address;
	}
	$to_email=$to_email_new;
	if ($to_email==array())
	{
		$SENDING_MAIL=false;
		return NULL;
	}
	if ($to_email[0]==$staff_address)
	{
		$lang=get_site_default_lang();
	} else
	{
		$lang=user_lang();
		if (method_exists($GLOBALS['FORUM_DRIVER'],'get_member_from_email_address'))
		{
			$member_id=$GLOBALS['FORUM_DRIVER']->get_member_from_email_address($to_email[0]);
			if (!is_null($member_id))
			{
				$lang=get_lang($member_id);
			}
		}
	}
	if (is_null($to_name))
	{
		if ($to_email[0]==$staff_address)
		{
			$to_name=get_site_name();
		} else
		{
			$to_name='';
		}
	}
	if ($from_email=='') $from_email=get_option('staff_address');
	if ($from_name=='') $from_name=get_site_name();

	ocp_profile_start_for('mail_wrap');

	$theme=method_exists($GLOBALS['FORUM_DRIVER'],'get_theme')?$GLOBALS['FORUM_DRIVER']->get_theme():'default';
	if ($theme=='default') // Sucks, probably due to sending from Admin Zone...
	{
		$theme=$GLOBALS['FORUM_DRIVER']->get_theme(''); // ... So get theme of welcome zone
	}

	// Our subject
	$_subject=do_template('MAIL_SUBJECT',array('_GUID'=>'4c7eefb7296e7b7d4f3a4ef0eeeca658','SUBJECT_LINE'=>$subject_line),$lang,false,NULL,'.tpl','templates',$theme);
	$subject=$_subject->evaluate($lang); // Note that this is slightly against spec, because characters aren't forced to be printable us-ascii. But it's better we allow this (which works in practice) than risk incompatibility via charset-base64 encoding.

	// Evaluate message. Needs doing early so we know if we have any headers

	// Misc settings
	$website_email=get_option('website_email');
	if ($website_email=='') $website_email=$from_email;
	$cc_address=$no_cc?'':get_option("cc_address");

	global $CID_IMG_ATTACHMENT;
	$CID_IMG_ATTACHMENT=array();

	// Decide message
	$GLOBALS['NO_LINK_TITLES']=true;
	global $LAX_COMCODE;
	$temp=$LAX_COMCODE;
	$LAX_COMCODE=true;
	$html_content=comcode_to_tempcode($message_raw,$as,$as_admin);
	$LAX_COMCODE=$temp;
	$GLOBALS['NO_LINK_TITLES']=false;
	if (!$in_html)
	{
		$_html_content=$html_content->evaluate($lang);
		$_html_content=preg_replace('#(keep|for)_session=[\d\w]*#','filtered=1',$_html_content);
		$message_html=(strpos($_html_content,'<html')!==false)?make_string_tempcode($_html_content):do_template($mail_template,array('_GUID'=>'b23069c20202aa59b7450ebf8d49cde1','CSS'=>'{CSS}','LOGOURL'=>get_logo_url(''),/*'LOGOMAP'=>get_option('logo_map'),*/'LANG'=>$lang,'TITLE'=>$subject,'CONTENT'=>$_html_content),$lang,false,NULL,'.tpl','templates',$theme);
		$css=css_tempcode(true,true,$message_html->evaluate($lang),$theme);
		$_css=$css->evaluate($lang);
		if (get_option('allow_ext_images')!='1')
		{
			$_css=preg_replace_callback('#url\(["\']?(http://[^"]*)["\']?\)#U','_mail_css_rep_callback',$_css);
		}
		$html_evaluated=$message_html->evaluate($lang);
		$html_evaluated=str_replace('{CSS}',$_css,$html_evaluated);

		// Cleanup the Comcode a bit
		$message_plain=comcode_to_clean_text($message_raw);
	} else
	{
		$html_evaluated=$message_raw;
	}

	// Character set
	$regexp='#^[\x'.dechex(32).'-\x'.dechex(126).']*$#';
	$charset=((preg_match($regexp,$html_evaluated)==0)?do_lang('charset',NULL,NULL,NULL,$lang):'us-ascii');

	// CID attachments
	if (get_option('allow_ext_images')!='1')
	{
		$html_evaluated=preg_replace_callback('#<img\s([^>]*)src="(http://[^"]*)"#U','_mail_img_rep_callback',$html_evaluated);
		$matches=array();
		foreach (array('#<([^"<>]*\s)style="([^"]*)"#','#<style( [^<>]*)?'.'>(.*)</style>#Us') as $over)
		{
			$num_matches=preg_match_all($over,$html_evaluated,$matches);
			for ($i=0;$i<$num_matches;$i++)
			{
				$altered_inner=preg_replace_callback('#url\(["\']?(http://[^"]*)["\']?\)#U','_mail_css_rep_callback',$matches[2][$i]);
				if ($matches[2][$i]!=$altered_inner)
				{
					$altered_outer=str_replace($matches[2][$i],$altered_inner,$matches[0][$i]);
					$html_evaluated=str_replace($matches[0][$i],$altered_outer,$html_evaluated);
				}
			}
		}
	}
	$cid_attachments=array();
	foreach ($CID_IMG_ATTACHMENT as $id=>$img)
	{
		$file_path_stub=convert_url_to_path($img);
		$mime_type=get_mime_type(get_file_extension($img));
		$filename=basename($img);

		if (!is_null($file_path_stub))
		{
			$cid_attachment=array(
				'mime'=>$mime_type,
				'filename'=>$filename,
				'path'=>$file_path_stub,
				'temp'=>false,
				'cid'=>$id,
			);
		} else
		{
			$myfile=mixed();
			$matches=array();
			if ((preg_match('#^'.preg_quote(find_script('attachment'),'#').'\?id=(\d+)&amp;thumb=(0|1)#',$img,$matches)!=0) && (strpos($img,'forum_db=1')===false))
			{
				$rows=$GLOBALS['SITE_DB']->query_select('attachments',array('*'),array('id'=>intval($matches[1])),'ORDER BY a_add_time DESC');
				require_code('attachments');
				if ((array_key_exists(0,$rows)) && (has_attachment_access($as,intval($matches[1]))))
				{
					$myrow=$rows[0];

					if ($matches[2]=='1')
					{
						$full=$myrow['a_thumb_url'];
					}
					else
					{
						$full=$myrow['a_url'];
					}

					if (url_is_local($full))
					{
						$_full=get_custom_file_base().'/'.rawurldecode($full);
						if (file_exists($_full))
						{
							$filename=$myrow['a_original_filename'];
							require_code('mime_types');
							$myfile=$_full;
							$mime_type=get_mime_type(get_file_extension($filename));
						} else
						{
							continue;
						}
					}
				}
			}
			if ($myfile===NULL)
			{
				$myfile=ocp_tempnam('email_attachment');
				http_download_file($img,NULL,false,false,'ocPortal',NULL,NULL,NULL,NULL,NULL,$myfile);
				if (is_null($file_contents)) continue;
				if (!is_null($GLOBALS['HTTP_DOWNLOAD_MIME_TYPE'])) $mime_type=$GLOBALS['HTTP_DOWNLOAD_MIME_TYPE'];
				if (!is_null($GLOBALS['HTTP_FILENAME'])) $filename=$GLOBALS['HTTP_FILENAME'];
			}

			$cid_attachment=array(
				'mime'=>$mime_type,
				'filename'=>$filename,
				'path'=>$myfile,
				'temp'=>true,
				'cid'=>$id,
			);
		}

		$cid_attachments[]=$cid_attachment;
	}

	// Attachments
	$real_attachments=array();
	$attachments=array_merge(is_null($attachments)?array():$attachments,$EMAIL_ATTACHMENTS);
	if (!is_null($attachments))
	{
		foreach ($attachments as $path=>$filename)
		{
			$mime_type=get_mime_type(get_file_extension($filename));

			if (strpos($path,'://')===false)
			{
				$real_attachment=array(
					'mime'=>$mime_type,
					'filename'=>$filename,
					'path'=>$path,
					'temp'=>false,
				);
			} else
			{
				$myfile=ocp_tempnam('email_attachment');
				http_download_file($path,NULL,false,false,'ocPortal',NULL,NULL,NULL,NULL,NULL,$myfile);
				if (!is_null($GLOBALS['HTTP_DOWNLOAD_MIME_TYPE'])) $mime_type=$GLOBALS['HTTP_DOWNLOAD_MIME_TYPE'];
				if (!is_null($GLOBALS['HTTP_FILENAME'])) $filename=$GLOBALS['HTTP_FILENAME'];

				$real_attachment=array(
					'mime'=>$mime_type,
					'filename'=>$filename,
					'path'=>$myfile,
					'temp'=>true,
				);
			}

			$real_attachments[]=$real_attachment;
		}
	}

	// ==========================
	// Interface with SwiftMailer
	// ==========================

	require_code('Swift-4.1.1/lib/swift_required');

	// Read in SMTP settings
	$host=get_option('smtp_sockets_host');
	$port=intval(get_option('smtp_sockets_port'));
	$username=get_option('smtp_sockets_username');
	$password=get_option('smtp_sockets_password');
	$smtp_from_address=get_option('smtp_from_address');
	if ($smtp_from_address!='') $from_email=$smtp_from_address;

	// Create the Transport
	$transport=Swift_SmtpTransport::newInstance($host,$port)
		->setUsername($username)
		->setPassword($password);
	if (($port==419) || ($port==465) || ($port==587))
		$transport->setEncryption('tls');

	// Create the Mailer using your created Transport
	$mailer=Swift_Mailer::newInstance($transport);

	// Create a message
	$to_array=array();
	if ($to_name==='')
	{
		foreach ($to_email as $_to_email)
		{
			$to_array[]=$_to_email;
		}
	} else
	{
		foreach ($to_email as $i=>$_to_email)
		{
			$to_array[$_to_email]=is_array($to_name)?$to_name[$i]:$to_name;
		}
	}
	$message=Swift_Message::newInstance($subject)
		->setFrom(array($website_email=>$from_name))
		->setReplyTo(array($from_email=>$from_name))
		->setTo($to_array)
		->setDate(time())
		->setPriority($priority)
		->setCharset($charset)
		->setBody($html_evaluated,'text/html',$charset)
		->addPart($message_plain,'text/plain',$charset)
		;
	if ($cc_address!='') $message->setCc($cc_address);

	// Attachments
	foreach ($real_attachments as $r)
	{
		$attachment=Swift_Attachment::fromPath($r['path'],$r['mime'])->setFilename($r['filename'])->setDisposition('attachment');
		$message->attach($attachment);
	}
	foreach ($cid_attachments as $r)
	{
		$attachment=Swift_Attachment::fromPath($r['path'],$r['mime'])->setFilename($r['filename'])->setDisposition('attachment')->setId($r['cid']);
		$message->attach($attachment);
	}

	// Send the message, and error collection
	$error='';
	try
	{
		$result=$mailer->send($message);
	}
	catch (Exception $e)
	{
		$error=$e->getMessage();
	}
	if (($error=='') && (!$result)) $error='Unknown error';

	// Attachment cleanup
	foreach ($real_attachments as $r)
	{
		if ($r['temp']) @unlink($r['path']);
	}
	foreach ($cid_attachments as $r)
	{
		if ($r['temp']) @unlink($r['path']);
	}

	ocp_profile_end_for('mail_wrap',$subject_line);

	// Return / Error handling
	$SENDING_MAIL=false;
	if ($error!='')
	{
		if (get_param_integer('keep_hide_mail_failure',0)==0)
		{
			require_code('site');
			attach_message(!is_null($error)?make_string_tempcode($error):do_lang_tempcode('MAIL_FAIL',escape_html(get_option('staff_address'))),'warn');
		} else
		{
			return warn_screen(get_screen_title('ERROR_OCCURRED'),do_lang_tempcode('MAIL_FAIL',escape_html(get_option('staff_address'))));
		}
	}
	return NULL;
}
