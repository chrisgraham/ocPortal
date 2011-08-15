{+START,IF,{$NOT,{SELECTED}}}
	<option value="{VALUE*}">{$STRIP_TAGS*,{NAME},1}</option>
{+END}
{+START,IF,{SELECTED}}
	<option selected="selected" value="{VALUE*}">{$STRIP_TAGS*,{NAME},1}</option>
{+END}

