{+START,IF,{SELECTED}}
	<option value="{NAME*}" selected="selected">{NAME*}</option>
{+END}
{+START,IF,{$NOT,{SELECTED}}}
	<option value="{NAME*}">{NAME*}</option>
{+END}

