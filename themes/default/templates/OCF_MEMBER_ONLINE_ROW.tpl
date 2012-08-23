<tr class="{$CYCLE,results_table_zebra,zebra_0,zebra_1}">
	<td>
		{MEMBER}
	</td>
	<td>
		{!MINUTES_AGO,{TIME*}}

		{+START,IF,{$MOBILE}}
			{+START,IF,{$HAS_PRIVILEGE,show_user_browsing}}
				<p class="associated_details">
					{+START,IF_EMPTY,{AT_URL}}
						{+START,IF_NON_EMPTY,{AT_URL}}
							{LOCATION}
						{+END}
						{+START,IF_EMPTY,{AT_URL}}
							<em>{!UNKNOWN}</em>
						{+END}
					{+END}
					{+START,IF_NON_EMPTY,{AT_URL}}
						<a href="{AT_URL*}">{LOCATION}</a>
					{+END}
				</p>
			{+END}
		{+END}
	</td>
	{+START,IF,{$NOT,{$MOBILE}}}
		{+START,IF,{$HAS_PRIVILEGE,show_user_browsing}}
			<td>
				{+START,IF_EMPTY,{AT_URL}}
					{LOCATION}
				{+END}
				{+START,IF_NON_EMPTY,{AT_URL}}
					<a href="{AT_URL*}">{LOCATION}</a>
				{+END}
			</td>
		{+END}
	{+END}
	{+START,IF,{$ADDON_INSTALLED,securitylogging}}
		{+START,IF,{$HAS_PRIVILEGE,see_ip}}
			<td>
				<a href="{$PAGE_LINK*,adminzone:admin_lookup:misc:{IP}}">{IP*}</a>
			</td>
		{+END}
	{+END}
</tr>
