{TITLE}

<p>
	{!QUERIES_WITHOUT_CACHE}
</p>

<div class="wide_table_wrap"><table summary="{!COLUMNED_TABLE}" class="wide_table solidborder">
	<colgroup>
		<col style="width: 100%" />
		<col style="width: 75px" />
	</colgroup>

	<thead>
		<tr>
			<th>
				{!QUERY}
			</th>
			<th axis="time">
				{!EXECUTE_TIME}
			</th>
		</tr>
	</thead>

	<tfoot>
		<tr>
			<td>
				<strong>{!COUNT_TOTAL}</strong>: {TOTAL}
			</td>
			<td>
				<strong>{TOTAL_TIME}</strong>
			</td>
		</tr>
	</tfoot>

	<tbody>
		{QUERIES}
	</tbody>
</table></div>

