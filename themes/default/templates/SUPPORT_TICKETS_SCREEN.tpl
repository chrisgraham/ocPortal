{TITLE}

{+START,IF_NON_EMPTY,{MESSAGE}}
	<p>{MESSAGE}</p>
{+END}

{+START,IF,{$NOT,{$IS_GUEST}}}
	<div class="box box___support_tickets_screen"><div class="box_inner vertical_alignment">
		<form title="{!FILTER}" class="float_surrounder" id="ticket_type_form" action="{$URL_FOR_GET_FORM*,{$SELF_URL,0,1}}" method="get" onsubmit="try { window.scrollTo(0,0); } catch(e) {};">
			{$HIDDENS_FOR_GET_FORM,{$SELF_URL,0,1},ticket_type}
			<label class="field_name" for="ticket_type">{!TICKET_TYPE}:</label>
			<select id="ticket_type" name="ticket_type" class="input_list_required">
				<option value="">&mdash;</option>
				{+START,LOOP,TYPES}
					<option value="{TICKET_TYPE*}"{+START,IF,{SELECTED}} selected="selected"{+END}>{NAME*}</option>{$,You can also use {LEAD_TIME} to get the ticket type's lead time}
				{+END}
			</select>
			<input onclick="disable_button_just_clicked(this);" class="button_pageitem" type="submit" value="{!FILTER}" />
		</form>
	</div></div>

	{+START,IF_EMPTY,{LINKS}}
		<p>{!SUPPORT_NO_TICKETS}</p>
	{+END}
	{+START,IF_NON_EMPTY,{LINKS}}
		<div class="wide_table_wrap"><table summary="{!COLUMNED_TABLE}" class="results_table wide_table support_tickets autosized_table">
			<thead>
				<tr>
					<th>
						{!SUPPORT_ISSUE}
					</th>
					{+START,IF,{$NOT,{$MOBILE}}}
						<th>
							{!COUNT_POSTS}
						</th>
					{+END}
					<th>
						{!LAST_POST_BY}
					</th>
					<th>
						{!DATE}
					</th>
				</tr>
			</thead>
			<tbody>
				{LINKS}
			</tbody>
		</table></div>
	{+END}
{+END}

<p class="buttons_group">
	<a rel="add" href="{ADD_TICKET_URL*}"><img class="button_page" src="{$IMG*,page/add_ticket}" title="{!ADD_TICKET}" alt="{!ADD_TICKET}" /></a>
</p>

