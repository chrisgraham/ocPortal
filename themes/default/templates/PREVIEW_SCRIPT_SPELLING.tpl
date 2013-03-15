<h2>{FIELD*}</h2>

<div class="wide_table_wrap"><table summary="{!COLUMNED_TABLE}" class="autosized_table results_table wide_table">
	<thead>
		<tr>
			<th>{!WORD}</th>
			<th>{!POSSIBLE_CORRECTIONS}</th>
		</tr>
	</thead>
	<tbody>
		{+START,LOOP,MISSPELLINGS}
			<tr>
				<td>{WORD*}</td>
				<td>{CORRECTIONS*}</td>
			</tr>
		{+END}
	</tbody>
</table></div>

