<div class="float_surrounder">
	<div class="ocf_avatar_page_old_avatar">
		{+START,IF_NON_EMPTY,{PHOTO}}
			<img class="ocf_topic_post_avatar" alt="{!PHOTO}" src="{PHOTO*}" />
		{+END}
		{+START,IF_EMPTY,{PHOTO}}
			{!NONE_EM}
		{+END}
	</div>
	<div class="ocf_avatar_page_text">
		<p>{!PHOTO_CHANGE,{USERNAME*}}</p>

		{TEXT}
	</div>
</div>
