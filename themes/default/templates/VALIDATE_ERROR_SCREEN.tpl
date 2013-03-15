<div class="{$,{RET},global_middle,}">
	{TITLE}

	{+START,IF_NON_EMPTY,{RETURN_URL}}
		<p class="back_button">
			<a href="{RETURN_URL*}"><img title="{MSG}" alt="{MSG}" src="{$IMG*,bigicons/back}" /></a>
		</p>
	{+END}

	<h2>{!VALIDATION_ERROR_2}</h2>

	<ul>
		{ERRORS}
	</ul>

	{+START,IF_NON_EMPTY,{MESSY_URL}}
		<h2>{!ACTIONS}</h2>

		<ul>
			<li>{$URLISE_LANG,{!VALIDATION_IGNORE},{IGNORE_URL}}</li>
			<li>{$URLISE_LANG,{!VALIDATION_IGNORE_2},{IGNORE_URL_2}}</li>
			<li>{$URLISE_LANG,{!VALIDATION_MESSAGE},{MESSY_URL}}</li>
		</ul>
	{+END}

	<h2>{!CODE}</h2>

	<div class="validate_div">
		<table summary="{!MAP_TABLE}" class="autosized_table validate_table">
			<tbody>
