{+START,BOX,{TITLE},,{$?,{$GET,in_panel},panel,classic},tray_closed}
	<script type="text/javascript" src="http://static.ak.connect.facebook.com/connect.php/en_US"></script>

	<script type="text/javascript">FB.init("40d2a3e3af18f7a6928882d0ea1bdea1");</script>
	<div xmlns:fb="http://api.facebook.com/1.0/">
		<fb:fan profile_id="{FAN_PROFILE_ID}" stream="{STREAM}" connections="{FANS}" logobar="{LOGOBAR}" width="300"></fb:fan>

		{+START,IF,{SHOW_FANPAGE_LINK}}
			<div style="font-size:8px; padding-left:10px"><a href="http://www.facebook.com/pages/redirect/{FAN_PROFILE_ID}">{FANPAGE_NAME}</a> on Facebook</div>
		{+END}
	</div>
{+END}
