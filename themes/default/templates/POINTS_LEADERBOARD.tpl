{+START,BOX,{!POINT_LEADERBOARD},,{$?,{$GET,in_panel},panel,classic},,,<a rel="archives" href="{URL*}" title="{!MORE}: {!POINT_LEADERBOARD}">{!MORE}</a>}
	<p>{!LEADERBOARD_ABOUT,{LIMIT*}}</p>

	<div class="wide_table_wrap"><table summary="{!MAP_TABLE}" class="variable_table leaderboard_table solidborder wide_table">
		<tbody>
			{ROWS}
		</tbody>
	</table></div>
{+END}

