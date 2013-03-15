{TITLE}

{+START,INCLUDE,handle_conflict_resolution}{+END}

<p>
	{!DESCRIPTION_BANNED_ADDRESSES_A}
</p>

<p>
	{!DESCRIPTION_BANNED_ADDRESSES_B}
</p>

<form title="{!PRIMARY_PAGE_FORM}" action="{URL*}" method="post">
	<div>
		<label for="bans" class="field_name">{!BANNED_ADDRESSES}:</label>
	</div>
	<div class="constrain_field">
		<textarea cols="30" rows="14" class="wide_field textarea_scroll" id="bans" name="bans">{BANS*}</textarea>
	</div>

	<div class="proceed_button">
		<input accesskey="u" onclick="disable_button_just_clicked(this);" class="button_page" type="submit" value="{!SAVE}" />
	</div>
</form>

