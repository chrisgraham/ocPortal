{$SET,skip_table,0}
{+START,IF_PASSED,FOR_GUESTS}{+START,IF,{$AND,{$IS_GUEST},{$NOT,{FOR_GUESTS}}}}{$SET,skip_table,1}{+END}{+END}
{+START,IF,{$NOT,{$GET,skip_table}}}
	{+START,BOX}
		<p class="important_notification"{$?,{$VALUE_OPTION,html5}, role="alert"}>{WARNING}</p>
	{+END}

	<br />
{+END}

