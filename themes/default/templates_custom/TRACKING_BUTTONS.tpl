{+START,IF_PASSED,TRACK_TYPE}
	{$SET,TRACK_TYPE,{TRACK_TYPE}}
{+END}

{+START,IF_NON_PASSED,TRACK_TYPE}
	{$SET,TRACK_TYPE,{$PAGE}}
{+END}

{+START,IF,{$NOT,{$IS_TRACKED,{TRACK_ID},{$GET,TRACK_TYPE}}}}
	<a href="{$PAGE_LINK*,_SEARCH:tracking:misc:{TRACK_ID}:track_type={$GET,TRACK_TYPE}:redirect={$SELF_URL*&,1}}"><img class="button_page page_icon" src="{$IMG*,page/track_resource}" title="" alt="{!TRACK_RESOURCE}" /></a>
{+END}

{+START,IF,{$IS_TRACKED,{TRACK_ID},{$GET,TRACK_TYPE}}}
	<a href="{$PAGE_LINK*,_SEARCH:tracking:untrack:{TRACK_ID}:track_type={$GET,TRACK_TYPE}:redirect={$SELF_URL*&,1}}"><img class="button_page page_icon" src="{$IMG*,page/untrack_resource}" title="" alt="{!UNTRACK_RESOURCE}" /></a>
{+END}
