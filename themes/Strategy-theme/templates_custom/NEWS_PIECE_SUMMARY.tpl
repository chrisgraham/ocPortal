<div class="{$CYCLE,stripes,stripes_a,stripes_b}">
	<div class="float_surrounder news_piece_summary">
		<h3><a title="#{ID*}" href="{FULL_URL*}">{$TRUNCATE_LEFT,{NEWS_TITLE},70,1,1}</a></h3>
	
		<div class="page_subtitle_tagline">
			{!POSTED_TIME,{DATE*}}
		</div>
	
		{+START,IF_NON_EMPTY,{NEWS}}
			{+START,IF,{$AND,{$NOT,{$IN_STR,{NEWS},<p>}},{$NOT,{$IN_STR,{NEWS},<h}}}}<p class="news_summary_p">{+END}
			{+START,IF,{TRUNCATE}}{$TRUNCATE_LEFT,{NEWS},400,0,1,1,0.4}{+END}
			{+START,IF,{$NOT,{TRUNCATE}}}{NEWS}{+END}
			{+START,IF,{$AND,{$NOT,{$IN_STR,{NEWS},<p>}},{$NOT,{$IN_STR,{NEWS},<h}}}}</p>{+END}
		{+END}
	</div>
	
	<div class="news_goto">
		{$,<img class="button_pageitem" src="{$IMG*,pageitem/goto}" title="{!VIEW} / {!COMMENTS}" alt="{!VIEW} / {!COMMENTS}" />}
		<a title="#{ID*}" href="{FULL_URL*}">{!READ_MORE}</a>{+START,IF,{$NOT,{$MATCH_KEY_MATCH,forum:topicview,forum:forumview}}} {+START,IF_PASSED,COMMENT_COUNT} ({$COMMENT_COUNT,news,{ID}}){+END}{+END}
	</div>
</div>

{$SET,box_stripes,{$?,{$EQ,{$CYCLE,stripes},stripes_a},stripes_b,stripes_a}}