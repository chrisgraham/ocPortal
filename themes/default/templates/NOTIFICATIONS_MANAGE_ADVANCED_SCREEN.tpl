{TITLE}

<p>
	{!DECIDE_PER_CATEGORY_NOTIFICATIONS}
</p>

<form method="post" action="{ACTION_URL*}">
	<div>
		{+START,IF_NON_EMPTY,{$TRIM,{TREE}}}
			{+START,BOX,{!ENABLE_NOTIFICATIONS_USING}:,,med}
				<div class="notifications_types">
					{+START,INCLUDE,NOTIFICATION_TYPES}{+END}
				</div>
			{+END}

			<br />

			{+START,BOX,{!CATEGORIES_TO_ENABLE_NOTIFICATIONS}:,,light}
				{TREE}

				<p>
					<input class="button_pageitem" type="button" id="check_uncheck" value="{!NOTIFICATIONS_CHECK_ALL}" onclick="advanced_notifications_check_all(this)" />
				</p>
			{+END}
		
			<p class="proceed_button">
				<input type="submit" class="button_page" value="{!SAVE}" />
			</p>
		{+END}

		{+START,IF_EMPTY,{$TRIM,{TREE}}}
			<p class="nothing_here">
				{!NO_CATEGORIES}
			</p>
		{+END}
	</div>
</form>
