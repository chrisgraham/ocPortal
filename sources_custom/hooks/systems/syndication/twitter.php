<?php

class Hook_Syndication_twitter
{
	function get_service_name()
	{
		return 'Twitter';
	}

	function is_available()
	{
		$api_key=get_option('twitter_api_key');
		if ($api_key=='') return false;

		return true;
	}

	function auth_is_set($member_id)
	{
		$save_to='twitter_oauth_token';
		if (!is_null($member_id)) $save_to.='__'.strval($member_id);
		return get_long_value($save_to)!==NULL;
	}

	function auth_set($member_id,$oauth_url)
	{
		require_lang('twitter');
		require_code('twitter');

		$api_key=get_option('twitter_api_key');
		$api_secret=get_option('twitter_api_secret');
		$twitter=new Twitter($api_key,$api_secret);

		if (get_param_integer('oauth_in_progress',0)==0)
		{
			$response=$twitter->oAuthRequestToken($oauth_url->evaluate());
			require_code('site2');
			smart_redirect(Twitter::SECURE_API_URL.'/oauth/authorize?oauth_token='.urlencode($response['oauth_token']));
			exit();
		}

		$response=$twitter->oAuthAccessToken(get_param('oauth_token'),get_param('oauth_verifier'));

		if (!isset($response['oauth_token']))
		{
			attach_message(do_lang_tempcode('TWITTER_OAUTH_FAIL',escape_html($response['message'])),'warn');
			return false;
		}

		$save_to='twitter_oauth_token';
		if (!is_null($member_id)) $save_to.='__'.strval($member_id);
		set_long_value($save_to,$response['oauth_token']);
		$save_to='twitter_oauth_token_secret';
		if (!is_null($member_id)) $save_to.='__'.strval($member_id);
		set_long_value($save_to,$response['oauth_token_secret']);

		return true;
	}

	function auth_unset($member_id)
	{
		$save_to='twitter_oauth_token';
		if (!is_null($member_id)) $save_to.='__'.strval($member_id);
		set_long_value($save_to,NULL);
		$save_to='twitter_oauth_token_secret';
		if (!is_null($member_id)) $save_to.='__'.strval($member_id);
		set_long_value($save_to,NULL);
	}

	function syndicate_user_activity($member_id,$row)
	{
		if (($this->is_available()) && ($this->auth_is_set($member_id)))
		{
			return $this->_send(
				get_long_value('twitter_oauth_token__'.strval($member_id)),get_long_value('twitter_oauth_token_secret__'.strval($member_id)),
				$row
			);
		}
		return false;
	}

	function auth_is_set_site()
	{
		return get_long_value('twitter_oauth_token')!==NULL;
	}

	function syndicate_site_activity($row)
	{
		if (($this->is_available()) && ($this->auth_is_set_site()))
		{
			return $this->_send(
				get_long_value('twitter_oauth_token'),get_long_value('twitter_oauth_token_secret'),
				$row
			);
		}
		return false;
	}

	function _send($token,$secret,$row)
	{
		require_lang('twitter');
		require_code('twitter');

		list($message)=render_activity($row,false);
		$link=static_evaluate_tempcode(pagelink_to_tempcode($row['a_pagelink_1']));

		// Shorten message for Twitter purposes
		$chopped_message=strip_html($message->evaluate());
		$max_length=255;
		$shortened_link=mixed();
		if ($link!='')
		{
			$shortened_link=http_download_file('http://is.gd/api.php?longurl='.urlencode($link));
			$max_length-=strlen($shortened_link)+1;
		}
		if (strlen($chopped_message)>$max_length)
		{
			$chopped_message=substr($chopped_message,0,$max_length-3).'...';
		}
		if ($link!='')
		{
			$chopped_message.=' '.$shortened_link;
		}
		require_code('character_sets');
		$chopped_message=convert_to_internal_encoding($chopped_message,get_charset(),'utf-8');

		require_code('developer_tools');
		destrictify();

		// Initiate Twitter connection
		$api_key=get_option('twitter_api_key');
		$api_secret=get_option('twitter_api_secret');
		$twitter=new Twitter($api_key,$api_secret);
		$twitter->setOAuthToken($token);
		$twitter->setOAuthTokenSecret($secret);

		// Send message
		try
		{
			$twitter->statusesUpdate($chopped_message);
		}
		catch (TwitterException $e)
		{
			attach_message($e->getMessage(),'warn');
			return false;
		}

		return true;
	}
}
