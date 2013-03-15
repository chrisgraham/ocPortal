{+START,IF_NON_EMPTY,{CONTENT}}
	<nav class="menu_type__dropdown" role="navigation">
		<ul onmouseout="return deset_active_menu()" class="nl" id="r_{MENU|*}_d">
			{CONTENT}
		</ul>

		{$REQUIRE_JAVASCRIPT,javascript_menu_popup}
	</nav>
{+END}
