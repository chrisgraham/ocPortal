{+START,BOX,,,curved}
	<table class="proceed-box" summary="{!COLUMNED_TABLE}">
		{+START,IF,{$NOT,{$MOBILE}}}
			<colgroup>
				<col style="width: 80%"/>
				<col style="width: 20%"/>
			</colgroup>
		{+END}
		<tbody>
			<tr>				
				<th class="a-right" colspan="1">{!GRAND_TOTAL}</th>
				<td class="a-middle">
					<span class="price">{$CURRENCY_SYMBOL} {GRAND_TOTAL*}</span>
				</td>
			</tr>
		</tbody>
	</table>
	{+START,IF_NON_EMPTY,{PAYMENT_FORM}}
		<div class="proceed-button">
			{PAYMENT_FORM}
		</div>
	{+END}	
{+END}

