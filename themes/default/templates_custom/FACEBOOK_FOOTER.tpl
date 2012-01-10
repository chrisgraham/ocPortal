{+START,IF_NON_EMPTY,{$CONFIG_OPTION,facebook_appid}}
   <div id="fb-root"></div>
 	<script type="text/javascript">
		window.fbAsyncInit=function() {
			FB.init({
				appId: '{$CONFIG_OPTION*;,facebook_appid}',
				channelUrl: '{$BASE_URL*;}/facebook_connect.php',
				status: true,
				cookie: true,
				xfbml: true
			});

			{$,Ignore floods of "Unsafe JavaScript attempt to access frame with URL" errors in Chrome they are benign}

			{$,Calling this effectively waits until the login is active on the client side, which we must do before we can call a log out}
			FB.getLoginStatus(function(response) {
				if (response.status=='connected') {
					{$,If ocP is currently logging out, tell FB connect to disentangle}
					{$,Must have JS FB login before can instruct to logout. Will not re-auth -- we know we have authed due to FB_CONNECT_LOGGED_OUT being set}
					{+START,IF,{$FB_CONNECT_LOGGED_OUT}}
						FB.logout(function(response) {
							if (typeof window.console!='undefined' && window.console) console.log('Logged out.');
						});
					{+END}
				}
			});

			{+START,IF_EMPTY,{$FB_CONNECT_UID}}
				FB.Event.subscribe('auth.login',function() {
					{+START,IF,{$NOT,{$FB_CONNECT_LOGGED_OUT}}}
						{$,Only refresh if this was a new login initiated just now on the client side}
						if (window.location.href.indexOf('login')!=-1)
						{
							window.location='{$SELF_URL;*,1}';
						}
						else
						{
							window.setTimeout(function() { {$,Firefox needs us to wait a bit}
								window.location.reload();
							},500);
						}
					{+END}
				});
			{+END}
		};

		// Load the SDK Asynchronously
		(function(d){
			var js, id = 'facebook-jssdk'; if (d.getElementById(id)) {return;}
			js = d.createElement('script'); js.id = id; js.async = true;
			js.src = "//connect.facebook.net/en_US/all.js";
			d.getElementsByTagName('head')[0].appendChild(js);
		 }(document));
	</script>
{+END}
