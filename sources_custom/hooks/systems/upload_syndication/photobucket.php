<?php

class Hook_upload_syndication_photobucket
{
	var $_api=NULL;

	function _get_api()
	{
		if (is_null($this->_api))
		{
			@ini_set('ocproducts.type_strictness','0');
			require_code('photobucket/PBAPI');
			$this->_api=new PBAPI(get_option('photobucket_client_id'),get_option('photobucket_client_secret'));
		}
		return $this->_api;
	}

	function get_label()
	{
		return 'Photobucket';
	}

	function get_file_handling_types()
	{
		return OCP_UPLOAD_IMAGE | OCP_UPLOAD_VIDEO;
	}

	function is_enabled()
	{
		return get_option('photobucket_client_id')!='' && get_option('photobucket_client_secret')!='';
	}

	function happens_always()
	{
		return false;
	}

	function get_reference_precedence()
	{
		return UPLOAD_PRECEDENCE_HIGH;
	}

	function is_authorised()
	{
		return get_long_value('photobucket_oauth_key__'.strval(get_member()))!==NULL;
	}

	function receive_authorisation()
	{
		if ($this->is_authorised()) return true;

		$api=$this->_get_api();

		// Handle oAuth result, store key
		if (get_param_integer('oauth_token',NULL)!==NULL) // This is a response to a particular 'request' token (referred to in oauth_token), requesting an access token
		{
			// Request the 'access' token, that should have just been generated for us
			$api->login('access');
			$api->post();
			$api->loadTokenFromResponse();
			$token=$api->getOAuthToken();

			set_long_value('photobucket_oauth_key__'.strval(get_member()),$token->getKey());
			set_long_value('photobucket_oauth_secret__'.strval(get_member()),$token->getSecret());
			set_long_value('photobucket_oauth_username__'.strval(get_member()),$api->getUsername());
			set_long_value('photobucket_oauth_subdomain__'.strval(get_member()),$api->getSubdomain());

			return true;
		} else // Pass through authorisation
		{
			// Generate a 'request' token
			$api->login('request');
			$api->post();
			$api->loadTokenFromResponse();
			//$token=$api->getOAuthToken();

			$api->goRedirect('login'); // Request an 'access' token to be generated for us
			exit();
		}

		return false;
	}

	function syndicate($url,$filename,$title,$description)
	{
		require_lang('video_syndication_photobucket');

		// Fix to correct file extensions
		$filename=preg_replace('#\.f4v#','.flv',$filename);
		$filename=preg_replace('#\.m2v#','.mpg',$filename);
		$filename=preg_replace('#\.mpv2#','.mpg',$filename);
		$filename=preg_replace('#\.mp2#','.mpg',$filename);
		$filename=preg_replace('#\.m4v#','.mp4',$filename);
		$filename=preg_replace('#\.ram#','.rm',$filename);
		require_code('files');
		$filetype=get_file_extension($filename);
		if (in_array($filetype,array('ogg','ogv','webm','pdf')))
		{
			if (!$this->happens_always())
				attach_message(do_lang_tempcode('PHOTOBUCKET_BAD_FILETYPE',escape_html($filetype)),'warn');
			return NULL;
		}

		try
		{
			$api=$this->_get_api();
			$api->setResponseParser('phpserialize');
			$api->setOAuthToken(
				get_long_value('photobucket_oauth_key__'.strval(get_member())),
				get_long_value('photobucket_oauth_secret__'.strval(get_member())),
				get_long_value('photobucket_oauth_username__'.strval(get_member()))
			);
			$api->setSubdomain(get_long_value('photobucket_oauth_subdomain__'.strval(get_member())));
			$api->login('access');
			$api->post();
			$api->loadTokenFromResponse();

			$remote_gallery_name=preg_replace('#[^A-Za-z\d\_\- ]#','',get_site_name());
			$call_params=array(
				'name'=>$remote_gallery_name,
			);
			$api->album('-',$call_params);
			$api->post();
			$response=$api->getParsedResponse(true);

			$call_params=array(
				'type'=>is_image($filename)?'image':'video',
				'uploadfile'=>$url,
				'filename'=>$filename,
				'title'=>$title,
				'description'=>$description,
			);
			$api->upload($remote_gallery_name,$call_params);
			$api->get();
			$response=$api->getParsedResponse(true);
			return $response->content->url;
		}
		catch (PBAPI_Exception_Response $e)
		{
			attach_message(do_lang_tempcode('PHOTOBUCKET_ERROR',escape_html($e->getCode()),escape_html($e->getMessage()),escape_html(get_site_name())));
		}
		catch (PBAPI_Exception $e)
		{
			attach_message(do_lang_tempcode('PHOTOBUCKET_ERROR',escape_html($e->getCode()),escape_html($e->getMessage()),escape_html(get_site_name())));
		}
		
		return NULL;
	}
}
