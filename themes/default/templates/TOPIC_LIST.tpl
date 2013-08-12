<div class="topic_list_topic notification_{$?,{HAS_READ},has_read,has_not_read}">
	{+START,IF_NON_EMPTY,{$AVATAR,{POSTER_ID}}}
		<img class="right spaced" src="{$AVATAR*,{POSTER_ID}}" title="{USERNAME*}" alt="{USERNAME*}" />
	{+END}

	<div class="topic_list_title">
		<a onclick="poll_for_notifications(true,true); return open_link_as_overlay(this);" title="{!POST_PLU,{NUM_POSTS*}}, {TITLE*~}" href="{TOPIC_URL*}">{$TRUNCATE_LEFT,{TITLE},30,0,1}</a>
	</div>

	<ul class="topic_list_meta horizontal_meta_details">
		{+START,IF_NON_EMPTY,{USERNAME}}
			<li>{!BY_SIMPLE,<a class="topic_list_by" href="{POSTER_URL*}">{$DISPLAYED_USERNAME*,{USERNAME}}</a>}</li>
		{+END}
		<li>{DATE*}</li>
		<li>({$?,{HAS_READ},{!notifications:HAS_READ},{!notifications:HAS_NOT_READ}})</li>
	</ul>
</div>

