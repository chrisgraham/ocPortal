<h3>{NAME*}</h3>

<div class="wide_table_wrap"><table summary="{!MAP_TABLE}" class="wide_table solidborder">
	{+START,IF,{$NOT,{$MOBILE}}}
		<colgroup>
			<col style="width: 100px" />
			<col style="width: 100%" />
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
<br />

