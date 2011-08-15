<div class="standardbox_classic">
	{MESSAGES}

	<form title="{!SHOUTBOX}" onsubmit="if (checkFieldForBlankness(this.elements['shoutbox_message'],event)) { disable_button_just_clicked(this); return true; } return false;" target="_self" action="{URL*}" method="post">
		<div class="constrain_field">
			<p class="accessibility_hidden"><label for="shoutbox_message">{!MESSAGE}</label></p>
			<input value="" type="text" onfocus="if (this.value=='{!MESSAGE;}') this.value='';" id="shoutbox_message" name="shoutbox_message" alt="{!MESSAGE}" class="wide_field" />
		</div>
		<div class="proceed_button">
			<input type="submit" value="{!SEND_MESSAGE}" class="wide_button" />
		</div>
	</form>
	
	<script type="text/javascript">// <![CDATA[
		document.getElementById('shoutbox_message').setAttribute('autocomplete','off');
	//]]></script>
</div>
