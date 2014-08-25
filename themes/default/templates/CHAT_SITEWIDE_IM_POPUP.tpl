<div class="sitewide_im_popup">
	{CONTENT}

	<form title="{!SOUND_EFFECTS}" action="index.php" method="post" class="inline">
		<div>
			<label for="play_sound">{!SOUND_EFFECTS}:</label> <input type="checkbox" id="play_sound" name="play_sound" checked="checked" />
		</div>
	</form>
</div>

<script type="text/javascript">// <![CDATA[
	window.setInterval(function()
		{
			try
			{
				if ((!window.opener) || (!window.opener.document) || (typeof window.opener.opened_popups['room_'+room_id]=="undefined") || (window.opener.opened_popups['room_'+room_id])!=window)
				{
					window.onbeforeunload=null;
					window.close();
				}
			}
			catch(err)
			{
				window.onbeforeunload=null;
				window.close();
			}
		},1000);
//]]></script>
