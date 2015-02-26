<div class="topic_list_topic">
	<div class="topic_list_title">
		<a title="{!POST_PLU,{NUM_POSTS*}}, {TITLE*~}" href="{TOPIC_URL*}">{$TRUNCATE_LEFT,{TITLE},30}</a>
	</div>

	<ul class="topic_list_meta horizontal_meta_details">
		{+START,IF_NON_EMPTY,{USERNAME}}
			<li>{!BY_SIMPLE,<a class="topic_list_by" href="{POSTER_URL*}">{USERNAME*}</a>}</li>
		{+END}
		<li>{DATE*}</li>
	</ul>
</div>

