{+START,IF_NON_EMPTY,{NOTIFICATION_CATEGORIES}}
	<ul class="notifications_advanced_chooser_cat cat_chooser">
		{+START,LOOP,NOTIFICATION_CATEGORIES}
			<li>
				<label>
					<input type="checkbox" id="notification_{NOTIFICATION_CODE*}_category_{NOTIFICATION_CATEGORY*}" name="notification_{NOTIFICATION_CODE*}_category_{NOTIFICATION_CATEGORY*}" value="1"{+START,IF,{CHECKED}} checked="checked"{+END} />
					{CATEGORY_TITLE*}
				</label>
				{CHILDREN}
			</li>
		{+END}
	</ul>
{+END}
