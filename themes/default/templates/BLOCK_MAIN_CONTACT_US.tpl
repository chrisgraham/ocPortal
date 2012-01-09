<div class="float_surrounder"{$?,{$VALUE_OPTION,html5}, itemscope="itemscope" itemtype="http://schema.org/ContactPage"}>
	{+START,IF_NON_EMPTY,{MESSAGE}}
		<p>
			{MESSAGE}
		</p>
	{+END}

	{COMMENT_DETAILS}

	{+START,IF_PASSED,NOTIFICATIONS_ENABLED}
		<div class="posting_form_wrap_buttons">
			<form title="{$?,{NOTIFICATIONS_ENABLED},{!notifications:DISABLE_NOTIFICATIONS},{!notifications:ENABLE_NOTIFICATIONS}}" class="inline" action="{NOTIFICATION_CHANGE_URL*}" method="post"><input type="hidden" name="{$?,{NOTIFICATIONS_ENABLED},disable_notifications,enable_notifications}" value="1" /><input name="submit" type="image" class="button_pageitem page_icon" src="{$?,{NOTIFICATIONS_ENABLED},{$IMG*,pageitem/disable_notifications},{$IMG*,pageitem/enable_notifications}}" title="{$?,{NOTIFICATIONS_ENABLED},{!notifications:DISABLE_NOTIFICATIONS},{!notifications:ENABLE_NOTIFICATIONS_LONG_EXP}}" alt="{$?,{NOTIFICATIONS_ENABLED},{!notifications:DISABLE_NOTIFICATIONS},{!notifications:ENABLE_NOTIFICATIONS}}" /></form>
		</div>
	{+END}
</div>
