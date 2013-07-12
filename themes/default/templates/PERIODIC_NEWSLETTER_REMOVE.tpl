{TITLE}

<p>
	{!CONFIRM_REMOVE_PERIODIC}
</p>

<form method="post" action="{URL*}">
	{+START,IF_PASSED,HIDDEN}{HIDDEN}{+END}

	<div>
		<div class="proceed_button">
			<input class="button_page" onclick="this.disabled=true; this.form.submit();" accesskey="u" type="submit" value="{!PROCEED}" />
		</div>
	</div>
</form>

{+START,IF,{$JS_ON}}
<a href="#" onclick="history.back(); return false;"><img title="{!_NEXT_ITEM_BACK}" alt="{!_NEXT_ITEM_BACK}" src="{$IMG*,bigicons/back}" /></a>
{+END}

