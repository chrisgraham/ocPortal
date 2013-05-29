<div id="fb-root"></div>
{+START,IF_NON_EMPTY,{$CONFIG_OPTION,facebook_appid}}
	<script type="text/javascript">// <![CDATA[
		facebook_init('{$CONFIG_OPTION;,facebook_appid}','{$BASE_URL;}/facebook_connect.php',{$?,{$FB_CONNECT_LOGGED_OUT},true,false},{$?,{$IS_EMPTY,{$FB_CONNECT_UID}},null,{$FB_CONNECT_UID}},'{$PAGE_LINK;,:}','{$PAGE_LINK;,:login:logout}');
	//]]></script>
{+END}
