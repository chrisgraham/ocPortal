{+START,IF,{$GET,in_panel}}
	{+START,BOX,{TITLE},,panel}
		{CONTENT}
	{+END}
{+END}

{+START,IF,{$NOT,{$GET,in_panel}}}
	<h2>{TITLE}</h2>

	{CONTENT}
{+END}
