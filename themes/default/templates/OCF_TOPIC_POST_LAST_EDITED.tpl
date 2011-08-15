<br /><br />

<span class="edited">
	<img alt="" title="" src="{$IMG*,edited}" />
	{+START,IF,{$VALUE_OPTION,html5}}
		{!LAST_EDIT_BY,<time datetime="{$FROM_TIMESTAMP*,Y-m-d\TH:i:s\Z,{LAST_EDIT_DATE_RAW}}">{LAST_EDIT_DATE*}</time>,<a href="{LAST_EDIT_PROFILE_URL*}">{LAST_EDIT_USERNAME*}</a>}
	{+END}
	{+START,IF,{$NOT,{$VALUE_OPTION,html5}}}
		{!LAST_EDIT_BY,{LAST_EDIT_DATE*},<a href="{LAST_EDIT_PROFILE_URL*}">{LAST_EDIT_USERNAME*}</a>}
	{+END}
</span>
