{TITLE}

<p>{!SUCCESS}</p>

<div class="wide_table_wrap"><table summary="{!MAP_TABLE}" class="wide_table solidborder">
	<colgroup>
		<col style="width: 200px" />
		<col style="width: 50%" />
		<col style="width: 50%" />
	</colgroup>

	<thead>
		<tr>
			<th>{!ACTION}</th>
			<th>{!PARAMETER_A}</th>
			<th>{!PARAMETER_B}</th>
		</tr>
	</thead>

	<tbody>
		{+START,LOOP,OPS}
			<tr>
				<td>{OP*}</td>
				<td class="whitespace">{PARAM_A*}</td>
				<td class="whitespace">{PARAM_B*}</td>
			</tr>
		{+END}
	</tbody>
</table></div>

