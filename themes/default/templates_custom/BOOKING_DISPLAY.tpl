<h2>{!BOOKINGS}</h2>

{+START,LOOP,DETAILS}
	<h3>{BOOKABLE_TITLE*}</h3>

	<div class="wide_table_wrap"><table class="wide_table solidborder"><tbody>
		<tr>
			<th>{!QUANTITY}</th>
			<td>{QUANTITY*}</td>
		</tr>
		<tr>
			<th>{!DATE}</th>
			<td>{START*}{+START,IF_NON_EMPTY,{END}} &ndash; {END*}{+END}</td>
		</tr>
		{+START,IF_NON_EMPTY,{NOTES}}
			<tr>
				<th>{!NOTES}</th>
				<td>{NOTES*}</td>
			</tr>
		{+END}
		{+START,IF_NON_EMPTY,{SUPPLEMENTS}}
			<tr>
				<th>{!OPTIONS}</th>
				<td>
					{+START,LOOP,SUPPLEMENTS}
						{SUPPLEMENT_TITLE*} &times; {SUPPLEMENT_QUANTITY*}
						{+START,IF_NON_EMPTY,{SUPPLEMENT_NOTES}}
							({SUPPLEMENT_NOTES*})
						{+END}
						<br />
					{+END}
				</td>
			</tr>
		{+END}
	</tbody></table></div>
{+END}

<h2>{!DETAILS}</h2>

<div class="wide_table_wrap"><table class="wide_table solidborder"><tbody>
	<tr>
		<th>{!TOTAL_PRICE}</th>
		<td>{PRICE*}</td>
	</tr>
	<tr>
		<th>{!CUSTOMER_NAME}</th>
		<td><a href="{$MEMBER_PROFILE_LINK*,{MEMBER_ID}}">{USERNAME*}</a></td>
	</tr>
	<tr>
		<th>{!CUSTOMER_EMAIL}</th>
		<td>{EMAIL_ADDRESS*}</td>
	</tr>
</tbody></table></div>
