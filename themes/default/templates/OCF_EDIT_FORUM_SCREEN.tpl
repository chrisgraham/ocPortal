{TITLE}

<p>
	{!CHOOSE_FORUM_EDIT}
</p>

<form title="{!PRIMARY_PAGE_FORM}" method="post" action="{REORDER_URL*}">
	{ROOT_FORUM}

	{+START,IF_NON_EMPTY,{REORDER_URL}}
		<br />
		<div class="proceed_button">
			<input accesskey="u" onclick="disable_button_just_clicked(this);" class="button_page" type="submit" value="{!REORDER_FORUMS}" />
		</div>
	{+END}
</form>

<p>
	{!CHOOSE_FORUM_EDIT_2}
</p>

