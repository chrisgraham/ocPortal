<form title="{!PRIMARY_PAGE_FORM}" action="{$URL_FOR_GET_FORM*,{EDIT_URL}}" method="get">
	{$HIDDENS_FOR_GET_FORM,{EDIT_URL}}

	<div>
		{TREE`}

		{HIDDEN}
	</div>

	<div class="proceed_button">
		<input onclick="disable_button_just_clicked(this);" value="{!EDIT_TEMPLATES}" class="button_page" type="submit" />
	</div>
</form>

