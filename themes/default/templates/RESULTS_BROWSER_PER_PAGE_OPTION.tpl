{+START,IF,{$NOT,{SELECTED}}}
	<option value="{VALUE*}">{NAME*}</option>
{+END}
{+START,IF,{SELECTED}}
	<option selected="selected" value="{VALUE*}">{NAME*}</option>
{+END}

