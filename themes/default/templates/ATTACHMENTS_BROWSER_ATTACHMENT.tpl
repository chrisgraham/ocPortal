{TPL}

<div class="buttons_group">
	<a onclick="do_attachment('{FIELD_NAME;*}','{ID;*}','{DESCRIPTION;*}'); if (typeof window.faux_close!='undefined') faux_close(); else window.close(); return false;" href="#"><img class="button_pageitem" alt="{!CHOOSE}" src="{$IMG*,pageitem/choose}" /></a>

	{+START,IF,{MAY_DELETE}}
		<form title="{!DELETE}" class="inline" method="post" action="{DELETE_URL*}">
			<input type="hidden" name="delete_{ID*}" value="1" />
			<input onclick="var form=this.form; fauxmodal_confirm('{!ARE_YOU_SURE_DELETE;*}',function(v) { if (v) form.submit(); } ); return false;" type="image" class="button_pageitem" alt="{!DELETE}" src="{$IMG*,pageitem/delete}" />
		</form>
	{+END}
</div>

<hr class="spaced_rule" />

