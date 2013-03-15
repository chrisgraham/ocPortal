{TITLE}

{WARNINGS}

{+START,IF_NON_EMPTY,{FILES}}
	<p class="lonely_label">{!WARNING_UNINSTALL}</p>
	<ul>
		{FILES}
	</ul>
{+END}

<div class="right">
	<form title="{!PRIMARY_PAGE_FORM}" action="{URL*}" method="post">
		<p>
			<input class="button_page" type="image" src="{$IMG*,page/delete}" title="{!PROCEED}" alt="{!PROCEED}" />
			<input type="hidden" name="name" value="{NAME*}" />
		</p>
	</form>
</div>

{+START,IF,{$JS_ON}}
	<p class="back_button">
		<a href="#" onclick="history.back(); return false;"><img title="{!_NEXT_ITEM_BACK}" alt="{!_NEXT_ITEM_BACK}" src="{$IMG*,bigicons/back}" /></a>
	</p>
{+END}

