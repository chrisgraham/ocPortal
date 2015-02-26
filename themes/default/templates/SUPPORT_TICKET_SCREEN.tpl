{TITLE}

{+START,INCLUDE,HANDLE_CONFLICT_RESOLUTION}{+END}
{+START,IF_PASSED,WARNING_DETAILS}
	{WARNING_DETAILS}
{+END}

<div>
	{+START,IF,{NEW}}
		<div class="ticket_page_text">
			{TICKET_PAGE_TEXT}
		</div>

		{+START,SET,EXTRA_COMMENTS_FIELDS_1}
			<tr>
				<th class="de_th">
					<span class="field_name"><label for="ticket_type">{!TICKET_TYPE}:</label></span>
				</th>
				<td>
					<select id="ticket_type" name="ticket_type" class="input_list_required wide_field">
						<option value="">---</option>
						{+START,LOOP,TYPES}
							<option value="{TICKET_TYPE*}"{+START,IF,{SELECTED}} selected="selected"{+END}>{NAME*}</option>{$,You can also use {LEAD_TIME} to get the ticket type's lead time}
						{+END}
					</select>
					<div id="error_ticket_type" style="display: none" class="input_error_here"></div>
				</td>
			</tr>
		{+END}
	{+END}

	<div id="comments_wrapper">
		{COMMENTS}
	</div>

	{+START,IF_PASSED,SERIALIZED_OPTIONS}{+START,IF_PASSED,HASH}
		<script type="text/javascript">// <![CDATA[
			window.comments_serialized_options='{SERIALIZED_OPTIONS;/}';
			window.comments_hash='{HASH;/}';
		//]]></script>
	{+END}{+END}

	{+START,IF_PASSED,PAGINATION}
		<div class="float_surrounder">
			{PAGINATION}
		</div>
	{+END}

	{+START,IF_NON_EMPTY,{STAFF_DETAILS}}
		{$,Load up the staff actions template to display staff actions uniformly (we relay our parameters to it)...}
		{+START,INCLUDE,STAFF_ACTIONS}
			1_URL={STAFF_DETAILS*}
			1_TITLE={!VIEW_COMMENT_TOPIC}
		{+END}
	{+END}
</div>

{+START,IF_NON_EMPTY,{COMMENT_FORM}}
	{+START,SET,EXTRA_COMMENTS_FIELDS_2}
		{+START,IF_NON_EMPTY,{STAFF_ONLY}}
			{STAFF_ONLY}
		{+END}
	{+END}

	<form title="{!PRIMARY_PAGE_FORM}" id="comments_form" onsubmit="return (check_field_for_blankness(this.elements['post'],event)) &amp;&amp; ((!this.elements['ticket_type']) || (check_field_for_blankness(this.elements['ticket_type'],event)));" action="{URL*}" method="post" enctype="multipart/form-data" itemscope="itemscope" itemtype="http://schema.org/ContactPage">
		{COMMENT_FORM}
	</form>
{+END}

<div class="buttons_group">
	{+START,IF,{$NEQ,{$_GET,type},ticket}}
		{+START,INCLUDE,SCREEN_BUTTON}
			TITLE={!CREATE_SUPPORT_TICKET}
			IMG=add_ticket
			URL={ADD_TICKET_URL}
			IMMEDIATE=0
		{+END}
	{+END}
	{+START,IF_PASSED,TOGGLE_TICKET_CLOSED_URL}
		{+START,INCLUDE,SCREEN_BUTTON}
			TITLE={$?,{CLOSED},{!OPEN_TICKET},{!CLOSE_TICKET}}
			IMG={$?,{CLOSED},closed,close}
			IMMEDIATE=1
			URL={TOGGLE_TICKET_CLOSED_URL}
		{+END}
	{+END}
</div>

<h2>{!OTHER_TICKETS_BY_MEMBER,{USERNAME*}}</h2>

{+START,IF_EMPTY,{OTHER_TICKETS}}
	<p class="nothing_here">{!NONE}</p>
{+END}
{+START,IF_NON_EMPTY,{OTHER_TICKETS}}
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
			{OTHER_TICKETS}
		</tbody>
	</table></div>
{+END}
