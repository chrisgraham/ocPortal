<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2012

 See text/EN/licence.txt for full licencing information.

*/

function init__facebook_connect()
{
	if (!class_exists('ocp_tempcode')) return;

	// Initialise Facebook Connect
	require_code('facebook/facebook');
	class ocpFacebook extends BaseFacebook // We don't want any persistence - we store in normal ocPortal sessions/member rows
	{
		protected function setPersistentData($key,$value)
		{
		}

		protected function getPersistentData($key,$default=false)
		{
		}

		protected function clearPersistentData($key)
		{
		}

		protected function clearAllPersistentData()
		{
		}

		protected function constructSessionVariableName($key)
		{
		}
	}
	global $FACEBOOK_CONNECT;
	$FACEBOOK_CONNECT=mixed();
	$appid=get_option('facebook_appid',true);
	if (is_null($appid)) return;
	$appsecret=get_option('facebook_secret_code',true);
	if (is_null($appsecret)) return;
	$FACEBOOK_CONNECT=new ocpFacebook(array('appId'=>$appid,'secret'=>$appsecret));

	global $EXTRA_FOOT;
	if (!isset($EXTRA_FOOT)) $EXTRA_FOOT=new ocp_tempcode();
	$EXTRA_FOOT->attach(do_template('FACEBOOK_FOOTER',NULL,NULL,true,NULL,'.tpl','templates','default'));
}

// TODO: Update for v10, config options moved. Remember to create config hooks too
function facebook_install()
{
	require_code('database_action');

	$facebook_appid=get_option('facebook_appid',true);
	if (is_null($facebook_appid))
	{
		add_config_option('FACEBOOK_APPID','facebook_appid','line','return \'\';','FEATURE','FACEBOOK_SYNDICATION');
		add_config_option('FACEBOOK_SECRET','facebook_secret_code','line','return \'\';','FEATURE','FACEBOOK_SYNDICATION');
		add_config_option('FACEBOOK_UID','facebook_uid','line','return \'\';','FEATURE','FACEBOOK_SYNDICATION');
	}

	$facebook_sync_username=get_option('facebook_sync_username',true);
	if (is_null($facebook_sync_username))
	{
		add_config_option('FACEBOOK_LOGIN','facebook_login','tick','return \'1\';','FEATURE','FACEBOOK_SYNDICATION');
		add_config_option('FACEBOOK_SYNC_USERNAME','facebook_sync_username','tick','return \'0\';','FEATURE','FACEBOOK_SYNDICATION');
		add_config_option('FACEBOOK_SYNC_DOB','facebook_sync_dob','tick','return \'0\';','FEATURE','FACEBOOK_SYNDICATION');
		add_config_option('FACEBOOK_SYNC_EMAIL','facebook_sync_email','tick','return \'0\';','FEATURE','FACEBOOK_SYNDICATION');
		add_config_option('FACEBOOK_SYNC_AVATAR','facebook_sync_avatar','tick','return \'0\';','FEATURE','FACEBOOK_SYNDICATION');
		add_config_option('FACEBOOK_AUTO_SYNDICATE','facebook_auto_syndicate','tick','return \'0\';','FEATURE','FACEBOOK_SYNDICATION');
		add_config_option('FACEBOOK_MEMBER_SYNDICATE_TO_PAGE','facebook_member_syndicate_to_page','tick','return \'0\';','FEATURE','FACEBOOK_SYNDICATION');
	}
}

