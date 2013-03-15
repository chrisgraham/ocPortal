{+START,IF_NON_EMPTY,{CONTENT}}
	<nav class="menu_type__popup" role="navigation">
		<ul onmouseout="return deset_active_menu()" class="nl" id="r_{MENU|*}_p">
			{CONTENT}
		</ul>

		{$REQUIRE_JAVASCRIPT,javascript_menu_popup}
	</nav>
{+END}
