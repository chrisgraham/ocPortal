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
						<tr class="vevent">
							<th>
								{+START,IF_PASSED,ICON}{+START,IF_PASSED,T_TITLE}
									<img src="{$IMG*,{ICON}}" title="{T_TITLE*}" alt="{T_TITLE*}" />
								{+END}{+END}
							</th>

							<td{+START,IF,{$EQ,{TIME},{!ALL_DAY_EVENT}}} style="display: none"{+END}>
								{+START,IF,{$VALUE_OPTION,html5}}
									<time class="dtstart" datetime="{TIME_VCAL*}" itemprop="startDate">{TIME*}</time>
								{+END}
								{+START,IF,{$NOT,{$VALUE_OPTION,html5}}}
									<abbr class="dtstart" title="{TIME_VCAL*}">{TIME*}</abbr>
								{+END}
							</td>
	
							<td class="summary"{+START,IF,{$EQ,{TIME},{!ALL_DAY_EVENT}}} colspan="2"{+END}>
								<a href="{VIEW_URL*}" class="url">{TITLE*}</a>
								{+START,IF_PASSED,TO_DAY}
									<span{+START,IF,{$EQ,{FROM_DAY},{TO_DAY}}} style="display: none"{+END}>
										{+START,IF,{$VALUE_OPTION,html5}}
											<span class="associated_details">({!EVENT_ENDS_ON,<time class="dtend" datetime="{TO_TIME_VCAL*}" itemprop="endDate">{TO_DAY*}</time>})</span>
										{+END}
										{+START,IF,{$NOT,{$VALUE_OPTION,html5}}}
											<span class="associated_details">({!EVENT_ENDS_ON,<abbr class="dtend" title="{TO_TIME_VCAL*}">{TO_DAY*}</abbr>})</span>
										{+END}
									</span>
								{+END}
							</td>
						</tr>
					{+END}
				</tbody>
			</table>
		</div>
		
		<br />
	{+END}
{+END}

