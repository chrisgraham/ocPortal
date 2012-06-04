<td class="calendar_year_month">
	<table summary="{!SPREAD_TABLE}" class="autosized_table calendar_year_month_table">
		<thead style="display: none">
			<tr>
				{+START,IF,{$SSW}}
				<th><span>{$?,{$MOBILE},{$SUBSTR,{!SUNDAY},0,1},{!SUNDAY}}</span></th>
				{+END}
				<th><span>{$?,{$MOBILE},{$SUBSTR,{!MONDAY},0,1},{!MONDAY}}</span></th>
				<th><span>{$?,{$MOBILE},{$SUBSTR,{!TUESDAY},0,1},{!TUESDAY}}</span></th>
				<th><span>{$?,{$MOBILE},{$SUBSTR,{!WEDNESDAY},0,1},{!WEDNESDAY}}</span></th>
				<th><span>{$?,{$MOBILE},{$SUBSTR,{!THURSDAY},0,1},{!THURSDAY}}</span></th>
				<th><span>{$?,{$MOBILE},{$SUBSTR,{!FRIDAY},0,1},{!FRIDAY}}</span></th>
				<th><span>{$?,{$MOBILE},{$SUBSTR,{!SATURDAY},0,1},{!SATURDAY}}</span></th>
				{+START,IF,{$NOT,{$SSW}}}
				<th><span>{$?,{$MOBILE},{$SUBSTR,{!SUNDAY},0,1},{!SUNDAY}}</span></th>
				{+END}
			</tr>
		</thead>

		<tbody>
			{ENTRIES}
		</tbody>
	</table>
</td>
