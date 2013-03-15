{+START,BOX,{$?,{$CONFIG_OPTION,tray_support},<a href="{CALENDAR_URL*}">{MONTH*}</a>,<a href="{CALENDAR_URL*}" title="{!CALENDAR}: {MONTH*}">{!CALENDAR}</a> &ndash; {MONTH*}},,{$?,{$GET,in_panel},panel,classic},tray_open}
	<div class="side_calendar_wrap">
		<div class="wide_table_wrap"><table summary="{!SPREAD_TABLE}" class="variable_table wide_table side_calendar">
			<colgroup>
				<col style="width: 14%" />
				<col style="width: 14%" />
				<col style="width: 14%" />
				<col style="width: 14%" />
				<col style="width: 14%" />
				<col style="width: 14%" />
				<col style="width: 14%" />
			</colgroup>
			<thead>
				<tr>
					{+START,IF,{$SSW}}
               <th>{!FC_SUNDAY}</th>
               {+END}
               <th>{!FC_MONDAY}</th>
               <th>{!FC_TUESDAY}</th>
               <th>{!FC_WEDNESDAY}</th>
               <th>{!FC_THURSDAY}</th>
               <th>{!FC_FRIDAY}</th>
               <th>{!FC_SATURDAY}</th>
               {+START,IF,{$NOT,{$SSW}}}
               <th>{!FC_SUNDAY}</th>
					{+END}
				</tr>
			</thead>

			<tbody>
				{ENTRIES}
			</tbody>
		</table></div>
	</div>
{+END}
