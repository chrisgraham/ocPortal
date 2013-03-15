{+START,BOX,{!WEEK,{WEEK*}},,light}
	<div class="wide_table_wrap"><table summary="{!MAP_TABLE}" class="leaderboard_table solidborder wide_table">
		{+START,IF,{$NOT,{$MOBILE}}}
			<colgroup>
				<col style="width: 150px" />
				<col style="width: 100%" />
				{+START,IF,{$OCF}}
					<col style="width: 150px" />
				{+END}
			</colgroup>
		{+END}

		<tbody>
			{ROWS}
		</tbody>
	</table></div>
{+END}
<br />
