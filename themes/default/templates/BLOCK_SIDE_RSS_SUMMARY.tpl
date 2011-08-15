{+START,IF,{$NOT,{TICKER}}}
	{+START,BOX,,,light}
		<p class="tiny_para"><a title="{$REPLACE,",&quot;,{$STRIP_TAGS,{NEWS_TITLE}}} {!LINK_NEW_WINDOW}" rel="external" target="_blank" href="{FULL_URL*}">{$TRUNCATE_LEFT,{NEWS_TITLE},30,0,1}</a></p>

		<p class="tiny_para associated_details">
			{DATE*}
		</p>
	{+END}

	<div class="tiny_linebreak">&nbsp;</div>
{+END}

{+START,IF,{TICKER}}
	{+START,BOX,,,light}
		<a title="{$REPLACE,",&quot;,{$STRIP_TAGS,{NEWS_TITLE}}} {!LINK_NEW_WINDOW}" rel="external" target="_blank" href="{FULL_URL*}">{NEWS_TITLE}</a> <span class="associated_details">({$MAKE_RELATIVE_DATE*,{DATE_RAW}} ago)</span><br />
		{SUMMARY}
	{+END}
{+END}
