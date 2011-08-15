<tr class="{$CYCLE,results_table_zebra,zebra_0,zebra_1}{+START,IF,{$AND,{$IS_STAFF},{UNCLOSED}}} unclosed_ticket{+END}">
	<td class="dottedborder_barrier_b_nonrequired">
		<a href="{URL*}">{+START,IF_EMPTY,{TITLE}}{!SUPPORT_ISSUE}{+END}{TITLE*}</a>
		{+START,IF,{CLOSED}}
			<span class="closed_ticket">{!CLOSED}</span>
		{+END}
		{+START,IF,{$MOBILE}}
			<p>{!COUNT_POSTS}: {NUM_POSTS*}</p>
		{+END}
	</td>
	{+START,IF,{$NOT,{$MOBILE}}}
		<td class="dottedborder_barrier_b_nonrequired">
			{NUM_POSTS*}
		</td>
	{+END}
	<td class="dottedborder_barrier_b_nonrequired">
		{+START,IF_NON_EMPTY,{PROFILE_LINK}}
			<a class="ticket_last_poster" href="{PROFILE_LINK*}">{LAST_POSTER*}</a>
		{+END}
		{+START,IF_EMPTY,{PROFILE_LINK}}
			{LAST_POSTER*}
		{+END}
	</td>
	<td class="dottedborder_barrier_b_nonrequired">
		{DATE*}
	</td>
</tr>

