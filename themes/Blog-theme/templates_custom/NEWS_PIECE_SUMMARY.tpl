<div class="float_surrounder news_piece_summary">
	<h3><a title="#{ID*}" href="{FULL_URL*}">{$TRUNCATE_LEFT,{NEWS_TITLE},70,1,1}</a></h3>

	{+START,IF_NON_EMPTY,{NEWS}}
		{+START,IF,{$AND,{$NOT,{$IN_STR,{NEWS},<p>}},{$NOT,{$IN_STR,{NEWS},<h}}}}<p class="news_summary_p">{+END}
		{+START,IF,{TRUNCATE}}{$TRUNCATE_LEFT,{NEWS},400,0,1,1,0.4}{+END}
		{+START,IF,{$NOT,{TRUNCATE}}}{NEWS}{+END}
		{+START,IF,{$AND,{$NOT,{$IN_STR,{NEWS},<p>}},{$NOT,{$IN_STR,{NEWS},<h}}}}</p>{+END}
	{+END}

	{+START,IF,{$NOT,{$GET,in_panel}}}
		<div class="comment">
			<a title="#{ID*}" href="{FULL_URL*}">COMMENTS</a>
		</div>
	{+END}

	<div class="date-post">
		{DATE*}
	</div>
</div>
