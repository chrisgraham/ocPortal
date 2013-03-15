<table class="cart_payment_summary" summary="{!COLUMNED_TABLE}">
	<tbody>
		<tr>
			<th class="de_th">
				{!GRAND_TOTAL}
			</th>
			<td>
				<span class="price">{$CURRENCY_SYMBOL}{GRAND_TOTAL*}</span>
			</td>
		</tr>
	</tbody>
</table>

{+START,IF_NON_EMPTY,{PAYMENT_FORM}}
	<div class="cart_proceed_button">
		{PAYMENT_FORM}
	</div>
{+END}	
