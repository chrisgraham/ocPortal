{TITLE}

{+START,INCLUDE,handle_conflict_resolution}{+END}
{+START,IF_PASSED,WARNING_DETAILS}
	{WARNING_DETAILS}
{+END}

<form title="{!PRIMARY_PAGE_FORM}" id="comments_form" onsubmit="return (checkFieldForBlankness(this.elements['post'],event)) &amp;&amp; ((!this.elements['ticket_type']) || (checkFieldForBlankness(this.elements['ticket_type'],event)));" action="{URL*}" method="post" enctype="multipart/form-data"{$?,{$VALUE_OPTION,html5}, itemscope="itemscope" itemtype="http://schema.org/ContactPage"}>
	<div>
		{+START,IF,{NEW}}
			<div class="ticket_page_text">
				{TICKET_PAGE_TEXT}
			</div>

			<h2>{!DETAILS}</h2>

			<div>
				<span class="field_name"><label for="ticket_type">{!TICKET_TYPE}</label></span>:
				<select id="ticket_type" name="ticket_type" class="input_list_required">
					<option value="">---</option>
					{+START,LOOP,TYPES}
					<option value="{TICKET_TYPE*}"{+START,IF,{SELECTED}} selected="selected"{+END}>{NAME*}</option>{$,You can also use {LEAD_TIME} to get the ticket type's lead time}
					{+END}
				</select>
			</div>
			<div id="error_ticket_type" style="display: none" class="input_error_here">&nbsp;</div>
		{+END}

		<br />
		{COMMENTS}

		{+START,IF_NON_EMPTY,{STAFF_DETAILS}}
			{$,Load up the staff actions template to display staff actions uniformly (we relay our parameters to it)...}
			{+START,INCLUDE,STAFF_ACTIONS}
				1_URL={STAFF_DETAILS*}
				1_TITLE={!VIEW_COMMENT_TOPIC}
			{+END}
		{+END}
	</div>

	{+START,IF_NON_EMPTY,{COMMENT_BOX}}
		{+START,IF_NON_EMPTY,{STAFF_ONLY}}
			<div class="wide_table_wrap"><table summary="{!MAP_TABLE}" class="dottedborder wide_table">
				{+START,IF,{$NOT,{$MOBILE}}}
					<colgroup>
						<col style="width: 198px" />
						<col style="width: 100%" />
					</colgroup>
				{+END}

				<tbody>
					{STAFF_ONLY}
				</tbody>
			</table></div>
		{+END}

		{COMMENT_BOX}
	{+END}
</form>

{+START,IF_PASSED,TOGGLE_TICKET_CLOSED_URL}
	<div class="float_surrounder">
		{+START,INCLUDE,SCREEN_BUTTON}
			TITLE={$?,{CLOSED},{!OPEN_TICKET},{!CLOSE_TICKET}}
			IMG={$?,{CLOSED},closed,close}
			IMMEDIATE=1
			URL={TOGGLE_TICKET_CLOSED_URL}
		{+END}
	</div>
{+END}

<br />

<h2>{!OTHER_TICKETS_BY_MEMBER,{USERNAME*}}</h2>

{+START,IF_EMPTY,{OTHER_TICKETS}}
	<p class="nothing_here">{!NONE}</p>
{+END}
{+START,IF_NON_EMPTY,{OTHER_TICKETS}}
	<div class="wide_table_wrap"><table summary="{!COLUMNED_TABLE}" class="solidborder wide_table support_tickets">
		{+START,IF,{$NOT,{$MOBILE}}}
			<colgroup>
				<col style="width: 100%" />
				<col style="width: 120px" />
				<col style="width: 198px" />
				<col style="width: 120px" />
			</colgroup>
		{+END}

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
			{OTHER_TICKETS}
		</tbody>
	</table></div>
{+END}
