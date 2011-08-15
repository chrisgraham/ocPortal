{$,Read the catalogue tutorial for information on custom catalogue layouts}

<tr>
	{FIELDS_TABLE}
	{+START,IF_NON_EMPTY,{VIEW_URL}}
		<td class="dottedborder_barrier_b_nonrequired">
			<!--VIEWLINK-->
			<a href="{VIEW_URL*}"><img title="{!COMMENTS} / {!VIEW}" alt="{!COMMENTS} / {!VIEW}" class="button_pageitem" src="{$IMG*,pageitem/more}" /></a>
		</td>
	{+END}
	{$, Uncomment to show ratings
	<td class="dottedborder_barrier_b_nonrequired">
		{+START,IF_NON_EMPTY,{$TRIM,{RATING}}}
			{RATING}
		{+END}
		{+START,IF_EMPTY,{$TRIM,{RATING}}}
			{!UNRATED}
		{+END}
	</td>
	}
</tr>

