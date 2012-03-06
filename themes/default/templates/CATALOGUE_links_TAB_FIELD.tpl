<td class="dottedborder_barrier_b_nonrequired">
	{+START,IF,{$EQ,{FIELDID},0}}
		<a target="_blank" title="{$STRIP_TAGS,{VALUE}} {!LINK_NEW_WINDOW}" href="{$GET*,FIELD_1_PLAIN}">{VALUE}</a>
	{+END}

	{+START,IF,{$NEQ,{FIELDID},0}}
		{VALUE}
	{+END}

	{+START,IF,{$HAS_ACTUAL_PAGE_ACCESS,cms_catalogues}}{+START,IF,{$EQ,{FIELDID},0}}
		<p class="associated_caption">
			( <a href="{$PAGE_LINK*,_SEARCH:cms_catalogues:_ed:{ENTRYID}}">{!EDIT}</a> )
		</p>
	{+END}{+END}
</td>

