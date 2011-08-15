{+START,IF,{$NOT,{CHECKED}}}
	<input id="{NAME*}" name="{NAME*}" type="checkbox" value="1" />
{+END}
{+START,IF,{CHECKED}}
	<input id="{NAME*}" name="{NAME*}" type="checkbox" value="1" checked="checked" />
{+END}

