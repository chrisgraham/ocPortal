{TITLE}

<div class="wide_table_wrap"><table summary="{!COLUMNED_TABLE}" class="wide_table solidborder variable_table">
	<thead>
		<tr>
			<th>{!NAME}</th>
			<th>{!AMOUNT}</th>
			<th>{!DATE_TIME}</th>
			{+START,IF,{$NOT,{$MOBILE}}}
				<th>{!STATUS}</th>
			{+END}
			<th>{!ACTIONS}</th>
		</tr>
	</thead>

	<tbody>
		{+START,LOOP,INVOICES}
			{$SET,cycle,{$CYCLE,results_table_zebra,zebra_0,zebra_1}}

			<tr class="{$GET,cycle} thick_border">
				<td class="dottedborder_barrier_b_nonrequired">
					<strong>{INVOICE_TITLE*}</strong>

					{+START,IF,{$MOBILE}}
						<p class="assocated_details">
							{!STATUS}: {STATE*}
						</p>
					{+END}
				</td>
				<td class="dottedborder_barrier_b_nonrequired">
					{$CURRENCY_SYMBOL}{AMOUNT*}
				</td>
				<td class="dottedborder_barrier_b_nonrequired">
					{TIME*}
				</td>
				{+START,IF,{$NOT,{$MOBILE}}}
					<td class="dottedborder_barrier_b_nonrequired">
						{STATE*}
					</td>
				{+END}
				<td class="dottedborder_barrier_b_nonrequired">
					{+START,IF,{PAYABLE}}
						{TRANSACTION_BUTTON}
					{+END}
					{+START,IF,{$HAS_ACTUAL_PAGE_ACCESS,admin_invoices}}
						&nbsp; <a title="{!DELETE}: #{ID}" href="{$PAGE_LINK*,adminzone:admin_invoices:type=delete:id={ID}}"><img class="button_pageitem" src="{$IMG*,pageitem/delete}" alt="{!DELETE}" title="{!DELETE}" /></a>
						{+START,IF,{DELIVERABLE}}
							&nbsp; <a title="{!DELIVER}: #{ID}" href="{$PAGE_LINK*,adminzone:admin_invoices:type=deliver:id={ID}}">{!DELIVER}</a>
						{+END}
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
