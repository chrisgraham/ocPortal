<div class="float_surrounder news_piece_summary">
	{+START,IF,{$AND,{$NOT,{BLOG}},{$IS_NON_EMPTY,{AUTHOR_URL}}}}
		<div class="newscat_img_author">
			{+START,IF,{$NOT,{$MOBILE}}}{+START,IF_NON_EMPTY,{CATEGORY}}
				<img src="{IMG*}" title="{CATEGORY*}" alt="{CATEGORY*}" />
			{+END}{+END}

			<div class="news_by">
				{!BY_SIMPLE,<a href="{AUTHOR_URL*}" title="{!AUTHOR}: {AUTHOR*}">{AUTHOR*}</a>}
			</div>
		</div>
	{+END}

	{+START,IF,{$NOT,{$IS_NON_EMPTY,{AUTHOR_URL}}}}
		<div class="newscat_img_member">
			{+START,IF_NON_EMPTY,{$USERNAME*,{SUBMITTER}}}
				<div class="news_by">
					<a class="fancy_user_link" rel="author" href="{$MEMBER_PROFILE_URL*,{SUBMITTER}}">{$USERNAME*,{SUBMITTER}}</a>
				</div>
			{+END}

			{+START,IF,{$NOT,{$MOBILE}}}{+START,IF_NON_EMPTY,{$AVATAR,{SUBMITTER}}}
				<img src="{$AVATAR*,{SUBMITTER}}" title="{!AVATAR}" alt="{!AVATAR}" />
			{+END}{+END}

			{+START,IF,{$NOT,{$MOBILE}}}{+START,IF,{$OCF}}{+START,IF_NON_EMPTY,{$OCF_RANK_IMAGE,{SUBMITTER}}}
				<p>{$OCF_RANK_IMAGE,{SUBMITTER}}</p>
			{+END}{+END}{+END}
		</div>
	{+END}

	<h3><a title="{$STRIP_TAGS,{$TRUNCATE_LEFT,{NEWS_TITLE},70,1,1}}: #{ID*}" href="{FULL_URL*}">{$TRUNCATE_LEFT,{NEWS_TITLE},70,1,1}</a></h3>

	<div class="meta_details" role="contentinfo">
		<ul class="meta_details_list">
			<li>{!POSTED_TIME,{DATE*}}</li>
			{+START,IF,{BLOG}}<li>{!BY_SIMPLE,<a rel="author" href="{$MEMBER_PROFILE_URL*,{SUBMITTER}}">{$USERNAME*,{SUBMITTER}}</a>}</li>{+END}
		</ul>
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
	<a title="{!READ_MORE}: #{ID*}" href="{FULL_URL*}">{!READ_MORE}</a>{+START,IF,{$NOT,{$MATCH_KEY_MATCH,forum:topicview,forum:forumview}}} {+START,IF_PASSED_AND_TRUE,COMMENT_COUNT} <span class="comment_count">{$COMMENT_COUNT,news,{ID}}</span>{+END}{+END}
</p>
