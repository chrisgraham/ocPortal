<h2>{GROUP_NAME*}</h2>

<div class="wide_table_wrap"><table summary="{!COLUMNED_TABLE}" class="results_table wide_table spaced_table autosized_table">
	<thead>
		<tr>
			<th>{!USERNAME}</th>
			<th>{!DAYS_LAST_VISIT}</th>
			{+START,IF,{$NOT,{$MOBILE}}}
				<th>{!VIEW_PROFILE}</th>
				{+START,IF,{$ADDON_INSTALLED,authors}}
					<th>{!VIEW_AUTHOR}</th>
				{+END}
				{+START,IF,{$ADDON_INSTALLED,points}}
					<th>{!VIEW_POINTS}</th>
				{+END}
				<th>{!SEND_PM}</th>
			{+END}
			{+START,IF,{$MOBILE}}
				<th>{!ACTIONS}</th>
			{+END}
			<th>{!SKILLS}</th>
		</tr>
	</thead>
	<tbody>
		{ENTRIES}
	</tbody>
</table></div>

