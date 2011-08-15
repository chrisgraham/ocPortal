{+START,IF_NON_EMPTY,{CONTENT}}
	<{$?,{$VALUE_OPTION,html5},nav,div} class="menu_type__dropdown">
		<ul onmouseout="return desetActiveMenu()" class="nl" id="r_{MENU|*}_d">
			{CONTENT}
		</ul>

		{$JAVASCRIPT_INCLUDE,javascript_menu_popup}
	</{$?,{$VALUE_OPTION,html5},nav,div}>
{+END}
