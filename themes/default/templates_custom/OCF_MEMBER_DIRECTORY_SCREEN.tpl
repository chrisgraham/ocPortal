{TITLE}

{$REQUIRE_CSS,search}
{$REQUIRE_CSS,member_directory_boxes}
{$REQUIRE_JAVASCRIPT,javascript_ajax}
{$REQUIRE_JAVASCRIPT,javascript_ajax_people_lists}

{+START,IF_PASSED,SYMBOLS}
	<div class="float_surrounder"><div class="pagination alphabetical_jumper">
		{+START,LOOP,SYMBOLS}{+START,IF,{$EQ,{$_GET,md_start},{START}}}<span class="results_page_num">{SYMBOL*}</span>{+END}{+START,IF,{$NEQ,{$_GET,md_start},{START}}}<a class="results_continue alphabetical_jumper_cont" target="_self" href="{$PAGE_LINK*,_SELF:_SELF:md_start={START}:md_max={MAX}:md_sort=m_username ASC}">{SYMBOL*}</a>{+END}{+END}
	</div></div>
{+END}

{$SET,filters_row_a,m_username={!USERNAME},{!DEFAULT_CPF_interests_NAME}={!DEFAULT_CPF_interests_NAME},{!DEFAULT_CPF_location_NAME}={!DEFAULT_CPF_location_NAME}}
{$SET,filters_row_b,{!DEFAULT_CPF_occupation_NAME}={!DEFAULT_CPF_occupation_NAME},{!DEFAULT_CPF_SELF_DESCRIPTION_NAME}={!DEFAULT_CPF_SELF_DESCRIPTION_NAME}}

<div class="box"><div class="box_inner">
	<form title="{!SEARCH}" action="{$URL_FOR_GET_FORM*,{$SELF_URL}}" target="_self" method="get" class="advanced_member_search">
		{$HIDDENS_FOR_GET_FORM,{$SELF_URL}}

		{+START,SET,active_filter}{+START,LOOP,{$GET,filters_row_a}\,{$GET,filters_row_b}}{_loop_key}{$?,{$IS_EMPTY,{$CPF_LIST,{_loop_var}}},~=,=}<{$FIX_ID,{_loop_key}}>,{+END}{+END}

		<input type="hidden" name="active_filter" value="{$GET*,active_filter}" />

		<div class="search_fields float_surrounder">
			<div class="search_button">
				<input onclick="disable_button_just_clicked(this);" accesskey="u" class="button_pageitem" type="submit" value="{!member_directory_boxes:FILTER_RESULTS}" />
			</div>

			{+START,LOOP,{$GET,filters_row_a}}
				{+START,INCLUDE,OCF_MEMBER_DIRECTORY_SCREEN_FILTER}
					NAME={$FIX_ID,{_loop_key}}
					LABEL={_loop_var}
				{+END}
			{+END}
		</div>

		<div class="search_fields float_surrounder">
			{+START,IF_NON_EMPTY,{$_GET,active_filter}}
				<div class="search_button">
					<input onclick="window.location.href='{$PAGE_LINK*;,_SELF:_SELF}';" class="button_pageitem" type="button" value="{!member_directory_boxes:RESET_FILTER}" />
				</div>
			{+END}

			{+START,LOOP,{$GET,filters_row_b}}
				{+START,INCLUDE,OCF_MEMBER_DIRECTORY_SCREEN_FILTER}
					NAME={$FIX_ID,{_loop_key}}
					LABEL={_loop_var}
				{+END}
			{+END}
		</div>
	</form>
</div></div>

{+START,IF_EMPTY,{$_GET,active_filter}}
	<p>{!member_directory_boxes:MEMBER_BOXES_UNFILTERED,{$SITE_NAME*}}</p>
{+END}
{+START,IF_NON_EMPTY,{$_GET,active_filter}}
	{+START,IF_NON_EMPTY,{MEMBER_BOXES}}
		<p>{!member_directory_boxes:MEMBER_BOXES_FILTERED,{$SITE_NAME*}}</p>
	{+END}

	{+START,IF_EMPTY,{MEMBER_BOXES}}
		<p class="nothing_here red_alert">{!search:NO_RESULTS_SEARCH}</p>
	{+END}
{+END}

{+START,IF,{$HAS_ACTUAL_PAGE_ACCESS,_SEARCH:admin_newsletter}}
	<form title="{!NEWSLETTER}" action="{$PAGE_LINK*,_SEARCH:admin_newsletter:new}" method="post">
{+END}

{$SET,fancy_screen,1}
<div class="float_surrounder ocf_member_directory_boxes">
	{+START,LOOP,MEMBER_BOXES}
		{_loop_var}
	{+END}
</div>
{$SET,fancy_screen,0}

{+START,IF,{$HAS_ACTUAL_PAGE_ACCESS,_SEARCH:admin_newsletter}}
		{+START,LOOP,OTHER_IDS}
			<input type="hidden" name="result__member_{_loop_var*}" value="1" />
		{+END}

		<hr />

		<div class="float_surrounder">
			<p class="proceed_button right">
				<input class="button_page" type="submit" value="{!newsletter:NEWSLETTER_SEND_TO_ALL}" />
			</p>
		</div>
	</form>
{+END}

<div class="float_surrounder">
	{PAGINATION}
</div>
