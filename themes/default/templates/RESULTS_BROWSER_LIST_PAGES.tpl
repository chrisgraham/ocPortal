<form title="{!COUNT_PAGES}" class="inline" action="{$URL_FOR_GET_FORM*,{URL}}" method="get" target="_self">
	<div class="results_browser_pages">
		{HIDDEN}
		<div class="accessibility_hidden"><label for="blp_start{RAND*}">{!COUNT_PAGES}: {$GET*,TEXT_ID}</label></div>
		<select{+START,IF,{$JS_ON}} onchange="this.form.submit();"{+END} id="blp_start{RAND*}" name="{START_NAME*}">
			{LIST}
		</select>
		{+START,IF,{$NOT,{$JS_ON}}}
			<input onclick="disable_button_just_clicked(this);" class="button_micro" type="submit" value="{!JUMP}: {$GET*,TEXT_ID}" />
		{+END}
	</div>
</form>

