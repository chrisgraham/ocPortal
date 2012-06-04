<h3>{NAME*}</h3>

<div class="wide_table_wrap"><table summary="{!MAP_TABLE}" class="wide_table results_table">
	{+START,IF,{$NOT,{$MOBILE}}}
		<colgroup>
			<col class="block_help_field_name_column" />
			<col class="block_help_field_value_column" />
		</colgroup>
	{+END}

	<tbody>
		<tr>
			<th>{!DESCRIPTION}</th>
			<td>{DESCRIPTION*}</td>
		</tr>
		<tr>
			<th>{!USE}</th>
			<td>{USE*}</td>
		</tr>
		{PARAMETERS}
	</tbody>
</table></div>


