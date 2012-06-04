{+START,IF_NON_EMPTY,{$MESSAGES_TOP}}
	<div class="global_messages">
		{$MESSAGES_TOP}
	</div>
{+END}

<div class="float_surrounder">
	<article id="page_running_{$PAGE*}" class="zone_running_{$ZONE*} global_middle">
		{+START,IF_NON_EMPTY,{$BREADCRUMBS}}{+START,IF,{$NEQ,{$ZONE}:{$PAGE},:start}}{+START,IF,{$SHOW_HEADER}}
			<nav class="global_breadcrumbs breadcrumbs" itemprop="breadcrumb" role="navigation">
				{$BREADCRUMBS}
			</nav>
		{+END}{+END}{+END}

		<a id="maincontent"> </a>

		{MIDDLE}
	</article>

	<div class="float_surrounder">
		{+START,IF_NON_EMPTY,{$TRIM,{$LOAD_PANEL,left}}}
			<div id="panel_left" class="global_side_panel" role="complementary" itemscope="itemscope" itemtype="http://schema.org/WPSideBar">
				{$GET,panel_left}
			</div>
		{+END}

		{+START,IF_NON_EMPTY,{$TRIM,{$LOAD_PANEL,right}}}
			<div id="panel_right" class="global_side_panel" role="complementary" itemscope="itemscope" itemtype="http://schema.org/WPSideBar">
				{$GET,panel_right}
			</div>
		{+END}
	</div>

	{+START,IF_NON_EMPTY,{$GET,panel_bottom}}
		<div id="panel_bottom" role="complementary">
			{$GET,panel_bottom}
		</div>
	{+END}

	{+START,IF_NON_EMPTY,{$MESSAGES_BOTTOM}}
		<div class="global_messages">
			{$MESSAGES_BOTTOM}
		</div>
	{+END}
</div>
