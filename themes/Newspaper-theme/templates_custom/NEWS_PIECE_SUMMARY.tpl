<div class="float_surrounder news_piece_summary">
	{+START,IF,{$NOT,{$GET,in_panel}}}
		{+START,IF,{$NOT,{$IS_NON_EMPTY,{AUTHOR_URL}}}}
			<div class="newscat_img_member">
				{+START,IF_NON_EMPTY,{$AVATAR*,{SUBMITTER}}}
					<img src="{$AVATAR*,{SUBMITTER}}" title="{!AVATAR}" alt="{!AVATAR}" />
				{+END}

				{+START,IF,{$OCF}}
					<br /><br />
					{$OCF_RANK_IMAGE,{SUBMITTER}}
				{+END}
			</div>
		{+END}
	{+END}

	<{$?,{$GET,in_panel},h2,h4}>{$TRUNCATE_LEFT,{NEWS_TITLE},70,1,1}</{$?,{$GET,in_panel},h2,h4}>

	{+START,IF,{$GET,in_panel}}
		<div class="quote">
			<div class="top"></div>
	{+END}

	{+START,IF_NON_EMPTY,{NEWS}}
		{+START,IF,{$AND,{$NOT,{$IN_STR,{NEWS},<p>}},{$NOT,{$IN_STR,{NEWS},<h}}}}<p class="news_summary_p">{+END}
		{+START,IF,{TRUNCATE}}{$TRUNCATE_LEFT,{NEWS},400,0,1,1,0.4}{+END}
		{+START,IF,{$NOT,{TRUNCATE}}}{NEWS}{+END}
		{+START,IF,{$AND,{$NOT,{$IN_STR,{NEWS},<p>}},{$NOT,{$IN_STR,{NEWS},<h}}}}</p>{+END}
	{+END}

	{+START,IF,{$GET,in_panel}}
		</div>
	{+END}

	<div class="page_subtitle_tagline">
		{!POSTED_TIME,{DATE*}}{+START,IF,{BLOG}}, {!BY_SIMPLE,<a rel="author" href="{$MEMBER_PROFILE_LINK*,{SUBMITTER}}">{$USERNAME*,{SUBMITTER}}</a>}{+END}
	</div>

	<div class="bottom-link">
		<a title="{$STRIP_TAGS,{$TRUNCATE_LEFT,{NEWS_TITLE},70,1,1}}: #{ID*}" href="{FULL_URL*}">full story</a>
	</div>
</div>

{+START,IF_PASSED,TAGS}
	{+START,IF,{$CONFIG_OPTION,show_content_tagging_inline}}{TAGS}{+END}
{+END}
