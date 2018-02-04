	<entry>
		<title type="html">{TITLE}</title>
		<link rel="alternate" href="{VIEW_URL*}" />
		<id>{VIEW_URL*}</id>
		{+START,IF_NON_EMPTY,{DATE}}
			<published>{DATE*}</published>
		{+END}
		{+START,IF_NON_EMPTY,{EDIT_DATE}}
			{+START,IF_NON_EMPTY,{DATE}}
				<updated>{DATE*}</updated>
			{+END}
			{+START,IF_EMPTY,{DATE}}
				<updated>{$FROM_TIMESTAMP*,Y-m-d\TH:i:s+00:00}</updated>
			{+END}
		{+END}
		{+START,IF_EMPTY,{EDIT_DATE}}
			<updated>{DATE*}</updated>
		{+END}
		{+START,IF_NON_EMPTY,{CATEGORY}}
			<category term="{CATEGORY_RAW*}" label="{CATEGORY*}" />
		{+END}
		{+START,IF_NON_EMPTY,{AUTHOR}}
			<author>
				<name>{AUTHOR*}</name>
			</author>
		{+END}
		{+START,IF_NON_EMPTY,{SUMMARY}}
			<summary type="html">{SUMMARY}</summary>
		{+END}
		{+START,IF_NON_EMPTY,{NEWS}}
			<content type="html">{NEWS}</content>
		{+END}
		{+START,IF_PASSED,ENCLOSURE_URL}{+START,IF_PASSED,ENCLOSURE_LENGTH}{+START,IF_PASSED,ENCLOSURE_TYPE}
			<link length="{ENCLOSURE_LENGTH*}" href="{ENCLOSURE_URL*}" type="{ENCLOSURE_TYPE*}" rel="enclosure" />
		{+END}{+END}{+END}
	</entry>

