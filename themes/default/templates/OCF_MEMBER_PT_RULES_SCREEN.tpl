{TITLE}

<p>
	{!PT_RULES_PAGE_INTRO,{USERNAME*}}
</p>

{+START,BOX}
	{RULES}
{+END}

<form title="{!PRIMARY_PAGE_FORM}" action="{URL*}" method="post">
	<div class="proceed_button">
		 <input accesskey="u" onclick="disable_button_just_clicked(this);" class="button_page" type="submit" value="{!PROCEED}" />
	</div>
</form>

