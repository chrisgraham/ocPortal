{TITLE}

<p>{!SUCCESS}</p>

<div class="wide_table_wrap"><table summary="{!MAP_TABLE}" class="wide_table results_table autosized_table">
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
				<td class="whitespace_visible">{PARAM_A*}</td>
				<td class="whitespace_visible">{PARAM_B*}</td>
			</tr>
		{+END}
	</tbody>
</table></div>

