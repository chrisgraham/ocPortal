{+START,SET,location}
	{+START,SET,_location}
		{+START,IF_NON_EMPTY,{LOCATION}}
			{LOCATION}
		{+END}
		{+START,IF_EMPTY,{LOCATION}}
			<em>{!UNKNOWN}</em>
		{+END}
	{+END}

	{+START,IF_EMPTY,{AT_URL}}
		{$GET,_location}
	{+END}
	{+START,IF_NON_EMPTY,{AT_URL}}
		<a href="{AT_URL*}">{$TRIM,{$GET,_location}}</a>
	{+END}
{+END}

<tr class="{$CYCLE,results_table_zebra,zebra_0,zebra_1}">
	<td class="dottedborder_barrier_b_nonrequired">
		{MEMBER}
	</td>
	<td class="dottedborder_barrier_b_nonrequired">
		{!MINUTES_AGO,{TIME*}}

		{+START,IF,{$MOBILE}}
			{+START,IF,{$HAS_SPECIFIC_PERMISSION,show_user_browsing}}
				<p class="associated_details">
					{$GET,location}
				</p>
			{+END}
		{+END}
	</td>
	{+START,IF,{$NOT,{$MOBILE}}}
		{+START,IF,{$HAS_SPECIFIC_PERMISSION,show_user_browsing}}
			<td class="dottedborder_barrier_b_nonrequired">
				{$GET,location}
			</td>
		{+END}
	{+END}
	{+START,IF,{$HAS_SPECIFIC_PERMISSION,see_ip}}
		<td class="dottedborder_barrier_b_nonrequired">
			<a href="{$PAGE_LINK*,adminzone:admin_lookup:misc:{IP}}">{IP*}</a>
		</td>
	{+END}
</tr>
