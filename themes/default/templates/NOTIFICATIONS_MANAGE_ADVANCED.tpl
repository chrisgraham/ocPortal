{TITLE}

<form method="post" action="{ACTION_URL*}" onsubmit="return notifications_children();">
	<div>
		{+START,IF,{$CONFIG_OPTION,is_on_sms}}
			<h2>{!NOTIFICATIONS_USING}</h2>

			{+START,INCLUDE,NOTIFICATION_TYPES}{+END}
		{+END}

		<h2>{!CATEGORIES_TO_ENABLE_NOTIFICATIONS}</h2>

		<p>
			<input class="button_pageitem" type="button" id="check_uncheck" value="{!CHECK_ALL}" onclick="advanced_notifications_check_all(this)" />
		</p>

		{TREE}
	</div>
</form>
