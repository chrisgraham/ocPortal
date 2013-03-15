{$,Read the catalogue tutorial for information on custom catalogue layouts}

<div class="wide_table_wrap"{$?,{$VALUE_OPTION,html5}, itemprop="mainContentOfPage" content="true" itemscope="itemscope" itemtype="http://schema.org/Table"}>
	<table summary="{!COLUMNED_TABLE}" class="dottedborder wide_table catalogue_table">
		{+START,IF,{$NOT,{$MOBILE}}}
			<colgroup>
				{$SET,INC,0}
				{+START,WHILE,{$NEQ,{$GET,INC},{FIELD_COUNT}}}
					<col />
					{$INC,INC}
				{+END}
				{+START,IF,{$IN_STR,{CONTENT},<!--VIEWLINK-->}}
					<col style="width: 80px" />
				{+END}
				{$, Uncomment to show ratings
					<col style="width: 85px" />
				}
			</colgroup>
		{+END}

		<thead>
			<tr>
				{HEAD}
				{+START,IF,{$IN_STR,{CONTENT},<!--VIEWLINK-->}}
					<th></th>
				{+END}
				{$, Uncomment to show ratings
					<th>{!RATING}</th>
				}
			</tr>
		</thead>

		<tbody>
			{CONTENT}
		</tbody>
	</table>
</div>

