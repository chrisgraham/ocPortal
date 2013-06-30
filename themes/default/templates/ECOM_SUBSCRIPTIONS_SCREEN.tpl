{TITLE}

<div class="wide_table_wrap autosized_table"><table summary="{!COLUMNED_TABLE}" class="autosized_table results_table wide_table" itemprop="significantLinks">
	<thead>
		<tr>
			<th>
				{!TITLE}
			</th>
			<th>
				{!COST}
			</th>
			<th>
				{!DATE}
			</th>
			{+START,IF,{$NOT,{$MOBILE}}}
				<th>{!STATUS}</th>
			{+END}
			<th>
				{!ACTIONS}
			</th>
		</tr>
	</thead>

	<tbody>
		{+START,LOOP,SUBSCRIPTIONS}
			<tr>
				<th>
					{SUBSCRIPTION_TITLE*}

					{+START,IF,{$MOBILE}}
						<p class="assocated_details">
							<span class="field_name">{!STATUS}:</span> {STATE*}
						</p>
					{+END}
				</th>
				<td>
					{$CURRENCY_SYMBOL}{AMOUNT*}, {PER}
				</td>
				<td>
					{TIME*}
				</td>
				{+START,IF,{$NOT,{$MOBILE}}}
					<td>
						{STATE*}
					</td>
				{+END}
				<td class="subscriptions_cancel_button">
					{+START,IF_PASSED,CANCEL_BUTTON}
						{CANCEL_BUTTON}
					{+END}
					{+START,IF_NON_PASSED,CANCEL_BUTTON}
						<a onclick="var t=this; window.fauxmodal_confirm('{!SUBSCRIPTION_CANCEL_WARNING_GENERAL=;}',function(result) { if (result) { click_link(t); } }); return false;" href="{$PAGE_LINK*,_SELF:_SELF:cancel:{ID}}">{!SUBSCRIPTION_CANCEL}</a>
					{+END}
				</td>
			</tr>
		{+END}
	</tbody>
</table></div>
