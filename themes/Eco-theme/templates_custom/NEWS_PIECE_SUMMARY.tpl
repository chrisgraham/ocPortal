<div class="float_surrounder news_piece_summary">
	{+START,IF,{$AND,{$NOT,{BLOG}},{$IS_NON_EMPTY,{AUTHOR_URL}}}}
		<div class="newscat_img_author">
			{+START,IF_NON_EMPTY,{CATEGORY}}
				<img src="{IMG*}" title="{CATEGORY*}" alt="{CATEGORY*}" />
			{+END}

			<div class="news_by">
				{!BY_SIMPLE,<a href="{AUTHOR_URL*}" title="{!AUTHOR}: {AUTHOR*}">{AUTHOR*}</a>}
			</div>
		</div>
	{+END}

	{+START,IF,{$NOT,{$IS_NON_EMPTY,{AUTHOR_URL}}}}
		<div class="newscat_img_member">
			{+START,IF_NON_EMPTY,{$USERNAME*,{SUBMITTER}}}
				<div class="news_by">
					<a class="poster_member" rel="author" href="{$MEMBER_PROFILE_LINK*,{SUBMITTER}}">{$USERNAME*,{SUBMITTER}}</a>
				</div>
			{+END}

			{+START,IF_NON_EMPTY,{$AVATAR*,{SUBMITTER}}}
				<img src="{$AVATAR*,{SUBMITTER}}" title="{!AVATAR}" alt="{!AVATAR}" />
			{+END}

			{+START,IF,{$OCF}}
				<br /><br />
				{$OCF_RANK_IMAGE,{SUBMITTER}}
			{+END}
		</div>
	{+END}

	<h4><a title="{$STRIP_TAGS,{$TRUNCATE_LEFT,{NEWS_TITLE},70,1,1}}: #{ID*}" href="{FULL_URL*}">{$TRUNCATE_LEFT,{NEWS_TITLE},70,1,1}</a></h4>

	<div class="page_subtitle_tagline">
		{!POSTED_TIME,{DATE*}}{+START,IF,{BLOG}}, {!BY_SIMPLE,<a rel="author" href="{$MEMBER_PROFILE_LINK*,{SUBMITTER}}">{$USERNAME*,{SUBMITTER}}</a>}{+END}
	</div>

	{+START,IF_NON_EMPTY,{NEWS}}
		{+START,IF,{$AND,{$NOT,{$IN_STR,{NEWS},<p>}},{$NOT,{$IN_STR,{NEWS},<h}}}}<p class="news_summary_p">{+END}
		{+START,IF,{TRUNCATE}}{$TRUNCATE_LEFT,{NEWS},400,0,1,0,0.4}{+END}
		{+START,IF,{$NOT,{TRUNCATE}}}{NEWS}{+END}
		{+START,IF,{$AND,{$NOT,{$IN_STR,{NEWS},<p>}},{$NOT,{$IN_STR,{NEWS},<h}}}}</p>{+END}
	{+END}
</div>

{+START,IF_PASSED,TAGS}
	{+START,IF,{$CONFIG_OPTION,show_content_tagging_inline}}{TAGS}{+END}
{+END}

<p class="news_goto">
	{$,<img class="button_pageitem" src="{$IMG*,pageitem/goto}" title="{!VIEW} / {!COMMENTS}" alt="{!VIEW} / {!COMMENTS}" />}
	<a title="{!READ_MORE}: #{ID*}" href="{FULL_URL*}">{!READ_MORE}</a>{+START,IF,{$NOT,{$MATCH_KEY_MATCH,forum:topicview,forum:forumview}}} {+START,IF_PASSED,COMMENT_COUNT} ({$COMMENT_COUNT,news,{ID}}){+END}{+END}
</p>
