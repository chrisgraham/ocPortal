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

	function syndication_javascript()
	{
		require_code('facebook_connect');
		facebook_install();

		if (get_option('facebook_member_syndicate_to_page')=='0') return '';

		require_lang('facebook');

		return "
			var fb_button=document.getElementById('syndicate_start__facebook');
			if (fb_button)
			{
				var fb_input;
				if (typeof fb_button.form.elements['facebook_syndicate_to_page']=='undefined')
				{
					fb_input=document.createElement('input');
					fb_input.type='hidden';
					fb_input.name='facebook_syndicate_to_page';
					fb_input.value='0';
					fb_button.form.appendChild(fb_input);
				} else
				{
					fb_input=fb_button.form.elements['facebook_syndicate_to_page'];
				}
				fb_button.onclick=function() {
					generate_question_ui(
						'".addslashes(do_lang('HOW_TO_SYNDICATE_DESCRIPTION'))."',

						['".addslashes(do_lang('INPUTSYSTEM_CANCEL'))."','".addslashes(do_lang('FACEBOOK_PAGE'))."','".addslashes(do_lang('FACEBOOK_WALL'))."'],

						'".addslashes(do_lang('HOW_TO_SYNDICATE'))."',

						'".addslashes(do_lang('SYNDICATE_TO_OWN_WALL',get_site_name()))."',

						function(val) {
							if (val!='".addslashes(do_lang('INPUTSYSTEM_CANCEL'))."')
							{
								fb_input.value=(val=='".addslashes(do_lang('FACEBOOK_PAGE'))."')?'1':'0';
								fb_button.onclick=null;
								click_link(fb_button);
							}
						}
					);

					return false;
				};
			}
		";
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

			$facebook_syndicate_to_page=get_param('facebook_syndicate_to_page',NULL);
			if ($facebook_syndicate_to_page!==NULL)
				set_long_value('facebook_syndicate_to_page__'.strval($member_id),$facebook_syndicate_to_page);
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
			$page_syndicate=(get_option('facebook_member_syndicate_to_page')=='1' && get_option('facebook_uid')!='' && get_long_value('facebook_syndicate_to_page__'.strval($member_id))==='1');
			return $this->_send(
				get_long_value('facebook_oauth_token__'.strval($member_id)),
				$row,
				$page_syndicate?get_option('facebook_uid'):'me',
				$member_id,
				$page_syndicate
			);
		}
		return false;
	}

	function auth_is_set_site()
	{
		global $FACEBOOK_CONNECT;
		if (!isset($FACEBOOK_CONNECT)) return false;

		if (get_long_value('facebook_oauth_token')===NULL) return false;

		if (get_option('facebook_uid')=='') return false; // No configured target

		if (($this->auth_is_set(get_member())) && (get_option('facebook_uid')==strval($FACEBOOK_CONNECT->getUser())))
		{
			return false; // Avoid double syndication, will already go to the user
		}

		return true;
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

	function _send($token,$row,$post_to_uid='me',$member_id=NULL,$silent_warn=false)
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

			if (!$silent_warn)
				attach_message($e->getMessage(),'warn');
		}

		return true;
	}
}


