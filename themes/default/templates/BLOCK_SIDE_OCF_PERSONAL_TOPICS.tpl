{+START,BOX,{!UNSEEN_PERSONAL_POSTS},,{$?,{$GET,in_panel},panel,classic},,,{$?,{$IS_NON_EMPTY,{SEND_URL}},<a href="{SEND_URL*}">{!NEW_PERSONAL_TOPIC_SHORT}</a>}|{$?,{$IS_NON_EMPTY,{VIEW_URL}},<a href="{VIEW_URL*}">{!VIEW_ARCHIVE}</a>}}
	{CONTENT}
	{+START,IF_EMPTY,{CONTENT}}
		<p class="nothing_here">{!NONE}</p>
	{+END}
{+END}

