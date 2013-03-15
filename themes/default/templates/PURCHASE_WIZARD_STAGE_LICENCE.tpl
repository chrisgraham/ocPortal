<form title="{!PRIMARY_PAGE_FORM}" {+START,IF_NON_PASSED,GET}method="post" action="{URL*}"{+END}{+START,IF_PASSED,GET}method="get" action="{$URL_FOR_GET_FORM*,{URL}}"{+END}>
	{+START,IF_PASSED,GET}{$HIDDENS_FOR_GET_FORM,{URL}}{+END}

	<p><label for="licence">{!LICENCE}</label>:<br />
	<textarea readonly="readonly" class="purchase_licence" id="licence" name="licence" cols="50" rows="11">{LICENCE*}</textarea></p>

	<br />

	<div class="purchase_button">
		<input onclick="disable_button_just_clicked(this);" class="button_page" type="submit" value="{!I_AGREE}" />
	</div>
</form>
