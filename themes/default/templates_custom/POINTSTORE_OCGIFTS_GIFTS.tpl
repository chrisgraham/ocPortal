{TITLE}

{+START,INCLUDE,handle_conflict_resolution}{+END}
{+START,IF_PASSED,WARNING_DETAILS}
	{WARNING_DETAILS}
{+END}

{+START,IF_NON_EMPTY,{GIFTS}}
	{$, Old table style
		<div class="wide_table_wrap">
			<table class="wide_table solidborder">
				<colgroup>
					<col width="100" />
					<col width="100%" />
					<col width="100" />
					<col width="100" />
				</colgroup>

				<thead>
					<tr style="border: 1px solid #ccc; background-color: #E3EAF6;">
						<th colspan="2">{!GIFT}</th>
						<th width="33%">{!GIFT_PRICE}</th>
						<th width="33%">{!ACTIONS}</th>
					</tr>
				</thead>

				<tbody>
					{+START,LOOP,GIFTS}
						<tr style="border: 1px solid #ccc; background-color: #D4E0F1;">
							<td style="padding: 10px;">
								<img src="{$THUMBNAIL*,{IMAGE_URL},80}" />
							</td>
							<td style="padding: 10px;">
								{NAME*}
							</td>
							<td width="33%" style="text-align: center; padding: 10px;">
								{!_GIFT_PRICE,{PRICE*}}
							</td>
							<td width="33%" style="text-align: center; padding: 10px;">
								<a title="{NAME*}" href="{GIFT_URL*}">{!PURCHASE}</a>
							</td>
						</tr>
					{+END}
				</tbody>
			</table>
		</div>
	}

	<p>{!CHOOSE_YOUR_GIFT}</p>

	{+START,BOX}
		{+START,LOOP,GIFTS}
			<div style="float: left; margin: 15px" onmouseout="if (typeof window.deactivateTooltip!='undefined') deactivateTooltip(this,event);" onmousemove="if (typeof window.activateTooltip!='undefined') repositionTooltip(this,event);" onmouseover="if (typeof window.activateTooltip!='undefined') activateTooltip(this,event,'{NAME^;*}.&lt;br /&gt;&lt;br /&gt;{!GIFT_POPULARITY^;*,{POPULARITY}}','auto');">
				<a href="{GIFT_URL*}"><img title="{NAME*}" src="{$THUMBNAIL*,{IMAGE_URL},80x80,,,,pad,both,#FFFFFF00}" /></a>

				<p style="text-align: center" class="associated_details">[ <a title="{NAME*}" href="{GIFT_URL*}">{!_GIFT_PRICE,{PRICE*}}</a> ]</p>
			</div>
		{+END}
	{+END}

	<br />

	<div class="float_surrounder">
		<form style="float: left; margin-top: 3px" title="{!SORT_BY}" action="{$SELF_URL*,,,,category=<null>,start=0}" method="post">
			<div class="inline">
				<label for="category">{!CATEGORY}</label>
				<select id="category" name="category">
					<option value="">{!ALL_EM}</option>
					{+START,LOOP,CATEGORIES}
						<option{+START,IF,{$EQ,{_loop_var},{CATEGORY}}} selected="selected"{+END}>{_loop_var*}</option>
					{+END}
				</select>

				<input onclick="disable_button_just_clicked(this);" class="button_micro" type="submit" value="{!FILTER}" />
			</div>
		</form>

		{+START,IF_NON_EMPTY,{RESULTS_BROWSER}}
			{RESULTS_BROWSER}
		{+END}
	</div>
{+END}

{+START,IF_EMPTY,{GIFTS}}
	<p class="no_entries">{!NO_GIFTS_TO_DISPLAY}</p>
{+END}
