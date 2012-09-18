{TPL}

<div class="buttons_group">
	<a onclick="do_attachment('{FIELD_NAME;}','{ID;}','{DESCRIPTION;}'); return false;" href="#"><img class="button_pageitem" alt="{!CHOOSE}" src="{$IMG*,pageitem/choose}" /></a>

	{+START,IF,{MAY_DELETE}}
		<form class="inline" method="post" action="{$SELF_URL*}">
			<input type="hidden" name="delete_{ID*}" value="1" />
			<input type="image" class="button_pageitem" alt="{!DELETE}" src="{$IMG*,pageitem/delete}" />
		</form>
	{+END}
</div>

<hr class="spaced_rule" />

