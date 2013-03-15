<div class="{$,{RET},global_middle,}">
	{TITLE}

	{+START,IF_NON_EMPTY,{RETURN_URL}}
		<p class="back_button">
			<a href="{RETURN_URL*}"><img title="{MSG}" alt="{MSG}" src="{$IMG*,bigicons/back}" /></a>
		</p>
	{+END}

	{+START,IF_NON_EMPTY,{MESSY_URL}}
		<ul class="actions_list">
			<li>{$URLISE_LANG,{!VALIDATION_MESSAGE},{MESSY_URL}}</li>
		</ul>
	{+END}

	<div class="validate_div">
		<table summary="{!MAP_TABLE}" class="autosized_table validate_table">
			<tbody>
