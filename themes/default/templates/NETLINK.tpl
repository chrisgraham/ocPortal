<form title="{!JUMP} ({!FORM_AUTO_SUBMITS})" method="get" action="{$FIND_SCRIPT*,netlink}">
	<div>
		<div class="constrain_field">
			<p class="accessibility_hidden"><label for="netlink_url">{!JUMP}</label></p>
			<select{+START,IF,{$JS_ON}} onchange="this.form.submit();"{+END} id="netlink_url" name="url" class="wide_field">
				{CONTENT}
			</select>
		</div>
		{+START,IF,{$NOT,{$JS_ON}}}
			<div class="constrain_field">
				<input onclick="disable_button_just_clicked(this);" type="submit" value="{!PROCEED}" class="wide_button" />
			</div>
		{+END}
	</div>
</form>

