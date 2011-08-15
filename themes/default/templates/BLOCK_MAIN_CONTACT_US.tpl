<div class="float_surrounder"{$?,{$VALUE_OPTION,html5}, itemscope="itemscope" itemtype="http://schema.org/ContactPage"}>
	{+START,IF_NON_EMPTY,{MESSAGE}}
		<p>
			{MESSAGE}
		</p>
	{+END}

	{COMMENT_DETAILS}

	{+START,IF_PASSED,TRACKING}
		<div class="posting_form_wrap_buttons">
			<form title="{$?,{TRACKING},{!UNTRACK_RESOURCE},{!TRACK_RESOURCE}}" class="inline" action="{TRACKING_URL*}" method="post"><input type="hidden" name="{$?,{TRACKING},disable_tracking,enable_tracking}" value="1" /><input name="submit" type="image" class="button_pageitem page_icon" src="{$?,{TRACKING},{$IMG*,pageitem/untrack_resource},{$IMG*,pageitem/track_resource}}" title="{$?,{TRACKING},{!UNTRACK_RESOURCE},{!TRACK_RESOURCE_LONG_EXP}}" alt="{$?,{TRACKING},{!UNTRACK_RESOURCE},{!TRACK_RESOURCE}}" /></form>
		</div>
	{+END}
</div>
