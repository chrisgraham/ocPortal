<div class="box" role="marquee"><div class="box_inner">
	{MESSAGES}

	<form title="{!SHOUTBOX}" onsubmit="if (check_field_for_blankness(this.elements['shoutbox_message'],event)) { disable_button_just_clicked(this); return true; } return false;" target="_self" action="{URL*}" method="post">
		<div class="constrain_field">
			<p class="accessibility_hidden"><label for="shoutbox_message">{!MESSAGE}</label></p>
			<input autocomplete="off" value="" type="text" onfocus="if (this.value=='{!MESSAGE;}') this.value='';" id="shoutbox_message" name="shoutbox_message" alt="{!MESSAGE}" class="wide_field" />
		</div>

		<p class="proceed_button">
			<input type="submit" value="{!SEND_MESSAGE}" class="wide_button" />
		</p>
	</form>
</div></div>
