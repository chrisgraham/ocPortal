{TITLE}

{+START,INCLUDE,HANDLE_CONFLICT_RESOLUTION}{+END}

<p>
	{!DESCRIPTION_BANNED_ADDRESSES_A}
</p>

<p>
	{!DESCRIPTION_BANNED_ADDRESSES_B}
</p>

<form title="{!PRIMARY_PAGE_FORM}" action="{URL*}" method="post">
	<p class="lonely_label"><label for="bans">{!BANNED_ADDRESSES}:</label></p>
	<div class="constrain_field">
		<textarea cols="30" rows="14" class="wide_field textarea_scroll" id="bans" name="bans">{BANS*}</textarea>
	</div>

	<p class="lonely_label"><label for="locked_bans">{!EXTERNALLY_BANNED_ADDRESSES}:</label></p>
	<div class="constrain_field">
		<textarea readonly="readonly" cols="30" rows="14" class="wide_field textarea_scroll" id="locked_bans" name="locked_bans">{LOCKED_BANS*}</textarea>
	</div>

	<p class="proceed_button">
		<input accesskey="u" onclick="disable_button_just_clicked(this);" class="button_page" type="submit" value="{!SAVE}" />
	</p>
</form>

