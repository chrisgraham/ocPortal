<h2>{FIELD*}</h2>

<table summary="{!COLUMNED_TABLE}" class="variable_table solidborder">
	<thead>
		<tr>
			<th>{!KEYWORD}</th>
			<th>{!DENSITY}</th>
			<th>{!IDEAL_DENSITY}</th>
		</tr>
	</thead>
	<tbody>
		{+START,LOOP,KEYWORDS}
			<tr>
				<td>{KEYWORD*}</td>
				<td>{DENSITY*}%</td>
				<td>{IDEAL_DENSITY*}%</td>
			</tr>
		{+END}
	</tbody>
</table>

