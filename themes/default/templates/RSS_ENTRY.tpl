	<item>
		<title>{TITLE}</title>
		{+START,IF_NON_EMPTY,{SUMMARY}}
			{+START,IF,{$NOT,{$BROWSER_MATCHES,itunes}}}
			<description>{SUMMARY}</description>
			{+END}
			{+START,IF,{$BROWSER_MATCHES,itunes}}
			<itunes:summary>{SUMMARY}</itunes:summary>
			{+END}
		{+END}
		{+START,IF_NON_EMPTY,{DATE}}
			<pubDate>{DATE*}</pubDate>
		{+END}
		<link>{VIEW_URL*}</link>
		{+START,IF_NON_EMPTY,{AUTHOR}}
			{+START,IF,{$NOT,{$BROWSER_MATCHES,itunes}}}
			<author>{$STAFF_ADDRESS} ({AUTHOR*})</author>
			{+END}
			{+START,IF,{$BROWSER_MATCHES,itunes}}
			<itunes:author>{$STAFF_ADDRESS} ({AUTHOR*})</author>
			{+END}
		{+END}
		{+START,IF_NON_EMPTY,{CATEGORY}}
			<category>{CATEGORY*}</category>
		{+END}
		<guid>{VIEW_URL*}</guid>
		{IF_COMMENTS}
		{+START,IF_PASSED,ENCLOSURE_URL}{+START,IF_PASSED,ENCLOSURE_LENGTH}{+START,IF_PASSED,ENCLOSURE_TYPE}
			<enclosure url="{ENCLOSURE_URL*}" length="{ENCLOSURE_LENGTH*}" type="{ENCLOSURE_TYPE*}" />
		{+END}{+END}{+END}
	</item>

