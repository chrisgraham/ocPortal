{+START,BOX,{!DETAILS},,light}
	<div class="wide_table_wrap"><table summary="{!MAP_TABLE}" class="wide_table solidborder">
		{+START,IF,{$NOT,{$MOBILE}}}
			<colgroup>
				<col style="width: 200px" />
				<col style="width: 100%" />
			</colgroup>
		{+END}

		<tbody>
			{+START,IF_PASSED,MESSAGE}
				<tr>
					<th>
						{!MESSAGE}
					</th>
					<td>
						{MESSAGE}
					</td>
				</tr>
			{+END}

			{+START,IF_PASSED,DAYS}
				<tr>
					<th>{!_UP_FOR}</th>
					<td>{!DAYS,{DAYS*}}</td>
				</tr>
			{+END}

			<tr>
				<th>{!SUBMITTER}</th>
				<td>{USERNAME}</td>
			</tr>
	
			<tr>
				<th>{!DAYS_ORDERED}</th>
				<td>{DAYS_ORDERED*}</td>
			</tr>
	
			<tr>
				<th>{!ORDER_DATE}</th>
				<td>{DATE*}</td>
			</tr>
		</tbody>
	</table></div>
{+END}

