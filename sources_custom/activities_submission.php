<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

/**
 * @license		http://opensource.org/licenses/cpal_1.0 Common Public Attribution License
 * @copyright	ocProducts Ltd
 * @package		activity_feed
 */

/**
 * Syndicate human-intended descriptions of activities performed to the internal wall, and external listeners.
 *
 * @param  string			Language string code
 * @param  string			Label 1 (given as a parameter to the language string code)
 * @param  string			Label 2 (given as a parameter to the language string code)
 * @param  string			Label 3 (given as a parameter to the language string code)
 * @param  string			Page link 1
 * @param  string			Page link 2
 * @param  string			Page link 3
 * @param  string			Addon that caused the event
 * @param  BINARY			Whether this post should be public or friends-only
 * @param  ?MEMBER		Member being written for (NULL: current member)
 * @param  boolean		Whether to push this out as a site event if user requested
 * @param  ?MEMBER		Member also 'intimately' involved, such as a content submitter who is a friend (NULL: none)
 */
function activities_addon_syndicate_described_activity($a_language_string_code='',$a_label_1='',$a_label_2='',$a_label_3='',$a_pagelink_1='',$a_pagelink_2='',$a_pagelink_3='',$a_addon='',$a_is_public=1,$a_member_id=NULL,$sitewide_too=false,$a_also_involving=NULL)
{
	require_code('activities');
	require_lang('activities');

	if ((get_db_type()=='xml') && (get_param_integer('keep_testing_logging',0)!=1)) return NULL;

	$stored_id=0;
	if (is_null($a_member_id)) $a_member_id=get_member();
	if (is_guest($a_member_id)) return NULL;

	$go=array(
		'a_language_string_code'=>$a_language_string_code,
		'a_label_1'=>$a_label_1,
		'a_label_2'=>$a_label_2,
		'a_label_3'=>$a_label_3,
		'a_is_public'=>$a_is_public
	);

	$stored_id=mixed();

	// Check if this has been posted previously (within the last 10 minutes) to
	// stop spamming but allow generalised repeat status messages.
	$test=$GLOBALS['SITE_DB']->query_select('activities',array('a_language_string_code','a_label_1','a_label_2','a_label_3','a_is_public'),NULL,'WHERE a_time>'.strval(time()-600).' AND a_time<='.strval(time()),1);
	if ((!array_key_exists(0,$test)) || ($test[0]!=$go) || (running_script('execute_temp')))
	{
		// Log the activity
		$row=$go+array(
			'a_member_id'=>$a_member_id,
			'a_also_involving'=>$a_also_involving,
			'a_pagelink_1'=>$a_pagelink_1,
			'a_pagelink_2'=>$a_pagelink_2,
			'a_pagelink_3'=>$a_pagelink_3,
			'a_time'=>time(),
			'a_addon'=>$a_addon,
			'a_is_public'=>$a_is_public
		);
		$stored_id=$GLOBALS['SITE_DB']->query_insert('activities',$row,true);

		// Update the latest activity file
		log_newest_activity($stored_id,1000,true/*We do want to force it, IDs can get out of sync on dev sites*/);

		// External places
		if (($a_is_public==1) && (!$GLOBALS['IS_ACTUALLY_ADMIN']/*SU means oauth'd user is not intended user*/))
		{
			$dests=find_all_hooks('systems','syndication');
			foreach (array_keys($dests) as $hook)
			{
				require_code('hooks/systems/syndication/'.$hook);
				$ob=object_factory('Hook_Syndication_'.$hook);
				if ($ob->is_available())
				{
					$ob->syndicate_user_activity($a_member_id,$row);
					if (($sitewide_too) && (has_specific_permission(get_member(),'syndicate_site_activity')) && (post_param_integer('syndicate_this',0)==1))
						$ob->syndicate_site_activity($row);
				}
			}
		}

		list($message)=render_activity($row,false);
		require_code('notifications');
		$username=$GLOBALS['FORUM_DRIVER']->get_username($a_member_id);
		$subject=do_lang('ACTIVITY_NOTIFICATION_MAIL_SUBJECT',get_site_name(),$username,strip_html($message->evaluate()));
		$mail=do_lang('ACTIVITY_NOTIFICATION_MAIL',comcode_escape(get_site_name()),comcode_escape($username),array('[semihtml]'.$message->evaluate().'[/semihtml]'));
		dispatch_notification('activity',strval($a_member_id),$subject,$mail);
	}

	return $stored_id;
}

/**
 * AJAX script handler for submitting posts.
 */
