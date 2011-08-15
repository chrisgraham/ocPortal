<tr class="{$CYCLE,results_table_zebra,zebra_0,zebra_1}">
	<td class="dottedborder_barrier_b_nonrequired"><strong>{NAME*}</strong></td>
	<td class="dottedborder_barrier_b_nonrequired">{DAYS*}</td>
	{+START,IF,{$MOBILE}}
		<td class="dottedborder_barrier_b_nonrequired">
			<a title="{!VIEW_PROFILE}: {NAME*}" href="{PROFILE_URL*}">{!VIEW_PROFILE}</a>
			{+START,IF,{$ADDON_INSTALLED,authors}}
				&middot; <a title="{!VIEW_AUTHOR}: {NAME*}" href="{AUTHOR_URL*}">{!VIEW_AUTHOR}</a>
			{+END}
			{+START,IF,{$ADDON_INSTALLED,points}}
				{+START,IF_NON_EMPTY,{POINTS_URL}}
					&middot; <a title="{!VIEW_POINTS}: {NAME*}" href="{POINTS_URL*}">{!VIEW_POINTS}</a>
				{+END}
			{+END}
			&middot; <a title="{!SEND_PM}: {NAME*}" href="{PM_URL*}">{!SEND_PM}</a>
		</td>
	{+END}
	{+START,IF,{$NOT,{$MOBILE}}}
		<td class="dottedborder_barrier_b_nonrequired"><a title="{!VIEW_PROFILE}: {NAME*}" href="{PROFILE_URL*}">{!VIEW_PROFILE}</a></td>
		{+START,IF,{$ADDON_INSTALLED,authors}}
			<td class="dottedborder_barrier_b_nonrequired"><a title="{!VIEW_AUTHOR}: {NAME*}" href="{AUTHOR_URL*}">{!VIEW_AUTHOR}</a></td>
		{+END}
		{+START,IF,{$ADDON_INSTALLED,points}}
			{+START,IF_NON_EMPTY,{POINTS_URL}}
				<td class="dottedborder_barrier_b_nonrequired"><a title="{!VIEW_POINTS}: {NAME*}" href="{POINTS_URL*}">{!VIEW_POINTS}</a></td>
			{+END}
		{+END}
		<td class="dottedborder_barrier_b_nonrequired"><a title="{!SEND_PM}: {NAME*}" href="{PM_URL*}">{!SEND_PM}</a></td>
	{+END}
	<td class="dottedborder_barrier_b_nonrequired">{+START,IF_EMPTY,{SKILLS}}<em>{!NOT_SPECIFIED}</em>{+END}{SKILLS}</td>
</tr>

