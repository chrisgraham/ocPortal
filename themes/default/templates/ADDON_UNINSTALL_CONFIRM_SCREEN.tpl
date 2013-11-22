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
			<input class="menu___generic_admin__delete button_page" type="submit" value="{!PROCEED}" />
			<input type="hidden" name="name" value="{NAME*}" />
		</p>
	</form>
</div>

{+START,IF,{$JS_ON}}
	<p class="back_button">
		<a href="#" onclick="history.back(); return false;"><img title="{!_NEXT_ITEM_BACK}" alt="{!_NEXT_ITEM_BACK}" src="{$IMG*,icons/48x48/menu/_generic_admin/back}" /></a>
	</p>
{+END}

