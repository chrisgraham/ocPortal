{TITLE}

{+START,IF,{$NOT,{$ISSET,SVG_ONCE}}}
	<p class="box">{!SVG_EXPLANATION}</p>
	{$SET,SVG_ONCE,1}
{+END}

<h2>{!VIEWS_PER_MONTH}</h2>
{+START,IF_EMPTY,{STATS_VIEWS_MONTHLY}}
	<p>{!NO_DATA}</p>
{+END}
{GRAPH_VIEWS_MONTHLY}
{STATS_VIEWS_MONTHLY}
