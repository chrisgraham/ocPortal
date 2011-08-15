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
}

if (!function_exists('json_encode'))
{
	require_code('facebook/jsonwrapper/JSON/JSON');

	function json_encode($arg)
	{
		global $services_json;
		if (!isset($services_json))
		{
			$services_json = new Services_JSON();
		}
		return $services_json->encode($arg);
	}

	function json_decode($arg)
	{
		global $services_json;
		if (!isset($services_json))
		{
			$services_json = new Services_JSON();
		}
		return $services_json->decode($arg);
	}
}


function get_facebook_cookie()
{
	$app_id = get_option('facebook_appid');
	$cookie_name = 'fbs_' . $app_id;
	$application_secret = get_option('facebook_secret_code');

	$args = array();
	if (!array_key_exists($cookie_name,$_COOKIE)) return NULL;
	parse_str(trim($_COOKIE[$cookie_name], '\\"'), $args);
	ksort($args);
	$payload = '';
	foreach ($args as $key => $value)
	{
		if ($key != 'sig')
		{
			$payload .= $key . '=' . $value;
		}
	}

	if (!array_key_exists('sig',$args)) return NULL;
	if (md5($payload . $application_secret) != $args['sig'])
	{
		return NULL;
	}
	return $args;
}

function handle_facebook_connection_login($cookie,$current_logged_in_member)
{
	if (!class_exists('ocp_tempcode')) return NULL;

	if (is_guest($current_logged_in_member)) $current_logged_in_member=NULL;

	$facebook_uid=$cookie['uid'];
	$member_row=$GLOBALS['FORUM_DB']->query_select('f_members',array('id','m_username','m_last_visit_time'),array('m_password_compat_scheme'=>'facebook','m_pass_hash_salted'=>$facebook_uid),'ORDER BY id DESC',1);
	$member=array_key_exists(0,$member_row)?$member_row[0]['id']:NULL;
	if (is_guest($member)) $member=NULL;

	if (!is_null($member))
	{
		if ((!is_null($current_logged_in_member)) && (!is_guest($current_logged_in_member)) && ($current_logged_in_member!=$member)) return; // Take precedence to the other login that is active on top of this

		$last_visit_time = $member[0]['m_last_visit_time'];
		if($last_visit_time > (5*60*60))
		{
			$url = 'https://graph.facebook.com/'.$facebook_uid;
			require_code('files');
			$details = json_decode(http_download_file($url), true);
			$username = array_key_exists('name', $details) ? $details['name'] : '';
			if($username != $member[0]['m_username'])
			{
				$test=$GLOBALS['FORUM_DB']->query_value_null_ok('f_members','id',array('m_username'=>$username));
				if (!is_null($test)) // Make sure there's no conflict
					$GLOBALS['FORUM_DB']->query_update('f_members',array('m_username'=>$username),array('m_password_compat_scheme'=>'facebook','m_pass_hash_salted'=>strval($facebook_uid)),'',1);
			}
		}
	}

	if ((is_null($member)) && (get_page_name()!='login') && ((running_script('index')) || (running_script('execute_temp'))))
	{
		// Bind to existing login?
		if (!is_null($current_logged_in_member))
		{
			$url = 'https://graph.facebook.com/'.$facebook_uid;
			require_code('files');
			$details = json_decode(http_download_file($url), true);
			$username = array_key_exists('name', $details) ? $details['name'] : '';

			$GLOBALS['FORUM_DB']->query_update('f_members',array('m_password_compat_scheme'=>'facebook','m_pass_hash_salted'=>$facebook_uid),array('id'=>$current_logged_in_member),'',1);
			attach_message(do_lang_tempcode('FACEBOOK_ACCOUNT_CONNECTED',escape_html(get_site_name()),escape_html($GLOBALS['FORUM_DRIVER']->get_username($current_logged_in_member)),array(escape_html($username))),'inform');
			return;
		}
		
		// We have to create one?
		$cookie = get_facebook_cookie();
		$url = 'https://graph.facebook.com/me?access_token='.preg_replace('#\s#','',$cookie['access_token']);
		require_code('files');
		$details = json_decode(http_download_file($url), true);
		if (is_null($details))
		{
			$url = 'http://graph.facebook.com/'.$facebook_uid;
			require_code('files');
			$details = json_decode(http_download_file($url), true);
		}

		$username = array_key_exists('name', $details) ? $details['name'] : '';

		if ($username!='')
		{
			$_username=$username;
			$i=1;
			do
			{
				$test=$GLOBALS['FORUM_DB']->query_value_null_ok('f_members','id',array('m_username'=>$_username));
				if (!is_null($test))
				{
					$i++;
					$_username=$username.' ('.strval($i).')';
				}
			}
			while (!is_null($test));
			$username=$_username;
		}

		$email_address = array_key_exists('email', $details) ? $details['email'] : '';
		$dob = array_key_exists('birthday', $details) ? $details['birthday'] : '';
		$_POST['email_address'] = $email_address;
		if ($dob!='')
		{
			$_dob=explode('/',$dob);
			$_POST['dob_day'] = $_dob[1];
			$_POST['dob_month'] = $_dob[0];
			$_POST['dob_year'] = $_dob[2];
		}

		require_lang('ocf');
		require_code('ocf_members');
		require_code('ocf_groups');
		require_code('ocf_members2');
		require_code('ocf_members_action');
		require_code('ocf_members_action2');
		if ((trim(post_param('email_address',''))=='') && (get_value('no_finish_profile')!=='1'))
		{
			require_code('urls');
			@ob_end_clean();
			if (!function_exists('do_header')) require_code('site');
			$middle=ocf_member_external_linker_ask($username,'facebook',$email_address);
			$tpl=globalise($middle,NULL,'',true);
			$tpl->evaluate_echo();
			exit();
		} else
		{
			$member=ocf_member_external_linker(post_param('username',$username),$facebook_uid,'facebook',false);
		}
	}
	
	if (!is_null($member))
	{
		// We are not a normal cookie login so ocPortal has loaded up a Guest session already in the expectation of keeping it. Unsetting it will force a rebind (existing session may be reused though)
		require_code('users_inactive_occasionals');
		set_session_id(-1);
	}

	delete_expired_sessions($member);

	return $member;
}
