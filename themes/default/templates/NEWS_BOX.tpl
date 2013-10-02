<div class="box box___news_box"><div class="box_inner">
	{+START,IF,{$HAS_DELETE_PERMISSION,mid,{SUBMITTER},{$MEMBER},cms_news}}
		{+START,INCLUDE,MASS_SELECT_MARKER}
			TYPE=news
			ID={ID}
		{+END}

		{$INC,has_mass_select}
	{+END}

	<h3>
		{+START,IF,{GIVE_CONTEXT}}
			{!CONTENT_IS_OF_TYPE,{!NEWS},{NEWS_TITLE}}
		{+END}
		{+START,IF,{$NOT,{GIVE_CONTEXT}}}
			{+START,IF_PASSED,ID}
				{+START,FRACTIONAL_EDITABLE,{NEWS_TITLE_PLAIN},title,_SEARCH:cms_news:type=__ed:id={ID},1}{$TRUNCATE_LEFT,{NEWS_TITLE},70,1,1}{+END}
			{+END}
			{+START,IF_NON_PASSED,ID}
				{$TRUNCATE_LEFT,{NEWS_TITLE},70,1,1}
			{+END}
		{+END}
	</h3>

	{+START,IF,{$AND,{$NOT,{BLOG}},{$IS_NON_EMPTY,{AUTHOR_URL}}}}
		<div class="newscat_img newscat_img_author">
			{+START,IF,{$NOT,{$MOBILE}}}{+START,IF_NON_EMPTY,{CATEGORY}}
				<img src="{IMG*}" alt="" />
			{+END}{+END}
		</div>
	{+END}

	{+START,IF,{$NOT,{$IS_NON_EMPTY,{AUTHOR_URL}}}}
		<div class="newscat_img newscat_img_member">
			{+START,IF,{$NOT,{$MOBILE}}}{+START,IF_NON_EMPTY,{$AVATAR,{SUBMITTER}}}
				<img src="{$AVATAR*,{SUBMITTER}}" title="{!AVATAR}" alt="{!AVATAR}" />
			{+END}{+END}

			{+START,IF,{$NOT,{$MOBILE}}}{+START,IF,{$OCF}}{+START,IF_NON_EMPTY,{$OCF_RANK_IMAGE,{SUBMITTER}}}
				<p>{$OCF_RANK_IMAGE,{SUBMITTER}}</p>
			{+END}{+END}{+END}
		</div>
	{+END}

	<div class="meta_details" role="contentinfo">
		<ul class="meta_details_list">
			<li>{!POSTED_TIME_SIMPLE,{DATE*}}</li>
			{+START,SET,author_details}
				{+START,IF,{$IS_NON_EMPTY,{AUTHOR_URL}}}
					{!BY_SIMPLE,<a href="{AUTHOR_URL*}" title="{!AUTHOR}: {AUTHOR*}">{AUTHOR*}</a>}
					{+START,INCLUDE,MEMBER_TOOLTIP}{+END}
				{+END}

				{+START,IF,{$IS_EMPTY,{AUTHOR_URL}}}
					{+START,IF_NON_EMPTY,{$USERNAME*,{SUBMITTER},1}}
						{!BY_SIMPLE,<a rel="author" href="{$MEMBER_PROFILE_URL*,{SUBMITTER}}">{$USERNAME*,{SUBMITTER},1}</a>}
						{+START,INCLUDE,MEMBER_TOOLTIP}{+END}
					{+END}
				{+END}
			{+END}
			{+START,IF_NON_EMPTY,{$GET,author_details}}
				<li>
					{$GET,author_details}
				</li>
			{+END}
		</ul>
	</div>

	{+START,IF_NON_EMPTY,{NEWS}}
		{+START,IF,{$AND,{$NOT,{$IN_STR,{NEWS},<p><div>}},{$NOT,{$IN_STR,{NEWS},<h}}}}<p class="news_summary_p">{+END}
		{+START,IF,{TRUNCATE}}{$TRUNCATE_LEFT,{NEWS},400,0,1,0,0.4}{+END}
		{+START,IF,{$NOT,{TRUNCATE}}}{NEWS}{+END}
		{+START,IF,{$AND,{$NOT,{$IN_STR,{NEWS},<p><div>}},{$NOT,{$IN_STR,{NEWS},<h}}}}</p>{+END}
	{+END}

	{+START,IF_PASSED,TAGS}
		{+START,IF,{$CONFIG_OPTION,show_content_tagging_inline}}{TAGS}{+END}
	{+END}

	<ul class="horizontal_links associated_links_block_group">
		<li><a title="{!READ_MORE}: #{ID*}" href="{FULL_URL*}">{!READ_MORE}</a>{+START,IF,{$NOT,{$MATCH_KEY_MATCH,forum:topicview,forum:forumview}}} {+START,IF_PASSED_AND_TRUE,COMMENT_COUNT} <span class="comment_count">{$COMMENT_COUNT,news,{ID}}</span>{+END}{+END}</li>
	</ul>
</div></div>

