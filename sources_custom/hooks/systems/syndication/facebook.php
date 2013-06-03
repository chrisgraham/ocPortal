<?php

class Hook_Syndication_facebook
{
	function get_service_name()
	{
		return 'Facebook';
	}

	function is_available()
	{
		$appapikey=get_option('facebook_appid',true);
		if (is_null($appapikey)) return false;
		$appsecret=get_option('facebook_secret_code');
		if (($appapikey=='') || ($appsecret=='')) return false;

		return true;
	}

	function auth_is_set($member_id)
	{
		$save_to='facebook_oauth_token';
		if (!is_null($member_id)) $save_to.='__'.strval($member_id);
		return get_long_value($save_to)!==NULL;
	}

	function auth_set($member_id,$oauth_url)
	{
		require_lang('facebook');
		require_code('facebook_connect');
		global $FACEBOOK_CONNECT;

		$code=get_param('code','',true);

		if ($code=='')
		{
			$oauth_redir_url=$FACEBOOK_CONNECT->getLoginUrl(array('redirect_uri'=>$oauth_url->evaluate(),'scope'=>array('publish_stream','offline_access')));
		   header('Location: '.$oauth_redir_url);
			exit();
		}

		if (!is_null(get_param('error_reason',NULL))) // oauth happened and ERROR!
		{
			attach_message(do_lang_tempcode('FACEBOOK_OAUTH_FAIL',escape_html(get_param('error_reason'))),'warn');
			return false;
		}

		// oauth apparently worked
		$access_token=$FACEBOOK_CONNECT->getAccessToken();
		if (is_null($access_token)) // Actually it didn't
		{
			attach_message(do_lang_tempcode('FACEBOOK_OAUTH_FAIL',escape_html(do_lang('UNKNOWN'))),'warn');
			return false;
		}

		if (is_null($member_id))
		{
			if (get_option('facebook_uid')=='')
			{
				require_code('config2');
				$facebook_uid=$FACEBOOK_CONNECT->getUser();
				set_option('facebook_uid',strval($facebook_uid));
			}
		}

		if ((strpos($access_token,'|')===false) || (is_null($member_id))) // If for users, not if application access token, which will happen on a refresh (as user token will not confirm twice)
		{
			$save_to='facebook_oauth_token';
			if (!is_null($member_id)) $save_to.='__'.strval($member_id);
			set_long_value($save_to,$access_token);
		}

		if (get_page_name()!='facebook_oauth') // Take member back to page that implicitly shows their results
		{
			header('Location: '.str_replace('&syndicate_start__facebook=1','',str_replace('oauth_in_progress=1&','oauth_in_progress=0&',$oauth_url->evaluate())));
			exit();
		}

		return true;
	}

	function auth_unset($member_id)
	{
		$save_to='facebook_oauth_token';
		if (!is_null($member_id)) $save_to.='__'.strval($member_id);
		set_long_value($save_to,NULL);
	}

	function syndicate_user_activity($member_id,$row)
	{
		if (($this->is_available()) && ($this->auth_is_set($member_id)))
		{
			return $this->_send(
				get_long_value('facebook_oauth_token__'.strval($member_id)),
				$row,
				'me',
				$member_id
			);
		}
		return false;
	}

	function auth_is_set_site()
	{
		return get_long_value('facebook_oauth_token')!==NULL;
	}

	function syndicate_site_activity($row)
	{
		if (($this->is_available()) && ($this->auth_is_set_site()))
		{
			return $this->_send(
				get_value('facebook_oauth_token'),
				$row,
				get_option('facebook_uid')
			);
		}
		return false;
	}

	function _send($token,$row,$post_to_uid='me',$member_id=NULL)
	{
		require_lang('facebook');
		require_code('facebook_connect');

		// Prepare message
		list($message)=render_activity($row,false);
		$name=$row['a_label_1'];
		require_code('character_sets');
		$name=convert_to_internal_encoding($name,get_charset(),'utf-8');
		$link=($row['a_pagelink_1']=='')?'':static_evaluate_tempcode(pagelink_to_tempcode($row['a_pagelink_1']));
		$message=strip_html($message->evaluate());
		$message=convert_to_internal_encoding($message,get_charset(),'utf-8');

		// Send message
		$appid=get_option('facebook_appid');
		$appsecret=get_option('facebook_secret_code');
		$fb=new ocpFacebook(array('appId'=>$appid,'secret'=>$appsecret));
		$fb->setAccessToken($token);

		$attachment=array('description'=>$message);
		if (($name!='') && ($name!=$message)) $attachment['name']=$name;
		if ($link!='') $attachment['link']=$link;
		if (count($attachment)==1) $attachment=array('message'=>$message);

		if ($post_to_uid=='me') $post_to_uid=$fb->getUser(); // May not be needed, but just in case

		try
		{
			$ret=$fb->api('/'.$post_to_uid.'/feed','POST',$attachment);
		}
		catch (Exception $e)
		{
			if ((!is_null($member_id)) && (count($_POST)==0))
			{
				$this->auth_set($member_id,get_self_url());
			}

			attach_message($e->getMessage(),'warn');
		}

		return true;
	}
}


