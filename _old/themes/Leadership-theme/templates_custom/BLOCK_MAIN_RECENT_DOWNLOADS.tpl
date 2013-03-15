{+START,IF,{$GET,in_panel}}
	{+START,BOX,,,panel}
		{CONTENT}
	{+END}
{+END}

{+START,IF,{$NOT,{$GET,in_panel}}}
	{CONTENT}
{+END}
