<?php /*

 ocPortal
 Copyright (c) ocProducts, 2004-2011

 See text/EN/licence.txt for full licencing information.

*/

function init__facebook_connect()
{
	if (!class_exists('ocp_tempcode')) return;

	global $EXTRA_FOOT;
	if (!isset($EXTRA_FOOT)) $EXTRA_FOOT=new ocp_tempcode();
	$EXTRA_FOOT->attach(do_template('FACEBOOK_FOOTER',NULL,NULL,true,NULL,'.tpl','templates','default'));

	// Initialise Facebook Connect
	require_code('facebook/facebook');
	class ocpFacebook extends BaseFacebook // We don't want any persistence - we store in normal ocPortal sessions/member rows
	{
		protected function setPersistentData($key, $value) {
		}

		protected function getPersistentData($key, $default = false) {
		}

		protected function clearPersistentData($key) {
		}

		protected function clearAllPersistentData() {
		}

		protected function constructSessionVariableName($key) {
		}
	}
	global $FACEBOOK_CONNECT;
	$FACEBOOK_CONNECT=mixed();
	$appid=get_option('facebook_appid',true);
	if (is_null($appid)) return;
	$appsecret=get_option('facebook_secret_code');
	if (($appsecret!='') && ($appid!=''))
		$FACEBOOK_CONNECT=new ocpFacebook(array('appId'=>$appid,'secret'=>$appsecret));
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

	// Who is this user, from Facebook's point of view?
	global $FACEBOOK_CONNECT;
	$facebook_uid=$FACEBOOK_CONNECT->getUser();
	$details=$FACEBOOK_CONNECT->api('/me');
	$username=$details['name'];
	$email_address=array_key_exists('email',$details)?$details['email']:'';
	$timezone=mixed();
	if (isset($details['timezone']))
		$timezone=convert_timezone_offset_to_formal_timezone($details['timezone']);
	$language=mixed();
	if (isset($details['languages'][0]->id))
		$language=strtoupper($details['languages'][0]->id);
	if (!file_exists(get_custom_file_base().'/lang_custom/'.$language)) $language='';
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
	$member=array_key_exists(0,$member_row)?$member_row[0]['id']:NULL;
	if (is_guest($member)) $member=NULL;

	// If logged in before using Facebook, see if they've changed their name or email or timezone on Facebook -- if so, try and update locally to match
	if (!is_null($member))
	{
		if ((!is_null($current_logged_in_member)) && ($current_logged_in_member!==NULL) && (!is_guest($current_logged_in_member)) && ($current_logged_in_member!=$member))
			return $current_logged_in_member; // User has an active login, and the Facebook account is bound to a DIFFERENT login. Take precedence to the other login that is active on top of this

		$last_visit_time=$member[0]['m_last_visit_time'];
		if ($last_visit_time>5*60*60)
		{
			if ($timezone!==NULL)
			{
				if (tz_time(time(),$timezone)==tz_time(time(),$member[0]['m_timezone_offset'])) $timezone=$member[0]['m_timezone_offset']; // If equivalent, don't change
			}
			if (($username!=$member[0]['m_username']) || (($timezone!==NULL) && ($timezone!=$member[0]['m_timezone_offset'])) || ($email_address!=$member[0]['m_email_address']))
			{
				$test=$GLOBALS['FORUM_DB']->query_value_null_ok('f_members','id',array('m_username'=>$username));
				if (!is_null($test)) // Make sure there's no conflict
				{
					$update_map=array('m_username'=>$username,'m_email_address'=>$email_address);
					if ($timezone!==NULL)
						$update_map['m_timezone_offset']=$timezone;
					$GLOBALS['FORUM_DB']->query_update('f_members',$update_map,array('m_password_compat_scheme'=>'facebook','m_pass_hash_salted'=>strval($facebook_uid)),'',1);
				}
			}
		}
	}

	// Not logged in before using Facebook, so we need to create an account, or bind to the active ocPortal login if there is one
	$in_a_sane_place=(get_page_name()!='login') && ((running_script('index')) || (running_script('execute_temp'))); // If we're in some weird script, or the login module UI, it's not a sane place, don't be doing account creation yet
	if ((is_null($member)) && ($in_a_sane_place))
	{
		// Bind to existing ocPortal login?
		if (!is_null($current_logged_in_member))
		{
			$GLOBALS['FORUM_DB']->query_update('f_members',array('m_password_compat_scheme'=>'facebook','m_pass_hash_salted'=>$facebook_uid),array('id'=>$current_logged_in_member),'',1);
			require_code('site');
			attach_message(do_lang_tempcode('FACEBOOK_ACCOUNT_CONNECTED',escape_html(get_site_name()),escape_html($GLOBALS['FORUM_DRIVER']->get_username($current_logged_in_member)),array(escape_html($username))),'inform');
			return $current_logged_in_member;
		}

		// If we're still here, we have to create a new account...
		// -------------------------------------------------------

		$completion_form_submitted=post_param('email_address','')!='';

		// If there's a conflicting username, we may need to change it (suffix a number)
		require_code('ocf_members_action2');
		$username=get_username_from_human_name($username);

		// Ask ocP to finish off the profile from the information presented in the POST environment (a standard mechanism in ocPortal, for third party logins of various kinds)
		require_lang('ocf');
		require_code('ocf_members');
		require_code('ocf_groups');
		require_code('ocf_members2');
		require_code('ocf_members_action');
		$_custom_fields=ocf_get_all_custom_fields_match(ocf_get_all_default_groups(true),NULL,NULL,NULL,1);
		if ((!$completion_form_submitted) && (count($_custom_fields)!=0) && (get_value('no_finish_profile')!=='1')) // UI
		{
			$middle=ocf_member_external_linker_ask($username,'facebook',$email_address,$dob_day,$dob_month,$dob_year);
			$tpl=globalise($middle,NULL,'',true);
			$tpl->evaluate_echo();
			exit();
		} else // Actualiser
		{
			$member=ocf_member_external_linker(post_param('username',$username)/*user may have customised username*/,$facebook_uid,'facebook',false,$email_address,$dob_day,$dob_month,$dob_year,$timezone,$language);
		}
	}

	if (!is_null($member))
	{
		require_code('users_inactive_occasionals');
		create_session($member,1); // This will mark it as confirmed
	}

	return $member;
}
