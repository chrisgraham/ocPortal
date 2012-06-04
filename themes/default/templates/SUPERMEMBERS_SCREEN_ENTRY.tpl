<tr class="{$CYCLE,results_table_zebra,zebra_0,zebra_1}">
	<td><strong>{NAME*}</strong></td>
	<td>{DAYS*}</td>
	{+START,IF,{$MOBILE}}
		<td>
			<ul class="horizontal_links associated_links_group">
				<li><a title="{!VIEW_PROFILE}: {NAME*}" href="{PROFILE_URL*}">{!VIEW_PROFILE}</a></li>
				{+START,IF,{$ADDON_INSTALLED,authors}}
					<li><a title="{!VIEW_AUTHOR}: {NAME*}" href="{AUTHOR_URL*}">{!VIEW_AUTHOR}</a></li>
				{+END}
				{+START,IF,{$ADDON_INSTALLED,points}}
					{+START,IF_NON_EMPTY,{POINTS_URL}}
						<li><a title="{!VIEW_POINTS}: {NAME*}" href="{POINTS_URL*}">{!VIEW_POINTS}</a></li>
					{+END}
				{+END}
				<li><a title="{!SEND_PM}: {NAME*}" href="{PM_URL*}">{!SEND_PM}</a></li>
			</ul>
		</td>
	{+END}
	{+START,IF,{$NOT,{$MOBILE}}}
		<td><a class="associated_link" title="{!VIEW_PROFILE}: {NAME*}" href="{PROFILE_URL*}">{!VIEW_PROFILE}</a></td>
		{+START,IF,{$ADDON_INSTALLED,authors}}
			<td><a class="associated_link" title="{!VIEW_AUTHOR}: {NAME*}" href="{AUTHOR_URL*}">{!VIEW_AUTHOR}</a></td>
		{+END}
		{+START,IF,{$ADDON_INSTALLED,points}}
			{+START,IF_NON_EMPTY,{POINTS_URL}}
				<td><a class="associated_link" title="{!VIEW_POINTS}: {NAME*}" href="{POINTS_URL*}">{!VIEW_POINTS}</a></td>
			{+END}
		{+END}
		<td><a class="associated_link" title="{!SEND_PM}: {NAME*}" href="{PM_URL*}">{!SEND_PM}</a></td>
	{+END}
	<td>{+START,IF_EMPTY,{SKILLS}}<em>{!NOT_SPECIFIED}</em>{+END}{SKILLS}</td>
</tr>

