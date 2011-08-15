{+START,BOX,{TITLE*},,{$?,{$GET,in_panel},panel,classic},tray_open}
	{+START,IF_EMPTY,{DAYS}}
		<p class="nothing_here">{!NO_ENTRIES}</p>
	{+END}
	{+START,LOOP,DAYS}
		<div class="event_listing_day">{TIME*}</div>

		<div class="wide_table_wrap">
			<table summary="{!MAP_TABLE}" class="solidborder wide_table events_listing_table">
				{+START,IF,{$NOT,{$MOBILE}}}
					<colgroup>
						<col style="width: 30px" />
						<col style="width: 40%" />
						<col style="width: 60%" />
					</colgroup>
				{+END}

				<tbody>
					{+START,LOOP,EVENTS}
						<tr>
							<th>
								{+START,IF_PASSED,ICON}{+START,IF_PASSED,T_TITLE}
									<img src="{$IMG*,{ICON}}" title="{T_TITLE*}" alt="{T_TITLE*}" />
								{+END}{+END}
							</th>

							<td>
								{TIME*}
							</td>
	
							<td>
								<a href="{VIEW_URL*}">{TITLE*}</a>
							</td>
						</tr>
					{+END}
				</tbody>
			</table>
		</div>
		
		<br />
	{+END}
{+END}

