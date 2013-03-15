{TITLE}

<div class="wide_table_wrap"><table summary="{!COLUMNED_TABLE}" class="solidborder wide_table">
	{+START,IF,{$NOT,{$MOBILE}}}
		<colgroup>
			<col style="width: 100%" />
			<col style="width: 75px" />
		</colgroup>
	{+END}

	<thead>
		<tr>
			<th>{!TYPE}</th>
			<th>{!AMOUNT}, {$CURRENCY_SYMBOL}</th>
		</tr>
	</thead>

	<tbody>
		{+START,LOOP,TYPES}
			<tr>
				<td>
					 {+START,IF,{SPECIAL}}<strong>{TYPE*}</strong>{+END}
					 {+START,IF,{$NOT,{SPECIAL}}}{TYPE*}{+END}
				</td>
				<td>
					 {+START,IF,{SPECIAL}}<strong>{AMOUNT*}</strong>{+END}
					 {+START,IF,{$NOT,{SPECIAL}}}{AMOUNT*}{+END}
				</td>
			</tr>
		{+END}
	</tbody>
</table></div>

