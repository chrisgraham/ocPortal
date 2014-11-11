<p>{!TRANSACT_INFO}</p>

{+START,IF_PASSED,HIDDEN}
	{HIDDEN}
{+END}

<div class="wide_table_wrap"><table summary="{!MAP_TABLE}" class="dottedborder wide_table">
	{+START,IF,{$NOT,{$MOBILE}}}
		<colgroup>
			<col style="width: 200px" />
			<col style="width: 100%" />
		</colgroup>
	{+END}

	<tbody>
		{FIELDS}
	</tbody>
</table></div>

