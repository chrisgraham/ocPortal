{$,Read the catalogue tutorial for information on custom catalogue layouts}

<td class="dottedborder_barrier_b_nonrequired">
	{VALUE}

	{+START,IF,{$NEQ,{FIELDID},0}}
		{+START,IF_NON_EMPTY,{$GET,EDIT_URL}}
			<p class="associated_caption">
				( <a href="{$GET*,EDIT_URL}">{!EDIT}</a> )
			</p>
		{+END}
	{+END}
</td>

