{+START,BOX,,,light}
	<p class="tiny_para"><a title="{$STRIP_TAGS,{NEWS_TITLE}} {!LINK_NEW_WINDOW}" rel="external" target="_blank" href="{FULL_URL*}">{$TRUNCATE_LEFT,{NEWS_TITLE},30,0,1}</a></p>

	<p class="tiny_para associated_details">
		{!BY_SIMPLE,{FIRSTUSERNAME*}} &middot; {!_COMMENTS,{$SUBTRACT,{REPLIES},1}}
	</p>

	<p class="tiny_para associated_details">
		{!LAST_POST}: {DATE*}
	</p>
{+END}

<div class="tiny_linebreak">&nbsp;</div>
