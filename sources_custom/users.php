<?php

function init__users($code)
{
	if (is_file(get_custom_file_base().'/sources_custom/openid.php'))
		$code=str_replace('// Guest or banned','$member=check_openid_login($member);'.chr(10).'// Guest or banned',$code); // Thread our code into the main users.php member retrieval code

	if (is_file(get_custom_file_base().'/sources_custom/facebook_connect.php'))
		$code=str_replace('// Guest or banned','$member=check_facebook_login($member);'.chr(10).'// Guest or banned',$code); // Thread our code into the main users.php member retrieval code

	return $code;
}

/**
 * Find whether the current member is logged in via httpauth.
 *
 * @return boolean		Whether the current member is logged in via httpauth
 */
function is_httpauth_login()
{
	if (get_forum_type()!='ocf') return false;
	if (is_guest()) return false;
	
	if (array_key_exists('REDIRECT_REMOTE_USER',$_SERVER))
		$_SERVER['PHP_AUTH_USER']=preg_replace('#@.*$#','',$_SERVER['REDIRECT_REMOTE_USER']);
	if (array_key_exists('PHP_AUTH_USER',$_SERVER))
		$_SERVER['PHP_AUTH_USER']=preg_replace('#@.*$#','',$_SERVER['PHP_AUTH_USER']);
	if (array_key_exists('REMOTE_USER',$_SERVER))
		$_SERVER['PHP_AUTH_USER']=preg_replace('#@.*$#','',$_SERVER['REMOTE_USER']);

	/*if ($GLOBALS['FORUM_DRIVER']->get_member_row_field(get_member(),'m_password_compat_scheme')=='httpauth')
		return true;*/

	$compat=$GLOBALS['FORUM_DRIVER']->get_member_row_field(get_member(),'m_password_compat_scheme');
	if (($compat=='facebook') || ($compat=='openid'))
	{
		global $SESSION_CONFIRMED;
		$SESSION_CONFIRMED=1;
	}

	require_code('ocf_members');
	return ((array_key_exists('PHP_AUTH_USER',$_SERVER)) && (!is_null(ocf_authusername_is_bound_via_httpauth($_SERVER['PHP_AUTH_USER']))));
}

function check_facebook_login($member)
{
	// Facebook connect
	if ((get_forum_type()=='ocf')/* && ((is_null($member)) || (is_guest($member)))*/)
	{
		require_code('facebook_connect');
		$facebook_cookie=get_facebook_cookie();
		if ((!is_null($facebook_cookie)) && (array_key_exists('uid',$facebook_cookie)))
		{
			$member=handle_facebook_connection_login($facebook_cookie,$member);
		}
	}
	return $member;
}

function check_openid_login($member)
{
	//if ((!is_null($member)) && (!is_guest($member))) return $member;

	try
	{
		require_code('openid');
		require_code('developer_tools');

		if(!isset($_REQUEST['openid_mode']))
		{
			if(array_key_exists('openid_identifier',$_POST))
			{
				destrictify();

				$openid = new LightOpenID;
				$openid->identity = $_POST['openid_identifier'];
				$openid->required = array(
					'namePerson/friendly',
					'namePerson',
					'contact/email',
					'birthDate',
					'pref/language',
					'media/image/default',
				);
				header('Location: ' . $openid->authUrl());
				exit();
			}
		} elseif($_GET['openid_mode'] == 'cancel')
		{
			destrictify();

			require_code('site');
			require_code('site2');
			attach_message('You cancelled your OpenID login, so you are not logged into the site.','inform');
		} else
		{
			destrictify();

			$openid = new LightOpenID();

			if ($openid->validate())
			{
				$attributes=$openid->getAttributes();

				$member=$GLOBALS['FORUM_DB']->query_value_null_ok('f_members','id',array('m_password_compat_scheme'=>'openid','m_pass_hash_salted'=>$openid->identity));
				if (!is_null($member))
				{
					// We are not a normal cookie login so ocPortal has loaded up a Guest session already in the expectation of keeping it. Unsetting it will force a rebind (existing session may be reused though)
					require_code('users_inactive_occasionals');
					set_session_id(-1);

					return $member;
				}

				require_code('ocf_members');
				require_code('ocf_groups');
				require_lang('ocf');

				if ((running_script('index')) || (running_script('execute_temp')))
				{
					require_code('ocf_members_action');
					require_code('ocf_members_action2');

					$email='';
					if (array_key_exists('contact/email',$attributes)) $email=$attributes['contact/email'];
					$_POST['email_address']=$email;

					$username=$openid->identity; // Yuck, we'll try and build on this
					if (array_key_exists('namePerson/friendly',$attributes)) $username=$attributes['namePerson/friendly'];
					elseif (array_key_exists('namePerson',$attributes)) $username=$attributes['namePerson'];
					elseif ($email!='') $username=substr($email,0,strpos($email,'@'));

					if (($username!='') && ($type!='ldap'))
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

					$dob='';
					if (array_key_exists('birthDate',$attributes)) $dob=$attributes['birthDate'];
					if ($dob!='')
					{
						$dob_bits=explode('-',$dob);
						$_POST['dob_day']=$dob_bits[2];
						$_POST['dob_month']=$dob_bits[1];
						$_POST['dob_year']=$dob_bits[0];
					}

					$_POST['language']='';
					if (array_key_exists('pref/language',$attributes)) $_POST['language']=$attributes['pref/language'];

					require_code('config2');
					set_option('maximum_password_length','1000');
					$member=ocf_member_external_linker($username,$openid->identity,'openid',false);

					$avatar='';
					if (array_key_exists('media/image/default',$attributes)) $avatar=$attributes['media/image/default'];
					ocf_member_choose_avatar($avatar,$member);
				}

				if (!is_null($member))
				{
					// We are not a normal cookie login so ocPortal has loaded up a Guest session already in the expectation of keeping it. Unsetting it will force a rebind (existing session may be reused though)
					require_code('users_inactive_occasionals');
					set_session_id(-1);
				}

				delete_expired_sessions($member);
			} else
			{
				require_code('site');
				require_code('site2');
				attach_message('An unknown error occurred during OpenID login.','warn');
			}
		}
	}
	
	catch(ErrorException $e)
	{
		require_code('site');
		require_code('site2');
		attach_message($e->getMessage(),'warn');
	}
	
	return $member;
}
