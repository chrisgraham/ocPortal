<form id="mass_select_form__{$GET%,support_mass_select}" style="display: none" onsubmit="return confirm_delete(this,true);" class="mass_delete_form" action="{$PAGE_LINK*,_SEARCH:{$GET,support_mass_select}:mass_delete:redirect={$SELF_URL&}}" method="post">
	<div class="proceed_button">
		<input class="button_pageitem" type="submit" value="{!DELETE_SELECTION}" />
	</div>
</form>
