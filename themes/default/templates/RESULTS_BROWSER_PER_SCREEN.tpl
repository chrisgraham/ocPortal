<form title="{!PER_PAGE}" action="{$URL_FOR_GET_FORM*,{URL}}" method="get" class="inline" target="_self">
	{HIDDEN}
	<div class="results_browser_per_page">
		<div class="accessibility_hidden"><label for="r_{RAND*}">{!PER_PAGE}: {$GET*,TEXT_ID}</label></div>
		<select id="r_{RAND*}" name="{MAX_NAME*}">
			{SELECTORS}
		</select>
		<input onclick="disable_button_just_clicked(this);" class="button_micro" type="submit" title="{!PER_PAGE}: {$GET*,TEXT_ID}" value="{!PER_PAGE}" />
	</div>
</form>
