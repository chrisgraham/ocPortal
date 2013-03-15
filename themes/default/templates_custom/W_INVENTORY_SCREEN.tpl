{TITLE}

<div class="float_surrounder">
	{+START,IF_NON_EMPTY,{AVATAR}}
		<div class="ocw_avatar">
			<img alt="{!W_AVATAR}" src="{AVATAR*}" />
			{+START,IF_NON_EMPTY,{PIC}}
				[<a title="{!W_PHOTO}: {!LINK_NEW_WINDOW}" target="_blank" href="{PIC*}">{!W_PHOTO}</a>]
			{+END}
		</div>
	{+END}

	<p>
		{!W_HAS_HEALTH,{USERNAME*},{HEALTH*}}
	</p>
</div>

{+START,IF_NON_EMPTY,{INVENTORY}}
	<div class="wide_table_wrap"><table summary="{!COLUMNED_TABLE}" class="wide_table ocw_inventory results_table ocw_centered_contents autosized_table">
		<thead>
			<tr>
				<th>{!W_PICTURE}</th>
				<th>{!NAME}/{!DESCRIPTION}</th>
				<th>{!COUNT_TOTAL}</th>
				<th>{!W_PROPERTIES}</th>
			</tr>
		</thead>

		<tbody>
			{INVENTORY}
		</tbody>
	</table></div>
{+END}

{+START,IF_EMPTY,{INVENTORY}}
	<p class="nothing_here">{!W_EMPTY_INVENTORY}</p>
{+END}

