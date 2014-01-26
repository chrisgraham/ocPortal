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
		<script>// <![CDATA[
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
			1_ICON=feedback/comments_topic
			{+START,IF_PASSED,TICKET_TYPE}{+START,IF,{$HAS_PRIVILEGE,assume_any_member}}
				{+START,IF,{$NEQ,{USERNAME},{$USERNAME}}}
					2_URL={$PAGE_LINK,_SEARCH:tickets:ticket:default={TICKET_TYPE}:post={!TICKET_SPLIT_POST&,{USERNAME}}:keep_su={USERNAME}}
					2_TITLE={!STAFF_NEW_TICKET_AS,{USERNAME}}
					2_ICON=buttons/add_ticket
				{+END}{+END}
				{+START,IF_PASSED,SUPPORT_OPERATOR_URL}
					3_URL={SUPPORT_OPERATOR_URL}
					3_TITLE={!SUPPORT_ACCOUNT_SWITCH}
					3_ICON=menu/site_meta/user_actions/login
				{+END}
			{+END}
		{+END}
	{+END}
</div>

{+START,SET,EXTRA_COMMENTS_FIELDS_2}
	{+START,IF,{STAFF_ONLY}}
		<tr>
			<th class="de_th">
				<span class="field_name">{!TICKET_STAFF_ONLY}:</span>
			</th>
			<td class="one_line">
				<label for="staff_only"><input type="checkbox" id="staff_only" name="staff_only" value="1" /> {!TICKET_STAFF_ONLY_DESCRIPTION}</label>
			</td>
		</tr>
	{+END}

	{+START,IF,{$NOT,{CLOSED}}}{+START,IF,{$NOT,{NEW}}}{+START,IF,{$OCF}}
		<tr>
			<th class="de_th">
				<span class="field_name">{!CLOSE_TICKET}:</span>
			</th>
			<td class="one_line">
				<label for="close"><input type="checkbox" id="close" name="close" value="1" /> {!DESCRIPTION_CLOSE_TICKET}</label>
			</td>
		</tr>
	{+END}{+END}{+END}
{+END}

{$SET,COMMENT_POSTING_ROWS,20}

{+START,IF_NON_EMPTY,{COMMENT_FORM}}
	<form title="{!PRIMARY_PAGE_FORM}" id="comments_form" onsubmit="return (check_field_for_blankness(this.elements['post'],event)) &amp;&amp; ((!this.elements['ticket_type']) || (check_field_for_blankness(this.elements['ticket_type'],event)));" action="{URL*}" method="post" enctype="multipart/form-data" itemscope="itemscope" itemtype="http://schema.org/ContactPage">
		{COMMENT_FORM}
	</form>

	<hr class="spaced_rule" />
{+END}

<div class="buttons_group">
	{+START,IF,{$NEQ,{$_GET,type},ticket}}
		{+START,INCLUDE,BUTTON_SCREEN}
			TITLE={!CREATE_SUPPORT_TICKET}
			IMG=add_ticket
			URL={ADD_TICKET_URL}
			IMMEDIATE=0
		{+END}
	{+END}
	{+START,IF_PASSED,TOGGLE_TICKET_CLOSED_URL}
		{+START,INCLUDE,BUTTON_SCREEN}
			TITLE={$?,{CLOSED},{!OPEN_TICKET},{!CLOSE_TICKET}}
			IMG={$?,{CLOSED},buttons__closed,buttons__clear}
			IMMEDIATE=1
			URL={TOGGLE_TICKET_CLOSED_URL}
		{+END}
	{+END}
</div>

<h2>{!OTHER_TICKETS_BY_MEMBER,{$DISPLAYED_USERNAME*,{USERNAME}}}</h2>

{+START,IF_EMPTY,{OTHER_TICKETS}}
	<p class="nothing_here">{!NONE}</p>
{+END}
{+START,IF_NON_EMPTY,{OTHER_TICKETS}}
	<div class="wide_table_wrap"><table class="columned_table results_table wide_table support_tickets autosized_table">
		<thead>
			<tr>
				<th>
					{!SUPPORT_TICKET}
				</th>
				<th>
					{!TICKET_TYPE}
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

{+START,IF,{$IS_STAFF}}
	{+START,IF_NON_EMPTY,{TYPE_ACTIVITY_OVERVIEW}}
		<p>
			{!TICKET_ACTIVITY_OVERVIEW,{USERNAME*}}
		</p>

		<dl class="compact_list">
			{+START,LOOP,TYPE_ACTIVITY_OVERVIEW}
				<dt>
					{OVERVIEW_TYPE*}
				</dt>
				<dd>
					{$NUMBER_FORMAT*,{OVERVIEW_COUNT}}
				</dd>
			{+END}
		</dl>
	{+END}
{+END}
