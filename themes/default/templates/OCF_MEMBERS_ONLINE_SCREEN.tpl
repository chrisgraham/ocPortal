{TITLE}

<div class="wide_table_wrap"><table summary="{!COLUMNED_TABLE}" class="autosized_table wide_table results_table">
	<thead>
		<tr>
			<th>
				{!USERNAME}
			</th>
			<th>
				{!LAST_ACTIVITY}
			</th>
			{+START,IF,{$NOT,{$MOBILE}}}
				{+START,IF,{$HAS_PRIVILEGE,show_user_browsing}}
					<th>
						{!_LOCATION}
					</th>
				{+END}
			{+END}
			{+START,IF,{$HAS_PRIVILEGE,see_ip}}
				<th>
					{!IP_ADDRESS}
				</th>
			{+END}
		</tr>
	</thead>
	<tbody>
		{ROWS}
	</tbody>
</table></div>

