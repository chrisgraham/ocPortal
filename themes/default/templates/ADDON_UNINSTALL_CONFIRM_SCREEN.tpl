{TITLE}

{WARNINGS}

{!WARNING_UNINSTALL}
{+START,IF_NON_EMPTY,{FILES}}
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
<p>
	<a href="#" onclick="history.back(); return false;"><img title="{!_NEXT_ITEM_BACK}" alt="{!_NEXT_ITEM_BACK}" src="{$IMG*,bigicons/back}" /></a>
</p>
{+END}

