<form title="{!SORT_BY}" action="{$URL_FOR_GET_FORM*,{URL}}{+START,IF_PASSED,HASH}#{HASH*}{+END}" method="get" target="_self">
	{$HIDDENS_FOR_GET_FORM,{URL}}

	{$SET,RAND,{$RAND}}

	<div class="inline">
		{+START,IF_PASSED,HIDDEN}
			{HIDDEN}
		{+END}

		{+START,IF_PASSED,FILTER}
			<label for="filter"><span class="field_name">{!SEARCH}:</span> <input value="{FILTER*}" name="filter" id="filter" size="10" /></label>
		{+END}

		<label {+START,IF_NON_PASSED,FILTER}class="accessibility_hidden" {+END}for="r_{$GET*;,RAND}">{!SORT_BY}: {$GET*,TEXT_ID}</label>
		<select{+START,IF,{$NOR,{$GET,show_sort_button},{$NOT,{$JS_ON}}}} onchange="this.form.submit();"{+END} id="r_{$GET*;,RAND}" name="{SORT*}">
			{SELECTORS}
		</select>

		{+START,IF,{$OR,{$GET,show_sort_button},{$NOT,{$JS_ON}}}}
			{+START,IF_NON_PASSED,FILTER}
				<input onclick="disable_button_just_clicked(this);" class="button_micro" type="submit" title="{!SORT_BY}: {$GET*,TEXT_ID}" value="{!SORT_BY}" />
			{+END}
		{+END}
		{+START,IF_PASSED,FILTER}
			<input onclick="disable_button_just_clicked(this);" class="button_micro" type="submit" title="{!PROCEED}: {$GET*,TEXT_ID}" value="{!PROCEED}" />
		{+END}
	</div>
</form>