// This is only called if we know we have a user logged into Facebook, who has authorised to our app
function handle_facebook_connection_login($current_logged_in_member)
{
	if (!class_exists('ocp_tempcode')) return NULL;

	if (is_guest($current_logged_in_member))
	{
		$current_logged_in_member=NULL;

		// We are not a normal cookie login so ocPortal has loaded up a Guest session already in the expectation of keeping it. Unsetting it will force a rebind (existing session may be reused though)
		require_code('users_inactive_occasionals');
		set_session_id(-1);
	}

	// If already session-logged-in onto a Facebook account, don't bother doing anything
	if ((!is_null($current_logged_in_member)) && ($GLOBALS['FORUM_DRIVER']->get_member_row_field($current_logged_in_member,'m_password_compat_scheme')=='facebook'))
	{
		return $current_logged_in_member;
	}

	// Who is this user, from Facebook's point of view?
	global $FACEBOOK_CONNECT;
	$facebook_uid=$FACEBOOK_CONNECT->getUser();
	if (is_null($facebook_uid)) return $current_logged_in_member;
	try
	{
		$details=$FACEBOOK_CONNECT->api('/me');
	}
	catch (Exception $e)
	{
		return $current_logged_in_member;
	}
	if (!is_array($details))
	{
		return $current_logged_in_member;
	}
	$details2=$FACEBOOK_CONNECT->api('/me',array('fields'=>'picture','type'=>'normal'));
	if (!is_array($details2)) // NB: This can happen even if there is a Facebook session, if the session ID in the cookie has expired. In this case Guest will be the user until the frontend does a refresh
	{
		return $current_logged_in_member;
	}
	$details=array_merge($details,$details2);
	if (!isset($details['name'])) return $current_logged_in_member;
	$username=$details['name'];
	$photo_url=array_key_exists('picture',$details)?$details['picture']:'';
	if (is_array($photo_url)) $photo_url=$photo_url['data']['url'];
	if ($photo_url!='')
	{
		$photo_url='http://graph.facebook.com/'.strval($facebook_uid).'/picture?type=large'; // In case URL changes
	}
	$avatar_url=($photo_url=='')?mixed():$photo_url;
	$photo_thumb_url='';
	if ($photo_url!='') $photo_thumb_url=$photo_url;
	$email_address=array_key_exists('email',$details)?$details['email']:'';
	$timezone=mixed();
	if (isset($details['timezone']))
	{
		require_code('temporal');
		$timezone=convert_timezone_offset_to_formal_timezone($details['timezone']);
	}
	$language=mixed();
	if (isset($details['locale']))
		$language=strtoupper($details['locale']);
	if ($language!==NULL)
	{
		if (!file_exists(get_custom_file_base().'/lang_custom/'.$language))
		{
			$language=preg_replace('#\_.*$#','',$language);
			if (!file_exists(get_custom_file_base().'/lang_custom/'.$language))
				$language='';
		}
	}
	$dob=array_key_exists('birthday',$details)?$details['birthday']:'';
	$dob_day=mixed();
	$dob_month=mixed();
	$dob_year=mixed();
	if ($dob!='')
	{
		$_dob=explode('/',$dob);
		$dob_day=intval($_dob[1]);
		$dob_month=intval($_dob[0]);
		$dob_year=intval($_dob[2]);
	}

	// See if they have logged in before - i.e. have a synched account
	$member_row=$GLOBALS['FORUM_DB']->query_select('f_members',array('*'),array('m_password_compat_scheme'=>'facebook','m_pass_hash_salted'=>$facebook_uid),'ORDER BY id DESC',1);
	$member_id=array_key_exists(0,$member_row)?$member_row[0]['id']:NULL;
	if (is_guest($member_id)) $member_id=NULL;

	/*if (!is_null($member_id)) // Useful for debugging
	{
		require_code('ocf_members_action2');
		ocf_delete_member($member_id);
		$member_id=NULL;
	}*/

	if ((!is_null($member_id)) && ($current_logged_in_member!==NULL) && (!is_guest($current_logged_in_member)) && ($current_logged_in_member!=$member_id))
		return $current_logged_in_member; // User has an active login, and the Facebook account is bound to a DIFFERENT login. Take precedence to the other login that is active on top of this

	// If logged in before using Facebook, do some synching
	if (!is_null($member_id))
	{
		$last_visit_time=$member_id[0]['m_last_visit_time'];
		if ($timezone!==NULL)
		{
			if ((!is_numeric($member_row[0]['m_timezone_offset'])) && (tz_time(time(),$timezone)==tz_time(time(),$member_row[0]['m_timezone_offset'])))
				$timezone=$member_row[0]['m_timezone_offset']; // If equivalent, don't change
		}

		$update_map=array();

		// Username
		if (get_option('facebook_sync_username')=='1')
		{
			$test=$GLOBALS['FORUM_DB']->query_value_null_ok('f_members','id',array('m_username'=>$username));
			if (is_null($test)) // Make sure there's no conflict yet the name has changed
			{
				$update_map['m_username']=$username;
			}
		}

		// DOB
		if (get_option('facebook_sync_dob')=='1')
		{
			$update_map+=array('m_dob_day'=>$dob_day,'m_dob_month'=>$dob_month,'m_dob_year'=>$dob_year);
		}

		// Email
		if (get_option('facebook_sync_email')=='1')
		{
			if ($email_address!='')
			{
				$update_map['m_email_address']=$email_address;
			}
		}

		// Avatar/photos
		if (get_option('facebook_sync_avatar')=='1')
		{
			$test=$member_row[0]['m_avatar_url'];
			if (($avatar_url!==NULL) && (($test=='') || (strpos($test,'facebook')!==false) || (strpos($test,'fbcdn')!==false)))
			{
				if ($timezone!==NULL)
					$update_map['m_timezone_offset']=$timezone;
				$update_map['m_avatar_url']=$avatar_url;
				$update_map['m_photo_url']=$photo_url;
				$update_map['m_photo_thumb_url']=$photo_thumb_url;
			}
		}

		// Run update
		$GLOBALS['FORUM_DB']->query_update('f_members',$update_map,array('m_password_compat_scheme'=>'facebook','m_pass_hash_salted'=>strval($facebook_uid)),'',1);

		// Caching
		if ((array_key_exists('m_username',$update_map)) && ($username!=$member_row[0]['m_username']))
		{
			require_code('ocf_members_action2');
			update_member_username_caching($member_id,$username);
		}
	}

	// Not logged in before using Facebook, so we need to create an account, or bind to the active ocPortal login if there is one
	$in_a_sane_place=(get_page_name()!='login') && ((running_script('index')) || (running_script('execute_temp'))); // If we're in some weird script, or the login module UI, it's not a sane place, don't be doing account creation yet
	if ((is_null($member_id)) && ($in_a_sane_place))
	{
		// Bind to existing ocPortal login?
		if (!is_null($current_logged_in_member))
		{
			/*if (post_param_integer('associated_confirm',0)==0)		Won't work because Facebook is currently done in JS and cookies force this. If user wishes to cancel they must go to http://www.facebook.com/settings?tab=applications and remove the app, then run a lost password reset.
			{
				$title=get_screen_title('LOGIN_FACEBOOK_HEADER');
				$message=do_lang_tempcode('LOGGED_IN_SURE_FACEBOOK',escape_html($GLOBALS['FORUM_DRIVER']->get_username($current_logged_in_member)));
				$middle=do_template('CONFIRM_SCREEN',array('_GUID'=>'3d80095b18cf57717d0b091cf3680252','TITLE'=>$title,'TEXT'=>$message,'HIDDEN'=>form_input_hidden('associated_confirm','1'),'URL'=>get_self_url_easy(),'FIELDS'=>''));
				$tpl=globalise($middle,NULL,'',true);
				$tpl->evaluate_echo();
				exit();
			}*/

			$GLOBALS['FORUM_DB']->query_update('f_members',array('m_password_compat_scheme'=>'facebook','m_pass_hash_salted'=>$facebook_uid),array('id'=>$current_logged_in_member),'',1);
			require_code('site');
			require_lang('facebook');
			attach_message(do_lang_tempcode('FACEBOOK_ACCOUNT_CONNECTED',escape_html(get_site_name()),escape_html($GLOBALS['FORUM_DRIVER']->get_username($current_logged_in_member)),array(escape_html($username))),'inform');
			return $current_logged_in_member;
		}

		// If we're still here, we have to create a new account...
		// -------------------------------------------------------

		$completion_form_submitted=post_param('email_address','')!='';

		require_code('ocf_members_action2');

		// Ask ocP to finish off the profile from the information presented in the POST environment (a standard mechanism in ocPortal, for third party logins of various kinds)
		require_lang('ocf');
		require_code('ocf_members');
		require_code('ocf_groups');
		require_code('ocf_members2');
		require_code('ocf_members_action');
		$_custom_fields=ocf_get_all_custom_fields_match(ocf_get_all_default_groups(true),NULL,NULL,NULL,1);
		if ((!$completion_form_submitted) && (count($_custom_fields)!=0) && (get_value('no_finish_profile')!=='1')) // UI
		{
			$GLOBALS['FACEBOOK_FINISHING_PROFILE']=true;
			$middle=ocf_member_external_linker_ask($username,'facebook',$email_address,$dob_day,$dob_month,$dob_year);
			$tpl=globalise($middle,NULL,'',true);
			$tpl->evaluate_echo();
			exit();
		} else // Actualiser
		{
			// If there's a conflicting username, we may need to change it (suffix a number)  [we don't do in code branch above, as ocf_member_external_linker_ask already handles it]
			$username=get_username_from_human_name($username);

			// Check RBL's/stopforumspam
			$spam_check_level=get_option('spam_check_level',true);
			if (($spam_check_level==='EVERYTHING') || ($spam_check_level==='ACTIONS') || ($spam_check_level==='GUESTACTIONS') || ($spam_check_level==='JOINING'))
			{
				require_code('antispam');
				check_rbls();
				check_stopforumspam(post_param('username',$username),$email_address);
			}

			$username=post_param('username',$username)/*user may have customised username*/;
			if ((count($_custom_fields)!=0) && (get_value('no_finish_profile')!=='1')) // Was not auto-generated, so needs to be checked
				ocf_check_name_valid($username,NULL,NULL);
			$member_id=ocf_member_external_linker($username,$facebook_uid,'facebook',false,$email_address,$dob_day,$dob_month,$dob_year,$timezone,$language,$avatar_url,$photo_url,$photo_thumb_url);
		}
	}

	// Finalise the session
	if (!is_null($member_id))
	{
		require_code('users_inactive_occasionals');
		create_session($member_id,1,(isset($_COOKIE[get_member_cookie().'_invisible'])) && ($_COOKIE[get_member_cookie().'_invisible']=='1')); // This will mark it as confirmed
	}

	// Store oAuth for syndication
	if (get_option('facebook_auto_syndicate')=='1')
	{
		if (!is_null($member_id))
		{
			set_long_value('facebook_oauth_token__'.strval($member_id),$FACEBOOK_CONNECT->getAccessToken());

			if (get_option('facebook_member_syndicate_to_page')=='1')
				set_long_value('facebook_syndicate_to_page__'.strval($member_id),'1');
		}
	}

	return $member_id;
}
