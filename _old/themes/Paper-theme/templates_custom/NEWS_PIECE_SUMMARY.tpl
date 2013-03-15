<div class="float_surrounder"><div class="news_piece_summary">
	<h3><a title="#{ID*}" href="{FULL_URL*}">{$TRUNCATE_LEFT,{NEWS_TITLE},70,1,1}</a></h3>

	{+START,IF,{$AND,{$NOT,{BLOG}},{$IS_NON_EMPTY,{AUTHOR_URL}}}}
		<div class="newscat_img_author">
			<div class="news_by">
				{!BY_SIMPLE,<a href="{AUTHOR_URL*}" title="{!_AUTHOR,{AUTHOR*}}">{AUTHOR*}</a>}
			</div>
		</div>
	{+END}

	<div class="page_subtitle_tagline">
		{!POSTED_TIME,{DATE*}}
	</div>

	{+START,IF_NON_EMPTY,{NEWS}}
		{+START,IF,{$AND,{$NOT,{$IN_STR,{NEWS},<p>}},{$NOT,{$IN_STR,{NEWS},<h}}}}<p class="news_summary_p">{+END}
		{$TRUNCATE_LEFT,{NEWS},400,0,1,1,0.4}
		{+START,IF,{$AND,{$NOT,{$IN_STR,{NEWS},<p>}},{$NOT,{$IN_STR,{NEWS},<h}}}}</p>{+END}
	{+END}
</div></div>
