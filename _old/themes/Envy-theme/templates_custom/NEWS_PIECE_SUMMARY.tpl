<div class="news1">
	<div class="float_surrounder news_piece_summary">
		{+START,IF,{$AND,{$NOT,{BLOG}},{$IS_NON_EMPTY,{AUTHOR_URL}}}}
			<div class="newscat_img_author">
				<div class="news_by">
					{!BY_SIMPLE,<a href="{AUTHOR_URL*}" title="{!_AUTHOR,{AUTHOR*}}">{AUTHOR*}</a>}
				</div>
			</div>
		{+END}
	
		{+START,IF,{$OR,{BLOG},{$NOT,{$IS_NON_EMPTY,{AUTHOR_URL}}}}}
			<div class="newscat_img_member">
				{+START,IF_NON_EMPTY,{$USERNAME*,{SUBMITTER}}}
					<div class="news_by">
						<a class="poster_member" rel="author" href="{$MEMBER_PROFILE_LINK*,{SUBMITTER}}" title="{$USERNAME*,{SUBMITTER}}">{$USERNAME*,{SUBMITTER}}</a>
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
		{$,<img class="button_pageitem" src="" title="{!VIEW} / {!COMMENTS}" alt="{!VIEW} / {!COMMENTS}" />}
		<a title="#{ID*}" href="{FULL_URL*}">{!READ_MORE}</a>{+START,IF,{$NOT,{$MATCH_KEY_MATCH,forum:topicview,forum:forumview}}} {+START,IF_PASSED,COMMENT_COUNT} ({$COMMENT_COUNT,news,{ID}}){+END}{+END}
	</div>
</div>
