{+START,IF_NON_EMPTY,{$TRIM,{GALLERIES}}}
	<ul class="category_list">
		{GALLERIES}
	</ul>
{+END}

{+START,IF_EMPTY,{$TRIM,{GALLERIES}}}
	<p class="nothing_here">{!NO_ENTRIES}</p>
{+END}
