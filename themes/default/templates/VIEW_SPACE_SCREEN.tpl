{TITLE}

{+START,IF_PASSED,TEXT}
	<p>{TEXT*}</p>
{+END}

<div class="wide_table_wrap"><table summary="{!MAP_TABLE}" class="wide_table solidborder">
	{+START,IF,{$NOT,{$MOBILE}}}
		<colgroup>
			<col style="width: 300px" />
			<col style="width: 100%" />
		</colgroup>
	{+END}

	<tbody>
		{FIELDS}
	</tbody>
</table></div>

