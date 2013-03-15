<div id="global_div" class="global_middle">
	{TITLE}

	{+START,IF_NON_EMPTY,{RETURN_URL}}
	<p>
		<a href="{RETURN_URL*}"><img title="{MSG}" alt="{MSG}" src="{$IMG*,bigicons/back}" /></a>
	</p>
	{+END}

	{+START,IF_NON_EMPTY,{MESSY_URL}}
	<p>
		{$URLISE_LANG,{!VALIDATION_MESSAGE},{MESSY_URL}}
	</p>
	{+END}

	<div class="validate_div">
	<table summary="{!MAP_TABLE}" class="variable_table global_middle validate_table">
		<tbody>
