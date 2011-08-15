{$SET,skip_table,_false}
{+START,IF_PASSED,FOR_GUESTS}{+START,IF,{$AND,{$IS_GUEST},{$NOT,{FOR_GUESTS}}}}{$SET,skip_table,_true}{+END}{+END}
{+START,IF,{$NOT,{$GET,skip_table}}}
	{+START,BOX}
		<p class="important_notification">{WARNING}</p>
	{+END}

	<br />
{+END}

