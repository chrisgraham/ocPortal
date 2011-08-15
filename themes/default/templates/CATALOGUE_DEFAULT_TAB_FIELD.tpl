{$,Read the catalogue tutorial for information on custom catalogue layouts}

<td class="dottedborder_barrier_b_nonrequired">
	{VALUE}

	{+START,IF,{$HAS_ACTUAL_PAGE_ACCESS,cms_catalogues}}{+START,IF,{$EQ,{FIELDID},0}}
		<p class="associated_caption">
			( <a href="{$PAGE_LINK*,_SEARCH:cms_catalogues:_ed:{ENTRYID}}">{!EDIT}</a> )
		</p>
	{+END}{+END}
</td>

