{+START,IF_PASSED,MSG}
	{MSG}
	<br />
{+END}

{+START,BOX,Sign Up for newsletter,,{$?,{$GET,in_panel},panel,classic}}
	<form onsubmit="if ((check_fieldForBlankness(this.elements['address'],event)) &amp;&amp; (this.elements['address'].value.match(/^[a-zA-Z0-9\._\-\+]+@[a-zA-Z0-9\._\-]+$/))) { disable_button_just_clicked(this); return true; } window.fauxmodal_alert('{!NOT_A_EMAIL;=*}'); return false;" action="{URL*}" method="post">
		{$INSERT_SPAMMER_BLACKHOLE}

		<p class="accessibility_hidden"><label for="baddress">{!EMAIL_ADDRESS}</label></p>

		<div class="constrain_field">
			<input class="search-box" id="baddress" name="address{NID*}" onfocus="if (this.value=='{!EMAIL_ADDRESS;}') this.value='';" onblur="if (this.value=='') this.value='{!EMAIL_ADDRESS;}';" value="{!EMAIL_ADDRESS}" />
		</div>

		<input class="button" type="submit" value="{!SUBSCRIBE}" />
	</form>
{+END}
