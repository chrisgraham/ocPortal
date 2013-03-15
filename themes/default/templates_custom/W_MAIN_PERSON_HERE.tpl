{+START,IF,{SELECTED}}
	<option value="{ID*}" selected="selected">{THIS_MEMBER_NAME*}</option>
{+END}
{+START,IF,{$NOT,{SELECTED}}}
	<option value="{ID*}">{THIS_MEMBER_NAME*}</option>
{+END}

