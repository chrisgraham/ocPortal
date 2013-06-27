<?php

require_code('developer_tools');
destrictify();

require_code('facebook/facebook');
require_lang('facebook');

$title=get_screen_title('FACEBOOK_OAUTH');

$facebook_appid=get_option('facebook_appid',true);

if (is_null($facebook_appid))
{
	require_code('facebook_connect');
	facebook_install();

	$facebook_appid='';
}

if ($facebook_appid=='')
{
	$config_url=build_url(array('page'=>'admin_config','type'=>'category','id'=>'FEATURE','redirect'=>get_self_url(true)),'_SELF',NULL,false,false,false,'group_FACEBOOK_SYNDICATION');
	require_code('site2');
	assign_refresh($config_url,0.0);
	$echo=do_template('REDIRECT_SCREEN',array('_GUID'=>'056998219c2fb3e4872e33e9041e2614','URL'=>$config_url,'TITLE'=>$title,'TEXT'=>do_lang_tempcode('FACEBOOK_SETUP_FIRST')));
	$echo->evaluate_echo();
	return;
}

require_code('hooks/systems/syndication/facebook');
$ob=new Hook_Syndication_facebook();

$result=$ob->auth_set(NULL,get_self_url(false,false,array('oauth_in_progress'=>1)));

if ($result)
{
	$out=do_lang_tempcode('FACEBOOK_OAUTH_SUCCESS');
} else
{
	$out=do_lang_tempcode('SOME_ERRORS_OCCURRED');
}

$title->evaluate_echo();

$out->evaluate_echo();
