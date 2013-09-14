<?php

function init__oauth()
{
	require_lang('oauth');
}

function ensure_got_oauth_client_id($service_name,$has_sep_key=false)
{
	$client_id=get_option($service_name.'_client_id');

	if ($client_id=='')
	{
		$title=get_screen_title('OAUTH_TITLE',true,array($service_name));

		$config_url=build_url(array('page'=>'admin_config','type'=>'category','id'=>'FEATURE','redirect'=>get_self_url(true)),'_SELF',NULL,false,false,false,'group_GALLERY_SYNDICATION');
		require_code('site2');
		assign_refresh($config_url,0.0);
		$echo=do_template('REDIRECT_SCREEN',array('URL'=>$config_url,'TITLE'=>$title,'TEXT'=>do_lang_tempcode('OAUTH_SETUP_FIRST',$service_name)));
		$echo->evaluate_echo();
		exit();
	}

	return $client_id;
}

/*
The following is ocPortal's oAuth2 implementation.
oAuth2 is simpler than oAuth1, because SSL is used for encryption, rather than a complex native implementation.
*/

function retrieve_oauth2_token($service_name,$service_title,$auth_url,$endpoint)
{
	$title=get_screen_title('OAUTH_TITLE',true,array($service_name));

	$client_id=ensure_got_oauth_client_id($service_name);

	if (get_param('state','')!='authorized')
	{
		$auth_url=str_replace('_CLIENT_ID_',$client_id,$auth_url);
		require_code('site2');
		assign_refresh($auth_url,0.0);
		$echo=do_template('REDIRECT_SCREEN',array('URL'=>$auth_url,'TITLE'=>$title,'TEXT'=>do_lang_tempcode('REDIRECTING')));
		$echo->evaluate_echo();
		return;
	}

	$code=get_param('code','');

	if ($code!='')
	{
		$post_params=array(
			'code'=>$code,
			'client_id'=>$client_id,
			'client_secret'=>get_option($service_name.'_client_secret'),
			'redirect_uri'=>static_evaluate_tempcode(build_url(array('page'=>'_SELF'),'_SELF',NULL,false,false,true)),
			'grant_type'=>'authorization_code',
		);

		$result=http_download_file($endpoint.'/token',NULL,true,false,'ocPortal',$post_params);
		$parsed_result=json_decode($result);
		set_long_value($service_name.'_refresh_token',$parsed_result->refresh_token);

		$out=do_lang_tempcode('OAUTH_SUCCESS',$service_name);
	} else
	{
		$out=do_lang_tempcode('SOME_ERRORS_OCCURRED');
	}

	$title->evaluate_echo();

	$out->evaluate_echo();
}

function refresh_oauth2_token($service_name,$url,$client_id,$client_secret,$refresh_token,$endpoint)
{
	$post_params=array(
		'client_id'=>get_option($service_name.'_client_id'),
		'client_secret'=>get_option($service_name.'_client_secret'),
		'refresh_token'=>get_long_value($service_name.'_refresh_token'),
		'grant_type'=>'refresh_token',
	);

	require_code('files');

	$result=http_download_file($endpoint.'/token',NULL,true,false,'ocPortal',$post_params);
	$parsed_result=json_decode($result);

	if (!array_key_exists('access_token',$parsed_result))
	{
		warn_exit(do_lang_tempcode('ERROR_OBTAINING_ACCESS_TOKEN'));
	}

	return $parsed_result->access_token;
}
