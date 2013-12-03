{+START,INCLUDE,BLOCK_TOP_LOGIN}{+END}

{+START,IF_NON_EMPTY,{$CONFIG_OPTION,facebook_appid}}
	{+START,IF_EMPTY,{$FB_CONNECT_UID}}
		<div class="fb-login-button" data-scope="email,user_birthday{+START,IF,{$CONFIG_OPTION,facebook_auto_syndicate}},publish_stream,offline_access{+END}"></div>
	{+END}
{+END}
