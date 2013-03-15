<tr class="{$CYCLE,results_table_zebra,zebra_0,zebra_1}{+START,IF,{$AND,{$IS_STAFF},{UNCLOSED}}} unclosed_ticket{+END}">
	<td>
		<a href="{URL*}">{+START,IF_EMPTY,{TITLE}}{!SUPPORT_ISSUE}{+END}{TITLE*}</a>
		{+START,IF,{CLOSED}}
			<span class="closed_ticket">{!CLOSED}</span>
		{+END}
		{+START,IF,{$MOBILE}}
			<p><span class="field_name">{!COUNT_POSTS}:</span> {NUM_POSTS*}</p>
		{+END}
	</td>
	{+START,IF,{$NOT,{$MOBILE}}}
		<td>
			{NUM_POSTS*}
		</td>
	{+END}
	<td>
		{+START,IF_NON_EMPTY,{PROFILE_URL}}
			<a class="ticket_last_poster" href="{PROFILE_URL*}">{LAST_POSTER*}</a>
		{+END}
		{+START,IF_EMPTY,{PROFILE_URL}}
			{LAST_POSTER*}
		{+END}
	</td>
	<td>
		{DATE*}
	</td>
</tr>

