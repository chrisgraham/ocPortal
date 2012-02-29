{+START,IF_PASSED,TEXT_ID}{$SET,TEXT_ID,{TEXT_ID}}{+END}

<div class="results_browser">
	<{$?,{$VALUE_OPTION,html5},nav,div} class="float_surrounder"{$?,{$VALUE_OPTION,html5}, role="navigation"}>
		{PER_PAGE}
		{PART}
	</{$?,{$VALUE_OPTION,html5},nav,div}>
</div>
