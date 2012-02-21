<div class="float_surrounder"{$?,{$VALUE_OPTION,html5}, itemscope="itemscope" itemtype="http://schema.org/ContactPage"}>
	{+START,IF_NON_EMPTY,{MESSAGE}}
		<p>
			{MESSAGE}
		</p>
	{+END}

	{COMMENT_DETAILS}

	{+START,IF_PASSED,NOTIFICATIONS_ENABLED}
		<div class="posting_form_wrap_buttons">
			{+START,INCLUDE,NOTIFICATION_BUTTONS}
				NOTIFICATIONS_TYPE=messaging
				NOTIFICATIONS_ID={TYPE}
			{+END}
		</div>
	{+END}
</div>
