<div class="wide_table_wrap" itemprop="mainContentOfPage" content="true" itemscope="itemscope" itemtype="http://schema.org/Table">
	<table summary="{!COLUMNED_TABLE}" class="results_table wide_table">
		{+START,IF,{$NOT,{$MOBILE}}}
			<colgroup>
				{$SET,INC,0}
				{+START,WHILE,{$NEQ,{$GET,INC},{FIELD_COUNT}}}
					<col />
					{$INC,INC}
				{+END}
			</colgroup>
		{+END}

		<thead>
			<tr>
				{HEAD}
			</tr>
		</thead>

		<tbody>
			{CONTENT}
		</tbody>
	</table>
</div>

