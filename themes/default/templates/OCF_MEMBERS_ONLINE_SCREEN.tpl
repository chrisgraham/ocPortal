{TITLE}

<div class="wide_table_wrap"><table summary="{!COLUMNED_TABLE}" class="variable_table wide_table solidborder">
	<thead>
		<tr>
			<th>
				{!USERNAME}
			</th>
			<th>
				{!LAST_ACTIVITY}
			</th>
			{+START,IF,{$NOT,{$MOBILE}}}
				{+START,IF,{$HAS_SPECIFIC_PERMISSION,show_user_browsing}}
					<th>
						{!_LOCATION}
					</th>
				{+END}
			{+END}
			{+START,IF,{$HAS_SPECIFIC_PERMISSION,see_ip}}
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

