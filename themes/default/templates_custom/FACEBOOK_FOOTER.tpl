<div id="fb-root"></div>
{+START,IF_NON_EMPTY,{$CONFIG_OPTION,facebook_appid}}
	<script type="text/javascript">// <![CDATA[
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
				if (response.status=='connected' && response.authResponse) {
					{$,If ocP is currently logging out, tell FB connect to disentangle}
					{$,Must have JS FB login before can instruct to logout. Will not re-auth -- we know we have authed due to FB_CONNECT_LOGGED_OUT being set}
					{+START,IF,{$FB_CONNECT_LOGGED_OUT}}
						FB.logout(function(response) {
							if (typeof window.console!='undefined' && window.console) console.log('Facebook: Logged out.');
						});
					{+END}

					{$,Facebook has automatically rebuilt its expired fbsr cookie, auth.login not triggered as already technically logged in}
					{+START,IF,{$NOT,{$FB_CONNECT_LOGGED_OUT}}}
						{+START,IF_EMPTY,{$FB_CONNECT_UID}}{$,Definitive mismatch between server-side and client-side}
							window.setTimeout(function() { {$,Firefox needs us to wait a bit}
								if ((window.location.href.indexOf('login')!=-1) && (window==window.top))
								{
									window.location='{$PAGE_LINK;,:refreshed_once=1}';
								} else
								{
									var current_url=window.top.location.href;
									if (current_url.indexOf('refreshed_once=1')==-1)
									{
										current_url+=((current_url.indexOf('?')==-1)?'?':'&')+'refreshed_once=1';
										window.top.location=current_url;
									}
									else if (current_url.indexOf('keep_refreshed_once=1')==-1)
									{
										window.alert('Could not login, probably due to restrictive cookie settings.');
										window.location+='&keep_refreshed_once=1';
									}
								}
							},500);
						{+END}
					{+END}

					{+START,IF_NON_EMPTY,{$FB_CONNECT_UID}}{$,No point this code being in the request for non-FB users}
						{$,Map Facebook logout action to logout links}
						var forms=document.getElementsByTagName('form');
						for (var i=0;i<forms.length;i++)
						{
							if (forms[i].action.indexOf('{$PAGE_LINK*;,:login:logout}')!=-1)
							{
								forms[i].onsubmit=function(logout_link) { return function() {
									FB.logout(function(response) {
										if (typeof window.console!='undefined' && window.console) console.log('Facebook: Logged out.');
										window.location=logout_link;
									});
									{$,We cancel the form submit, as we need to wait for the AJAX request to happen}
									return false;
								} }(forms[i].action);
							}
						}
					{+END}
				}
			});

			/*Facebook: Current user is "{$FB_CONNECT_UID*}"*/
			{+START,IF_EMPTY,{$FB_CONNECT_UID}} {$,If not already in an ocPortal Facebook login session}
				FB.Event.subscribe('auth.login',function(response) { {$,New login status arrived - so an ocPortal Facebook login session should be established, or ignore as we are calling a logout within this request (above)}
					{+START,IF,{$NOT,{$FB_CONNECT_LOGGED_OUT}}} {$,Check it is not that logout}
						{$,... and therefore only refresh to let ocPortal adapt, if this was a new login initiated just now on the client side}
						if (response.status=='connected' && response.authResponse) {$,Check we really are logged in, in case this event calls without us being}
						{
							window.setTimeout(function() { {$,Firefox needs us to wait a bit}
								if ((window.location.href.indexOf('login')!=-1) && (window==window.top))
								{
									window.location='{$PAGE_LINK;,:refreshed_once=1}';
								} else
								{
									var current_url=window.top.location.href;
									if (current_url.indexOf('refreshed_once=1')==-1)
									{
										current_url+=((current_url.indexOf('?')==-1)?'?':'&')+'refreshed_once=1';
										window.top.location=current_url;
									}
									else if (current_url.indexOf('keep_refreshed_once=1')==-1)
									{
										window.alert('Could not login, probably due to restrictive cookie settings.');
										window.location+='&keep_refreshed_once=1';
									}
								}
							},500);
						}
					{+END}
				});
			{+END}
		};

		// Load the SDK Asynchronously
		(function(d, s, id) {
			var js, fjs = d.getElementsByTagName(s)[0];
			if (d.getElementById(id)) return;
			js = d.createElement(s); js.id = id;
			js.src = "//connect.facebook.net/en_US/all.js#xfbml=1&appId={$CONFIG_OPTION,facebook_appid}";
			fjs.parentNode.insertBefore(js, fjs);
		}(document, 'script', 'facebook-jssdk'));
	//]]></script>
{+END}
