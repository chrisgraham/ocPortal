{+START,IF_PASSED,SYMBOLS}
	<div class="float_surrounder"><div class="pagination alphabetical_jumper">
		{+START,LOOP,SYMBOLS}{+START,IF,{$EQ,{$_GET,{BLOCK_ID}_start},{START}}}<span class="results_page_num">{SYMBOL*}</span>{+END}{+START,IF,{$NEQ,{$_GET,{BLOCK_ID}_start},{START}}}<a class="results_continue alphabetical_jumper_cont" target="_self" href="{$PAGE_LINK*,_SELF:_SELF:{BLOCK_ID}_start={START}:{BLOCK_ID}_max={MAX}:{BLOCK_ID}_sort=m_username ASC}">{SYMBOL*}</a>{+END}{+END}
	</div></div>
{+END}

{$REQUIRE_JAVASCRIPT,javascript_ajax}
{$REQUIRE_JAVASCRIPT,javascript_ajax_people_lists}

<div class="box advanced_member_search"><div class="box_inner">
	<form title="{!SEARCH}" action="{$URL_FOR_GET_FORM*,{$SELF_URL}}" target="_self" method="get">
		{$HIDDENS_FOR_GET_FORM,{$SELF_URL},{BLOCK_ID}_start,{BLOCK_ID}_max,{BLOCK_ID}_sort,{BLOCK_ID}_filter_*}

		{+START,SET,active_filter}{+START,LOOP,{FILTERS_ROW_A}\,{FILTERS_ROW_B}}{_loop_key}{$?,{$IS_EMPTY,{$CPF_LIST,{_loop_var}}},~=,=}<{$FIX_ID,{_loop_key}}>,{+END}{+END}

		<div class="search_fields float_surrounder">
			<div class="search_button">
				<input onclick="disable_button_just_clicked(this);" accesskey="u" class="buttons__filter button_screen_item" type="submit" value="{!FILTER}" />
			</div>

			{+START,LOOP,{FILTERS_ROW_A}}
				{+START,INCLUDE,OCF_MEMBER_DIRECTORY_SCREEN_FILTER}
					NAME={$FIX_ID,{_loop_key}}
					LABEL={_loop_var}
				{+END}
			{+END}
		</div>

		<div class="search_fields float_surrounder">
			{+START,IF_NON_EMPTY,{$_GET,active_filter}}
				<div class="search_button">
					<input onclick="window.location.href='{$PAGE_LINK;*,_SELF:_SELF}';" class="buttons__clear button_screen_item" type="button" value="{!RESET_FILTER}" />
				</div>
			{+END}

			{+START,LOOP,{FILTERS_ROW_B}}
				{+START,INCLUDE,OCF_MEMBER_DIRECTORY_SCREEN_FILTER}
					NAME={$FIX_ID,{_loop_key}}
					LABEL={_loop_var}
				{+END}
			{+END}
		</div>
	</form>
</div></div>

{+START,IF,{$NOT,{HAS_ACTIVE_FILTER}}}
	{+START,IF_NON_EMPTY,{MEMBER_BOXES}}
		<p>{!MEMBER_DIRECTORY_UNFILTERED,{$SITE_NAME*}}</p>
	{+END}

	{+START,IF_EMPTY,{MEMBER_BOXES}}
		<p class="nothing_here">{!MEMBER_DIRECTORY_UNFILTERED_NO_RESULTS,{$SITE_NAME*}}</p>
	{+END}
{+END}
{+START,IF,{HAS_ACTIVE_FILTER}}
	{+START,IF_NON_EMPTY,{MEMBER_BOXES}}
		<p>{!MEMBER_DIRECTORY_FILTERED,{$SITE_NAME*}}</p>
	{+END}

	{+START,IF_EMPTY,{MEMBER_BOXES}}
		<p class="nothing_here">{!MEMBER_DIRECTORY_FILTERED_NO_RESULTS,{$SITE_NAME*}}</p>
	{+END}
{+END}

{+START,IF,{$NEQ,{DISPLAY_MODE},listing}}
	{$SET,fancy_screen,1}
	<div class="block_main_members block_main_members__{DISPLAY_MODE%} float_surrounder">
		{+START,LOOP,MEMBER_BOXES}
			{+START,IF,{$EQ,{DISPLAY_MODE},avatars,photos}}
				<div style="{ITEM_WIDTH*}" onmouseover="if (typeof window.activate_tooltip!='undefined') activate_tooltip(this,event,'{BOX;^*}','auto');">
					<p>
						<a href="{$MEMBER_PROFILE_URL*,{MEMBER_ID}}"><img alt="" src="{$?*,{$EQ,{DISPLAY_MODE},avatars},{$AVATAR,{MEMBER_ID}},{$PHOTO,{MEMBER_ID}}}"></a>
					</p>

					<p>
						<a href="{$MEMBER_PROFILE_URL*,{MEMBER_ID}}" onfocus="this.parentNode.onmouseover(event);" onblur="this.parentNode.onmouseout(event);">{$USERNAME*,{MEMBER_ID}}</a>
					</p>
				</div>

				{+START,IF,{BREAK}}
					<br />
				{+END}
			{+END}

			{+START,IF,{$EQ,{DISPLAY_MODE},media}}
				<div style="{ITEM_WIDTH*}" class="image_fader_item" onmouseover="if (typeof window.activate_tooltip!='undefined') activate_tooltip(this,event,'{BOX;^*}','auto');">
					{+START,NO_PREPROCESSING}
						<div class="box"><div class="box_inner">
							<h3>{$USERNAME*,{MEMBER_ID}}</h3>

							{$BLOCK,block=main_image_fader,param={GALLERY_NAME}}

							<a href="{$MEMBER_PROFILE_URL*,{MEMBER_ID}}" onfocus="this.parentNode.onmouseover(event);" onblur="this.parentNode.onmouseout(event);">{$USERNAME*,{MEMBER_ID}}</a>
						</div></div>
					{+END}
				</div>

				{+START,IF,{BREAK}}
					<br />
				{+END}
			{+END}

			{+START,IF,{$EQ,{DISPLAY_MODE},boxes}}
				<div style="{ITEM_WIDTH*}">
					{BOX}
				</div>

				{+START,IF,{BREAK}}
					<br />
				{+END}
			{+END}
		{+END}
	</div>
	{$SET,fancy_screen,0}
{+END}

{+START,IF,{$EQ,{DISPLAY_MODE},listing}}
	{RESULTS_TABLE}
{+END}

<div class="float_surrounder">
	{PAGINATION}
</div>
