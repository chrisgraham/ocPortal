{+START,IF_PASSED,MSG}
	<p>
		{MSG}
	</p>
{+END}

<section class="box box___block_main_newsletter_signup"><div class="box_inner">
	<h3>{!NEWSLETTER}{$?,{$NEQ,{NEWSLETTER_TITLE},{!GENERAL}},: {NEWSLETTER_TITLE*}}</h3>

	<form title="{!NEWSLETTER}" onsubmit="if ((check_field_for_blankness(this.elements['address'],event)) &amp;&amp; (this.elements['address{NID*}'].value.match(/^[a-zA-Z0-9\._\-\+]+@[a-zA-Z0-9\._\-]+$/))) { disable_button_just_clicked(this); return true; } window.fauxmodal_alert('{!NOT_A_EMAIL;=*}'); return false;" action="{URL*}" method="post">
		{$INSERT_SPAMMER_BLACKHOLE}

		<p class="accessibility_hidden"><label for="baddress">{!EMAIL_ADDRESS}</label></p>

		<div class="constrain_field">
			<input class="wide_field" id="baddress" name="address{NID*}" onfocus="if (this.value=='{!EMAIL_ADDRESS;}') this.value='';" onblur="if (this.value=='') this.value='{!EMAIL_ADDRESS;}';" value="{!EMAIL_ADDRESS}" />
		</div>

		<p>
			<input class="wide_button" type="submit" value="{!SUBSCRIBE}" />
		</p>
	</form>
</div></section>
