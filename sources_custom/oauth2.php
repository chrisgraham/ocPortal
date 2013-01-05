<?php

function init__oauth2()
{
	require_lang('oauth2');
}

function ensure_got_oauth_api_key($service_name) // This is generic so can work with oauth1
{
	$api_key=get_option($service_name.'_key',true);

	if (is_null($api_key))
	{
		install_oauth_settings_for($service_name);
		$api_key='';
	}

	if ($api_key=='')
	{
		$title=get_screen_title('OAUTH_TITLE',true,array($service_name));

		$config_url=build_url(array('page'=>'admin_config','type'=>'category','id'=>'FEATURE','redirect'=>get_self_url(true)),'_SELF',NULL,false,false,false,'group_GALLERY_SYNDICATION');
		require_code('site2');
		assign_refresh($config_url,0.0);
		$echo=do_template('REDIRECT_SCREEN',array('URL'=>$config_url,'TITLE'=>$title,'TEXT'=>do_lang_tempcode('OAUTH_SETUP_FIRST',$service_name)));
		$echo->evaluate_echo();
		return;
	}
}

function install_oauth_settings_for($service_name) // This is generic so can work with oauth1
{
	require_code('database_action');

	add_config_option(strtoupper($service_name).'_KEY',$service_name.'_key','line','return \'\';','FEATURE','GALLERY_SYNDICATION');
	add_config_option(strtoupper($service_name).'_CLIENT_SECRET',$service_name.'_client_secret','line','return \'\';','FEATURE','GALLERY_SYNDICATION');
}

function handle_oauth($service_name,$service_title,$auth_url)
{
	$title=get_screen_title('OAUTH_TITLE',true,array($service_name));

	$api_key=ensure_got_oauth_api_key($service_name);

	if (get_param('state','')!='authorized')
	{
		$auth_url=str_replace('_API_KEY_',$api_key,$auth_url);
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
			'client_id'=>$api_key,
			'client_secret'=>get_option($service_name.'_client_secret'),
			'redirect_uri'=>get_base_url(),
			'grant_type'=>'authorization_code',
		);

		$result=http_download_file('https://accounts.google.com/o/oauth2/token',NULL,true,false,'ocPortal',$post_params);
		$parsed_result=json_decode($result);

		set_long_value($service_name.'_refresh_token',$parsed_result['refresh_token']);

		$out=do_lang_tempcode('OAUTH_SUCCESS',$service_name);
	} else
	{
		$out=do_lang_tempcode('SOME_ERRORS_OCCURRED');
	}

	$title->evaluate_echo();

	$out->evaluate_echo();
}

function refresh_oauth($url,$client_id,$client_secret,$refresh_token)
{
	$post_params=array(
		'client_id'=>get_option('youtube_key'),
		'client_secret'=>get_option('youtube_secret'),
		'refresh_token'=>get_value('youtube_refresh_token'),
		'grant_type'=>'refresh_token',
	);

	require_code('files');

	$result=http_download_file('https://accounts.google.com/o/oauth2/token',NULL,true,false,'ocPortal',$post_params);
	$parsed_result=json_decode($result);

	if (!array_key_exists('access_token',$parsed_result))
	{
		warn_exit(do_lang_tempcode('ERROR_OBTAINING_ACCESS_TOKEN'));
	}

	return $parsed_result['access_token'];
}
