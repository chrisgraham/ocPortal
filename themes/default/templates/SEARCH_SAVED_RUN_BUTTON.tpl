<form title="{!RUN_SEARCH}: {NAME*}" action="{$URL_FOR_GET_FORM*,{URL}}" method="get">
	{$HIDDENS_FOR_GET_FORM,{URL}}

	<div>
		{HIDDEN}
		<input onclick="disable_button_just_clicked(this);" class="button_pageitem" type="submit" title="{!RUN_SEARCH}: {NAME*}" value="{!RUN_SEARCH}" />
	</div>
</form>
