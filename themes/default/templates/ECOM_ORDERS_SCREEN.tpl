{TITLE}

<div class="wide_table_wrap"><table summary="{!MAP_TABLE}" class="wide_table results_table autosized_table">
	<thead>
		<tr>
			<th>{!NAME}</th>
			<th>{!AMOUNT}</th>
			<th>{!DATE_TIME}</th>
			{+START,IF,{$NOT,{$MOBILE}}}
				<th>{!STATUS}</th>
			{+END}
		</tr>
	</thead>

	<tbody>
		{+START,LOOP,ORDERS}
			{$SET,cycle,{$CYCLE,results_table_zebra,zebra_0,zebra_1}}

			<tr class="{$GET,cycle} thick_border">
				<td>
					{+START,IF_NON_EMPTY,{ORDER_DET_URL}}
						<strong><a href="{ORDER_DET_URL*}">{ORDER_TITLE*}</a></strong>
					{+END}
					{+START,IF_EMPTY,{ORDER_DET_URL}}
						<strong>{ORDER_TITLE*}</strong>
					{+END}

					{+START,IF,{$MOBILE}}
						<p class="assocated_details">
							<span class="field_name">{!STATUS}:</span> {STATE*}
						</p>
					{+END}
				</td>
				<td>
					{$CURRENCY_SYMBOL}{AMOUNT*}
				</td>
				<td>
					{TIME*}
				</td>
				{+START,IF,{$NOT,{$MOBILE}}}
					<td>
						{STATE*}
					</td>
				{+END}
			</tr>
			{+START,IF_NON_EMPTY,{NOTE}}
				<tr>
					<td colspan="5">
						{NOTE*}
					</td>
				</tr>
			{+END}
		{+END}
	</tbody>
</table></div>