function activities_ajax_submit_handler()
{
	header('Content-Type: text/xml');
	header("Cache-Control: no-cache, must-revalidate"); // HTTP/1.1
	header("Expires: Mon, 26 Jul 1997 05:00:00 GMT"); // Date in the past

	$response ='<'.'?xml version="1.0" encoding="'.get_charset().'" ?'.'>';
	$response.='<response><content>';

	$map=array();

	$guest_id=intval($GLOBALS['FORUM_DRIVER']->get_guest_id());

	if (!is_guest(get_member()))
	{
		$map['STATUS']=trim(either_param('status',''));

		if ((post_param('zone','')!='') && ($map['STATUS']!='') && ($map['STATUS']!=do_lang('activities:TYPE_HERE')))
		{
			comcode_to_tempcode($map['STATUS'],$guest_id,false,NULL);

			$map['PRIVACY']=either_param('privacy','private');

			if (strlen(strip_tags($map['STATUS']))<strlen($map['STATUS']))
			{
				$cc_guide=build_url(array('page'=>'userguide_comcode'),'site');
				$response.='<success>0</success><feedback><![CDATA[No HTML allowed. See <a href="'.$cc_guide->evaluate().'">Comcode Help</a> for info on the alternative.]]></feedback>';
			}
			else
			{
				if (strlen($map['STATUS'])>255)
				{
					$response.='<success>0</success><feedback>Message is '.strval(strlen($map['STATUS'])-255).' characters too long</feedback>';
				}
				else
				{
					$stored_id=activities_addon_syndicate_described_activity('RAW_DUMP',
													$map['STATUS'],
													'',
													'',
													'',
													'',
													'',
													'',
													($map['PRIVACY']=='public')?1:0
					);

					if ($stored_id>0)
					{
						$response.='<success>1</success><feedback>Message received.</feedback>';
					}
					elseif ($stored_id==-1)
					{
						$response.='<success>0</success><feedback>Message already received.</feedback>';
					}
				}
			}
		}
	}
	else
		$response.='<success>0</success><feedback>'.do_lang('LOGIN_EXPIRED_POST').'</feedback>';

	$response.='</content></response>';

	echo $response;
}

/**
 * AJAX script handler for refreshing the post list.
 */
function activities_ajax_update_list_handler()
{
	$map=array();

	$map['max']=$GLOBALS['SITE_DB']->query_value_null_ok('values','the_value',array('the_name'=>get_zone_name()."_".get_page_name()."_update_max"));

	if (is_null($map['max']))
	{
		$map['max']='10';
	}

	$last_id=post_param('last_id','-1');
	$mode=post_param('mode','all');

	require_lang('activities');
	require_code('activities');
	require_code('addons_overview');

	$proceed_selection=true; //There are some cases in which even glancing at the database is a waste of precious time.

	$guest_id=intval($GLOBALS['FORUM_DRIVER']->get_guest_id());
	$viewer_id=intval(get_member()); //We'll need this later anyway.

	$can_remove_others=(has_zone_access($viewer_id,'adminzone'));

	//Getting the member viewed ids if available, member viewing if not
	$member_ids=array_map('intval',explode(',',post_param('member_ids',strval($viewer_id))));

	list($proceed_selection,$where_clause)=get_activity_querying_sql($viewer_id,$mode,$member_ids);

	header("Content-Type: text/xml");
	header("Cache-Control: no-cache, must-revalidate"); // HTTP/1.1
	header("Expires: Mon, 26 Jul 1997 05:00:00 GMT"); // Date in the past

	$response ='<'.'?xml version="1.0" encoding="'.get_charset().'" ?'.'>';

	$can_remove_others=(has_zone_access($viewer_id,'adminzone'));

	if ($proceed_selection===true)
	{
		$activities=$GLOBALS['SITE_DB']->query('SELECT * FROM '.get_table_prefix().'activities WHERE (('.$where_clause.') AND id>'.(($last_id=='')?'-1':$last_id).') ORDER BY a_time DESC',intval($map['max']));

		if (count($activities)>0)
		{
			$list_items='';
			foreach ($activities as $row)
			{
				list($message,$memberpic,$datetime,$member_url)=render_activity($row);

				$username=$GLOBALS['FORUM_DRIVER']->get_username($row['a_member_id']);
				if (is_null($username)) $username=do_lang('UNKNOWN');
				$list_item=do_template('BLOCK_MAIN_ACTIVITIES_XML',array('_GUID'=>'02dfa8b02040f56d76b783ddb8fb382f','LANG_STRING'=>'RAW_DUMP','ADDON_ICON'=>find_addon_icon($row['a_addon']),'BITS'=>$message,'MEMBER_ID'=>strval($row['a_member_id']),'MEMPIC'=>$memberpic,'USERNAME'=>$username,'DATETIME'=>strval($datetime),'MEMBER_URL'=>$member_url,'LIID'=>strval($row['id']),'ALLOW_REMOVE'=>(($row['a_member_id']==$viewer_id) || $can_remove_others)));
				// We dump our response in CDATA, since that lets us work around the
				// fact that our list elements aren't actually in a list, etc.
				// However, we allow comcode but some tags make use of CDATA. Since
				// CDATA can't be nested (as it's a form of comment), we take this
				// into account by base64 encoding the whole template and decoding
				// it in the browser. We wrap it in some arbitrary XML and a CDATA
				// tag so that the Javascript knows what it's received
				$list_items.='<listitem id="'.strval($row['id']).'"><![CDATA['.base64_encode($list_item->evaluate()).']]></listitem>';

			}
			$response.='<response><success>1</success><feedlen>'.$map['max'].'</feedlen><content>'.$list_items.'</content><supp>'.escape_html($where_clause).'</supp></response>';
		}
		else
		{
			$response.='<response><success>2</success><content>NU - Nothing new.</content></response>';
		}
	}
	else
	{
		$response.='<response><success>2</success><content>NU - No feeds to select from.</content></response>';
	}

	echo $response;
}

