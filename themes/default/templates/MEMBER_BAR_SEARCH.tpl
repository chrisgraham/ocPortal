{$,Forum/private topic search}
{+START,IF,{$EQ,{$PAGE},forumview}}
	{+START,IF,{$EQ,{$_GET,type},pt}}
		<div class="ocf_search_box">
			<form title="{!SEARCH}" action="{$URL_FOR_GET_FORM*,{$PAGE_LINK*,_SEARCH:search:results:ocf_own_pt,1}}" method="get">
				{$HIDDENS_FOR_GET_FORM,{$PAGE_LINK,_SEARCH:search:results:ocf_own_pt,1}}

				<div>
					<label class="accessibility_hidden" for="member_bar_search">{!_SEARCH_PRIVATE_TOPICS}</label><input maxlength="255" type="text" name="content" id="member_bar_search" onfocus="if (this.value=='{!_SEARCH_PRIVATE_TOPICS;}') { this.value=''; this.className=''; }" onblur="if (this.value=='') { this.value='{!_SEARCH_PRIVATE_TOPICS;}'; this.className='field_input_non_filled'; };" class="field_input_non_filled" value="{!_SEARCH_PRIVATE_TOPICS}" /> <input class="button_micro" type="submit" onclick="disable_button_just_clicked(this);" value="{!SEARCH}" /> <span class="horiz_field_sep associated_link"><a href="{$PAGE_LINK*,_SEARCH:search:misc:ocf_own_pt}" title="{!MORE}: {!search:SEARCH_OPTIONS}">{!MORE}</a></span>
				</div>
			</form>
		</div>
	{+END}
	{+START,IF,{$NEQ,{$_GET,type},pt}}
		<div class="ocf_search_box">
			<form title="{!SEARCH}" action="{$URL_FOR_GET_FORM*,{$PAGE_LINK*,_SEARCH:search:results:ocf_posts:search_under={$_GET,id},1}}" method="get">
				{$HIDDENS_FOR_GET_FORM,{$PAGE_LINK,_SEARCH:search:results:ocf_posts:search_under={$_GET,id},1}}

				<div>
					<label class="accessibility_hidden" for="member_bar_search">{!SEARCH_FORUM_POSTS}</label><input maxlength="255" type="text" name="content" id="member_bar_search" onfocus="if (this.value=='{!SEARCH_FORUM_POSTS;}') { this.value=''; this.className=''; }" onblur="if (this.value=='') { this.value='{!SEARCH_FORUM_POSTS;}'; this.className='field_input_non_filled'; };" class="field_input_non_filled" value="{!SEARCH_FORUM_POSTS}" /> <input class="button_micro" type="submit" onclick="disable_button_just_clicked(this);" value="{!SEARCH}" /> <span class="horiz_field_sep associated_link"><a href="{$PAGE_LINK*,_SEARCH:search:misc:ocf_posts:search_under={$_GET,id}}" title="{!MORE}: {!search:SEARCH_OPTIONS}">{!MORE}</a></span>
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

			<div>
				<label class="accessibility_hidden" for="member_bar_search">{!SEARCH_POSTS_WITHIN_TOPIC}</label><input maxlength="255" type="text" name="content" id="member_bar_search" onfocus="if (this.value=='{!SEARCH_POSTS_WITHIN_TOPIC;}') { this.value=''; this.className=''; }" onblur="if (this.value=='') { this.value='{!SEARCH_POSTS_WITHIN_TOPIC;}'; this.className='field_input_non_filled'; };" class="field_input_non_filled" value="{!SEARCH_POSTS_WITHIN_TOPIC}" /> <input class="button_micro" type="submit" onclick="disable_button_just_clicked(this);" value="{!SEARCH}" /> <span class="horiz_field_sep associated_link"><a href="{$PAGE_LINK*,_SEARCH:search:misc:ocf_within_topic:search_under={$_GET,id}}" title="{!MORE}: {!search:SEARCH_OPTIONS}">{!MORE}</a></span>
			</div>
		</form>
	</div>
{+END}

{$,General search}
{+START,IF,{$NEQ,{$PAGE},forumview,topicview}}
	<div class="ocf_search_box">
		<form title="{!SEARCH}" action="{$URL_FOR_GET_FORM*,{$PAGE_LINK,_SEARCH:search:results}}" method="get">
			{$HIDDENS_FOR_GET_FORM,{$PAGE_LINK,_SEARCH:search:results}}

			<div>
				<label class="accessibility_hidden" for="member_bar_search">{!SEARCH}</label><input maxlength="255" type="text" name="content" id="member_bar_search" onfocus="if (this.value=='{!SEARCH;}') { this.value=''; this.className=''; }" onblur="if (this.value=='') { this.value='{!SEARCH;}'; this.className='field_input_non_filled'; };" class="field_input_non_filled" value="{!SEARCH}" /> <input class="button_micro" type="submit" onclick="disable_button_just_clicked(this);" value="{!SEARCH}" /> <span class="horiz_field_sep associated_link"><a href="{$PAGE_LINK*,_SEARCH:search:misc}" title="{!MORE}: {!search:SEARCH_OPTIONS}">{!MORE}</a></span>
			</div>
		</form>
	</div>
{+END}
