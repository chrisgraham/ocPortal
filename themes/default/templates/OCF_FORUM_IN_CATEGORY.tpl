<tr>
	{+START,IF,{$NOT,{$MOBILE}}}
		<td class="ocf_forum_new_post_indicator ocf_row1">
			<img title="" alt="{LANG_NEW_POST_OR_NOT*}" src="{$IMG*,ocf_general/{NEW_POST_OR_NOT*}}" />
		</td>
	{+END}
	<td class="ocf_forum_in_category_forum ocf_row2">
		<a class="field_name" href="{FORUM_URL*}">{+START,FRACTIONAL_EDITABLE,{FORUM_NAME},name,_SEARCH:admin_ocf_forums:type=__ed:id={ID}}{FORUM_NAME*}{+END}</a>
		{+START,IF_NON_EMPTY,{EDIT_URL}}
			<span class="associated_details">(<a rel="edit" href="{EDIT_URL*}" title="{!EDIT}: {FORUM_NAME*}">{!EDIT}</a>)</span>
		{+END}
		{+START,IF_NON_EMPTY,{FORUM_RULES_URL}}
			<span class="associated_details">(<a target="_blank" onclick="window.faux_open(maintain_theme_in_link('{FORUM_RULES_URL*;}'),'','width=600,height=500,status=yes,resizable=yes,scrollbars=yes'); return false;" href="{FORUM_RULES_URL*}" title="{!FORUM_RULES}: {FORUM_NAME*} {!LINK_NEW_WINDOW}">{!FORUM_RULES}</a>)</span>
		{+END}
		{+START,IF_NON_EMPTY,{INTRO_QUESTION_URL}}
			<span class="associated_details">(<a target="_blank" onclick="window.faux_open(maintain_theme_in_link('{INTRO_QUESTION_URL*;}'),'','width=600,height=500,status=yes,resizable=yes,scrollbars=yes'); return false;" href="{INTRO_QUESTION_URL*}" title="{!INTRO_QUESTION}: {FORUM_NAME*} {!LINK_NEW_WINDOW}">{!INTRO_QUESTION}</a>)</span>
		{+END}
		{+START,IF_NON_EMPTY,{DESCRIPTION}}
		<div class="ocf_forum_description">
			{DESCRIPTION}
		</div>
		{+END}
		{+START,IF_NON_EMPTY,{SUBFORUMS}}
			<div class="ocf_forum_subforums">
				<p>{!SUBFORUMS}: {SUBFORUMS}</p>
			</div>
		{+END}

		{+START,IF,{$MOBILE}}
			<p class="associated_details">
				{!COUNT_TOPICS}: {$PREG_REPLACE,([^<>/\s\w]),\1 ,{NUM_TOPICS*}}
				&middot;
				{!COUNT_POSTS}: {$PREG_REPLACE,([^<>/\s\w]),\1 ,{NUM_POSTS*}}
			</p>
		{+END}
	</td>
	{+START,IF,{$NOT,{$MOBILE}}}
		<td class="ocf_forum_num_topics ocf_row3">
			{$PREG_REPLACE,([^<>/\s\w]),\1 ,{NUM_TOPICS*}}
		</td>
		<td class="ocf_forum_num_posts ocf_row4">
			{$PREG_REPLACE,([^<>/\s\w]),\1 ,{NUM_POSTS*}}
		</td>
	{+END}
	<td class="ocf_forum_latest ocf_row5">
		{LATEST}
	</td>
</tr>


