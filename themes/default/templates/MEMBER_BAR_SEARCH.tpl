{$,Forum/private topic search}
{+START,IF,{$EQ,{$PAGE},forumview}}
	{+START,IF,{$EQ,{$_GET,type},pt}}
		<div class="ocf_search_box">
			<form title="{!SEARCH}" action="{$URL_FOR_GET_FORM*,{$PAGE_LINK*,_SEARCH:search:results:ocf_own_pt,1}}" method="get">
				{$HIDDENS_FOR_GET_FORM,{$PAGE_LINK,_SEARCH:search:results:ocf_own_pt,1}}

				<div class="vertical_alignment">
					<label class="accessibility_hidden" for="member_bar_search">{!_SEARCH_PRIVATE_TOPICS}</label><input maxlength="255" type="text" name="content" id="member_bar_search" onfocus="placeholder_focus(this);" onblur="placeholder_blur(this);" class="field_input_non_filled" value="{!_SEARCH_PRIVATE_TOPICS}" /><input class="buttons__search button_micro" type="submit" onclick="disable_button_just_clicked(this);" value="{!SEARCH}" /> <a class="horiz_field_sep associated_link" href="{$PAGE_LINK*,_SEARCH:search:misc:ocf_own_pt}" title="{!MORE}: {!search:SEARCH_OPTIONS}">{!MORE}</a>
				</div>
			</form>
		</div>
	{+END}
	{+START,IF,{$NEQ,{$_GET,type},pt}}
		<div class="ocf_search_box">
			<form title="{!SEARCH}" action="{$URL_FOR_GET_FORM*,{$PAGE_LINK*,_SEARCH:search:results:ocf_posts:search_under={$_GET,id},1}}" method="get">
				{$HIDDENS_FOR_GET_FORM,{$PAGE_LINK,_SEARCH:search:results:ocf_posts:search_under={$_GET,id},1}}

				<div class="vertical_alignment">
					<label class="accessibility_hidden" for="member_bar_search">{!SEARCH_FORUM_POSTS}</label><input maxlength="255" type="text" name="content" id="member_bar_search" onfocus="placeholder_focus(this);" onblur="placeholder_blur(this);" class="field_input_non_filled" value="{!SEARCH_FORUM_POSTS}" /><input class="buttons__search button_micro" type="submit" onclick="disable_button_just_clicked(this);" value="{!SEARCH}" /> <a class="horiz_field_sep associated_link" href="{$PAGE_LINK*,_SEARCH:search:misc:ocf_posts:search_under={$_GET,id}}" title="{!MORE}: {!search:SEARCH_OPTIONS}">{!MORE}</a>
				</div>
			</form>
		</div>
	{+END}
{+END}

{$,Topic search}
{+START,IF,{$EQ,{$PAGE},topicview}}
	<div class="ocf_search_box">
		<form title="{!SEARCH}" action="{$URL_FOR_GET_FORM*,{$PAGE_LINK,_SEARCH:search:results:ocf_within_topic:search_under={$_GET,id}}}" method="get">
			{$HIDDENS_FOR_GET_FORM,{$PAGE_LINK,_SEARCH:search:results:ocf_within_topic:search_under={$_GET,id}}}

			<div class="vertical_alignment">
				<label class="accessibility_hidden" for="member_bar_search">{!SEARCH_POSTS_WITHIN_TOPIC}</label><input maxlength="255" type="text" name="content" id="member_bar_search" onfocus="placeholder_focus(this);" onblur="placeholder_blur(this);" class="field_input_non_filled" value="{!SEARCH_POSTS_WITHIN_TOPIC}" /><input class="buttons__search button_micro" type="submit" onclick="disable_button_just_clicked(this);" value="{!SEARCH}" /> <a class="horiz_field_sep associated_link" href="{$PAGE_LINK*,_SEARCH:search:misc:ocf_within_topic:search_under={$_GET,id}}" title="{!MORE}: {!search:SEARCH_OPTIONS}">{!MORE}</a>
			</div>
		</form>
	</div>
{+END}

{$,General search}
{+START,IF,{$NEQ,{$PAGE},forumview,topicview}}
	<div class="ocf_search_box">
		<form title="{!SEARCH}" action="{$URL_FOR_GET_FORM*,{$PAGE_LINK,_SEARCH:search:results}}" method="get">
			{$HIDDENS_FOR_GET_FORM,{$PAGE_LINK,_SEARCH:search:results}}

			<div class="vertical_alignment">
				<label class="accessibility_hidden" for="member_bar_search">{!SEARCH}</label><input maxlength="255" type="text" name="content" id="member_bar_search" onfocus="placeholder_focus(this);" onblur="placeholder_blur(this);" class="field_input_non_filled" value="{!SEARCH}" /><input class="buttons__search button_micro" type="submit" onclick="disable_button_just_clicked(this);" value="{!SEARCH}" /> <a class="horiz_field_sep associated_link" href="{$PAGE_LINK*,_SEARCH:search:misc}" title="{!MORE}: {!search:SEARCH_OPTIONS}">{!MORE}</a>
			</div>
		</form>
	</div>
{+END}
