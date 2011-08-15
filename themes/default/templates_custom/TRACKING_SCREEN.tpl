{TITLE}

<div>
	<form method="post" action="{ACTION*}" name="tracking" onsubmit="return track_children();">
		{+START,IF,{$CONFIG_OPTION,is_on_sms}}
			<h2>{!TRACK_USING}</h2>

			<p style="float: left; width: 50%">
				<label for="sms">{!TRACK_SMS}</label>
				<input type="checkbox" name="sms" id="sms" value="1" {SMS_ENABLED}/>
			</p>

			<p>
				<label for="email">{!TRACK_EMAIL}</label>
				<input type="checkbox" name="email" id="email" value="1" {EMAIL_ENABLED}/>
			</p>
		{+END}

		{+START,IF,{$NOT,{$CONFIG_OPTION,is_on_sms}}}
			<input id="email" type="hidden" name="email" value="1" />
		{+END}

		<h2>{!CATEGORIES_TO_TRACK}</h2>

		<input type="hidden" name="t_cat_id" id="t_cat_id" value="{ID*}" />
		<input type="hidden" name="t_cat_type" id="t_cat_type" value="{TYPE*}" />
		<input type="hidden" name="track_child" id="track_child" value="{T_CHILD*}" />
		<p>
			<input type="button" name="check_uncheck" id="check_uncheck" value="{!CHECK_ALL}" onclick="check_all('tracking','nodes[]',this)" />
			{TREE}
		</p>

		<p class="proceed_button">
			<input class="button_page" type="submit" value="{!SAVE}" name="btn_submit" />
		</p>
	</form>
</div>
