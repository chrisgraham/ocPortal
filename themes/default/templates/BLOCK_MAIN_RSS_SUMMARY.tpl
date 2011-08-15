<div class="float_surrounder rss_summary">
	<div class="newscat_img_author">
		{+START,IF_NON_EMPTY,{AUTHOR}}
			<div class="news_by">{AUTHOR}</div>
		{+END}
	</div>

	<h3>{$TRUNCATE_LEFT,{NEWS_TITLE},70,1,1}</h3>

	{+START,IF_NON_EMPTY,{DATE}}
		<div class="page_subtitle_tagline">
			{!POSTED_TIME,{DATE*}}{+START,IF,{$AND,{$NOT,{$IN_STR,{CATEGORY},<img}},{$IS_NON_EMPTY,{CATEGORY}}}}. {!IN,{CATEGORY}}.{+END}
		</div>
	{+END}
	{+START,IF,{$AND,{$IN_STR,{CATEGORY},<img},{$IS_NON_EMPTY,{CATEGORY}}}}
		<div class="newscat_img_author">
			{CATEGORY}
		</div>
	{+END}

	{+START,IF_NON_EMPTY,{NEWS}}
		{+START,IF,{$NOT,{$IN_STR,{NEWS},<p>}}}<p class="news_summary_p">{+END}{NEWS}{+START,IF,{$NOT,{$IN_STR,{NEWS},<p>}}}</p>{+END}
	{+END}
</div>

<div class="news_goto">
	{FULL_URL}
</div>

