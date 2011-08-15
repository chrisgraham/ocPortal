<div class="wide_table_wrap"{$?,{$VALUE_OPTION,html5}, itemscope="itemscope" itemtype="http://schema.org/Table"}>
	{+START,IF,{$VALUE_OPTION,html5}}
		<meta itemprop="mainContentOfPage" content="true" />
	{+END}
	<table summary="{!COLUMNED_TABLE}" class="dottedborder wide_table">
		{+START,IF,{$NOT,{$MOBILE}}}
			<colgroup>
				{$SET,INC,0}
				{+START,WHILE,{$NEQ,{$GET,INC},{FIELD_COUNT}}}
					<col />
					{$INC,INC}
				{+END}
			</colgroup>
		{+END}

		<tbody>
			{CONTENT}
		</tbody>
	</table>
</div>

