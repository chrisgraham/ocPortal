{+START,IF,{$AND,{$NEQ,{TYPE},dropdown},{$NEQ,{TYPE},top},{$NEQ,{TYPE},zone}}}
<div class="edit_menu_link">
	<a href="{EDIT_URL*}" title="{!EDIT_MENU}: {NAME*}">{!EDIT_MENU}</a> <a href="{EDIT_URL*}" title="{!EDIT_MENU}: {NAME*}"><img class="inline_image" alt="" src="{$IMG*,menus/menu}" /></a>
</div>
{+END}
{+START,IF,{$NOT,{$AND,{$NEQ,{TYPE},dropdown},{$NEQ,{TYPE},top},{$NEQ,{TYPE},zone}}}}
	<a class="edit_menu_link_inline" href="{EDIT_URL*}" title="{!EDIT_MENU}: {NAME*}"><img class="inline_image" alt="" title="" src="{$IMG*,menus/menu}" /></a>
{+END}

