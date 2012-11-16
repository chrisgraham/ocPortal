<section class="box box___block_main_facebook_friends"><div class="box_inner">
	{+START,IF_NON_EMPTY,{TITLE}}<h3>{TITLE}</h3>{+END}

	<script type="text/javascript" src="http://static.ak.connect.facebook.com/connect.php/en_US"></script>

	<script type="text/javascript">
	FB.init({
		appId: '{$CONFIG_OPTION*;,facebook_appid}',
		channelUrl: '{$BASE_URL*;}/facebook_connect.php',
		status: true,
		cookie: true,
		xfbml: true
	});
	</script>

	<div class="fb-fan" data-profile_id="{$CONFIG_OPTION*,facebook_uid}" data-stream="{STREAM}" data-connections="{FANS}" data-logobar="{LOGOBAR}" data-width="300"></div>

	{+START,IF,{SHOW_FANPAGE_LINK}}
		<div style="font-size:8px; padding-left:10px">
			<a href="http://www.facebook.com/pages/redirect/{$CONFIG_OPTION*,facebook_uid}">{FANPAGE_NAME}</a> on Facebook
		</div>
	{+END}
</div></section>
