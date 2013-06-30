<?php

require_code('developer_tools');
destrictify();

require_code('twitter');
require_lang('twitter');

$title=get_screen_title('TWITTER_OAUTH');

$api_key=get_option('twitter_api_key',true);
$api_secret=get_option('twitter_api_secret',true);

if (is_null($api_key))
{
	require_code('database_action');

	add_config_option('TWITTER_API_KEY','twitter_api_key','line','return \'\';','FEATURE','TWITTER_SYNDICATION');
	add_config_option('TWITTER_API_SECRET','twitter_api_secret','line','return \'\';','FEATURE','TWITTER_SYNDICATION');
	/*
	delete_config_option('twitter_api_key');
	delete_config_option('twitter_api_secret');
	*/

	$api_key='';
	$api_secret='';
}

if ($api_key=='' || $api_secret=='')
{
	$config_url=build_url(array('page'=>'admin_config','type'=>'category','id'=>'FEATURE','redirect'=>get_self_url(true)),'_SELF',NULL,false,false,false,'group_TWITTER_SYNDICATION');
	require_code('site2');
	assign_refresh($config_url,0.0);
	$echo=do_template('REDIRECT_SCREEN',array('_GUID'=>'18fe4234d995bd855331cc9a6f66b3e5','URL'=>$config_url,'TITLE'=>$title,'TEXT'=>do_lang_tempcode('TWITTER_SETUP_FIRST')));
	$echo->evaluate_echo();
	return;
}

require_code('hooks/systems/syndication/twitter');
$ob=new Hook_Syndication_twitter();

$result=$ob->auth_set(NULL,get_self_url(false,false,array('oauth_in_progress'=>1)));

if ($result)
{
	$out=do_lang_tempcode('TWITTER_OAUTH_SUCCESS');
} else
{
	$out=do_lang_tempcode('SOME_ERRORS_OCCURRED');
}

$title->evaluate_echo();

$out->evaluate_echo();
