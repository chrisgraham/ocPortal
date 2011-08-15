<div class="wide_table_wrap">
	<table summary="{!MAP_TABLE}" class="wide_table solidborder spaced_table">
		{+START,IF,{$NOT,{$MOBILE}}}
			<colgroup>
				<col style="width: 150px" />
				<col style="width: 100%" />
			</colgroup>
		{+END}

		<tbody>
			{FIELDS}
		</tbody>
	</table>
</div>

