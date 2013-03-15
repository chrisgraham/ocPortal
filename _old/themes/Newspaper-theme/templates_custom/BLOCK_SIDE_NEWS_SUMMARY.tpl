{+START,IF,{$GET,done_one_side_news}}
	<div class="tiny_linebreak">&nbsp;</div>
{+END}
{$SET,done_one_side_news,1}

{+START,BOX,,,light}
	<p class="tiny_para"><a title="{$STRIP_TAGS,{NEWS_TITLE}}" href="{FULL_URL*}">{$TRUNCATE_LEFT,{NEWS_TITLE},30,0,1}</a></p>

	<p class="tiny_para associated_details">
		{!BY_SIMPLE,{AUTHOR*}}
	</p>

	<p class="tiny_para associated_details">
		{!LAST_POST}: {DATE*}
	</p>

	<p class="tiny_para bottom-link">
		<a title="{$STRIP_TAGS,{NEWS_TITLE}}" href="{FULL_URL*}">Read story</a>
	</p>
{+END}
