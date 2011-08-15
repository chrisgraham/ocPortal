{+START,IF_NON_EMPTY,{$CONFIG_OPTION,facebook_appid}}
   <div id="fb-root"></div>
   <script type="text/javascript" src="http://connect.facebook.net/en_US/all.js#appId={$CONFIG_OPTION*,facebook_appid}&amp;xfbml=1"></script>
   <script type="text/javascript">// <![CDATA[
	   FB.init({appId: '{$CONFIG_OPTION*;,facebook_appid}', status: true,cookie: true, xfbml: true});
		window.setTimeout(function () {
			var logged_in=(ReadCookie('fbs_{$CONFIG_OPTION*;,facebook_appid}')!='');

			{+START,IF,{$FB_CONNECT_LOGGED_OUT}}
				{$,Protection to make sure cookie has gone}
				SetCookie('fbs_{$CONFIG_OPTION*;,facebook_appid}','');
			{+END}

			FB.Event.subscribe('auth.login', function(response) {
				{+START,IF,{$FB_CONNECT_LOGGED_OUT}}
					if (FB.getSession())
						FB.logout();
				{+END}

				{+START,IF,{$NOT,{$FB_CONNECT_LOGGED_OUT}}}
					{$,Protection if Facebook failed to save the cookie}
					if (!logged_in)
					{
						var val='',s=FB.getSession();
						for (var i in s)
						{
							val+=i+'='+window.encodeURIComponent(s[i])+'&';
						}
						SetCookie('fbs_{$CONFIG_OPTION*;,facebook_appid}',val);
					}

					{$,Only refresh if ocPortal would have thought we were not already logged in (if Facebook failed to save the cookie and we made it, Facebook does not like it somehow}
					if (!logged_in)
					{
						if (window.location.href.indexOf('login')!=-1) window.location='{$PAGE_LINK;*,:}'; else window.location.reload();
					}
				{+END}
			});
		}, 0 );
   //]]></script>
{+END}