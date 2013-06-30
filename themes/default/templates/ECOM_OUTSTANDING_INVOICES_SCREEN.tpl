{TITLE}

<div class="wide_table_wrap"><table summary="{!COLUMNED_TABLE}" class="wide_table solidborder">
	{+START,IF,{$NOT,{$MOBILE}}}
		<colgroup>
			<col style="width: 140px" />
			<col style="width: 25%" />
			<col style="width: 25%" />
			<col style="width: 25%" />
			<col style="width: 25%" />
		</colgroup>
	{+END}

	<thead>
		<tr>
			<th>{!TITLE}</th>
			<th>{!USERNAME}</th>
			<th>{!AMOUNT}</th>
			<th>{!DATE_TIME}</th>
			<th>{!ACTIONS}</th>
		</tr>
	</thead>

	<tbody>
		{+START,LOOP,INVOICES}
			{$SET,cycle,{$CYCLE,results_table_zebra,zebra_0,zebra_1}}

			<tr class="{$GET,cycle} thick_border">
				<td class="dottedborder_barrier_b_nonrequired">
					{INVOICE_TITLE*}
				</td>
				<td class="dottedborder_barrier_b_nonrequired">
					<a href="{PROFILE_URL*}">{USERNAME*}</a>
				</td>
				<td class="dottedborder_barrier_b_nonrequired">
					{AMOUNT*}
				</td>
				<td class="dottedborder_barrier_b_nonrequired">
					{TIME*}
				</td>
				<td class="dottedborder_barrier_b_nonrequired">
					<a title="{!DELETE}: #{ID}" href="{$PAGE_LINK*,_SELF:_SELF:type=delete:id={ID}:from={FROM}}"><img src="{$IMG*,tableitem/delete}" title="{!DELETE_INVOICE}" alt="{!DELETE_INVOICE}" /></a>
					{+START,IF,{$EQ,{STATE},paid}}
						<a title="{!MARK_AS_DELIVERED}: #{ID}" href="{$PAGE_LINK*,_SELF:_SELF:type=deliver:id={ID}}">{!MARK_AS_DELIVERED}</a>
					{+END}
				</td>
			</tr>
			{+START,IF_NON_EMPTY,{NOTE}}
				<tr class="{$GET,cycle}">
					<td class="dottedborder_barrier_b_nonrequired" colspan="5">
						{NOTE*}
					</td>
				</tr>
			{+END}
		{+END}
	</tbody>
</table></div>