/**
 * AJAX script handler for removing posts.
 */
function activities_ajax_removal_handler()
{
	$is_guest=false; // Can't be doing with overcomplicated SQL breakages. Weed it out.
	$guest_id=intval($GLOBALS['FORUM_DRIVER']->get_guest_id());
	$viewer_id=intval(get_member()); //We'll need this later anyway.
	if ($guest_id==$viewer_id)
		$is_guest=true;

	$can_remove_others=(has_zone_access($viewer_id,'adminzone'));

	header('Content-Type: text/xml');
	header("Cache-Control: no-cache, must-revalidate"); // HTTP/1.1
	header("Expires: Mon, 26 Jul 1997 05:00:00 GMT"); // Date in the past

	$response ='<'.'?xml version="1.0" encoding="'.get_charset().'" ?'.'>';
	$response.='<response>';

	$stat_id=post_param_integer('removal_id',-1);
	$stat_owner=($stat_id!=-1)?$GLOBALS['SITE_DB']->query_value_null_ok('activities','a_member_id',array('id'=>$stat_id)):NULL;

	if (($is_guest!==true) && (!is_null($stat_owner)))
	{
		if (($stat_owner!=$viewer_id) && ($can_remove_others!==true))
		{
			$response.='<success>0</success><err>perms</err>';
			$response.='<feedback>You do not have permission to remove this status message.</feedback><status_id>'.strval($stat_id).'</status_id>';
		}
		else // I suppose we can proceed now.
		{
			$GLOBALS['SITE_DB']->query_delete('activities',array('id'=>$stat_id),'',1);

			$response.='<success>1</success><feedback>Message deleted.</feedback><status_id>'.strval($stat_id).'</status_id>';
		}
	}
	elseif (is_null($stat_owner))
	{
		$response.='<success>0</success><err>missing</err><feedback>Missing ID for status removal or id does not exist.</feedback>';
	}
	else
		$response.='<success>0</success><feedback>Login expired, you must log in again to post</feedback>';

	$response.='</response>';

	echo $response;
}

/**
 * Maintains a text file in data_custom. This contains the latest activity's ID.
 * Since the Javascript polls for updates, it can check against this before
 * running any PHP.
 * Locking timeout code provided by "administrator at proxy-list dot org" on
 * http://php.net/manual/en/function.flock.php
 *
 * @param  integer		The ID we are going to write to the file
 * @param  integer		Our timeout in milliseconds (how long we should keep trying). Default: 1000
 * @param  boolean		Whether to force this ID to be the newest, even if it's less than the current value
 */
function log_newest_activity($id,$timeout=1000,$force=false)
{
	$filename=get_custom_file_base().'/data_custom/latest_activity.txt';

	// Grab a pointer for appending to this file
	// NOTE: ALWAYS open as append! Opening as write will wipe the file during
	// the fopen call, which is before we have a lock.
	$fp=@fopen($filename,'a+');

	// Only bother running if this file can be opened
	if ($fp!==false)
	{
		// Grab our current time in milliseconds
		$start_time=microtime(true);

		$sleep_multiplier=floatval($timeout)/10.0;

		flock($fp,LOCK_EX);

		// Read the current value
		rewind($fp);
		$old_id=intval(fgets($fp,1024));
		// See if we should be updating the file (IDs increase numerically)
		if ($force || ($old_id<$id))
		{
			// If so then wipe the file (since we're in append mode,
			// but we want to overwrite)
			ftruncate($fp,0);

			// Save our new ID
			fwrite($fp,strval($id));
		}

		flock($fp,LOCK_UN);
		fclose($fp);
	} else
	{
		if (function_exists('attach_message'))
			attach_message(intelligent_write_error_inline($filename),'warn');
	}

	fix_permissions($filename);
	sync_file($filename);
}
