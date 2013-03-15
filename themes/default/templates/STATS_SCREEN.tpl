{TITLE}

{+START,IF,{$NOT,{$ISSET,SVG_ONCE}}}
	<p class="lightborder svg_exp">{!SVG_EXPLANATION}</p>
	{$SET,SVG_ONCE,1}
{+END}

{GRAPH}
<div class="link_exempt_wrap">
	{STATS}
</div>

{+START,IF_NON_PASSED,NO_CSV}
	<p>
		<a href="{$SELF_URL*}&amp;csv=1" class="xls_link">{!EXPORT_STATS_TO_CSV}</a>
	</p>
{+END}
