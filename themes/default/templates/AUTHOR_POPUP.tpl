{+START,IF_NON_EMPTY,{CONTENT}}
	<ul>
		{CONTENT}
	</ul>
{+END}
{+START,IF_EMPTY,{CONTENT}}
	<p class="nothing_here">
		{!NO_ENTRIES}
	</p>
{+END}

<hr />

{+START,IF_PASSED,NEXT_URL}
	<ul class="actions_list" role="navigation">
		<li><a title="{!MORE}: {!AUTHORS}" href="{NEXT_URL*}">{!MORE}</a></li>
	</ul>
{+END}
