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
		if(($appapikey=='') || ($appsecret=='')) return false;

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

		$facebook_uid=$FACEBOOK_CONNECT->getUser();

		// Save in two parts, as too long
		$save_to='facebook_oauth_token';
		if (!is_null($member_id)) $save_to.='__'.strval($member_id);
		set_long_value($save_to,$access_token);

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
				get_value('facebook_oauth_token__'.strval($member_id)),
				$row
			);
		}
		return false;
	}

	function auth_is_set_site()
	{
		return get_value('facebook_oauth_token')!==NULL;
	}

	function syndicate_site_activity($row)
	{
		if (($this->is_available()) && ($this->auth_is_set_site()))
		{
			return $this->_send(
				get_value('facebook_oauth_token'),
				$row
			);
		}
		return false;
	}

	function _send($token,$row)
	{
		require_lang('facebook');
		require_code('facebook_connect');

		// Prepare message
		list($message)=render_activity($row);
		$name=$row['a_label_1'];
		require_code('character_sets');
		$name=convert_to_internal_encoding($name,get_charset(),'utf-8');
		$link=static_evaluate_tempcode(pagelink_to_tempcode($row['a_pagelink_1']));
		$message=html_entity_decode(strip_tags($message->evaluate()),ENT_COMPAT,get_charset());
		$message=convert_to_internal_encoding($message,get_charset(),'utf-8');

		$post_to_uid=get_option('facebook_uid');

		// Send message
		global $FACEBOOK_CONNECT;
		$attachment=array('description'=>$message);
		if ($name!='') $attachment['name']=$name;
		if ($link!='') $attachment['link']=$link;
		try
		{
			$ret=$FACEBOOK_CONNECT->api('/'.$post_to_uid.'/feed','POST',$attachment);
		}
		catch (Exception $e)
		{
			if ($e->getMessage()=='(#200) The user hasn\'t authorized the application to perform this action')
			{
		      header('Location: '.$oauth_redir_url);
				exit();
			} else fatal_exit($e->getMessage());
		}

		return true;
	}
}


