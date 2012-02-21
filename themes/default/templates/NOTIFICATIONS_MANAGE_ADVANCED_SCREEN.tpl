{TITLE}

<form method="post" action="{ACTION_URL*}" onsubmit="return notifications_children();">
	<div>
		<h2>{!NOTIFICATIONS_USING}</h2>

		{+START,INCLUDE,NOTIFICATION_TYPES}{+END}

		<h2>{!CATEGORIES_TO_ENABLE_NOTIFICATIONS}</h2>

		<p>
			<input class="button_pageitem" type="button" id="check_uncheck" value="{!NOTIFICATIONS_CHECK_ALL}" onclick="advanced_notifications_check_all(this)" />
		</p>

		{TREE}
	</div>
</form>
